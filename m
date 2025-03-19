Return-Path: <bpf+bounces-54380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99099A69312
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9408A21DE
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B61D7999;
	Wed, 19 Mar 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgI/j4U0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B41D5AD9;
	Wed, 19 Mar 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397084; cv=none; b=ZwSA36E/GR8fk/wK8GSxjU3B8S2vcm5ycYywc3bZeguf/68+9RqF/p3X3ebkFhzzxx8PWG9ND1CduEWuEIaurTiqD44siSMFwiKBRNIiz+9D+A5Z/NhnjQLZfAni4wraMGvmYmdliTaOu3Qy/2vYoqAfDUEW/W7Y1Hl5p8dh2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397084; c=relaxed/simple;
	bh=zZCVUvBcP8zvDTA17qjcEna0PARMpjfKQbWossFdjHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECP4VHdzI9PGogfzENcFXLMx7vaKgMGa0d+ZOywyFrYVY448GdEHoSGhAHr9SA+kB5MlfstO1VWB1Fah72YlFUUMzNCfogkaYbgOGwb/dawhsRdaw9Xdm2Y0DgRDiTpBfUzT6dX9aPsNoOWPUaZ+nk0Oe11IgdyVv53k/XXIiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgI/j4U0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-391342fc148so4538810f8f.2;
        Wed, 19 Mar 2025 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742397081; x=1743001881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZCVUvBcP8zvDTA17qjcEna0PARMpjfKQbWossFdjHM=;
        b=IgI/j4U0guncUhWsaVlLg3ng61A69ZdRKp9MGE5YKfye9/1usXrFAHU3tnFWJiEsQs
         cxy6w4pOy/wk50h6nvotUre7dSfqUDQ30hZXBxN+c+mUB3KP5oQq+1GCM8zI8fVKr1al
         xUbOPXLLSVBtGB74dR84njjS5mTqyjfTL0wFZo1Okkmq+91rm5z3b2smjbnsqC2YdHEg
         +uj0l9QcDOWU2py3g9YpvGpBUT99YQ8xAkixUyPnPtcB/FtI+lIdfMzu1xbvZ8qNOnX6
         x0+bOqgpMDKkNePP1EpWlnur2VUlexzUGnBm4NFwEeUrjh3Bjlzl1mNKJBCdKFHdIE/q
         BkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397081; x=1743001881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZCVUvBcP8zvDTA17qjcEna0PARMpjfKQbWossFdjHM=;
        b=G2+hj4OUiCsg18qyADgKsvXrFvV8z4BRjroutfuyciy8EXJzd59JNrGZRlaiDVLeM4
         qv4k97wc6sC0wOGa1uzG+gbaNtSWxdcxZJf+4xZN0qN1I+d+oJ4JrDsIlRyoxHj6OZkG
         kjDB1R0jX0DWpQYQtNzYse9dvpKOE2az0UKk38dDYYXR7zRlnHR2Vz922kDL4fFE2OZb
         ic3uOOwxhh2Gt5QUYup/L3etg8dll/v1NqXeqbMogDdnqvKg8/5xcNeS2/ltSjMxgtAF
         R0VRkijp2hkTJ6osK5JYr2ASs7MO5/b2iWlfUl0NYZqPk60wnwYtqMdojq6jJ5xANkx0
         5J2A==
X-Forwarded-Encrypted: i=1; AJvYcCV3B4/hu5vaWwiLr+kpXfjC5nEredZDthnMj7uECeMUZNLTPqKWAWxguy3+LP004Rq5yYhIF7zw@vger.kernel.org, AJvYcCVkGw4Tedlq3bFHkI7HKTifQpEm4APwTKciilEbVsjNGLDt3+SIwqfcdL89VEhVgDHjv4w=@vger.kernel.org, AJvYcCXMJchwVzWuG8H/3aGIb/eeU6Q0EyFDn8eSTLxhcGj1ppSL2+bC6NeIiOoMcQzND6p9vtinAc78nv7ebA==@vger.kernel.org, AJvYcCXcXbU9dsICjqU40f0TE28YX7MxvbwUCrKqvb15+uh021yBQFCfqc29PEA/hrhPy5Kf7t5MAQDPjeys68KO@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4jBEAlp1pw+w2ruwmChkary3+DLwowea02X4puaicSt+yqb8
	gIfvU8JkXJPlmBAUmJv4pnTmGJeO4UtJRingP9RDqXWvfkr6plEK8HB6f8vAQBQBRnyhui/3vCt
	8jXG+ZkVzaM/FR1xbUJfoXkQCbmxsAg==
X-Gm-Gg: ASbGncsMHKum9K9lXUGhpMmBqGvuEqMV+0jMP0OzZUiaXyVI72D1WEw+zwQNLtWGJjj
	YL2hd91I+xFQC3auiCN+IeIzKEmORzfKP1zf/JfExRC+OETKWRdR9rEvtFiX7sZHOAJ6JykNPGb
	YylbGowXIn7KeIVJAN8OwNkxLaCxRzKTn+RQKGrIQ7I1Px6eaWavKsjQzVvf0=
X-Google-Smtp-Source: AGHT+IFnc1HvWZNKDa1JjpjU3I8fOCgeRNWqualgxF/qAnNf22Qp7WInhotCXWObWjh82fDQsdgR62KCXEdbFD7m70E=
X-Received: by 2002:a05:6000:1a87:b0:390:fbba:e65e with SMTP id
 ffacd0b85a97d-399739db618mr2775842f8f.32.1742397081245; Wed, 19 Mar 2025
 08:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com> <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
In-Reply-To: <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Mar 2025 08:11:09 -0700
X-Gm-Features: AQ5f1JoTSmjrjETVwKdEgE1TiaZzPsz3fltpYyrN8w-q9tqLVyk3QrkAHbP9Rm8
Message-ID: <CAADnVQK8E5JucnGoHAUQiHURpErQYtNJvWOWBottOZf1edT7JA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > > >
> > > > I've sent a fix [0], but unfortunately I was unable to reproduce th=
e
> > > > problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=
=3D 14
> > > > as the patches require to confirm, but based on the error I am 99%
> > > > sure it will fix the problem.
> > >
> > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
> > > Let me give it a go with GCC.
> > >
> >
> > Can confirm now that this fixes it, I just did a build with GCC 14
> > where Uros's __percpu checks kick in.
>
> Great. Thanks for checking and quick fix.
>
> btw clang supports it with __attribute__((address_space(256))),
> so CC_IS_GCC probably should be relaxed.

Stephen,

bpf-next/for-next is force pushed with the fix.

Thank you for flagging it quickly! Appreciate it.

