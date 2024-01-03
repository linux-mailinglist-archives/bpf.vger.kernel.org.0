Return-Path: <bpf+bounces-18912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9F8236C4
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AF3B23CC9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29F1D53F;
	Wed,  3 Jan 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPemyDrP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD01D687
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5E7C433CC
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704314878;
	bh=TuYusuG6DSAk3BWUCs3XHFavLmfU2GQ4VmoLpFtqHxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aPemyDrPUwdhYhKXldToW2X40EYL82F5rWt06xUA865iTke8B2mqm3N9Lb72mGr6Y
	 k4rhYhD6fsLoCUTrzccytEtY7VwwjrWhQTyHbOWHK+50HR8U5fVouw+7rZ/U6yqfzD
	 pjxK1/0plkOv6qFie6ME6BWabZcxumKZO1T8zlTunzx8++BVeFillcV0nq1LObYHAD
	 IWyZ797W7R8sgQ3dCBuE5AK4JlGROk2BQqTXdfckvDh89D74MkV8BBbQ2LQ+hXnqjy
	 WL9ZlC/v0IK8teejHr+JRBN1MCFGz73bJWYH5o1vEqnx/XIH8SLC+zxHTe/UsyDy8Q
	 HEH2Jck+4dMrg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so56836941fa.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:47:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yxl4AMAXP1oZQ1nlBlm/AG/DPsNeYmQ2Ey/4O0vKGcJb6N1Fv7g
	fsStfp4NKCPJyaE7rnUuKXjbVTLok0ckZgNIsCQ=
X-Google-Smtp-Source: AGHT+IEm/8eU4tiHXPVeLeIU9Qa5P9xkqP/mkmAuSJ6sxATijsK//JHeZZkzHjh4H+5X/Sbg70q1BT+ciwr7vTy8+es=
X-Received: by 2002:a19:8c10:0:b0:50e:70c0:b071 with SMTP id
 o16-20020a198c10000000b0050e70c0b071mr3733700lfd.255.1704314876314; Wed, 03
 Jan 2024 12:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103190559.14750-1-9erthalion6@gmail.com> <20240103190559.14750-3-9erthalion6@gmail.com>
 <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com> <20240103201853.xqh4hhdp7p4owkna@erthalion.local>
In-Reply-To: <20240103201853.xqh4hhdp7p4owkna@erthalion.local>
From: Song Liu <song@kernel.org>
Date: Wed, 3 Jan 2024 12:47:44 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4rRXLU=Pt6eqhjHW1gxy8ypo0BkFaEPP-Ny+GGEpjPrw@mail.gmail.com>
Message-ID: <CAPhsuW4rRXLU=Pt6eqhjHW1gxy8ypo0BkFaEPP-Ny+GGEpjPrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:19=E2=80=AFPM Dmitry Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> > On Wed, Jan 03, 2024 at 11:47:14AM -0800, Song Liu wrote:
> > On Wed, Jan 3, 2024 at 11:06=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gma=
il.com> wrote:
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +/*
> > > + * Dummy fentry bpf prog for testing fentry attachment chains. It's =
going to be
> > > + * a start of the chain.
> > > + */
> >
> > Comment  style. I guess we don't need to respin the set just for this.
>
> Damn, I thought I've corrected them all, sorry.
>
> What do you mean by not needing to respin the set, are you suggesting
> leaving it like this, or to change it without bumping the patch set
> number?

I meant let's not send v13 yet. If this is the only fix we need, the mainta=
iner
can probably fix it when applying the patches.

Thanks,
Song

