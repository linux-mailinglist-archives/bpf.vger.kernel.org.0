Return-Path: <bpf+bounces-35786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497E93DC95
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B531C22CEC
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CB10FA;
	Sat, 27 Jul 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeehC6qS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2A7E8
	for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722040258; cv=none; b=jDTkmyuun0awI83NoJKZ6BO3jaZKifnP1OtdgHWz8G44U2jpeuIXyFJwUOpW6i4E2vxUrKju2idfJIJiaKtGv70YtBQiCExKRJkGJfUDqxk5ZAoiX42WX2xujZkbGMf8i5gFms3jU0tFPM+1J3eW+kjBA2PNSQEYNi+9RAKq8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722040258; c=relaxed/simple;
	bh=D6phxm31bogqHekO+k11K9MiXe6zyQTQKX231I18K9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXCblQaIWign+4r12SuQZDsVYuLNrBKAokXM5+WEHgXSEPKeSosd3j5XIhEHJUyYLJLc56TKkel9cyh28lYNCqophDyO4JPQmjWPttchUi0eJQ0v4c60KovDa039zwTwuqjNwD8TA7DUg2a9CJbm3+5SPoOShSV7ouJbXmhsbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeehC6qS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a115c427f1so1028180a12.0
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722040256; x=1722645056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StO8kndJTQRbnIGG3lvbO55jDVCGSi6tPsTcTxq7VYM=;
        b=eeehC6qS5JJ3btEsCfgPMweV1Tzb7y0ADMI6Mdk1wHTJxi/8lqJaT5CG6Kd4v+CGqg
         a5pJZgvX1ZKOFfsdlNSe1dreQEw3d4CKmorzvDhkvgIYPu5Ea3YLoULFedWko+AcFen3
         tAVXJWE+QkqEZTiDa4+0glbfqpREE68bG8krK8vkQA900JpQEfAeWuhafSwOmkOk/XlK
         wUBJRm5oXXuIRMvgq375tidqF/pH0NfD0C7QvGHB0IAGvjQbhffHOVbuT3V63O0SJCna
         jjBcT54dQnnT3ThdsrMr/TAvS9ANe7yqxhuHrmG1vkeqY0MSc57kF/MJrj62zmN2xoXR
         n1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722040256; x=1722645056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StO8kndJTQRbnIGG3lvbO55jDVCGSi6tPsTcTxq7VYM=;
        b=ZMmG5A1PQ2YcIHkvqtQ8x1VTnzCplVrDSn3iNWsvTF3gHaNq8/qYOvPxpmumdcMLsI
         67rG0KYN3gLopitWcZX7naG5S/6vGU3B2bSFgWFKHA9rcSNYFBaLgQSvMAwNQm9ejHFp
         hqI8mBZZeAFdIx/3Dmfe5SEuKCaSbDoOD21RGDwY3ivlelE9aLNCInpnvYSSM//5c1+X
         PX/3m2+ZMbTNripH77HpukiweuL+kWzQyUV9GqgFYvecpR7x6yeUl0GO5XhH6qvf2ezc
         5pBUJRidjkkRVL4hVBSVNJpWPk67pVT9zqk8h+AObQtHJQSWfzgiVpBUDhxgmLuca8Uo
         cAYw==
X-Forwarded-Encrypted: i=1; AJvYcCWYul0IzyjBSkX6nv9TTWOIcmxX5NgVOhqOQmvAb4tMk4Lz9B43fzaP+lpN9YI7kzTfCPYbyVVBEu8yIKVG/HIR3a2A
X-Gm-Message-State: AOJu0Ywj6aUi32mlWCKrHn6POt49Mh/wnkmm7uyJ62URvj3zIJD8soaT
	ctTAY1jydsSVRR0s78XWeRlzoi2aeO9hM2PBb5lzTf4fAI1gs5JD2iR0Kx5AM0minbk8Zi87zhj
	8f1+RrI+O9s0LHP22JkNITt7LFps=
X-Google-Smtp-Source: AGHT+IGLyqm9kfSgfKswGpdXMK88MBE/WYwyC4rANzUvflZ9b29D516O8HaFT+eNdp1wRbjLNztIvmIQ3DUYMIqbpEY=
X-Received: by 2002:a05:6a20:3d89:b0:1c2:8949:5ba1 with SMTP id
 adf61e73a8af0-1c4a1529b50mr1123848637.53.1722040256447; Fri, 26 Jul 2024
 17:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-3-andrii@kernel.org>
 <ZqLVc7gqQQ9PMIbD@tassilo>
In-Reply-To: <ZqLVc7gqQQ9PMIbD@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:30:44 -0700
Message-ID: <CAEf4BzYZz=s2aFVtKb8m+2WNxTUmxhpriW2mT1etOCwS2ZdqzA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] lib/buildid: take into account e_phoff
 when fetching program headers
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:45=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > @@ -214,13 +214,14 @@ static int get_build_id_32(struct freader *r, uns=
igned char *build_id, __u32 *si
> >
> >       /* subsequent freader_fetch() calls invalidate pointers, so remem=
ber locally */
> >       phnum =3D ehdr->e_phnum;
> > +     phoff =3D READ_ONCE(ehdr->e_phoff);
> >
> >       /* only supports phdr that fits in one page */
> >       if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr)=
)
> >               return -EINVAL;
> >
> >       for (i =3D 0; i < phnum; ++i) {
> > -             phdr =3D freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(=
Elf32_Phdr));
> > +             phdr =3D freader_fetch(r, phoff + i * sizeof(Elf32_Phdr),=
 sizeof(Elf32_Phdr));
>
> What happens if phoff is big enough that this computation wraps?
>

phoff is u32, phoff + i * sizeof(Elf32_Phdr) will be casted to u64 as
it's passed into freader_fetch (which expects u64), and so it will be
an offset slightly bigger than 4GB into the file. If that happens to
be a valid file offset, so be it, we'll fetch the page at that file
offset. If not, freader_fetch() will return NULL.

