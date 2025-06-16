Return-Path: <bpf+bounces-60779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C425CADBDC3
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 01:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0003918915C3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602722F14D;
	Mon, 16 Jun 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDY4T2sj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8C2163B2
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117029; cv=none; b=WtBBJXd+x8IXsPJv0G3fHeeaj8i6kcA+papzWoodnPn4/qki/jNcue7a2C1xTjaC4VD4yjH0DrPRUP0Jn0sMt2kWbJnVl78w+0Es1GP4nSYo1ZMeMsip7a0m6wOoLyjsVEQmS8/Qs388cxybZiIM87IwMFciUjfztr+AcXvmHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117029; c=relaxed/simple;
	bh=HEKJ13sbMQ7XRIVtVSdhBAAeC0w/Rk+mFe7mNEW0fis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGKwP63LpCoG05xG616GUEQEgYfsZvgF3uxaBIZXnX1Lir4OmCRbIPLT8pV1d+vgecWIG6bdA7eflI/FVqM7MmXJyZCh1TUOGg40Oa0gEhx72riE8AbBjiGPGkAJj5fZSy9ghse9UdE/zJJLlNtFfG1weIB14NeF3bETLo8Kgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDY4T2sj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso4606827a91.2
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750117027; x=1750721827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNwDORcO4bHfXQRFrCL0fYyHh5Y9Ugr7OJawSD9yuFk=;
        b=nDY4T2sjY247LftFMCuZ5xt9tMnv6yYQGc6/pUheIfmHp9X/ez/2LYba7jSwce80FM
         UdYNxWL/OfMZLItCr5bq2dyvyIvddMcLIxsv6VwAEwEDNDcuN6HdmnmqC7/6e2Pawmn0
         lw+/2Wy8Y8tcQO0YKCK/xVsVqLda/T0LGveITgMYbzfJr+nt+Czv8ANPz8x8nfXPsgHk
         drR6ZxWDCnl7uJ96k/GigT3G2CkUc/5Vyx6vZUl8J/2jBaBLPKrKhPzDUkeAQQ+WaW/8
         dsY1IaHTeXfxZQXckw9imTmZcfAG2e308aCKfA/iOzY8s8Vg5czrTPPFplI9hJZtRd16
         +WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750117027; x=1750721827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNwDORcO4bHfXQRFrCL0fYyHh5Y9Ugr7OJawSD9yuFk=;
        b=KqS9QYLn7S1/zlpH4X6I4oaEjrdXtVDTAbnSx7jHiPMNJBYnXG6q7HfZyLM4XyMVeH
         5mpm4SK0GFGBD88BxeYL3O477dl/Sq/TJFr7hQdRkWIA4RdRlSUPwkMxrr9AMNvTDtvc
         /rrUcVdv4Mz0oW+l0tM8G5RoawHhzikWsDOKmFmUGsL8N0QUYUsQsSA52Ttbj+Ul98Uq
         bhg7TI0y4zs/RwXZZYnOK8Fp04KSuQEd55n4V2zf6vsnJsN+BuhqbAUuGv9W+0AcC61+
         nmCuXxKRcYjDbgSCZhtQDIbLfTh5k4mYhb0zkC0AEfWVvmDc7NRyx7cnOC+VkjXQmw+u
         zsLQ==
X-Gm-Message-State: AOJu0YyEe7G5lRdyA5y7kmxA7dmC5OOpZyDaD9cc16W+nyyGc4tV71V9
	PeZFnGg/orb2hp71ibmbiKucFb5+39jT0EjEw7rpSyBUXf+aLkMhg2tq50yrtzfbYI1Ic2MORDg
	7qtvLllmVJ+PP10jbgbkZWKV4jRy16Tc=
