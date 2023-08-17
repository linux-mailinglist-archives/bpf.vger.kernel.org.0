Return-Path: <bpf+bounces-7943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D377EE95
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C21C2111E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2D390;
	Thu, 17 Aug 2023 01:13:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0F379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:13:52 +0000 (UTC)
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC11987
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:13:50 -0700 (PDT)
Message-ID: <d7bf3641-8c25-b335-db8a-e73557601509@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692234828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClrE/Ty6H0sqZg1VFeDL0yX2u0beF3Sa8n9VaYyGUHs=;
	b=O0Drirdu2ZSJbyiD5RQGvWb9ig79WOYen2j7JnjDxFPxQg7xTWYJ5IIyzhgxbfBuKRbfy6
	FslhauAWjdUwhegqaxRHRpw8eOAv6hB9ZB5Vt+osPCW++tMpCZf1+ZejVWSn9Btng4Vqf7
	EbeWo6veq4xJtnB7n+EaZT5VyP9ujFk=
Date: Wed, 16 Aug 2023 18:13:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 5/5] selftests/bpf: Add test cases for sleepable
 BPF programs of the CGROUP_SOCKOPT type
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev,
 kuifeng@meta.com, thinker.li@gmail.com, Stanislav Fomichev <sdf@google.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-6-thinker.li@gmail.com> <ZNvm1INWVulkWM8d@google.com>
 <93e2d6f7-e661-5c83-6a86-246e231da52d@gmail.com>
 <c7833c94-59fe-23da-7ac8-a2dd81124d4c@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c7833c94-59fe-23da-7ac8-a2dd81124d4c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/23 5:03 PM, Kui-Feng Lee wrote:
