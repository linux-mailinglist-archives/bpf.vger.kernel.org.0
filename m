Return-Path: <bpf+bounces-76602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C0CBD30F
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0947E3016C6C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6B289824;
	Mon, 15 Dec 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbKrqdN0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB9315D50;
	Mon, 15 Dec 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791502; cv=none; b=K1EdLKxT8/Houl2VOsjh4SyOyCprMat5LQx6xj1Oh/9kstYUA36R+VjGM0z5IWEjwIA98DIDjIC4CT8IjILLQpbyAd46ZwhctROS9ATB9gGbLktNaYUmz9A00Y4BYOrxNmZNoGqdRaIuqzhpducMoNKchXbkuTHUolawkG1BAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791502; c=relaxed/simple;
	bh=yt+469yfmAuLABFynjtgGbbfLtjpClR6qKWwdhqni84=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f9cEzoH9yAImEZawW7vJdQ9YARfmGCEgFxrXKWKKlO9DfI3j213cRVRFy3Yk4tuc8rhswwr3HAj2uXlf/DvllkysZ0Y8ECc23Ohmbt2952gWBTaPiJd2JMc25Y70Tvien78tHGoRzutxlOYrSSbgk9DHGe1dkiAalrkIK/n17sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbKrqdN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AB0C19425;
	Mon, 15 Dec 2025 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791501;
	bh=yt+469yfmAuLABFynjtgGbbfLtjpClR6qKWwdhqni84=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sbKrqdN0Ei+1nv4OM2x70oQh4tYxtvBCvvjhkSGDv/eOJhYgt0+v2LcZ+hjM11chR
	 EUm0cyZQQ3f1/tbKUyh7j08n+Tan9feEZG/EvdNR6p/xjIAHvQY0BFJ94ni4PJYHof
	 Cll9t4nwrtpYRhhyOEfexAz1UfWLWxY/o/LzovWwMZlqYEP5k6gpKcU2l+/dNZ9kzW
	 xH15Dbk7YbL2ACH2qOyBgJXJxVncCJKqScOcECu9RXMpdwkZizvxQNyF1Biw7TILwU
	 lsk6l5jrTurg4CySXzm6Bp9A8FnAGBjsXaZWsPH1MgB4SPB9knltcjA+4bwVCGP+uy
	 IpwYBsz1E1img==
Content-Type: multipart/mixed; boundary="===============3842367936751581720=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96af5bdd4d68c9e912257697f82b815c4926930874fc707b559aa0dfbcd35a64@mail.kernel.org>
In-Reply-To: <20251215091730.1188790-2-alan.maguire@oracle.com>
References: <20251215091730.1188790-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,mykyta.yatsenko5@gmail.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 09:38:21 +0000 (UTC)

--===============3842367936751581720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..c1854a1c7b38 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,15 @@
>  #define BTF_MAGIC	0xeB9F
>  #define BTF_VERSION	1
>
> +/*
> + * kind layout section consists of a struct btf_kind_layout for each known
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
> @@ -19,6 +28,8 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	__u32	kind_layout_off;/* offset of kind layout section */
> +	__u32	kind_layout_len;/* length of kind layout section */
>  };

This adds two new __u32 fields to struct btf_header, growing it from 24
to 32 bytes. When BTF data needs to be byte-swapped for cross-endian
parsing, these new fields also need byte-swapping.

Looking at tools/lib/bpf/btf.c::btf_bswap_hdr() (not shown in this
UAPI-only patch), the function swaps magic, hdr_len, type_off, type_len,
str_off, and str_len, but the new kind_layout_off and kind_layout_len
fields are not present in the swapping logic. Will cross-endian BTF files
with kind layout sections fail to parse correctly in libbpf?

Note: This issue was fixed in the follow-up commit 16346d216f9b
("libbpf: Support kind layout section handling in BTF") which added
conditional byte-swapping for the new fields.

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c07..c1854a1c7b38 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h

[ ... identical change to tools copy ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20226997366

--===============3842367936751581720==--

