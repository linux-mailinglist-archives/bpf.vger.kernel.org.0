Return-Path: <bpf+bounces-76437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815ECB4028
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB25A303FE0C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F16329C55;
	Wed, 10 Dec 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhYoprTV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496E324714;
	Wed, 10 Dec 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400146; cv=none; b=UX9SSQ9iuPLi70X54WAn9MheQMRsnfWIefWgL/SI4BlwuzZIDgs7J0yfnRIn7xLMvCqdEjgZMiEggloqDK3Oi616+gBaA3XsFbkqE93CeAzNPGfKEHYtZm2LkWO/nCKXvL0CvNZbL5XKCu2CiGjjt8zE8kImHSAoaWudph0Cq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400146; c=relaxed/simple;
	bh=gN81/HUjwP0ji572ft37uo7nLxaZs8wWeh9Y6iSQHmU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b51QOEmoCMtmU4JNsGoMxw4DI24RSw3BYGU5V2iG0CVVqZsSxvmGc92pE+Z2njj+xrMSGbGM+RfRk4W/k/SJTC1m/2DITgqhMvrevroU5gCPGOshsI7pmznxlHpKkPgNUs73ppmP098PW5laEOv013sWZIrkdp5jq2VhsUPomNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhYoprTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF66C4CEF1;
	Wed, 10 Dec 2025 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400146;
	bh=gN81/HUjwP0ji572ft37uo7nLxaZs8wWeh9Y6iSQHmU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rhYoprTVsYMBI+jkLvt1CGxiKlATHBC5gxYDCeF3aEl3SbhqEKV4Y3/1i4cpA4Jx9
	 Tqwqxz66Jw1uJ/RI3fqCf353fzK9eO1QOSWg9R1cdXoLzbRD8n3I+s7K6mn89rTbiQ
	 dglozsFfz5VWgAFnMa2CMGsCaI0DffuvcUFMoyjlz1bcRqI7xejI/GT9kuPvliNGO8
	 qG3d6UTXMFrhen9y4l7iDmFsuXg+qkfosSdoRa0hMjZBDnpbqsggM65x7YHv3bM+b7
	 CkbREYwQKwsKqlucH530cZvzKPVa9Nz4rENubSvxvbYnqs8eApEX+qqUnaf9jAzWVX
	 e6X/0guzkibFA==
Content-Type: multipart/mixed; boundary="===============1159379565909165362=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6dcc4caa01eabb37a074ca584c6e9deac0e8ab217269dac8e2317a23c252f5c2@mail.kernel.org>
In-Reply-To: <20251210203243.814529-4-alan.maguire@oracle.com>
References: <20251210203243.814529-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 03/10] libbpf: use kind layout to compute an unknown kind size
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:44 +0000 (UTC)

--===============1159379565909165362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 737adc560818..4eb0704a0309 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
> +{
> +	int size = sizeof(struct btf_type);
> +	struct btf_kind_layout *k = NULL;
> +	__u16 vlen = btf_vlen(t);
> +	__u8 kind = btf_kind(t);
> +
> +	if (btf->kind_layout)
> +		k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
> +
> +	if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can the bounds check be moved before the array access?  Currently the code
indexes into kind_layout[kind] before validating whether 'kind' is within
bounds.  While computing an out-of-bounds pointer may not cause immediate
issues, the bounds check itself appears incorrect.

The check uses '>' which allows access when k points exactly to the end of
the array. For example, if kind_layout_len is 40 bytes (20 kinds * 2 bytes
each) and kind is 20, then k would point to offset 40, and the check
'(ptr at 40) > (ptr at 40)' evaluates to false, allowing the subsequent
read of k->info_sz at an out-of-bounds location.

Should this be: 'if (!btf->kind_layout || kind >= (btf->hdr->kind_layout_len
/ sizeof(*k)))'?  This would validate the index before the array access and
ensure the full structure can be read safely.

> +		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> +		return -EINVAL;
> +	}
> +
> +	size += k->info_sz;
> +	size += vlen * k->elem_sz;
> +
> +	return size;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============1159379565909165362==--

