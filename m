Return-Path: <bpf+bounces-38933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A705B96C8A6
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331911F25D69
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3814883C;
	Wed,  4 Sep 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I6ckhaKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62344148307
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482233; cv=none; b=kWon25wJu7WzB5cLKOi3KdKfESugvyawoinOUMgh1cCsPmUMZPp6bLfieN8OvrxPh8E4Td5e/a8FB4gbKXA99zrLeQGYHw5iE+0iNrjfyHuZOGH3dcDywN7pA+1mc5RBpvvJwxViUGoDEVsX8rhyZ1nT2zvtnJ/DSASP/FYhLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482233; c=relaxed/simple;
	bh=yQwnYD19n1xUXU4dbty3ehLdSGl/V3zWXm5EKMRaIf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP/JiwrGSWvvmQAce4YetJH1D7UXQUOXCIXe4h1QHy790tmVEg+eTi9Ari3lkc3cVPlqn0jBz8ZPTJLr+Dov8jHYVjG6fbR3u/sT44skzf+Y4P5cIYVTXo13oB+RqrOF6FgSVke03j+C4eZdZ1rpafMvOTZ5vtMYuCtEd8REtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I6ckhaKT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d3c10af2efso54805277b3.0
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725482230; x=1726087030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uSNgAoLeuNZ3XWdQeqcMJZ932reV/H1BZ/60TxYWNg=;
        b=I6ckhaKTHN86Qd0oxsBHDCuvEwxZ+gt388yVPW9pXcoJY4vYyPXXZiONw/+vnLSVnB
         rpL0lytcQ2cK61+dSKQlwG0gjAU4tc3xOhEJ8WaFOcRgE9ApVHV/XqqtJJO761YMuCUS
         wJ56hIZ9BkXC8yy0j64OWUGHh9WGXywwrUeepl4rl9MCtPWist6N2OjFOul+g5dIhAYd
         0UK/Z+8/eznXHOtkh/XYPRGVoh/WKIMOPnxq60cZ85FsKkkBKDSeRq5miz9shOAUvW+T
         RHoVYGzFtDLa4NzNDWAS1Mjte4nfrHUn/at1AkkEopftDKcxE+qXB8Az5IXEdSsMBJjz
         W4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482230; x=1726087030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uSNgAoLeuNZ3XWdQeqcMJZ932reV/H1BZ/60TxYWNg=;
        b=FS7VWxDS1iijqolZlPGUG2Qup0ZWoh6lpd9yVVXZQufQbOiqxkJEGTsDI8zGxxRPOj
         cuduCjtrSpF19ruVkSOT/E7oob2ypK4WtQfBkUWAVyMwOMp0yibkP0az84qX81hGA+hr
         oJu6TO9oiCcSbVeQsuQq3sAOhg3yvYYGC0q+DFlgytzNMUfybkt+F9PFJ8olIVM3s220
         Ygkgpx9JXpFdfEEJRQUt8iJJwhsBbNKF5y0k3YmqPk23/d7wGYrHAPxgjwfRw1lVba4n
         L6s4DXSYmlPtUQh5RItJls2iCHYdEemqF3cV9PnbVx7lXPjB+Xfg7kVei6f9Grj4/N5f
         6IZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKFLd4etuK1v69pi8Z54dNbU5IulOgcBW4M0OHNkck+qs9PiBCfNAnyjW3zkFbSUr87X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVyh64mY3gTJ1G6GK9jAAx266e4gmaG6PwvRmyZIrbI6asgIp
	UOI/Dk/VDHceqsESLho8YuXsYaxe6WtbZmQKyUacj2Ecwzhhgi2WRd3dZ2m4W1VY2coYAc57rZT
	s6XY6pMoilrd/49EpLnV+DDxW5LYvjuvxnkBp
