Return-Path: <bpf+bounces-47701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF79FEA43
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3751606CF
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21616198E7B;
	Mon, 30 Dec 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bugLDZrN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF9195
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586034; cv=none; b=RP/t7Gdykc+8SxOgTM/J3uqlejGYiPfXlUUcmEER6UEcIn4jEkXJiqKP64FRCZ8kVcxbY9PQuVvcGjDzpxvzA7/K3jcjMbKHMz3eFv9ZnMrXBAeAqsOLCRnQcMO8Yc8M63ZR/eb1JgQJrpTzcVnVFrh9Kix3T/R/2jzziyb0zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586034; c=relaxed/simple;
	bh=DDmaL7WZlOMfxyECH1rYzJXUu4xZ6wY8ETGKqVPkyUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLr8fb6kao+/G7o/0HTPL3ym6++ifBWC6KsMebAIXFv6fmk/EJ9SOXHCsKsCHKysEYRLb5dovblBKXxK8jaKcwD7Xa+1JpfbaIhXySgpJf21ecys6xc+6/PkO5aGsFQRcJ6JFRRlMEzAlRNT7fC1pTJ/4vl2lq20scQIWFsQ7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bugLDZrN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so6112550f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735586031; x=1736190831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozHUY7AgBpG6uetAj/RotMa8eDuOAR8E7DF43HTEO0w=;
        b=bugLDZrNP8/GzQlLkbQZ/UjZvK1BoxIIHS83iyICRy4QTwG4xZ0M/hDyKs+81uGd84
         +vxn6j628YlCrHDxCOHPi30YJosAdPUVb0GtBTjCnFqKcKGrkg3Z929DAcL9SqWhJt7m
         Ke45UKXzOdENlO11DXLD/FDpuftChYjIqkbEDYT+nlyEekisHUHgrHOLbd1avnjU2ev5
         9c1SDulX+JXLEohCIi9HdxFxjLqPuEymqQwxKCTkNBvbwgVK9KHjdnzQhm51jFXLjLbO
         vkdbTqkvSNv4JEjbWwcyqzpI3vJFHqJQEZDXlxFckAifKJD3QwkCJ/AatUXnuHn8VfVS
         jbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735586031; x=1736190831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozHUY7AgBpG6uetAj/RotMa8eDuOAR8E7DF43HTEO0w=;
        b=k8waOdI4sFtGLSn8eoAIdbhQgFxVQK9kWaQwdJbpBCb74qnBfCeeM+D4pHcy5DrC4a
         L8H+DQDFhR69gX6f8A2cF877m+GeLsWQJI3PBhMa7y8HLgkJ+ryNiYPKcgTmAX5ENX5H
         bUxytWI24iiWBtCuMGqKOVqS+GjMn2WcUe/s5J75MNLprBcho1/SV7VlIwXqz6SXj8/P
         7RnKtsDmOrOjQ+2PbHjAC3l/qC4HG4dXfCNkMsOtm1B4siHmdy1Rt69agaXuwHMjBS4f
         wIjAVZEvfa0lEwf/9TxCmUlLgmXtQIRhoI3IB6D9zBgiJxI4pMnTP8xrsEaoBgVx316l
         jovA==
X-Forwarded-Encrypted: i=1; AJvYcCW9BaAjJPE8+KjWlmG10eCrPMhr62BjLleRTpexLTACsu2M9bUw7dhSsdM6XJvH/IgZCfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDTkv+kao11ApWB7m8MqaUk9xy+IeuUPKm22kDJhAhk2VOOYr
	Z08zmCL5aWkKhhv9rffO3u1Twg4veO7l7jJy0QFfF9CD/uFPiyMYJac4ovawhn00BomMmHF+pN/
	8JXQWi+Oz8hA3teSxEvmCbxoFy8s=
X-Gm-Gg: ASbGncvnhsEwtf54qm+nsTwZTt+8f5KMeXK2HKoAJUlzp/ex7Xtfox/I/aoja3OiX66
	kjUoHdUhvNNFfYorqKZAjvSkd+HO38C+vfSEAXw==
X-Google-Smtp-Source: AGHT+IF3kcicEfx5XYuIgqZEOd4X+9BgoVChWBzak9HCOBTypmKz2+uvQY7EzFy0eahKR2BTG+s7Xmf+Qym86uY7Fy8=
X-Received: by 2002:a05:6000:471e:b0:385:f64e:f163 with SMTP id
 ffacd0b85a97d-38a221fa4aamr27163809f8f.32.1735586031067; Mon, 30 Dec 2024
 11:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2NK63_D3A4XK54XvOAywlNwXaq6bq2I2nc2nU9g-YVdEkYaPPKcbcQ3RI0yRDc65N2LmtEx1e2aWDKXS0BabHqkihS2gtXBcghhwM5TfDeE=@proton.me>
 <Z3LgQwjTHKq_xi4Z@krava>
In-Reply-To: <Z3LgQwjTHKq_xi4Z@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 11:13:40 -0800
Message-ID: <CAADnVQ+pEPm5_enawAW0r5juxZSgZwe9o6=tCM9Tx+LJ8DL1cQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Use non-executable memfds for maps
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrei Enache <andreien@proton.me>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 10:02=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Dec 30, 2024 at 05:18:31PM +0000, Andrei Enache wrote:
> > This patch enables use of non-executable memfds for bpf maps. [1]
> > As this is a recent kernel feature, the code checks at runtime to make =
sure it is available.
> > ---
> > Changes in v3:
> > - Check return value before checking errno
> > - Update newline style
> > - Link to v2: https://lore.kernel.org/bpf/Z3LHcCgqY7kHs08S@krava/T/
> >
> > [1] https://lwn.net/Articles/918106/
> >
> > Signed-off-by: Andrei Enache <andreien@proton.me>
> > ---
> >  tools/lib/bpf/libbpf.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 66173ddb5..3a30c094d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1732,11 +1732,22 @@ static int sys_memfd_create(const char *name, u=
nsigned flags)
> >  #define MFD_CLOEXEC 0x0001U
> >  #endif
> >
> > +#ifndef MFD_NOEXEC_SEAL
> > +#define MFD_NOEXEC_SEAL 0x0008U
> > +#endif
> > +
> >  static int create_placeholder_fd(void)
> >  {
> >       int fd;
> > +     int memfd;
> > +
> > +     memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_CLOEXEC);
> > +
> > +     /* MFD_NOEXEC_SEAL is missing from older kernels */
> > +     if (memfd < 0 && errno =3D=3D EINVAL)
> > +             memfd =3D sys_memfd_create("libbpf-placeholder-fd", MFD_C=
LOEXEC | MFD_NOEXEC_SEAL);
>
> hum, you need to try 'MFD_CLOEXEC | MFD_NOEXEC_SEAL' first, right?
>
> jirka

I think Daniel's fix is further along while this one is still buggy.

