Return-Path: <bpf+bounces-45433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF59D56BF
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7283BB218F2
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C51853;
	Fri, 22 Nov 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHR1QrUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925312566
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235450; cv=none; b=i2KBW4Ma55vxSvDcHHR8MAx/zZ0tch4NZBXFjG10sdCh25omnsjPnXRoXMaltPkwuILqGQ9JEfJ8BS6eOzPycEscprLcZT32QS1NozqcVHd+DxKLxYii1E0/jUikvZ0JQl5mi05qvEWFs3KJV82Xglk1fCCSEQD6m7rvsjXj6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235450; c=relaxed/simple;
	bh=ljrnxgsxAxDFIWXpqlmwzVb2KCqEaI5CaCMAmXmlOss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yv5dHSNP+Dg9hoyhprlXQDHnttH2dCwNPHROKRduaNo86mBS2bS6wmlkxeNye5Db6Ks4tK67zE5cuHPAPvcNDXc0dsTmY455vGbCxAiMz8MpsrM7wn6CSECGPm2HXUi+9Ud0Dw/UhqU47fnTCvNGnOQnQBHr562y/UPoxJITRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHR1QrUd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fb27cc6bso16640565ad.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732235448; x=1732840248; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfwnvJGe4uZaA6pVU5ajRlK6L+iESycgnOt/Ll87qm8=;
        b=HHR1QrUduGreMm9W1oHNbxo8Y+T8/qjY98Qps9XtLRQyiI31H+UmPfrmi8Ox9JoEBp
         ESLPpCHfIRXeX7VuDUPgBHp0PQ/UzlRa0aLHnij4KjQaF5c4c8txD0nGNjBuiNqBVazj
         i5ONrszH13Na30zhGDIXTTisDFPdcTTXR1bGif+LG0vJ7JJfxBj6EQn3ZFocEzE9d+Za
         KwW8zE4YjK/yymwfDtALWYMJj4EO71xch8bmBynITy76tmfbCtoJ7ORrig+nsGlhAblp
         flTFleb4VPw+y3PfQUjJE4BBsaEk2+uxcL5ipfFBkXkEPTNwMuhWOtSl4MtWWcMPed0e
         7I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235448; x=1732840248;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfwnvJGe4uZaA6pVU5ajRlK6L+iESycgnOt/Ll87qm8=;
        b=pV2txkT+isEhqdalbH//EWeCZW1txkDc0jBpA1/mptFJ/XR+Rnlj3xc/36AJ/lnXOW
         UQS95yOKB1Xqj9/zwpnoXtJQ72596+GldGBtW8ioYNvDVo8kU9v8x7c0xI+rA618asty
         xqrGPMHY5R9uihWwFe3swFU7jVAiYDSqkD799Abmx+E1uHykon8UQ0OWU4atZkEtMnzd
         K4+PSJpAUxBVcJD7Uj0gxf7VihJ1Hap3kAWQCfDeikMGBcfTWBZ/IuZqWlHkfXaVESK7
         wj6WibkvZYohHl7gBvmwMOZ5CMTWepNvVcs5aYqUIaxT8L7RvBT0eIVsjZX8lp1IjDCg
         +row==
X-Gm-Message-State: AOJu0YwTA5luwAPfSEpFVfhYkCB4IO5INee8M97dGXQRWq8VEtfDFc5D
	cvkyM2mqR4DZncPTcwoNxRAHd/yBmaGysla7QK4ZrfoeJ/YW9BPvL7l6Cg==
X-Gm-Gg: ASbGncsX6fOvZWIMLm6n5Gzv/cz5xl5rnMwuXyWmIwJRpeptFOePwqlzclD/DcPs26d
	X37PqKdZduNqRT8wETQ3mjy/6VGrP0j/b3FlcwW8sgoqhnFy5u80eHAyJAmNXjgXnhT6i0exH1w
	ThRy4+JwHhvzKX+GUI1Z4Pr6+Ttx/Y3bkL6NI2jS5XmRI1GyztSDefF3TKm5OPf+uwJSpZ+pt3j
	rQ4XUhIdjf4gsGFvCggFX6YJ7xG7/HYJpMHKnOdHosGDz8=
X-Google-Smtp-Source: AGHT+IGX76fgMDfmFe6aCuIqG+mqQgzdabuR4RMEyczOOq5OIPKTIbrA+JjKYCMyuQbtu/LY9EoZQw==
X-Received: by 2002:a17:902:f54a:b0:212:fa3:f61e with SMTP id d9443c01a7336-2129f5d81b8mr13526015ad.15.1732235447780;
        Thu, 21 Nov 2024 16:30:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c71bsm4312075ad.51.2024.11.21.16.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:30:47 -0800 (PST)
Message-ID: <94f17cb91ef680d0b16ff8836b10d06ab386be63.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Thu, 21 Nov 2024 16:30:42 -0800
In-Reply-To: <CAP01T76QF3HqCPaB8LhG+b6UuDJrXPdqzsSgZgSG=DXVAwKDpQ@mail.gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-6-memxor@gmail.com>
	 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
	 <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
	 <46250fef76c4b78eb283c724f27fcf4e275d4839.camel@gmail.com>
	 <CAP01T76QF3HqCPaB8LhG+b6UuDJrXPdqzsSgZgSG=DXVAwKDpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-22 at 00:12 +0100, Kumar Kartikeya Dwivedi wrote:
> On Fri, 22 Nov 2024 at 00:08, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Thu, 2024-11-21 at 23:06 +0100, Kumar Kartikeya Dwivedi wrote:
> >=20
> > [...]
> >=20
> > > > > +/* Keep unsinged long in prototype so that kfunc is usable when =
emitted to
> > > > > + * vmlinux.h in BPF programs directly, but since unsigned long m=
ay potentially
> > > > > + * be 4 byte, always cast to u64 when reading/writing from this =
pointer as it
> > > > > + * always points to an 8-byte memory region in BPF stack.
> > > > > + */
> > > > > +__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_fl=
ag)
> > > >=20
> > > > Nit: 'unsigned long long' is guaranteed to be at-least 64 bit.
> > > >      What would go wrong if 'u64' is used here?
> > >=20
> > > It goes like this:
> > > If I make this unsigned long long * or u64 *, the kfunc emitted to
> > > vmlinux.h expects a pointer of that type.
> > > Typically, kernel code is always passing unsigned long flags to these
> > > functions, and that's what people are used to.
> > > Given for --target=3Dbpf unsigned long * is always a 8-byte value, I
> > > just did this, so that in kernels that are 32-bit,
> > > we don't end up relying on unsigned long still being 8 when
> > > fetching/storing flags on BPF stack.
> >=20
> > So, the goal is to enable the following pattern:
> >=20
> >   unsigned long flags;
> >   bpf_local_irq_save(&flags);
> >=20
> > Right?
> >=20
> > For a 32-bit system 'flags' would be 4 bytes long.
> > Consider the following example:
> >=20
> >   unsigned long flags; // assume 'flags' and 'foo'
> >   int foo;             // are allocated sequentially.
> >=20
> >   bpf_local_irq_save(&flags);
> >=20
> > I think that in such case '*ptr =3D flags;' would overwrite foo.
>=20
> In the kernel or userspace, yes, but I'm assuming unsigned long will
> always be 64-bit for target=3DBPF.
> Would that be incorrect? This pattern will only happen within BPF program=
s.

Discussed off-list.
Kumar is right, and there is no problem, as on BPF side 'unsigned
long' is always 8 bytes.

[...]


