Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A66C3F23
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 01:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCVAgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 20:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVAgY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 20:36:24 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13D57D0A
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:36:23 -0700 (PDT)
Message-ID: <73eafb52-76e2-81b3-93ad-a80379ba6100@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679445381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhIxpNyiWDog8xM6DOtT92OUwTy3yfz8bCZ1hnWt0y8=;
        b=K9SE9MTWid2tiUElHj02MtYArNqOdDwxOkL5oq8VEWKpXGUUE95nVI7mtDSkMI5H6akp+z
        HneAZSDP34g5zevPrabhTVxf7HSxNs6ieOjUN4GDl+YYvceP0gW7KyWwpXUN+dsdlGAd0n
        mFJvZYUr0qV+uqMed31iy4CRUVdXitQ=
Date:   Tue, 21 Mar 2023 17:36:19 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf@vger.kernel.org
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-3-aditi.ghag@isovalent.com>
 <aa458066-529f-cb84-ce4e-2c780aad17bf@linux.dev>
 <181130C0-6EC6-49EB-BF16-DC23F36AF254@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <181130C0-6EC6-49EB-BF16-DC23F36AF254@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/21/23 5:00 PM, Aditi Ghag wrote:
>> n Mar 21, 2023, at 4:43 PM, Martin KaFai Lau<martin.lau@linux.dev>  wrote:
>>
>> On 3/21/23 11:45 AM, Aditi Ghag wrote:
>>> diff --git a/include/net/udp.h b/include/net/udp.h
>>> index de4b528522bb..d2999447d3f2 100644
>>> --- a/include/net/udp.h
>>> +++ b/include/net/udp.h
>>> @@ -437,6 +437,7 @@ struct udp_seq_afinfo {
>>>   struct udp_iter_state {
>>>   	struct seq_net_private  p;
>>>   	int			bucket;
>>> +	int			offset;
>> All offset change is easier to review with patch 1 together, so please move them to patch 1.
> Thanks for the quick review!
> 
> Oh boy... Absolutely! Looks like I misplaced the changes during interactive rebase. Can I fix this up in this patch itself instead of creating a new patch series? That way, I can batch things up in the next revision.
> 

Instead of re-posting a single patch, it will be easier to batch up all the 
changes in one set in the next revision after the review comments in v3.
