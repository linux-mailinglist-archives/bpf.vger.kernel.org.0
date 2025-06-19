Return-Path: <bpf+bounces-61115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957FAE0D36
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD75A3BBC45
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B22441AA;
	Thu, 19 Jun 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NhSECbXD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2C1D5AB7
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359371; cv=none; b=ZSsMWGlnSoyhcASPbMsIfLAR0azTMpgTI6UXBQa7VoQyoifyhxjn90S18v/8qmrrzQ6+2mqMkJLVXpk/hYV/4JgD+QhJEqzoeUo1LPn81xiEcic/gJXwAgZXTrjbmV2oJmvs8h3zn14vN9qXAowVudv1oFiwbvkQLJSKBk4rJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359371; c=relaxed/simple;
	bh=jTwfMNgiDqIRJOksWYTy5jCF9CPb5zihZBKzIWwSFm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4SvOZioOuOvdE911P4qE/KFsLFA10bvt9/+SuIjSGW45ygnqSB7b0GznKwSF67wtwPFaUNK7e3sPobphMYcQ4wf7oEOY6ed+QM7ia2brte0O6+7KmTrbBelGXodcsxEf0/L75scYULCh1g+ZBm7NMn0qwf5hSH8lxbMV8iq6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NhSECbXD; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8276224c65so1238790276.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750359368; x=1750964168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwc/J2z7K8Oc3tRBm2Nezvg/uque+UdAnRf1u/K/WLw=;
        b=NhSECbXDk7EohYFokjry8rDIOWcIiyUyTMwZEtVshs6Ah7fhlxc70zNncCAjkpe9oi
         hvTE733+H/fjrOOWPCoAjzOxXg2BGGfAlhZNkDYLzu912v7CvBCX8NALxed2u1+kWyjX
         FViOgF/e0xbcnCbSnuGgr0UqBJADSQ7LUr8DQpBbL+JRgm/EMmiT6cYUEy2YVCK+c8T2
         725D31AEdfUmU5n4ura03tAtyIg7t05R8nnaPpXrmSTQkBHqbbmYCSgfwP/bU7fNt1qt
         snde2yweaMOQKq7sJFzDfUeTKXCui7hi5rn3zzOH2f+aGOaTbq5Y9b7XJNuylY88ROay
         iYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359368; x=1750964168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwc/J2z7K8Oc3tRBm2Nezvg/uque+UdAnRf1u/K/WLw=;
        b=J2SNsApsc4Gt1QH4byLXeGLObL5QDsDLqOzk325vRBbMHb5GqBReIbNCPfpxJfaX7r
         aKFYM9Afyy1qw3l76jKeCukvMK333iuVcVit7rzT/66JYzJXBj5QRnyIIOjLzfZhAEXb
         9enKYQM+C5r6zEUNx+EWEwHeUkoaDOjqkAmnJaTckSq7dcNOz6hHVxIQ3p32rOU3nF+C
         s5KBwE+5/UIajlkxu2lQ4VSFexHIF5ihjmZ+3gvqyLFKTYv3r4dSllCpQlzYVYZU2s4/
         Km1VUstgDsvv9Z1GRYfkAfzMM6ZmdhbXRL1Z/nx2qAclpRWopydeyP72yvYZjk+CacwP
         NdKA==
X-Forwarded-Encrypted: i=1; AJvYcCUfwDoHUsxhYT4aH7hbPyz47pNcLn8une1i9BLB32M5WRvvqa2mjGWqYvkLyRkaK9xcA18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyOSTGz8z7+KPMy0wf4oP7MBwwehvfCOgklTv5l79Te4FPiDO
	hPvo24fHgh6SxzA492+TD/YvlDjunLbbYpkplmrq5qN3CdZRb65DxhW0ZT4pvCq+tKJo4pc4oiK
	+CTxL8DtGdy2fGwv2DQ/UwEsom2mnUBAUUl+LsEKw
X-Gm-Gg: ASbGncv0tIUKLuKtEtlDk/Aqp8P7UAEbNkqGF/2PE8hvtMpUB6vw39brve1NQWXrzfx
	2IV342bAlNHZ17XYg1u5g+fVygFTgHnDJH0rpUUbrWRp+/t1a9lpHBMCLxR8Hk2NlQc3ys0XjaJ
	uNCKs/R3s5hvvNi2Ek+MkBODmtcgIsfd+o4mHjxozd0Bo=
X-Google-Smtp-Source: AGHT+IH067L4bejA4TI2O2DetkqX3aZTCVzDlFULZgdP7Lam4wsYXB5eU0tsHYelUE6XF/5qHsQm4PXzb1LotTfJpvY=
X-Received: by 2002:a05:6902:260e:b0:e84:d34:f35c with SMTP id
 3f1490d57ef6-e842bd0763emr454620276.34.1750359368469; Thu, 19 Jun 2025
 11:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRWi5QdRgU-Eko4XZ9A2W2o3uhVAagVkhu1eT18qAWdkg@mail.gmail.com>
 <20250619040127.1122427-1-kuni1840@gmail.com>
