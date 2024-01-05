Return-Path: <bpf+bounces-19109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA49824DB8
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 05:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A81F22EE1
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00725234;
	Fri,  5 Jan 2024 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODj4NVpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BF5220
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3368ae75082so88819f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 20:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704429913; x=1705034713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BaGUUr1CINH8S5L8V1hJ5YXZpaU0nB18jDwzAX8wsk=;
        b=ODj4NVpqnfIhmPDrZm2SRMFggFGvlsZWDNwcOy3Cyez1l9iq8XZGMC/I9SfrPaYWy9
         0nj3loSYbveAoCO4S0bS3TDIRAVeWRRwoR3pMW0h4YEdXhu6OCz8evmK5ssQlUSnU98G
         FB/4D8N+rmoS5jwtIjdhFTI+MCkwpSWjqsfyEH6L5g44mayqmjcQ1qjE8e3XJm/YoGfN
         J1ccRBFWbHxN+wfWj7AD+I0Ev/+pDU1E9wA2lhUQSobK0ZeYhCNX4VR5UDglF7ejX+91
         nedGz4oCCcoN6sxIJ1ADg7MkpEpam8zx5hV8XPPe+72y0bf6nbzxU6NQE/KoHH8oLrTw
         Xl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704429913; x=1705034713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BaGUUr1CINH8S5L8V1hJ5YXZpaU0nB18jDwzAX8wsk=;
        b=ZXF8hdL+iqwg4+AIuu+/4VjMXJ7Y+l3MBDdLzM/IO9t1MBQcvVJDD1PRotZGmway1w
         oGStnuJVyCOcWpn2k17FEbyp9aMtsODQyTHnB+wL661QBhubTMbEbIFdsBFiwNxO2BSC
         7/jwBUN+b9NkUxsecjOv1ys38zVLDIUB0/krYYDG/uhftUdKB5l0imgZnbHFfN/Gh4ku
         /ZnbDNKMC6HY49rIj1NlyE8r4Bt5srW4L38KHPNS+wTefRbSKPDhjThEtDWNYTHjPQbU
         l6Dd1nACkI8G9yzrRd9w9UiJ0OnWME0yuC9cOFrQcq9CLi6yiON5QmG0YF0euHrQGbC/
         TLjw==
X-Gm-Message-State: AOJu0YwL1WUOgsYGD3sDYawBamdvXvndZt3RWCk0GN0KubkuF9wFv2Pi
	BXpv8ZRTCJ3hqdKNQBlZlpvDTmPxLz3a5O76NbA=
X-Google-Smtp-Source: AGHT+IG7m78cftHzSTWxLhQBnqVkpToz7XBPnyjNl2RIQChQ2/n7w4Pe+sBXySHXrRzm2+AqafCpVPD5qsECOjIkMX0=
X-Received: by 2002:a05:600c:213:b0:40c:6b2c:a1c3 with SMTP id
 19-20020a05600c021300b0040c6b2ca1c3mr844640wmi.178.1704429912963; Thu, 04 Jan
 2024 20:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103190559.14750-1-9erthalion6@gmail.com> <20240103190559.14750-3-9erthalion6@gmail.com>
 <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>
 <20240103201853.xqh4hhdp7p4owkna@erthalion.local> <CAPhsuW4rRXLU=Pt6eqhjHW1gxy8ypo0BkFaEPP-Ny+GGEpjPrw@mail.gmail.com>
 <20240103205106.i7pukj7baii6xk7z@erthalion.local>
In-Reply-To: <20240103205106.i7pukj7baii6xk7z@erthalion.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 20:45:01 -0800
Message-ID: <CAADnVQJZCqimQwGrVqfkhEGrsygBC=9tUWkfcGBWND+rBY7UAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Artem Savkov <asavkov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:51=E2=80=AFPM Dmitry Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> > On Wed, Jan 03, 2024 at 12:47:44PM -0800, Song Liu wrote:
> > On Wed, Jan 3, 2024 at 12:19=E2=80=AFPM Dmitry Dolgov <9erthalion6@gmai=
l.com> wrote:
> > >
> > > > On Wed, Jan 03, 2024 at 11:47:14AM -0800, Song Liu wrote:
> > > > On Wed, Jan 3, 2024 at 11:06=E2=80=AFAM Dmitrii Dolgov <9erthalion6=
@gmail.com> wrote:
> > > > > +char _license[] SEC("license") =3D "GPL";
> > > > > +
> > > > > +/*
> > > > > + * Dummy fentry bpf prog for testing fentry attachment chains. I=
t's going to be
> > > > > + * a start of the chain.
> > > > > + */
> > > >
> > > > Comment  style. I guess we don't need to respin the set just for th=
is.
> > >
> > > Damn, I thought I've corrected them all, sorry.
> > >
> > > What do you mean by not needing to respin the set, are you suggesting
> > > leaving it like this, or to change it without bumping the patch set
> > > number?
> >
> > I meant let's not send v13 yet. If this is the only fix we need, the ma=
intainer
> > can probably fix it when applying the patches.
>
> Sounds reasonable, thanks.

Fixed up patches 2 and 4 while applying.

