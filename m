Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFC6031FB
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJRSHn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJRSHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:07:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3E5D73B
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:07:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l185-20020a6388c2000000b004610d11faddso8315481pgd.1
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuVjSplyBXIPd7uWO393ugBi/njAUtKrGdSOK72nMMo=;
        b=oCN1jDfBFe0TZVpGUlaA/ZZtrXqmMoDyg2Xic0OjjoRanJrpKg517yTqDVe7dRqy1z
         AECFSeXfdl6b3KJLmBTghr1pR/Nr9a8QYIF5TCOoHrJK6RyQOIJP4v7VtxdfhiMZGiMe
         azHmeZmV5QC73wA/YZ5PxwDh1ZrG07R8yXJ5aBcHUDYiFEFs8G0EEhOn4mHrf9S2Qa8D
         D9CjqmSfzRR87v/AwVqgXtnheJOW8h3zbqyn6O05QmNYCFyuwkJFD0kdqFt6UzlcZhV8
         kGT1vGW4q+ZuieONJelSFhWDo9sjwExgKB0x75CtI6xQsti11GJN+yl9VLGsueaCA/zM
         IsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuVjSplyBXIPd7uWO393ugBi/njAUtKrGdSOK72nMMo=;
        b=axw2lB69nfmDaA20Y/FMAbsP1LlyzpOcVpNKOPpe2GjAfHv0ZoD1FZiIAs+c8lPmq4
         RUFkrIDkkL35WaU7wW+ol4qZPSJeaOWSJVe2T0SjaDjVE59O4OFjNR4PYVi/9R76EXUa
         n+WvPY5uNhkyik+xna4+GWQBFjahdoeQb1TfW+buAMA8JlUtfhDigCRz+I36Sx5v8E9Z
         B6Tbbi7iY7DDgLOuJIA9VwohalK0aTs/oh/YSn6kNEiqTl1kknZDJnJIcNoX6/glTOfQ
         pDdfYTGDc07oQ/7B4jjBp5UvRXXlr7RW/kiiSxsykL6Mz42lkMBrULUZVAdo4auCK9Yf
         zrQg==
X-Gm-Message-State: ACrzQf0wChoEnvmFOk1jLBOHD8hngE9eS/DuRmCzDEBLAtfnDEsAK+mr
        54uNhcFJgFgzf5xOVTbZH5noyaY=
X-Google-Smtp-Source: AMsMyM4kTW3fLnTML3Zt8GdvqSub4ZsxSFSiIsHj8w9JHnGzIiT4SuAdzosdCmimydC5OKOcFwwsCZs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1707:b0:562:e790:dfc3 with SMTP id
 h7-20020a056a00170700b00562e790dfc3mr4484929pfc.59.1666116460090; Tue, 18 Oct
 2022 11:07:40 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:07:38 -0700
In-Reply-To: <20221018090550.never.834-kees@kernel.org>
Mime-Version: 1.0
References: <20221018090550.never.834-kees@kernel.org>
Message-ID: <Y07raim32wOBRGPi@google.com>
Subject: Re: [PATCH] bpf: Use kmalloc_size_roundup() to match ksize() usage
From:   sdf@google.com
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18, Kees Cook wrote:
> Round up allocations with kmalloc_size_roundup() so that the verifier's
> use of ksize() is always accurate and no special handling of the memory
> is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> information back up to callers so they can use the space immediately,
> so array resizing to happen less frequently as well. Explicitly zero
> any trailing bytes in new allocations.

> Additionally fix a memory allocation leak: if krealloc() fails, "arr"
> wasn't freed, but NULL was return to the caller of realloc_array() would
> be writing NULL to the lvalue, losing the reference to the original
> memory.

> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
>   1 file changed, 31 insertions(+), 18 deletions(-)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 014ee0953dbd..8a0b60207d0e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1000,42 +1000,53 @@ static void print_insn_state(struct  
> bpf_verifier_env *env,
>    */
>   static void *copy_array(void *dst, const void *src, size_t n, size_t  
> size, gfp_t flags)
>   {
> -	size_t bytes;
> +	size_t src_bytes, dst_bytes;

>   	if (ZERO_OR_NULL_PTR(src))
>   		goto out;

> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &src_bytes)))
>   		return NULL;

