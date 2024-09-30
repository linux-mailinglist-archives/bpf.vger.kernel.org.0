Return-Path: <bpf+bounces-40587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084A98A9B7
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0056028641E
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D12192B8C;
	Mon, 30 Sep 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QWFB8+3k"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235318EFFA
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713580; cv=none; b=mCh5jTanvL3o3+y6CnRzlwCLdHEtKV3Ec3xUj56GLSYux2Oyie72Pfdmxnu9rVXOXXNnxIO3WH1qYFJu+wruKzaA3coaOUHrKJYYtbF69kxoP4E06xOwfgWzqs2/y3AzW+znEFKemXkLjXW4E6FX5e5xLGeJ3byR2Smn4tfJ3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713580; c=relaxed/simple;
	bh=1Qv9irsyKxhiB+12GA8l7bysfrbanbF4ZZMeobTIim4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixYcv9lps6B3w79A0lOWd5JmfA5pXia76i80LSWpDtTbNo5MVenJq0Zv2JABjDjgnq0WDSQs1ZpN1SWdSnDD9XGfCrqvZJuyPEymwhMkYd5MnxhDEtDm7DyeaHPBUvsRc7Xae6mMVT/FhkZ4/+Ao2rQiYGcEgfrH3smJu2u3KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QWFB8+3k; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75341619-0f3d-4d36-bbbd-a3128bca34c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727713572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xy0FagBogitXzhPBsHmjTnRkMXV0Aql9DaTu8Vlqvvs=;
	b=QWFB8+3koy+ocqUVd7mVDQJ5eeKXC/f+ooM7C0aLjivFUeeXx5hDfEThqQPfwzSUrgnDBp
	Df7+pX2Yf9EeGMjYN277URX3RwRRnYP1HSvgQwKriU6zYhvD/6EJEZbgqKcSVr4FIi/FB9
	tjeMRIUm7N9NcLRWn8g1R65RJ02jK9Q=
Date: Mon, 30 Sep 2024 09:26:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Mark each subprog with proper pstack
 states
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234521.1770481-1-yonghong.song@linux.dev>
 <CAADnVQ+BQ+hkpyyWKH+W-j4FbXmh1STycEEpeGfTxOnafSO8og@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+BQ+hkpyyWKH+W-j4FbXmh1STycEEpeGfTxOnafSO8og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/30/24 7:49 AM, Alexei Starovoitov wrote:
> On Thu, Sep 26, 2024 at 4:45 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Three private stack states are used to direct jit action:
>>    PSTACK_TREE_NO:       do not use private stack
>>    PSTACK_TREE_INTERNAL: adjust frame pointer address (similar to normal stack)
>>    PSTACK_TREE_ROOT:     set the frame pointer
>>
>> Note that for subtree root, even if the root bpf_prog stack size is 0,
>> PSTACK_TREE_INTERNAL is still used. This is for bpf exception handling.
>> More details can be found in subsequent jit support and selftest patches.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h   |  9 +++++++++
>>   kernel/bpf/core.c     | 19 +++++++++++++++++++
>>   kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
>>   3 files changed, 58 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 156b9516d9f6..8f02d11bd408 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1550,6 +1550,12 @@ struct bpf_prog_aux {
>>          };
>>   };
>>
>> +enum bpf_pstack_state {
>> +       PSTACK_TREE_NO,
>> +       PSTACK_TREE_INTERNAL,
>> +       PSTACK_TREE_ROOT,
>> +};
> The names could be improved and 'state' doesn't quite fit imo.
> How about:
> enum bpf_priv_stack_mode {
>     NO_PRIV_STACK,
>     PRIV_STACK_SUB_PROG,
>     PRIV_STACK_MAIN_PROG,
> };

Since we agreed to use priv_stack instead of pstack. The above
names make sense. Will change.

