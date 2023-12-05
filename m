Return-Path: <bpf+bounces-16762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B0805D5A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D85281CEF
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658868EA7;
	Tue,  5 Dec 2023 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHiriVMl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED710CA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:28:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so6923416a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701800932; x=1702405732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zciHMcY570pG2crMnGDJoJDQoI7U1ZG0eUYDkYh61pA=;
        b=JHiriVMlRFAiwEo3ay/UYOmDS8YpL5lPEd7z+dcQFo5II1T1Q/haqN4SDAkqG3w1qi
         k1NouhS52JzrMv6ofDUabMbrwnWNfxFvpH3xJ1fLP7e9P4Qb5beUrtsA9fn9E6vPjB/t
         9HVZhmjV026A99SDmQzJ1HDKDU+T5LsN1gL8i6FOB4Z79H2i5btbTtCv5KZUcnEdHTJ0
         Mp/3lZERc9/1tlv4E1yYo+qJ7TXpghEP/TJQWUUSJRAmjA59/OuWjzZI2eG4N5Jf6A+Q
         tsGQas3D3Kj8f58Fy1iXUF+9QmsuZamSUFfoMQ162jFovhHruj4GXPDt084tkR5vyEP4
         Ne3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800932; x=1702405732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zciHMcY570pG2crMnGDJoJDQoI7U1ZG0eUYDkYh61pA=;
        b=PmsfPsuOrGfG2G6JYL0UozDZg6bbzAwnRLwOVbCCA8HcrRNBsylBzGZNaLgn61cKm7
         bEngTqm1c7rPs86DCH1c+XWiKI6yfAuD2QmnjyBkdAtf8ZCE7aH/YBHFTslvT2LtidS4
         p9BlzAWqXxHd+skoFEXW7ZG/zW8YC6D81VwS0naL386S7UltA/STzJCh/dV6DUW37vO6
         +hyNmMQx+PhIdE08zi8k6dqU4H3QezXtA2D2ST2t2VVFrQQEfw1CssBAR2eQT21FmhZD
         kkSto9uUZgPfyws1JftTkOGASIVNGn5obqB7DNL42eiWMEeBxPhn0e6MB2JYmxpFTaPX
         Uh1g==
X-Gm-Message-State: AOJu0Yy1XaaYN0DTRvUXfnwoN948tMkjMFuRX+fSQ7YpjDkFvVekR1U0
	ANq3PsYdq+WRFKhiHSUTNVlsB88TGjmou9s9JKI=
X-Google-Smtp-Source: AGHT+IHAnqm2h1vNYlZIjFTCQZOjaJ2e6cdX5HDPJSJ0p5jvJLlWj0lWSltcDpQmLPRTE2el4vgGmFGwaeNfD6hyz20=
X-Received: by 2002:a17:907:7002:b0:a1d:4d2c:9bf7 with SMTP id
 wr2-20020a170907700200b00a1d4d2c9bf7mr71817ejb.68.1701800931945; Tue, 05 Dec
 2023 10:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201094729.1312133-1-jiejiang@chromium.org> <20231205-versorgen-funde-1184ee3f6aa4@brauner>
In-Reply-To: <20231205-versorgen-funde-1184ee3f6aa4@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Dec 2023 10:28:39 -0800
Message-ID: <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: Jie Jiang <jiejiang@chromium.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	vapier@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:31=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Dec 01, 2023 at 09:47:29AM +0000, Jie Jiang wrote:
> > Parse uid and gid in bpf_parse_param() so that they can be passed in as
> > the `data` parameter when mount() bpffs. This will be useful when we
> > want to control which user/group has the control to the mounted bpffs,
> > otherwise a separate chown() call will be needed.
> >
> > Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> > ---
>
> Sorry, I was asked to take a quick look at this. The patchset looks fine
> overall but it will interact with Andrii's patchset which makes bpffs
> mountable inside a user namespace (with caveats).
>
> At that point you need additional validation in bpf_parse_param(). The
> simplest thing would probably to just put this into this series or into
> @Andrii's series. It's basically a copy-pasta from what I did for tmpfs
> (see below).
>
> I plan to move this validation into the VFS so that {g,u}id mount
> options are validated consistenly for any such filesystem. There is just
> some unpleasantness that I have to figure out first.
>
> @Andrii, with the {g,u}id mount option it means that userns root can
>
> fsconfig(..., FSCONFIG_SET_STRING, "uid", "1000", ...)
> fsconfig(..., FSCONFIG_SET_STRING, "gid", "1000", ...)
> fsconfig(..., FSCONFIG_CMD_CREATE, ...)
>
> If you delegate CAP_BPF in that userns to uid 1000 then an unpriv user
> in that userns can create bpf tokens. Currently this would require
> userns root to give both CAP_DAC_READ_SEARCH and CAP_BPF to such an
> unprivileged user.

This is probably fine. Basically the only difference is that BPF FS
can be instantiated inside an unpriv namespace, instead of in a
privileged parent namespace, right?

But delegate_xxx options are still guarded by the explicit
capable(CAP_SYS_ADMIN) check, so that unprivileged user won't be able
to grant themselves BPF token-enabling capabilities without a
privileged parent doing it on their behalf.

Is my understanding correct or am I missing some nuance here?

>
> Depending on whether or not that's intended you might want to add an
> additional check into bpf_token_create() to verify that the caller's
> {g,u}id resolves to 0:
>
> if (from_kuid(current_user_ns(), current_fsuid()) !=3D 0)
>         return -EINVAL;
>
> That's basically saying you're restricting this to userns root. Idk,
> that's up to you. (Note that you currently enforce current_user_ns() =3D=
=3D
> token->user_ns =3D=3D s_user_ns which is why it doesn't matter what usern=
s
> you pass here. You'd just error out later.)
>
> >  kernel/bpf/inode.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 1aafb2ff2e953..826fe48745ee2 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c

[...]