> -	if (ksize(dst) < bytes) {
> +	dst_bytes = kmalloc_size_roundup(src_bytes);
> +	if (ksize(dst) < dst_bytes) {

Why not simply do the following here?

	if (ksize(dst) < ksize(src)) {

?

It seems like we care about src_bytes/bytes only in this case, so maybe
move that check_mul_overflow under this branch as well?


>   		kfree(dst);
> -		dst = kmalloc_track_caller(bytes, flags);
> +		dst = kmalloc_track_caller(dst_bytes, flags);
>   		if (!dst)
>   			return NULL;
>   	}

> -	memcpy(dst, src, bytes);
> +	memcpy(dst, src, src_bytes);
> +	memset(dst + src_bytes, 0, dst_bytes - src_bytes);
>   out:
>   	return dst ? dst : ZERO_SIZE_PTR;
>   }

> -/* resize an array from old_n items to new_n items. the array is  
> reallocated if it's too
> - * small to hold new_n items. new items are zeroed out if the array  
> grows.
> +/* Resize an array from old_n items to *new_n items. The array is  
> reallocated if it's too
> + * small to hold *new_n items. New items are zeroed out if the array  
> grows. Allocation
> + * is rounded up to next kmalloc bucket size to reduce frequency of  
> resizing. *new_n
> + * contains the new total number of items that will fit.
>    *
> - * Contrary to krealloc_array, does not free arr if new_n is zero.
> + * Contrary to krealloc, does not free arr if new_n is zero.
>    */
> -static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t  
> size)
> +static void *realloc_array(void *arr, size_t old_n, size_t *new_n,  
> size_t size)
>   {
> -	if (!new_n || old_n == new_n)
> +	void *old_arr = arr;
> +	size_t alloc_size;
> +
> +	if (!new_n || !*new_n || old_n == *new_n)
>   		goto out;


[..]

> -	arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> -	if (!arr)
> +	alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
> +	arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
> +	if (!arr) {
> +		kfree(old_arr);
>   		return NULL;
> +	}

Any reason not do hide this complexity behind krealloc_array? Why can't
it take care of those roundup details?


> -	if (new_n > old_n)
> -		memset(arr + old_n * size, 0, (new_n - old_n) * size);
> +	*new_n = alloc_size / size;
> +	if (*new_n > old_n)
> +		memset(arr + old_n * size, 0, (*new_n - old_n) * size);

>   out:
>   	return arr ? arr : ZERO_SIZE_PTR;
> @@ -1067,7 +1078,7 @@ static int copy_stack_state(struct bpf_func_state  
> *dst, const struct bpf_func_st

>   static int resize_reference_state(struct bpf_func_state *state, size_t n)
>   {
> -	state->refs = realloc_array(state->refs, state->acquired_refs, n,
> +	state->refs = realloc_array(state->refs, state->acquired_refs, &n,
>   				    sizeof(struct bpf_reference_state));
>   	if (!state->refs)
>   		return -ENOMEM;
> @@ -1083,11 +1094,11 @@ static int grow_stack_state(struct bpf_func_state  
> *state, int size)
>   	if (old_n >= n)
>   		return 0;

> -	state->stack = realloc_array(state->stack, old_n, n, sizeof(struct  
> bpf_stack_state));
> +	state->stack = realloc_array(state->stack, old_n, &n, sizeof(struct  
> bpf_stack_state));
>   	if (!state->stack)
>   		return -ENOMEM;

> -	state->allocated_stack = size;
> +	state->allocated_stack = n * BPF_REG_SIZE;
>   	return 0;
>   }

> @@ -2499,9 +2510,11 @@ static int push_jmp_history(struct  
> bpf_verifier_env *env,
>   {
>   	u32 cnt = cur->jmp_history_cnt;
>   	struct bpf_idx_pair *p;
> +	size_t size;

>   	cnt++;
> -	p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
> +	size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
> +	p = krealloc(cur->jmp_history, size, GFP_USER);
>   	if (!p)
>   		return -ENOMEM;
>   	p[cnt - 1].idx = env->insn_idx;
> --
> 2.34.1

