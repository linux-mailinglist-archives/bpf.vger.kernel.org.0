Return-Path: <bpf+bounces-73239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F75C27CC5
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08C03B558C
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14612F5334;
	Sat,  1 Nov 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK3KxhUQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2362F3625
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996602; cv=none; b=KHhkgmaKqfkxySoqc/4o7SpMSpsmB6+MLjBgBLayw7HZrVB4C+Axu3tDAerJJ4JsnYUCaaNPAcy0bHNaNGMsFkwgvKO+dVe9p5t1PaLcL+2lGrw+wdBwkGiG13JJbFz1YHXhECAcyyCo5m5/Sl9+tRbjww1Mi+Bcx097+omztCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996602; c=relaxed/simple;
	bh=7lIc1qjLwWHsQdcZIoBsSxZtWcrsykv7iC3T3K2BeBY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nMlyJ189ykhfsKJNu0p4nlbSjNT4PTsSRNF9E4Z2rFOyNfC3HcgsN2WcyXXWsJlJRdf1HuoAq8KSU9LZD1GVuFJrCAF8xWk4U6/FgUgYub4+MrCf9XEgrWuLJ37vSq2GTovx4jULjC7R0sVH+DhpVY/p3MEQr/3PXe+9jk3jmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK3KxhUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275FFC4CEF7;
	Sat,  1 Nov 2025 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761996601;
	bh=7lIc1qjLwWHsQdcZIoBsSxZtWcrsykv7iC3T3K2BeBY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vK3KxhUQzi8s4WFfWTarRvu35te45IRRtuDBBpyB5cL3z4aSuxNzJV3DUDAYSU+9Z
	 1q+rWJ0h1NBlUAEl3W1/rQToWOuOsAeqndjVQ26bN195OXX7YOgUGKSFCPrXOOkY8a
	 jKMgclz+K0msFQIbfZco98PtxFdAGgPLyHSH0ouXC1FfVpbrERp6wTfhfLxNr8ZMM5
	 W0RyZ/oV3n7E5JASuiv46wzZ4ai/RtXLWpl+kpUR7CVio83nO84/IhwdofhPPCNEm9
	 Gj95Xtj4yPK0T5F1Sr2ro7qSKrLATIMnelrK1kCBTQQAWhOGLpWg08+YQuD53XPppX
	 2QwU4+CK2JpHA==
Content-Type: multipart/mixed; boundary="===============7419785522013349844=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22279948629130284ac94db4c37f1d6e44f0ac9dd2e6724e8562ba9d87156f61@mail.kernel.org>
In-Reply-To: <20251101110717.2860949-7-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-7-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v9 bpf-next 06/11] bpf, x86: add support for indirect jumps
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  1 Nov 2025 11:30:01 +0000 (UTC)

--===============7419785522013349844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit cb92a900026e1efa9f89af1f2682f1b544cc7e22
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf, x86: add support for indirect jumps

This patch adds support for indirect jumps (gotox instruction) in BPF
programs, introducing a new PTR_TO_INSN register type to ensure jump
targets are loaded from verified instruction array maps.

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index d29f38721..7bf345a87 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -114,6 +114,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
>  	return insn_array_alloc_size(map->max_entries);
>  }
>
> +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> +{
> +	struct bpf_insn_array *insn_array = cast_insn_array(map);
> +
> +	if ((off % sizeof(long)) != 0 ||
> +	    (off / sizeof(long)) >= map->max_entries)
> +		return -EINVAL;
> +
> +	/* from BPF's point of view, this map is a jump table */
> +	*imm = (unsigned long)insn_array->ips + off;
> +
> +	return 0;
> +}

The insn_array_alloc_size() function can overflow. It computes:

  base_size + max_entries * (entry_size + sizeof(long))

and returns u32. With entry_size=16 and sizeof(long)=8, if max_entries
exceeds ~178 million, the multiplication overflows u32 before the
result is widened to u64 in insn_array_alloc(). This could result in
allocating a buffer much smaller than intended.

While BPF programs have size limits, max_entries validation in
insn_array_alloc_check() only checks != 0 without an upper bound. Should
insn_array_alloc_size() return u64 or add overflow checking?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2b771e2bf..3fdabae07 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17833,6 +17861,197 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
>  	return new;
>  }
>
> +static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
> +{
> +	struct bpf_insn_array_value *value;
> +	u32 i;
> +
> +	for (i = start; i <= end; i++) {
> +		value = map->ops->map_lookup_elem(map, &i);
> +		if (!value)
> +			return -EINVAL;
> +		items[i - start] = value->xlated_off;
> +	}
> +	return 0;
> +}
> +
> +static int cmp_ptr_to_u32(const void *a, const void *b)
> +{
> +	return *(u32 *)a - *(u32 *)b;
> +}
> +
> +static int sort_insn_array_uniq(u32 *items, int cnt)
> +{
> +	int unique = 1;
> +	int i;
> +
> +	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
> +
> +	for (i = 1; i < cnt; i++)
> +		if (items[i] != items[unique - 1])
> +			items[unique++] = items[i];
> +
> +	return unique;
> +}
> +
> +/*
> + * sort_unique({map[start], ..., map[end]}) into off
> + */
> +static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
> +{
> +	u32 n = end - start + 1;
> +	int err;
> +
> +	err = copy_insn_array(map, start, end, off);
> +	if (err)
> +		return err;
> +
> +	return sort_insn_array_uniq(off, n);
> +}
> +
> +/*
> + * Copy all unique offsets from the map
> + */
> +static struct bpf_iarray *jt_from_map(struct bpf_map *map)
> +{
> +	struct bpf_iarray *jt;
> +	int n;
> +
> +	jt = iarray_realloc(NULL, map->max_entries);
> +	if (!jt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->items);
> +	if (n < 0) {
> +		kvfree(jt);
> +		return ERR_PTR(n);
> +	}
> +
> +	return jt;
> +}
                  ^^^^

The iarray_realloc() call sets jt->cnt = map->max_entries, but
copy_insn_array_uniq() returns n (the actual number of unique items)
which could be less. The function returns without updating jt->cnt to n.

In jt_from_subprog()->jt_from_map(), at the check:

  if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end)

Can items[0] be accessed when n=0? If the map contains no valid entries,
jt_cur->cnt still equals max_entries but no items were populated.

Later at:

  memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);

This copies jt_cur->cnt elements, but cnt=max_entries, not the actual
count. Does this copy uninitialized memory from the jt_cur->items array?

[ ... ]

> @@ -18855,6 +19074,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
>  	case PTR_TO_ARENA:
>  		return true;
> +	case PTR_TO_INSN:
> +		return (rold->off == rcur->off && range_within(rold, rcur) &&
> +			tnum_in(rold->var_off, rcur->var_off));
>  	default:
>  		return regs_exact(rold, rcur, idmap);
>  	}
                     ^^^^

Should PTR_TO_INSN check map_ptr equality like PTR_TO_MAP_VALUE does?

The PTR_TO_MAP_VALUE case uses memcmp() which compares all fields
including map_ptr. But this PTR_TO_INSN case only checks off, range, and
var_off. If a BPF program uses multiple INSN_ARRAY maps with different
jump tables, could state pruning incorrectly consider two PTR_TO_INSN
registers equivalent when they point to different maps?


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf, x86: add support for indirect jumps`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18995945884

--===============7419785522013349844==--

