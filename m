Return-Path: <bpf+bounces-1467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7777170CE
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 00:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B38B1C20D7C
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39C206B9;
	Tue, 30 May 2023 22:37:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21782A948
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 22:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB01EC433D2;
	Tue, 30 May 2023 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685486258;
	bh=zlKPf1zWEZmccX9g5IdIK7T/lGMu8AaFUNgCzd/alzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h8nJ9Vic5pc1MPghQKIV+6G4nGyVxapMQSX9onSpimd49f0Dt94rgN6uwFWN6JCx8
	 g/uRtOt/CaWAN8Ti/n0pNBHxvraJqbAYAEDiySib6aRFx/kq2NSaRS6eYwsR9804EO
	 xrVQB9d0QxMUL8fFPmH4goy/vbYeYl3MOPUTnTlmW0/xxipwzhZdN8zYP5NeourDky
	 Kg2gls6Glev6/Ln4gve6totJHasnwJ8gHhVQJOAAH9+IZrNi/1ehUC92qGB27HynmO
	 JdFxzPeMgqec4SxEwZgO9e4GQ6S2bTmz/Tu00CI6mIogKw92d3fYOuFqWWhMunTYq6
	 FnWqgjkhex2Nw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so5657423e87.2;
        Tue, 30 May 2023 15:37:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDz3H1+mJUcJg79xCeLwiXFYAwKEvXoFFBGieuPcd+4eBLkJ3SiF
	fA8RRh8bQhaL8cUHRuruLXPwGVv8aTZtKimKEIc=
X-Google-Smtp-Source: ACHHUZ5ooYFKQsuPaTyXMgJ5NVjOHadGyJuwtkOmYRpkguSA/6TROmpB38zgUeFvQZYofPrrOwd3LU6QBgsDmUCj4K0=
X-Received: by 2002:ac2:518d:0:b0:4f3:b215:ef7c with SMTP id
 u13-20020ac2518d000000b004f3b215ef7cmr1466352lfi.23.1685486256839; Tue, 30
 May 2023 15:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526051529.3387103-1-song@kernel.org> <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com> <20230529104530.GL4967@kernel.org>
In-Reply-To: <20230529104530.GL4967@kernel.org>
From: Song Liu <song@kernel.org>
Date: Tue, 30 May 2023 15:37:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
Message-ID: <CAPhsuW6g98Wz9Oj1NiwwZ1OkSVNXX10USByY0b9tEfzOt8SVQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Type aware module allocator
To: Mike Rapoport <rppt@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, mcgrof@kernel.org, peterz@infradead.org, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 3:45=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> > On Sat, May 27, 2023 at 12:04=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > I think this needs to back to the drawing board and we need something
> > > simpler just targeted at executable memory; architecture specific
> > > options should definitely _not_ be part of the exposed interface.
> >
> > I don't think we are exposing architecture specific options to users.
> > Some layer need to handle arch specifics. If the new allocator is
> > built on top of module_alloc, module_alloc is handling that. If the new
> > allocator is to replace module_alloc, it needs to handle arch specifics=
.
>
> I'm for creating a new allocator that will replace module_alloc(). This
> will give us a clean abstraction that modules and all the rest will use a=
nd
> it will make easier to plug binpack or another allocator instead of
> vmalloc.
>
> Another point is with a new allocator we won't have weird dependencies on
> CONFIG_MODULE in e.g. bpf and kprobes.
>
> I'll have something ready to post as an RFC in a few days.

I guess this RFC is similar to unmapped_alloc()? If it replaces
vmalloc, we can probably trim this set down a bit (remove
mod_alloc_params and vmalloc_params, etc.).

Thanks,
Song

