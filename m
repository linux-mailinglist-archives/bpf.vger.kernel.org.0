Return-Path: <bpf+bounces-76435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E4CB4025
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6051306DC92
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64B305E01;
	Wed, 10 Dec 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx3difso"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87D324707;
	Wed, 10 Dec 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400139; cv=none; b=IfslJju5MAF8pvpzVDC3zhlnTGsoeP6I3kCkpwSIFSp0szv4OoxCp9FDhKJ0Q5KOsfm/GgU+oQ5/qU8LEiOlM/FdkiF8SQu7umrAZarpI6eKGF/mZ2298Pp3hurssPX4ygmkYK0bZ+GaKyXfZ/N12sA+8gpJp2co/dPDdLYjcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400139; c=relaxed/simple;
	bh=+GRoqdUap/rMrlE4bEfAtd5QIqesUDCKJE7DhL90hic=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IQ3026wkg92gTOJ2lk2Vw5LCBxQbNv+aumBG+IK/s2GR8Fduu0YkT+Tvtl2CluildztJL/D9mChb4ft9C+BVHGBIsqv0k2tCIeCWy52t11nqXLTeuGPcLcNLuxA3c8/P7Dn+tm4jqCSINImh7w0lG8DxOOl6xbgIqAILicKrZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx3difso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1314EC4CEF1;
	Wed, 10 Dec 2025 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400138;
	bh=+GRoqdUap/rMrlE4bEfAtd5QIqesUDCKJE7DhL90hic=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Gx3difsoyEDMSu9qkEM0vIevvG9oUDXW7XghWP1VTz/rwwOjwW76NUxXpAVrUQgah
	 kJdVgdHgdA/404vM4xNyrDCU2lVCbr48pq4WKGRpCGBBmmBDLHgQW5CDhmx7C+2Grb
	 8BegqjeeQTtnSYrceJn1BK1/CwxhGZ3ZysShxrjKHq9pnsW0kO+INo4Y1p9WwaALzY
	 a8f50Ch0O1gS9/3JonXOBIhdejC7xDcJOtr7poYY6K1YlxIJNKW2bVNgZF++2JK9fB
	 lfCl2zDJzZhHMR4XcUNC0O//kBuescLZ3PzmiK977xbNuoA3rAQbjBIjYC60HJoxPT
	 HbPmNXvgaw7xg==
Content-Type: multipart/mixed; boundary="===============9057994685082376210=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70817209e536325d03acd4ab4e60e3de7c3210b4c30e7101299918f6da1c4f0e@mail.kernel.org>
In-Reply-To: <20251210203243.814529-2-alan.maguire@oracle.com>
References: <20251210203243.814529-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 01/10] btf: add kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:37 +0000 (UTC)

--===============9057994685082376210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..64dd681274f4 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,14 @@
>  #define BTF_MAGIC	0xeB9F
>  #define BTF_VERSION	1
>
> +/* kind layout section consists of a struct btf_kind_layout for each known
> + * kind at BTF encoding time.
> + */
> +struct btf_kind_layout {
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
>  struct btf_header {
>  	__u16	magic;
>  	__u8	version;
> @@ -19,6 +27,8 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
                             ^^^^

Adding these fields to struct btf_header expands it from 24 to 32 bytes.
This breaks compatibility in two ways without implementation support:

1. In kernel/bpf/btf.c, the btf_sec_info_offset[] array at
   btf_check_sec_info() only includes type_off and str_off, missing the
   new kind_layout_off. When btf_check_sec_info() validates sections, it
   checks that expected_total == total. If a BTF file contains a
   kind_layout section, the validation will fail with "Unsupported
   section found" and reject the BTF with -EINVAL.

   Can the kernel accept BTF files with kind_layout sections without
   updating btf_sec_info_offset[] to include the new field?

   Note: This is fixed in commit e82981d01e84 which adds kind_layout_off
   to the validation array.

2. In tools/lib/bpf/btf.c at btf_sanity_check(), when handling
   non-native endianness, there's an exact equality check:

     if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header))

   With sizeof(struct btf_header) now 32 bytes, this check will reject
   old BTF files with 24-byte headers. Does this break loading of
   existing BTF files that have non-native endianness?

   Note: This is fixed in commit a018196d8c9e which changes the check to
   a minimum size comparison instead of exact equality.

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============9057994685082376210==--

