Return-Path: <bpf+bounces-33846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F744926CBD
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830351C222A5
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9A4437;
	Thu,  4 Jul 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFYGZotB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBF4C70
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052657; cv=none; b=qPwlIxicqVx2vjkheDupDAGLhzwTxrHqJAJjV+kyWV6GLllxHbs/weGATywvHoJKuT1sTRhhUEbhx223bIIUKd+nM3FnSdmXipsoYih/oRZeGb7wE+3whZV1H6jaK+909LiMiIzH9oVPYNlu9vDvGQcSxjcMO4TJFwrcZi89iHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052657; c=relaxed/simple;
	bh=f/uoUa+qo5ejd4/tahRq4sFpvq8hqYRsh39XEfDxKDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5Sbfd1sA/cfO1SrhvosrfYiVYEMI0WTMs7+/zKoh6Ag1xxax+PQXO6q4Ig2MVeQpJPNIwincpqOzZ6dcmC7dvJONuxt/AWygCtHsnWPiUO9gbU5pdDUwLNmvTgsW4q4odO5wJoBBPlAz32K3BNZOdjZMZ8pLfsWm4It2kdsb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFYGZotB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76096C4AF0D
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720052657;
	bh=f/uoUa+qo5ejd4/tahRq4sFpvq8hqYRsh39XEfDxKDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VFYGZotBwabQRrYwP/5jyF7/CRvBQnW+tuzulOb3WFmfNMIBhQRSJVQNKQmFOz5Mw
	 8/5YZv7s+0+7b7+MMAba4YZfrqQHMzbEV5ANsRA7o7jZF0UCh5q4k71P6OotXB6D3L
	 9qCKqneIDWrLiCHZu/gEoUVym/bxUPmzcbkHwCzqFJwHOBs1vYeBszAduVTVSD2pVX
	 hLFcVXCZk3Pu9pzFYdw6VTZ70fkWiScnfyPmZ1mvv86ft9U2h+0Su0j9boeTKQ5H8g
	 o6gRSLtEEBtvB/AWAuV/EQnx9NP2e97vGGTT0u1re37X22362LeLfE0q1egzn6tQJR
	 LHorX2T2cxPaw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so53684a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 17:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEAz144+ghmEo2Ejz3GuyuypAFUXwsjyTpGGLc9d7tGnsPZc+3KdE8y3BclDk01KlbJdNosFwEgcCPZ54Xi7uVw8uY
X-Gm-Message-State: AOJu0YzwXp41JNP2s79oZYfUmSb78ZaxebeuuuF28ypCubzVWT9nUIKp
	gL1gEBGp6x5FM+xKCPOQo9vjjeXVTywdFqo4UNhxCZ8RnaUdp0w8Ijz+L6nJzqPba8ZD8goSw3W
	ZodTZPTDoB7LQ4aAII53u09BOswrsWi4xU8wF
X-Google-Smtp-Source: AGHT+IHb+12767QM2TBBkzdQYl1Za9EQOKMSct+D2QLA1LcpcnZZ5664sW5DbGE7mIIO/bNvceY5UHeC8HJgwsZ/as8=
X-Received: by 2002:a05:6402:17c4:b0:585:3a33:9de0 with SMTP id
 4fb4d7f45d1cf-58e5aecb62cmr44813a12.26.1720052655917; Wed, 03 Jul 2024
 17:24:15 -0700 (PDT)
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
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com> <90baed2b-b775-4eb7-9024-c15e65d8aee3@schaufler-ca.com>
In-Reply-To: <90baed2b-b775-4eb7-9024-c15e65d8aee3@schaufler-ca.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 4 Jul 2024 02:24:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4R9mE+4-fYWb6UwVr9x3jw2PFp4Axt6ot1iWKngRv55A@mail.gmail.com>
Message-ID: <CACYkzJ4R9mE+4-fYWb6UwVr9x3jw2PFp4Axt6ot1iWKngRv55A@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:04=E2=80=AFAM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 7/3/2024 4:08 PM, KP Singh wrote:
> > On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> >>> On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>> On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
> >>>>> On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> >>>>>> On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >>>>>>> LSM hooks are currently invoked from a linked list as indirect ca=
lls
> >>>>>>> which are invoked using retpolines as a mitigation for speculativ=
e
> >>>>>>> attacks (Branch History / Target injection) and add extra overhea=
d which
> >>>>>>> is especially bad in kernel hot paths:
> >>>>> [...]
> >>>>>
> >>>>>> should fix the more obvious problems.  I'd like to know if you are
> >>>>>> aware of any others?  If not, the text above should be adjusted an=
d
> >>>>>> we should reconsider patch 5/5.  If there are other problems I'd
> >>>>>> like to better understand them as there may be an independent
> >>>>>> solution for those particular problems.
> >>>>> We did have problems with some other hooks but I was unable to dig =
up
> >>>>> specific examples though, it's been a while. More broadly speaking,=
 a
