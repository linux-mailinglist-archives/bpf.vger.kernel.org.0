Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419D6D0CCF
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjC3Rax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjC3Rax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:30:53 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60971DBF5
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:30:50 -0700 (PDT)
Message-ID: <9cfdf301-fc82-d734-bec9-081daef4c896@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680197448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAfSawKCmapOF4dTXnHPh/4QfRqPZ0MzntYSo5KJ5Vc=;
        b=dOAVIzkLZYLMuktTejnnAAiyZ8H+e7pGG2HvCZHc6hWVtkVCyxtreTV2fGucSvX9BjZcH1
        kZ1sxf2PI05OxNw3S+dQWPmOXxHUd3OADyFBfQGDQJDxUzbhsqA2LnNLtHxm9FjFutzg9c
        Lzwgwxzm2R09mThGhT2dBMhDQQzIWso=
Date:   Thu, 30 Mar 2023 10:30:43 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-3-aditi.ghag@isovalent.com>
 <ZB4X/uOEdq79Lbof@google.com>
 <ED9BFD83-8CCE-4783-B28F-0742F70AAB8F@isovalent.com>
 <CAKH8qBvibAPqkJ_73-e_CpPRDMMhP9v4nP7vAqw=q9et8DPCig@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBvibAPqkJ_73-e_CpPRDMMhP9v4nP7vAqw=q9et8DPCig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 9:32 AM, Stanislav Fomichev wrote:
>>> Maybe make it more opt-in? (vs current "opt ipproto_raw out")
>>>
>>> if (sk->sk_prot->diag_destroy != udp_abort &&
>>>     sk->sk_prot->diag_destroy != tcp_abort)
>>>             return -EOPNOTSUPP;
>>>
>>> Is it more robust? Or does it look uglier? )
>>> But maybe fine as is, I'm just thinking out loud..
>>
>> Do we expect the handler to be extended for more types? Probably not... So I'll leave it as is.
> 
> My worry is about somebody adding .diag_destroy to some new/old
> protocol in the future, say sctp_prot, without being aware
> of this bpf_sock_destroy helper and its locking requirements.

Other helpers in filter.c is also opt-in. I think it is better to do the same 
here. IPPROTO_TCP and IPPROTO_UDP should have very good use case coverage to 
begin with. It can also help to ensure new selftests are written to cover the 
protocol supporting bpf_sock_destroy in the future.

I like the comment in bpf_sock_destroy() in this patch. It will be even better 
if it can spell out more clearly that future supporting protocol needs to assume 
the lock_sock has already been done on the bpf side.

> 
> So having an opt-in here (as in sk_protocol == IPPROTO_TCP ||
> sk_protocol == IPPROTO_UDP) feels more future-proof than your current
> opt-out (sk_proto != IPPROTO_RAW).
> WDYT?
>>>> +            release_sock(sk);
>>>
>>>>       return 0;
>>>>   }
>>>> --
>>>> 2.34.1
>>

