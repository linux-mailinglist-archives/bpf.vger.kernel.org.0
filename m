Return-Path: <bpf+bounces-73863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E01C3B748
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D96D505601
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D63396E1;
	Thu,  6 Nov 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcxSMNO9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539533890E;
	Thu,  6 Nov 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436403; cv=none; b=JEmGDtbKV3OWAbgPZkIERRDSCXa0Ng5EV4OrMHUt8zXNOJZh2Rm2sxPb4PkiZ3YbdQ99JZFjWGnON40rAkq8It95wN6shgeFAAAASWtnhjwRnIykCoBJitWN3n4vJIcvycNOwAk0N73ATS2vDcN9jI4coaG9Ysig8a37sRuksBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436403; c=relaxed/simple;
	bh=0c32xygNFMHuAdkgTiAseuURvj7uxZ0qyUH2dXpbt90=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AwUPquSVknD67vmldht4Gby+SGG/jir44LxQ2vW+srvO/nuDUDw0+KpN268LAWRkO5jcqkQKdBDO7LrEmPkz3Co2Uf22IbCjFqVTyNrijSc/t7JgCdltyAsTc1p9VVsa7f/Mq/wxuXnP5C+mPiGva2zsm73GrjpmvEBhE7uHBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcxSMNO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB51C116C6;
	Thu,  6 Nov 2025 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436402;
	bh=0c32xygNFMHuAdkgTiAseuURvj7uxZ0qyUH2dXpbt90=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DcxSMNO98vqeBcDuF8H+OKTwmQGN5eZRQ/HjAoiWQjAcrU1ZLnx+eNI+cN+oWchtb
	 /ut4/fEQr9Q+q0GF9CaY8X7jgRaA1smmWXd/kOvNVRrpO8PM1MgDT6DVqFtk92hv/P
	 TUplzIEf3Zur1Wv0yzY9Mh2dne4bivEI2MM5n6K5hju9cVSiUlUU7/AHHQkmoGuTmz
	 +Zo+oubWSdposInHLWuMMNDFBsNN6qafC2YgvcubzjfRh2Ye9QJcsrYERcM+d+Ar9Y
	 h5XgChffr9V9FfGmnh3irMc6fDheelYR52WXPGWTV7YqKbK5qCA35h17d3Tfs4wvp+
	 SOpp4qsbJ6D4A==
Content-Type: multipart/mixed; boundary="===============7991617120707915876=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20ace4a32dae5b4dcac499d8cb78ac5cab73d75a69b07b67113b7fbbb6e5ef45@mail.kernel.org>
In-Reply-To: <20251106131956.1222864-4-dolinux.peng@gmail.com>
References: <20251106131956.1222864-4-dolinux.peng@gmail.com>
Subject: Re: [PATCH v5 3/7] libbpf: Optimize type lookup with binary search for sorted BTF
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,dolinux.peng@gmail.com,alan.maguire@oracle.com,song@kernel.org,pengdonglin@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  6 Nov 2025 13:40:02 +0000 (UTC)

--===============7991617120707915876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 97451a929..30be62ee2 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -26,6 +26,10 @@
>
>  #define BTF_MAX_NR_TYPES 0x7fffffffU
>  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> +/*
> + * sort verification occurs lazily upon first btf_find_type_by_name_kind() call
> + */
> +#define BTF_NEED_SORT_CHECK ((__u32)-1)

[ ... ]

