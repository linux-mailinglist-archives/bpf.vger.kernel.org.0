Return-Path: <bpf+bounces-68965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF3B8AE8C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035B31BC333F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A725784A;
	Fri, 19 Sep 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTjvsyMZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1160B8A
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306306; cv=none; b=BkvX5ZHNe/F3VWk7mWMdZp3cutnaOOuXH31l/bSMqSEysX0HLuiszzZqfLDT8GGJQb+LM2J5zhJq1ppI2w1NZ0euVuoUYBByqRjc0+isS2kLInbTII6ipaWNkFFbh1bhzdSvwtBJ5Tc/qloDuT/tE17KbctvuGGRAHccr0p9zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306306; c=relaxed/simple;
	bh=tJTDdS9KUrNBMpT96XQ0s3biUIm8b1pbtxdhIhMvMAc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7ifE/+f1pyqjAaFaUdZEKzPEeDhRGKXqtZQ7Gk7nzZmyVwk6rWcFOho0mpEu8g0X+wESJPu489BWrAH/GcGLXd6O8ptOl3qjCBlJTHfiy8Ixiiz+Ubo0dOP15iYOQmWHKhFKAY8EsMi0Kdiw5F/bJxst7ZsdcF7TC8AK1yRVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTjvsyMZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77b0a93e067so2168649b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306304; x=1758911104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuRrr8tGHkv51txgeuWP6TGFUkqvYPSiHXqz+HzV23Q=;
        b=VTjvsyMZqh/JfsWgkPm82vi9sgib8aoL/Yk1GIMqxWyvg14dDoh8QNuqU9hTUF+bzg
         ry2VQ3BNsfXLzVXSGxJgKMz7DJ1nO1U6UDicAYChZg8QMsnazvpF/3e7+Zhgywl/gxKM
         VinrS7qxve9+PO+z12ITh9x/HuySYqEh90g1vt+JWnCGPPmNbmKucQ809vpuWXaFgYmu
         SK9UOSF3z17YeuORVSLAU/DWUuJcJ7xxFCcHJkRBVvXgPfpVnD7MTsTkMtt4jdKJ6Q8C
         oWAaMmgi0FDKiLzDZPKBi0saGP+ciFtc8ii7mwqnwsJS6YVh4TKVRsCqNyrkV4GeLLqs
         d71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306304; x=1758911104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuRrr8tGHkv51txgeuWP6TGFUkqvYPSiHXqz+HzV23Q=;
        b=cuTM+lEhXRwxWas6CfjFkZz1YGFW+PNUeS6Atbx7yJbVrqSuoWnz6I+QZeQCViTWE7
         vGSJLNQ7qcN+xh4hwrPcBZDdVLxikixfnJw3/G6sPLMix+HXDrkppGuUQSiUJVz5yaPS
         OQPlXbDEJbU4oPn0eA4/55C7xAE0ohHp77UOzwo2YhmjWcdLPeM9WZOnW/cXmOCnZKnM
         J929tsrUGGMCdspTCy6JKHYEC5mRckpvZdrJ2tksRwxo6C5rkHFsK9Mj6vEZvCayRhfs
         gNO3tACe9QTr508wxO2Rl3EviiMcwyCa+PhV9Z24v9TCydhIstJs8PJ9LcB10VZFb/0q
         SxDA==
X-Forwarded-Encrypted: i=1; AJvYcCWLwVXvvtudoMzUDDmuBOYbu6AMDNpnF/XsQXYOFPqr7NHXDQKuZ1woBozdB+gUJ/FPW6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt530fkqTu15abxdiBF9i2HdVxH/htUn4ps3ndVSXyf5XWPW2n
	MxB1Xs3WfYTR6agFkIN4X1bgwiOl3JjyDzlxqMH0NG+Tz8fWtZaSB7wM
