Return-Path: <bpf+bounces-13636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF387DC0D4
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A85B281608
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216231A723;
	Mon, 30 Oct 2023 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZKXuoxp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EA14018
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:52:20 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F858DB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:52:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc3542e328so12327745ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698695538; x=1699300338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdgxUvpUVsRw9uupLFCccGk2yeWOcpQUS6GgoiusbWY=;
        b=AZKXuoxpCZNCl0dbON7FmyoikLTkmOtxaH2TNIjTuBE2DZzg3akM1xwsUTL1MI+Y3N
         YiuYl0uz5r+ENshtDPRyTbE5hks7QMPRXMnIGAnd+XuUBCNG63TgSIgoGyWvnYCt0NA2
         VjO/EZMwhFXNcI68+Fd52uiaHqja8DRlLo1oDgOWre6TyXw8FhOHiW7M9me3bnKY7Mjo
         1OM27Qsk7tOHyJvEV4v9NhXJ7F5R7/Kf9aRuoS/lrKmvwYHtE1fXizc0EFb19kcynVgK
         ZQY5p5dUPTxJAjR7uCe7BDN2aH96zHAVPsCsFkPN43HDCXH09MjGGQNH2YiVyIivW09o
         gdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698695538; x=1699300338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdgxUvpUVsRw9uupLFCccGk2yeWOcpQUS6GgoiusbWY=;
        b=gKO/LWVYY3CoI3GtMC/rMG3GEdjcnRPsZOwLUhAYMAtM0pm9B4SKIIyNTKVTX7rCzc
         R3a4y7lANPWBdk2DBbDNVBHtGhwa4QGCU+5fwcDyPRQ9EgeB/JMofK+1SCAqFRPBh0Gl
         B1p3nXxNiYgplBdBiErFwHSLvFVes5Kbh4jhzhW6MMN1JZFB1rDuIlSyXd2xJUEcMJCz
         e2uWonrtZwDmBQNiaz/GJmwBbZpRi/UNjNk+bhN713mvB5tTwvq1wkWcMvTAg4i658Z6
         9i7/raIzFN0UOx823rYNVedETqZKHFXQrU6/A93QRSzfl0YXa1pdxOFj40bje+49CU6a
         ggNw==
X-Gm-Message-State: AOJu0YzM+GiIbTBhPZ1RwIuXP/0TEJvjO1Rx6lntoStpn5rFhnP7ZYQP
	HVra73ZJsy7uNVY1S4Ugols=
X-Google-Smtp-Source: AGHT+IFQVPzT30UVfTDy44Ysmgn4wDYmGFCDbVYqYSP2Wl1Bm4b6paG6c7BrLdk03eEAd0R/EG/wcA==
X-Received: by 2002:a17:902:db10:b0:1cc:5833:cf5e with SMTP id m16-20020a170902db1000b001cc5833cf5emr2376712plx.27.1698695538428;
        Mon, 30 Oct 2023 12:52:18 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:500::7:f772])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001bd62419744sm6634115pli.147.2023.10.30.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:52:18 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:52:16 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 15/23] bpf: unify 32-bit and 64-bit
 is_branch_taken logic
Message-ID: <20231030195216.zpcntk47dxyissoi@macbook-pro-49.dhcp.thefacebook.com>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231027181346.4019398-16-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-16-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:38AM -0700, Andrii Nakryiko wrote:
> Combine 32-bit and 64-bit is_branch_taken logic for SCALAR_VALUE
> registers. It makes it easier to see parallels between two domains
> (32-bit and 64-bit), and makes subsequent refactoring more
> straightforward.
> 
> No functional changes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 154 ++++++++++--------------------------------
>  1 file changed, 36 insertions(+), 118 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fedd6d0e76e5..b911d1111fad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14185,166 +14185,86 @@ static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
>  /*
>   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
>   */
> -static int is_branch32_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2, u8 opcode)
> +static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> +				  u8 opcode, bool is_jmp32)
>  {
> -	struct tnum subreg = tnum_subreg(reg1->var_off);
> -	u32 val = (u32)tnum_subreg(reg2->var_off).value;
> -	s32 sval = (s32)val;
> +	struct tnum t1 = is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_off;
> +	u64 umin1 = is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
> +	u64 umax1 = is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
> +	s64 smin1 = is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
> +	s64 smax1 = is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
> +	u64 val = is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->var_off.value;
> +	s64 sval = is_jmp32 ? (s32)val : (s64)val;

Maybe use uval and sval to be consisten with umin/smin ?

