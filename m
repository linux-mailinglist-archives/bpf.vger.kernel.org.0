Return-Path: <bpf+bounces-13654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E17DC481
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F0CB20F4F
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4EC15A1;
	Tue, 31 Oct 2023 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HXTGtJOt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441AA4D
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:36:54 +0000 (UTC)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255CFEA
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:36:50 -0700 (PDT)
Message-ID: <73604c03-75ea-4126-9d8c-38d9581b6d9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698719808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fF3sLgV9ECIJ8pAley6VZPGiy9RqmDb1qwAh4db1m/I=;
	b=HXTGtJOtJKHEX54oK88R3T/B0RFDx5KlhjOgyoOKrMVazuboBduR3lMbNkxfd+ppgzODmg
	JdcbtqILOlanvKgoUfi948L6KIIKWfXxGr5SVfe5cxdQADhjgIqRy2Jb2knSsW8Zqt+c9c
	BbCZPxczcyedBpIPmDHAuVMWrdjWg9M=
Date: Mon, 30 Oct 2023 19:36:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 5/6] bpf: Mark direct ld of stashed
 bpf_{rb,list}_node as non-owning ref
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
 <20231025214007.2920506-6-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025214007.2920506-6-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 2:40 PM, Dave Marchevsky wrote:
> This patch enables the following pattern:
>
>    /* mapval contains a __kptr pointing to refcounted local kptr */
>    mapval = bpf_map_lookup_elem(&map, &idx);
>    if (!mapval || !mapval->some_kptr) { /* omitted */ }
>
>    p = bpf_refcount_acquire(&mapval->some_kptr);
>
> Currently this doesn't work because bpf_refcount_acquire expects an
> owning or non-owning ref. The verifier defines non-owning ref as a type:
>
>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
>
> while mapval->some_kptr is PTR_TO_BTF_ID | PTR_UNTRUSTED. It's possible
> to do the refcount_acquire by first bpf_kptr_xchg'ing mapval->some_kptr
> into a temp kptr, refcount_acquiring that, and xchg'ing back into
> mapval, but this is unwieldy and shouldn't be necessary.
>
> This patch modifies btf_ld_kptr_type such that user-allocated types are
> marked MEM_ALLOC and if those types have a bpf_{rb,list}_node they're
> marked NON_OWN_REF as well. Additionally, due to changes to
> bpf_obj_drop_impl earlier in this series, rcu_protected_object now
> returns true for all user-allocated types, resulting in
> mapval->some_kptr being marked MEM_RCU.
>
> After this patch's changes, mapval->some_kptr is now:
>
>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU
>
> which results in it passing the non-owning ref test, and the motivating
> example passing verification.
>
> Future work will likely get rid of special non-owning ref lifetime logic
> in the verifier, at which point we'll be able to delete the NON_OWN_REF
> flag entirely.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..bb098a4c8fd5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5396,10 +5396,23 @@ BTF_SET_END(rcu_protected_types)
>   static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
>   {
>   	if (!btf_is_kernel(btf))
> -		return false;
> +		return true;
>   	return btf_id_set_contains(&rcu_protected_types, btf_id);
>   }
>   
> +static struct btf_record *kptr_pointee_btf_record(struct btf_field *kptr_field)
> +{
> +	struct btf_struct_meta *meta;
> +
> +	if (btf_is_kernel(kptr_field->kptr.btf))
> +		return NULL;
> +
> +	meta = btf_find_struct_meta(kptr_field->kptr.btf,
> +				    kptr_field->kptr.btf_id);
> +
> +	return meta ? meta->record : NULL;
> +}
> +
>   static bool rcu_safe_kptr(const struct btf_field *field)
>   {
>   	const struct btf_field_kptr *kptr = &field->kptr;
> @@ -5410,12 +5423,25 @@ static bool rcu_safe_kptr(const struct btf_field *field)
>   
>   static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr_field)
>   {
> +	struct btf_record *rec;
> +	u32 ret;
> +
> +	ret = PTR_MAYBE_NULL;
>   	if (rcu_safe_kptr(kptr_field) && in_rcu_cs(env)) {
> -		if (kptr_field->type != BPF_KPTR_PERCPU)
> -			return PTR_MAYBE_NULL | MEM_RCU;
> -		return PTR_MAYBE_NULL | MEM_RCU | MEM_PERCPU;
> +		ret |= MEM_RCU;
> +		if (kptr_field->type == BPF_KPTR_PERCPU)
> +			ret |= MEM_PERCPU;
> +		if (!btf_is_kernel(kptr_field->kptr.btf))
> +			ret |= MEM_ALLOC;
> +
> +		rec = kptr_pointee_btf_record(kptr_field);
> +		if (rec && btf_record_has_field(rec, BPF_GRAPH_NODE))
> +			ret |= NON_OWN_REF;
> +	} else {
> +		ret |= PTR_UNTRUSTED;
>   	}
> -	return PTR_MAYBE_NULL | PTR_UNTRUSTED;
> +
> +	return ret;
>   }

