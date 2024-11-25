Return-Path: <bpf+bounces-45566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB99D7CFE
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 09:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6CE281DF3
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82A18B475;
	Mon, 25 Nov 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdooRpbQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C31376;
	Mon, 25 Nov 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523749; cv=none; b=nl8egGGg1Fsk/KHdIaKFQLbBJpPYlP2mwNHauds0bGI1VxB7BnCXYpDddf26oNZ7vpGunT5kUuEPVn20XDRuQwIS+HHOdaN9Kpkoedh2Hl6Qthh8rGQFKr/RhheF5XL6yVJR/bLSm3ryeaugOtRuvKi7K7ZrAgC8J//sGajSYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523749; c=relaxed/simple;
	bh=giqjuR8SayINfQRMvdKC45TjKx+/gcQKWZAhbM6pN6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGalBSOrtuS5oPiAziC0eK+SGjbXU970APf/GpAWCfewYOArqp8Aq9fnbYx/4zS0y635uQ9PYVNnMR+5clzUyjjuVRKMKiELfCQhn3MpoveBz6IfSpHcUI7Lyqa3xEJTfkXlQUSbT4n5OKC4tRzdKo5PcKEFvFYdmTl2teMd2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdooRpbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E04C4CECE;
	Mon, 25 Nov 2024 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732523748;
	bh=giqjuR8SayINfQRMvdKC45TjKx+/gcQKWZAhbM6pN6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WdooRpbQ5u6eHCnM9Ej4riSSEeaFmHBi7Db444box+szJzgzdapMMH6GZAbrnH2xB
	 sqr4k2kHzpaE1OdphrsR9izJmdStKqo9AiThGJ7T6gDaKM8fssTCtZYrVZz7amT+zc
	 hO5yUeHXDJ857s4LbyLmjJTlPaQ4J2Qe91uhQkwWvcV8ZTdSTqaYDYPJ15L6eFHa8v
	 hnSmmgYvJgID8XBMcjzk8S4hiJmniyJq/tTGVLQdDE4CLpWd6YWS6Heppblvj9PleV
	 rlM2nSvhr5mXoJrZ9WgS0jpEDDH1rUCHruQ9DX34ZVETxU13AlaDS3j3TMTI+Nt1yD
	 d5VJ+yzigvTtw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so28759481fa.3;
        Mon, 25 Nov 2024 00:35:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7kN2IKSQj8bc91QuM5f5/Z/l39/wAU0qNf+204IJaVfno0X3qKq1c7yZmctxtX3g+ZPGyPl6etdBZ4bB5@vger.kernel.org, AJvYcCW3+T1SZWPaSEd8a17wBiFBk1xnpJK1ooCzelubMRDrvHw93JjKvK6y1GoE+X9LQecs237o/s48tfmXIBXC@vger.kernel.org, AJvYcCXDocWxBjQBhTQvzMiymEjQ2Wn4JFicF+LfNG4lKvLH54o6f5KBHyM3TTtV5Z7qzhyI/J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyTY44oFRMs5UMR4Kzm9D9J+ytNdczecI5ZSCCX5KBS6kct8h
	cyjFDy+RCfBzUjB9RyKkrv1EfiXz/DO8aH4a517Jik7LxQUXXK9ijqw5sesSSWETVlR3dHWncSJ
	Plado8MeO/qIzitABS7081L6BByc=
X-Google-Smtp-Source: AGHT+IE3pYY4SyydxATz2K5n+Wei67MO86RDjcb//k8TvfxZ3L/3zJNbxC7jzwmA+XU84NJpz/HlxAZNDIhvOYStDes=
X-Received: by 2002:a05:651c:19a2:b0:2ff:c741:db92 with SMTP id
 38308e7fff4ca-2ffc741de13mr4309141fa.17.1732523747252; Mon, 25 Nov 2024
 00:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
 <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
 <Z0ONnhIVK1Sj9J09@krava> <fa77c47c-b9c7-4013-8ccf-7ee7773c0c2d@t-8ch.de>
In-Reply-To: <fa77c47c-b9c7-4013-8ccf-7ee7773c0c2d@t-8ch.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 25 Nov 2024 17:35:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQw9Ra8p6PtkGqhGvDZoWudsxHGW005ZotcpdqXuAMCRg@mail.gmail.com>
Message-ID: <CAK7LNAQw9Ra8p6PtkGqhGvDZoWudsxHGW005ZotcpdqXuAMCRg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add dependency from vmlinux to resolve_btfids
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 5:58=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-11-24 21:33:34+0100, Jiri Olsa wrote:
> > On Sat, Nov 23, 2024 at 02:33:37PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > resolve_btfids is used by link-vmlinux.sh.
> > > In contrast to other configuration options and targets no transitive
> > > dependency between resolve_btfids and vmlinux.
> > > Add an explicit one.
> >
> > hi,
> > there's prepare dependency in root Makefile, isn't it enough?
>
> It doesn't seem for me.
> If the source of resolve_btfids is changed, it itself is recompiled as
> per the current Makefile, but vmlinux is not relinked/BTFID'd.


If we need rebuilding vmlinux, this seems correct

Acked-by: Masahiro Yamada <masahiroy@kernel.org>


I can pick up this during the current MW.






> > ifdef CONFIG_BPF
> > ifdef CONFIG_DEBUG_INFO_BTF
> > prepare: tools/bpf/resolve_btfids
> > endif
> > endif
> >
> > thanks,
> > jirka
> >
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > >  scripts/Makefile.vmlinux | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> > > index 1284f05555b97f726c6d167a09f6b92f20e120a2..599b486adb31cfb653e54=
707b7d77052d372b7c1 100644
> > > --- a/scripts/Makefile.vmlinux
> > > +++ b/scripts/Makefile.vmlinux
> > > @@ -32,6 +32,9 @@ cmd_link_vmlinux =3D                               =
                         \
> > >  targets +=3D vmlinux
> > >  vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
> > >     +$(call if_changed_dep,link_vmlinux)
> > > +ifdef CONFIG_DEBUG_INFO_BTF
> > > +vmlinux: $(RESOLVE_BTFIDS)
> > > +endif
> > >
> > >  # module.builtin.ranges
> > >  # ------------------------------------------------------------------=
---------
> > >
> > > --
> > > 2.47.0
> > >



--=20
Best Regards
Masahiro Yamada

