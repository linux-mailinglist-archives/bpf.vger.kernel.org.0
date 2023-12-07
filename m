Return-Path: <bpf+bounces-17011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6A808B2A
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7081C20AA8
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7444377;
	Thu,  7 Dec 2023 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnnEPcXn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E6C3
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 06:56:33 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67ad891ff36so5565006d6.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701960992; x=1702565792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC3/WFkPvYymJTPAzkMoINYv0neN6ZWDbuyYpIh0ZPU=;
        b=OnnEPcXnHaS4KqBySsbIyhESNctTV2hefrwpSp8sz4Z+kSatD65/kkg586BZ+8GrhH
         kMj4jmFYztz/SqvfDaOWzRiXBWDJVT6/RJcfEZkj8paYF+mrVSPC/IW8ODyzyF/OZaFy
         Fa8Zge+ZWCOek0hWgKy0L7WWCON+HMxjs/w794XfqMdDL+gpilciHogljVqw3WmpBQtx
         XS9xsKok9ZACAS5Ja8qCK9rCwblfYmEJ8TgQPCbeEQ28lP7qSWUo9Mt+71vFvNOhoFC1
         cYaO3cP2UjF/POC4/CgbRG3SogCC1R9MSy1Ukw0L8GiGsMcvkIv7LSlwry0gE1rVbvr3
         ykwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960992; x=1702565792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC3/WFkPvYymJTPAzkMoINYv0neN6ZWDbuyYpIh0ZPU=;
        b=vxb407zglWK2iB0tjZc9VsN51lTRbjJSRzWAMhqsf9kMulR2GamXfVZ/nW1s4Rj3Nm
         jpozG1Za2k7EP5IZzgGOgCDiryT8rjK/GeMAXWZ5IUdiitcsijGIfOSWOW8GlIcVNoly
         5x6EKdWMUutIeYQHr9Of7RRE5kRKf4NhJxlCDmvRLc7luxeuxkwBC51vmschcOOWz281
         uoaFjqvQF0ErYczuTSizmNJembFGPnj0CJfinYivGdwKtxdtQMzxNV/BbYJ+gYOZsSVo
         1feKgP73PLllVwGwIPkaL2nnsj3QWsX0d5uRgLsAEEIjZ/9CLVGDZl7Em7TedxvyjX3p
         Znlg==
X-Gm-Message-State: AOJu0YzqCvnZloLWk1hLF5UgfLywrIgdY95KTfP1P6+5M2BedIOKLrin
	YVdRAwrtgwM9Olj006UI5c2fWW8piC9h73w0Xp0=
X-Google-Smtp-Source: AGHT+IEQqtMY6Kn6tJLMsNT7wIaJLBiLaqv+pzR5Ljlk7r+2jaWmWY35vdwC9qSWzF8QdxXUODdyXA8Jco/HqjLTokE=
X-Received: by 2002:a05:6214:164e:b0:67a:a721:d78e with SMTP id
 f14-20020a056214164e00b0067aa721d78emr2467128qvw.116.1701960992239; Thu, 07
 Dec 2023 06:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <CALOAHbDjdNhtkTdimkQaqrPOX2gOxao9Z_udjyPsfhPfu=+vKA@mail.gmail.com> <CACYkzJ6fgjMHvyUt0v5Z_-_uSKPu-zdKu+iXDZBNQZWsVc2WXQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6fgjMHvyUt0v5Z_-_uSKPu-zdKu+iXDZBNQZWsVc2WXQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 7 Dec 2023 22:55:55 +0800
Message-ID: <CALOAHbC3b9scsysawvAQ5Pq2igaxdvCdeL4=2LdKQn5TVWgY6w@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: KP Singh <kpsingh@kernel.org>
Cc: Frederick Lawler <fred@cloudflare.com>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 10:39=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> > >
> > > IMHO this is the best option. Here:
> > >
> > > * BPF LSM Program =3D MAC Policy
> > > * Removing / detaching / updating programs =3D Updating MAC policy
> >
> > What happens if a privileged user terminates the BPF LSM task and
> > deletes any pinned BPF files that might exist?
>
> The LSM program is pinned, so it does not matter if the task is terminate=
d.
>
> > We can apply specific capabilities to restrict access, but it's
> > important to note that privileged users might also possess these
>
> That depends on how you implement your restriction logic. If your LSM
> program says, check CAP_MAC_ADMIN -> Allow removal, then your logic
> explicitly grants the privilege. If your LSM hook denies all
> privileged users the ability to remove the program, then no privileged
> user can remove the LSM program.

If it's impossible for any privileged user to remove the LSM program,
this brings up another question: how can we stop this program?
However, if a privileged user does have the capability to remove it,
then the individual capable of doing so might possess these
privileges.

>
> The whole point here is to restrict privileged users from doing stuff.
>
> - KP
>
> > capabilities.
> >
> > >
> > > The decision around who can update MAC policy can be governed by the
> > > policy itself a.k.a. implemented with BPF LSM programs.  So we can
> > > update hooks (as suggested here inode_unlink, sb_unmount, path_unlink=
)
> > > to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN o=
r
> > > even further restricted)
> > >
> > > While, I think this may be doable with existing LSM hooks but we need
> > > to probably have to cover multiple hook points needed to prevent one
> > > action which makes a good case for another LSM hook, perhaps somethin=
g
> > > in the link->ops->detach path like
> > > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L=
5074
> > >
> > > What do you think?
> > >
> > > - KP
>
> >
> >
> > --
> > Regards
> > Yafang



--=20
Regards
Yafang

