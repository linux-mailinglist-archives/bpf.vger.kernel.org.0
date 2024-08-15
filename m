Return-Path: <bpf+bounces-37318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F58953D25
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041081C231A4
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298B15445D;
	Thu, 15 Aug 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVtzlpc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092D149C4E
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759646; cv=none; b=Ct4a1uRh4bGiBlUXQtt37tgDC4PzttFIAahbtWnFIoc3FTW7P5JHRxtAMLF/AMWYKwP3yPqLjcwx8WxeCTV7R2Sv7mdqTL8+DVl9fT+8fLLIeoN8oJyqrq0+94CvpkVvnlhHSgmQcJdOJ8Od4Gk1aleBhznHRIKOxev3o4WbMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759646; c=relaxed/simple;
	bh=+U1w5lqp11gFmcmlm+Wg4Ps/6CZwYjhoaIF/f25Uem0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeTHSDV3mx9t4LlV+MmQ2W0p5th6ZNBIFzqPulYCKXG/yVAllbAG3Z7INsT2vieurBdBtaA4vBsrNVZaIIMXM4A04QYtCQotR0KBX0UDcea+SX2/uC65nQCREV85KunqypogDsZMx8NkrwQ9ORJCrYhGygAzsKjjRVIUJtLeHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYVtzlpc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201cd78c6a3so11078605ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759644; x=1724364444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2tnCr/qe8A2Ag4n2OM5Y/FZMk6hbHME+AokEC7Nelo=;
        b=XYVtzlpc5rNuUlcM28eoFPvAHswFj8s4m/S1e/jbybn677Rt3i0VD0ekrNY+wLALJe
         zm2cNMs1ivGKFT14OQFF1Td0rfktLLlOhJSqImZ6aYGvCG4T2JgMnT+pI4ohMr3+qv+i
         ET7pzDzbvt2C1FY5KUWzbCSmqOdpMWyg7AaVfjaKBvsmGCTSgt5L1l0GQ/ziN/UZGIpr
         1+OKRP4IUyXWqLkJ+0BYqdCDJxxu+EufQiXfBhJxPq3ji91UkuGJHrMd+u2mQXQCAwg3
         gnZh6s7uF8ltIp1Od/o7GJzexSG4pEi5zfFccAm9LhONR0z6xk1UN1tzoDtwIICl2TFG
         qpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759644; x=1724364444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2tnCr/qe8A2Ag4n2OM5Y/FZMk6hbHME+AokEC7Nelo=;
        b=Pw8hA0V6TU51U5D4RMJX0sTrckeYq5gAtYe1wvIFrLg9F3BW8KdB6+3DIZMFjNTAUN
         fMc/tbkxQsQ1UNhAMf8Aao/O0Cov8fVLN26516R9bWPxXkEwuoB8WqjZX7RqfZultV9o
         pfE3OouLbZqIRVTEeP4lidZt89m5XyKW4F8Yw78U+3gixws5XJrq2PSkVvovIv2ro9M0
         peT02sPIrejyPsy9xBJvyyGUzF8AMhdtkUfBVIZ8fxpYQr15fSqVDWchj1VWDGsp+wlE
         qqNV/GJRDLr93+9VR6YoTTztDb8Bu9MWWkIdxWth9HTAanvE8unbGTG7uj9fh6GUleLs
         XRuQ==
X-Gm-Message-State: AOJu0YyQkeEWsG+7QMnK9RZIafsYSzSYKS2kI3a6BlcqFbB9NaQUp8Bm
	bHlf0593m+Kv9JaHs2SANqjS2aEXCjQ9oXNHEZVcdpGRERp+uBNl
X-Google-Smtp-Source: AGHT+IHG5YHlJMMY2vmvR1hVTqQMAoyLAfZuSq10LixyCJnfm+Cym6AjqWU/kg+xdvWeeAHmqtxOwg==
X-Received: by 2002:a17:903:944:b0:202:60e:7700 with SMTP id d9443c01a7336-202060e7a85mr9137365ad.7.1723759644124;
        Thu, 15 Aug 2024 15:07:24 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03767a5sm14547025ad.130.2024.08.15.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:07:23 -0700 (PDT)
Message-ID: <065543369ba59473ae2479957ad318b5bb393c43.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Thu, 15 Aug 2024 15:07:19 -0700
In-Reply-To: <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-2-eddyz87@gmail.com>
	 <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:24 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struc=
t bpf_verifier_env *env, s32 imm)
> >         }
> >  }
> >=20
> > +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment abo=
ve */
> > +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *me=
ta)
> > +{
> > +       const struct btf_param *params;
> > +       u32 vlen, i, mask;
> > +
> > +       params =3D btf_params(meta->func_proto);
> > +       vlen =3D btf_type_vlen(meta->func_proto);
> > +       mask =3D 0;
> > +       if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_prot=
o->type)))
> > +               mask |=3D BIT(BPF_REG_0);
> > +       for (i =3D 0; i < vlen; ++i)
> > +               mask |=3D BIT(BPF_REG_1 + i);
>=20
> Somewhere deep in btf_dump implementation of libbpf, there is a
> special handling of `<whatever> func(void)` (no args) function as
> having vlen =3D=3D 1 and type being VOID (i.e., zero). I don't know if
> that still can happen, but I believe at some point we could get this
> vlen=3D=3D1 and type=3DVOID for no-args functions. So I wonder if we shou=
ld
> handle that here as well, or is it some compiler atavism we can forget
> about?
>

I just checked BTF generated for 'int filelock_init(void)',
for gcc compiled kernel using latest pahole and func proto looks as follows=
:

  FUNC_PROTO '(anon)' ret_type_id=3D12 vlen=3D0

So I assume this is an atavism.

[...]


