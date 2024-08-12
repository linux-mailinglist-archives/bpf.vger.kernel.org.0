Return-Path: <bpf+bounces-36946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6194F8A8
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 22:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686B81C22331
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950D194A6B;
	Mon, 12 Aug 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U11yJ0no"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455B152199
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496235; cv=none; b=RnXfL87gbpMZdBSBV0o+y9D3yOpfBa14FxZzexZch/Jx83kDfqMfHXVbGRotERCeqEt6AH0xn0JPm7sjlwkMim3QleWA8ReNw81O8b3FzacIxZnvaVoeWwj6zMjPSp1oUuy24/zPnBdE5BE5im7YIuzQMl/Vkh4MexkNH06BfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496235; c=relaxed/simple;
	bh=DWysP3RZfNEAIaRQir9iCV+yiLKeMzx8Q8DwdPFLF/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEOeBvUms4U5Ie4nP8cEAQ3XaVvVm0oYBTHilbi6GDtrN1ZrcJ/WadJA3F8530gTkO/MAAQ64VXzB+bp/oixSy/FSwh7HRYWzmwo4u8NAnTatMHPbFFFxEldZ5fofvKRxReugtCuNVZYQspZdM+2dsHtzRySR3ATLCa6aaqmT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U11yJ0no; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a10b293432so3396477a12.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496234; x=1724101034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k3Jc49fKyV9pAwESlILxyyepknys2Ru6lZFn8OVkvg=;
        b=U11yJ0notcUR61S6rDWvxNNW3ThnqlJtsn/IHDOw/QJPsVMdusIJpvK0BgJYe9eJ5Z
         OJiDTCKui8yGJMmAjiUKjDSNazvctBt+NNcdtpKWQ/4xLFGDOTUegDLlHoRGXnxCew00
         cRsNWJx3tUvmbj6+P11g3n41u/PcNYBt4q41pcdSGJpFWaAaPN/QSFdbS4UDVcbA9vBt
         l7cvKqC3CADuvRGyriqy+50/3gjE520N27wPo4ltZIAKEDAJTmgL2FXTeTquItbQsh1E
         0HoSvUaRgTS89CiOBCI30W5XU3koyPlmF+21bRpNuJ7qOGp/CiGgLVVCj3rzyQ8VygIZ
         m5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496234; x=1724101034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k3Jc49fKyV9pAwESlILxyyepknys2Ru6lZFn8OVkvg=;
        b=EQ51QCoCLN+KNI4PPitkmM8Y+BMbh9aTmbTGKYHkzeK8xCQ9cERTFaaNI/hIkJwMlu
         geSNckuz454fOz3+8Ma/7JL7pQKEGQW/seZ93NwBcovaemxpTvSG/2DvZKgQdokaqhZj
         6/nTTIpFHI33ALlK/0CKALWSkajAmnjOSaVR5na9yFIa/MWuTEGFyQrztHZx9DRvSpru
         MRC8FXFUl/ZCQjd5t62s4Ax5NTpPxTmk0xTg88LJTszljYDTQIgGz/1qO8YK377es5Dx
         OjZPuI6k0w0COC86f1LlCLgz+MngSv3NVuUh9bULvjDzh2N+zdgH/nx9PK3k99hyVOUm
         EegA==
X-Forwarded-Encrypted: i=1; AJvYcCXxSSVlAozOsVKCYpa15eF0MRDfH85i47jj7DGA60XMG+/TPHy6zQqZM4RQcq4Q9cUBVlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfZPNVFcmJdQh8pMqqGscMiysuiAQ9j83FSSEQq0wj0eXEPWL
	V8cmScbf5KL3zVQPbrrqInvFSwpAnn36ZP/lpxji6xk6s9snh1z49XfwnyZ0OnADWt6LsNYLscx
	Z3A3fxoOVPWgHnFDtooIJyE/eygI=
X-Google-Smtp-Source: AGHT+IFm6NN0VGa3RQz8WnYdO4XAWDhX5iOq0mPDE4lPCu6mJO1HZBnJGfnfSawg6D38CZXXH4QbzQssMSoCPqwjVqQ=
X-Received: by 2002:a17:90b:33d2:b0:2c9:9fdf:f72e with SMTP id
 98e67ed59e1d1-2d3926340bemr1725939a91.26.1723496233805; Mon, 12 Aug 2024
 13:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810093504.2111134-1-alan.maguire@oracle.com> <ZrpYVOaMvEo3UZwf@google.com>
In-Reply-To: <ZrpYVOaMvEo3UZwf@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 13:57:00 -0700
Message-ID: <CAEf4BzYGw0A07Jk66VTu2YfjRK=6v_e9idnbP1J2D-OLUhSGSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix license for btf_relocate.c
To: Neill Kapron <nkapron@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:45=E2=80=AFAM Neill Kapron <nkapron@google.com> =
wrote:
>
> On Sat, Aug 10, 2024 at 10:35:04AM +0100, Alan Maguire wrote:
> > License should be
> >
> > // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >
> > ...as with other libbpf files.
> >
> > Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> > Reported-by: Neill Kapron <nkapron@google.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/lib/bpf/btf_relocate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.=
c
> > index 17f8b32f94a0..4f7399d85eab 100644
> > --- a/tools/lib/bpf/btf_relocate.c
> > +++ b/tools/lib/bpf/btf_relocate.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  /* Copyright (c) 2024, Oracle and/or its affiliates. */
> >
> >  #ifndef _GNU_SOURCE
> > --
> > 2.43.5
> >
>
> Thanks Alan. Patch LGTM, but I'm not certain of the legal aspect of
> relicencing, so will leave reviewed-by to others.

Given Alan is the sole person who contributed to this file, it's
enough to have his SOB to re-license. Applied to bpf-next, thanks.

>
> Neill

