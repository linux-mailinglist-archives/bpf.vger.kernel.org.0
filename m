Return-Path: <bpf+bounces-29788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563148C6B43
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8E01F2503C
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54752157469;
	Wed, 15 May 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3uvyMRy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760447F63
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792565; cv=none; b=IF1j1Z8Lh2O6r9jS1eQDmfAZYg6Pd/IoGTuEaid4Ppt8Ho69kG4EGG3nWctxkmfsHzwzt+Kz9WidF8fnoYFZNpJz/VdvWL3LM5AXT84KrwCZrplqDWLSS3lBmD21wZma5U0YOOzEaNFA/suODON9oHBXTlaArcq/XoozxSWSP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792565; c=relaxed/simple;
	bh=7OEf8zJV8DEwbsjhDg/GY+8G5Ko52ZH06IrbEHdKM8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey/PRvwQn4Tilyrtaghc6qUK1NmmjGAXUa8xQzlG/nF7vjHx6kWW5wAGQpj+C/O52HzBxDr/AkqZUs2thJVgkatYk7ZxUc12dddu61n0h8ObhIP1xYIJSoI327Woq7j1f5Z+2pxZXZPSJbyc9MoIkruXqA++FRyJAE8LAnTpAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3uvyMRy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351d4909783so49129f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715792562; x=1716397362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh3m3XjTL2DoP4DTOrEzVeyAHuwM1Po+gOqYm7QrQrc=;
        b=C3uvyMRy5vAsZ9/S9y2Om0x9l+isnxbd/e+PBOolOG63VMTR5zuFBTzdgJ41l8mdNT
         LnGzIF00WsWCxHPegXdYpCNmSME9o8TYyq5Vf1c19lONbsLB27fhOIZtRuklE6GNuypP
         VnTbJvyd3LcOS7KbzNhh6lS/LYNFw+1Q6iXYvvdLuSUYtU1MgqXV66aRiuAs1zzJDzYI
         k4WSlPLS2Dgi/fp0Q8GU4eRxn1kzv+PXfiB0CZGEOfaVyF0DJnpUzAhpKTR5fxPod+Pe
         Y4ZAnpi1e2gg79XWzU/S0ZUdVQ3z4VhsYTQYO7qZcVJF5/JRcnddpKSsQDaSQ49BcOo6
         N6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715792562; x=1716397362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh3m3XjTL2DoP4DTOrEzVeyAHuwM1Po+gOqYm7QrQrc=;
        b=rWviVnUMLR3y4iA+6cfY1aFuSdBcSmumftd3qQcQMoRuCqs4tFX/bm0h5EM7MUEyth
         VQMHLPzQV5wy2iTK46CasTKaXWltY6SzXobahg8OV6rYyEXhI/SyNlH/Yh6KiHIzNgGU
         FBkG8wPAA5FeuhZOEOCx0ANDVKxw961BegIuJrz4uBEOxBSsgJc/hBcD7CflBrJ/VADP
         P64bOXK/w4oxnJv9NOAPouvrd5VkMe3xodP37QQMfubdEpTaYc/eoW0dyMf8mKMmJG2P
         cOIG82r6Jx1d+f4u7yKZ3dMGMRPclmF5V35HN6uBfEb541qdz/TPpBSyaEt2x7VGHNfw
         qUcA==
X-Forwarded-Encrypted: i=1; AJvYcCU07fIl1jiYH+7SXt7N3fZaxZttvZnhGlgPMBe77NgG/crBrj6esY49Fuvzm2S1D8UH9t2EluqM5hsgqWAqFMuOarqL
X-Gm-Message-State: AOJu0YweK/qZX3/APkWk/sA80cbXx8/GxUurRFvWAEV54lTg6pc6lXdL
	C8nkhveq9s2J3TpY+uo8SqShWvkRP/ciMlnqNtfbg5WgKBl3h1nOWjYMmI2hjxXdBzIJ0BpUNI5
	qEVYSC9C0NZlOHLG09EO3nN0F+us=
X-Google-Smtp-Source: AGHT+IEqr18heC6tfO8yQFc3E3r5+io/W4og/hPEB8HQDlo/LrENYuUPKWDJUmqKQfVDFEMUhmLuINn9ECJ0NU4WQmo=
X-Received: by 2002:adf:fc89:0:b0:34d:118f:21ee with SMTP id
 ffacd0b85a97d-3504a6376bfmr13297435f8f.28.1715792562226; Wed, 15 May 2024
 10:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514183914.27737-1-puranjay@kernel.org> <2fc3b4da-7218-4a79-aef3-152297c37926@huawei.com>
In-Reply-To: <2fc3b4da-7218-4a79-aef3-152297c37926@huawei.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 May 2024 10:02:31 -0700
Message-ID: <CAADnVQ+KKxVhDGKr3KDCam=SrTqas3rDJVSPSy=3QVm2w1q1mw@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: Update ARM64 BPF JIT maintainer
To: Xu Kuohai <xukuohai@huawei.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Zi Shen Lim <zlim.lnx@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:22=E2=80=AFAM Xu Kuohai <xukuohai@huawei.com> wro=
te:
>
> On 5/15/2024 2:39 AM, Puranjay Mohan wrote:
> > Zi Shen Lim is not actively doing kernel development and has decided to
> > tranfer the responsibility of maintaining the JIT to me.
> >
> > Add myself as the maintainer for BPF JIT for ARM64 and remove Zi Shen
> > Lim.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 05720fcc95cb..95beaf4dccf7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3722,7 +3722,7 @@ F:      arch/arm/net/
> >   BPF JIT for ARM64
> >   M:  Daniel Borkmann <daniel@iogearbox.net>
> >   M:  Alexei Starovoitov <ast@kernel.org>
> > -M:   Zi Shen Lim <zlim.lnx@gmail.com>
> > +M:   Puranjay Mohan <puranjay@kernel.org>
> >   L:  bpf@vger.kernel.org
> >   S:  Supported
> >   F:  arch/arm64/net/
>
> Ah, I've been working on arm64 bpf jit since 2 years ago, added arm64 bpf
> trampoline, cpuv4 insns, and helped to review patches. I would appreciate
> it if I could be also added as a reviewer or maintainer.

All the work is very much appreciated.
Feel free to send a patch to add yourself as a reviewer,
but fix your email first. @ huawei domain gmail classifies as spam.
So "R: Xu Kuohai <xukuohai@huawei.com>" entry
won't work well for many users.

