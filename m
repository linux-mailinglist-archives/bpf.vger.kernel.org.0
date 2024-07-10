Return-Path: <bpf+bounces-34486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6CD92DCA4
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712311F26857
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686D156993;
	Wed, 10 Jul 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebZ30oN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE877154BFE
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654112; cv=none; b=thksth8cellpVy3Zvsm9yAA4Go5v7CSlqfPUqXhddNtY+ghd++cW659G4RBYaeUVIoHZMR9Tq17cVbjh2aKAy3ljMje6XpW6zDb63E/GUkFZZkhs8QI7906w0uHBnSAL/urhfXwNeDz5RVoNdq6sQIYCYWd7tRa8nvF3LQUBNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654112; c=relaxed/simple;
	bh=T7FKtbI1NQF1FO4pkeKhsOioXQ5hR+vx6SDleSTQk9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBQZZ/BXvVWeytu3Z0vyX/ManbTz8yp/Jv/fcBnVBli3UsPkUnzSl8ivrOWtbQsfopcyLMDtNiUrq7akHD2rFVbi8VBPJvxLZKXqCnwhd0PSfjdWrr62E73PMpHoe8oQNj9FGohB9y5mXxAWAkaZw86XHb+RVDIxfZ8s/aAE/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebZ30oN0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36798779d75so126676f8f.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720654109; x=1721258909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDC+PlbeAWI0mopElsGNkz5T2kdSbbqELXoiN+T+oV4=;
        b=ebZ30oN06AoT1yEg+JyKqhJSNTzfNQfknMZDrrCCCq9L3+eKY+T55F2pJxmiF0ujuF
         4dR6PYJEHMTs5AThu03HzxDpa3nTGlIBMGhVc3eCybtIboHD6ZksKy6x1TmUJPa3m8Aq
         9CRUNVFni07UOrDlB1ByiPpNy5F+b4VX6czcgpERZAar6NUtR4OBS3fnf1n1EqhUdPVI
         Rwg4CnnSmGuEvmeg+VNNPvxEPUHT2KXMFjLKHCQuvWfCbMW9MXoGsgS4ZxK5zWckpM26
         44xtqDjAP4N7sYeVqL4x1DP7uDuUnioplEWAxE+q6uXkj5IuE4+qZLm+7XSvBKylcggp
         NxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654109; x=1721258909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDC+PlbeAWI0mopElsGNkz5T2kdSbbqELXoiN+T+oV4=;
        b=S7y6kNxnC3yOz25CulrJMAF3v5smbYD9fk1PwUg8/3KIL+bzOUcDADBBUTsxNQY6HP
         Lo9ZQxQB3ODiHxUiYUuCyrnMZ7+Hude7WzhOo4Ks6a20GhswIR6FsGPiJ6fmjSvaEpjE
         grreEF3kW53bK05/i+7BxzZDJ0+EjBOufwVTNQD6AL2zaOE2IeEoqbWgEfOU/MwrCCz/
         rk7t2IDUJe4DpioVRKxMGJvJZDwIxGZIzcQYIpTGAA+uS5ZTQDRa1X8OLzzKEc0mH270
         zejP7VADvd5HygNdnzpR49K7yLlSJ1cCZa46Lp5C9tfyNIeZQhzOk53Be8rzGYYd2Zqc
         uLag==
X-Gm-Message-State: AOJu0YyISM9f3UY1OM6eOtOdsmcqjp6LdOKa0bkH87D9YRDwvjrsmmlO
	xheCjVTuQyn0HJZEzHUtRQpk3UrEkE110zpdST67BsIZUclJPFFW7IIN9TPOwZiRQtdd5Tsfvpn
	kTKilwitcRu5PPSff9mIa96fvaVs=
X-Google-Smtp-Source: AGHT+IFz/CvWFvEzImIDFrWU3YzO4OSaLHA9EAq6ZaO42XsqUllvbTjBtQhz+OJMbIfUqFpC8cL12hzE9e46lO4ZXgs=
X-Received: by 2002:a05:6000:154a:b0:366:e9f9:3d1b with SMTP id
 ffacd0b85a97d-367cea46470mr7042091f8f.9.1720654109228; Wed, 10 Jul 2024
 16:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709185440.1104957-1-memxor@gmail.com> <20240709185440.1104957-4-memxor@gmail.com>
 <CAP01T77vmSEZ=cgb499s1jP1Usjdz6yR2C2W9jXDOMi9arg7Hg@mail.gmail.com>
In-Reply-To: <CAP01T77vmSEZ=cgb499s1jP1Usjdz6yR2C2W9jXDOMi9arg7Hg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 16:28:17 -0700
Message-ID: <CAADnVQ+yJn_mtT+ZdiJEY3H=LYdV4TdTG+zzUDC89FU=Ly7hGQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Add timer lockup selftest
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Dohyun Kim <dohyunkim@google.com>, 
	Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>, Tejun Heo <htejun@gmail.com>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 2:07=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
> > +       while (!*timer1_err && !*timer2_err)
> > +               bpf_prog_test_run_opts(prog_fd, &opts);
> > +
> > +       return NULL;
> > +}
> > +
> > +void test_timer_lockup(void)
> > +{
> > +       struct timer_lockup *skel;
> > +       pthread_t thrds[2];
> > +       void *ret;
> > +
> > +       skel =3D timer_lockup__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
> > +               return;
> > +
> > +       int timer1_prog =3D bpf_program__fd(skel->progs.timer1_prog);
> > +       int timer2_prog =3D bpf_program__fd(skel->progs.timer2_prog);

Pls don't declare inline. Some compiler might warn.

> > +
> > +       timer1_err =3D &skel->bss->timer1_err;
> > +       timer2_err =3D &skel->bss->timer2_err;
> > +
> > +       if (!ASSERT_OK(pthread_create(&thrds[0], NULL, timer_lockup_thr=
ead, &timer1_prog), "pthread_create thread1"))

pls shorten the line.

> > +               return;
> > +       if (!ASSERT_OK(pthread_create(&thrds[1], NULL, timer_lockup_thr=
ead, &timer2_prog), "pthread_create thread2")) {
> > +               pthread_exit(&thrds[0]);
> > +               return;
>
> A goto out: timer_lockup___destroy(skel) is missing here and above
> this. Will wait for a day or so before respinning.

I was thinking to fix all these up while applying.
So I fixed it, but then noticed that the new test is quite flaky.
It seems it can get stuck in that while() loop forever.
Pls investigate.

So I applied the first two patches only.

Also pls fix:
+static int timer_cb2(void *map, int *k, struct bpf_timer *timer)
+{
+       int key =3D 0;
+
+       timer =3D bpf_map_lookup_elem(&timer1_map, &key);

1. no need to do a lookup.
2. the 3rd arg is not a bpf_timer. It's a pointer to map value.
So use
timer_cb2(void *map, int *k, struct elem *v)
then cast it to bpf_timer and use it w/o lookup.

