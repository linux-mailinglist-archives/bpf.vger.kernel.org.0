Return-Path: <bpf+bounces-74705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8DC62E01
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BC5C4E7223
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773130DEBB;
	Mon, 17 Nov 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXs+LUvE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AD1946DF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367400; cv=none; b=PIk59a/iO4h4FO+delWCwyQOlTsWziA9SzrSEjQuwSHX666V8oKhZn5l+lKOmKDDbXOsiSudWKRr4yUn1ngXHPKU4MvV1QXDGD2+wxmdrmVYDcTt0nWhd8+lMz+EKM30lBh9LuiLJ7RYC0F+PjQvGDCZo1xnF/1LL4C+6qTxD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367400; c=relaxed/simple;
	bh=lyq5OpJ0eogIfQYbpW/suAdxzfrmv8RxqJNMtrB3Z2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Tbkuzz/tV2GKWLF5QbndAO5s50+JYVhgVB+fo1zeQgQFmNoq02tOJLNp+ZHdB3vNUzZwVOwCMYZpRCrSLv1TG1AmLLfYY0NLHv4XhkdI6vJgIrRkSwJ/Lbpk2SYavzUgWvssLMRJ8hkTxhybSJ2T4FeOOnpqDYpgEe6PAWM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXs+LUvE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so10709415e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763367398; x=1763972198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3SYoogpUSSXMLdWBLPxBJj0dnsnX0elQ7QXOfEGhrs=;
        b=JXs+LUvETx4UMvD68HUiKSJShLC097PDxX9oUbhhhpo3iRQeXm6u50pc0v1kjh/o76
         0eXzarDRfXF3Q9HwADH+C1vPXxDGXjRpQHJeaR9OtRctCaOoF32SFtlxVxIjFG9HzzgC
         oOTiZOa8NIe/yjRraLFh1nnP2wWcX/jQuRXLSNhSFvfQqa4fPeffwqJHdMAcu5Ct36zc
         MHFCIdggvxe1OcyB+IDRARcGKa5im4CvC/3AscPcORKYAeOfm5I43mkNhfrQKvmpsN/H
         6NLm/uSt0HFMApxAXZImueC8/ynD98JEnF4qv1slQR1icSSukuiB5x6D9GABbtJotQNt
         zXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763367398; x=1763972198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3SYoogpUSSXMLdWBLPxBJj0dnsnX0elQ7QXOfEGhrs=;
        b=knWqJoMZbQPe0w2uJjQht/Lu2MLQJEPC9dzUXSpdwA0A2CfReJ/Mtv+TWN2MjKBqB/
         pj77w2DVG3GnppuScj8123/M/SunjTT+glRNWngaYncWvAruGYzkFRXSPHbD/xG1Zomo
         kUfnJwRgyKpu3tnO680msB1jtQQkkxrPrRPK9deWoev4Ls0WDsT6NCJYjZqv6/srytGp
         cA/rr6QjKe5LKd4EtPMLClrOLb54+ohb6/ME9JC0ODhU/hwO1Ol/hmJK/EN6c0q7ww+j
         G6gGPCqNaf2yyILm6cwB1z/R7n7dcy6sCCaDJxcZto/IGD8FRPfMee47z+RQluRQYoJ/
         1vZg==
X-Gm-Message-State: AOJu0YwK5MqyhGNzt3IiConfwtwmJTb9JsqYQGnXSbzffdG90WRoiJeD
	hyGnTcZoMDXW6MrTu3e1B2W5A45mgQAuFMz6VjlmDGA5Mtr/41d3kAbB
X-Gm-Gg: ASbGncsi/KuT2uTkEIfzbsAH2K5RTR8ZN2rIGlJqRvMK0WKnpI/LlsGg4ySOcD5EHsx
	DpqihLiT9QQWRQX/Gx6Lg+w3ke+dUQJk3J9hWhSc0SykMhNb8dPr3vkC7QvwZo54rsn4mNmDLOL
	iLOW3wuawX+YjqHFEjV60SOv9GzCpPTrnDaKLXT6r/QMlY/3ynlwS9NDOrmE/+M4UeKq5aHZdyx
	lLzxaKrtGta7GKnaReCoJtsRRvu8VM/s4/wd3xBH73z535CeeYAU78kRck/9zHIUtHupDhL2YHh
	tX9OwggesCDOY+ujnU1aR/NTPNREpZvSYNXk+xZaTzLzMPNkIFgsVqcVtoIKXjZRgqVvEv2khkt
	6ZbRVCyMZWNx9OPPEym1mcdypsmwednkXRQw/boUQwrfpq/DNX93pf16o9Nna/U9bO2aUOFNK4P
	xPktMVq9syLJ2nI5HrhHz2
X-Google-Smtp-Source: AGHT+IHkwtT2BR/nKgSl/5MG8uClGpuLYoEmxerKw/zF9x6f93Xg4N+ohC+usC+mQZ6JxnEceQleUg==
X-Received: by 2002:a05:600c:a49:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4778fe6822fmr102160345e9.9.1763367397308;
        Mon, 17 Nov 2025 00:16:37 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779920f2cdsm133672185e9.10.2025.11.17.00.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:16:36 -0800 (PST)
Date: Mon, 17 Nov 2025 08:23:33 +0000
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
Subject: Re: [PATCH bpf-next 2/4] bpf: arm64: Add support for indirect jumps
Message-ID: <aRrbhVollFOf0d/A@mail.gmail.com>
References: <20251117004656.33292-1-puranjay@kernel.org>
 <20251117004656.33292-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117004656.33292-3-puranjay@kernel.org>

On 25/11/17 12:46AM, Puranjay Mohan wrote:
> Add support for a new instruction
> 
> 	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> 
> which does an indirect jump to a location stored in Rx.  The register
> Rx should have type PTR_TO_INSN. This new type assures that the Rx
> register contains a value (or a range of values) loaded from a
> correct jump table – map of type instruction array.
> 
> ARM64 JIT supports indirect jumps to all registers through the A64_BR()
> macro, use it to implement this new instruction.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4a2afc0cefc4..4cfb549f2b43 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1452,6 +1452,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  		emit(A64_ASR(is64, dst, dst, imm), ctx);
>  		break;
>  
> +	/* JUMP reg */
> +	case BPF_JMP | BPF_JA | BPF_X:
> +		emit(A64_BR(dst), ctx);
> +		break;
>  	/* JUMP off */
>  	case BPF_JMP | BPF_JA:
>  	case BPF_JMP32 | BPF_JA:
> -- 
> 2.47.3
> 

Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>

