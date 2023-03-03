Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881516A9E0E
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCCRzg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 12:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjCCRz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 12:55:29 -0500
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [IPv6:2001:41d0:1004:224b::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9830D6
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 09:55:28 -0800 (PST)
Message-ID: <51a62deb-93bd-7f84-c9f7-f2ccffb38567@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677866125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82rUjYL/rzs6KAP8DVK0PZj8pV9TP6+2TGIigbProMk=;
        b=AxeUndlIfERquVYmEsXDOv7OTwSQdv4ChEJmiSz0rmuHZ34IYlu4G3lQO7XaQEesaZUhD9
        nMMHzGR7MdGoovmVItKmxMuOK6IBir9BhKUG3/i+VFa2hwrFwRsje3EBpAHfxtIu1QBVbV
        ARaamWmWUqcAIrv2UiGROBVmiewiXZA=
Date:   Fri, 3 Mar 2023 09:55:22 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Use separate RCU callbacks for freeing
 selem
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20230303141542.300068-1-memxor@gmail.com>
 <ea8736cf-6d25-5e56-0359-6a80593dd3ec@linux.dev>
 <CAP01T77XW-XenFnqz4aruFKzLWVHhyL0vE9cJEK_OuyRVW+Bww@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T77XW-XenFnqz4aruFKzLWVHhyL0vE9cJEK_OuyRVW+Bww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/3/23 9:45 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri, 3 Mar 2023 at 16:40, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/3/23 6:15 AM, Kumar Kartikeya Dwivedi wrote:
>>> Martin suggested that instead of using a byte in the hole (which he has
>>> a use for in his future patch) in bpf_local_storage_elem, we can
>>> dispatch a different call_rcu callback based on whether we need to free
>>> special fields in bpf_local_storage_elem data. The free path, described
>>> in commit 9db44fdd8105 ("bpf: Support kptrs in local storage maps"),
>>> only waits for call_rcu callbacks when there are special (kptrs, etc.)
>>> fields in the map value, hence it is necessary that we only access
>>> smap in this case.
>>>
>>> Therefore, dispatch different RCU callbacks based on the BPF map has a
>>> valid btf_record, which dereference and use smap's btf_record only when
>>> it is valid.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>
>> Thanks for your patch. I have already made a similar change in my local branch
>> which has some differences like refactored it a little for my work. The set is
>> almost ready. Do you mind if I include your patch in my set and keep your SOB?
>>
> 
> No problem, please do.

Please ignore my previous message. I will make some adjustments on my set.

Applied with some changes on de-referencing SDATA(selem)->smap to address these 
warnings:

# this is addressed by rcu_dereference_protected(..., true)
../kernel/bpf/bpf_local_storage.c:117:41: warning: dereference of noderef expression

# this is addressed by directly using the earlier dereferenced smap pointer
../kernel/bpf/bpf_local_storage.c:200:27: warning: dereference of noderef expression


