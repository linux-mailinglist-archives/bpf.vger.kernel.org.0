Return-Path: <bpf+bounces-68968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF5B8AF29
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E13B5A0591
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554425A33F;
	Fri, 19 Sep 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsXu6gcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB770258ED2
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307093; cv=none; b=S0jRPFGfb9NdPmKzYrGk3HSEs8tT3oeQ2m8PzjnCQdIzppxFe7aAq4Ay5BHDcybkSJdt5QnE6hH8vA9P2pn4oaaldg8meO1JQJoFGRl4WMOBZCca0krddF+ZQewKuEEvYGLxCCEWGUBtLkh8cfvVpw7gULFWJHUKUfd7h0q4NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307093; c=relaxed/simple;
	bh=Uj7LyBtMGWKSZZNoCwoI3XnyS6aYtlzbwFJHLMzFOn4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvuO/tH0/fQVSg/bzxo2eGF3jmOZnqjn2auPdsKkWbEIItgdfnhN3P5JA76XowNCcAIHIpYaUURTUuSaNm0Zt9fBW++crW3gY+IWkS9cisIKdd0SLVxIvWoYSMNryUBuaKr5EOh977bEUwmL77oBBBUU6PZLRfy9738YMSNI9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsXu6gcd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf6058aso32023855ad.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758307091; x=1758911891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMRa6ZqOfv0k7/2hfsjA4oxC4hTv8Opov0LyPKUA1p4=;
        b=nsXu6gcdzfTojqeXAtTxWD7iTHY5JNNNbutTrWgOPSLygmRHBMKzAuQqIrzilYTmUG
         aeAzFXtMYYgaTMiVG/Cpol06pJzt6kLEw4GGC1nrIoTQUcPGHAnK24MqkLYGivjNcWjU
         p52tzYOy9xgszAjBv27EArdT6n1Vumd39aJoIAWbzsDfmY21T/f5sAj2D7Tt7DaEUJaE
         8vM2B27G6RICJCR9fx9sRmPboJsHssCUqe87ffRrS0sFBRA8Kzj3GOWxlP1xq+srF0Qc
         SvpHvoSomrVEs8lUOdgdDOCFuph2WSijBopUFu4qyzveOpyiqkKH0Ff+fJOCdkXoCbDs
         YeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307091; x=1758911891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMRa6ZqOfv0k7/2hfsjA4oxC4hTv8Opov0LyPKUA1p4=;
        b=X8IGNujxL7q20rBxvy8+Bhhwzv/cfzqsmHQ3KVjHcA9huEz7g3UVeEqVV/P4/QtP5L
         XbE0ZapzRiMtbuJMR0PrmTT4yWMirjSQRETmfnz+PgbU0so8NXHZe5dlAqoA2HXYdJ6X
         +4QuQAuAjtkc4WuzJFfnEeiGpSyKVlBnOAC7ZzlJqvvvLmNFaaKgLl3JO5cCG3+Cdqoi
         zC7AduO7NA30a5TByEeJx+1ekemRHjdM/98cVXRTJc4u6tA34/VEyjQEfG6JRi+0fks2
         UU+VBdA/N0ZaLAIGCUJODBPgQtoMx7fMl7LXSSg3+vkyPwRVbsCJ+JXN8ToLrRScd5iP
         Z6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUHps2PTxrNQMT7ESs/SuCJNYKfFRRXn+sH3yPj/FlFp5aCo4ihqSkr7J5+8zfB+SLdPRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYCAjx9KZmNmYpVC3h+cRcy4vNPh07GKhk/ZD4ogR1fdty+tp
	Ft1FOqjdrG1hLqvQ81gbatatpIKnzjvJBGiHM37CpPFodO1Ls3Nzm94d
X-Gm-Gg: ASbGncs/sOWCK7J6TLmgy3HuXfnTVgH9PwwPSwMD3bREEp9iEQwSU42/FOyg2WATl0X
	BoiD0N163TdBC2vaq18b4166dBpUsy53noNd/S6LOLNpUAG+c/sjIfajylXDy7JMaZc3bw5MwRT
	oN0EBJEQ+8gTVshDp2kpmbtfeyS9aDl2YSsjs9RPDJ20Sod9AwdC9btnJhiErXAdo28gI2vqtoX
	S/EKcx4/4hKOdiZrqoiT84EEKWhrl49p7UDTTZczCy7g2zwbUw0iHn9Cb2GEhOj7Mh04LCugCEX
	ASXW2PHovLEYZrAnC5eUQU4P+iJcD2M+J9lXeYB+2nwYME++MNscPaD85TMyFSXBCfqTFf4pw5p
	0PI+IDQcMm7ux8Kle77A=
X-Google-Smtp-Source: AGHT+IElGtg6WNsje1gMiYVs8t2vDdMGTNKR47nFjIJjbfMP3UcsOgKzWVPierMI+GEHwfCMoEtkcQ==
X-Received: by 2002:a17:903:2308:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-269ba510000mr52337905ad.34.1758307091077;
        Fri, 19 Sep 2025 11:38:11 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm61979045ad.4.2025.09.19.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:38:10 -0700 (PDT)
Message-ID: <aee4f446462315c88537c87c39da2a5d3b745b62.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/13] bpf, x86: allow indirect jumps to
 r8...r15
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 11:38:08 -0700
In-Reply-To: <59dd1a009a5682d4b16df81e097a1a1b43308a28.camel@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
		 <20250918093850.455051-8-a.s.protopopov@gmail.com>
	 <59dd1a009a5682d4b16df81e097a1a1b43308a28.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 11:25 -0700, Eduard Zingerman wrote:

[...]

> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_po=
ke_type t,
> >
> >  #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
> >
> > -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> > +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
> >  {
> >  	u8 *prog =3D *pprog;
> >
> > +	if (ereg)
> > +		EMIT1(0x41);
> > +
> > +	EMIT2(0xFF, 0xE0 + reg);
> > +
> > +	*pprog =3D prog;
> > +}
> > +
> > +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
> > +{

[...]

> >  	} else {
> > -		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
> > +		__emit_indirect_jump(pprog, reg, ereg);
>
>                 You need to re-read *pprog after __emit_indirect_jump() c=
all
>                 this is what causes KASAN error I reported in the sibling=
 thread.
>                 W/o re-reading it the FF E1 emitted above is overwritten =
to CC E1
>                 by EMIT1(0xCC) below.
>
> >  		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MIT=
IGATION_SLS))
> >  			EMIT1(0xCC);		/* int3 */
> >  	}

Or just move the EMIT1(0xCC) inside __emit_indirect_jump().
It is probably necessary to correctly do mitigations anyway, wdyt?