X-Gm-Gg: ASbGncu6Da9hbdNIQyJqV2RwO9haG3NaUZoLcCS4pyvGeIJ5bdPOm5ZGZRN8Qmju0BK
	1ul9RZQ3PiwD5LbpSE2rouUiIxc0pkMntL1XcVscWtulWR/ZJ4t+eycW+wcnDH36BsQCHKdVNW+
	wX2IjE/z1S9pJXOBpSKo3ihugiWVq3OgmZqKdzPF/oDRqaGooJ+Z2LKDDrAEI=
X-Google-Smtp-Source: AGHT+IEfsf7uxVuXF3mTn7nePr+MrfqUJc9FIVomekZ9U/xizQzp0trtUyDbDsFusf4Jb7fo2h74/DfoyJFHvW+ptbs=
X-Received: by 2002:a17:90b:5150:b0:312:1143:cf8c with SMTP id
 98e67ed59e1d1-313f1cafae6mr18239936a91.16.1750117027511; Mon, 16 Jun 2025
 16:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614050617.4161083-1-eddyz87@gmail.com> <20250614050617.4161083-2-eddyz87@gmail.com>
 <CAEf4BzYh38ZW5x_tttT7qGSPbUtT4SLC7F+aoE_cymkV5q59hw@mail.gmail.com> <d92b2e43d7710624deaf10a9919cdfa45ee91bdb.camel@gmail.com>
In-Reply-To: <d92b2e43d7710624deaf10a9919cdfa45ee91bdb.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Jun 2025 16:36:54 -0700
X-Gm-Features: AX0GCFtYqzOwguz4sVtp5t5FFnuaSZ-D1HO6s2G64GpEyny7eloEnpHwKCXYylA
Message-ID: <CAEf4BzbHZgz3=1o2gmE80cyD7AVDejdDZEk1Qv-wqdL6cs62nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] selftests/bpf: more precise
 cpu_mitigations state detection
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, laoar.shao@gmail.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:27=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-06-16 at 14:13 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +static int config_contains(const char *pat)
> >
> > int-returning function... but we return do `ret =3D true;`, that looks
> > accidental and sloppy. Let's add a comment that it returns <0 on
> > error, 0 for no match, 1 for match and stick to numbers everywhere?
>
> It was actually intentional but ok, I can change that.

Thanks, I wouldn't mix true/false and integers, even though false ->
0, true -> 1 implicit conversion is well defined.

>
> > > +{
> > > +       int n, err, ret =3D -1;
> > > +       const char *msg;
> > > +       char buf[1024];
> > > +       gzFile config;
> > > +
> > > +       config =3D open_config();
> > > +       if (!config)
> > > +               goto out;
> >
> > nothing to gzclose if open_config() returns NULL, just return
> >
> > pw-bot: cr
> >
> > > +
> > > +       for (;;) {
> > > +               if (!gzgets(config, buf, sizeof(buf))) {
> > > +                       msg =3D gzerror(config, &err);
> > > +                       if (err =3D=3D Z_ERRNO)
> > > +                               perror("gzgets /proc/config.gz");
> > > +                       else if (err !=3D Z_OK)
> > > +                               fprintf(stderr, "gzgets /proc/config.=
gz: %s", msg);
> > > +                       goto out;
> >
> > nit: I'd probably just do
> >
> > gzclose(config);
> > return -EINVAL; (or whatever the error code might be)
>
> I'll make this change just to avoid arguing but don't understand why tbh.

I don't insist, but early return is easier for me to follow because it
clearly states that nothing is going to happen after that point, so
whoever is reading the code doesn't have to jump around the code to
see if there is some follow up logic.

It's similar (for me) to the common pattern of

for (i =3D 0; i < n; i++) {
  if (<some condition>) {
     ... here goes multi-line processing logic ...
  }
}

I find it much more mentally draining than more obvious (to me)

for (i =3D 0; i < n; i++) {
    if (!<some condition)
        continue
    ... same logic, -1 level of nestedness, but really it's just to
know there is no other logic past <some condition> ...
}

It's all subjective, of course.

>
> [...]

