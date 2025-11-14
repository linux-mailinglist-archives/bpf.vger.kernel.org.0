Return-Path: <bpf+bounces-74496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D636C5C77F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AE544F80B5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69223081B2;
	Fri, 14 Nov 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jthHnMIp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FBB2FDC50;
	Fri, 14 Nov 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113649; cv=none; b=VJ43YD2hOxVhXzh5v620lcMUS0QKRCNwoWGhp5SqMLFyJowWW4W0pKo4X7eyH1DhZr8Om46mZJVm3I+BNIyngYlG5v73AiLd39MMVvA6f4/Pbtu1B+PbzVTBf2z/Qs+WBO6n1Ju4jZrryL/w1N4Y5AHa7kHivYTg85PO+Kwcd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113649; c=relaxed/simple;
	bh=X8Y5j2D4oavP62BIlUPLmipqYyyL03jwOIVskNNP3SU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UKr5hUwP7HwJbguely3SytsK+UOnJX9XWuRWWGHfpOt0Ara0E9O18LxpSF37zQSfuw1OXS+uAn3r7YeQoeCNvYngjXxPxAiODfbR5/w7Yyo7iPUyqGYuCmhXcb9si8cji3mZIo/wYvZASyFWOkK+0/8d8lZC4CrKhIYjWo8oBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jthHnMIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEBBC4CEF1;
	Fri, 14 Nov 2025 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763113648;
	bh=X8Y5j2D4oavP62BIlUPLmipqYyyL03jwOIVskNNP3SU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jthHnMIp8+vUaiTA2usCXF0EEbtuJ886noIxYObwMFwJ6DYEboiHO8Ax9Ut+t4IT0
	 c1FpS8eAtr2z/2MQVEH8iyqKSle21MRDl7+v1JOCIZS5Ag2WkeqtVFldzC4B11Aq3v
	 q1Jt5eoYIaOwGi9k7hfrdllet0mMaCjsWUY6MKg/PUv5wW5C5SoI0cZYK3wakcPUvZ
	 7B2j3bwnjPeyUPTX+BGWOcizwGIjRmDL7TOCXaHQH/IqX+il3Pm09H2U+mlW9xJeMv
	 J2aVesFKNbK4jmvYOSpElO0+8hBnFYiRB4zzFmDV81NUc2L/xrgwfEujbyxgSHcaIl
	 Escj38esS+Y5g==
Content-Type: multipart/mixed; boundary="===============3734957261837909528=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8afe4009725d807dde7ec1d7734005bd9bfe44fcd2ea18178dae9be99b3759ad@mail.kernel.org>
In-Reply-To: <20251114090231.2786984-2-dolinux.peng@gmail.com>
References: <20251114090231.2786984-2-dolinux.peng@gmail.com>
Subject: Re: [RFC PATCH 1/2] libbpf: Add BTF permutation support for type reordering
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,zhangxiaoqin@xiaomi.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,pengdonglin@xiaomi.com,alan.maguire@oracle.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 09:47:28 +0000 (UTC)

