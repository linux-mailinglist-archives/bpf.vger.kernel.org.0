Return-Path: <bpf+bounces-72333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3AEC0E687
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 15:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B98461D20
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CE3090CA;
	Mon, 27 Oct 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeYJg7rG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35961E32D6;
	Mon, 27 Oct 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574816; cv=none; b=m42hHoCITLDPxt3gSr+W43qnbsysmKrGOTutVj7r9hHsH4INLJiWps4t5Ft/bxH7z1Pec+m692Zkb6NqrSvvh05TRSLsXQ2h9h7o2wTM43ylSERn0mTUrGAuJJXtrzSf2bAjcVj/jgZ94R7zLo5wAwkCIndlIIalQEv8mQtw5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574816; c=relaxed/simple;
	bh=WvotowJYmjcG2tGRzmtuc8Os1u6jgZN0RM68zABwZL0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iRFKmB+LAZG+p++LfrG8VL36tkAPfge84xXTg+0xmxf0X9GYNLSo1tR5f/v1SlilFoVZsOwWgTSXqhEsZroLhsOv6KwgbQHaIbQvBYIztCv41lt+u6q3iI7v6b+HInEjFo0iWc0KB64uUK02beDs8fQjMEn9TufqaWDoNgfoDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeYJg7rG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D583C4CEF1;
	Mon, 27 Oct 2025 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574815;
	bh=WvotowJYmjcG2tGRzmtuc8Os1u6jgZN0RM68zABwZL0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XeYJg7rGs0ELts6mw/zdSWyLKVfRw2qbudo+DpXdXrTAbluh2Gh2WpXIhjkgkkZoZ
	 36hg9EYAwK5IULfAlnP6paOMGHgGT0sloRfLBbfGlfSCyJEj/IvDatKd3w4zh7TcDk
	 1EDJ6UeIWvjXjTAlMctjZMb4dzqONKB/3aoutMjj2GDnowZOlDYBQXyHUtO0Jhv1Kf
	 1V6hjKmQboe5TfpoUSDb6eYFM9smIdiuIkhc0zsKmewrKKhanczTZJBSwd4Uct3uKB
	 0Fe13+ANZvDbsbm83IpHwXNAuFCeFg0+hAVyCwq9B5uEkK+fIxN2PMwFEDHgsfIokT
	 mPME9CUzlZD/w==
Content-Type: multipart/mixed; boundary="===============5581349777016619937=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ce42cc0aa2dbb6414178fe6e848101b62c4094b0e27cd12e44c9f742f13718a@mail.kernel.org>
In-Reply-To: <20251027135423.3098490-2-dolinux.peng@gmail.com>
References: <20251027135423.3098490-2-dolinux.peng@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for accelerated lookups
From: bot+bpf-ci@kernel.org
To: dolinux.peng@gmail.com,ast@kernel.org
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,dolinux.peng@gmail.com,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,song@kernel.org,pengdonglin@xiaomi.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Oct 2025 14:20:14 +0000 (UTC)

--===============5581349777016619937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 1fada9fa20ae7a48b4ba2dd189d4d2dd29878ad2
Author: Donglin Peng <dolinux.peng@gmail.com>

btf: implement BTF type sorting for accelerated lookups

This patch introduces a new libbpf interface btf__permute() to reorganize
BTF types according to a provided mapping, with binary search capability
for accelerated lookups in large type sets.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fc..d20bf81a2 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> +/*
> + * Shuffle BTF types.
> + *
> + * Rearranges types according to the permutation map in p->ids. The p->map
> + * array stores the mapping from original type IDs to new shuffled IDs,
> + * which is used in the next phase to update type references.
> + */
> +static int btf_permute_shuffle_types(struct btf_permute *p)
> +{
> +	struct btf *btf = p->btf;
> +	const struct btf_type *t;
> +	__u32 *new_offs = NULL;
> +	void *l, *new_types = NULL;
> +	int i, id, len, err;
> +
> +	new_offs = calloc(btf->nr_types, sizeof(*new_offs));
> +	new_types = calloc(btf->hdr->type_len, 1);
> +	if (!new_types || !new_offs) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}

Can btf_permute_shuffle_types() leak new_offs? If the first calloc()
succeeds but the second fails, the function jumps to out_err which
returns without freeing new_offs.

> +
> +	l = new_types;
> +	for (i = 0; i < btf->nr_types; i++) {
> +		id = p->ids[i];
> +		t = btf__type_by_id(btf, id);

Can invalid type IDs from p->ids[] crash btf__type_by_id()? The ids
array comes from user input via btf__permute() opts, but there's no
validation that the IDs are within the valid range before passing them
to btf__type_by_id(). If a user provides an out-of-range type ID, this
could access invalid memory.

> +		len = btf_type_size(t);
> +		memcpy(l, t, len);
> +		new_offs[i] = l - new_types;
> +		p->map[id - btf->start_id] = btf->start_id + i;
> +		l += len;
> +	}
> +
> +	free(btf->types_data);
> +	free(btf->type_offs);
> +	btf->types_data = new_types;
> +	btf->type_offs = new_offs;
> +	return 0;
> +
> +out_err:
> +	return err;
> +}

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `btf: implement BTF type sorting for accelerated lookups`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18843706931

--===============5581349777016619937==--

