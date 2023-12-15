Return-Path: <bpf+bounces-17954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63B81412D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BEE1F23081
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 05:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8D63B8;
	Fri, 15 Dec 2023 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmh6wVUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112E5692;
	Fri, 15 Dec 2023 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55202565d48so216489a12.0;
        Thu, 14 Dec 2023 21:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702617656; x=1703222456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUP5j6wCeeIzfoESCBV0oq3hZ+5SdsZawBwHzCrsEYM=;
        b=Cmh6wVUVuYY+qDGogJGxZPALrxHrf0IVprXuwTRoG3IUJYtl+gA/xfvYaZFqom8tX/
         pt8AbNSlSxtJQdh9rqA6U04KvMRdWFJt6NM967UU280TXuJq1oSCQzY29aneQ6BXvOWA
         PjeBsBHy26MPmbfaUW5UOnSvIkhJ97pib6/yoajwZ7/sz1wVYGLHOdcPCFpUPfperb54
         UvwM90nt3wxbEgnifU9Yy8FjUObKLGY+Hxatl+Cl6FApRzks/YtN1q6fKIgtDZrozUNb
         p7DLMCqSCWZZhUy7c8H3Fz02Qj3VwdTbykx53p3rmzLb9A+QtsUCFCaJT38Fj2xTF4eP
         0OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702617656; x=1703222456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUP5j6wCeeIzfoESCBV0oq3hZ+5SdsZawBwHzCrsEYM=;
        b=EKIm6qK8cOdjsu3BWRAzEDg1uVtuE6ntht404WF61O5Uf4DldH30OmcYNXfmnL1guD
         h2AZpQywdPFDpnPTeAxmG/DVr4/F95Z5NT20NThUELkrWChM7Hy2vVNNjvLuZIm0hyDC
         uHgyCkdsxcM5bELAUiqNydOWtvlVRuYxW+bLB2kD/WvgsUuTynELT7et6w+SwXijZqAP
         tRxikqXROS1YNdhoenOc8KVkt1C2qEPjZ2mdpL2ekSOD23WsuMss7JHudSRPjaJh6GDi
         rjIUmbuvyUPWaZWFf6gAjdsCadYRxllcIYnB0cLxTh9d2wUpr2+ipAz9k3EX8C6QlLvW
         O66w==
X-Gm-Message-State: AOJu0YyKBg074S3qeOzacx9Bg/ono9RgEnNrQkd8kojYUJ4q9N7iN1OW
	wO5oYfwYnCcM8uvAWiSScIKeoNm7RGZRo+shuZe7Le5c
X-Google-Smtp-Source: AGHT+IFi0pVrV1d3NLr+UJkI7MyUyhr3HHj6SXh+gCq2GQbK0pvJUZqW6NcmK+t0cU8nWQqaMWICagygN8bli+44lZk=
X-Received: by 2002:a50:a696:0:b0:552:9643:2951 with SMTP id
 e22-20020a50a696000000b0055296432951mr543307edc.72.1702617655608; Thu, 14 Dec
 2023 21:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com> <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
 <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
 <CAADnVQ+RVT1pO1hTzMawdkfc9B0xAxas2XmSk6+_EiqX9Xy9Ug@mail.gmail.com> <66b2a6c45045c207d8452ad3b5786a9dc0082d79.camel@gmail.com>
In-Reply-To: <66b2a6c45045c207d8452ad3b5786a9dc0082d79.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 21:20:43 -0800
Message-ID: <CAEf4BzaTTv7oP2vcfVYXjUnA958MqohkRDJ9J7qOCtGfpijROw@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hao Sun <sunhao.th@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-12-14 at 18:16 -0800, Alexei Starovoitov wrote:
> [...]
> > > E.g. for the test-case at hand:
> > >
> > >   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> > >   1: (bf) r7 =3D r0                       ; R0=3Dscalar(id=3D1) R7_w=
=3Dscalar(id=3D1)
> > >   2: (bf) r8 =3D r0                       ; R0=3Dscalar(id=3D1) R8_w=
=3Dscalar(id=3D1)
> > >   3: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> > >   --- checkpoint #1 r7.id =3D 1, r8.id =3D 1 ---
> > >   4: (25) if r0 > 0x1 goto pc+0         ; R0=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,...)
> > >   --- checkpoint #2 r7.id =3D 1, r8.id =3D 1 ---
> > >   5: (3d) if r8 >=3D r0 goto pc+3         ; R0=3D1 R8=3D0 | record r8=
.id=3D1 in jump history
> > >   6: (0f) r8 +=3D r8                      ; R8=3D0
> >
> > can we detect that any register link is broken and force checkpoint her=
e?
>
> Should be possible. I'll try this in the morning and check veristat resul=
ts.
>
> By the way, I added some stats collection for find_equal_scalars() and se=
e
> the following results when run on ./test_progs:
> - maximal number of registers with same id per call: 3
> - average number of registers with same id per call: 1.4


What if we keep 8 extra bytes in jump/instruction history and encode
up to 8 linked registers/slots:

1. 1 bit to mark whether it's a src_reg set, or dst_reg set
2. 1 bit to mark whether it's a stack slot or register
3. 6 bits (0..63 values) to record register or slot number

If we ever need more than 8 linked registers, we can just forcefully
some "links" by resetting some IDs?

BTW, is it only conditional jumps that need to record this linked
register sets? Did we previously discuss why we don't need this for
any other operation?

