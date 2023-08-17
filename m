Return-Path: <bpf+bounces-8013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6762677FDF0
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C38F282196
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1C168D6;
	Thu, 17 Aug 2023 18:36:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A414AA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 18:36:35 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD6E1BE7
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:36:33 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c711a88e8so105252eaf.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692297392; x=1692902192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r2DyZivkES+b6AFQjtdqh4JUP9fo669zk8SeMBNNHI=;
        b=fz80VzRnb1wZiK8B9O+hIOFl766du9kc+ksLsCE+moiHYRK2+IKa4rfOHvBjd/yCQ7
         tOuzetGvPtcaHEvKOKC97K/iOIqaJ5gcwcDeYlk4E4zlsK2oDivyvm60vskhMv6VP2xi
         yuSOx0koE09Y11XQcOgc9DkKA9WE5MvkHEE2VS0PzqO6M9N/qwDgfIHOa+sFHuTKlf4i
         cpNiOMvPm8MamZ6BT0k6ETesBuWEbdNyd+LiAVWGRFPOzD51gJ8QiDoCJJFi9kNrYtSW
         YhAuqWg8KfUfGCQ/CC5I9qKXwU5ArQ3TKT5KVJjAXI8icKyp4d/oM+/KoZEA8S2wyX6f
         nFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297392; x=1692902192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r2DyZivkES+b6AFQjtdqh4JUP9fo669zk8SeMBNNHI=;
        b=DTUAki7s0guZRXCni0rRt3nmvegZQc8CeUM+4R8ptM+D+xPEQ5X3qpKnpDt+1anWc2
         Dn2//bSpP0x2C6w/Fc6hdDR+DjkYDJfeiuAmbK4iiuJMTny+nCtlQmEiLQTRkViKvNlL
         JYGaCjm7HsxTzqBIbG6XZR7GFiVQF7vs+sWWrR61UxmRqiE8dNCtIzmqGBI2LAsf3zt0
         sqOfZ9XcGc5cN2l3WOV5cAkzfnaqgX6G7L9I6tuojzP5pmWChI+lx9UcdrTM1LaViTTq
         Nk1XgQAaoUIz/SwSDwJcw/yVtVMiMVFDIAimrbs5BmuJsysWdDXxT93SMcY/NBJGpPWo
         Ob7w==
X-Gm-Message-State: AOJu0YzcuvxG4SmmdgTEfXz/h2pqP+MRneT3EBxd1Y6xXxrSxhwqG/e4
	y8QZdJ1i73O3EX4sYITg7L4=
X-Google-Smtp-Source: AGHT+IHO6Mg/JPZtz3FctYcndtkfTlKZAj/sgCIu9hFJdbV2GBEVTk+MdnS0/K6V6qXtt0AuXzsTIA==
X-Received: by 2002:a05:6358:9318:b0:13a:a85b:cdc2 with SMTP id x24-20020a056358931800b0013aa85bcdc2mr326395rwa.15.1692297392438;
        Thu, 17 Aug 2023 11:36:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b6d:34bc:f82a:990? ([2600:1700:6cf8:1240:b6d:34bc:f82a:990])
        by smtp.gmail.com with ESMTPSA id v98-20020a25abeb000000b00bcd91bb300esm9443ybi.54.2023.08.17.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 11:36:32 -0700 (PDT)
Message-ID: <a097194e-41b2-2fc2-b6d3-9029a2576608@gmail.com>
Date: Thu, 17 Aug 2023 11:36:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 5/5] selftests/bpf: Add test cases for sleepable
 BPF programs of the CGROUP_SOCKOPT type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev,
 kuifeng@meta.com, thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-6-thinker.li@gmail.com> <ZNvm1INWVulkWM8d@google.com>
 <93e2d6f7-e661-5c83-6a86-246e231da52d@gmail.com>
 <c7833c94-59fe-23da-7ac8-a2dd81124d4c@gmail.com>
 <d7bf3641-8c25-b335-db8a-e73557601509@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d7bf3641-8c25-b335-db8a-e73557601509@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 18:13, Martin KaFai Lau wrote:
