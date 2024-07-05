Return-Path: <bpf+bounces-33963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56B928D54
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622AE284A8E
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788414A62F;
	Fri,  5 Jul 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZdOSw+3l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036671B963
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202841; cv=none; b=TXisRmSIN6ZPG0BfLLAZGpaEkMrsIBz0UAjcfEq8PlN6kg6EWznYSO3XB8q/zsuqJWdwQg8wqKo//XSs+PnQ5DefgZ8bLJk7YoXPjXQSvekKzuUCGuEPqjMJSQ4T2mLU+XUiXFW2QWxPX4lH6qsOB+bt2D2ui6wZf89e9/9Szwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202841; c=relaxed/simple;
	bh=mTFn1+gouHuDvwi8MhJq3mtQwOjyoxlhGXl229894LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P63AUjpbo71xkC+pwIcvCgOeLZMkMNgOeSZl+hE/8ccAGjveMHMIXubtzRGiMn1JX0CCZxDHev0Yo8YM7BBPCcKi7rPL8kBq6x8Z+9YavsZu52zl8FtPHGcCltF3eqaLAwLqL5JV5AxYDhyKyUtr60GRbPBBsEgNZgb0FWPIxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZdOSw+3l; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03c6892e31so1648488276.1
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720202839; x=1720807639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z5FLCZCyvnlRwY34tEON5vJPfy/b/J/+6MiwH9oud8=;
        b=ZdOSw+3l9DVU7mNd1KGA9Hb5/soVOhPn2kpOsPtg3kAwUJ6Ds+7U5Y6Agrir4VdAAq
         X+oaQC3SInXM67+d8jzDM1I6KjrqUGi+puozama1ezIfQ60r8pv6wTazVWy1ZUt3m5h9
         4xj5RhF4JJXfWGsfsyc6tj4BqQDyypjlDzytPdDKSgyQmf5MqGXmMczy19KICsMSx/Mi
         tWsgTjB0k88hEQGYcBFAtp64/00zpkbgldNq9imVnXIH/kQ2126A/nB1cHJ+r7PcAcIg
         n6vp0wwVb91WX5Qk97RkJasSeLOdItzLZXvuAfB2X3qN/2Zwkfevz7gYfEjRThsQG5C0
         chmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202839; x=1720807639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z5FLCZCyvnlRwY34tEON5vJPfy/b/J/+6MiwH9oud8=;
        b=Is8qo/D7ykVuINs9ORCpZfdho3xVqAbsmMj5i9QTj3fwWyVdJohjhExK0xpYm2XcxK
         xIHGS6tsLYJlwADPNue27FS9oi3jIVdfzS6FNgFjr9SE5T4sooplvuBjQjcTNYetJjr1
         RUGWEOkncH6u72rHLdiJ35h4cXelAyYSIGjiLGNnD43s5EVWQvNDIKO8aIvkEXgCgSeQ
         cO8ABSgczAkjU/6GQv1lqGz4qcLG7ObppO6ZVTEoyzyAJKQUHQV1Qd51OD4+kqlb7cSk
         gP4L/RpF69b/WaBptoZ/zeOw9XnLe+qeRPgd18PH4+23iXpId0orotnjK9qvUMEtlx/6
         vOPw==
X-Forwarded-Encrypted: i=1; AJvYcCXQoZjI6NE9yuZsoJnFONpu8Tjet7P47u8P2CRWMHHWFVki6Nj8pV/qwEyneILklsYw/fvutK3lY8DiraWrSYPx8/J0
X-Gm-Message-State: AOJu0YyYrsz5RPXhBluRQCo2N3KYZ1tE1ZJbcOgeBBR/W8hvEuNpH46H
	IQmOgC0NcJlxpvY+IaTHeZ+UZXE+cB9VkBdXOkSTuYpsXdmpnFbMIMcso06NVkA4cFe3ik+sBQy
	VJCjByEPNE48RZNbQJQK8A8PWumC2czTAWvAw
X-Google-Smtp-Source: AGHT+IHtVQL4ushPXpuFfGzD/I37qb404b6S8CwopaYra26BwP845rfO/hNT8paVpltqskHWve498APJkFDoux9J+OE=
X-Received: by 2002:a5b:bcf:0:b0:e03:597f:5c0 with SMTP id 3f1490d57ef6-e03c1963ea4mr5500345276.17.1720202838303;
 Fri, 05 Jul 2024 11:07:18 -0700 (PDT)
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
 <CAHC9VhRoMpmHEVi5K+BmKLLEkcAd6Qvf+CdSdBdLOx4LUSsgKQ@mail.gmail.com> <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
