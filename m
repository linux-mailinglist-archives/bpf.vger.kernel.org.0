Return-Path: <bpf+bounces-59843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35511ACFC7A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926073AEF6A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9AC24EA9D;
	Fri,  6 Jun 2025 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQnMGtUW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C871E1A3B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190919; cv=none; b=ZqY6aKpy+iz2boPr1Gv8k2x/VaXSkRPaL5O/5UQQY/WQrfCv8FwkFHGR8YDZQ1LNFRE2pec0ARb4Pw3YTQ0SINvmRV3rncU7thfL3FlfzQW1CCNL2hdmCr/vNd337bUkqqAS6vR905BE3tcoiEJqx0aoFkpfzY5oxOA7NuqjvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190919; c=relaxed/simple;
	bh=/hhxPKyV8c7R5WACfSoGjG5FxM2Pcy7H7mzTrEBAWvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJ8/yL6H1bsGtcV0p6A6RmWNYu32cfaAC0xQaMvXTLhl6njlYjiv0b0Tb3Y6syZV7zocDpD+WN+oeQfhqu44R2U7AxPdczYI/eW1/dN60nZ6mv+eVdsK10nz46F4daE99yZ/Xqja75Fm3jJlh4af7/NWFbqRQ21rjsLhkQj5Pf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQnMGtUW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43e277198so14314091cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749190916; x=1749795716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsBMtfbagVpHr2dWUudDAezMnERXc8jN5mmlbFaIuMI=;
        b=HQnMGtUWRNYW1Ra+BlcGaVdvg3UN7hXU48xL1tKnCfy8Wu40BoOlcY5JO9nRvwgwar
         vxdP8729uX5+STQi0/R9dXt1XF4PByR2A9ngmhQHieqBClyeNykPXtpV1fwv0xJ9m3CR
         IImLRbdpqZjxAkJmfQ+cDgo7BzOwniwiHEbcXqqlnt/HmdAAnlDVKQrhMa00u9LrG7qG
         ovuheDUXiXracDuD34K+5MVvbIkYGTWqf+f4Vz61qFy3gDsMI9HUAjmkk8mmQt3Kx7Vq
         TIHbRXxiLlgPs3AfY9/901/4Jviiu3ZNwdcJyVqc4LNGbfwHtLv7Ur3GaTPKlFHoBH6M
         5zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749190916; x=1749795716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsBMtfbagVpHr2dWUudDAezMnERXc8jN5mmlbFaIuMI=;
        b=TbOuBMrms/waurCrsT4pK0Tq6aaM/xWBia+2rxE/QB1aHys0Cxp0NU1/Dz4a9hm2OZ
         iIrXePOCfHuiwSJIXlBwHr4OT1ftor+5mCUCGl7tGQYRPj+slrZlrgWBoTYEYoa5RPFe
         rfl92Y+KMVffEZyD3bZylEyFxgUk+TJLwIX1Gl4v2FACDMpoBCiXyIraUTgMXMGWelhP
         PVr/wZaOtjd++PFcBsWaFLpND1Eb1aSAgw7+Ni2qrILwDedlScPmIv6FOU5v3YNhAYXF
         GwbyU5FFhzNEY0o18IDjw7tefxjLoiSpTMpVlIXenSkYGVu2uJAIVLz8ILnKkuZOof4H
         3oAA==
X-Forwarded-Encrypted: i=1; AJvYcCUfsbDwtVGUZF23vktkySuxTtyrHJaV+b6VreNWdvkNJGWMnSZjytxHxeGuNXmIKox03GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnR4RXtAjuNvOlczIArnjgL1gRv9SvBj7pwCe64ypk+T3hmMd
	3807RcRe9YHr3Un1tiKbprIHUmS0aUNXs6qqqFZUEIxWCsFIFBycD5nIFbx3k3opJonsuXsT3m8
	pAtsgMjpdBg3IEVRNkle+hOdYbvKtxfWEyumpFG4X
X-Gm-Gg: ASbGnctVzCzQhfhGaJCX6UPwzpt/XKzzm3JuBNSKGF0MZqnovSS4J/eOBa2SsttWmEA
	QfARNkoqAK9xYeAMqxAgySGxCwmumPzTr2f2ryxNgpW2u9wy91jkFZK4f0n25ssWfdx6tr6AC01
	YyYN1l7QXf0vGE3KLz3LesSBMzmRb4ormorQQ3hD4nMgHpTc/swZ3PvOGcyZfdQ3sGV0Ze9+gb
X-Google-Smtp-Source: AGHT+IHSnKSNTajMIDeaip5sd8sIZfLqFKnW5zqtsvkLtQLXGTWBXvW+v3e338cE6mS/LSFh7KNJ0hL2rtVDd3KBbrg=
X-Received: by 2002:a05:622a:488a:b0:4a5:afa8:b3f with SMTP id
 d75a77b69052e-4a5b9a052b9mr43763231cf.3.1749190916414; Thu, 05 Jun 2025
 23:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606052301.810338-1-suleiman@google.com> <20250606053650.863215-1-suleiman@google.com>
 <2025060650-detached-boozy-8716@gregkh> <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>
 <2025060620-stainless-unedited-ddfc@gregkh>
In-Reply-To: <2025060620-stainless-unedited-ddfc@gregkh>
From: Suleiman Souhlal <suleiman@google.com>
Date: Fri, 6 Jun 2025 15:21:45 +0900
X-Gm-Features: AX0GCFvRUMvIRxLmq81-oToKmXjpNnaQGe54t1cYDvCDvW8q6W4X7-0XyGhmifI
Message-ID: <CABCjUKB4OgQoGv+Eg7q3zmJXXw8dWfEo_AP-XfzxHDoodtxhXg@mail.gmail.com>
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:20=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jun 06, 2025 at 03:08:09PM +0900, Suleiman Souhlal wrote:
> > On Fri, Jun 6, 2025 at 3:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> > > > When cross compiling the kernel with clang, we need to override
> > > > CLANG_CROSS_FLAGS when preparing the step libraries for
> > > > resolve_btfids.
> > > >
> > > > Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." l=
ogs
> > > > when building tools in parallel"), MAKEFLAGS would have been set to=
 a
> > > > value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> > > > fact that we weren't properly overriding it.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids =
as host program")
> > > > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > > > ---
> > > >  tools/bpf/resolve_btfids/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > You forgot to say why this is a resend :(
> >
> > I wasn't sure how to say it. It didn't occur to me that I could have
> > replied to it with the reason.
>
> That goes below the --- line and it would be a v2, not a RESEND as you
> changed something:
>
> > It was because I had "Signed-of-by:" instead of "Signed-off-by:".
>
> Which means it was not identical to the first version (a RESEND means a
> maintainer can take either as they are the same).

Ah. Should I resend it as a v2?

Thanks,
-- Suleiman

