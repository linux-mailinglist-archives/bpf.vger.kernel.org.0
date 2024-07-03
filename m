Return-Path: <bpf+bounces-33825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC5926B78
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB921F23788
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4101619409E;
	Wed,  3 Jul 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDqka1DD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA12136643
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045375; cv=none; b=OuusEGxhJYTajNs+KnIJt1flB+MU3vfOe0IDtud9PFs2+o6nPrxSYZGtdGfXLTuUplZgn6K+JlGMldGSP8fU9rdCwml55HLeKg8Crx4pD8bC7mz0j465j57flKsDrimIwakVpyGoH/396ktgPe+Fsk8AcYn+OyswSDLVMoZNCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045375; c=relaxed/simple;
	bh=Pknlh239cKWhhvyp7caV3a3RTyq1add85b+Okr37Ca8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS5RdpExeyWCwL2Z6saFLVlrTiY4lYzDEfui4W7Dh3KKAfzoHp2FotZNGMr7H4UvGrUSqAV2sVhZBorgYkYZWDElQ32D2FZfkApPVwuITV/jSFJQBGF3+oHxvpTlzlzQEydJeOK5v3G9ghSlAO3Kc5y0G2En+NUIS0hc574aSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDqka1DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE1C4AF0C
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045375;
	bh=Pknlh239cKWhhvyp7caV3a3RTyq1add85b+Okr37Ca8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDqka1DDpoiAE7zDd0uEJQ9PAjM0lnyYuOl5KY5m4VlHXywpANW/dh5F5Q+cJiG7Q
	 JtH39ZyV8n4sojOxeRaXv+62ovI1vxVEKLzZh57DuSAuJ8JeYPVtuzITqAm5CJm66V
	 s/CGFx/9JjkhBvliqadMhs5Lx3Wxj+lw9HI++qxHcKGLf9ogNTk5KAuBXCFd+3nd2p
	 RGCKvgop8YXa6Qzp3avS5VKAgjJLz9gTKT3XZtf+DHC5z+87XH/FhIFAeQV72NEE5Y
	 ESGji1ISypbnij+bk2/3xvZ6wazVGBw+v81ZNlHRYdTqOGfq0TUA/4NuBprRylqG4O
	 lyCyml5nuJNiw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso4366401a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 15:22:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6VNPnao5ktYtFYw1SOlvtjN8IrhWIsshYqfYlMeaRD70NTXJLgkHtEKo6YpAWivfODvpBiZKxSOJhO8Fm6zhMlP52
X-Gm-Message-State: AOJu0YyWJ8vsx873HXyMkRYwZ29ozVQAbZ1ryHyW52rlzVN8qHLjEprH
	EOYiU00fKBZdI1ckj3UR8mmum2p1nGmE5FfZKH2bk9UsEPy9tmtR+tl/wGn7vVAorIksBSdqE8s
	lPqye43/ujC9nANYMPjoJ2asKyJGHLr0dLKWY
X-Google-Smtp-Source: AGHT+IEHWpPHEUqRs/J6w5z8j+hazXuFXKD7mojNIT7monYyELk63gnzNUp4V+3SuHiFxGjElmh5GNdDD0kfas9Fttg=
X-Received: by 2002:a05:6402:40d4:b0:58b:e89:b0c8 with SMTP id
 4fb4d7f45d1cf-58b0e89b393mr3775054a12.36.1720045373910; Wed, 03 Jul 2024
 15:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com> <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 4 Jul 2024 00:22:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
Message-ID: <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > LSM hooks are currently invoked from a linked list as indirect call=
s
> > > > which are invoked using retpolines as a mitigation for speculative
> > > > attacks (Branch History / Target injection) and add extra overhead =
which
> > > > is especially bad in kernel hot paths:
> >
> > [...]
> >
> > > should fix the more obvious problems.  I'd like to know if you are
> > > aware of any others?  If not, the text above should be adjusted and
> > > we should reconsider patch 5/5.  If there are other problems I'd
> > > like to better understand them as there may be an independent
> > > solution for those particular problems.
> >
> > We did have problems with some other hooks but I was unable to dig up
> > specific examples though, it's been a while. More broadly speaking, a
> > default decision is still a decision. Whereas the intent from the BPF
> > LSM is not to make a default decision unless a BPF program is loaded.
> > I am quite worried about the holes this leaves open, subtle bugs
> > (security or crashes) we have not caught yet and PATCH 5/5 engineers aw=
ay
> >  the problem of the "default decision".
>
> The inode/xattr problem you originally mentioned wasn't really rooted
> in a "bad" default return value, it was really an issue with how the
> LSM hook was structured due to some legacy design assumptions made
> well before the initial stacking patches were merged.  That should be
> fixed now[1] and given that the inode/xattr set/remove hooks were
> unique in this regard (individual LSMs were responsible for performing
> the capabilities checks) I don't expect this to be a general problem.
>
> There were also some issues caused by the fact that we were defining
> the default return value in multiple places and these values had gone
> out of sync in a number of hooks.  We've also fixed this problem by
> only defining the default return value once for each hook, solving all
> of those problems.

I don't see how this solves problems or prevents any future problems
with side-effects. I have always been uncomfortable with an extraneous
function being called with a side effect ever since we merged BPF LSM
with default callback. We have found one bug due to this, not all the
bugs.

>
> I'm not aware of any other existing problems relating to the LSM hook
> default values, if there are any, we need to fix them independent of
> this patchset.  The LSM framework should function properly if the
> "default" values are used.

Patch 5 eliminates the possibilities of errors and subtle bugs all
together. The problem with subtle bugs is, well, they are subtle, if
you and I knew of the bugs, we would fix all of them, but we don't. I
really feel we ought to eliminate the class of issues and not just
whack-a-mole when we see the bugs.

The LSM framework ought to function with default values is a nice
goal, but a weaker position than what we have where we make these
subtle bugs impossible. If you feel this should not be a part of the
framework, I would still like to revert back to implementation where
we kept the toggling logic contained to the BPF LSM.

- KP

>
> [1] I just realized that commit 61df7b828204 doesn't properly update
> the removexattr implementations for SELinux and Smack, expect a patch
> for that soon.  The current code is okay, it just does some
> unnecessary work (see the setxattr changes to get an idea of the
> changes needed).
>
> > > > +#define lsm_for_each_hook(scall, NAME)                            =
           \
> > > > +     for (scall =3D static_calls_table.NAME;                      =
     \
> > > > +          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++=
)  \
> > > > +             if (static_key_enabled(&scall->active->key))
> > >
> > > This is probably a stupid question, but why use static_key_enabled()
> > > here instead of static_branch_unlikely() as in the call_XXX_macros?
> >
> > The static_key_enabled is a check for the key being enabled, whereas
> > the static_branch_likely is for laying out the right assembly code
> > (jump tables etc.) and based on the value of the static key, here we
> > are not using the static calls or even keys, rather we are following
> > back from direct calls to indirect calls and don't really need any
> > jump tables in the slow path.
>
> Gotcha, thanks for the explanation.
>
> --
> paul-moore.com

