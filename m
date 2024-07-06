Return-Path: <bpf+bounces-33983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B659290BD
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 06:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D62B283750
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F90171B6;
	Sat,  6 Jul 2024 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DOZoOJpX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4710A2A
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 04:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720240846; cv=none; b=rjItf+DzQ52dzR/gTFqq47OZSAFj5dags8do9FGEETilEsrfJKyEM0uM5crVxbmjO6FrYRSZJCpDceS5cHTeJGkepGIMcKWlOMOSU7Y0Xtz6mVp1/baJkoKxAJUaKIQyUYGq5aj+9llEdD7ls0fBrz9wKtbPDFOnSnGhfpPM9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720240846; c=relaxed/simple;
	bh=8M5er9YjStnMXRNCG3WNAs5g+EmmXlIuGIN7yE3sCKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOc7deZn4DYDVzdYhuFQu5o8thcFMV2Eb3WRXAS3OY1Ubob6QHObEsuiwYTujlfl9XeT6pulKxB9rARu9hkAHGrQHIJ6UZb785eeUdVJKwNmhSW7OlsYxmfKR+ZDZjLDiPH0aTfFo14T9Nr7vyAoGgaWOEgRZ+PV7PeG/afrbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DOZoOJpX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so2493057276.2
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 21:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720240843; x=1720845643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dgWYeFOoYYrqtK5fxSiE6RizfLA6F0xNXYkGXTLxv8=;
        b=DOZoOJpXByS7daBvp540J7NeA4sZuncfdt5PLGW+HR867TT5SuhIxyEmbOO3cQJEnb
         vpFATer8roAnLnjbZs+TV558sajLkaW7PeiytH9djBViajpgMG9wITQzIoc9Ts/LHJag
         0pj7i6sXyuupGxwfRgV1soy+5mqD/c/Qtbr8Z0ywT4DmzUI2bXqtzSz3+H6fxR8EVb2f
         j7C0vwB/aD0hpKTsCdFF1rj4ZlWWUbSfwyr5olCRjAb58S8xQUXaivnfE/mBfSN4xlGV
         jps1b51aHctCEcVTf30Gp17T9BWrv5c93JQ+P2xRjOH3WxEUbY2oELhOFR41wQ5XcPPH
         JJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720240843; x=1720845643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dgWYeFOoYYrqtK5fxSiE6RizfLA6F0xNXYkGXTLxv8=;
        b=G25VS43fahsy/vvVpN+SvyXZCtHaGX2B/tIdDR+punPAv986oNWgjRXgoBqGotyoAB
         XoUI/H6qbinknstnEekTnjGE+ZdCyk+kFdY6JDLoG3IGH3gvveMAYPVd6yo0gywh/iu8
         VCaIpYyq4HpzVGaykjaeYwZy6Pwiho8eqZ86pE2Q85iIJQzQtCnPJsgbrFmKNt2jqKUm
         e3TK4bF8ENvu8F6AHzmQynon1qkJ7HKgiLCwZBzT8Gmd1AWAW5kpyguk/JhS8rvmdqq/
         Z3wL8ggm88aSXppeHqYpOlGf9ShFEY3E19odpTg8UNO/z5NvsTXC9wx259VR01LYDn83
         w8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg+LSQ9azoowwwaUgPFG2PJ3rxGTDguOYbJ2NRJBEYuunnMiaWB41X762j6qxh1v4UySo8L28x0xMU3Y3EERRKfoLf
X-Gm-Message-State: AOJu0YzTWgm/32o+FTNUkgSj5/YNZ9ESjwWJlG6mn4X1bYzMSkIabF3g
	PB7uDBGsBOZNzoYL0kyfRzOP7eFUr74cntXuJsk8Q6bcBCJzKRouOs80ZRy3Ct7kXmCYVsGDQzh
	+OTPmVSxjHpxGvD0pufRcU0LIu/CbiDx9OPdx
X-Google-Smtp-Source: AGHT+IHRGXBBadWH3kB0Ae4Y7QzaiiSx38+TmU1enfHug0Z/RlfyRVIoyJm8hodrbz4Bj9WcRk3GnOykbTAryiHzY9Q=
X-Received: by 2002:a25:bc8d:0:b0:e03:643a:2a3b with SMTP id
 3f1490d57ef6-e03c1911bb6mr7067551276.2.1720240843331; Fri, 05 Jul 2024
 21:40:43 -0700 (PDT)
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
 <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
 <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com> <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
In-Reply-To: <CACYkzJ6jADoGNuPP3-1wkk-kV7NOQh+eFkU5KEDEZgq9qNNEfg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 6 Jul 2024 00:40:32 -0400
Message-ID: <CAHC9VhQQkWxMT3KguOOK7W8cbY-cdeYTJSuh=tSDV4jsqp6s6g@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:34=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Fri, Jul 5, 2024 at 8:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org=
> wrote:
> > > > > On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > > > On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kerne=
l.org> wrote:
> > > > > > > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > > > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > LSM hooks are currently invoked from a linked list as ind=
irect calls
> > > > > > > > > which are invoked using retpolines as a mitigation for sp=
eculative
> > > > > > > > > attacks (Branch History / Target injection) and add extra=
 overhead which