--===============3734957261837909528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9f141395c..de3aa62fd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5829,3 +5829,189 @@ int btf__relocate(struct btf *btf, const struct btf *base_btf)
>  		btf->owns_base = false;
>  	return libbpf_err(err);
>  }
> +
> +struct btf_permute {
> +	struct btf *btf;
> +	__u32 *id_map;
> +	__u32 offs;
> +};
> +
> +/* Callback function to remap individual type ID references */
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{

[ ... ]

> +int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
> +		 const struct btf_permute_opts *opts)
> +{
> +	struct btf_permute p;
> +	struct btf_ext *btf_ext;
> +	void *next_type, *end_type;
> +	void *nt, *new_types = NULL;
> +	int err = 0, n, i, new_type_len;
> +	__u32 *order_map = NULL;
> +	__u32 offs, id, new_nr_types = 0;
> +
> +	if (btf__base_btf(btf)) {
> +		/*
> +		 * For split BTF, the number of types added on the
> +		 * top of base BTF
> +		 */
> +		n = btf->nr_types;
> +		offs = btf->start_id;
> +	} else if (id_map[0] != 0) {
> +		/* id_map[0] must be 0 for base BTF */
> +		err = -EINVAL;
> +		goto done;
> +	} else {
> +		/* include VOID type 0 for base BTF */
> +		n = btf__type_cnt(btf);
> +		offs = 0;
> +	}
> +
> +	if (!OPTS_VALID(opts, btf_permute_opts) || (id_map_cnt != n))
> +		return libbpf_err(-EINVAL);
> +
> +	/* used to record the storage sequence of types */
> +	order_map = calloc(n, sizeof(*id_map));
> +	if (!order_map) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	new_types = calloc(btf->hdr->type_len, 1);
> +	if (!new_types) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	if (btf_ensure_modifiable(btf)) {
> +		err = -ENOMEM;
> +		goto done;
> +	}
> +
> +	for (i = 0; i < id_map_cnt; i++) {
> +		id = id_map[i];
> +		/*
> +		 * 0: Drop the specified type (exclude base BTF type 0).
> +		 * For base BTF, type 0 is always preserved.
> +		 */
> +		if (id == 0)
> +			continue;
> +		/* Invalid id  */
> +		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
> +			err = -EINVAL;
> +			goto done;
> +		}
> +		id -= offs;
> +		/* Multiple types cannot be mapped to the same ID */
> +		if (order_map[id]) {
> +			err = -EINVAL;
> +			goto done;
> +		}
> +		order_map[id] = i + offs;
> +		new_nr_types = max(id + 1, new_nr_types);
> +	}
> +
> +	/* Check for missing IDs */
> +	for (i = offs ? 0 : 1; i < new_nr_types; i++) {
> +		if (order_map[i] == 0) {
> +			err = -EINVAL;
> +			goto done;
> +		}
> +	}
> +
> +	p.btf = btf;
> +	p.id_map = id_map;
> +	p.offs = offs;
> +	nt = new_types;
> +	for (i = offs ? 0 : 1; i < new_nr_types; i++) {
> +		struct btf_field_iter it;
> +		const struct btf_type *t;
> +		__u32 *type_id;
> +		int type_size;
> +
> +		id = order_map[i];
> +		/* must be a valid type ID */
> +		t = btf__type_by_id(btf, id);
> +		if (!t) {
> +			err = -EINVAL;
> +			goto done;
> +		}
> +		type_size = btf_type_size(t);
> +		memcpy(nt, t, type_size);
> +
> +		/* Fix up referenced IDs for BTF */
> +		err = btf_field_iter_init(&it, nt, BTF_FIELD_ITER_IDS);
> +		if (err)
> +			goto done;
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			err = btf_permute_remap_type_id(type_id, &p);
> +			if (err)
> +				goto done;
> +		}
> +
> +		nt += type_size;
> +	}
> +
> +	/* Fix up referenced IDs for btf_ext */
> +	btf_ext = OPTS_GET(opts, btf_ext, NULL);
> +	if (btf_ext) {
> +		err = btf_ext_visit_type_ids(btf_ext, btf_permute_remap_type_id, &p);
> +		if (err)
> +			goto done;
> +	}
> +
> +	new_type_len = nt - new_types;
> +	next_type = new_types;
> +	end_type = next_type + new_type_len;
> +	i = 0;
> +	while (next_type + sizeof(struct btf_type) <= end_type) {
> +		btf->type_offs[i++] = next_type - new_types;
> +		next_type += btf_type_size(next_type);
> +	}
> +
> +	/* Resize */
> +	if (new_type_len < btf->hdr->type_len) {
> +		void *tmp_types;
> +
> +		tmp_types = realloc(new_types, new_type_len);
> +		if (new_type_len && !tmp_types) {
> +			err = -ENOMEM;
> +			goto done;
> +		}
> +		new_types = tmp_types;
> +		btf->nr_types = new_nr_types - (offs ? 0 : 1);
> +		btf->type_offs_cap = btf->nr_types;
> +		btf->types_data_cap = new_type_len;
> +		btf->hdr->type_len = new_type_len;
> +		btf->hdr->str_off = new_type_len;
> +		btf->raw_size = btf->hdr->hdr_len + btf->hdr->type_len + btf->hdr->str_len;
> +	}
> +	free(btf->types_data);
> +	btf->types_data = new_types;
> +	return 0;

Does this leak order_map on the success path? It looks like order_map is
allocated above and freed only in the error path at the done label, but
the success path returns here without freeing it.

> +
> +done:
> +	free(order_map);
> +	free(new_types);
> +	return libbpf_err(err);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19359945665

--===============3734957261837909528==--