The CI reported a failure.
   https://github.com/kernel-patches/bpf/actions/runs/6675467065/job/18143577936?pr=5886

Error: #162 percpu_alloc
Error:#162/1 percpu_alloc/array
Error:#162/2 percpu_alloc/array_sleepable
Error:#162/3 percpu_alloc/cgrp_local_storage

Error: #162 percpu_alloc
Error:#162/1 percpu_alloc/array
Error: #162/1 percpu_alloc/array
test_array:PASS:percpu_alloc_array__open 0 nsec
libbpf: prog 'test_array_map_2': BPF program load failed: Permission denied
libbpf: prog 'test_array_map_2': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function test_array_map_2#25
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_PROG(test_array_map_2)
0: (b4) w1 = 0 ; R1_w=0
; int index = 0;
1: (63) *(u32 *)(r10 -4) = r1 ; R1_w=0 R10=fp0 fp-8=0000????
2: (bf) r2 = r10 ; R2_w=fp0 R10=fp0
;
3: (07) r2 += -4 ; R2_w=fp-4
; e = bpf_map_lookup_elem(&array, &index);
4: (18) r1 = 0xffffa3bd813c5400 ; R1_w=map_ptr(off=0,ks=4,vs=16,imm=0)
6: (85) call bpf_map_lookup_elem#1 ; 
R0_w=map_value_or_null(id=1,off=0,ks=4,vs=16,imm=0)
; if (!e)
7: (15) if r0 == 0x0 goto pc+9 ; R0_w=map_value(off=0,ks=4,vs=16,imm=0)
; p = e->pc;
8: (79) r1 = *(u64 *)(r0 +8) ; R0=map_value(off=0,ks=4,vs=16,imm=0) 
R1=percpu_rcu_ptr_or_null_val_t(id=2,off=0,imm=0)
; if (!p)
9: (15) if r1 == 0x0 goto pc+7 ; R1=percpu_rcu_ptr_val_t(off=0,imm=0)
; v = bpf_per_cpu_ptr(p, 0);
10: (b4) w2 = 0 ; R2_w=0
11: (85) call bpf_per_cpu_ptr#153
R1 type=percpu_rcu_ptr_ expected=percpu_ptr_, percpu_rcu_ptr_, 
percpu_trusted_ptr_
processed 11 insns (limit 1000000) max_states_per_insn 0 total_states 1 
peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'test_array_map_2': failed to load: -13
libbpf: failed to load object 'percpu_alloc_array'
libbpf: failed to load BPF skeleton 'percpu_alloc_array': -13
test_array:FAIL:percpu_alloc_array__load unexpected error: -13 (errno 13)

The following hack can fix the issue.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb098a4c8fd5..2bbda1f5e858 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5431,7 +5431,7 @@ static u32 btf_ld_kptr_type(struct 
bpf_verifier_env *env, struct btf_field *kptr
                 ret |= MEM_RCU;
                 if (kptr_field->type == BPF_KPTR_PERCPU)
                         ret |= MEM_PERCPU;
-               if (!btf_is_kernel(kptr_field->kptr.btf))
+               else if (!btf_is_kernel(kptr_field->kptr.btf))
                         ret |= MEM_ALLOC;

                 rec = kptr_pointee_btf_record(kptr_field);


Note in the current kernel, MEM_RCU | MEM_PERCPU implies non-kernel 
kptr. The kernel PERCPU kptr has PTR_TRUSTED | MEM_PERCPU. So there is 
no MEM_ALLOC. Adding MEM_ALLOC might need changes in other places 
w.r.t., percpu non-kernel kptr.

Please take a look.

>   
>   static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,

