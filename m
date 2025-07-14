Return-Path: <bpf+bounces-63248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE0B048DC
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27D57AB2B7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1D23AB87;
	Mon, 14 Jul 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCHTvO2e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE687239E6B;
	Mon, 14 Jul 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526603; cv=none; b=R1q3pE3jNAE/Unrm+VddU5bmvma8k1D5RxWvE9qMvh+OZB9wRa25iJpC2PdSrwaqLYlrU/Bz5p31WzDy9WsXKPSWZH4oO7P6exfyr/6OJ4gUcanLt1ZbdzAyqkUgUoi3hCJbopi/Fu8yYuNbu36yFGovEoXF0itM1jHlZgIbbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526603; c=relaxed/simple;
	bh=0YShKZtSncb/nch0G4vGOX+qOxCRREuAJGnfSkEXYFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhKJsIpvU/4JZgTvZF9M3aBdhBn1c+dl2cG6npFM57o0BfcucESL9tlJY0aeCkf9JQPUcaGB/r0+h+bVata4qvpRGHtLL83kfww56ae3b7UQ2bMfVldxBmliEi+xeWYxIttkLj3Iqsh2tnOcb7wiTSiBTYTe2kKoKQABQkrcKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCHTvO2e; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b390136ed88so3550095a12.2;
        Mon, 14 Jul 2025 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752526601; x=1753131401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7hS8xv7YrfADJ1HYUxX6xnUnehE1Jq8V6yW09+p82I=;
        b=HCHTvO2eDgDr4EvSGXCgKJoSV58C1VeStUDxtOQ5HA+wR7J7vS3L+xdxKesshz1Sk+
         q8L9syzHnuJIGvJQVpm5ipQ+7KcvV+sPOzAeFHx03U0VrYNyNh8TXJEAaAz+xW5o5vtH
         OVPpM3EL9UVbeSCo+8O4R2A4CXPxber7BvxeYM5lihQpaD+RSpCpJoEjDD6Ugk6ZEZK8
         Py8mN9MtTMbWfYxNTssjtqBRK4meZvjfFBMnCcrHjAFH0YoQn5b2OnS9h6+62SY711rc
         FbHZG3LB1U2V6hfUYZYuSvcMoEw3knwHCL+il9D5Cf8okPVb0JacZKINqirVHKDOatsp
         FzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752526601; x=1753131401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7hS8xv7YrfADJ1HYUxX6xnUnehE1Jq8V6yW09+p82I=;
        b=HpVbKXmaWafHjdOKU+/91zvi7fDJ5DapWRE/MfMvuz2dPdO5N+5YjWSFxvcLfnYTpO
         4JD3xvlpOrk/j6enufrn+vc8Jtf+LRf1msovSbQ+RZeo8NoF7vQZ5tQG4yqtZMctlget
         38f0aN3CRnU9SyjKFon5xDVfeOMmbpHmeOfWAIGDIDxeBUHRQrpOqVZMK33stsGgiJcN
         sRPrLCgjKOflzPgCR7fBDZ3j1gvFq5BaAGGOPYdO3xnXgnO4dUt9XbCvmxJJb5tOd8WJ
         F7+/gKe3uABU+D9V2hwDsmVDgxV3pGaxFQ2Fk4C49r3cUHR5VJ94zj23uWwPo8NBl2lW
         AHRA==
X-Forwarded-Encrypted: i=1; AJvYcCUs8FLRMEF2j21SkTPL4PQJpYZeZKkrJVJTbK5QWyIVEgSZTJoCk5kasTjRuWu6PhSmhXdHC4p6lRO42lRqy+NWi/ykL+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXeDKuEypXv4Wgf1OdzRIqKxQsUcMJqzxQEuENipUaJn4/dpL
	c3N8kKesqxFlUgVA55yU45RumnoEP+rGebZBu3PgrN7PdraYL8uhSwX9+RF+FAwqur1mfRDIWLj
	mA9lwTwEANIxP76p0y9ut+1C+jftLlCwnxRfI
