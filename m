Return-Path: <bpf+bounces-41026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D899118D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9685E1C221C5
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F611487DF;
	Fri,  4 Oct 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxEilANI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A9231CA0;
	Fri,  4 Oct 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078416; cv=none; b=HzO7GYuSkq7qT30W0AM6YgQSK4T1A+ScXxkbnJnr2fs5UHugbjY55aQcOO/xnwWd1/PwARXZnbQExVScfp9NNBVUZlU0HVos3k/14PeNZv+3hhNHAPuMqW+cnCnbshAFNzJ+V2gS5zOwJMivaFx6BQ+3dTaD2gMqjOp7P2P4Fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078416; c=relaxed/simple;
	bh=lmmZc9fY43kbad/NkggIPVIJBJBJ9TKXgCFT6dehHUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOL+gdvY7CMDqmRRbyC5RQcDaWuGl9R+zgqOxBqO9DgUgSY1ooDC/W01ZUUD42eyQ90uZ0cmXSkOMa0qoAe9gseIr/rbVh2uqMw9Ftrchpchdz+lV7sGlQ5LPjMI2lFGTeVJpcEkhbyTLBzLYYabZjupcQdt6FrrFlsmTMQNSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxEilANI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8776BC4CED5;
	Fri,  4 Oct 2024 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728078415;
	bh=lmmZc9fY43kbad/NkggIPVIJBJBJ9TKXgCFT6dehHUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UxEilANISa4v0JAFkIRGNIen1SX1PmY/F9uRji9fKrKQArXST4WvyrM84ZpYD1gxo
	 i5sZD/oYCSHg1R26vbPx0tamR6NTIooeJUJvpIkVGulgxnEnCs2yLb94AgtLSGObx9
	 xm3f0YsSuGzrOR53B417BgyyGBPW+6G9fEh2f7jja/DrRLZzps9PDXeRLwDOindboN
	 ODgSFHrVglkTSK/x1yvXKgK2xx0qMG8IgLryHVDnyrLJjYqPeGssOauLvS9pYUa+T2
	 QFm/Q0XHgNXLx0fR+jPQzH1cjHOUOIF3o580HLZhmFbxSD1lFD5RsQK+gcWZZT8o79
	 CKrLacCKgyO9g==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8323dddfca2so139563939f.2;
        Fri, 04 Oct 2024 14:46:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZrLXWrnrgyJ5b6WNxUk+BGoTN9WFGNivZJYQMjdhdoKnnDk1WHpG36GeZH/7jB4fcTu0=@vger.kernel.org, AJvYcCW+Ao19aBosZdLbnUQJKQ5T/Lk9ObvL1GgTzZH0xm2Vu4EaoUfdl32mCnhArNbNQKRkUVKjKUsxmNdq4z4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEqQHorp8bU4I1u9H8iexfArcX6YjQtH+fcJzac2V/Hm8ixpe
	hwSt2Q13rOG2VT161SCpRIM2b7ImPqBmK/MtBPEc39KgVYjTHx/evm4Zou0AO/PmxWJqSiSUTLu
	fsgCT2gZaAnEJN7d0a/1mfG0ZvRA=
X-Google-Smtp-Source: AGHT+IHXDP5z8ROQeQBFKF30JBdj/4C6B3pysw2YO4R8Q6trXLKTULDxEzsFUJ9pzeWlrnAyu5OQau+OXCF6pPDYnno=
X-Received: by 2002:a05:6e02:1a8d:b0:3a3:4477:e2eb with SMTP id
 e9e14a558f8ab-3a375bc5ddfmr42558065ab.21.1728078414875; Fri, 04 Oct 2024
 14:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-2-namhyung@kernel.org>
 <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com> <ZwBgLmcEwuplwNSt@google.com>
In-Reply-To: <ZwBgLmcEwuplwNSt@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 14:46:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7NFHbt0yPxh81gkRo8q_z_6JSrGGGLXtPMqvrbxk6b5w@mail.gmail.com>
Message-ID: <CAPhsuW7NFHbt0yPxh81gkRo8q_z_6JSrGGGLXtPMqvrbxk6b5w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Song,
>
> On Fri, Oct 04, 2024 at 01:33:19PM -0700, Song Liu wrote:
[...]
> > > +
> > > +static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v,=
 loff_t *pos)
> > > +{
> > > +       struct kmem_cache *s =3D v;
> > > +       struct kmem_cache *next =3D NULL;
> > > +       bool destroy =3D false;
> > > +
> > > +       ++*pos;
> > > +
> > > +       mutex_lock(&slab_mutex);
> > > +
> > > +       if (list_last_entry(&slab_caches, struct kmem_cache, list) !=
=3D s) {
> > > +               next =3D list_next_entry(s, list);
> > > +               if (next->refcount > 0)
> > > +                       next->refcount++;
> >
> > What if next->refcount <=3D0? Shall we find next of next?
>
> The slab_mutex should protect refcount =3D=3D 0 case so it won't see that=
.
> The negative refcount means it's a boot_cache and we shouldn't touch the
> refcount.

I see. Thanks for the explanation!

Please add a comment here, and maybe also add

  WARN_ON_ONCE(next ->refcount =3D=3D 0).

Song