In-Reply-To: <20250619040127.1122427-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Jun 2025 14:55:57 -0400
X-Gm-Features: Ac12FXydpMmxk0hVfZce2Xoy08sDvTtPT8UVGVKruYSutx9qMXgs89MIxsZJvtk
Message-ID: <CAHC9VhSDYwekbzzZB3LwQG=hVVX0-wfFg0i2n2Y_MuyAtv7OWA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter
 SCM_RIGHTS at sendmsg().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	casey@schaufler-ca.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	gnoack@google.com, haoluo@google.com, jmorris@namei.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mic@digikod.net, 
	netdev@vger.kernel.org, omosnace@redhat.com, sdf@fomichev.me, 
	selinux@vger.kernel.org, serge@hallyn.com, song@kernel.org, 
	stephen.smalley.work@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 12:01=E2=80=AFAM Kuniyuki Iwashima <kuni1840@gmail.=
com> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Wed, 18 Jun 2025 23:23:31 -0400
> > On Sat, Jun 14, 2025 at 4:40=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gma=
il.com> wrote:
> > > From: Paul Moore <paul@paul-moore.com>
> > > Date: Sat, 14 Jun 2025 07:43:46 -0400
> > > > On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> =
wrote:
> > > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > >
> > > > > Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> > > > > we can disable SCM_RIGHTS per socket, but it's not flexible.
> > > > >
> > > > > This series allows us to implement more fine-grained filtering fo=
r
> > > > > SCM_RIGHTS with BPF LSM.
> > > >
> > > > My ability to review this over the weekend is limited due to device=
 and
> > > > network access, but I'll take a look next week.
> > > >
> > > > That said, it would be good if you could clarify the "filtering" as=
pect of
> > > > your comments; it may be obvious when I'm able to look at the full =
patchset
> > >
> > > I meant to mention that just below the quoted part :)
> > >
> > > ---8<---
> > > Changes:
> > >   v2: Remove SCM_RIGHTS fd scrubbing functionality
> > > ---8<---
> >
> > Thanks :)
> >
> > While looking at your patches tonight, I was wondering if you had ever
> > considered adding a new LSM hook to __scm_send() that specifically
> > targets SCM_RIGHTS?  I was thinking of something like this:
> >
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index 0225bd94170f..5fec8abc99f5 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -173,6 +173,9 @@ int __scm_send(struct socket *sock, struct msghdr *=
msg, stru
> > ct scm_cookie *p)
> >                case SCM_RIGHTS:
> >                        if (!ops || ops->family !=3D PF_UNIX)
> >                                goto error;
> > +                       err =3D security_sock_scm_rights(sock);
> > +                       if (err<0)
> > +                               goto error;
> >                        err=3Dscm_fp_copy(cmsg, &p->fp);
> >                        if (err<0)
> >                                goto error;
> >
> > ... if I'm correct in my understanding of what you are trying to
> > accomplish, I believe this should allow you to meet your goals with a
> > much simpler and targeted approach.  Or am I thinking about this
> > wrong?
>
> As BPF LSM is just a hook point and not tied to a specific socket,
> we cannot know who will receive the message in __scm_send().

Okay, based on your patches, I'm assuming you're okay with just the
socket endpoint, yes? Unfortunately, it's not really possible to get
the receiving task on the send side.

Beyond that, and given the immediate goal of access control based on
SCM_RIGHTS files, I think I'd rather see a unix_skb_parms passed to
the LSM instead of a skb as it will make the individual LSM subsystem
code a bit cleaner.  I'd prefer a scm_cookie, but given the
destructive nature of unix_scm_to_skb() and the fact that it is called
before we've determined the socket endpoint (at least in the datagram
case), I don't think that will work.

I'm also not overly excited about converting security_unix_may_send()
into a per-msg/skb hook for both stream and datagram sends, that has
the potential for increasing the overhead for LSMs that really only
care about the datagram sends and the establishment of a stream
connection.

I'm open to suggestions, thoughts, etc. but I think modifying
security_unix_may_send() to take a unix_skb_params pointer, e.g.
'security_unix_may_send(sk, other, UNIXCB(skb))', and moving the
SEQ_PACKET restriction out of unix_dgram_sendmsg() and into the
existing LSM callbacks is okay.  However, instead of adding
security_unix_may_send() to unix_stream_sendmsg(), I would suggest the
creation of a new hook, security_unix_send_scm(sk, other, UNIXCB(skb))
(feel free to suggest a different name), that would handle the per-skb
access control for streams.

Of course there is an issue with unix_skb_params not being defined
outside of net/unix, but from a practical perspective that is going to
be a challenge regardless of which, unix_skb_params or the full skb,
is passed to the LSM hook.  You'll need to solve this with all the
relevant stakeholders regardless.

As a FYI, we've documented our policy/guidance on both modifying
existing LSM hooks as well as adding new hooks, see the link below.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

> BTW, I was about to send v3, what target tree should be specified in
> subject, bpf-next or something else ?

I wouldn't worry too much about the subject, prefix, etc. as the To/CC
line tends to be more important, at least from a LSM subsystem
perspective.  I would ensure that you send it to the LSM list and any
related lists, MAINTAINERS and/or scripts/get_maintainer.pl is your
friend here.  Since this is almost surely LSM framework tree material,
my general rule is that I'll handle any merge conflicts so long as
your patch is based on the lsm/dev branch or Linus' default branch.
Of course, you can base your patch against any tree you like, and I'll
grab it, but if there are significant merge conflicts you'll likely
get a nasty email back about that ;)

As far as a v3 is concerned, while I generally don't like to tell
people *not* to post patches, I'll leave that up to you, I do think we
could benefit from some additional discussion here before you post a
v3.  Reviewer time is precious and I would hate to see it spent on an
approach that still has open questions, just in case we all decide to
go in a different direction.

--=20
paul-moore.com