> @@ -92,6 +96,16 @@ struct btf {
>  	 *   - for split BTF counts number of types added on top of base BTF.
>  	 */
>  	__u32 nr_types;
> +	/* number of sorted and named types in this BTF instance:
> +	 *   - doesn't include special [0] void type;
> +	 *   - for split BTF counts number of sorted and named types added on
> +	 *     top of base BTF.
> +	 *   - BTF_NEED_SORT_CHECK value indicates sort validation will be performed
> +	 *     on first call to btf_find_type_by_name_kind.
> +	 *   - zero value indicates applied sorting check with unsorted BTF or no
> +	 *     named types.
> +	 */
> +	__u32 nr_sorted_types;

[ ... ]

> @@ -897,44 +911,126 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
>  	return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +/* Performs binary search within specified type ID range to find the leftmost
> + * BTF type matching the given name. The search assumes types are sorted by
> + * name in lexicographical order within the specified range.
> + *
> + * Return: Type ID of leftmost matching type, or -ENOENT if not found
> + */
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
> +						__s32 start_id, __s32 end_id)
>  {
> -	__u32 i, nr_types = btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	const char *tname;
> +	__s32 l, r, m, lmost = -ENOENT;
> +	int ret;
> +
> +	l = start_id;
> +	r = end_id;
> +	while (l <= r) {
> +		m = l + (r - l) / 2;
> +		t = btf_type_by_id(btf, m);
> +		tname = btf__str_by_offset(btf, t->name_off);
> +		ret = strcmp(tname, name);
>                      ^^^^^^

Can strcmp receive a NULL tname here? Anonymous types have name_off=0,
and btf__str_by_offset() can return NULL for invalid offsets. The old
btf__find_by_name() checked "if (name && !strcmp(...))" before calling
strcmp.

> +		if (ret < 0) {
> +			l = m + 1;
> +		} else {
> +			if (ret == 0)
> +				lmost = m;
> +			r = m - 1;
> +		}
> +	}
> +
> +	return lmost;
> +}
> +
> +/* Searches for a BTF type by name and optionally by kind. The function first
> + * checks if the search should start from the base BTF (if @start_id is before
> + * current BTF's start_id). If types are sorted, it uses binary search to find
> + * the leftmost matching type and then verifies the kind. For unsorted types,
> + * it falls back to linear search through all types.
> + *
> + * The function handles split BTF scenarios by recursively searching in base
> + * BTFs when necessary. When @kind is -1, only the name matching is performed.
> + *
> + * Return: Type ID of matching type on success, -ENOENT if not found
> + */
> +static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_id,
> +				   const char *type_name, __u32 kind)
> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	int err = -ENOENT;
> +
> +	if (start_id < btf->start_id) {
> +		err = btf_find_type_by_name_kind(btf->base_btf, start_id,
> +			type_name, kind);
> +		if (err > 0)
> +			goto out;
> +		start_id = btf->start_id;
> +	}
> +
> +	if (btf->nr_sorted_types != BTF_NEED_SORT_CHECK) {

Where is nr_sorted_types updated from BTF_NEED_SORT_CHECK? I only see
three assignments in the entire file:

  btf_new_empty():             btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
  btf_new():                   btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
  btf_invalidate_raw_data():   btf->nr_sorted_types = BTF_NEED_SORT_CHECK;

The comment claims "sort verification occurs lazily upon first
btf_find_type_by_name_kind() call" but this function never updates
nr_sorted_types. Does this mean the binary search path never executes?

> +		/* binary search */
> +		__s32 end_id;
> +		bool skip_first;
> +		int ret;
> +
> +		end_id = btf->start_id + btf->nr_sorted_types - 1;
> +		ret = btf_find_type_by_name_bsearch(btf, type_name, start_id, end_id);
> +		if (ret < 0)
> +			goto out;
> +		if (kind == -1)
> +			return ret;
> +		skip_first = true;
> +		do {
> +			t = btf_type_by_id(btf, ret);
> +			if (BTF_INFO_KIND(t->info) != kind) {
> +				if (skip_first) {
> +					skip_first = false;
> +					continue;
> +				}
> +			} else if (skip_first) {
> +				return ret;
> +			}
> +			tname = btf__str_by_offset(btf, t->name_off);
> +			if (!strcmp(tname, type_name))
>                              ^^^^^^

Same NULL dereference concern here - tname isn't checked before strcmp.

> +				return ret;
> +			else
> +				break;
> +		} while (++ret <= end_id);
> +	} else {
> +		/* linear search */
> +		__u32 i, total;
>
> -	if (!strcmp(type_name, "void"))
> -		return 0;
> -
> -	for (i = 1; i < nr_types; i++) {
> -		const struct btf_type *t = btf__type_by_id(btf, i);
> -		const char *name = btf__name_by_offset(btf, t->name_off);
> -
> -		if (name && !strcmp(type_name, name))
> -			return i;
> +		total = btf__type_cnt(btf);
> +		for (i = start_id; i < total; i++) {
> +			t = btf_type_by_id(btf, i);
> +			if (kind != -1 && btf_kind(t) != kind)
> +				continue;
> +			tname = btf__str_by_offset(btf, t->name_off);
> +			if (tname && !strcmp(tname, type_name))
> +				return i;
> +		}
>  	}
>
> -	return libbpf_err(-ENOENT);
> +out:
> +	return err;
>  }

[ ... ]

> @@ -1006,6 +1102,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>  	btf->fd = -1;
>  	btf->ptr_sz = sizeof(void *);
>  	btf->swapped_endian = false;
> +	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
>
>  	if (base_btf) {
>  		btf->base_btf = base_btf;

[ ... ]

> @@ -1057,6 +1154,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
>  	btf->start_id = 1;
>  	btf->start_str_off = 0;
>  	btf->fd = -1;
> +	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
>
>  	if (base_btf) {
>  		btf->base_btf = base_btf;

[ ... ]

> @@ -1715,6 +1813,7 @@ static void btf_invalidate_raw_data(struct btf *btf)
>  		free(btf->raw_data_swapped);
>  		btf->raw_data_swapped = NULL;
>  	}
> +	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19137195500

--===============7991617120707915876==--