>
>> +
>>   struct bpf_prog {
>>          u16                     pages;          /* Number of allocated pages */
>>          u16                     jited:1,        /* Is our filter JIT'ed? */
>> @@ -1570,15 +1576,18 @@ struct bpf_prog {
>>                                  pstack_eligible:1; /* Candidate for private stacks */
>>          enum bpf_prog_type      type;           /* Type of BPF program */
>>          enum bpf_attach_type    expected_attach_type; /* For some prog types */
>> +       enum bpf_pstack_state   pstack:2;       /* Private stack state */
>>          u32                     len;            /* Number of filter blocks */
>>          u32                     jited_len;      /* Size of jited insns in bytes */
>>          u8                      tag[BPF_TAG_SIZE];
>> +       u16                     subtree_stack_depth; /* Subtree stack depth if PSTACK_TREE_ROOT prog, 0 otherwise */
> All the extra vars can be in prog->aux.
> No need to put them in struct bpf_prog.

Will do.

>
>>          struct bpf_prog_stats __percpu *stats;
>>          int __percpu            *active;
>>          unsigned int            (*bpf_func)(const void *ctx,
>>                                              const struct bpf_insn *insn);
>>          struct bpf_prog_aux     *aux;           /* Auxiliary fields */
>>          struct sock_fprog_kern  *orig_prog;     /* Original BPF program */
>> +       void __percpu           *private_stack_ptr;
> same as this one. prog->aux should be fine.

Will do.

>
>>          /* Instructions for interpreter */
>>          union {
>>                  DECLARE_FLEX_ARRAY(struct sock_filter, insns);
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 0727fff6de0e..d6eb052f6631 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1239,6 +1239,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>>                  struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
>>
>>                  bpf_jit_binary_free(hdr);
>> +               free_percpu(fp->private_stack_ptr);
>>                  WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>>          }
>>
>> @@ -2420,6 +2421,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>                  if (*err)
>>                          return fp;
>>
>> +               if (fp->pstack_eligible) {
>> +                       if (!fp->aux->stack_depth) {
>> +                               fp->pstack = PSTACK_TREE_NO;
>> +                       } else {
>> +                               void __percpu *private_stack_ptr;
>> +
>> +                               fp->pstack = PSTACK_TREE_ROOT;
>> +                               private_stack_ptr =
>> +                                       __alloc_percpu_gfp(fp->aux->stack_depth, 8, GFP_KERNEL);
>> +                               if (!private_stack_ptr) {
>> +                                       *err = -ENOMEM;
>> +                                       return fp;
>> +                               }
>> +                               fp->subtree_stack_depth = fp->aux->stack_depth;
>> +                               fp->private_stack_ptr = private_stack_ptr;
>> +                       }
>> +               }
>> +
>>                  fp = bpf_int_jit_compile(fp);
>>                  bpf_prog_jit_attempt_done(fp);
>>                  if (!fp->jited && jit_needed) {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 69e17cb22037..9d093e2013ca 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20060,6 +20060,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_prog *prog = env->prog, **func, *tmp;
>>          int i, j, subprog_start, subprog_end = 0, len, subprog;
>> +       int subtree_top_idx, subtree_stack_depth;
>>          struct bpf_map *map_ptr;
>>          struct bpf_insn *insn;
>>          void *old_bpf_func;
>> @@ -20138,6 +20139,35 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>                  func[i]->is_func = 1;
>>                  func[i]->sleepable = prog->sleepable;
>>                  func[i]->aux->func_idx = i;
>> +
>> +               subtree_top_idx = env->subprog_info[i].subtree_top_idx;
>> +               if (env->subprog_info[subtree_top_idx].pstack_eligible) {
>> +                       if (subtree_top_idx == i)
>> +                               func[i]->subtree_stack_depth =
>> +                                       env->subprog_info[i].subtree_stack_depth;
>> +
>> +                       subtree_stack_depth = func[i]->subtree_stack_depth;
>> +                       if (subtree_top_idx != i) {
>> +                               if (env->subprog_info[subtree_top_idx].subtree_stack_depth)
>> +                                       func[i]->pstack = PSTACK_TREE_INTERNAL;
>> +                               else
>> +                                       func[i]->pstack = PSTACK_TREE_NO;
>> +                       } else if (!subtree_stack_depth) {
>> +                               func[i]->pstack = PSTACK_TREE_INTERNAL;
>> +                       } else {
>> +                               void __percpu *private_stack_ptr;
>> +
>> +                               func[i]->pstack = PSTACK_TREE_ROOT;
>> +                               private_stack_ptr =
>> +                                       __alloc_percpu_gfp(subtree_stack_depth, 8, GFP_KERNEL);
>> +                               if (!private_stack_ptr) {
>> +                                       err = -ENOMEM;
>> +                                       goto out_free;
>> +                               }
>> +                               func[i]->private_stack_ptr = private_stack_ptr;
>> +                       }
>> +               }
>> +
>>                  /* Below members will be freed only at prog->aux */
>>                  func[i]->aux->btf = prog->aux->btf;
>>                  func[i]->aux->func_info = prog->aux->func_info;
>> --
>> 2.43.5
>>