In-Reply-To: <CACYkzJ6mWFRsdtRXSnaEZbnYR9w85MfmMJ3i76WEz+af=_QnLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jul 2024 14:07:07 -0400
Message-ID: <CAHC9VhRA0hX-Nx20CK+yV276d7nooMmR+Q5OBNOy5fces4q9Bw@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:08=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Thu, Jul 4, 2024 at 12:52=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 3, 2024 at 6:22=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > > On Wed, Jul 3, 2024 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.or=
g> wrote:
> > > > > On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > > > > > >
> > > > > > > LSM hooks are currently invoked from a linked list as indirec=
t calls
> > > > > > > which are invoked using retpolines as a mitigation for specul=
ative
> > > > > > > attacks (Branch History / Target injection) and add extra ove=
rhead which
> > > > > > > is especially bad in kernel hot paths:

...

> > > > I'm not aware of any other existing problems relating to the LSM ho=
ok
> > > > default values, if there are any, we need to fix them independent o=
f
> > > > this patchset.  The LSM framework should function properly if the
> > > > "default" values are used.
> > >
> > > Patch 5 eliminates the possibilities of errors and subtle bugs all
> > > together. The problem with subtle bugs is, well, they are subtle, if
> > > you and I knew of the bugs, we would fix all of them, but we don't. I
> > > really feel we ought to eliminate the class of issues and not just
> > > whack-a-mole when we see the bugs.
> >
> > Here's the thing, I don't really like patch 5/5.  To be honest, I
> > don't really like a lot of this patchset.  From my perspective, the
> > complexity of the code is likely going to mean more maintenance
> > headaches down the road, but Linus hath spoken so we're doing this
> > (although "this" is still a bit undefined as far as I'm concerned).
> > If you want me to merge patch 5/5 you've got to give me something real
> > and convincing that can't be fixed by any other means.  My current
> > opinion is that you're trying to use a previously fixed bug to scare
> > and/or coerce the merging of some changes I don't really want to
> > merge.  If you want me to take patch 5/5, you've got to give me a
> > reason that is far more compelling that what you've written thus far.
>
> Paul, I am not scaring you, I am providing a solution that saves us
> from headaches with side-effects and bugs in the future. It's safer by
> design.

Perhaps I wasn't clear enough in my previous emails; instead of trying
to convince me that your solution is literally the best possible thing
to ever touch the kernel, convince me that there is a problem we need
to fix.  Right now, I'm not convinced there is a bug that requires all
of the extra code in patch 5/5 (all of which have the potential to
introduce new bugs).  As mentioned previously, the bugs that typically
have been used as examples of unwanted side effects with the LSM hooks
have been resolved, both in the specific and general case.  If you
want me to add more code/functionality to fix a bug, you must first
demonstrate the bug exists and the risk is real; you have not done
that as far as I'm concerned.

> You say you have not reviewed it carefully ...

That may have been true of previous versions of this patchset, but I
did not say that about this current patchset.

> ... but you did ask me to move
> the function from the BPF LSM layer to an LSM API, and we had a bunch
> of discussion around naming in the subsequent revisions.
>
> https://lore.kernel.org/bpf/f7e8a16b0815d9d901e019934d684c5f@paul-moore.c=
om/

That discussion predates commit 61df7b828204 ("lsm: fixup the inode
xattr capability handling") which is currently in the lsm/dev branch,
marked for stable, and will go up to Linus during the upcoming merge
window.

> My reasons are:
>
> 1. It's safer, no side effects, guaranteed to be not buggy. Neither
> you, nor me, can guarantee that a default value will be safe in the
> LSM layer.

In the first sentence above you "guarantee" that your code is not
buggy and then follow that up with a second sentence discussing how no
one can guarantee source code safety.  Regardless of whatever point
you were trying to make here, I maintain that *all* patches have the
potential for bugs, even those that are attempting to fix bugs.  With
that in mind, if you want me to merge more code to fix a bug (class),
a bug that I've mentioned several times now that I believe we've
already fixed, you first MUST convince me that the bug (class) still
exists.  You have not done that.

> 2. Performance, no extra function call.

Convince me the bug still exists first and then we can discuss the
merits of whatever solutions are proposed.

--=20
paul-moore.com