>>>> +SEC("cgroup/getsockopt.s")
>>>> +int _getsockopt_s(struct bpf_sockopt *ctx)
>>>> +{
>>>> +    struct tcp_zerocopy_receive *zcvr;
>>>> +    struct bpf_dynptr optval_dynptr;
>>>> +    struct sockopt_sk *storage;
>>>> +    __u8 *optval, *optval_end;
>>>> +    struct bpf_sock *sk;
>>>> +    char buf[1];
>>>> +    __u64 addr;
>>>> +    int ret;
>>>> +
>>>> +    if (skip_sleepable)
>>>> +        return 1;
>>>> +
>>>> +    /* Bypass AF_NETLINK. */
>>>> +    sk = ctx->sk;
>>>> +    if (sk && sk->family == AF_NETLINK)
>>>> +        return 1;
>>>> +
>>>> +    optval = ctx->optval;
>>>> +    optval_end = ctx->optval_end;
>>>> +
>>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>>> +     */
>>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>>> +        return 0;
>>>> +
>>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>>> +        return 0;
>>>> +
>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>>> +        /* Not interested in SOL_IP:IP_TOS;
>>>> +         * let next BPF program in the cgroup chain or kernel
>>>> +         * handle it.
>>>> +         */
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>>> +        /* Not interested in SOL_SOCKET:SO_SNDBUF;
>>>> +         * let next BPF program in the cgroup chain or kernel
>>>> +         * handle it.
>>>> +         */
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
>>>> +        /* Not interested in SOL_TCP:TCP_CONGESTION;
>>>> +         * let next BPF program in the cgroup chain or kernel
>>>> +         * handle it.
>>>> +         */
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
>>>> +        /* Verify that TCP_ZEROCOPY_RECEIVE triggers.
>>>> +         * It has a custom implementation for performance
>>>> +         * reasons.
>>>> +         */
>>>> +
>>>> +        bpf_sockopt_dynptr_from(ctx, &optval_dynptr, sizeof(*zcvr));
>>>> +        zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
>>>> +        addr = zcvr ? zcvr->address : 0;
>>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>
>>> This starts to look more usable, thank you for the changes!
>>> Let me poke the api a bit more, I'm not super familiar with the dynptrs.
>>>
>>> here: bpf_sockopt_dynptr_from should probably be called
>>> bpf_dynptr_from_sockopt to match bpf_dynptr_from_mem?
>>
>> agree!
>>
>>>
>>>> +
>>>> +        return addr != 0 ? 0 : 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>>>> +        if (optval + 1 > optval_end)
>>>> +            return 0; /* bounds check */
>>>> +
>>>> +        ctx->retval = 0; /* Reset system call return value to zero */
>>>> +
>>>> +        /* Always export 0x55 */
>>>> +        buf[0] = 0x55;
>>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>>> +        if (ret >= 0) {
>>>> +            bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>>> +            ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>>> +        }
>>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>
>>> Does bpf_sockopt_dynptr_alloc and bpf_sockopt_dynptr_release need to be
>>> sockopt specific? Seems like we should provide, instead, some generic
>>> bpf_dynptr_alloc/bpf_dynptr_release and make
>>> bpf_sockopt_dynptr_copy_to/install work with them? WDYT?
>>
>> I found that kmalloc can not be called in the context of nmi, slab or
>> page alloc path. It is why we don't have functions like
>> bpf_dynptr_alloc/bpf_dynptr_release yet. That means we need someone
>> to implement an allocator for BPF programs. And, then, we can have
>> bpf_dynptr_alloc unpon it. (There is an implementation of
>> bpf_dynptr_alloc() in the early versions of the patchset of dynptr.
>> But, be removed before landing.)
>>
>>
>>>
>>>> +        if (ret < 0)
>>>> +            return 0;
>>>> +        ctx->optlen = 1;
>>>> +
>>>> +        /* Userspace buffer is PAGE_SIZE * 2, but BPF
>>>> +         * program can only see the first PAGE_SIZE
>>>> +         * bytes of data.
>>>> +         */
>>>> +        if (optval_end - optval != page_size && 0)
>>>> +            return 0; /* unexpected data size */
>>>> +
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level != SOL_CUSTOM)
>>>> +        return 0; /* deny everything except custom level */
>>>> +
>>>> +    if (optval + 1 > optval_end)
>>>> +        return 0; /* bounds check */
>>>> +
>>>> +    storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
>>>> +                     BPF_SK_STORAGE_GET_F_CREATE);
>>>> +    if (!storage)
>>>> +        return 0; /* couldn't get sk storage */
>>>> +
>>>> +    if (!ctx->retval)
>>>> +        return 0; /* kernel should not have handled
>>>> +               * SOL_CUSTOM, something is wrong!
>>>> +               */
>>>> +    ctx->retval = 0; /* Reset system call return value to zero */
>>>> +
>>>> +    buf[0] = storage->val;
>>>> +    ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>>> +    if (ret >= 0) {
>>>> +        bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>>> +        ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>>> +    }
>>>> +    bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>>> +    if (ret < 0)
>>>> +        return 0;
>>>> +    ctx->optlen = 1;
>>>> +
>>>> +    return 1;
>>>> +}
>>>> +
>>>>   SEC("cgroup/setsockopt")
>>>>   int _setsockopt(struct bpf_sockopt *ctx)
>>>>   {
>>>> @@ -144,6 +281,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>>       struct sockopt_sk *storage;
>>>>       struct bpf_sock *sk;
>>>> +    if (skip_nonsleepable)
>>>> +        return 1;
>>>> +
>>>>       /* Bypass AF_NETLINK. */
>>>>       sk = ctx->sk;
>>>>       if (sk && sk->family == AF_NETLINK)
>>>> @@ -236,3 +376,120 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>>           ctx->optlen = 0;
>>>>       return 1;
>>>>   }
>>>> +
>>>> +SEC("cgroup/setsockopt.s")
>>>> +int _setsockopt_s(struct bpf_sockopt *ctx)
>>>> +{
>>>> +    struct bpf_dynptr optval_buf;
>>>> +    struct sockopt_sk *storage;
>>>> +    __u8 *optval, *optval_end;
>>>> +    struct bpf_sock *sk;
>>>> +    __u8 tmp_u8;
>>>> +    __u32 tmp;
>>>> +    int ret;
>>>> +
>>>> +    if (skip_sleepable)
>>>> +        return 1;
>>>> +
>>>> +    optval = ctx->optval;
>>>> +    optval_end = ctx->optval_end;
>>>> +
>>>> +    /* Bypass AF_NETLINK. */
>>>> +    sk = ctx->sk;
>>>> +    if (sk && sk->family == AF_NETLINK)
>>>> +        return -1;
>>>> +
>>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>>> +     */
>>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>>> +        return 0;
>>>> +
>>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>>> +        return 0;
>>>> +
>>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>>> +        /* Not interested in SOL_IP:IP_TOS;
>>>> +         * let next BPF program in the cgroup chain or kernel
>>>> +         * handle it.
>>>> +         */
>>>> +        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>>> +        /* Overwrite SO_SNDBUF value */
>>>> +
>>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, sizeof(__u32),
>>>> +                           &optval_buf);
>>>> +        if (ret < 0)
>>>> +            bpf_sockopt_dynptr_release(ctx, &optval_buf);
>>>> +        else {
>>>> +            tmp = 0x55AA;
>>>> +            bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
>>>> +            ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
>>>
>>> One thing I'm still slightly confused about is
>>> bpf_sockopt_dynptr_install vs bpf_sockopt_dynptr_copy_to. I do
>>> understand that it comes from getsockopt vs setsockopt (and the ability,
>>> in setsockopt, to allocate larger buffers), but I wonder whether
>>> we can hide everything under single bpf_sockopt_dynptr_copy_to call?
>>>
>>> For getsockopt, it stays as is. For setsockopt, it would work like
>>> _install currently does. Would that work? From user perspective,
>>> if we provide a simple call that does the right thing, seems a bit
>>> more usable? The only problem is probably the fact that _install
>>> explicitly moves the ownership, but I don't see why copy_to can't
>>> have the same "consume" semantics?
> 
> Sorry for missing this part!
> This overloading is counterintuitive for me.
> *_copy_to() will not copy/overwrite the buffer, but replace the buffer
> instead. And, it will change its side-effects according to its context.
> I would prefer a different name instead of reusing *_copy_to().
> 
> We probably need a better name, instead of copy_to, in order to merge
> these two functions if we want to.

It also took me some time to realize the alloc/install/copy_to/release usages. 
iiuc, to change optval in getsockopt, it is alloc=>write=>copy_to=>release.
       to change optval in setsockopt, it is alloc=>write=>install.

Can this alloc and user-or-kernel memory details be done in the 
bpf_dynptr_write() instead such that both BPF_CGROUP_GETSOCKOPT and 
BPF_CGROUP_SETSOCKOPT program can just call one bpf_dynptr_write() to update the 
optval? I meant bpf_dynptr_write() should have the needed context to decide if 
it can directly write to the __user ptr or it needs to write to a kernel memory 
and if kmalloc is needed/allowed.

Same for reading. bpf_dynptr_read() should know it should read from user or 
kernel memory. bpf_dynptr_data() may not work well if the underlying sockopt 
memory is still backed by user memory, so probably don't support 
bpf_dynptr_data() for sockopt. Support the bpf_dynptr_slice() and 
bpf_dynptr_slice_rdwr() instead. Take a look at how the "buffer__opt" arg is 
used by the xdp dynptr. If the underlying sockopt is still backed by user 
memory, the bpf_dynptr_slice() can do a copy_from_user to the "buffer__opt".

bpf_dynptr_from_cgrp_sockopt() should be the only function to initalize a dynptr 
from the 'struct bpf_sockopt *ctx'. Probably don't need to allocate any memory 
at the init time.

Is there something specific to cgrp sockopt that is difficult and any downside 
of the above?

WDYT?