> On 8/15/23 5:03 PM, Kui-Feng Lee wrote:
>>>>> +SEC("cgroup/getsockopt.s")
>>>>> +int _getsockopt_s(struct bpf_sockopt *ctx)
>>>>> +{
>>>>> +    struct tcp_zerocopy_receive *zcvr;
>>>>> +    struct bpf_dynptr optval_dynptr;
>>>>> +    struct sockopt_sk *storage;
>>>>> +    __u8 *optval, *optval_end;
>>>>> +    struct bpf_sock *sk;
>>>>> +    char buf[1];
>>>>> +    __u64 addr;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (skip_sleepable)
>>>>> +        return 1;
>>>>> +
>>>>> +    /* Bypass AF_NETLINK. */
>>>>> +    sk = ctx->sk;
>>>>> +    if (sk && sk->family == AF_NETLINK)
>>>>> +        return 1;
>>>>> +
>>>>> +    optval = ctx->optval;
>>>>> +    optval_end = ctx->optval_end;
>>>>> +
>>>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>>>> +     */
>>>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>>>> +        /* Not interested in SOL_IP:IP_TOS;
>>>>> +         * let next BPF program in the cgroup chain or kernel
>>>>> +         * handle it.
>>>>> +         */
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>>>> +        /* Not interested in SOL_SOCKET:SO_SNDBUF;
>>>>> +         * let next BPF program in the cgroup chain or kernel
>>>>> +         * handle it.
>>>>> +         */
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
>>>>> +        /* Not interested in SOL_TCP:TCP_CONGESTION;
>>>>> +         * let next BPF program in the cgroup chain or kernel
>>>>> +         * handle it.
>>>>> +         */
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level == SOL_TCP && ctx->optname == 
>>>>> TCP_ZEROCOPY_RECEIVE) {
>>>>> +        /* Verify that TCP_ZEROCOPY_RECEIVE triggers.
>>>>> +         * It has a custom implementation for performance
>>>>> +         * reasons.
>>>>> +         */
>>>>> +
>>>>> +        bpf_sockopt_dynptr_from(ctx, &optval_dynptr, sizeof(*zcvr));
>>>>> +        zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
>>>>> +        addr = zcvr ? zcvr->address : 0;
>>>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>>
>>>> This starts to look more usable, thank you for the changes!
>>>> Let me poke the api a bit more, I'm not super familiar with the 
>>>> dynptrs.
>>>>
>>>> here: bpf_sockopt_dynptr_from should probably be called
>>>> bpf_dynptr_from_sockopt to match bpf_dynptr_from_mem?
>>>
>>> agree!
>>>
>>>>
>>>>> +
>>>>> +        return addr != 0 ? 0 : 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>>>>> +        if (optval + 1 > optval_end)
>>>>> +            return 0; /* bounds check */
>>>>> +
>>>>> +        ctx->retval = 0; /* Reset system call return value to zero */
>>>>> +
>>>>> +        /* Always export 0x55 */
>>>>> +        buf[0] = 0x55;
>>>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>>>> +        if (ret >= 0) {
>>>>> +            bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>>>> +            ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>>>> +        }
>>>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>>
>>>> Does bpf_sockopt_dynptr_alloc and bpf_sockopt_dynptr_release need to be
>>>> sockopt specific? Seems like we should provide, instead, some generic
>>>> bpf_dynptr_alloc/bpf_dynptr_release and make
>>>> bpf_sockopt_dynptr_copy_to/install work with them? WDYT?
>>>
>>> I found that kmalloc can not be called in the context of nmi, slab or
>>> page alloc path. It is why we don't have functions like
>>> bpf_dynptr_alloc/bpf_dynptr_release yet. That means we need someone
>>> to implement an allocator for BPF programs. And, then, we can have
>>> bpf_dynptr_alloc unpon it. (There is an implementation of
>>> bpf_dynptr_alloc() in the early versions of the patchset of dynptr.
>>> But, be removed before landing.)
>>>
>>>
>>>>
>>>>> +        if (ret < 0)
>>>>> +            return 0;
>>>>> +        ctx->optlen = 1;
>>>>> +
>>>>> +        /* Userspace buffer is PAGE_SIZE * 2, but BPF
>>>>> +         * program can only see the first PAGE_SIZE
>>>>> +         * bytes of data.
>>>>> +         */
>>>>> +        if (optval_end - optval != page_size && 0)
>>>>> +            return 0; /* unexpected data size */
>>>>> +
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level != SOL_CUSTOM)
>>>>> +        return 0; /* deny everything except custom level */
>>>>> +
>>>>> +    if (optval + 1 > optval_end)
>>>>> +        return 0; /* bounds check */
>>>>> +
>>>>> +    storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
>>>>> +                     BPF_SK_STORAGE_GET_F_CREATE);
>>>>> +    if (!storage)
>>>>> +        return 0; /* couldn't get sk storage */
>>>>> +
>>>>> +    if (!ctx->retval)
>>>>> +        return 0; /* kernel should not have handled
>>>>> +               * SOL_CUSTOM, something is wrong!
>>>>> +               */
>>>>> +    ctx->retval = 0; /* Reset system call return value to zero */
>>>>> +
>>>>> +    buf[0] = storage->val;
>>>>> +    ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>>>> +    if (ret >= 0) {
>>>>> +        bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>>>> +        ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>>>> +    }
>>>>> +    bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>>> +    if (ret < 0)
>>>>> +        return 0;
>>>>> +    ctx->optlen = 1;
>>>>> +
>>>>> +    return 1;
>>>>> +}
>>>>> +
>>>>>   SEC("cgroup/setsockopt")
>>>>>   int _setsockopt(struct bpf_sockopt *ctx)
>>>>>   {
>>>>> @@ -144,6 +281,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>>>       struct sockopt_sk *storage;
>>>>>       struct bpf_sock *sk;
>>>>> +    if (skip_nonsleepable)
>>>>> +        return 1;
>>>>> +
>>>>>       /* Bypass AF_NETLINK. */
>>>>>       sk = ctx->sk;
>>>>>       if (sk && sk->family == AF_NETLINK)
>>>>> @@ -236,3 +376,120 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>>>           ctx->optlen = 0;
>>>>>       return 1;
>>>>>   }
>>>>> +
>>>>> +SEC("cgroup/setsockopt.s")
>>>>> +int _setsockopt_s(struct bpf_sockopt *ctx)
>>>>> +{
>>>>> +    struct bpf_dynptr optval_buf;
>>>>> +    struct sockopt_sk *storage;
>>>>> +    __u8 *optval, *optval_end;
>>>>> +    struct bpf_sock *sk;
>>>>> +    __u8 tmp_u8;
>>>>> +    __u32 tmp;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (skip_sleepable)
>>>>> +        return 1;
>>>>> +
>>>>> +    optval = ctx->optval;
>>>>> +    optval_end = ctx->optval_end;
>>>>> +
>>>>> +    /* Bypass AF_NETLINK. */
>>>>> +    sk = ctx->sk;
>>>>> +    if (sk && sk->family == AF_NETLINK)
>>>>> +        return -1;
>>>>> +
>>>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>>>> +     */
>>>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>>>> +        /* Not interested in SOL_IP:IP_TOS;
>>>>> +         * let next BPF program in the cgroup chain or kernel
>>>>> +         * handle it.
>>>>> +         */
>>>>> +        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
>>>>> +        return 1;
>>>>> +    }
>>>>> +
>>>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>>>> +        /* Overwrite SO_SNDBUF value */
>>>>> +
>>>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, sizeof(__u32),
>>>>> +                           &optval_buf);
>>>>> +        if (ret < 0)
>>>>> +            bpf_sockopt_dynptr_release(ctx, &optval_buf);
>>>>> +        else {
>>>>> +            tmp = 0x55AA;
>>>>> +            bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
>>>>> +            ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
>>>>
>>>> One thing I'm still slightly confused about is
>>>> bpf_sockopt_dynptr_install vs bpf_sockopt_dynptr_copy_to. I do
>>>> understand that it comes from getsockopt vs setsockopt (and the 
>>>> ability,
>>>> in setsockopt, to allocate larger buffers), but I wonder whether
>>>> we can hide everything under single bpf_sockopt_dynptr_copy_to call?
>>>>
>>>> For getsockopt, it stays as is. For setsockopt, it would work like
>>>> _install currently does. Would that work? From user perspective,
>>>> if we provide a simple call that does the right thing, seems a bit
>>>> more usable? The only problem is probably the fact that _install
>>>> explicitly moves the ownership, but I don't see why copy_to can't
>>>> have the same "consume" semantics?
>>
>> Sorry for missing this part!
>> This overloading is counterintuitive for me.
>> *_copy_to() will not copy/overwrite the buffer, but replace the buffer
>> instead. And, it will change its side-effects according to its context.
>> I would prefer a different name instead of reusing *_copy_to().
>>
>> We probably need a better name, instead of copy_to, in order to merge
>> these two functions if we want to.
> 
> It also took me some time to realize the alloc/install/copy_to/release 
> usages. iiuc, to change optval in getsockopt, it is 
> alloc=>write=>copy_to=>release.
>        to change optval in setsockopt, it is alloc=>write=>install.
> 
> Can this alloc and user-or-kernel memory details be done in the 
> bpf_dynptr_write() instead such that both BPF_CGROUP_GETSOCKOPT and 
> BPF_CGROUP_SETSOCKOPT program can just call one bpf_dynptr_write() to 
> update the optval? I meant bpf_dynptr_write() should have the needed 
> context to decide if it can directly write to the __user ptr or it needs 
> to write to a kernel memory and if kmalloc is needed/allowed.

For v3, you can just call  bpf_dynptr_write() to update the buffer
without installing it if optval is already a in kernel buffer.
But, you can still call *_install() even if it is unnecessary.
The code in the test case try to make it less complicated. So,
it always call *_install() without any check.
> 
> Same for reading. bpf_dynptr_read() should know it should read from user 
> or kernel memory. bpf_dynptr_data() may not work well if the underlying 
> sockopt memory is still backed by user memory, so probably don't support 
> bpf_dynptr_data() for sockopt. Support the bpf_dynptr_slice() and 
> bpf_dynptr_slice_rdwr() instead. Take a look at how the "buffer__opt" 
> arg is used by the xdp dynptr. If the underlying sockopt is still backed 
> by user memory, the bpf_dynptr_slice() can do a copy_from_user to the 
> "buffer__opt".

> 
> bpf_dynptr_from_cgrp_sockopt() should be the only function to initalize 
> a dynptr from the 'struct bpf_sockopt *ctx'. Probably don't need to 
> allocate any memory at the init time.
> 
> Is there something specific to cgrp sockopt that is difficult and any 
> downside of the above?
> 
> WDYT?
> 

This is doable.