X-Google-Smtp-Source: AGHT+IG9r5awwLWDaSa/SS1wlz6GDBVERagOH9s3xymO+3hCHtxHEKujYrlOkzwl7hougrLaBBg55clsy/6UTBUp4qs=
X-Received: by 2002:a05:690c:4589:b0:6d4:f41d:de2f with SMTP id
 00721157ae682-6d4f42d2475mr143212667b3.39.1725482230428; Wed, 04 Sep 2024
 13:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830003411.16818-2-casey@schaufler-ca.com>
 <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com> <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
 <CAHC9VhQ8QDAGc9BsxvPMi6=okwj+euLC+QXL1sgMsr8eHOcx2w@mail.gmail.com> <93952b9f-2e40-42fc-9a61-749b9c8ee306@schaufler-ca.com>
In-Reply-To: <93952b9f-2e40-42fc-9a61-749b9c8ee306@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 16:36:59 -0400
Message-ID: <CAHC9VhTwYftY4nLauF8A9AOawAGKdU-+TGoVfM7Paf23x1Vm8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/13] LSM: Add the lsmblob data structure.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:28=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/4/2024 1:00 PM, Paul Moore wrote:
> > On Tue, Sep 3, 2024 at 8:53=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 9/3/2024 5:18 PM, Paul Moore wrote:
> >>> On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> > ..
> >
> >>>> +/*
> >>>> + * Data exported by the security modules
> >>>> + */
> >>>> +struct lsmblob {
> >>>> +    struct lsmblob_selinux selinux;
> >>>> +    struct lsmblob_smack smack;
> >>>> +    struct lsmblob_apparmor apparmor;
> >>>> +    struct lsmblob_bpf bpf;
> >>>> +    struct lsmblob_scaffold scaffold;
> >>>> +};
> >>> Warning, top shelf bikeshedding follows ...
> >> Not unexpected. :)
> >>
> >>> I believe that historically when we've talked about the "LSM blob" we=
've
> >>> usually been referring to the opaque buffers used to store LSM state =
that
> >>> we attach to a number of kernel structs using the `void *security` fi=
eld.
> >>>
> >>> At least that is what I think of when I read "struct lsmblob", and I'=
d
> >>> like to get ahead of the potential confusion while we still can.
> >>>
> >>> Casey, I'm sure you're priority is simply getting this merged and you
> >>> likely care very little about the name (as long as it isn't too horri=
ble),
> >> I would reject lsmlatefordinner out of hand.
> > Fair enough :)
> >
> >>> but what about "lsm_ref"?  Other ideas are most definitely welcome.
> >> I'm not a fan of the underscore, and ref seems to imply memory managem=
ent.
> >> How about "struct lsmsecid", which is a nod to the past "u32 secid"?
> >> Or, "struct lsmdata", "struct lsmid", "struct lsmattr".
> >> I could live with "struct lsmref", I suppose, although it pulls me tow=
ard
> >> "struct lsmreference", which is a bit long.
> > For what it's worth, I do agree that "ref" is annoyingly similar to a
> > reference counter, I don't love it here, but I'm having a hard time
> > coming up with something appropriate.
> >
> > I also tend to like the underscore, at least in the struct name, as it
> > matches well with the "lsm_ctx" struct we have as part of the UAPI.
> > When we use the struct name in function names, feel free to drop the
> > underscore, for example: "lsm_foo" -> "security_get_lsmfoo()".
> >
> > My first thought was for something like "lsmid" (ignoring the
> > underscore debate), but we already have the LSM_ID_XXX defines which
> > are something entirely different and I felt like we would be trading
> > one source of confusion for another.  There is a similar problem with
> > the LSM_ATTR_XXX defines.
> >
> > We also already have a "lsm_ctx" struct which sort of rules out
> > "lsmctx" for what are hopefully obvious reasons.
> >
> > I'd also like to avoid anything involving "secid" or "secctx" simply
> > because the whole point of this struct is to move past the idea of a
> > single integer or string representing all of the LSM properties for an
> > entity.
> >
> > I can understand "lsm_data", but that is more ambiguous than I would li=
ke.
> >
> > What about "lsm_prop" or "lsm_cred"?
>
> If we ever do the same sort of thing for the existing blobs we're
> going to need to have lsm_cred for the cred blob, so I shan't use
> it here. I can live with lsm_prop, which shouldn't confuse too many
> developers. We can start saying "property" in place of secid, which
> would be a good thing.

Works for me, thanks Casey.

--=20
paul-moore.com

