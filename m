Return-Path: <bpf+bounces-76436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABAECB400A
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBD28300A222
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D433305E01;
	Wed, 10 Dec 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVjqNqhh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83E326955;
	Wed, 10 Dec 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400143; cv=none; b=E0MbA4RH/9O15XS9jtZdU9Keu+NzKh6ZvHJKY8X3A1L5jUidvF8OwCftbYODCLXEMLXFXXIQdSGnnpmCwr9V6r0+KNRUesksYRmx414tL0+hDGwpVj/azPWUnuHaSzLFQ7KHzM6wkN19IJN0qkRQKZ+gai+hzdtCv8ajRlU0EK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400143; c=relaxed/simple;
	bh=0pZvtcXVveauFf03C/ROlYv7IpcEC0ZuzrxqDjQe5Ic=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZDbP2sByF8sWgJ/k3bMU/Tl65aew3xhsrwBo2nq0GTmEd2ZADnnV19wZWe2/S/XtVXRF5P8KHh4fCrghVvkDlu/FIOSGZ3nOhI+H0oXvI6KJQVK3wscLbWoQEWTZx52wMITpCt0wXn9VAigpxlaGFVJxWywKDtAsflmylY1ZqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVjqNqhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C6C4CEF1;
	Wed, 10 Dec 2025 20:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400142;
	bh=0pZvtcXVveauFf03C/ROlYv7IpcEC0ZuzrxqDjQe5Ic=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fVjqNqhhOjo/KsG6xRBtiZlb1Q6okXRmOCZvGFQ3NWr6xXNWzWzX3epsD7yI73OYs
	 hnCtU2VPy8bMIdrBZXzt6Tz7HxuyCtsDxLD4KGPfQamdnKeGkQLV+AfR+jZHlAJCT7
	 t82fdbXGsG+K0e/cCD2eH/JGDVX+A2oK83QXb+hGpo9mIKXCDeak9RtYKcx8LSm27r
	 OoGH4QIJ+EHCZTFMKNr6gyQwdT6N1m29QoEGKVPLzC2LLJFe42Is6XRwrFwfjm3bGR
	 QgcKRKBwWa6sjGJGx73IvDEzuJYWUu+EgtijsgYe8Du7NFWX1jBJuqKZRTe2vSjHb6
	 c36gE7mqKfsRQ==
Content-Type: multipart/mixed; boundary="===============1158128993824160785=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e0f6354688867327290334013a595b8d548820a7d374cbe607a86cc5bedf293@mail.kernel.org>
In-Reply-To: <20251210203243.814529-5-alan.maguire@oracle.com>
References: <20251210203243.814529-5-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 04/10] libbpf: Add kind layout encoding support
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:40 +0000 (UTC)

--===============1158128993824160785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 4eb0704a0309..2133e976cb9c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> -static struct btf *btf_new_empty(struct btf *base_btf)
> +static struct btf *btf_new_empty(struct btf_new_opts *opts)
>  {
> +	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
>  	struct btf_header *hdr;
>  	struct btf *btf;
>
> @@ -1111,6 +1141,17 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>  		free(btf);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +
> +	if (opts->add_kind_layout) {

Can opts be NULL here? The OPTS_VALID() check in btf__new_empty_opts()
returns true when opts is NULL (!(opts) evaluates to true), so this code
could dereference NULL. Should this use OPTS_GET(opts, add_kind_layout,
false) instead?

> +		hdr->kind_layout_len = sizeof(kind_layouts);
> +		btf->kind_layout = malloc(hdr->kind_layout_len);
> +		if (!btf->kind_layout) {
> +			free(btf->hdr);
> +			free(btf);
> +			return ERR_PTR(-ENOMEM);
> +		}

Does this error path leak btf->raw_data? It was allocated earlier via
calloc() but isn't freed here, while btf->hdr is freed. The same issue
appears in the error path above at the check "if (!btf->hdr)" where
btf->raw_data is also not freed.

> +		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
> +	}
>  	memcpy(btf->hdr, hdr, sizeof(*hdr));
>
>  	return btf;

Also, when a BTF object is created via btf_new_empty() with
add_kind_layout=true, btf->kind_layout is allocated but btf->modifiable
remains false (never set to true). Later, when btf__free() is called, it
only frees btf->kind_layout if btf_is_modifiable() returns true (checking
the modifiable flag). Does this leak the kind_layout allocation for BTF
objects created with btf__new_empty_opts()?

> @@ -1118,12 +1159,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)

[ ... ]

> +struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
> +{
> +	if (!OPTS_VALID(opts, btf_new_opts))
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	return libbpf_ptr(btf_new_empty(opts));
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============1158128993824160785==--

