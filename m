Return-Path: <bpf+bounces-17274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42BF80B092
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543C21F2139A
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169D5ABAB;
	Fri,  8 Dec 2023 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Brkh3f+S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941A1720
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 15:28:04 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso2959599276.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702078084; x=1702682884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFuACjQl1hcwplPr8cKbq94/IvpQ2wdBnShKIuIIGdo=;
        b=Brkh3f+S837+e+9N021C1giyslzOBmZn0fMtXGGaaMGYr1OvjNiTs8SGbXgoNzXMiZ
         GMgmC/dOCgAH0bzzQFHFrhv90V44EDl5ICbSfoYitMPI15Tf1OfdEOc7pyahnkX9DSZC
         0VV95Xexqfde6lfbvXoCJeiU0OZBCwiyzevNsz9fUtqcSVlAW/HQ8pYBBvWRLUd2ejpi
         7uBq3uu89SnNpYPgoyfTNEIJX7TJtvxwtsOd8PDtEbgN731BxXfvyhJxE0XE5IcpTBpA
         URw7r23WYoLOvj0RghNm2PoVazQ3DViipVudRPc1ySr5i8wfrWzTnKIqwP1FjRCoR/Nz
         6oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078084; x=1702682884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFuACjQl1hcwplPr8cKbq94/IvpQ2wdBnShKIuIIGdo=;
        b=s/LXIpewgCpXLdFZatEPFl/mBc0Px1eS/jEZ6ew00btlVhbPNwS0A6L+tLrWGc87Ck
         /lz0K2mGXUb5dfYbU1JWVhIji8p0mzPOtlQfJTeY7knYTvOA2a5bfAtGL21X1kmumBK/
         Trz9IJ2Xk2a40wdiN9wQ43gkt1MOSE0eC8b4xm5iL1Ea8WxJi5Au5FFgRu8S4lndPsUH
         QzXVPtwzGv6I7RwkB5VRVYP78FEzGPxq/IXK7WhPAEcZ/nvwfgl8a8Lo7XZ48tl1Ii9b
         9/nJc+mQw9fA0AKtTs3U6FZ/XKiXis2jcmIonGOD5iSH2pEy0PxQetmQJPM3oN8w3UDa
         mNOA==
X-Gm-Message-State: AOJu0Yy8aGPQSsny6Jzc4lIwYWMPcY3PBL+lnatmSCDcQ2TXQDcgUBhn
	JHP7gzwtS4owSuLV1lkb+L1GS/S3hVS+m3H9j898
X-Google-Smtp-Source: AGHT+IGOrf2bAf1uilqGwZx9oJnrTo5PSMMq3fMnfkKwvF/+RSbHeq73+Wt/Eyveg1DeFc8tXAi2EwYbWJKEfd5gw+c=
X-Received: by 2002:a25:8a0a:0:b0:db7:dacf:ed87 with SMTP id
 g10-20020a258a0a000000b00db7dacfed87mr602524ybl.104.1702078083930; Fri, 08
 Dec 2023 15:28:03 -0800 (PST)
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
 <CAHC9VhQPc4k9iAXuifsWzAdkrWghyUh9NF6P0-oSD=5ZccpaLA@mail.gmail.com> <CACYkzJ5TaTXMKfadqcmXDwd6-EbexLAQsRHR-3buKN8GLPrNxw@mail.gmail.com>
In-Reply-To: <CACYkzJ5TaTXMKfadqcmXDwd6-EbexLAQsRHR-3buKN8GLPrNxw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 18:27:53 -0500
Message-ID: <CAHC9VhRFSXoQSr9H04wcOmCs-jJOwW13hjiPWuUcNvb_BB-R+A@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:06=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Fri, Dec 8, 2023 at 11:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Dec 8, 2023 at 5:40=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Fri, Dec 8, 2023 at 11:05=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > > On Fri, Dec 08, 2023 at 04:43:57PM -0500, Paul Moore wrote:
> > > > > On Fri, Dec 8, 2023 at 4:13=E2=80=AFPM Kees Cook <keescook@chromi=
um.org> wrote:
> > > > > > On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> > > > > > > Hopefully by repeating the important bits of the conversation=
 you now
> > > > > > > understand that there is nothing you can do at this moment to=
 speed my
