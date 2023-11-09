Return-Path: <bpf+bounces-14606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0B7E7091
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AE81C20C1C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBB241EF;
	Thu,  9 Nov 2023 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOv1PS8a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7B249FE
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:43:30 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F7269E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:43:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso184200266b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551808; x=1700156608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Y8ovd3a0XX+JzYlITsjsMozxEnJNhL8cTwGDi3H0w=;
        b=kOv1PS8aTNp8eH1p76ILd67E34zp5aRMXP2PuQsYCtUyzrBG5qiAgDMOdmMPMetnTq
         c8PvnOyh8pW5K2GwMKc5yYELstJ8UD53/9xCNL3ymnfdrSSP72Lz3QrDN3o51bhiGlC3
         Tkq+RBV1SWOxvCvEZ09eL7BuDqd6V9QR4U9pd9kNP8xsfy+1VntOFoW7zxx0MR6MUEwi
         1HpUnIGEdX+Mn0/bNnJpakRqLO9EMebY/JErbQ7UvN57YjF12kln2fioeUoFQcCKbGIf
         S6Hb6r0b+c2IsDH2S7voUVm3jCpLOK5rGSfV/t24Fr03YanpRlzP2JcpOz2+NOfeVLj+
         T9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551808; x=1700156608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Y8ovd3a0XX+JzYlITsjsMozxEnJNhL8cTwGDi3H0w=;
        b=SrSB4K2KoxqglU6NhUmLG3xEys4dlSBsZWHt1psJkl1o3IbFXvJIL5NOILD2gulvh7
         HoVlT1iZWEemOFudh48cbWXN8/dHd4i5bGZJV/SxDT0wvRG4BrUhtY64eCaRW94WuMMe
         YdmbyY3bXfy6ktG9GCif+0lXiSW64T+Dj81CuyQMyf+RHWL8LahXMM8zAV15gLGkUzi7
         SewM2iKkOL0gAkctEusOGE/Pb8csDSJT4aejYR5+fGC0PQjLMzAUVs4FSd/S/WLNsNmI
         GpJJvOQBkPBfxfs3afKyJbwNq2VMjXNpzz6INEWdMBekCybG/r8yAnsuPNVXI46X1yOs
         JveA==
X-Gm-Message-State: AOJu0Yzo/bni3YBek986h3Wg9d5BHeK8L6LqjXaeKzwemqOuRPt+W3Qk
	H6snaPbh1JkoYyVtRxdpdoqKGro1glomMkZOAGE=
X-Google-Smtp-Source: AGHT+IFWBy4NGFXtXd32aV77Q2k7wvg/Yb1kn7y8i69cE9drzXcw5L3yGHhLuNtJH8owN1aXmuqHLkM8bR6DuSuCCBc=
X-Received: by 2002:a17:907:9620:b0:9d3:e48f:30d3 with SMTP id
 gb32-20020a170907962000b009d3e48f30d3mr5328773ejc.31.1699551808503; Thu, 09
 Nov 2023 09:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-8-andrii@kernel.org>
 <38b2c899104ac9cb7009351531787a7691748bee.camel@gmail.com>
In-Reply-To: <38b2c899104ac9cb7009351531787a7691748bee.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:43:17 -0800
Message-ID: <CAEf4Bzat=bHEF30nt95vGV=Jhh9FYiAPA94SK=vLcR4XACT32Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > track aligned STACK_ZERO cases as imprecise spilled registers
>
> Great improvement.

thanks!

> Could you please add a test case?

sure, though I guess I'd have to rely on verifier state printing logic
for this, is that ok?

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>
>

