Return-Path: <bpf+bounces-73238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDFC27CC2
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACB23B671E
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7F2F5304;
	Sat,  1 Nov 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhO/O+Sn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A58253F3A
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996602; cv=none; b=SdUGW89m/H1zh/fYBWrs7LxJzipbJfMLbaEYKO6cu3z3y97VT6K3aFjdpqLaE9foP1sy2pCEe8b1/1QrcXpbtef/R4WFupsz+vNJbmAszlEm/cbWICDsGVbNDe5tiCrReIXZRKWRSgRrEks8s6xP7LvIdgWXKnA8kUM3QYQHG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996602; c=relaxed/simple;
	bh=7dv/q4CA8M0w4wGxUywYT+vr8kGelCCU3qShPaVwDV0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZZSV23pOozaURFt8aWcC608lzaabY+gKIAvsZlm8CekFAYbWqVgRlnNwpPZUXmSdUVVgxKuzpg7OyyYZlquawontcyW/NlfGp9sVAdWnZ0V7+7epnv3JQu4yh7RHtHLPfOGUv/J3uVkRiDpRPGFv5ju/Wap7njKPNe2BLG52uMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhO/O+Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E943C4CEF1;
	Sat,  1 Nov 2025 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761996599;
	bh=7dv/q4CA8M0w4wGxUywYT+vr8kGelCCU3qShPaVwDV0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BhO/O+SnoFCIbqbAoSCk3jlL8W5OdMkypW6dsne28TYDoOwCi5qq1CJQWZdvwvYFr
	 co5GsEhFH1yMCDxgxht48O7MxzjkOIskahvRTm50c1JGByEWL1B3Z2bP6kciYIQpVk
	 1soglxX4UrB1yjf7zY0lR/Aa6F/AIp+R+u/6ufdFWoV7wrIvKcw+5jU7Hjn0upZOJl
	 IhsW4uYS6KPa4g229arNoQ8pwtzkxGEEAlATrv4y6S7IE9VOIaGF7YkOZ9hrdgeq3P
	 fEzeqfqnPawthNXXwdUQAIuGD/2v47lLl3JAQ711PUFMGAeWk5H0YTJO7dS8E7yTcL
	 UvwEDQkacDmkQ==
Content-Type: multipart/mixed; boundary="===============8080404888809844237=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d383a192daaee1666c5a3dec3d07020dfcb4b4caa2434e73e3f911f629e35f45@mail.kernel.org>
In-Reply-To: <20251101110717.2860949-2-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-2-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v9 bpf-next 01/11] bpf, x86: add new map type: instructions array
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  1 Nov 2025 11:29:59 +0000 (UTC)

--===============8080404888809844237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 77dc1e7091f8bbd42ffa1730c0339642333528c6
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf, x86: add new map type: instructions array

This patch adds BPF_MAP_TYPE_INSN_ARRAY to track instruction offset
mappings (original -> xlated -> jitted) during BPF program verification
and JIT compilation.

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> new file mode 100644
> index 000000000..d29f38721
> --- /dev/null
> +++ b/kernel/bpf/bpf_insn_array.c

[ ... ]

> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Isovalent */
> +
> +#include <linux/bpf.h>
> +
> +struct bpf_insn_array {
> +	struct bpf_map map;
> +	atomic_t used;
> +	long *ips;
> +	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
> +};
> +
> +#define cast_insn_array(MAP_PTR) \
> +	container_of((MAP_PTR), struct bpf_insn_array, map)
> +
> +#define INSN_DELETED ((u32)-1)
> +
> +static inline u32 insn_array_alloc_size(u32 max_entries)
> +{
> +	const u32 base_size = sizeof(struct bpf_insn_array);
> +	const u32 entry_size = sizeof(struct bpf_insn_array_value);
> +
> +	return base_size + max_entries * (entry_size + sizeof(long));
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +}

Can this overflow u32? With entry_size=16 and sizeof(long)=8 on 64-bit,
max_entries around 200 million would cause: 200M * 24 = 4.8B which wraps
to around 504MB when cast to u32. The subsequent bpf_map_area_alloc()
would then allocate only 504MB, but later accesses to values[150000000]
would be out of bounds. Should this function return u64 instead, or
should insn_array_alloc_check() validate an upper bound on max_entries?

[ ... ]

> +static int insn_array_alloc_check(union bpf_attr *attr)
> +{
> +	u32 value_size = sizeof(struct bpf_insn_array_value);
> +
> +	if (attr->max_entries == 0 || attr->key_size != 4 ||
> +	    attr->value_size != value_size || attr->map_flags != 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[ ... ]

> +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
> +{
> +	struct bpf_insn_array *insn_array;
> +	struct bpf_map *map;
> +	u32 xlated_off;
> +	int i, j;
> +
> +	if (!offsets || !image)
> +		return;
> +
> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> +		map = prog->aux->used_maps[i];
> +		if (!is_insn_array(map))
> +			continue;
> +
> +		insn_array = cast_insn_array(map);
> +		for (j = 0; j < map->max_entries; j++) {
> +			xlated_off = insn_array->values[j].xlated_off;
> +			if (xlated_off == INSN_DELETED)
> +				continue;
> +			if (xlated_off < prog->aux->subprog_start)
> +				continue;
> +			xlated_off -= prog->aux->subprog_start;
> +			if (xlated_off >= prog->len)
> +				continue;
> +
> +			insn_array->values[j].jitted_off = offsets[xlated_off];
> +			insn_array->ips[j] = (long)(image + offsets[xlated_off]);
> +		}
> +	}
> +}

Does this handle programs with function calls correctly? When
jit_subprogs() in the verifier splits a program with function calls, it
creates separate bpf_prog structures for the main program and each
subprogram. During JIT compilation, bpf_int_jit_compile() calls
bpf_prog_update_insn_ptrs() for each subprogram separately.

However, subprograms don't have used_maps copied to their aux structure
(see jit_subprogs() in verifier.c). So when bpf_prog_update_insn_ptrs()
is called on a subprogram, prog->aux->used_map_cnt is 0 and the loop
doesn't execute.

When called on the main program (func[0]), prog->len only covers the
main program's instructions (not subprograms), so any tracked instruction
with xlated_off >= prog->len (i.e., in a subprogram) hits the continue
statement and doesn't get its ips[] field set.

Then bpf_insn_array_ready() checks if ips[i] is NULL and returns -EFAULT,
causing program load to fail. Should this function iterate through all
func[] entries and handle each subprogram, or should the main program's
used_maps be copied to subprograms so this works as-is?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c

[ ... ]

> @@ -2853,6 +2854,23 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
>  	return err;
>  }
>
> +static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
> +{
> +	int err;
> +	int i;
> +
> +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> +		if (prog->aux->used_maps[i]->map_type != BPF_MAP_TYPE_INSN_ARRAY)
> +			continue;
> +
> +		err = bpf_insn_array_ready(prog->aux->used_maps[i]);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf, x86: add new map type: instructions array`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18995945884

--===============8080404888809844237==--

