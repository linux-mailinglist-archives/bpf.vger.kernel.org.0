Return-Path: <bpf+bounces-53259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F200A4F239
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED907A7D1A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2974C92;
	Wed,  5 Mar 2025 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WniGFjPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF82E3369
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133664; cv=none; b=gkIse9x987MTsz5894N8yNutPcfEL55pixI5RYaOTSaWzs/eCxBXyT0Y/03UdjGR7mHLvEh9UD1+nGQNReiAyez3fg1WWHXkYi6Zu9yAhw+1IgmXccT5l2TSthNiasVjI59UYgbbHmOHNatF1ev+RHyRuVihz4QndwD4qQICJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133664; c=relaxed/simple;
	bh=JfttwXL/bzuU1IJHfZlcI5srOK9yQtYJDXmW8qxgrLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p31uyb0Its6L2p8aqM33lNyIoZrTMIOQjyBNG8/5793fGDEDmskUhHq1Ly110D+9PN2JAC99vIEprDV54cx5NxBzJvyRzr/tine5UqAgs1Gt4NThfRuxy8lz9ihuIq/1vDkiSafNpNmC4w12EYNEggcGE96ydhHfn/T+CIIFcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WniGFjPm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223959039f4so68584365ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 16:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133662; x=1741738462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ufvIvwL6E82Fn0IylQCB27Egvd4/pUjirnu2h/dl3s=;
        b=WniGFjPmpnP1TFfDv/hy43H9HZCmMTm8TeNXjHLf1tMifV/YVeQpf9JZALHiFxgkQQ
         hruTtEJLRSGh/sL08EYz34xj/mV5vjkcn1b25rfY4aX/auO4XFi9CcDzaLvr+hBFQj5R
         0ubnesQCkl/hu024Edom1OIj7M1NZStp42g8QYEIiA13A/m7SQP9f6Bz2xc9qqSquRed
         T1kJgINY8EGWHy/5N/xLJ+2WDl6S4U2FpApkh1Q/Dfn1m1/UtTLzuuQsBQaRkgs8CQd4
         DQz6TmxrRtI78PWxQA5Hb3cglqizUXSxt2aGsKrTKdQVAfvDORj8WgKaA+VA77cM5Qls
         wYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133662; x=1741738462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ufvIvwL6E82Fn0IylQCB27Egvd4/pUjirnu2h/dl3s=;
        b=NXjgMaGNkxZSNEteoYida8MbRSkkVnc8rRhUVKNAQnXOoJyUXY/Xx6L1AvovuOCP74
         tEAOVlDuyTmmHeZ3GRVpJBs9N1SVuVpU/5fKgbDpBTGMdfWBJ7v6k5A0fYPhozcnBFTm
         8+iWIemK5R994ybHpLBiuCA2UnIDtMPoxJyFdOK6xlEpSOLDxvgrxk3YtoOV44cp2/+j
         R/C4I6iejvc03AlaFMtCND7jQPt7t0sS8RWCi/zPHniILjMH1LqtvzZ5Vy1EyTXI295F
         +bhg1a5bipkDDoURcPzUbqKcrM95AwXSSgIOX9wSNg5UCc0+vqVCnsI4vec75r79T05b
         o3CA==
X-Gm-Message-State: AOJu0YyY1UQ+vCdiNMVC2LgUCf4CYWWwBK3cSTyMG+kXZ0o4Dmi/nJEg
	4dpZ7Bm/imY6TgmtJb62NBUz0893zOFLzmxmkZL8tMYF28SueFHE
X-Gm-Gg: ASbGncunrYYJjc5wWiKXeiXWctc3bKwKgsyjQL3fLlnNdo635e/pk/sVMKMsbVNEJph
	SQfJRIaglBugzHg/I9EhqLl/7XlSYYpjqRc0uGIy+drVzuRffLOW695jyuN9QFJDIAXMJg8HHWS
	5j/609BLSB4Ff40RdJO1zKHTTtRci4NjvQX3b0RX7fF3NsWP3JybTjmuHtsaGM+MgLhIY4s4dU8
	LUBAzRTtBRZ1zOIgH2lTxQHSlzoRbqSC0IZ3LPRZMMupNQxAgnXc1+G15JbDhtIefM6eFhuvvWl
	F6i7VGgZKgXO4RDtYXSaNf6BwCbRomi6wEUydbQ9Mg==
X-Google-Smtp-Source: AGHT+IG4Pqc2t+tT+FVJKu77ATGW4mX25+y1pMLbRo5p0/I3cYHhr4RhnKPUvyo0Ds1523R7ugvKBg==
X-Received: by 2002:a05:6a21:7001:b0:1ee:6ec3:e82e with SMTP id adf61e73a8af0-1f349593e7bmr2245551637.29.1741133662463;
        Tue, 04 Mar 2025 16:14:22 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1a49esm10782706a12.17.2025.03.04.16.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:14:22 -0800 (PST)
Message-ID: <b7450cf543a69a0192f2e9af86236ebae8eae94e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Clean up call sites of
 stdio_restore()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Date: Tue, 04 Mar 2025 16:14:17 -0800
In-Reply-To: <CAMB2axNvqyr-vnv5WcMMqykq6sCdnNYCOP4z1wsvO1GtrwGQyQ@mail.gmail.com>
References: <20250304163626.1362031-1-ameryhung@gmail.com>
	 <891505bc040c9dd82814889b2da52e299132cc89.camel@gmail.com>
	 <CAMB2axNvqyr-vnv5WcMMqykq6sCdnNYCOP4z1wsvO1GtrwGQyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 15:39 -0800, Amery Hung wrote:
> On Tue, Mar 4, 2025 at 1:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-03-04 at 08:36 -0800, Amery Hung wrote:
> > > There is no need to call a bunch of stdio_restore() in test_progs if =
the
> > > scope of stdio redirection is reduced to what it needs to be: only
> > > hijacking tests/subtests' stdio.
> > >=20
> > > Also remove an unnecessary check of env.stdout_saved in the crash han=
dler.
> > >=20
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> >=20
> > If anyone else would look at this commit, here is an alternative
> > description:
> > - functions reset_affinity() and restore_netns() are only called from
> >   run_one_test();
> > - beside other places stdio_restore() is called from reset_affinity(),
> >   restore_netns() and run_one_test() itself;
> > - this commit moves stdio_restore() call in run_one_test() so that
> >   it executes before reset_affinity() and restore_netns().
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
>=20
> I can improve the commit message in the next respin.

If there would be a respin, otherwise no need to worry.

[...]

> > > @@ -1943,6 +1938,9 @@ int main(int argc, char **argv)
> > >=20
> > >       sigaction(SIGSEGV, &sigact, NULL);
> > >=20
> > > +     env.stdout_saved =3D stdout;
> > > +     env.stderr_saved =3D stderr;
> > > +
> >=20
> > Nit: why moving these?
>=20
> If we assign env.stdout_saved at the very beginning, crash_handler()
> can just call stdio_restore() without checking if env.stdout_saved is
> set or not.

Understood, thank you.

[...]