> >>>>> default decision is still a decision. Whereas the intent from the B=
PF
> >>>>> LSM is not to make a default decision unless a BPF program is loade=
d.
> >>>>> I am quite worried about the holes this leaves open, subtle bugs
> >>>>> (security or crashes) we have not caught yet and PATCH 5/5 engineer=
s away
> >>>>>  the problem of the "default decision".
> >>>> The inode/xattr problem you originally mentioned wasn't really roote=
d
> >>>> in a "bad" default return value, it was really an issue with how the
> >>>> LSM hook was structured due to some legacy design assumptions made
> >>>> well before the initial stacking patches were merged.  That should b=
e
> >>>> fixed now[1] and given that the inode/xattr set/remove hooks were
> >>>> unique in this regard (individual LSMs were responsible for performi=
ng
> >>>> the capabilities checks) I don't expect this to be a general problem=
.
> >>>>
> >>>> There were also some issues caused by the fact that we were defining
> >>>> the default return value in multiple places and these values had gon=
e
> >>>> out of sync in a number of hooks.  We've also fixed this problem by
> >>>> only defining the default return value once for each hook, solving a=
ll
> >>>> of those problems.
> >>> I don't see how this solves problems or prevents any future problems
> >>> with side-effects. I have always been uncomfortable with an extraneou=
s
> >>> function being called with a side effect ever since we merged BPF LSM
> >>> with default callback. We have found one bug due to this, not all the
> >>> bugs.
> >> You've got to give me something more concrete than that.  If you can't
> >> provide any concrete examples, start with providing a basic concept
> >> with far more detail than just "side-effects".
> >>
> >>>> I'm not aware of any other existing problems relating to the LSM hoo=
k
> >>>> default values, if there are any, we need to fix them independent of
> >>>> this patchset.  The LSM framework should function properly if the
> >>>> "default" values are used.
> >>> Patch 5 eliminates the possibilities of errors and subtle bugs all
> >>> together. The problem with subtle bugs is, well, they are subtle, if
> >>> you and I knew of the bugs, we would fix all of them, but we don't. I
> >>> really feel we ought to eliminate the class of issues and not just
> >>> whack-a-mole when we see the bugs.
> >> Here's the thing, I don't really like patch 5/5.  To be honest, I
> >> don't really like a lot of this patchset.  From my perspective, the
> >> complexity of the code is likely going to mean more maintenance
> >> headaches down the road, but Linus hath spoken so we're doing this
> >> (although "this" is still a bit undefined as far as I'm concerned).
> >> If you want me to merge patch 5/5 you've got to give me something real
> >> and convincing that can't be fixed by any other means.  My current
> >> opinion is that you're trying to use a previously fixed bug to scare
> >> and/or coerce the merging of some changes I don't really want to
> >> merge.  If you want me to take patch 5/5, you've got to give me a
> >> reason that is far more compelling that what you've written thus far.
> > Paul, I am not scaring you, I am providing a solution that saves us
> > from headaches with side-effects and bugs in the future. It's safer by
> > design.
> >
> > You say you have not reviewed it carefully, but you did ask me to move
> > the function from the BPF LSM layer to an LSM API, and we had a bunch
> > of discussion around naming in the subsequent revisions.
> >
> > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore=
.com/
> >
> > My reasons are:
> >
> > 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> > you, nor me, can guarantee that a default value will be safe in the
> > LSM layer. I request others (Casey, Kees) for their opinion here too.
> > 2. Performance, no extra function call.
>
> I want to be very careful about the comments I make on this patch set.
> I can't say that I trust any fix for the BPF LSM layer. My natural
> inclination is to isolate the fix to the area that has the problem,
> that is, BPF. I have a hard time accepting the notion that the implementa=
tion
> will really fix all possible bugs in the future. The pace at which eBPF
> is evolving gives me the heebee geebees when I think of it as a mechanism
> for implementing security modules.
>
> My biggest concern is that we may be trying too hard for perfection.
> I see a situation where we're not moving forward because there are two
> reasonable solutions and rather than running with either we're desperatel=
y
> looking for a compelling reason to pick one over the other.

I am fine with either, if you folks prefer security_toggle_hook to be
in BPF only / limited to BPF. I can revert back to what we had in v9,
the changes to the LSM layer are then very minimal.

- KP

>
> >
> > If you still don't like it, it's your call, I would still like to keep
> > most of the logic local to the BPF LSM as proposed in
> > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore=
.com/
> >
> > - KP
> >
> >> --
> >> paul-moore.com

