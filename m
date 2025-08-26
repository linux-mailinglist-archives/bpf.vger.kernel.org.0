Return-Path: <bpf+bounces-66602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC8B374E3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28ED1787FE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35327D786;
	Tue, 26 Aug 2025 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwiZzJom"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE71E89C
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247504; cv=none; b=pi5pskdng852dKj6U9CuieMNxGyGMTdrKToHF2op+/lkNf5Y3mchhFVGHL8PJf4mGY6IIrqYgvIcNeVQrW2MpzxnNGCWf0JBEUu4hJ0hSQrJW1IpZol8SqnGGW6D2XJ8VSQVLBpTqX45SUM5uqpQJ72JTYLSFnxDCA2OGuupz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247504; c=relaxed/simple;
	bh=RfkwD//fVbtKN7T1ul50BnBezHKseZI9B1xnIT5rEyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbEFpVXus33gTQRaVSXiuHdv7zkEG8KYMN4ca/+qeK4UCPmrPiTDUb1vunIg4U3t4v9SSyKUfnoPKiOuF1f8TaB0NWJLlEvsM9ne6QecdRl0svRWrSKFKWSiUbtENw4mySkHJCiLZgh+baeUoBFXK67SwAdlMWZ6wvr+c0Gh9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwiZzJom; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2469e32f7c1so22990195ad.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756247502; x=1756852302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bqiWc8IUMM7QXsjsuI2jDP/jXsEvh1Kiir9ntnJEqMU=;
        b=AwiZzJomh87bLr4R0hbdte/FqnN1iKG66AOKx6bDP94LOps4CWk3wDmUwWfCVyK45r
         JI/JRKjhSfo19xuj7AU9Q8RxkRgmsF2AcJLGLW1kM/sYC+rPPpN+gPvdLfVUqjNd20MV
         wAvistys/1D660fYHRpo+lk+s/4IYB8VyTFxiGKYoumN+COvKsdx0cy+mH3qmXTwm3uv
         wuJmy0xPFohI4oovs0it9gZ5u6yP/BnEyfQUUxWewwRf0Zx9qfwfUO9ne2GxrdNaJb7D
         4tknm6VqpPNNP06TyfQoSsDdHPnDL9uIyCa4WcDUCnahbSKhn0GsISOxd4r58mBLQD3T
         IR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756247502; x=1756852302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqiWc8IUMM7QXsjsuI2jDP/jXsEvh1Kiir9ntnJEqMU=;
        b=MLcyWEZ2pl5E0R7edxqZ50ul57QjzxaK9VmAYpgg9K/pTKPa7jRYytpjtR5PWI4yTa
         +jFttV+IJnyQJVP3lUWdVqJF7rL3MyJwf9owllYEA6y/Nfu/734/8pQMO2DuqOOv7xE9
         Gj316FesazCxT50lRD2gJJP1syuYJ3YhWmlgNtbY4VStERyoFYBMX86/Dmq020cPdNgO
         1YXEmBonPyxsCz8RqPmcv2+b1L1/hq2gWQLGr4Hbnvho8RdEWkhia2pmfbb19F+PyYH4
         0Fd91v54mQ+JGK1RGLyVdmVoIbMkxtsaUZIlz2h+6VIeoDBd5LdsSdPMfbM3h7osR/SY
         Y9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWogON/rfwSVypgt4WqyiTMLWd1U7bVk6QjBcwPtLYtw/COKvkk+1EG0rKZTBumhmtzok8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoT5msJEb4OVztEjXASPIIFyRWaz92WaN5rMB3esaN06Kf4v0
	gVE4QrGGxrfo2tWklHr7TTaKqrdfjaZFEVuRAWVObE22UiSqdozigFd9
X-Gm-Gg: ASbGncuqrFW0svzKDTpODIefCiHl+p0/XE83lQcf9iOFJ+41i7XwausYzTcGYNYRSQB
	BZv9Q8MG3T9frXRmNTD/QQ+wbtTS55h21NMQrDfPKXtfLonm4350FHwGWWXBWnXfL6Ep/Q3lGPz
	pC4OeADzqm+SAaPM7cOVz4AIlRWhrCnfqgNVWu9Pbw4X1yuunltoLAGBnmeth7M/+xAmM58C+Fq
	OZ05CA+LzCO7ysOlUUU9ew/XUv+//ct3HsGvWJaLwL0zLdB0fbRLIcRnGG350SyIcxc07iMicoW
	P63rgDH02RsQd8zOlecRnBFYVRz3QcpVqLPtaBV2GoMFCU5qPvLbl+qFeMvLHCqnig+siD6WLHh
	JMo7PrAtJxBw4HW3RGPEy9K0o9u9GTw==
X-Google-Smtp-Source: AGHT+IFc+YHkeHCTo7+ENs+3yDmq/Dh3eNpTbtHM6c60IofEymn2UR5UelBSEb9kgLrO3VliYS/DWg==
X-Received: by 2002:a17:903:4b4b:b0:248:9348:965e with SMTP id d9443c01a7336-248934897bemr12700135ad.9.1756247502083;
        Tue, 26 Aug 2025 15:31:42 -0700 (PDT)
Received: from [192.168.28.36] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885f2c1sm105348805ad.73.2025.08.26.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:31:41 -0700 (PDT)
Message-ID: <10876516b0da85f1d167920a76616b191a4f894d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add case to test
 bpf_in_interrupt kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 kernel-patches-bot@fb.com
Date: Tue, 26 Aug 2025 15:31:36 -0700
In-Reply-To: <312530ee-3f80-4f07-a533-7341bc1d09a8@linux.dev>
References: <20250825131502.54269-1-leon.hwang@linux.dev>
	 <20250825131502.54269-3-leon.hwang@linux.dev>
	 <c37eb846e94c11b74301a699b64037e9d247ba9e.camel@gmail.com>
	 <312530ee-3f80-4f07-a533-7341bc1d09a8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 11:05 +0800, Leon Hwang wrote:

[...]

> > > diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/=
selftests/bpf/progs/irq.c
> > > index 74d912b22de90..65a796fd1d615 100644
> > > --- a/tools/testing/selftests/bpf/progs/irq.c
> > > +++ b/tools/testing/selftests/bpf/progs/irq.c
> > > @@ -563,4 +563,11 @@ int irq_wrong_kfunc_class_2(struct __sk_buff *ct=
x)
> > >  	return 0;
> > >  }
> > > =20
> > > +SEC("?tc")
> > > +__success
> >=20
> > Could you please extend this test to verify generated x86 assembly
> > code? (see __arch_x86_64 and __jited macro usage in verifier_tailcall_j=
it.c).
>=20
> I=E2=80=99ll try to extend it, depending on the specific x86 implementati=
on.
>=20
> > Also, is it necessary to extend this test to actually verify returned
> > value?
>=20
> Not necessary =E2=80=94 let=E2=80=99s just return 0 here.

I mean a bit more broadly, make the bpf program run in an interrupt
and outside of the interrupt context and check the return value.
If it is a small wrapper around existing kernel function probably not
worth it, but you are adding custom logic with inlining.

Basically same thing Alexei asked in the sibling thread.

