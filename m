Return-Path: <bpf+bounces-43994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F59BC390
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F107E1F22D1D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470166F307;
	Tue,  5 Nov 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DxTo2Mmh"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D92A1CA
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776053; cv=none; b=SFMXPiirRj1zZ05/5SwPNjXLK/Q2K3zmY4LF/z4vCHTKM8JmsC5GCtZQg7K6bWRJIR1UTTXekFAasEnZZr4kG7fgVJlYU7gqHTdorBJVIYl1hADY/jdxOT0XMZkwyJJLVRRAI9MDvQcbQwbiL7D2P1ZmhOcM8D9SUpDGCfOnpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776053; c=relaxed/simple;
	bh=e1bqnIk72+BlalW4jTydiF8www6B4ymhZsxr0SNTUmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrTrwCHKG7H6TFCVQlN55owk4/uB3Z7zjj0OYgSn2Bx5+vZf701Rh2XJU6kFaA7A6fkS2aQ1nGMVfJBEGMkwmN2OW2yscS9VvEQ7R4Y9IR5ktttnitvSPyScbCR55DKe68nlCzHXxz+wWtyjINc3S4zeMIv5UY1gLO089s+4COY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DxTo2Mmh; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34a35dce-fd05-4353-8eaa-0dc87a78dceb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730776048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UERrkHL1OHe8PplPtDtkXD5vmvS+sdIDhdzmKCK4Q/E=;
	b=DxTo2Mmhk+pyr2XFfcpcxJVKQxffnMJXnKZUWBL1fCasDup4KawyRpVfcYMC+r6DylRAI/
	a98yxL9PNEiZOvsIeD/9bVkkq2/sq6JmhvR1uffhdNmXjSDKmIjj4w8g0Xj/fz2t31+nsY
	yEkOM8+BWyzjHbWNdrtjgzwqGMddGeo=
Date: Mon, 4 Nov 2024 19:07:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 05/10] bpf: Allocate private stack for
 eligible main prog or subprogs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193521.3243984-1-yonghong.song@linux.dev>
 <CAADnVQ+RGgtLtoc_ODv54gt0donCdd_4sLWS1oWA_nGStjb1KQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+RGgtLtoc_ODv54gt0donCdd_4sLWS1oWA_nGStjb1KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/4/24 5:38 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 11:38 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> For any main prog or subprogs, allocate private stack space if requested