> > > > > > > > > is especially bad in kernel hot paths:
> >
> > ...
> >
> > > > > > I'm not aware of any other existing problems relating to the LS=
M hook
> > > > > > default values, if there are any, we need to fix them independe=
nt of
> > > > > > this patchset.  The LSM framework should function properly if t=
he
> > > > > > "default" values are used.
> > > > >
> > > > > Patch 5 eliminates the possibilities of errors and subtle bugs al=
l
> > > > > together. The problem with subtle bugs is, well, they are subtle,=
 if
> > > > > you and I knew of the bugs, we would fix all of them, but we don'=
t. I
> > > > > really feel we ought to eliminate the class of issues and not jus=
t
> > > > > whack-a-mole when we see the bugs.
> > > >
> > > > Here's the thing, I don't really like patch 5/5.  To be honest, I
> > > > don't really like a lot of this patchset.  From my perspective, the
> > > > complexity of the code is likely going to mean more maintenance
> > > > headaches down the road, but Linus hath spoken so we're doing this
> > > > (although "this" is still a bit undefined as far as I'm concerned).
> > > > If you want me to merge patch 5/5 you've got to give me something r=
eal
> > > > and convincing that can't be fixed by any other means.  My current
> > > > opinion is that you're trying to use a previously fixed bug to scar=
e
> > > > and/or coerce the merging of some changes I don't really want to
> > > > merge.  If you want me to take patch 5/5, you've got to give me a
> > > > reason that is far more compelling that what you've written thus fa=
r.
> > >
> > > Paul, I am not scaring you, I am providing a solution that saves us
> > > from headaches with side-effects and bugs in the future. It's safer b=
y
> > > design.
> >
> > Perhaps I wasn't clear enough in my previous emails; instead of trying
> > to convince me that your solution is literally the best possible thing
> > to ever touch the kernel, convince me that there is a problem we need
> > to fix.  Right now, I'm not convinced there is a bug that requires all
> > of the extra code in patch 5/5 (all of which have the potential to
> > introduce new bugs).  As mentioned previously, the bugs that typically
> > have been used as examples of unwanted side effects with the LSM hooks
> > have been resolved, both in the specific and general case.  If you
> > want me to add more code/functionality to fix a bug, you must first
> > demonstrate the bug exists and the risk is real; you have not done
> > that as far as I'm concerned.
> >
> > > You say you have not reviewed it carefully ...
> >
> > That may have been true of previous versions of this patchset, but I
> > did not say that about this current patchset.
> >
> > > ... but you did ask me to move
> > > the function from the BPF LSM layer to an LSM API, and we had a bunch
> > > of discussion around naming in the subsequent revisions.
> > >
> > > https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moo=
re.com/
> >
> > That discussion predates commit 61df7b828204 ("lsm: fixup the inode
> > xattr capability handling") which is currently in the lsm/dev branch,
> > marked for stable, and will go up to Linus during the upcoming merge
> > window.
> >
> > > My reasons are:
> > >
> > > 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> > > you, nor me, can guarantee that a default value will be safe in the
> > > LSM layer.
> >
> > In the first sentence above you "guarantee" that your code is not
> > buggy and then follow that up with a second sentence discussing how no
> > one can guarantee source code safety.  Regardless of whatever point
> > you were trying to make here, I maintain that *all* patches have the
> > potential for bugs, even those that are attempting to fix bugs.  WithD
> > that in mind, if you want me to merge more code to fix a bug (class),
> > a bug that I've mentioned several times now that I believe we've
> > already fixed, you first MUST convince me that the bug (class) still
> > exists.  You have not done that.
>
> Paul, I am talking about eliminating a class of bugs, but you don't
> seem to get the point and you are fixated on the very instance of this
> bug class.

I do understand that you are trying to eliminate a class of bugs, the
point I'm trying to make is that I believe we have addressed that
already with the patches I've previously cited.

> > > 2. Performance, no extra function call.
> >
> > Convince me the bug still exists first and then we can discuss the
> > merits of whatever solutions are proposed.
>
> This is independent of the bug!

Correctness first, maintainability second, performance third.  That's
my current priority and I feel the maintainability hit doesn't justify
the performance win at this point in time.  Besides, we're already
expecting a big performance boost simply by moving to static_calls.

> As I said, If you don't want to modify the core LSM layer, it's okay,
> I still want to go with changes local to the BPF LSM, If you really
> don't agree with the changes local to the BPF LSM, we can have it go
> via the BPF tree and seek Linus' help to resolve the conflict.

As the BPF maintainer you are always free to do whatever you like
within the scope of the LSM you maintain so long as it does not touch
or otherwise impact any of the other LSMs or the LSM framework.  If
you do affect the other LSMs, or the LSM framework, you need to get an
ACK from the associated maintainer.  That's pretty much how Linux
kernel development works.

--=20
paul-moore.com

