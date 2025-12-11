Return-Path: <bpf+bounces-76484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F4CB69F6
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 18:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A3E300DA61
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ED03126A2;
	Thu, 11 Dec 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3hP/GPI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA127A10F;
	Thu, 11 Dec 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472879; cv=none; b=K7le7yhdDneQXBuOq8Z5xov3rGBdjjVie/u/yA9e2OSU+IoSzpmtudVf8ZhHujzp9+E9Uh/ydI3UWLueoiYADq8oSffaYyC0//2dnCvPD7GWXjqjkXndPdckwQQJNLBmHOkEWFBRGgRva8h1z6iM9OylhJzdOV28D80kg+4jR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472879; c=relaxed/simple;
	bh=DudJApjLUoTmAj5cvkDfymYrjho3T6TE9VYl/7AVy4Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qi9I0JfDASSmU2Iu4VelQFTiCB/tg+p4hWgqKHYQxYuQudHic0LkmtLifv828wwjb1jWdVjun/aS6YZqSZWMy1vAvrhqAUNITAnjixugguI4LcLInOKhXk7ZBXYbqz4NK3GFph9F6f9w9Jg13OV40qPBSsEKFsBdnA+sFXOYTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3hP/GPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29963C4CEF7;
	Thu, 11 Dec 2025 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765472878;
	bh=DudJApjLUoTmAj5cvkDfymYrjho3T6TE9VYl/7AVy4Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G3hP/GPIlGudXfCyI77zr/fm8azc/l4eVsjjajJmeFkZn6MlwBkrzTkzhZcgFKIUR
	 NqEcdRqOnns4E3WdmNuJwTqFsbjMH55ecKYTEyQGNMahbUtRy1bOGljXdEwH/BeFOP
	 Mcqm1bs/RbrX0ub03WbP97YQ9/fDwRjtdLFV0UHmkWQ/XTyPrMc6IXRcqzQa0UZfeO
	 zFOx2k/c9/S4OB5sitTko5QJCyHnc5lORG2UcQd4GNP44nz1l4EVmPk+xfHp1RQmiU
	 6JGvEtFpidCYFqlqVcPqtJ3U1H9ClhgBJT4xMeupMLaj7zgbK7PxyUCuhoomrCInex
	 /4wndp3ELH+yQ==
Content-Type: multipart/mixed; boundary="===============8490203888914503827=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c051f3dfd97b289e23bd9a04cb33f8ad8a40a425e7a5d4c98bf04329f74b7f33@mail.kernel.org>
In-Reply-To: <20251211164646.1219122-3-alan.maguire@oracle.com>
References: <20251211164646.1219122-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v7 bpf-next 02/10] libbpf: Support kind layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 11 Dec 2025 17:07:57 +0000 (UTC)

--===============8490203888914503827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..531089a64adc 100644
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
> @@ -222,54 +240,89 @@ static void btf_bswap_hdr(struct btf_header *h)
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
>  	} else if (hdr->magic != BTF_MAGIC) {
>  		pr_debug("Invalid BTF magic: %x\n", hdr->magic);
>  		return -EINVAL;
>  	}
>
> -	if (btf->raw_size < hdr->hdr_len) {
> +	if (btf->raw_size < hdr_len) {
>  		pr_debug("BTF header len %u larger than data size %u\n",
> -			 hdr->hdr_len, btf->raw_size);
> +			 hdr_len, btf->raw_size);
>  		return -EINVAL;
>  	}
>
> -	meta_left = btf->raw_size - hdr->hdr_len;
> -	if (meta_left < (long long)hdr->str_off + hdr->str_len) {
> +	/* At this point, we have basic header information, so allocate btf->hdr */
> +	btf->hdr = calloc(1, sizeof(struct btf_header));
> +	if (!btf->hdr) {
> +		pr_debug("BTF header allocation failed\n");
> +		return -ENOMEM;
> +	}
> +	if (btf->swapped_endian)
> +		btf_bswap_hdr(hdr, hdr_len);
                    ^^^
Can this segfault on mmap'd BTF data?  In btf_parse_raw_mmap(), the BTF
file is mmap'd with PROT_READ (read-only), then btf_new() is called with
is_mmap=true.  The hdr pointer here points to btf->raw_data which is the
mmap'd read-only memory.  When btf_bswap_hdr() attempts to write to hdr
(swapping the header fields in-place), it will write to read-only memory.

This differs from the old code which rejected swapped-endian BTF with
the old strict header size check.  Now that the header size check is
relaxed to support kind layout, swapped-endian BTF from mmap becomes
accessible but crashes.

Call chain: btf__parse_raw()->btf_parse_raw_mmap() mmaps PROT_READ at
mmap() call, then btf_new(..., true) sets btf->raw_data to mmap'd
memory, then btf_parse_hdr() attempts to write to it.

> +	memcpy(btf->hdr, hdr, hdr_len < sizeof(struct btf_header) ? hdr_len :
> +								    sizeof(struct btf_header));

[ ... ]

> @@ -1550,6 +1629,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
>  	}
>
>  	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
> +	if (btf->kind_layout) {
> +		data_sz = roundup(data_sz, 4);
> +		data_sz += hdr->kind_layout_len;
> +		hdr->kind_layout_off = roundup(hdr->type_len + hdr->str_len, 4);
                                ^^^^^^^^^^^^^^^^^^^^
Should btf_get_raw_data() modify btf->hdr->kind_layout_off?  The hdr
pointer is btf->hdr, so this modifies the BTF object's header.  The
function signature takes const struct btf *btf_ro, suggesting the object
shouldn't be modified.  If btf__raw_data() is called multiple times,
kind_layout_off could potentially be set to different values on each
call, or if the BTF was originally loaded with kind_layout at a
different offset, that information is lost.

> +	}
>  	data = calloc(1, data_sz);
>  	if (!data)
>  		return NULL;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20140850025

--===============8490203888914503827==--

