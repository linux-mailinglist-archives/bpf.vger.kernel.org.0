Return-Path: <bpf+bounces-74826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C71E9C66A81
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0BA04E26CF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A1326ED37;
	Tue, 18 Nov 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoERhKf3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1128371
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425600; cv=none; b=X60fn9IUtAFdVF6MGJfdI4jECzxyxOT5k5sQ0E8bnE1nybXuAjXpST65So8SamqE+kqeU+8c/i2AnNQIpxSbXI/ugWx+/qy5g5UgSavHz13RQCBet2H7I9JipoNCSjR1DX7wZ9xP3ba9jD8j65gbWOmnBbUb/S/Xc5zrQfb7K9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425600; c=relaxed/simple;
	bh=8yO0poy+JOKg8cdFMvUWE8pS0ietBvn55bcMRbU7/bQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U0zYgyTpKSQy58V743jOhEHrAw3zgQ6ogOVPIXMNlJil+w6pVyhwOPCz18M2GKHGUI4+VgbMiAy814OoRb6c4+9uXasDmBhRUg6phXFVASQ6wjswTBUdDHXCqragzqAMuwf1TIS0VC7QYb3kBn7PGraiRpdY9drPHjsiFlSv238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoERhKf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4751AC19423;
	Tue, 18 Nov 2025 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763425599;
	bh=8yO0poy+JOKg8cdFMvUWE8pS0ietBvn55bcMRbU7/bQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uoERhKf3S8AKUM06r5/wyuH+JuytIZADhSaIjQc6K65vQFCuV80C1Rdc0Ibfwrx3f
	 I+ssLaYzy0+2Fh7BDu/hXpdUFQDZzJBBZgDAe+zIMkFXhcCRayoMiig6kfHQrb4PLY
	 DlGiYQamgqc3ddrAuRd4c2FH6pnjLtdwaU18iRRtOpQHXzjfaCqkJD+dxeBtZyvAlw
	 6ayONZRr8ZhdldooqSLrKPuzcBDUbvf3PAmJgTillcsZYS3EpZ/a/ypgJ4B53F0PO0
	 0Q8Qpm1HLDZSK8zJwvqq0UQf9gLxvsh9MCKZDyrdayEU60sNVC5LRFWft9jaakYfYy
	 B5aX37AIloaMA==
Content-Type: multipart/mixed; boundary="===============8029119305964500815=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <059daf735c7afa0eb6abe7b77cebe3fb96a227722721e6e4001661262308446b@mail.kernel.org>
In-Reply-To: <20251117235636.140259-4-emil@etsalapatis.com>
References: <20251117235636.140259-4-emil@etsalapatis.com>
Subject: Re: [PATCH 3/4] libbpf: offset global arena data into the arena if possible
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,memxor@gmail.com,andrii@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Nov 2025 00:26:38 +0000 (UTC)

--===============8029119305964500815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 32dac36ba..6f40c6321 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -757,6 +757,7 @@ struct bpf_object {
>  	int arena_map_idx;
>  	void *arena_data;
>  	size_t arena_data_sz;
> +	__u32 arena_data_off;
>
>  	void *jumptables_data;
>  	size_t jumptables_data_sz;

[ ... ]

> @@ -2991,10 +2992,14 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
>  			       void *data, size_t data_sz)
>  {
>  	const long page_sz = sysconf(_SC_PAGE_SIZE);
> +	const size_t data_alloc_sz = roundup(data_sz, page_sz);
> +	/* default offset into the arena, may be resized */
> +	const long max_off_pages = 16;
>  	size_t mmap_sz;
> +	long off_pages;
>
>  	mmap_sz = bpf_map_mmap_sz(map);
> -	if (roundup(data_sz, page_sz) > mmap_sz) {
> +	if (data_alloc_sz > mmap_sz) {
>  		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
>  			sec_name, mmap_sz, data_sz);
>  		return -E2BIG;
> @@ -3006,6 +3011,17 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
>  	memcpy(obj->arena_data, data, data_sz);
>  	obj->arena_data_sz = data_sz;
>
> +	/*
> +	 * find the largest offset for global arena variables
> +	 * where they still fit in the arena
> +	 */
> +	for (off_pages = max_off_pages; off_pages > 0; off_pages >>= 1) {
> +		if (off_pages * page_sz + data_alloc_sz <= mmap_sz)
> +			break;
> +	}
> +
> +	obj->arena_data_off = off_pages * page_sz;
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can the multiplication overflow __u32 on systems with large page sizes?
On a system configured with 1GB huge pages as the default,
16 pages * 1GB = 16GB, which exceeds 2^32. The result would be
truncated when stored in arena_data_off (declared as __u32), causing
the offset calculation to wrap around.

While this configuration is rare, the truncation would cause arena data
to be placed at an incorrect offset, breaking the intended behavior. The
three uses of arena_data_off (in init_arena_map_data,
bpf_program__record_reloc, and bpf_object__create_maps) would all use
the truncated value consistently, so if truncation occurs to 0, the code
would fall back to the original behavior of placing data at offset 0.

Should arena_data_off be changed to size_t or __u64 to handle larger
page sizes, or is __u32 considered sufficient for expected arena usage?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19448868610

--===============8029119305964500815==--

