Return-Path: <bpf+bounces-17269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7E80B05F
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6331F2142E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D45733C;
	Fri,  8 Dec 2023 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwKDBNO9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42259160
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 23:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E1C43397
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 23:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702076804;
	bh=oTY+DJP0tJwvIvKFVwbjmzNh25OrK4eQS3dc5iHBe4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GwKDBNO9OUxqTRQfV9uzBfSFybdg0ZB4gpgNZhuN/f8Bcyj6zZPz3kXM39qdUeI42
	 59e51PAdeRfyO2rqYRlTNPx8nDocG9yvz4b1acnV2MtX7ECR5DzViuCm2Hep4gzwon
	 4Up46UkHA55nYBZcLJIcP31e0DJmPSfDn8qbbqCzK1NFFMSOdmvleuaEVv6tg0eRU+
	 4iDngJelMSMweD51DRQ312Ne3WabHzA2Xl6F9v6L4JQnzFJUrWY43Bpopchzf6QWfn
	 h10s3VpuxTbW266spVDo421pOyFLXVsssL3xbh4Hc+qox+MvwGuvUcDWne4p/YCQGj
	 LREhUBGkQozVg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so1335616a12.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 15:06:44 -0800 (PST)
X-Gm-Message-State: AOJu0YxO5wi+l4r1FC/Lr40mc+oIDRFwJ/mZXwK7bB3LJoBc0foIuNjj
	ZttpsdW890V2ss0qONEM4MiZscAPytcqeKfutjHlWA==
X-Google-Smtp-Source: AGHT+IFSxeU1bOZOl6ezXsFG3gCl2lALrny8//rTuGa2wCdsO13B9loRU1Bh0K52lX4ZHIw0iXQ7iWiNst0y7+lZUV8=
X-Received: by 2002:a50:c88a:0:b0:54f:48ca:9397 with SMTP id
 d10-20020a50c88a000000b0054f48ca9397mr528642edh.44.1702076802906; Fri, 08 Dec
 2023 15:06:42 -0800 (PST)
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
 <202312081352.6587C77@keescook> <CACYkzJ7TbwNOmSeYFANMK86wDx+0yyFgJGM6rp8ZXvQz+pxQrg@mail.gmail.com>
 <CAHC9VhQPc4k9iAXuifsWzAdkrWghyUh9NF6P0-oSD=5ZccpaLA@mail.gmail.com>
In-Reply-To: <CAHC9VhQPc4k9iAXuifsWzAdkrWghyUh9NF6P0-oSD=5ZccpaLA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 9 Dec 2023 00:06:32 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5TaTXMKfadqcmXDwd6-EbexLAQsRHR-3buKN8GLPrNxw@mail.gmail.com>
Message-ID: <CACYkzJ5TaTXMKfadqcmXDwd6-EbexLAQsRHR-3buKN8GLPrNxw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 11:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Dec 8, 2023 at 5:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Fri, Dec 8, 2023 at 11:05=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > > On Fri, Dec 08, 2023 at 04:43:57PM -0500, Paul Moore wrote:
> > > > On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> > > > > On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > > > > > Hopefully by repeating the important bits of the conversation y=
ou now
> > > > > > understand that there is nothing you can do at this moment to s=
peed my
> > > > > > review of this patchset, but there are things you, and KP, can =
do in
> > > > > > the future if additional respins are needed.  However, if you a=
re
> > > > > > still confused, it may be best to go do something else for a bi=
t and
> > > > > > then revisit this email because there is nothing more that I ca=
n say
> > > > > > on this topic at this point in time.
> > > > >
> > > > > I moved to the list because off-list discussions (that I got invo=
luntarily
> > > > > CCed into and never replied to at all) tend to be unhelpful as no=
 one else
> > > > > can share in any context they may provide. And I'm not trying to =
rush
> > > > > you; I'm trying to make review easier.
> > > >
> > > > From my perspective whatever good intentions you had at the start w=
ere
> > > > completely lost when you asked "What's the right direction forward?=
"
> > > > after I had already explained things multiple times *today*.  That'=
s
> > > > the sort of thing that drives really bothers me.
> > >
> > > Okay, I understand now. Sorry for frustrating you! By "way forward",
> > > I meant I didn't understand how to address what looked like conflicti=
ng
> > > feedback. I think my confusion was over separating the goal ("this
> > > feature should be automatically enabled when it is known to be useful=
")
> > > from an interpretation of earlier feedback as "I don't want a CONFIG =
[that
> > > leaves this up to the user]", when what you really wanted understood =
was
> > > "I don't want a CONFIG *ever*, regardless of whether it picks the cor=
rect
> > > setting automatically".
> > >
> > > >
> > > > > While looking at the v8 again I
> > > > > saw an obvious problem with it, so I commented on it so that it's=
 clear
> > > > > to you that it'll need work when you do get around to the review.
> > > >
> > > > That's fair.  The Kconfig patch shouldn't have even been part of th=
e
> > > > v8 patchset as far as I'm concerned, both because I explained I did=
n't
> > > > want to merge something like that (and was ignored) and because it
> > > > doesn't appear to do anything.  From where I sit this was, and
> > > > remains, equally parts comical and frustrating.
> >
> >
> > Paul, as I said I will include it in v3 and we can drop it if that's
> > the consensus.
> >
> > https://lore.kernel.org/bpf/CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9BA=
m-rx3Gsg@mail.gmail.com/
> >
> > Following that, I received Acks on the patch, so I kept it. I wasn't
> > sure if this was going to be perceived as "ignoring your feedback".
> > Definitely not my intention. I was just giving an option for folks who
> > wanted to test the patch so that we get the defaults right. I am
> > totally okay with us dropping the config patch.
>
> <heavy sarcasm>I'm glad you're okay with dropping a patch I said I
> wasn't going to merge three months ago.  I'm also glad you're okay
> with dropping a patch that does absolutely nothing.</heavy sarcasm>

The patch does something (it's in the patch description). But it's
something that you don't think is worth tweaking and that's fine.

>
> Come on KP, you're better than this.  Continuing to carry a patch that
> I've said I'm not going to merge only creates confusion about what
> will be accepted/supported (see today's exchange as a perfect
> example).  There is no need to keep the patch going "for reference",

Okay, I won't. I honestly did not think this was that big a deal and
would bother you so much and, please do assume good intent, I did not
want to create confusion here.

- KP

> to record ACKs, or anything similar to that; all the reviews, ACKs,
> etc. happened on a public list so we have that covered from a
> historical perspective.
>
> I suppose there is a worthy offshoot discussion about consensus and
> maintainer discretion, but I'm too tired and annoyed to give that
> discussion the attention it deserves, so let's just say that when I
> say stuff like I did back in the v2 patchset that should be taken as a
> "regardless of what consensus there may be, I'm not going to merge
> this patch."
>
> --
> paul-moore.com

