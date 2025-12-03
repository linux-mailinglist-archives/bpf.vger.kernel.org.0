Return-Path: <bpf+bounces-75981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198FCA03FE
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 18:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B72A3064E53
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB409368276;
	Wed,  3 Dec 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvUQFxoM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31836829B
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780723; cv=none; b=S72K6ekBv63KqiD5SECUdxzE0Y2AgT/gXvb46KQmWBY+yFb/mUdNMpdJqgNmhOgMwBzm7zCXFJZ1jEXetdOCbyZYLVdn9/BLDmbvlBYkgV1EbnZgkR7a8Qg/MLoRmPOfNR+TN9sFjgOS8yYpCTrW5XXDPzIrQYip5LRD48xUr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780723; c=relaxed/simple;
	bh=TrWS17HYoUnHgvbKDRzjfKX/+vjn4Glt5gwuZekc0Es=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UbCujc5T0p9EoNhCGdqnAJ16SXOZ8SH2iy1GK58E2aiNoKIxu6XS/tEgoYyEFfU9TPpXAMionFrzcknvYlWZs0nf7QKfwAJ+hSx3UqFEm07SKZRT5vAF/lX/U1qp88kCYIz/MGDfccGpQaIPpFMGsnRquQ9sZ1W6VkRqaALliK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvUQFxoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB32C116C6;
	Wed,  3 Dec 2025 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764780723;
	bh=TrWS17HYoUnHgvbKDRzjfKX/+vjn4Glt5gwuZekc0Es=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TvUQFxoMsEIBIRzrjJWztmFYc74Za8xjTtMHaRRzAaOuPI33/YPD/KWSy2YD0tu2o
	 cHNkc9QzTi8dL65FdcWLLpyQtjGAwFA27Wq3/4QprwvQNyqnPjL+2IAy4MC48MjR27
	 nxvi+NtkaLHGnuUBBCBq9fTlrilZ0nTpv3fdP5pytYFa8bQUtPrdcwQfAqB4mqM1gO
	 0BFHupOi7RRZKEMYInBXx0n17K3iy0H7O0klL9TCgsOQgvblHa66jXJmJVoy/jk5q9
	 QYXC0Su1X+zocxowyoO/IRoulhCahjADmKhg/XcDzcy0FRioHodTUylkaUSKqZYHMd
	 Y/03shBbATtYw==
Content-Type: multipart/mixed; boundary="===============4674205723203824665=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45513ae5c2cfe74c5d29d23e6c2eaec62b07e709138bc9167c5fea5ea6dde762@mail.kernel.org>
In-Reply-To: <20251203162625.13152-4-emil@etsalapatis.com>
References: <20251203162625.13152-4-emil@etsalapatis.com>
Subject: Re: [PATCH v2 3/4] libbpf: move arena globals to the end of the arena
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  3 Dec 2025 16:52:01 +0000 (UTC)

--===============4674205723203824665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481b..9642d697b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -2991,10 +2992,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
>  			       void *data, size_t data_sz)
>  {
>  	const long page_sz = sysconf(_SC_PAGE_SIZE);
> +	const size_t data_alloc_sz = roundup(data_sz, page_sz);
>  	size_t mmap_sz;
>
>  	mmap_sz = bpf_map_mmap_sz(map);
> -	if (roundup(data_sz, page_sz) > mmap_sz) {
> +	if (data_alloc_sz > mmap_sz) {
>  		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
>  			sec_name, mmap_sz, data_sz);
>  		return -E2BIG;
> @@ -3006,6 +3008,9 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
>  	memcpy(obj->arena_data, data, data_sz);
>  	obj->arena_data_sz = data_sz;
>
> +	/* place globals at the end of the arena */
> +	obj->arena_data_off = mmap_sz - data_alloc_sz;
> +

Here obj->arena_data_off is a __u32, but the calculation is done in
size_t (64-bit). For a 4GB arena (which the test verifier_arena_large.c
uses), mmap_sz is 4GB and the result can approach 4GB - PAGE_SIZE. This
fits in u32 correctly.

> @@ -4663,7 +4668,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>  		reloc_desc->type = RELO_DATA;
>  		reloc_desc->insn_idx = insn_idx;
>  		reloc_desc->map_idx = obj->arena_map_idx;
> -		reloc_desc->sym_off = sym->st_value;
> +		reloc_desc->sym_off = sym->st_value + obj->arena_data_off;
                                                 ^^^^^^^^^^^^^^^^^^^^^^

Can this overflow when storing to reloc_desc->sym_off? The sym_off field
is 'int' (signed 32-bit), but arena_data_off can be larger than INT_MAX
for arenas approaching 4GB in size.

For example, with a 4GB arena and one page of globals:
- mmap_sz = 4GB = 0x100000000
- data_alloc_sz = 4096
- arena_data_off = 0xFFFFF000 = 4294963200

This value (4294963200) exceeds INT_MAX (2147483647), so when stored in
the signed int sym_off field, it becomes negative.

Later in bpf_object__relocate_data(), this is used as:
    insn[1].imm = insn[0].imm + relo->sym_off;

With sym_off being negative due to overflow, this produces an incorrect
offset for accessing arena globals.

Should sym_off be changed to an unsigned type to handle large arena
offsets correctly?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19901383089

--===============4674205723203824665==--

