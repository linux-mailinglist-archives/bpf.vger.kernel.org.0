Return-Path: <bpf+bounces-38732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F68968E13
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A921F229C4
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28041A3A9B;
	Mon,  2 Sep 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="feTn4y1M"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A341A3A95
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303683; cv=none; b=a7kgkQEQdiZfzIQvMdxrB5YUqSMnrJT1qeguFv3kgXCpy2aNpgxh4vhVq+6hK19SoDrahqky9DHNxWb/iK1Wnf19MBVi2Aa5EauahEPnGMRDMvGr1NhPdGFAncJByruEIJRWMywPT2D9z3IhEvDeW8/CgmYY1X5RTV9bT2jl7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303683; c=relaxed/simple;
	bh=1RAKRwSxyDGRz0efRzLAI3TLxfmnCYW6KPgMdGB5fcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZSeQSlXYflRIXDxe8102oF2XpfeMSH2TAtfyerRAbhC0AwFhPKc359NaScAJCIQIBWzZsbgzZBbIlrecyBfZGMe4K1JlFWbuqS6rmautluCYymyby4eWK4VWQsuGqgIx4kPdvODQB9AUF9zjq6ZHF6e/BUqNg4QJRjYZvtmCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=feTn4y1M; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4WyHtf3xvGz8t;
	Mon,  2 Sep 2024 18:52:26 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4WyHtd57p3z69;
	Mon,  2 Sep 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=feTn4y1M;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1725303146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4YxGhduz9au11cu4/u4d85pUYjN6Q9xwPA6fPbospM=;
	b=feTn4y1MGAqcYUyvSVEy0q0xMeVYWrJ0TdAIwKe/cp/F1XnTbxE9aquLPA4b0AUOp+3Kba
	hBPcTjZ6/bNPdJiJDdEPIsqDDifz6yJ9ali9eM40CIWMDt8jUuZnPxoBC6AWpQUM5FCiJj
	r/GpRVPtoHISjd7UbNh7p0+ubR39iZKf7azc9a2kEXDP3eaR5PBIWdir/NCUwjxrwXEVQn
	I8/nV3xu3bj1+lalJ77QwJnmJ2edFmZx4QNWbWmLkSB9VLBTc0jl1019q3XH2nik3rQNCf
	5Ax7wjyEaphdEJLP4H8iePtuFZE+RnRyh0lTphjGewsNDQtYwzEQhYnlHtmp5A==
Message-ID: <394636e7-54f8-4a93-82cc-7f949fb39aca@qmon.net>
Date: Mon, 2 Sep 2024 19:52:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240902171721.105253-1-mykyta.yatsenko5@gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20240902171721.105253-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

On 2024-09-02 18:17 BST, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Wrong function is used to access the first enum64 element.
> Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/btf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6789c7a4d5ca..3b57ba095ab6 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -561,9 +561,10 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>  	case BTF_KIND_ENUM64: {
>  		int name_off = t->name_off;
>  
> -		/* Use name of the first element for anonymous enums if allowed */
> -		if (!from_ref && !t->name_off && btf_vlen(t))
> -			name_off = btf_enum(t)->name_off;
> +		if (!from_ref && !name_off && btf_vlen(t))
> +			name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
> +				btf_enum64(t)->name_off :
> +				btf_enum(t)->name_off;
>  
>  		return btf__name_by_offset(btf, name_off);
>  	}


(Please don't forget to tag your patch as a v2.)
Looks good, thanks!

Acked-by: Quentin Monnet <qmo@kernel.org>