X-Gm-Gg: ASbGncsIufKvyuDkMjIynp70S2OsrC4A8ovqFN7Oun1ZJIr0Aa7xsi0xIYCTksJidZY
	seGaQ76e+e/HaW1Iw2vKc+2zfG4hdEPYEPhVQ9XYW+GDKHt/PMwZZfGknLPVMZ5NGvIyoa5cwla
	OUCzozHN1AOa7AjfAyRiYesW2if/oFP/NCYhCn7Tng1XScjXwhuj+DbuOWdYYbkBkMf1Qw5hvx3
	rn7khIKCdI+ffavB0/Jr+BCXa2zCcWEgQ==
X-Google-Smtp-Source: AGHT+IH9uNE+Gn9ulUlrKKRv3i2K+rCPFSAonU1Gmf/Za5qPCf51TcNjbl1w7iIzTXdiIS+yswb3/lsUrTaHPADIAz8=
X-Received: by 2002:a17:90a:da90:b0:31c:72d7:558b with SMTP id
 98e67ed59e1d1-31c72d75601mr9523482a91.32.1752526600982; Mon, 14 Jul 2025
 13:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
 <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com> <CACYkzJ7_JfCmDC5mdjTUzO3ZKA2E1-WamPMxQ5F0iLoKgaFrAQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7_JfCmDC5mdjTUzO3ZKA2E1-WamPMxQ5F0iLoKgaFrAQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 13:56:26 -0700
X-Gm-Features: Ac12FXwu6azm8uxU8Ec0cY2Ck0p-WJn6QewZFNi1DVWLjy7UP0cPhf150zA-9F4
Message-ID: <CAEf4BzYFfXbarqDYj7GBXabNr03xFYHaj2-yBx1EZnkVP+hN4Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 5:53=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Jun 13, 2025 at 12:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > >
> > > Implement a convenient method i.e. bpf_map__make_exclusive which
> > > calculates the hash for the program and registers it with the map for
> > > creation as an exclusive map when the objects are loaded.
> > >
> > > The hash of the program must be computed after all the relocations ar=
e
> > > done.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  tools/lib/bpf/bpf.c            |  4 +-
> > >  tools/lib/bpf/bpf.h            |  4 +-
> > >  tools/lib/bpf/libbpf.c         | 68 ++++++++++++++++++++++++++++++++=
+-
> > >  tools/lib/bpf/libbpf.h         | 13 +++++++
> > >  tools/lib/bpf/libbpf.map       |  5 +++
> > >  tools/lib/bpf/libbpf_version.h |  2 +-
> > >  6 files changed, 92 insertions(+), 4 deletions(-)
> > >

[...]

> > > +int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program =
*prog)
> > > +{
> > > +       if (map_is_created(map)) {
> > > +               pr_warn("%s must be called before creation\n", __func=
__);
> >
> > we don't really add __func__ for a long while now, please drop, we
> > have a consistent "map '%s': what the problem is" format
> >
> > but for checks like this we also just return -EBUSY or something like
> > that without error message, so I'd just drop the message altogether
> >
> > > +               return libbpf_err(-EINVAL);
> > > +       }
> > > +
> > > +       if (prog->obj->state =3D=3D OBJ_LOADED) {
> > > +               pr_warn("%s must be called before the prog load\n", _=
_func__);
> > > +               return libbpf_err(-EINVAL);
> > > +       }
> >
> > this is unnecessary, map_is_created() takes care of this
>
> No it does not? This is about the program and the latter is about the
> map, how does map_is_created check if the program is already loaded. A
> map needs to be marked as an exclusive to the program before the
> program is loaded.

Um... both map_is_created() and your `prog->obj->state =3D=3D OBJ_LOADED`
check *object* state, making sure it didn't progress past some
specific stage. excl_prog_sha is *map* attribute, and *maps* are
created at the preparation stage (OBJ_PREPARED), which comes before
OBJ_LOADED step. OBJ_PREPARED is already too late, and so OBJ_LOADED
check is meaningless altogether because map_is_created() will return
true before that.


What am I missing?

>
>
> >
> > > +       map->excl_prog_sha =3D prog->hash;
> > > +       map->excl_prog_sha_size =3D SHA256_DIGEST_LENGTH;
> >
> > this is a hack, I assume that's why you compute that hash for any
> > program all the time, right? Well, first, if this is called before
> > bpf_object_prepare(), it will silently do the wrong thing.
> >
> > But also I don't think we should calculate hash proactively, we could
> > do this lazily.
> >
> > > +       return 0;
> > > +}
> > > +
> > > +

[...]

