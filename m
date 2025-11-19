Return-Path: <bpf+bounces-75043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98BC6CAE3
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 05:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36F134EBAC5
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F22E7F38;
	Wed, 19 Nov 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh6uJu3u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3F1DDA18;
	Wed, 19 Nov 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525506; cv=none; b=fBvQYLEKYMfNyGzux3KqtDHJceb2wtm+oOr2HeAbBOiFxCkT63FQAbXRbc3P23y5AfStzqIuXkPC5KxXgChm0uDTXUu8KJ9QnCTCKZ8+NJWcjMZH/hG7PcaaFsuG8zWt4ORcnvGjqDnTkEvZR4ophz/6lsRDS5KSNd19G0BYmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525506; c=relaxed/simple;
	bh=mEsH2+lbjhS8gwYwdw4P6p6JgksAeLAfQnIuwiEKVZQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=is2K1qLC9SuysXRdQUsENg7KPSigV+CioJVjFRth52u8vWJVmblkUGOM5OJmsVUEhHmXnindChQvGLnHi4r/q91USMZi4NDEipUWP8f/LExDJJufgPdm212XZ0rjtf/rAPKo99T3zrMwiz/Dj4OAPTtZ7hEfr6M08FAErmdUZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh6uJu3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA93BC2BCAF;
	Wed, 19 Nov 2025 04:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763525505;
	bh=mEsH2+lbjhS8gwYwdw4P6p6JgksAeLAfQnIuwiEKVZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Bh6uJu3u/1vhff6VNyXV3EYIQczW8nMw6OZa0BCyMAkG2AQ1gNNfsRkKCWoU05+WG
	 aLxWrIaMz77kwcIrbejVklBh3DMBs5fVCeBNu/0tZRsituQSecnVB4xB36do48g97r
	 xk6toXJC1TdFihxuHSu9Noer2PrgDXoleypZ5lI6bPNwKX0pmx3KDoQyViUz1F1x6K
	 MWxSglxt+4Bel8k58CT66aSPi8dzEKHOP5SjBw0bIOSngtVbBvZr4E2nqvbGTzpA85
	 u+6udlUPRv+mBchHO2NZGtEqjDE4K0oQaj5TO20tkDI83NfRgLuBn6RCK0FBKSqxEw
	 bo7zMaEXELKpA==
Content-Type: multipart/mixed; boundary="===============8658183863931700979=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fac834d1e096215cef3e1211d329e92b2e5eb1efe2c3f06881fc051ecafd743d@mail.kernel.org>
In-Reply-To: <20251119031531.1817099-5-dolinux.peng@gmail.com>
References: <20251119031531.1817099-5-dolinux.peng@gmail.com>
Subject: Re: [RFC PATCH v7 4/7] libbpf: Optimize type lookup with binary search for sorted BTF
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org,andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,pengdonglin@xiaomi.com,alan.maguire@oracle.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Nov 2025 04:11:44 +0000 (UTC)

--===============8658183863931700979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 71d464690..555703b37 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -897,44 +903,93 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
>  	return type_id;
>  }
>
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
> +						__s32 start_id, __s32 end_id)
>  {
> -	__u32 i, nr_types = btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	const char *tname;
> +	__s32 l, r, m;
> +
> +	l = start_id;
> +	r = end_id;
> +	while (l <= r) {
> +		m = l + (r - l) / 2;
> +		t = btf_type_by_id(btf, m);
> +		tname = btf__str_by_offset(btf, t->name_off);
> +		if (strcmp(tname, name) >= 0) {
                    ^^^^^^
Can strcmp() handle a NULL tname here? The btf__str_by_offset()
function returns NULL when offset is out of range (line 1674 returns
"errno = EINVAL, NULL"), but strcmp() requires non-NULL arguments.

The original linear search code at line 971 checks "if (tname &&
!strcmp(tname, type_name))" before calling strcmp(). Should the binary
search path also check for NULL?

> +			if (l == r)
> +				return r;
> +			r = m;
> +		} else {
> +			l = m + 1;
> +		}
> +	}
> +
> +	return btf__type_cnt(btf);
> +}
> +
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
> +	if (btf->nr_sorted_types > 0) {
> +		/* binary search */
> +		__s32 end_id;
> +		int idx;
> +
> +		end_id = btf->start_id + btf->nr_sorted_types - 1;
> +		idx = btf_find_type_by_name_bsearch(btf, type_name, start_id, end_id);
> +		for (; idx <= end_id; idx++) {
> +			t = btf__type_by_id(btf, idx);
> +			tname = btf__str_by_offset(btf, t->name_off);
> +			if (strcmp(tname, type_name))
                            ^^^^^^
Same question here - can tname be NULL at this point?

> +				goto out;
> +			if (kind == -1 || btf_kind(t) == kind)
> +				return idx;
> +		}
> +	} else {
> +		/* linear search */
> +		__u32 i, total;
> +
> +		total = btf__type_cnt(btf);
> +		for (i = start_id; i < total; i++) {
> +			t = btf_type_by_id(btf, i);
> +			if (kind != -1 && btf_kind(t) != kind)
> +				continue;
> +			tname = btf__str_by_offset(btf, t->name_off);
> +			if (tname && !strcmp(tname, type_name))
> +				return i;
> +		}
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19488781158

--===============8658183863931700979==--

