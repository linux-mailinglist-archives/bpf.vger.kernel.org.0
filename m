Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A689F6EF9CE
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDZSHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDZSHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:07:23 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [IPv6:2001:41d0:203:375::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB265BBA
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:07:22 -0700 (PDT)
Message-ID: <9864acbe-7118-d7b5-0287-7737f3135c30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682532440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGNH9441lUhP9/cCCGkPSXJhzwT8yodRCtUyd+kXhGQ=;
        b=mRxRzX5W5YlHFf6QHAHRLtKzaXX/S3j75Kh48KjYfJoz8PjsLi8cBmPHv4tSsSbk94TmKR
        6En1OM+VmG3606qwLZuSaMxxrcB+XZDMLUHD3jGCgKpE+Gfw8Zt1/DsyWS0AMtkDTVxNFw
        ZYiI0ZK64t84ucmZ0iosUC90pAK3huw=
Date:   Wed, 26 Apr 2023 11:07:13 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230418225343.553806-1-sdf@google.com>
 <20230418225343.553806-4-sdf@google.com>
 <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net>
 <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
 <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev>
 <CAKH8qBsVw=my-pB5Mnmyq-Cp0a1by-nS_=Fyu7cZTmiKk8niXw@mail.gmail.com>
 <4d5e33ff-9e0a-aa2b-0482-49bda0d7fade@linux.dev>
 <CAKH8qBtuz0DYrsdgoX2_McOYFSES2_z9+BWcj+XczQZ_Fr6_KQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBtuz0DYrsdgoX2_McOYFSES2_z9+BWcj+XczQZ_Fr6_KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/26/23 10:27 AM, Stanislav Fomichev wrote:
>>> As per above, I'll stick a line to the dmest (similar
>>> bpf_warn_invalid_xdp_action), at least to record that this has
>>> happened once.
>>> LMK if you or Danial still don't see a value in printing this..
>>
>> pr_info_once? hmm... I think it is ok-ish. At least not a warning.
>>
>> I think almost all of the time the bpf prog forgets to set it to 0 for the long
>> optval that it has no interest in. However, to suppress this pr_info_once,
>> setting optlen to 0 will disable the following cgroup-bpf prog from using the
>> optval as read-only. The case that the printk that may flag is that the bpf prog
>> did indeed want to change the long optval?
> 
> The case we want to printk is where the prog changes some byte in the
> first 4k range of the optval and does not touch optlen (or maybe
> adjusts optlen to be >PAGE_SIZE and <original_optlen).
> I agree that it feels super corner-casy; but it feels like without
> some kind of hint, it would be impossible to figure out why it doesn't
> work. Or am I overblowing it?

I don't have a better idea how to flag this 'changing the first few bytes of a 
long optval is not supported' either. I guess pr_info_once is ok-ish for now to 
stop the bleeding in the most common case.

If it can separate the original_optlen > PAGE_SIZE case (ignore and no -EFAULT), 
the message probably needs to be less alarming. "bpf setsockopt returned 
unexpected optlen" may cause confusion when the bpf prog did not touch the 
optval and optlen.

Hopefully this pr_info_once will disappear when the cgroup-bpf prog can directly 
read/write the optval without pre-allocation.

