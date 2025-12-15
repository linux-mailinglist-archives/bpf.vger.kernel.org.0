Return-Path: <bpf+bounces-76603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B34CBD316
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48A373017071
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752632AAB0;
	Mon, 15 Dec 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBN/sYn/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFF329E6F;
	Mon, 15 Dec 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791503; cv=none; b=l4FE9YeJYc67rgjHf0qvu3mWnDN6xgj4f4HHfxm5N0obEy3Zv2uNSexZ9Q8f/W6eJ/igeRM+qAmQWrvmfTH9xRLHeOND+w7aSFj9N+OKXK3UWuc4DiRF3LDVOTZUgyunDcX/GJcklIoBczowq/l8koHC8X/Ca+T7vut7IxN7zpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791503; c=relaxed/simple;
	bh=eEugN3BdMP8sna/dDhqwJq//y9SVssdoij/5Lf/OS/g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EG+Ud1J3SLhbIO/7UmXpE4CEgJN8JbH/3P8DszqYThbQh1eM2c57Nr+yJ0ArWfmTB2GgXDF07NqNY0weBOR9F3y5u5ESPWRYgtGbpTlLKgnNhR8A2+SKCi6p5UP/lxNI5oFpHaugrUiOFobIzj6dS8FSY9gbJFVZYhJziiteJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBN/sYn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D47C4CEFB;
	Mon, 15 Dec 2025 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791503;
	bh=eEugN3BdMP8sna/dDhqwJq//y9SVssdoij/5Lf/OS/g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qBN/sYn/LWcXoMIE0C3T86S4KVUO27aza+gf/kyDXlwA2xbmkGUqK+swj2XVN1uCW
	 blWfBNeMquVxVH6sCTGWWcqSNQNf0o0Dh3ba4fysARxeJt++7ubTmlSQjucK6gFpJ+
	 qS44E+l7kFBTHWP4kSDV1s/3WDjg4PHMtGnJFZge1Oxpz4O1iGyYxQdsHLoy6Ewrxd
	 tBOeB/I0iiUqgn1BDPgvwTuiTrGCkT+m+CGJCdHVB6mPNBF2IAMAiPI2AoXooRRRwD
	 ngflj1xwtINvGnlRK10I/9X+qY74jZS6uxQDlltRYZfUKd8ut3ufi/GmsoyGvEz96Z
	 RSdqYUnNpy6Pg==
Content-Type: multipart/mixed; boundary="===============4491836444337585209=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d965ba27da4b59ef69f94b335575827debba459e27c86a10e63d5edeeb155e97@mail.kernel.org>
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
References: <20251215091730.1188790-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,mykyta.yatsenko5@gmail.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 09:38:22 +0000 (UTC)

--===============4491836444337585209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..8835aee6ee84 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -214,7 +232,7 @@ static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
>  	return 0;
>  }
>
> -static void btf_bswap_hdr(struct btf_header *h)
> +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
>  {
>  	h->magic = bswap_16(h->magic);
>  	h->hdr_len = bswap_32(h->hdr_len);
> @@ -222,54 +240,87 @@ static void btf_bswap_hdr(struct btf_header *h)
>  	h->type_len = bswap_32(h->type_len);
>  	h->str_off = bswap_32(h->str_off);
>  	h->str_len = bswap_32(h->str_len);
> +	/* May be operating on raw data with hdr_len that does not include below fields */
> +	if (hdr_len >= sizeof(struct btf_header)) {
> +		h->kind_layout_off = bswap_32(h->kind_layout_off);
> +		h->kind_layout_len = bswap_32(h->kind_layout_len);
> +	}
>  }
>
>  static int btf_parse_hdr(struct btf *btf)
>  {
> -	struct btf_header *hdr = btf->hdr;
> +	struct btf_header *hdr = btf->raw_data;
> +	__u32 hdr_len = hdr->hdr_len;
>  	__u32 meta_left;
>
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}
>
>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian = true;
> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> +		hdr_len = bswap_32(hdr->hdr_len);
> +		if (hdr_len < offsetofend(struct btf_header, str_len)) {
>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
> -				bswap_32(hdr->hdr_len));
> +				hdr_len);
>  			return -ENOTSUP;
>  		}
> -		btf_bswap_hdr(hdr);
> +		btf_bswap_hdr(hdr, hdr_len);
                       ^^^

Does this result in hdr->hdr_len being double-swapped? In the swapped
endianness path, hdr_len is set to bswap_32(hdr->hdr_len) and then
btf_bswap_hdr() is called, which does h->hdr_len = bswap_32(h->hdr_len)
again. This means hdr->hdr_len in the structure ends up with its original
(incorrect) endianness while the local hdr_len variable has the correct
swapped value.

Later code then copies the incorrectly-swapped header into btf->hdr:

>  	}
>
> -	if (btf->raw_size < hdr->hdr_len) {
> +	if (btf->raw_size < hdr_len) {
>  		pr_debug("BTF header len %u larger than data size %u\n",
> -			 hdr->hdr_len, btf->raw_size);
> +			 hdr_len, btf->raw_size);
>  		return -EINVAL;
>  	}

[ ... ]

> +	/* At this point, we have basic header information, so allocate btf->hdr */
> +	btf->hdr = calloc(1, sizeof(struct btf_header));
> +	if (!btf->hdr) {
> +		pr_debug("BTF header allocation failed\n");
> +		return -ENOMEM;
> +	}
> +	memcpy(btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));
                           ^^^

The memcpy copies from hdr, which contains the double-swapped (therefore
incorrect) hdr_len field. So btf->hdr->hdr_len will have the wrong
endianness when btf_parse_hdr() returns. This affects subsequent pointer
arithmetic like:

    btf->types_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->type_off

causing types_data to point to the wrong location when loading BTF with
non-native endianness.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20226997366

--===============4491836444337585209==--

