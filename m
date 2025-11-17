Return-Path: <bpf+bounces-74704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD9C62DFA
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78BDA34F99D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D022F744A;
	Mon, 17 Nov 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hza2anhR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC33220F37
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367334; cv=none; b=a0EtbSdufmFZQ3FABuaRcHV4AnMaq7xn7rA3rE//ITgCy7Y/SEvchnCknHKuEFP3L7KOQL29uiFnLWb6BVEGpzt4nrNRF+Y0aZsyAYFvwXqvJ3IY8mJd6j+PtqZOAxJxta9LMQLwEZuyN7Wyz2Fz319TESz9LqkJKTFRSBJDGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367334; c=relaxed/simple;
	bh=HKXsYNaGD7855NAn1CVtPmZ0L17N2YLtYIVTxaRmxBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5kV1+qM/qB18EO/MDqUmf5n6nUDosBRky3JsQkIWPKbLE670mRYULfraI8hFj4oLLhnP/YeY6ERO+RntFKoSdatu6M7QS0Wq6TWiKJ2ewBO08Sn2NR+z0YvIVf2IxQuHmrhuYXBoIEdO9t7R+s3XymANTxzYxekxYaLW87QG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hza2anhR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso25890225e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763367330; x=1763972130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2l4BuUOpntiilgAU0uTWmh+wmTyOVxCQrKtqYTkhQs=;
        b=Hza2anhRvaoUv+TlEEIJwrpKd5GzjrOXCzdmAFtIApDxNMlaX1j6yXtrvZgyN8Mqa7
         ICAazIljxPdjlRhwLlxDtl2FbuYH1GZX8aES9MeTp6JwaUKUXosB96yS248BFTZFBWlC
         sHbGvc8R6IuSLU9St550fNkX8pj+Gas6g03HzAhWKXLiRegDe42MljNSj8jpseQYP6mW
         9Buke5+AZ3KRnrvNPL0yCqr+PghsDh4bqqOs6yfIF/Q7DPpoy3SnrgBYBR9+M07SsJpf
         2/OOKd2u/0ecXN8Zk45YJR56nQc9iemXVOq3WZwzQ5rzE666GgVsh5C9dR/EnJA05pJm
         TL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763367330; x=1763972130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2l4BuUOpntiilgAU0uTWmh+wmTyOVxCQrKtqYTkhQs=;
        b=POrboojz5fca1zYF3nZc4nqGNivEjm9KWx+fsiFs7qS8RotZIH6qNp8GN93pidcBdO
         q4XQuFH34m9S1gRnSHgVUeuD3bJ3TTLLupqk4R7RB1spBSpMnhwNMauyZM69EW7Ev3yC
         VQaqlBaOEbCypNQn3U+EQZed/5F8y3vVXvbWgYuXptaM6mR+WxM1vMsAvFNnMmELN9eW
         joZ1MJb2j5uVsj6bsmKh+WmRv9UHHIxQErERPNtCgIwLbqUrT8SEtIPSejeqtbgVJwyw
         K6uCxHwyBGB0YnxrlfTvEjtjvAwyH/YT2H+fpJSdx2bVmVStpwnHAveQDUEqyQ27fC15
         BUwA==
X-Gm-Message-State: AOJu0YyBBRDmToHBaS/gotwBR2VZHvjIr3sT6QdqN8dJM50jLLW5QRKe
	zTam1deFZRezbLBxTxPD7MsFgiFRETI2cAi2g6v7sSw24yeHcEUoSi6HB5vp0Q==
X-Gm-Gg: ASbGncsHcRHYQ7y4S8Ju8NYoO7TWijArKie4Tq7RycmdDxe8QpxKZ7hZGPiE50Zh5q/
	shYHnr7kXd9at004O7oT10kFhz1Ez8skXS5lPudprHULNQUY/Slz8TVfWzYMt3pM6VWmoIuem9d
	E9xEjyTgePhbECNoBSSI2833QOHyV/3DwZeaKttT5au2p/kc2mtSPgh0VlsBMXbLakdySl1m0KG
	ESBDR/T5xOAC6Cee4p3eYoHG8/X63eHXrouE1g8QAhmv1UgT1rq8o0M1yMZaZgzFDIEX1+UU+0f
	swoe4Nmz2AKDYWvuZA83kLf+i1qsj4eSjbO+dXYWHuLOuQeMAAi9kvCBWQ4b5NC5lIPkx9RXmxT
	+H8tJsT+Dm/3ltcrMezwBI78zyUZR7NdAzLjSwGMb3O1OQwUrL297RN8ECduW3JaM2l3Vib2AHt
	VuUf87NlgibP7ukMFZQXxg
X-Google-Smtp-Source: AGHT+IHutYjnQ+JySVUn+8IcJL7RyOEDexJUvMpBGsRYFPquHhLlUrxVA6uQ8a9T8zPHJg9vt+sahg==
X-Received: by 2002:a05:600c:3587:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-4778fe7e760mr114298645e9.17.1763367329828;
        Mon, 17 Nov 2025 00:15:29 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm295900245e9.3.2025.11.17.00.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:15:29 -0800 (PST)
Date: Mon, 17 Nov 2025 08:22:26 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/4] bpf: arm64: Add support for instructions
 array
Message-ID: <aRrbQtct2X1IqwIC@mail.gmail.com>
References: <20251117004656.33292-1-puranjay@kernel.org>
 <20251117004656.33292-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117004656.33292-2-puranjay@kernel.org>

On 25/11/17 12:46AM, Puranjay Mohan wrote:
> Add support for the instructions array map type in the arm64 JIT by
> calling bpf_prog_update_insn_ptrs() with the offsets that map
> xlated_offset to the jited_offset in the final image. arm64 JIT already
> has this offset array which was being used for
> bpf_prog_fill_jited_linfo() and can be used directly for
> bpf_prog_update_insn_ptrs.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 0c9a50a1e73e..4a2afc0cefc4 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2231,6 +2231,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		for (i = 0; i <= prog->len; i++)
>  			ctx.offset[i] *= AARCH64_INSN_SIZE;
>  		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
> +		/*
> +		 * The bpf_prog_update_insn_ptrs function expects offsets to
> +		 * point to the first byte of the jitted instruction (unlike
> +		 * the bpf_prog_fill_jited_linfo above, which, for historical
> +		 * reasons, expects to point to the next instruction)
> +		 */
> +		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
>  out_off:
>  		if (!ro_header && priv_stack_ptr) {
>  			free_percpu(priv_stack_ptr);
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

