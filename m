Return-Path: <bpf+bounces-73864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A687C3B6F1
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16911AA3BBD
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177921FF4C;
	Thu,  6 Nov 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHZGfPtU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF6224AEB;
	Thu,  6 Nov 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436862; cv=none; b=s0vLIVtWJuplQ16aM2JA4O7OP84P1QLtfcrgffDghf8iDakyQosbkWMGeFDchdzMf/2FtA3G3T7Ii3AfdH+qtSIx43anI2c8q9dgo6bUZwAavM+57Fhe+owr+G+BZ6Ihk3YIbN7DeqHRa4Ytwfue55K2smCg5qEDtBgsG/wrnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436862; c=relaxed/simple;
	bh=lx84fD5W7xw2dxcyU/Nm5QZtToxR2CWTtzsuFi6Z+js=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qw8f+G36XG9yoib1BxbmIBzCXIJXP/rVuVbDluu4kgAu83yt8tgJG22xKMfos1rXqKhdgdgouuSwva6la4an0dwdrTonir98r9FYvzN9VDn7/esPTHyJQGCp0BNjdML6Yii4p15e8cxswnWp7up/c7kIyrd0pLlgo1ZG2jB1i8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHZGfPtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D9C2BCB1;
	Thu,  6 Nov 2025 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762436861;
	bh=lx84fD5W7xw2dxcyU/Nm5QZtToxR2CWTtzsuFi6Z+js=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UHZGfPtUV+I2Iy7PB+A6n4E6B1kTI/ledWnVJ7ET1YpRT016EJUFm8jWFvnO1xNYc
	 WhpBQiCs3opm8NRoSwbjeSl6PBfdYpjGs7xh0DJ8fCbunvCTTKgX91X6ayy15/gsQG
	 hUxMfGd0uhpIoPzoYLXYgDt4eU87Rmw0A7f9IBz8zW1su+UYmainfM+y8PA5zF601m
	 e2kKL6L02gm83VBBLZ0be2EncZXXja3mJZ7a2cbunKsURgaJhIGQ5I2Oy7EIH5eAqK
	 TUNswj6WNVeOaruxk/v+EvVeq77F6njo2Y1ZMThMqZH3q1sTtIOs6CSMkwPuzTIuGt
	 YHGEF7/H4wHOg==
Content-Type: multipart/mixed; boundary="===============8769320570170703310=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <36cd75fea9d630152704e29bd21054aba72dcb459a7b9d40b5d979313b1fe3a5@mail.kernel.org>
In-Reply-To: <20251106131956.1222864-3-dolinux.peng@gmail.com>
References: <20251106131956.1222864-3-dolinux.peng@gmail.com>
Subject: Re: [PATCH v5 2/7] libbpf: Add BTF permutation support for type reordering
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,dolinux.peng@gmail.com,alan.maguire@oracle.com,song@kernel.org,pengdonglin@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  6 Nov 2025 13:47:40 +0000 (UTC)

--===============8769320570170703310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9c389b2c8..97451a929 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> +int btf__permute(struct btf *btf, __u32 *ids, __u32 ids_sz, const struct btf_permute_opts *opts)
> +{
> +	struct btf_permute p;
> +	int err = 0;
> +	__u32 *ids_map = NULL;
> +
> +	if (!OPTS_VALID(opts, btf_permute_opts) || (ids_sz > btf->nr_types))
> +		return libbpf_err(-EINVAL);
> +
> +	ids_map = calloc(ids_sz, sizeof(*ids_map));

Can ids_map overflow here in btf_permute_shuffle_types()?

The ids_map array is allocated with ids_sz elements, giving valid
indices from 0 to ids_sz-1. However, in btf_permute_shuffle_types()
the code accesses:

    ids_map = &p->ids_map[id - btf->start_id]

where 'id' is validated only to be in range [btf->start_id,
btf->start_id + btf->nr_types). When ids_sz < btf->nr_types
(truncation case) and a user provides a type ID where
(id - btf->start_id) >= ids_sz, this results in an out-of-bounds
write to ids_map.

For example, with start_id=1, nr_types=100, and ids_sz=50:
- ids_map has 50 elements (indices 0-49)
- If user includes type ID 75 in the ids array
- btf__type_by_id(btf, 75) succeeds (75 < 101)
- ids_map[75-1] = ids_map[74] writes beyond the array

The same issue occurs in btf_permute_remap_type_id() where the code
reads from ids_map without validating the index is within ids_sz:

    new_type_id = p->ids_map[*type_id - p->btf->start_id]

If any included type references a type ID beyond ids_sz, this reads
uninitialized memory (or out-of-bounds if the ID is >= ids_sz +
start_id).

> +	if (!ids_map) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	p.btf = btf;
> +	p.btf_ext = OPTS_GET(opts, btf_ext, NULL);
> +	p.ids = ids;
> +	p.ids_map = ids_map;
> +	p.ids_sz = ids_sz;
> +
> +	if (btf_ensure_modifiable(btf)) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +	err = btf_permute_shuffle_types(&p);
> +	if (err < 0) {
> +		goto done;
> +	}
> +	err = btf_permute_remap_types(&p);
> +	if (err < 0) {
> +		goto done;
> +	}
> +
> +done:
> +	free(ids_map);
> +	return libbpf_err(err);
> +}

[ ... ]

> +static int btf_permute_shuffle_types(struct btf_permute *p)
> +{
> +	struct btf *btf = p->btf;
> +	const struct btf_type *t;
> +	__u32 *new_offs = NULL, *ids_map;
> +	void *nt, *new_types = NULL;
> +	int i, id, len, err;
> +
> +	new_offs = calloc(p->ids_sz, sizeof(*new_offs));
> +	new_types = calloc(btf->hdr->type_len, 1);
> +	if (!new_offs || !new_types) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	nt = new_types;
> +	for (i = 0; i < p->ids_sz; i++) {
> +		id = p->ids[i];
> +		/* type IDs from base_btf and the VOID type are not allowed */
> +		if (id < btf->start_id) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +		/* must be a valid type ID */
> +		t = btf__type_by_id(btf, id);
> +		if (!t) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +		ids_map = &p->ids_map[id - btf->start_id];
> +		/* duplicate type IDs are not allowed */
> +		if (*ids_map) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +		len = btf_type_size(t);
> +		memcpy(nt, t, len);
> +		new_offs[i] = nt - new_types;
> +		*ids_map = btf->start_id + i;
> +		nt += len;
> +	}

[ ... ]

> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{
> +	struct btf_permute *p = ctx;
> +	__u32 new_type_id = *type_id;
> +
> +	/* skip references that point into the base BTF */
> +	if (new_type_id < p->btf->start_id)
> +		return 0;
> +
> +	new_type_id = p->ids_map[*type_id - p->btf->start_id];
> +	if (new_type_id > BTF_MAX_NR_TYPES)
> +		return -EINVAL;
> +
> +	*type_id = new_type_id;
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19137195500

--===============8769320570170703310==--

