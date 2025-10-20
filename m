Return-Path: <bpf+bounces-71365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDBBEFF9A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4C83B40B0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740382EA75C;
	Mon, 20 Oct 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwuUH/5j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63D2153FB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949151; cv=none; b=ue0t6Rce5g+9Q7RmTLmf4M3Da5WAWgwdlFxPlx9JJ9u2QOpC1KnuEuL04sxuJNeFUO/fPbr/ZIMtrdLiErIy+vwkC8F985vFOOQB5BnH8GEsDPP/+y4KixWeVG0RyGJA6cA8ZEefrbcrkjTNcVkvnbNgMkWCpsQnCHvioJ97NLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949151; c=relaxed/simple;
	bh=l8cmaS2SKGt1xvgQbKHx3HmLmcdLfZAslOypsZISbCw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0p3ufMpqlEX0hZaGY/KgiNfLflYHwVkVk3nV8hO3cPAkuZ4PEytFSzTMGy2Su4HJQV7N68n2EpFJLMR83GkGr8p9OBsy+VF5sX7Ig7sH80gb+7J8o9EfRAuVtjabke3lgPn4PN5UFkqF7mwIjYcAuymsWgnu9kD+D6cZ0HTafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwuUH/5j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso34029735e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949147; x=1761553947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7cHa8JYza0+oKYC1CcOJOjoywkgaaVS64RVWYlUn3M=;
        b=FwuUH/5jlTH7N31LqAP643lMNNhEHr01F51lsRjWLuwoXe0WOxB3bZsKlsIK0rSakj
         QDKQeXnUcIopVp108EG5jfjZ0QkG+lHqFW3S81p8kfiGlBxVRXkzBulxtRh4UVnGOeQM
         EUMQs+9TPiIvf96oMfTiwCxJtyrGNTnDEsV7PdHdiRnTrWS3t0V4Yl24b2ZnJRCIfsHo
         mZl1KC4UQhkSCmn5miqgUWs8JKZHy5QXVGFzGQIo/UKLLAWel/Rz4N/CLuEjVbeyq7TP
         1KBIvV+dSeh5ejnlLpEUJhWxYiW/dux4mEit29g67blK8GVLhDtWjMggr5liywCeWdCh
         gTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949147; x=1761553947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7cHa8JYza0+oKYC1CcOJOjoywkgaaVS64RVWYlUn3M=;
        b=ISMb6zuTMeUkI9ed9wi2iH9tsbbZ+oKvK1PiYjnQob0U2uUvXeQJTAXxeioTKcoUMs
         MqH2xPGkHsuFDYima8hSZozf2V4elGAkMeUwOqN0sXGwGxTx082ts3lLDA75pkN7iSe1
         aqkUryxYYuTwzhVpV2v+VY456+eUp7Fnp+m4NEzmWxGMticMaNSYPvsIvl1Tm6wwJhak
         j1dFIF03Q1q5Od6DrCbjswRAH5uBQyEnDGvRm471bEfW4x51UVbcU0cTnZ4MbR3zy5Al
         i9tnxBfQkzTm73SesPRW9Gc4XrM9iWrRBXav7vVcbK4pC997MlRRn+xRlBaFX94k+ZZN
         Zhvw==
X-Gm-Message-State: AOJu0YzFkswhrHN69toX+Rnd0QqT/v41p1mMs2eQpdg2A2Or+6YShNUc
	FKuRETfn0JcqVM0zvhhYfncDGsFf/uyqQ3ZyOl8ROKsd24L8JIpAbzcFq2T8sQ==
X-Gm-Gg: ASbGncvZI4S63coBxE8wV1KjfJPg74RevQP+j+2oBfVpQygqLIy6cw3XcL/oBBAv9U2
	6X6TPYuNg7pGoEJyfaeZQXuEUIjihhjxjpPNXLwHfBlAaiGSS4OyTCCg4jqdB/SxrYtDZdhC5pl
	IbUUL6PQZmJo2TGiGJatOkF7zqXhwpM+T8T+MDbMUrZG2Dxmiwgp830wULE0349rqd5MouPgBpW
	fAElXDm9i9E3JetlShVYSAzxIp81LyU+yAKp+b146byOLAMhuF8U8dyi+h7PExe5B6ubIzM+9KE
	Ciy3fN40BUW3tUKg0d+N073Ul5f5CBZeTDe3JGRoTvzhFFCavOp9UvkgSQG2CCldTEAD3oOHuEB
	LtKC8z1mDAC9fOVFgUHK2Xi76ngRo1lowTKF71L0oaeezPjTlEv9iFXmw7UhaW53OpI2jpJx+Ui
	uzvySiHl342TCIqkARZ2fx
X-Google-Smtp-Source: AGHT+IGwRCYPc3nzGn10cltIpubplawJmNxMJX1D0Vn+eGxMVong6yZOcGv5nOWfx4eitxFEAszhPA==
X-Received: by 2002:a05:600c:190f:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-471178705b0mr94148915e9.6.1760949146509;
        Mon, 20 Oct 2025 01:32:26 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm263753525e9.3.2025.10.20.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:32:26 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:38:51 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 08/17] bpf, x86: allow indirect jumps to
 r8...r15
Message-ID: <aPX1Gzcqm0Aq7xTx@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-9-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019202145.3944697-9-a.s.protopopov@gmail.com>

On 25/10/19 08:21PM, Anton Protopopov wrote:
> Currently the emit_indirect_jump() function only accepts one of the
> RAX, RCX, ..., RBP registers as the destination. Make it to accept
> R8, R9, ..., R15 as well, and make callers to pass BPF registers, not
> native registers. This is required to enable indirect jumps support
> in eBPF.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c8e628410d2c..7443465ce9a4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  
>  #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
>  
> -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
>  {
>  	u8 *prog = *pprog;
>  
> +	if (ereg)
> +		EMIT1(0x41);
> +
> +	EMIT2(0xFF, 0xE0 + reg);
> +
> +	*pprog = prog;
> +}
> +
> +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
> +{
> +	u8 *prog = *pprog;
> +	int reg = reg2hex[bpf_reg];
> +	bool ereg = is_ereg(bpf_reg);
> +
>  	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
>  		OPTIMIZER_HIDE_VAR(reg);
>  		emit_jump(&prog, its_static_thunk(reg), ip);

AI found bug here: its_static_thunk(reg) should use reg+8*ereg.
(The code here was not changed, however, before this patch this code
only was called for eax and ecx.) Will fix in the next version.

Also added verifier_gotox tests which validate that gotox works with
r0,...,r9.

> [...]

