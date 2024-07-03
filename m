Return-Path: <bpf+bounces-33839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F7926C54
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1871C221F2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38569194A65;
	Wed,  3 Jul 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGlzMnLs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45761836D0
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048113; cv=none; b=JIN8gNYLtDE4+loZwE1LMLD+I2thtx9P9aiYEMPi/mVwp5niSsEkjv6RC2QZRu/rMMcTV8R/UoqPKxcGMyI5528W7+DYH4ntXtSTMkq9PI7/4Kvl+9LDSBiydGTyiRUibrZLtTHejri1462yfD5B8xfjGk5DrnIlRLyDVMEy5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048113; c=relaxed/simple;
	bh=2OMOqfOetSmVlahXw8mHSTHgbxV4dER+5EvCBq83hnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAc0cAUmgikYI4rDhy6+cKi7VzFmWkxYAC1P0820qvqFJyZIyJo2/DUFrS7WBluJUxHYyqIsp0thjfyzVqGsNSf8LqnvP8woHigWofDXqkb5IkwCe8sIXDZX0B2pmduZXAyExozoJsvW89U+XOlF+zHCSE9oZqB2Wv3QqSRvVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGlzMnLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50415C4AF0B
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720048113;
	bh=2OMOqfOetSmVlahXw8mHSTHgbxV4dER+5EvCBq83hnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oGlzMnLs+63jwkZ+lusqszPc88hl5RzQ/TPZhXBDwro3NO4Sm8voeHd2L2fnmxgCI
	 KZLBHBr7vJPKCeAinLfi6tbBpuyg0KDJ3j44C2zMiU4zjXdlQtL9CAakYEjdfQvLcZ
	 BzrVag2JYmRPPBko5AtcdpVkeD5mS8GqKyLXhH4gbw/uDy2aZwNlQd6NYz+xGHquq9
	 c/dIY+Urzht57FaWI2IKp92aytAA2kXF9Tr5yw79Q78TyxNKZydOqdJ236lm5Ad5OW
	 YKVi+7pamruEP6cAgZ0pPyf4ggLYj6dhWQIAvbCcbhKLDAvC2kLdgnOjvKmT994cIi
	 Q9vIi942fozng==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so8983122e87.2
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 16:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlPpfLoZT2SOzh3vOPn2dQ6XcKMzrxwiykmmybuIbB0qmrivMsMJwMXkoIPhIYDHLsztnJI4RdgvCtkk4BR7SQsc3c
X-Gm-Message-State: AOJu0Yzvm3NK9OlLfuBrb+BpqeFMjJFaz33zRQn1gjutZUJGBDi4gOkw
	/WY6IUhYciwFpmwRaM4B2Qg3I0GWZg+1ypoWfgpsxlE+jVA44uVRKHDdh2sqdmC+UNdhl8pYuGI
	ZiIS6Sq//sHv7I+C+cmYCfOYxdMk34d8dPk6p
X-Google-Smtp-Source: AGHT+IGWzttEz+J2RL9fns3/eUhmpms1UQ8pJEdGX+w2EfSjsxosZzxB4GPMd6yfdN2II6DPIY2pD/7a1FPp9VzZTdI=
X-Received: by 2002:a05:6512:e98:b0:52c:6461:e913 with SMTP id
 2adb3069b0e04-52e82661276mr9141990e87.16.1720048111618; Wed, 03 Jul 2024
 16:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
 <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
 <CACYkzJ4kwrsDwD2k5ywn78j7CcvufgJJuZQ4Wpz8upL9pAsuZw@mail.gmail.com> <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 4 Jul 2024 01:08:20 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
