Return-Path: <bpf+bounces-38927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91296C818
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC531F23901
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF21E7670;
	Wed,  4 Sep 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DSUaYCWr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507213A276
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480070; cv=none; b=pVGbe4DocDs2ZrAuvV3gpZQGEUafBuj5ZK0xE2hI4zo2/KzktFgVBKeWizMLOUjiNLOEL8zsyLSi5u2MzoJDadM06Tkt56rUmxctT+cdySGBKRobvBm+2PZagnyfixG+zKOwS+Jb83VwF+7fGmnJpl0p1AUk9vVwbn2GXjJeeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480070; c=relaxed/simple;
	bh=4ZW9uYBRy1l5v3eg2vwYnWmQtnxuduXzhYgb0NI7pac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYavvGsDzaK9gOqpXWj1noO4hoCSMBVSprx99Ufba+7PbxuQUQwwwHWshh0Whn7Dg4qnp41m9gyGNXe5TKpz7RnqMQGdY4qjjZuxKx09z3+EBokXGae+WyzPXboOY+inGMaSCDQCIlgEhFTv6xzVjJIogXH98LxU9jMOpJLBM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DSUaYCWr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6b6b9867f81so57336677b3.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725480068; x=1726084868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj31Cc7yUKdv/FGIF8ZxPGEVE5FVuiVNrp+0ISWDt4c=;
        b=DSUaYCWr/prACtzyg/rPSUvm30yKQ0V+ubT7ZcPSXOQZrWHKdL2v6lCjM/hTEPDtE0
         sqVlA/wLifJgfoU7GeeLALd/fPen2C7kHUFzlntnDXlarJSTTI/UX0v1hEXUIrrcSIfV
         4c2upEGc4WamL5D1Vt300uOrSwbx8ytzKILJLwR0yIjXCON37wB110LKDv1j2j/JehXn
         bzAe/gcx6lzajTXH0V24JE5VH6x92U4rberLWfedRvfS9ghSQv0j6VPPrx3LqtEnQooD
         uFLi2BHXKgpBFmJ8uMgI54nUdksi1sl+l/ZJ6NMD2mHs59cLJo3dzmJW8CRwpeeC1nZb
         rUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480068; x=1726084868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj31Cc7yUKdv/FGIF8ZxPGEVE5FVuiVNrp+0ISWDt4c=;
        b=RxTayFebyYDZIoyx+xin7RbRB98Pog42OLMVY42S8bWbnlDIi951lLF64Bdwry5sK2
         3c3yRZd4SMBueB7zIAlGCc4vaVnRgM87Hgqh4jX0DkhP4NXPuBgY1LSftg7Ot5YOXTtc
         bcZ3Gc0f+jCTHlF/maQspCUHXLSBO1eQeu/wvX5J8G1eswIL8c2vJQZAsixe5WCLnDHN
         +QOPR3tfPb5sn/30zMqNx4kBx1h0mU3mBgli27ATxKUb3w+l2VPrumXX2YmVKh9UPHcQ
         32oLfbDpHcqvMt0C1rfn6URq8pqXWx4Z2biEXONlVW/OTt1dt6UhPwSzL7rIACzwZZSe
         ZcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvm1sNRdBfSH6PZodfF67j/irtV2/fDN1bS0gK/CA+LG7QsC0RR665aZsYgoM0ty4+fjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zEpKjNv1UZjnKt166srJfDGEHtSZoIPjPMqldzscjHeBe8ge
	n42iS6fvAzmHtxNZoHcNU2t4pSqg8utDoadlFbLogaPgdjrLC4POq3DYUiSw1JT7jmqdT8sjTWY
	a7Jq9Qln9vQbmS8sVuxia+sD0JzMW4JMg5fwn
X-Google-Smtp-Source: AGHT+IHwvQ13BznmsQbX7s8QKh0hPJ3ZlsV9dmecF5yPb9RpjrIRg7UHuPNLul3M/O4Vy1wrYN7rj/2T9vkcOmYq8W8=
X-Received: by 2002:a05:690c:3693:b0:6b1:135:4d84 with SMTP id
 00721157ae682-6d40df8a252mr200806537b3.16.1725480068164; Wed, 04 Sep 2024
 13:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830003411.16818-2-casey@schaufler-ca.com>
 <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com> <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
In-Reply-To: <b444ffb9-3ea3-4ef4-b53c-954ea66f7037@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 16:00:57 -0400
Message-ID: <CAHC9VhQ8QDAGc9BsxvPMi6=okwj+euLC+QXL1sgMsr8eHOcx2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/13] LSM: Add the lsmblob data structure.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/3/2024 5:18 PM, Paul Moore wrote:
> > On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> >> +/*
> >> + * Data exported by the security modules
> >> + */
> >> +struct lsmblob {
> >> +    struct lsmblob_selinux selinux;
> >> +    struct lsmblob_smack smack;
> >> +    struct lsmblob_apparmor apparmor;
> >> +    struct lsmblob_bpf bpf;
> >> +    struct lsmblob_scaffold scaffold;
> >> +};
> >
> > Warning, top shelf bikeshedding follows ...
>
> Not unexpected. :)
>
> > I believe that historically when we've talked about the "LSM blob" we'v=
e
> > usually been referring to the opaque buffers used to store LSM state th=
at
> > we attach to a number of kernel structs using the `void *security` fiel=
d.
> >
> > At least that is what I think of when I read "struct lsmblob", and I'd
> > like to get ahead of the potential confusion while we still can.
> >
> > Casey, I'm sure you're priority is simply getting this merged and you
> > likely care very little about the name (as long as it isn't too horribl=
e),
>
> I would reject lsmlatefordinner out of hand.

Fair enough :)

> > but what about "lsm_ref"?  Other ideas are most definitely welcome.
>
> I'm not a fan of the underscore, and ref seems to imply memory management=
.
> How about "struct lsmsecid", which is a nod to the past "u32 secid"?
> Or, "struct lsmdata", "struct lsmid", "struct lsmattr".
> I could live with "struct lsmref", I suppose, although it pulls me toward
> "struct lsmreference", which is a bit long.

For what it's worth, I do agree that "ref" is annoyingly similar to a
reference counter, I don't love it here, but I'm having a hard time
coming up with something appropriate.

I also tend to like the underscore, at least in the struct name, as it
matches well with the "lsm_ctx" struct we have as part of the UAPI.
When we use the struct name in function names, feel free to drop the
underscore, for example: "lsm_foo" -> "security_get_lsmfoo()".

My first thought was for something like "lsmid" (ignoring the
underscore debate), but we already have the LSM_ID_XXX defines which
are something entirely different and I felt like we would be trading
one source of confusion for another.  There is a similar problem with
the LSM_ATTR_XXX defines.

We also already have a "lsm_ctx" struct which sort of rules out
"lsmctx" for what are hopefully obvious reasons.

I'd also like to avoid anything involving "secid" or "secctx" simply
because the whole point of this struct is to move past the idea of a
single integer or string representing all of the LSM properties for an
entity.

I can understand "lsm_data", but that is more ambiguous than I would like.

What about "lsm_prop" or "lsm_cred"?

--=20
paul-moore.com

