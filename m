Return-Path: <bpf+bounces-76438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18804CB400D
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86EB3302EDEE
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667A329E6C;
	Wed, 10 Dec 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og/3Solb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5B19CD06;
	Wed, 10 Dec 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400151; cv=none; b=Wxr4ZaBqXayK33PbcNFhvzSPKQiQ3ISjFx5hsQlonKFWxKv7slGuR10GcvytTsW1fKffA/e71NoHbqf7aPM2a7gEKOgaxGm7xHBWuuIDwauAVh9W2p2SlOjZhann8tf3LyiTfFectQ0FDGSMpAdAq4tNRGYqKAsQIHRIt8s57kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400151; c=relaxed/simple;
	bh=KKbCM1X1uJIYT0yRGVwubbPCy4FEOJ00Su6v87bjJYE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FIFGUHpsXLu6R10UpmIvsnZVXOBwhqqBPGbuzeJZU2CBFxEI3LDcOgAVL8B/WhiCEzxH5Alvip7mULkTNVKy2m4n1fZkw67d/1+vmI1fjZlEeN7uxEOOBVPKIA2cr9wZF+4+BVnLC5q7nZF+HlUqbLitKFA1oy/WGcLhU75V45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og/3Solb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBEAC116B1;
	Wed, 10 Dec 2025 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400149;
	bh=KKbCM1X1uJIYT0yRGVwubbPCy4FEOJ00Su6v87bjJYE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=og/3SolbpqGz++1W9K2fYxhM/CTQionIWCnfKrwfa4xFy7X4uRJE9BKrkJRI/yTgw
	 NFS3QWHC1nKed7IEPhvbyjzp7rmzPEzgZfxE1pZFztDcVCEpYONHdZF1He+SEKyrwP
	 4DYJZ+aLBca6Hl+VoB2MpEDRX2DXf2oTsVPk9Tzh40EutrJeB+XQi9WQvrJ6sFadwP
	 bX+PelxDv9EBawVuD+IKPPdZyUFUGwCnCFfsVyxinL6Fo7xV2pXlHV3Ony2p1KTQ2Y
	 um8KZGq53l9PUs3vV1lVSQrpsVApplUnWdOay6SqrjwWTmwdvNX/0Adx4jT0RximJp
	 kLZ01wG7XccfQ==
Content-Type: multipart/mixed; boundary="===============6499341889599721231=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <feaff1feac98ab8a9ad99b7310883c58c5253950417b1332afc21ad22ffb0a95@mail.kernel.org>
In-Reply-To: <20251210203243.814529-9-alan.maguire@oracle.com>
References: <20251210203243.814529-9-alan.maguire@oracle.com>
Subject: Re: [PATCH v6 bpf-next 08/10] bpftool: add BTF dump "format meta" to dump header/metadata
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Dec 2025 20:55:47 +0000 (UTC)

--===============6499341889599721231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 53bcfeb1a76e..a331172cf8de 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool

[ ... ]

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..028448c0c7a0 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -835,6 +835,85 @@ static int dump_btf_c(const struct btf *btf,
>  	return err;
>  }
>
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +	const struct btf_header *hdr;
> +	const struct btf_kind_layout *k;
> +	__u8 i, nr_kinds = 0;
> +	const void *data;
> +	__u32 data_sz;
> +
> +	data = btf__raw_data(btf, &data_sz);
> +	if (!data)
> +		return -ENOMEM;
> +	hdr = data;
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);		/* metadata object */
> +		jsonw_uint_field(json_wtr, "size", data_sz);
> +		jsonw_name(json_wtr, "header");
> +		jsonw_start_object(json_wtr);		/* header object */
> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +		jsonw_uint_field(json_wtr, "version", hdr->version);
> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
> +	} else {
> +		printf("size %-10u\n", data_sz);
> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10u\n",
> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
> +		printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len, hdr->type_off);
> +		printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hdr->str_off);
> +	}
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
> +		if (json_output) {
> +			jsonw_end_object(json_wtr);	/* end header object */
> +			jsonw_end_object(json_wtr);	/* end metadata object */
> +		}
> +		return 0;
> +	}
> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
> +		k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
                    ^^^^

Can this read out of bounds? The code checks that kind_layout_len and
kind_layout_off are positive, but doesn't validate that hdr->hdr_len +
hdr->kind_layout_off + hdr->kind_layout_len stays within data_sz. If a
malformed BTF file has kind_layout_off pointing beyond the buffer, the
subsequent k[i] accesses could read past the end of the buffer.

This same calculation appears in libbpf's btf_parse_kind_layout_sec()
without bounds checking, suggesting the validation gap exists at the
parsing layer.

> +		nr_kinds = hdr->kind_layout_len / sizeof(*k);
> +	}
> +	if (json_output) {
> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
> +		jsonw_end_object(json_wtr);		/* end header object */
> +
> +		if (nr_kinds > 0) {
> +			jsonw_name(json_wtr, "kind_layouts");
> +			jsonw_start_array(json_wtr);
> +			for (i = 0; i < nr_kinds; i++) {
> +				jsonw_start_object(json_wtr);
> +				jsonw_uint_field(json_wtr, "kind", i);
> +				if (i < NR_BTF_KINDS)
> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
> +				else
> +					jsonw_null_field(json_wtr, "name");
> +				jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
> +				jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
                                                                         ^^^^

The k[i] accesses here will read from the out-of-bounds pointer if
kind_layout_off was invalid.

> +				jsonw_end_object(json_wtr);
> +			}
> +			jsonw_end_array(json_wtr);
> +		}
> +		jsonw_end_object(json_wtr);		/* end metadata object */
> +	} else {
> +		printf("kind_layout_len %-10u\nkind_layout_off %-10u\n",
> +		       hdr->kind_layout_len, hdr->kind_layout_off);
> +		for (i = 0; i < nr_kinds; i++) {
> +			printf("kind %-4d %-10s info_sz %-4d elem_sz %-4d\n",
> +			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
> +			       k[i].info_sz, k[i].elem_sz);
                               ^^^^

Same out-of-bounds read in the plain text output path.

> +		}
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20112692486

--===============6499341889599721231==--