Message-ID: <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> > On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > > > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > >
> > > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > > >
> > > > > > LSM hooks are currently invoked from a linked list as indirect =
calls
> > > > > > which are invoked using retpolines as a mitigation for speculat=
ive
> > > > > > attacks (Branch History / Target injection) and add extra overh=
ead which
> > > > > > is especially bad in kernel hot paths:
> > > >
> > > > [...]
> > > >
> > > > > should fix the more obvious problems.  I'd like to know if you ar=
e
> > > > > aware of any others?  If not, the text above should be adjusted a=
nd
> > > > > we should reconsider patch 5/5.  If there are other problems I'd
> > > > > like to better understand them as there may be an independent
> > > > > solution for those particular problems.
> > > >
> > > > We did have problems with some other hooks but I was unable to dig =
up
> > > > specific examples though, it's been a while. More broadly speaking,=
 a
> > > > default decision is still a decision. Whereas the intent from the B=
PF
> > > > LSM is not to make a default decision unless a BPF program is loade=
d.
> > > > I am quite worried about the holes this leaves open, subtle bugs
> > > > (security or crashes) we have not caught yet and PATCH 5/5 engineer=
s away
> > > >  the problem of the "default decision".
> > >
> > > The inode/xattr problem you originally mentioned wasn't really rooted
> > > in a "bad" default return value, it was really an issue with how the
> > > LSM hook was structured due to some legacy design assumptions made
> > > well before the initial stacking patches were merged.  That should be
> > > fixed now[1] and given that the inode/xattr set/remove hooks were
> > > unique in this regard (individual LSMs were responsible for performin=
g
> > > the capabilities checks) I don't expect this to be a general problem.
> > >
> > > There were also some issues caused by the fact that we were defining
> > > the default return value in multiple places and these values had gone
> > > out of sync in a number of hooks.  We've also fixed this problem by
> > > only defining the default return value once for each hook, solving al=
l
> > > of those problems.
> >
> > I don't see how this solves problems or prevents any future problems
> > with side-effects. I have always been uncomfortable with an extraneous
> > function being called with a side effect ever since we merged BPF LSM
> > with default callback. We have found one bug due to this, not all the
> > bugs.
>
> You've got to give me something more concrete than that.  If you can't
> provide any concrete examples, start with providing a basic concept
> with far more detail than just "side-effects".
>
> > > I'm not aware of any other existing problems relating to the LSM hook
> > > default values, if there are any, we need to fix them independent of
> > > this patchset.  The LSM framework should function properly if the
> > > "default" values are used.
> >
> > Patch 5 eliminates the possibilities of errors and subtle bugs all
> > together. The problem with subtle bugs is, well, they are subtle, if
> > you and I knew of the bugs, we would fix all of them, but we don't. I
> > really feel we ought to eliminate the class of issues and not just
> > whack-a-mole when we see the bugs.
>
> Here's the thing, I don't really like patch 5/5.  To be honest, I
> don't really like a lot of this patchset.  From my perspective, the
> complexity of the code is likely going to mean more maintenance
> headaches down the road, but Linus hath spoken so we're doing this
> (although "this" is still a bit undefined as far as I'm concerned).
> If you want me to merge patch 5/5 you've got to give me something real
> and convincing that can't be fixed by any other means.  My current
> opinion is that you're trying to use a previously fixed bug to scare
> and/or coerce the merging of some changes I don't really want to
> merge.  If you want me to take patch 5/5, you've got to give me a
> reason that is far more compelling that what you've written thus far.

Paul, I am not scaring you, I am providing a solution that saves us
from headaches with side-effects and bugs in the future. It's safer by
design.

You say you have not reviewed it carefully, but you did ask me to move
the function from the BPF LSM layer to an LSM API, and we had a bunch
of discussion around naming in the subsequent revisions.

https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.com=
/

My reasons are:

1. It's safer, no side effects, guaranteed to be not buggy. Neither
you, nor me, can guarantee that a default value will be safe in the
LSM layer. I request others (Casey, Kees) for their opinion here too.
2. Performance, no extra function call.

If you still don't like it, it's your call, I would still like to keep
most of the logic local to the BPF LSM as proposed in
https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.com=
/

- KP

>
> --
> paul-moore.com

