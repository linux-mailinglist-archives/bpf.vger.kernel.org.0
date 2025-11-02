Return-Path: <bpf+bounces-73270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FDC29705
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0B13AD0F6
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A91A224225;
	Sun,  2 Nov 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLdJfo3O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C3B663
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762118009; cv=none; b=pxMP+uTwrVigcaQxD/8KIWTjV1tJJH7XfZLDmWsAWp0Tdtv4WXlPOfuaATPMxOjndSK2ICQlf24V1SZ23722Kxs+WQy++bn19RIOG5q9pcFk2sDkgKxWb1tingRq+A1+TYfVhW1C7222P3zfrJW7XCtYZZdIxm8R6lL3yiQc83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762118009; c=relaxed/simple;
	bh=DElHm74UY3eMKeNl5uymx1uYYGqjmOKRlNfRYvSl7J8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UOXV5IPSrIlYHzhzIx9c5c7Rk3LXrYafrmjxy0ATqxcNlsgQ8YqvjqecsTrVS+K7Lgap13JlCFt/3q/DmmT0rqwMkF4ZOObUv6jEz2AYL+m2zqGO2ZY8KkQiSGrS/I/UvsgTRKaPuJ/z9Que9me2yd37UjRJlzw+FoNuVxZhL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLdJfo3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43224C4CEF7;
	Sun,  2 Nov 2025 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762118008;
	bh=DElHm74UY3eMKeNl5uymx1uYYGqjmOKRlNfRYvSl7J8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vLdJfo3OwYuOKx5NesRp9hAK4bkN8KHaAziVm1CWJHb3qOd6HFfTEGndW6b5bLw4t
	 0yZ6cW1hWRemkuArkP4dAMf4i5Klx32tTyH0M/Eq+pHVZQjaIPEJPSEQhEjX3rkQmQ
	 QVSp9+3KyXr4aFpyV2993FnqWqNh4EoOJKOcacF5ikyN28JXdKYhnXgrWNz0/1kYt/
	 vFlzomnVSkmG3opBdkzIodeTp1VSwOB8V1nIXB4W21bwQgzCRZBMEvIQbAL0HPd0Ra
	 gyZ72SGx5gc0srwCQcr1BxL/IBYhXwIiXLIXdGriEr1Z2iVHBda7s6OVzG/9SnyGfB
	 S7ZiRFLfcBvRw==
Content-Type: multipart/mixed; boundary="===============8105821141155133688=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
In-Reply-To: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated indirect jumps
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,aspsk@isovalent.com,daniel@iogearbox.net,eddyz87@gmail.com,qmo@kernel.org,yonghong.song@linux.dev
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  2 Nov 2025 21:13:28 +0000 (UTC)

--===============8105821141155133688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit b44690c09995d34f7665c7d687b359d41a6ab79f
Author: Anton Protopopov <a.s.protopopov@gmail.com>

libbpf: support llvm-generated indirect jumps

This commit adds support for LLVM-generated indirect jumps in BPF v4
instruction set. It handles jump table metadata from the .jumptables
ELF section and creates BPF_MAP_TYPE_INSN_ARRAY maps for them.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fbe74686c..ed14090a9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -6144,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
>  	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
>  }
>
> +static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
> +{

[ ... ]

> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
> +{
> +	const __u32 jt_entry_size = 8;
> +	int sym_off = relo->sym_off;
> +	int jt_size = relo->sym_size;
> +	__u32 max_entries = jt_size / jt_entry_size;
> +	__u32 value_size = sizeof(struct bpf_insn_array_value);
> +	struct bpf_insn_array_value val = {};
> +	int subprog_idx;
> +	int map_fd, err;
> +	__u64 insn_off;
> +	__u64 *jt;
> +	__u32 i;
> +
> +	map_fd = find_jt_map(obj, prog, sym_off);
> +	if (map_fd >= 0)
> +		return map_fd;
> +
> +	if (sym_off % jt_entry_size) {
> +		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
> +			sym_off, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	if (jt_size % jt_entry_size) {
> +		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
> +			jt_size, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> +				4, value_size, max_entries, NULL);
> +	if (map_fd < 0)
> +		return map_fd;
> +
> +	if (!obj->jumptables_data) {
> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> +		err = -EINVAL;
> +		goto err_close;
> +	}
> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> +		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
> +			obj->jumptables_data_sz, sym_off + jt_size);
> +		err = -EINVAL;
> +		goto err_close;
> +	}
> +
> +	subprog_idx = -1; /* main program */
> +	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
> +		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
> +		err = -EINVAL;
> +		goto err_close;
> +	}
> +	if (prog->subprogs)
> +		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> +
> +	jt = (__u64 *)(obj->jumptables_data + sym_off);
> +	for (i = 0; i < max_entries; i++) {
> +		/*
> +		 * The offset should be made to be relative to the beginning of
> +		 * the main function, not the subfunction.
> +		 */
> +		insn_off = jt[i]/sizeof(struct bpf_insn);
> +		if (subprog_idx >= 0) {
> +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> +		} else {
> +			insn_off -= prog->sec_insn_off;
> +		}
> +
> +		/*
> +		 * LLVM-generated jump tables contain u64 records, however
> +		 * should contain values that fit in u32.
> +		 */
> +		if (insn_off > UINT32_MAX) {
> +			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
> +				(long long)jt[i], sym_off + i);
                                                      ^^^^^^^^^^^^

Does this error message print the correct offset? Since jt is a pointer
to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
not "sym_off + i". All the other error messages in create_jt_map report
byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
one should probably be "sym_off + i * jt_entry_size" for consistency.

> +			err = -EINVAL;
> +			goto err_close;
> +		}
> +
> +		val.orig_off = insn_off;
> +		err = bpf_map_update_elem(map_fd, &i, &val, 0);
> +		if (err)
> +			goto err_close;
> +	}
> +
> +	err = bpf_map_freeze(map_fd);
> +	if (err)
> +		goto err_close;
> +
> +	err = add_jt_map(obj, prog, sym_off, map_fd);
> +	if (err)
> +		goto err_close;
> +
> +	return map_fd;
> +
> +err_close:
> +	close(map_fd);
> +	return err;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `libbpf: support llvm-generated indirect jumps`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19018051915

--===============8105821141155133688==--

