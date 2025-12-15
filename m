Return-Path: <bpf+bounces-76604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58294CBD491
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4EA3022A89
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98193161AB;
	Mon, 15 Dec 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrAWxcuZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5C314B82;
	Mon, 15 Dec 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792335; cv=none; b=fJziBgoTC8VQl2mNc9zN0E1ow17+3HPs4fNGK1cFqLkoy3NyNfFsZiNxiXd0zVqNPdbZa9LcB8tRq8d4y4w4l3JFOag5tMkLXKqnnNcJSqQhC0Q38aVVl7o0LvLNRj4ifsjZLQkQYE/nl/tTpyY5wk/o6YahVFfMsArLfoLXoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792335; c=relaxed/simple;
	bh=bj4eSN7LNi0wSKOXjq45q6b8L04irR7EvXvQvL8sZXg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bZCKqr/0kyWqLcFPI6FKaclMUUzeFBWPEKzns9R8kdacwBLKVDYgiCxFUc1tZwDHr8sMDP5UUhKU4aejbGqeni1M8U1Pstdnj5hPmuvBvABJWpI8VU+YsF581S2tyAd/oXuWJkp0+aYZ5Hi5rAo9W/JyAqMUjBzQOW3Hlw/XqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrAWxcuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2A3C4CEF5;
	Mon, 15 Dec 2025 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765792334;
	bh=bj4eSN7LNi0wSKOXjq45q6b8L04irR7EvXvQvL8sZXg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mrAWxcuZQrPFfFR28HeXlxGlJgRQ6fqmeiD7nLedJYp7BqCD+RZ2dun6djtMvSftR
	 pytXFHGmK9ra+mKJDh6yzw6Lkk+GtV1XPTTEKjfldjcU+zx+ZxINY1tQYm4MXBP5fN
	 /mDgxo3AUkvrnHxdCNThAV9+QadvgExS4OlIUcvWZimVs7pKpURp1hgm/NIQLnIRq6
	 DoTu4J2ElNcAE+F3xjKcjc77RDTkeOMgIZvE2CBp7RZ2CL917qOJEfQiaQwwEJNwVV
	 r45mDoJl6NHhAhNJ7YJ1LrC3o2G2NcBMx20ixhE7x1LHqgV1QJO5TxPc5RV9bLTMNA
	 J8qV2ud4QQfWQ==
Content-Type: multipart/mixed; boundary="===============7988741503568897969=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70f85401f517647dde59a2900a9f113c7dd2991381c7ba5c9665fabc326978e6@mail.kernel.org>
In-Reply-To: <20251215091730.1188790-9-alan.maguire@oracle.com>
References: <20251215091730.1188790-9-alan.maguire@oracle.com>
Subject: Re: [PATCH v8 bpf-next 08/10] bpftool: add BTF dump "format meta" to dump header/metadata
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,dwarves@vger.kernel.org,bpf@vger.kernel.org,ttreyer@meta.com,mykyta.yatsenko5@gmail.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 09:52:14 +0000 (UTC)

--===============7988741503568897969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..fdb9b36fe106 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -835,6 +835,90 @@ static int dump_btf_c(const struct btf *btf,
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

[ ... ]

> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
> +		if (json_output) {
> +			jsonw_end_object(json_wtr);	/* end header object */
> +			jsonw_end_object(json_wtr);	/* end metadata object */
> +		}
> +		return 0;
> +	}
> +
> +	data_sz -= hdr->hdr_len;

Can data_sz underflow here? If hdr->hdr_len is larger than the
original data_sz, this subtraction wraps to a large value. The
check above only ensures hdr_len >= sizeof(struct btf_header),
not that hdr_len <= data_sz.

> +
> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
> +		if (hdr->kind_layout_off + hdr->kind_layout_len <= data_sz) {

Can the addition here overflow? Both kind_layout_off and
kind_layout_len are __u32 values from the BTF header. If an attacker
crafts a BTF file with kind_layout_off = 0xFFFFFFF0 and
kind_layout_len = 0x20, the sum wraps to 0x10 and passes the bounds
check, but the actual range extends far beyond data_sz. The subsequent
pointer calculation and k[i] accesses would then read out-of-bounds.

> +			k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
> +			nr_kinds = hdr->kind_layout_len / sizeof(*k);

Does nr_kinds truncate correctly? Since nr_kinds is __u8 but
kind_layout_len is __u32, the division result gets truncated. If
kind_layout_len is 512 or larger, nr_kinds wraps (512/2 = 256 -> 0).
While this causes incorrect output rather than a crash, using __u32
for nr_kinds would be more appropriate given that BTF kinds are
designed to be extensible.

> +		}
> +	}

[ ... ]

> +	} else {
> +		printf("kind_layout_len %-10u\nkind_layout_off %-10u\n",
> +		       hdr->kind_layout_len, hdr->kind_layout_off);
> +		for (i = 0; i < nr_kinds; i++) {
> +			printf("kind %-4d %-10s info_sz %-4d elem_sz %-4d\n",
> +			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
> +			       k[i].info_sz, k[i].elem_sz);
> +		}
> +	}
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20226997366

--===============7988741503568897969==--

