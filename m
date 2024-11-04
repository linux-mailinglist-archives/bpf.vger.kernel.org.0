Return-Path: <bpf+bounces-43859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D292B9BA9B4
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB0281C04
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532B10F1;
	Mon,  4 Nov 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HJvEXFpW"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99517C
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730679055; cv=none; b=h3sIUUnRT9keh4yZ1LgflWBRkHYiaYI7Qrqvg+Hx6lzk0t/f+OmBSq9idLaj1kKSg+tKG0gr/BeZ13AUJaTpaWL9ACmvZM2d5GTBJB7KWYB8zE9Jz8An+Kb8o7nrju4Q6LC+0H+3+aO1ad4yn+2LVKDoSnVZ+kMCx1CmoMePwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730679055; c=relaxed/simple;
	bh=GQMEur4pbJiNcgwlmdqpHAzAtcN/Wgtb6TIxOZonuIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVrgKYvvWdmgaBAn+eOVa9MdHDl+5fgqsi1rRjTlv97XKkXowvgE1fRAoh/fkDFANOcO5P+H1g8lbAIbhPJSXM+oGsti+sRyELw8TztWz3lOYSu1KPA+tFzZaG90WdgWvwNrL4W8z796n7v39hX9un/HSciac1ef5++3UeUCbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJvEXFpW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f30a28d-0c30-48be-99a8-6018e3ea92b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730679051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8r88AnZYDSjrcE1aE2RoTx8IYfIe3UIYrdpREqjiMn8=;
	b=HJvEXFpWhPYEWYSZxY84BJukJgTOXfKyCQY+8dFU4yW8zaoEWMiqIB2oOzEQoNQdmo9I1Q
	2eTDR91tjxVImIXMN/jwvDbYWvTm/0lLcJiCdBywpsh1a1gPSn3IFPsGTGXhEd7l8tR43H
	O6pcfXHeR6JPmkSoKcLHL/fVyZiLsNs=
Date: Sun, 3 Nov 2024 16:10:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/9] bpf: Allocate private stack for eligible
 main prog or subprogs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
 <20241101031011.2679361-1-yonghong.song@linux.dev>
 <CAADnVQ+3XKiR4YNjZUbZd-UA8pcc697m0-D9x_oNTjo2iCd6QQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+3XKiR4YNjZUbZd-UA8pcc697m0-D9x_oNTjo2iCd6QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/24 1:18 PM, Alexei Starovoitov wrote:
> On Thu, Oct 31, 2024 at 8:10 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> For any main prog or subprogs, allocate private stack space if requested
>> by subprog info or main prog. The alignment for private stack is 16
>> since maximum stack alignment is 16 for bpf-enabled archs.
>>
>> For x86_64 arch, the allocated private stack is freed in arch specific
>> implementation of bpf_jit_free().
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c |  1 +
>>   include/linux/bpf.h         |  1 +
>>   kernel/bpf/core.c           | 10 ++++++++++
>>   kernel/bpf/verifier.c       | 12 ++++++++++++
>>   4 files changed, 24 insertions(+)
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
> I'm 99% certain there are memory leaks when free and alloc
> are imbalanced like this:
> arch code doing free while generic code doing alloc.

Indeed, there are memory leaks. See below.

>
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
>> index 14d9288441f2..6905f250738b 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2396,6 +2396,7 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
>>    */
>>   struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>   {
>> +       void __percpu *priv_stack_ptr;
>>          /* In case of BPF to BPF calls, verifier did all the prep
>>           * work with regards to JITing, etc.
>>           */
>> @@ -2421,6 +2422,15 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
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
> what happens if this jit_compile fails?
> Which part will free priv_stack_ptr?
> I suspect it's a memory leak.

Indeed. There will be a memory leak if jit failed. The same for below
jit_subprogs() case. Will fix in the next revision.

>
>>                  bpf_prog_jit_attempt_done(fp);
>>                  if (!fp->jited && jit_needed) {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 596afd29f088..30e74db6a85f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20080,6 +20080,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_prog *prog = env->prog, **func, *tmp;
>>          int i, j, subprog_start, subprog_end = 0, len, subprog;
>> +       void __percpu *priv_stack_ptr;
>>          struct bpf_map *map_ptr;
>>          struct bpf_insn *insn;
>>          void *old_bpf_func;
>> @@ -20176,6 +20177,17 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
>> --
>> 2.43.5
>>

