Return-Path: <bpf+bounces-17262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036580AFC5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2C51F213EA
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCF59B7E;
	Fri,  8 Dec 2023 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuWnAG+Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6759B7D
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 22:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD7EC43395
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702075243;
	bh=gBe4Yw3lJK9hMOBvE55lhceshoFtlvq72WCe6hZXMOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UuWnAG+YtwT78nSPUrNKoYh4B2Fd66BTdA6BfLlcYKlOpvKug/1QpYABEYQMxDWJS
	 DkHWWjAe4al2qRaEIMDIgjWPueUCysLMRD371nvTLPDDlTrmGPBcHyFfRi4FyCvmC0
	 NhbRYYg24SLRDnx3SVJfdO9epElDahZZS/xN/3+XUlAPVagCBDRKP1A91K5wlTNydz
	 lNrAGlfx9x0VaBF0XHPmKVdkYWQZfXjDNfN6xt1OpJoinLe1a+fpEDmZSv/ypnQsKu
	 gQil0dpLcp2Ae3yxowU4lN+/5nzzpq4DY0CkbIRl7/gRRYEM34bR2y8eLPiQtlRtVT
	 sqQkk4wQkKzCw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so7576882a12.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:40:43 -0800 (PST)
X-Gm-Message-State: AOJu0YyOkpO5dovfCc4oe06g2QQyjsTpLlOmovpvFtJCkEC0DViLrPwE
	evpO+CUUFevjrLejrglGC8nLdyQ28sFOOfGw0jVi/A==
X-Google-Smtp-Source: AGHT+IHw0G0EIse1yGYFFFpdV5UP4PTKWTtl5We9VjFVy52nNEQTh2JVJULrmuUOEeTTNz4RJCeXyzGziUKOfDUoJLo=
X-Received: by 2002:aa7:c542:0:b0:54c:973e:6783 with SMTP id
 s2-20020aa7c542000000b0054c973e6783mr1565025edr.3.1702075241744; Fri, 08 Dec
 2023 14:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook> <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook> <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
 <202312081302.323CBB189@keescook> <CAHC9VhQ2VxM=WWL_jpoELu=dHuiF3Pk=bxNrpfctc7Q0K2DUfA@mail.gmail.com>
 <202312081352.6587C77@keescook>
In-Reply-To: <202312081352.6587C77@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 8 Dec 2023 23:40:20 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7TbwNOmSeYFANMK86wDx+0yyFgJGM6rp8ZXvQz+pxQrg@mail.gmail.com>
Message-ID: <CACYkzJ7TbwNOmSeYFANMK86wDx+0yyFgJGM6rp8ZXvQz+pxQrg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 11:05=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Dec 08, 2023 at 04:43:57PM -0500, Paul Moore wrote:
> > On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromium.org=
> wrote:
> > > On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > > > Hopefully by repeating the important bits of the conversation you n=
ow
> > > > understand that there is nothing you can do at this moment to speed=
 my
> > > > review of this patchset, but there are things you, and KP, can do i=
n
> > > > the future if additional respins are needed.  However, if you are
> > > > still confused, it may be best to go do something else for a bit an=
d
> > > > then revisit this email because there is nothing more that I can sa=
y
> > > > on this topic at this point in time.
> > >
> > > I moved to the list because off-list discussions (that I got involunt=
arily
> > > CCed into and never replied to at all) tend to be unhelpful as no one=
 else
> > > can share in any context they may provide. And I'm not trying to rush
> > > you; I'm trying to make review easier.
> >
> > From my perspective whatever good intentions you had at the start were
> > completely lost when you asked "What's the right direction forward?"
> > after I had already explained things multiple times *today*.  That's
> > the sort of thing that drives really bothers me.
>
> Okay, I understand now. Sorry for frustrating you! By "way forward",
> I meant I didn't understand how to address what looked like conflicting
> feedback. I think my confusion was over separating the goal ("this
> feature should be automatically enabled when it is known to be useful")
> from an interpretation of earlier feedback as "I don't want a CONFIG [tha=
t
> leaves this up to the user]", when what you really wanted understood was
> "I don't want a CONFIG *ever*, regardless of whether it picks the correct
> setting automatically".
>
> >
> > > While looking at the v8 again I
> > > saw an obvious problem with it, so I commented on it so that it's cle=
ar
> > > to you that it'll need work when you do get around to the review.
> >
> > That's fair.  The Kconfig patch shouldn't have even been part of the
> > v8 patchset as far as I'm concerned, both because I explained I didn't
> > want to merge something like that (and was ignored) and because it
> > doesn't appear to do anything.  From where I sit this was, and
> > remains, equally parts comical and frustrating.


Paul, as I said I will include it in v3 and we can drop it if that's
the consensus.

https://lore.kernel.org/bpf/CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9BAm-rx=
3Gsg@mail.gmail.com/

Following that, I received Acks on the patch, so I kept it. I wasn't
sure if this was going to be perceived as "ignoring your feedback".
Definitely not my intention. I was just giving an option for folks who
wanted to test the patch so that we get the defaults right. I am
totally okay with us dropping the config patch.


>
> Agreed. :) Anyway, when you do review it, I think you can just ignore
> patch 5, and if a v9 isn't needed, a brand new patch for that logic can
> be created later.
>
> --
> Kees Cook

