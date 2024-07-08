Return-Path: <bpf+bounces-34060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55479929FD0
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32FF1F21D7E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008175808;
	Mon,  8 Jul 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjMQoKB/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7936134
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433091; cv=none; b=E7U4WzbGeMTHfSaRciBumMUHYbVOUpTR/+D+bc+zrqzvpM5bOQbWsMb035+7xG6W+XXQf+M7ol+fYtB3QRKVEQNKho0ICagaKgwKIZxx2+VAYy0KzWDAOHYnbq8UXAHIOnIdtf3datbKDeE7D7pQtrsbCFKj3/Ttd2uXk25iyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433091; c=relaxed/simple;
	bh=USy5tAusbYhsNK4T3DhzfrXWJZNN3yFfYPLsqMtD+AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfY0dHZicT71dLE0WINi26m0asNg5oWnZSi3Cpglsdd1R630+IyI2tOIjcBI4le3UAewJWtrR0HTdxmwS9BE+4wAzQuvEzY+gwvTY01mA9zlofLKvmpdeZ3XPAqKD0z/XqXJOsOPwinoXypw9qso9dPWfL4vO0K7L/5SPA1w+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjMQoKB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72E5C4AF10
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720433090;
	bh=USy5tAusbYhsNK4T3DhzfrXWJZNN3yFfYPLsqMtD+AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HjMQoKB/Tz2oaWPvKxRodrl1bgihRp5pQHQoz3ddUDeg968b/8wOlJmO+Ir2YLfRz
	 1/AXGdUzDNwK2J5d6Zq+LDqz4IiWJhJfBbk8LhJUlRcVlPat/qiajn59/yrTWvbVYk
	 O828Kp1hh0AKM4Za9t9E3otA9iKjMMPbOwu2ai1LHIG53DnJqPdnuor5HxfInaJKsb
	 oUDac6oYF4CwZqYITibpyHC3+vamLNehSWrQPT6zhqePwcM2QhPJIVOd4LCnEdaFLW
	 yTTZdM+pxpG5upHtOWJheV+b9p7hdYLpDqwkn8/q0L//HG+tkRX991Zkw33uz7XfqC
	 J72cL00m56gcQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso4637403a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 03:04:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6O7lzt2D21ogw3fRu8AK7iRiRaArhJYbLff+ldjJfqoyOGZ9z11ZJ16Uhagumq8ULOODOVDV5YS1FvUuYpvHResDT
X-Gm-Message-State: AOJu0YzlodFcUNcG/9g+VSZbNmPlGZBREWbhnlOo+LQfDpVYFE5lhldl
	cCWghFecv3289viSeQpooAX/2D6XC9ka0M3Iak6DfcGhV+4UOnhDq5i8O5f78ElAbpmPiznr0LF
	pu0u8gyYYrMndnnphiy5QgoQjZ8cgYyaOKFj8
X-Google-Smtp-Source: AGHT+IHYhZUMGl3xoMe6nGJCiUDuux4b5qNKC9p3FSNKDNSbMdP8pPQTIUoPx5b2kRBVKsNnXotkfx2Vvb3CGONNVLc=
X-Received: by 2002:a05:6402:40cc:b0:57a:27c8:3269 with SMTP id
 4fb4d7f45d1cf-58e5a7f0899mr9931152a12.4.1720433089092; Mon, 08 Jul 2024
 03:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
 <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com> <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com>
In-Reply-To: <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 8 Jul 2024 12:04:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com>
Message-ID: <CACYkzJ5gAnbXX_aWy6952s2O5L2p3Mw14OUfo9Z-Od6_Dp2HLQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 6:40=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jul 5, 2024 at 3:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:

[...]

> >
> > Paul, I am talking about eliminating a class of bugs, but you don't
> > seem to get the point and you are fixated on the very instance of this
> > bug class.
>
> I do understand that you are trying to eliminate a class of bugs, the
> point I'm trying to make is that I believe we have addressed that
> already with the patches I've previously cited.

The class I am referring to is useless hooks returning a default value
and imposing a denial / enforcement when they are not supposed to. If
you think this class of issues is not relevant to the overall LSM,
sure. I would still like BPF LSM to not add default callbacks as I
have always maintained since day 1:

https://lwn.net/ml/linux-kernel/20200224171305.GA21886@chromium.org/

BPF LSM does not want to provide a default decision until a BPF LSM
policy program is loaded,

>
> > > > 2. Performance, no extra function call.
> > >
> > > Convince me the bug still exists first and then we can discuss the
> > > merits of whatever solutions are proposed.
> >
> > This is independent of the bug!
>
> Correctness first, maintainability second, performance third.  That's
> my current priority and I feel the maintainability hit doesn't justify
> the performance win at this point in time.  Besides, we're already
> expecting a big performance boost simply by moving to static_calls.
>
> > As I said, If you don't want to modify the core LSM layer, it's okay,
> > I still want to go with changes local to the BPF LSM, If you really
> > don't agree with the changes local to the BPF LSM, we can have it go
> > via the BPF tree and seek Linus' help to resolve the conflict.
>
> As the BPF maintainer you are always free to do whatever you like
> within the scope of the LSM you maintain so long as it does not touch
> or otherwise impact any of the other LSMs or the LSM framework.  If
> you do affect the other LSMs, or the LSM framework, you need to get an
> ACK from the associated maintainer.  That's pretty much how Linux
> kernel development works.

Okay, then let's not make an LSM API, I will handle it within the BPF LSM.

The patch I proposed should not affect any other LSMs and is self
contained within BPF LSM:

https://lore.kernel.org/bpf/CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qN=
NEfg@mail.gmail.com/


>
> --
> paul-moore.com

