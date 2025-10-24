Return-Path: <bpf+bounces-72132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFFC07652
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E213F3B42B4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC623375C5;
	Fri, 24 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxmCCltx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD82DCF5D
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324565; cv=none; b=GupSov0ZIfNwu0Zefgc0r+ikN3VMuibnxG1+q6rUgZfdoDrFAWo7D1fZCwyVmqhBmbCCtEJnqjqtG4rcx32WeeunSQ7kgfAQzsURFJC4/Z7FxfCaQlna5fUFGyHJJbAUdLaLGt36j3bZuLnf7kV6/bLTfV7QAgAOlRr1nwankOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324565; c=relaxed/simple;
	bh=sgiY7S2FZHhzhRvgyfD38Eu70p9ExVfmt96bzmbHAUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHLJ+vfP1jPd0oZvaCgIGYuGTCW3APjuyRuFrPCm2m/x0VAGQC47BLJGFgDoupnXZ9ZG4FqWaU3Wa+GigS0ZVbMYIXOK3BPYSzDuCIeTf5R16BDCUyZ2juX1Yii4+4pRlqlM472++lNAH+B3lz4FcYTqJ2/sECjyV4Y3kFR61bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxmCCltx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso2457031a91.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324563; x=1761929363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sgiY7S2FZHhzhRvgyfD38Eu70p9ExVfmt96bzmbHAUE=;
        b=WxmCCltx692iLancAE4VF0FNvEGI5nMDJsYBKdEbp6xcWQXAlTYcD5Ll1aMbkmXTCz
         48RfcPvL6DZd0SFp42+Sf4ied4XJxQzRYuF3X8AxQklTHq7K/d+XZAV/k+D7xm7dlwZf
         4x+jrcLF/Wb3u20WUhcs62+ImK7vA4GkGJX2fJJUWpR5QEPG2ryi6pOiH4lm63Sslg7U
         LMvb7NxmEYxTFgOUtogQGbJInE5pPsR3LtFD+c4/wGla6JlptZuDL1smli0cGPGoasCh
         L5Q1556r+xfsL69riFaSrb3onKIjTflYEKD8orH5iU4Hys4a/yv5RpD8Af7cyk5fLs0H
         MCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324563; x=1761929363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgiY7S2FZHhzhRvgyfD38Eu70p9ExVfmt96bzmbHAUE=;
        b=RS2I9l+SwOWRxxzxN3CFGsmeF5HIoBQazeceGNRwEh9Z2ezINmzI4SoXNQq/WAGzyr
         cg8KR+bLXgWPiei5f2K5mHJV7d3Vw4lQ+/WEDXBx9JQqRD4TLnPsL1F/BLgkMsm1ilBm
         hCZNBLOq1+qc3gsq0xF93SjlAKZBHy2z8JXPMH0VJliBoVUdI/hpfgCDq4sJXoXJpOIE
         3oTym8fzMn+Qlo9x9tbgqQInrx3aVcgsMGIA48JMkl32eptvJ0JVQjZhKayaWHOS/3KT
         b8hyjSiVjM6Z9Fqh28+Xy+Dh8ElgDcnKaqjqAonfEZi3brcPNb80ehDcC/s/zKtrctrz
         OTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXuJ5k94yBvY11JQC1rrkE+CqFD5ppHqQ/gM1zh2oPimaxuFahfmzdRzcy7gh8bCcSEK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztujsH01gHvZdAOpMUBzjBmwxAYhv9CVPo4PftWpbUjMvBa0bI
	6Q/8FRQ7dvjPTJTKMyNoZ7OQzFGEUbxTqUpq6ws1KQH2WV/VD3HK9wYJ
X-Gm-Gg: ASbGncuTrtFLSMw+70e4p4wUGsXMpzJ9vTDJZ9Ivh4FovFEweBOgwmJTJtJkEQHMFp7
	Wpejf4/4BGzWQYBNJUelmNJBI8Ovp2fo91JlelD1yKu92CnyykOuhRpol594hMm3npMg1iUqMnk
	2FrFuoQp9uaZRp5B9HcaYSSXtKBNHcFMrepZtVJr6S+so4o5uvBA+fXqp6Z+RtUiPo5bAsxiojJ
	SpKF/Tx4BoGjEJKcxgIQCGZnkzHT7UtXUWD/ajTGta/TTlEQ6Adtluqno1efJEe9/Ed1XIiRJyc
	AInMBFDUxt6wShI6abWMVu7G6fNZV1klW6ReT07oPoRYeeDyw1kHCJ/E+pPYZkWU19bu/V1wni8
	zTEsDcYeUUxKGNNEm+t9yJUBotTm+BlqJNnqlaerEGIMEHgcrk8bT6KhGWqJzueAP5MeMw/kV8m
	NjukP4b3K5
X-Google-Smtp-Source: AGHT+IHI2qhxubh7aw0QABZnXIzYjudD+7z4dciJffBCPR+S7LPzwfRZbX1c9jX24fep6cPAloiInA==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-33bcf8e61admr40559172a91.17.1761324563105;
        Fri, 24 Oct 2025 09:49:23 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c3a6csm6079076a91.5.2025.10.24.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:49:22 -0700 (PDT)
Message-ID: <31a2e1d259485c8d6ae0fa33801e94057f4b47c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add ABBCCA case for
 rqspinlock stress test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@kernel.org>,
 kkd@meta.com, kernel-team@meta.com
Date: Fri, 24 Oct 2025 09:49:19 -0700
In-Reply-To: <CAMB2axOs7-0=BX5HVwYgvGzDu7z2k7UrnNAopCJ_Fq6Vjj8seg@mail.gmail.com>
References: <20251022175402.211176-1-memxor@gmail.com>
	 <93e428555500f60c3dbcb04b79807d3ffce024c5.camel@gmail.com>
	 <CAMB2axOs7-0=BX5HVwYgvGzDu7z2k7UrnNAopCJ_Fq6Vjj8seg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 09:42 -0700, Amery Hung wrote:
> On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-10-22 at 17:54 +0000, Kumar Kartikeya Dwivedi wrote:
> > > Introduce a new mode for the rqspinlock stress test that exercises a
> > > deadlock that won't be detected by the AA and ABBA checks, such that =
we
> > > always reliably trigger the timeout fallback. We need 4 CPUs for this
> > > particular case, as CPU 0 is untouched, and three participant CPUs fo=
r
> > > triggering the ABBCCA case.
> > >=20
> > > Refactor the lock acquisition paths in the module to better reflect t=
he
> > > three modes and choose the right lock depending on the context.
> > >=20
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >=20
> > The overhaul makes sense to me and the code is easy to follow.
> > The only nit I have is that test does not fail if deadlock is not detec=
ted.
> > E.g. if I remove raw_res_spin_unlock_irqrestore() call in nmi_cb(),
> > there are stall splats in dmesg, but test harness reports success.
> > I suggest adding some signal that all kthreads terminated successfully.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
>=20
> Maybe it should be another way around? The test must and should have
> triggered deadlocks, so if we count how many times the return of
> raw_res_spin_lock_irqrestore =3D=3D -EDEADLK or -EITMEDOUT, the number
> should be non-zero.

+1, that would be a good thing to check.

>=20
> The test looks good to me otherwise.
>=20
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

