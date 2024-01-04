Return-Path: <bpf+bounces-18976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACCA8239AC
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D460B21C72
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC2382;
	Thu,  4 Jan 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGemONSg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B4364
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d560818b8so82367965e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704328225; x=1704933025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzAGin6cTVBbyD6azCJ4LfLuwRsoj3XQoFBbD3ahuuc=;
        b=XGemONSgnWq4mvIjTZbmIH1Bu4bj6unpp1v7/kqn7mpWvjvbL1cGb6sFpvNypZHV+1
         /TJuScfdrwj1ZhGBbv/ge+lsad3phauAFT16N8tuuBlZ1houIZFMLH2uOdv8g+uqQohY
         iUTtbtWWNEjTw1K+v4it3SD5g/0sbHvSzl8pm7vMaLjYyADPIW5MrgZuhIbJ1/CvVsIv
         zMkwyC1666PbWvWjLSyrNqXqzoXnDx88Pi/WYMPDZybIRJm4OYcL2IAcEXJaYb0M+vYX
         skhacqBRcbzrlejOoKL5RdNJxpusBlyxzhIpquLrwCruYjo0MT3fUy859p8iGCYket1C
         iA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328225; x=1704933025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzAGin6cTVBbyD6azCJ4LfLuwRsoj3XQoFBbD3ahuuc=;
        b=A4cjODFTkjOGnopIaWEpJh27m6NhxZLBP0QRiHcr2sVww5qJpy7XeaaTCv7t2YWrX7
         IywtA+s4cvGfgTSW00+ZsTkkD1iLQYTMz9Ly09V4NWb8+LtoRdSSoBlVqESQzl445f75
         IS9vDkdc5M9pj4pDsNTMuplZlo0ln9yFy9Q1G5woS3c1a/WXZWg3XDf05MHPSYGQa4BA
         SWzNCUQLM/GnooN4iBqqWfDDhx9afO485M9jMYWKSVDT7VC0gxR5zO7U9Ffkwsza+0nZ
         AgeJ9dls2vYnNBF3GXaejaxSfH8xCGxJ9Wa1hDD0oEgZOGtbOw/HroeAdQsybTDAganf
         O4Pg==
X-Gm-Message-State: AOJu0Yyqr5fg+gsgOHUExaBGK536gLpP+m+vRDBJpw3WEkhPcMtUF60G
	zUHki47hJo1aNjxEn0LVUUk6opmCTHQfLbR/xjg=
X-Google-Smtp-Source: AGHT+IGkKffGGBPSwAonYoQHPaSvKruLg2bHMsBNICCGImYS60yazzYEF66H7jQs91ITnxTzqv7LBTRu8e4bA49jiVo=
X-Received: by 2002:a1c:7203:0:b0:40d:5be2:55bc with SMTP id
 n3-20020a1c7203000000b0040d5be255bcmr7151898wmc.83.1704328225288; Wed, 03 Jan
 2024 16:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-2-andrii@kernel.org>
 <CAADnVQ+XcewF3aQm1itG_8GDOEbgRZLknYPyK_JuCjzQJ4=+_w@mail.gmail.com> <28d03d76c70881a739f2f0b745da1fba131d486f.camel@gmail.com>
In-Reply-To: <28d03d76c70881a739f2f0b745da1fba131d486f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 16:30:13 -0800
Message-ID: <CAEf4BzZNWfN7XNSxTogjjxJODqNL3Gi56=LAmtbo9nXih4HB1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] libbpf: name internal functions consistently
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-01-03 at 15:12 -0800, Alexei Starovoitov wrote:
> [...]
> > At the same time I agree that a public function looking different from
> > internal is a good thing to have.
> > We have LIBBPF_API that is used in the headers.
> > Maybe we should start using something similar in .c files
> > than there will be no confusion.
> >
> > Not a strong opinion.
> >
> > Eduard,
> > what's your take?
>
> I kind-off like private vs. public method encoded as '_' vs. '__'.
> But this seem to be a minor detail, personally I grep header file
> each time to see if LIBBPF_API is used for certain function and
> that is not a big deal.

I'll drop patch #1 in v3. This whole naming discussion is just a
distraction in this patch set.

Long term I think single underscores for internal functions is the
right approach, and makes working with the code simpler. But we can
save that discussion to another day.