X-Gm-Gg: ASbGncvEgkTSnmT3bRRMFICDCvSXVHt/Rt7pMLgh6WvDCvJAVB43cvgs+4ATKcNHhNo
	46PBH+h4I5NS9xl1bTgBSF6FmwpYqIx/jqlHZg02ylUYGMCeOGU6RccFptwoDFhIaxlWtSSkPtw
	v57e8V3+wnivvGTrKN2/wSxd9r1EZlFySYU8YDbEj9BBUzGU/TkheGseRKTekUs/eJuR0KLQ4nF
	+JyBcdmG9Ov2NVvi3h4aXGRsMecqEf7rfenn2AV2MU+RXewSkq8FJ4diw+ebCmvek2rngzPGRDy
	stw5rrX5RWahexIpI69hoF9nu2QzNwtoUnq4H225+sqnOU4R/5xEl5i42SHm+JpH8Iz8n6f5LFh
	U+lye1U46EMeQbqXd1IObO3tk29QXyg==
X-Google-Smtp-Source: AGHT+IHGRUnq6gEGeZiVHGz/aHBZ2WpKg0Ai46IC3a3IJMTG7ay+gdLXibx8eMgG80VY4V5Culy9Ug==
X-Received: by 2002:aa7:8895:0:b0:776:1591:64de with SMTP id d2e1a72fcca58-77e4e4c8493mr5544151b3a.17.1758306304081;
        Fri, 19 Sep 2025 11:25:04 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f84fsm5880365b3a.79.2025.09.19.11.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:25:03 -0700 (PDT)
Message-ID: <59dd1a009a5682d4b16df81e097a1a1b43308a28.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/13] bpf, x86: allow indirect jumps to
 r8...r15
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 11:25:01 -0700
In-Reply-To: <20250918093850.455051-8-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-8-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> Currently the emit_indirect_jump() function only accepts one of the
> RAX, RCX, ..., RBP registers as the destination. Make it to accept
> R8, R9, ..., R15 as well, and make callers to pass BPF registers, not
> native registers. This is required to enable indirect jumps support
> in eBPF.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8792d7f371d3..fcebb48742ae 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke=
_type t,
>
>  #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
>
> -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
>  {
>  	u8 *prog =3D *pprog; <-------------------------------------------------=
-----------------------.
>                                                                          =
                         |
> +	if (ereg)                                                              =
                     |
> +		EMIT1(0x41);                                                          =
              |
> +                                                                        =
                         |
> +	EMIT2(0xFF, 0xE0 + reg);                                               =
                     |
> +                                                                        =
                         |
> +	*pprog =3D prog;     <-------------------------------------------------=
-----------------------|
> +}                                                                       =
                         |
> +                                                                        =
                         |
> +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)         =
                         |
> +{                                                                       =
                         |
> +	u8 *prog =3D *pprog; <-------------------------------------------------=
-----------------------|
> +	int reg =3D reg2hex[bpf_reg];                                          =
                       |
> +	bool ereg =3D is_ereg(bpf_reg);                                        =
                       |
> +                                                                        =
                         |
>  	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {             =
                     |
>  		OPTIMIZER_HIDE_VAR(reg);                                              =
              |
>  		emit_jump(&prog, its_static_thunk(reg), ip);                          =
              |
>  	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {        =
                     |
>  		EMIT_LFENCE();                                                        =
              |
> -		EMIT2(0xFF, 0xE0 + reg);                                              =
              |
> +		__emit_indirect_jump(pprog, reg, ereg);                               =
              |
>  	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {               =
                     |
>  		OPTIMIZER_HIDE_VAR(reg);                                              =
              |
>  		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))                      =
              |
> -			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);         =
       |
> +			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);=
       |
>  		else                                                                  =
              |
> -			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);              =
       |
> +			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);     =
       |
>  	} else {                                                               =
                     |
> -		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */                             =
       |
> +		__emit_indirect_jump(pprog, reg, ereg);    <--------------------------=
--------------|
                                                                           =
                         |
                You need to re-read *pprog after __emit_indirect_jump() cal=
l                        |
                this is what causes KASAN error I reported in the sibling t=
hread.                   |
                W/o re-reading it the FF E1 emitted above is overwritten to=
 CC E1                   |
                by EMIT1(0xCC) below.                                      =
                         |
                                                                           =
                         |
>  		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIG=
ATION_SLS))   |
>  			EMIT1(0xCC);		/* int3 */ <----------------------------------------'
>  	}