>> by subprog info or main prog. The alignment for private stack is 16
>> since maximum stack alignment is 16 for bpf-enabled archs.
>>
>> If jit failed, the allocated private stack will be freed in the same
>> function where the allocation happens. If jit succeeded, e.g., for
>> x86_64 arch, the allocated private stack is freed in arch specific
>> implementation of bpf_jit_free().
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c |  1 +
>>   include/linux/bpf.h         |  1 +
>>   kernel/bpf/core.c           | 19 ++++++++++++++++---
>>   kernel/bpf/verifier.c       | 13 +++++++++++++
>>   4 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa5..59d294b8dd67 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3544,6 +3544,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>>                  prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
>>                  hdr = bpf_jit_binary_pack_hdr(prog);
>>                  bpf_jit_binary_pack_free(hdr, NULL);
>> +               free_percpu(prog->aux->priv_stack_ptr);
>>                  WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>>          }
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8db3c5d7404b..8a3ea7440a4a 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1507,6 +1507,7 @@ struct bpf_prog_aux {
>>          u32 max_rdwr_access;
>>          struct btf *attach_btf;
>>          const struct bpf_ctx_arg_aux *ctx_arg_info;
>> +       void __percpu *priv_stack_ptr;
>>          struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
>>          struct bpf_prog *dst_prog;
>>          struct bpf_trampoline *dst_trampoline;
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 14d9288441f2..f7a3e93c41e1 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2396,6 +2396,7 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
>>    */
>>   struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>   {
>> +       void __percpu *priv_stack_ptr = NULL;
>>          /* In case of BPF to BPF calls, verifier did all the prep
>>           * work with regards to JITing, etc.
>>           */
>> @@ -2421,11 +2422,23 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>                  if (*err)
>>                          return fp;
>>
>> +               if (fp->aux->use_priv_stack && fp->aux->stack_depth) {
>> +                       priv_stack_ptr = __alloc_percpu_gfp(fp->aux->stack_depth, 16, GFP_KERNEL);
>> +                       if (!priv_stack_ptr) {
>> +                               *err = -ENOMEM;
>> +                               return fp;
>> +                       }
>> +                       fp->aux->priv_stack_ptr = priv_stack_ptr;
>> +               }
>> +
>>                  fp = bpf_int_jit_compile(fp);
>>                  bpf_prog_jit_attempt_done(fp);
>> -               if (!fp->jited && jit_needed) {
>> -                       *err = -ENOTSUPP;
>> -                       return fp;
>> +               if (!fp->jited) {
>> +                       free_percpu(priv_stack_ptr);
>> +                       if (jit_needed) {
>> +                               *err = -ENOTSUPP;
>> +                               return fp;
>> +                       }
>>                  }
>>          } else {
>>                  *err = bpf_prog_offload_compile(fp);
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e01b3f0fd314..03ae76d57076 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20073,6 +20073,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_prog *prog = env->prog, **func, *tmp;
>>          int i, j, subprog_start, subprog_end = 0, len, subprog;
>> +       void __percpu *priv_stack_ptr;
>>          struct bpf_map *map_ptr;
>>          struct bpf_insn *insn;
>>          void *old_bpf_func;
>> @@ -20169,6 +20170,17 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>
>>                  func[i]->aux->name[0] = 'F';
>>                  func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
>> +
>> +               if (env->subprog_info[i].use_priv_stack && func[i]->aux->stack_depth) {
>> +                       priv_stack_ptr = __alloc_percpu_gfp(func[i]->aux->stack_depth, 16,
>> +                                                           GFP_KERNEL);
>> +                       if (!priv_stack_ptr) {
>> +                               err = -ENOMEM;
>> +                               goto out_free;
>> +                       }
>> +                       func[i]->aux->priv_stack_ptr = priv_stack_ptr;
>> +               }
>> +
>>                  func[i]->jit_requested = 1;
>>                  func[i]->blinding_requested = prog->blinding_requested;
>>                  func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
>> @@ -20201,6 +20213,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>                          func[i]->aux->exception_boundary = env->seen_exception;
>>                  func[i] = bpf_int_jit_compile(func[i]);
>>                  if (!func[i]->jited) {
>> +                       free_percpu(func[i]->aux->priv_stack_ptr);
>>                          err = -ENOTSUPP;
>>                          goto out_free;
>>                  }
> Looks correct from leaks pov, but this is so hard to follow.
> I still don't like this imbalanced alloc/free.
> Either both need to be done by core or both by JIT.
>
> And JIT is probably better, since in:
> _alloc_percpu_gfp(func[i]->aux->stack_depth, 16
>
> 16 alignment is x86 specific.

Agree. I use alignment 16 to cover all architectures. for x86_64, 
alignment 8 is used. I did some checking in arch/ directory. 
[~/work/bpf-next/arch (master)]$ find . -name 'net' ./arm/net ./mips/net 
./parisc/net ./powerpc/net ./s390/net ./sparc/net ./x86/net ./arc/net 
./arm64/net ./loongarch/net ./riscv/net [~/work/bpf-next/arch (master)]$ 
egrep -r bpf_jit_free (excluding not func definition) 
powerpc/net/bpf_jit_comp.c:void bpf_jit_free(struct bpf_prog *fp) 
sparc/net/bpf_jit_comp_32.c:void bpf_jit_free(struct bpf_prog *fp) 
x86/net/bpf_jit_comp.c:void bpf_jit_free(struct bpf_prog *prog) 
arm64/net/bpf_jit_comp.c:void bpf_jit_free(struct bpf_prog *prog) 
riscv/net/bpf_jit_core.c:void bpf_jit_free(struct bpf_prog *prog) Looks 
like all important arch's like x86_64,arm64,riscv having their own 
bpf_jit_free(). Some others like s390, etc. do not. I think we can do 
allocation in JIT. If s390 starts to implement private stack, then it 
can implement arch-specific version of bpf_jit_free() at that time.


