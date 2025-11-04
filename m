Return-Path: <bpf+bounces-73443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA74C31758
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65F4F4F8C32
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092B2F3605;
	Tue,  4 Nov 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEE4RMnY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A632D455;
	Tue,  4 Nov 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265737; cv=none; b=Dzd9FIfoE9yu/5HFMIO3GI+S6N4yswtBUXKm1XaMvxWUBuzQxm2z3kGuemSz11Rif4ZJjCaAEJ116G9unsYXIab5ufdzH8X/ZwbZ7WPW0mT6Ck6oYPsX1as0WUkkKUYFtPcwfaDzxmUz9umUE8+2sntqdp/nAK3tLhBQukyOIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265737; c=relaxed/simple;
	bh=E1djz9xWSZfpNMoUbjjZ6AOdqe01/8uQr8xlUPfaUJc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tQ3fBuV7GgVDm3CKpzn28v02ic9bQhm77RLgF3hHIBskwdm/i9JFy6/wVIddzzi1+uIUpHnb/a1uYlOCWs96afZvLFyfhZKLolYXoRRBqk+PmYFPrxGtw4nnHRQkC7h/CCCkh7/VIKoR3FtlSaPqvQ2MaoFl3k+1UCm4IQkv6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEE4RMnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC558C4CEF7;
	Tue,  4 Nov 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265737;
	bh=E1djz9xWSZfpNMoUbjjZ6AOdqe01/8uQr8xlUPfaUJc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EEE4RMnYHL3E8llcN9SERFI50LtR7VGdawrokUs0wcVAomneSUVM4TCYruxYanBxA
	 1yg9+bz7UzsfElBOODID5ZqapSmXadBpeMWwhWiSkFxQ97gszHUamcn6gp9vJpEn2j
	 AU7X2BqELxhi7CrgrLWmql2aTbA/4BwfFYyOGVylk25cfCAXeytcKwXI5QJR70rsZn
	 /nqscHd6mMqcGXXiD1RSinKyS4pW+q0WeDzMzoppd5dMvK54W830yTN7RMooS4LnlP
	 Mq4DhLhfmDolyHaLliNx16E5L4emYH0cM16+qRSkXXDDq61i3YArCJRBmHeeR+RaVS
	 R2FvdJKugQdHA==
Content-Type: multipart/mixed; boundary="===============1160980078400196391=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1364f197cb22d16221dd90b76a10378fc5b99917f1e62c9184f9611a91357532@mail.kernel.org>
In-Reply-To: <20251104134033.344807-4-dolinux.peng@gmail.com>
References: <20251104134033.344807-4-dolinux.peng@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary search for sorted BTF
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,dolinux.peng@gmail.com,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,song@kernel.org,pengdonglin@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 14:15:36 +0000 (UTC)

--===============1160980078400196391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3bc03f7fe..5af143044 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -92,6 +92,12 @@ struct btf {
>  	 *   - for split BTF counts number of types added on top of base BTF.
>  	 */
>  	__u32 nr_types;
> +	/* number of sorted and named types in this BTF instance:
> +	 *   - doesn't include special [0] void type;
> +	 *   - for split BTF counts number of sorted and named types added on
> +	 *     top of base BTF.
> +	 */
> +	__u32 nr_sorted_types;

Where is this field initialized? I searched the entire codebase and
found no assignments to nr_sorted_types. Since struct btf is allocated
with calloc() in btf__new() and other allocation functions, this field
will always be zero.

This means the binary search optimization added below will never execute
because the check at btf_find_type_by_name_kind() tests:

    if (btf->nr_sorted_types) {
        /* binary search */
        ...
    }

With nr_sorted_types always zero, the optimization appears to be
completely non-functional in this commit.

>  	/* if not NULL, points to the base BTF on top of which the current
>  	 * split BTF is based
>  	 */

[ ... ]

> @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
>  	return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +/*
> + * Find BTF types with matching names within the [left, right] index range.
> + * On success, updates *left and *right to the boundaries of the matching range
> + * and returns the leftmost matching index.
> + */
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
> +						__s32 *left, __s32 *right)
>  {
> -	__u32 i, nr_types = btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	const char *tname;
> +	__s32 l, r, m, lmost, rmost;
> +	int ret;
> +
> +	/* found the leftmost btf_type that matches */
> +	l = *left;
> +	r = *right;
> +	lmost = -1;
> +	while (l <= r) {
> +		m = l + (r - l) / 2;
> +		t = btf_type_by_id(btf, m);
> +		tname = btf__str_by_offset(btf, t->name_off);
> +		ret = strcmp(tname, name);

Can strcmp() crash with a NULL tname here? btf__str_by_offset() can
return NULL when offset is invalid (see line 1713 in btf.c). The old
code had a NULL check: "if (name && !strcmp(type_name, name))" and the
new linear search path also checks: "if (tname && !strcmp(tname,
type_name))", but this binary search path calls strcmp() directly.

Though currently unreachable due to nr_sorted_types being zero, if that
initialization issue is fixed, this could dereference NULL.

> +		if (ret < 0) {
> +			l = m + 1;
> +		} else {
> +			if (ret == 0)
> +				lmost = m;
> +			r = m - 1;
> +		}
> +	}
> +
> +	if (lmost == -1)
> +		return -ENOENT;
> +
> +	/* found the rightmost btf_type that matches */
> +	l = lmost;
> +	r = *right;
> +	rmost = -1;
> +	while (l <= r) {
> +		m = l + (r - l) / 2;
> +		t = btf_type_by_id(btf, m);
> +		tname = btf__str_by_offset(btf, t->name_off);
> +		ret = strcmp(tname, name);

Same potential NULL dereference issue here.

> +		if (ret <= 0) {
> +			if (ret == 0)
> +				rmost = m;
> +			l = m + 1;
> +		} else {
> +			r = m - 1;
> +		}
> +	}
> +
> +	*left = lmost;
> +	*right = rmost;
> +	return lmost;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19070905166

--===============1160980078400196391==--

