Return-Path: <bpf+bounces-60209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B573AAD3F7F
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D55D1890ED3
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521923C4F6;
	Tue, 10 Jun 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A5JFk4yG"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF98BF8;
	Tue, 10 Jun 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749574283; cv=none; b=NqjQLo0GW0DS/w/j51bEYFCu61c8HCoh7aXyBneF7EWNUlWUq7kyF1/Q8hsUfY/9fyPYEeGMhK4IaDa9AVdNkIIju+BVc5eDSxflV6N0zMIyvN6lEl8sxXZVg45GMsJq5JCmE9/ujwYjourWuCnAHTU10HpCJWSJSoQ18zEii64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749574283; c=relaxed/simple;
	bh=Vnp2pGDBFC1FRRFjLh56HzSPYJIAcN4hN39e6nTO3i4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WVVo3KzLjmt/l1d3J9GfT4zgDtzWpkBjYmzmhBh7xlrZeHb2nU5rj5CCaJqTawIFwDU/YeHzX9zg2m9Qs9PY50xgI70lpLTFi2LjZzssQaodsLR8chYMPo5+5QAlpft9plxDZ+PG0gprwwgj5Bwmj6ZyA0bfmXGthCK4217Smn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A5JFk4yG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 91EA82027DFC;
	Tue, 10 Jun 2025 09:51:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91EA82027DFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749574281;
	bh=iVKMmCMXdyVuVJ1kvt9F0Q2gH7f1XhSnOnf/XpzVitw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A5JFk4yGJS5XEuWBZTeYrfGmtBBXea+cmST9lD8/cf1L0D9DCjGgTmar/1Fm/6dzU
	 VGvi4Tejr5AD58W3+8GRIoW8H3UdkdGPIrjPSJcodTnJ2h194vjC+xL50Dw7jMPJJ8
	 pazSZmDxGbst9HlObyY/qAWlzG3D7RscbLKkBI6g=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the
 loader
In-Reply-To: <20250606232914.317094-11-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <20250606232914.317094-11-kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 09:51:19 -0700
Message-ID: <87qzzrleuw.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

> To fulfill the BPF signing contract, represented as Sig(I_loader ||
> H_meta), the generated trusted loader program must verify the integrity
> of the metadata. This signature cryptographically binds the loader's
> instructions (I_loader) to a hash of the metadata (H_meta).
>
> The verification process is embedded directly into the loader program.
> Upon execution, the loader loads the runtime hash from struct bpf_map
> i.e. BPF_PSEUDO_MAP_IDX and compares this runtime hash against an
> expected hash value that has been hardcoded directly by
> bpf_obj__gen_loader.
>
> The load from bpf_map can be improved by calling
> BPF_OBJ_GET_INFO_BY_FD from the kernel context after BPF_OBJ_GET_INFO_BY_FD
> has been updated for being called from the kernel context.
>
> The following instructions are generated:
>
>     ld_imm64 r1, const_ptr_to_map // insn[0].src_reg == BPF_PSEUDO_MAP_IDX
>     r2 = *(u64 *)(r1 + 0);
>     ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
> bpftool (part of H_meta)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 8);
>     ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 16);
>     ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
>     if r2 != r3 goto out;
>
>     r2 = *(u64 *)(r1 + 24);
>     ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
>     if r2 != r3 goto out;
>     ...
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |  2 ++
>  tools/lib/bpf/gen_loader.c       | 52 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h           |  3 +-
>  3 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index 6ff963a491d9..49af4260b8e6 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -4,6 +4,7 @@
>  #define __BPF_GEN_INTERNAL_H
>  
>  #include "bpf.h"
> +#include "libbpf_internal.h"
>  
>  struct ksym_relo_desc {
>  	const char *name;
> @@ -50,6 +51,7 @@ struct bpf_gen {
>  	__u32 nr_ksyms;
>  	int fd_array;
>  	int nr_fd_array;
> +	int hash_insn_offset[SHA256_DWORD_SIZE];
>  };
>  
>  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 113ae4abd345..3d672c09e948 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -110,6 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
>  
>  static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
>  static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
> +static void bpf_gen__signature_match(struct bpf_gen *gen);
>  
>  void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
>  {
> @@ -152,6 +153,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
>  	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
>  	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
>  	emit(gen, BPF_EXIT_INSN());
> +	if (gen->opts->gen_hash)
> +		bpf_gen__signature_match(gen);
>  }
>  
>  static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
> @@ -368,6 +371,25 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
>  	__emit_sys_close(gen);
>  }
>  
> +static int compute_sha_udpate_offsets(struct bpf_gen *gen)
> +{
> +	__u64 sha[SHA256_DWORD_SIZE];
> +	int i, err;
> +
> +	err = libbpf_sha256(gen->data_start, gen->data_cur - gen->data_start, sha);
> +	if (err < 0) {
> +		pr_warn("sha256 computation of the metadata failed");
> +		return err;
> +	}
> +	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
> +		struct bpf_insn *insn =
> +			(struct bpf_insn *)(gen->insn_start + gen->hash_insn_offset[i]);
> +		insn[0].imm = (__u32)sha[i];
> +		insn[1].imm = sha[i] >> 32;
> +	}
> +	return 0;
> +}
> +
>  int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  {
>  	int i;
> @@ -394,6 +416,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  			      blob_fd_array_off(gen, i));
>  	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
>  	emit(gen, BPF_EXIT_INSN());
> +	if (gen->opts->gen_hash) {
> +		gen->error = compute_sha_udpate_offsets(gen);
> +		if (gen->error)
> +			return gen->error;
> +	}
> +
>  	pr_debug("gen: finish %s\n", errstr(gen->error));
>  	if (!gen->error) {
>  		struct gen_loader_opts *opts = gen->opts;
> @@ -557,6 +585,30 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  		emit_sys_close_stack(gen, stack_off(inner_map_fd));
>  }
>  
> +static void bpf_gen__signature_match(struct bpf_gen *gen)
> +{
> +	__s64 off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
> +	int i;
> +
> +	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> +						 0, 0, 0, 0));
> +		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * sizeof(__u64)));
> +		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
> +		emit2(gen,
> +		      BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
> +
> +		if (is_simm16(off)) {
> +			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> +			emit(gen,
> +			     BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
> +		} else {
> +			gen->error = -ERANGE;
> +			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> +		}
> +	}
> +}
> +

The above code gets generated per-program and exists out-of-tree in a
very unreadable format in it's final form. I have general objections to
being forced to "trust" out-of-tree code, when it's demostrably trivial
to perform this check in-kernel, without impeding any of the other
stated use cases. There is no possible audit log nor LSM hook for these
operations. There is no way to know that this check was ever performed.

Further, this check ends up happeing in an entirely different syscall,
the LSM layer and the end user may both see invalid programs successfully
being loaded into the kernel, that may fail mysteriously later.

Also, this patch seems to rely on hacking into struct internals and
magic binary layouts.

-blaise

>  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
>  				   enum bpf_attach_type type)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b6ee9870523a..084372fa54f4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1803,9 +1803,10 @@ struct gen_loader_opts {
>  	const char *insns;
>  	__u32 data_sz;
>  	__u32 insns_sz;
> +	bool gen_hash;
>  };
>  
> -#define gen_loader_opts__last_field insns_sz
> +#define gen_loader_opts__last_field gen_hash
>  LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
>  				      struct gen_loader_opts *opts);
>  
> -- 
> 2.43.0