> > > > > > > review of this patchset, but there are things you, and KP, ca=
n do in
> > > > > > > the future if additional respins are needed.  However, if you=
 are
> > > > > > > still confused, it may be best to go do something else for a =
bit and
> > > > > > > then revisit this email because there is nothing more that I =
can say
> > > > > > > on this topic at this point in time.
> > > > > >
> > > > > > I moved to the list because off-list discussions (that I got in=
voluntarily
> > > > > > CCed into and never replied to at all) tend to be unhelpful as =
no one else
> > > > > > can share in any context they may provide. And I'm not trying t=
o rush
> > > > > > you; I'm trying to make review easier.
> > > > >
> > > > > From my perspective whatever good intentions you had at the start=
 were
> > > > > completely lost when you asked "What's the right direction forwar=
d?"
> > > > > after I had already explained things multiple times *today*.  Tha=
t's
> > > > > the sort of thing that drives really bothers me.
> > > >
> > > > Okay, I understand now. Sorry for frustrating you! By "way forward"=
,
> > > > I meant I didn't understand how to address what looked like conflic=
ting
> > > > feedback. I think my confusion was over separating the goal ("this
> > > > feature should be automatically enabled when it is known to be usef=
ul")
> > > > from an interpretation of earlier feedback as "I don't want a CONFI=
G [that
> > > > leaves this up to the user]", when what you really wanted understoo=
d was
> > > > "I don't want a CONFIG *ever*, regardless of whether it picks the c=
orrect
> > > > setting automatically".
> > > >
> > > > >
> > > > > > While looking at the v8 again I
> > > > > > saw an obvious problem with it, so I commented on it so that it=
's clear
> > > > > > to you that it'll need work when you do get around to the revie=
w.
> > > > >
> > > > > That's fair.  The Kconfig patch shouldn't have even been part of =
the
> > > > > v8 patchset as far as I'm concerned, both because I explained I d=
idn't
> > > > > want to merge something like that (and was ignored) and because i=
t
> > > > > doesn't appear to do anything.  From where I sit this was, and
> > > > > remains, equally parts comical and frustrating.
> > >
> > >
> > > Paul, as I said I will include it in v3 and we can drop it if that's
> > > the consensus.
> > >
> > > https://lore.kernel.org/bpf/CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9=
BAm-rx3Gsg@mail.gmail.com/
> > >
> > > Following that, I received Acks on the patch, so I kept it. I wasn't
> > > sure if this was going to be perceived as "ignoring your feedback".
> > > Definitely not my intention. I was just giving an option for folks wh=
o
> > > wanted to test the patch so that we get the defaults right. I am
> > > totally okay with us dropping the config patch.
> >
> > <heavy sarcasm>I'm glad you're okay with dropping a patch I said I
> > wasn't going to merge three months ago.  I'm also glad you're okay
> > with dropping a patch that does absolutely nothing.</heavy sarcasm>
>
> The patch does something (it's in the patch description). But it's
> something that you don't think is worth tweaking and that's fine.
>
> > Come on KP, you're better than this.  Continuing to carry a patch that
> > I've said I'm not going to merge only creates confusion about what
> > will be accepted/supported (see today's exchange as a perfect
> > example).  There is no need to keep the patch going "for reference",
>
> Okay, I won't. I honestly did not think this was that big a deal and
> would bother you so much and, please do assume good intent, I did not
> want to create confusion here.

The patch itself isn't the problem, it's at the end of the patchset
and easily dropped.  The problem is that you pinged me off-list to try
and get me to move your patchset up the review queue, which isn't
something I appreciate, especially when the feedback I provided
previously was not acted upon ... and yes, I've heard your arguments
about why you continued to carry the patch, but please understand when
I explicitly say "no thank you" to a patch, I want you to drop that
patch; "no thank you" shouldn't be ambiguous.

To summarize:
1. Don't ping me off-list to review patchsets.  I personally find that
incredibly annoying and it guarantees that the patchset gets pushed to
the end of the list (spiteful? sure, but it helps soothe the jagged
nerves of this haggard maintainer).
2. Take maintainer feedback seriously.  If you ignore feedback,
providing a proper review tends to be a waste of time; there are
plenty of other patchsets with authors who are receptive to comments.

Anyway, go enjoy your weekend and just do better next time.  What's
done is done.

--=20
paul-moore.com

