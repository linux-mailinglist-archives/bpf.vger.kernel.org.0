Return-Path: <bpf+bounces-29004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE08BF434
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 03:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BAE1C22328
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 01:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41499449;
	Wed,  8 May 2024 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fHcDMvKZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46368F55
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132722; cv=none; b=Eacu/AdxIjTMIeAv5bU/NFuhs5U7m/HAp7XkMIUm4i+gyPrGMxDz+Z5kai88ykICj570BEXDk5WUZnsQ+GZc4gkZi7k0P7mwT1IhuKVwerEnppnKrlWArYAx6/Ne6Z77MNdU/DIrH02SHRGYm7fK4y0hA3EJhTkf1UKP0KEbRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132722; c=relaxed/simple;
	bh=R5J5D9ZKuWmZzGFNECx87GIRuqKlti4xOZdHT8yGlp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1HAsSMGqTBTU5nku4gaCfbWyxzJRG499r1AX0+O+APQsISkrOjt4y7XH6COkCpHTtwVOXypbHciSkv6Oz04XKTKYTh0UmoepcRWLIUB9xv4c7sQ1gQNZN7+3pTv6p6b7hOWYSC9JiVV7XWsGQrS2qwnL/eL1pMCuufNrYTGW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fHcDMvKZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62036051972so42138947b3.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715132720; x=1715737520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrJsMoaRhbasokCymMtA8+yZNAppY6Qm/M+dgYp8KUs=;
        b=fHcDMvKZc3mm7/WVCyXEhUJIJE5pW8muV1yyC7SZjJStCSSi8w71nl+sn+EgJdl+a2
         qVjhrsK9iTpr74cAPfXRANc3KZ1H2SbJ/JgoC66ldCq4Ww03DOMkZPZ3pLphz5uDKTEL
         WjRHEo2uV+2CigBN7Z9GubPkvQ+lXfMGVYy9adhimVltQmbCg7SrYyK+h/gkC6YaKDsx
         NkNKTkx80gdx0sgMXiOURoBs4C7kPxMr6U7mk52A0uu9kvvcss/YfqR4hrxANrOzqnyK
         kwnhppm/gj69M217XJmRG9Jb6TjEmmqyiSzm0bMD3zgzRmoANJ8T+CeLZAazbeNZmbeK
         OC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132720; x=1715737520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrJsMoaRhbasokCymMtA8+yZNAppY6Qm/M+dgYp8KUs=;
        b=V8zbIo4G+A+Nek+O+pVnOcgsXkcgo1rGmOVzwOg5t5yAMkoUxcB3B4qWxr4EHG+Eqi
         EuId/U/dTXhMOM6cD/CkODbhot+z64FF4ZvhNyyMKNoOJQnDql3FfLzFsYI46zoE5UW1
         mMe/ENCDCHt0TAuIUlU+IMcppfyYi5TfBD4oca0k5cDL41G7TojOPG1pLdDiVxhuZaAc
         lyTj9j+GiDAc3eugfLhWwHgzun7QmhxYmHRIq9wgQuGAVzycwUYcfl/HQCJEnTgqFlos
         dhdjpH/nDbBLX7yTj3bAgQE+UvqQHfT5Ap5SpBvUxDeaJhlIU6kKZyXohJeudPVRJNtP
         bWUw==
X-Forwarded-Encrypted: i=1; AJvYcCUzd3jik/r2wed0psa0tnkwGAE5o2zmsZB155ZHULzj2cCwxB4IgqDINlQ5+mHOKsNFHqjiwlMDWIRQzcANZdpQmQi/
X-Gm-Message-State: AOJu0YxzTIdQFFNwvnilMpRJP7mN6uHPhn6GRFqeRdah5C+SEanwDoTS
	Gk9SuuR5TwPR0CoQhtkTT2uMIWRUzOKx36Zmq3JZp8bfehbLH1C2C1K9xVN3ES0UPPBPHj73sX8
	/BiM0MBlrtfcTHqPw0DXgwOSpjGIHWa3KVACP
X-Google-Smtp-Source: AGHT+IGjKeonlGN7lLPWOVHFC+5P9EL3SvbUl7WN4dyHUsZy0cawxGPRfPyPsIJFsTkfddSbIY4cRnWTJC4/C30kbkw=
X-Received: by 2002:a0d:ea92:0:b0:61b:2b7:27d8 with SMTP id
 00721157ae682-62085aa1ee8mr15117897b3.23.1715132719776; Tue, 07 May 2024
 18:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook>
In-Reply-To: <202405071653.2C761D80@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 May 2024 21:45:09 -0400
Message-ID: <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com, 
	song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:01=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
> > [...]
> > +/**
> > + * security_toggle_hook - Toggle the state of the LSM hook.
> > + * @hook_addr: The address of the hook to be toggled.
> > + * @state: Whether to enable for disable the hook.
> > + *
> > + * Returns 0 on success, -EINVAL if the address is not found.
> > + */
> > +int security_toggle_hook(void *hook_addr, bool state)
> > +{
> > +     struct lsm_static_call *scalls =3D ((void *)&static_calls_table);
> > +     unsigned long num_entries =3D
> > +             (sizeof(static_calls_table) / sizeof(struct lsm_static_ca=
ll));
> > +     int i;
> > +
> > +     for (i =3D 0; i < num_entries; i++) {
> > +             if (!scalls[i].hl)
> > +                     continue;
> > +
> > +             if (scalls[i].hl->hook.lsm_func_addr !=3D hook_addr)
> > +                     continue;
> > +
> > +             if (state)
> > +                     static_branch_enable(scalls[i].active);
> > +             else
> > +                     static_branch_disable(scalls[i].active);
> > +             return 0;
> > +     }
> > +     return -EINVAL;
> > +}
>
> First of all: patches 1-4 are great. They have a measurable performance
> benefit; let's get those in.
>
> But here I come to patch 5 where I will suggest the exact opposite of
> what Paul said in v9 for patch 5. :P

For those looking up v9 of the patchset, you'll be looking for patch
*4*, not patch 5, as there were only four patches in the v9 series.
Patch 4/5 in the v10 series is a new addition to the stack.

Beyond that, I'm guessing you are referring to my comment regarding
bpf_lsm_toggle_hook() Kees?  The one that starts with "More ugh.  If
we are going to solve things this way ..."?

> I don't want to have a global function that can be used to disable LSMs.
> We got an entire distro (RedHat) to change their SELinux configurations
> to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
> CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
> remove the runtime disable functionality"). We cannot reintroduce that,
> and I'm hoping Paul will agree, given this reminder of LSM history. :)
>
> Run-time hook changing should be BPF_LSM specific, if it exists at all.

I don't want individual LSMs manipulating the LSM hook state directly;
they go through the LSM layer to register their hooks, they should go
through the LSM layer to unregister or enable/disable their hooks.
I'm going to be pretty inflexible on this point.

Honestly, I see this more as a problem in the BPF LSM design (although
one might argue it's an implementation issue?), just as I saw the
SELinux runtime disable as a problem.  If you're upset with the
runtime hook disable, and you should be, fix the BPF LSM, don't force
more bad architecture on the LSM layer.

--=20
paul-moore.com

