Return-Path: <bpf+bounces-33809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF329269C3
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DB9B21729
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98303190696;
	Wed,  3 Jul 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eV654SwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE817965E
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040213; cv=none; b=OB9TyJx1dLnN9fCjB/WCdJBAdt0PYH+T7RFkN0UIbxA9eAt1Xpktwp7PzyaeY8ermSjBJjsnj4oUJr8E5FSFKfkOLMH8raBOaLvV8pTzCPuONT4zfCLhZBqx+3gGHWyzTnKXfOjXKPtSJDvtMxYBjKKpU6L7TnpFPxoB79F4bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040213; c=relaxed/simple;
	bh=obgNzfWpS4Wqjh8sVn9FRXNg2IXTLSbLvjMbVsv5wz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAm9RcbGLxXb8hw56ZHBAsC0B5CiNGNuQpncZ3DSWsJZi/LfqnkN4/uT5QNJA54tTOEkL3UwMV7Po5cMyJn2uDegMzMeydwz8VrjkQxfc5OIA7YPLKSfFdb8RkvCq1no9U4QRdx++HSPhjq2JKeTVCw/8uXzO8Pc5nL00L9F85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eV654SwB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b5617ba47so50658027b3.3
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720040210; x=1720645010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm3scAkam10jRvz+UGdgrBYyDyM7niI++wTLdui9CLM=;
        b=eV654SwBV3rz6FcIxIrriDJL/2aCBqJ5Gk0fMzIfIwG/JIMR+5N8hMr5nlumrOodgh
         Kgqb5MwI8R4lDTdRY3WotunM7533LkocBQRoh7obD8gRfBHpx6j7ArSYJVEJ7EEU50aD
         rz8rTMM1VmLlTOGl8Vp4TuWB3TFI11FHeYoDhh2GYDkLtvUgVB4lkqi4KETTTyYK4mE9
         wi5sE4FHC6q2gjiTLLB3mbKpiCV5GMYyEho02NyKcMC81tgQW0MQIDBPiL8knqk9JCfW
         +Lo5UPJR1pFHZJ4CkTiyAkuQU9ixky5pc+5E61KYLZDXoE6UhKP4LjRfaZqm67FwOxIT
         KrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040210; x=1720645010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm3scAkam10jRvz+UGdgrBYyDyM7niI++wTLdui9CLM=;
        b=ZOWbolg9bPv4Igvf8TFjY8/nsPERA22mKlHQ1wZv5rHT+oK3V866nim42GZ3mq0Ljc
         cmYT2HbMdELJME2R4sLx7lcB5Tt5DUv2PfM/S/6G0dmxgLd0cCuJcT3HT7pWOlLYUXpO
         Rfk2+mmNUaIh7bNbvKvINx29J2YjoKS2g8e7lpHToFGYBFCw9Cshc1gJBao8V6pXKsL7
         LtPsVpE9TBincohza5mqpdRuE7ffaZGdCEqhtoJZ26D5FkzxX9ZUpohskL/+MLg1kgsQ
         5FcTfVmauzupm5MlB98H9HwPpqppQJHGqv1UKToJhmE/ha2i3YD5XsRvtQlwLatC1yYi
         m2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuUli81VWUqILSRCq2G3lUqU1RnzN9KP2lLL357X8lfs1Ru9EqoNLXSSHsff2j5ZZoT+yZREbbRt6T8lpoHPOdGlUO
X-Gm-Message-State: AOJu0YyWd2DilfA/NnKVAqulXgB+ZhF/NTbvLhEzK8jZB5N0nprhYISR
	kTO48fYLZtUeDwkDn0ejH+BK/SDrxMBR4vTS2tBtku2O1xNYXdmb/iCa1P+A+shvQIXgIjgVlYV
	ziGlS9KFL1kSHvaCzUpyKz/yPWlGj+bLkGKW4
X-Google-Smtp-Source: AGHT+IGNRuXndoerx+c+18AiEd37OO1dyOuVdk3aAsh5sos5JlabrQ9IEFOKlwNvejaNXfF+hqhb3IBEBOFOundq9IA=
X-Received: by 2002:a0d:e80d:0:b0:645:44d:82cf with SMTP id
 00721157ae682-64c71145676mr110101137b3.1.1720040210534; Wed, 03 Jul 2024
 13:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-4-kpsingh@kernel.org> <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
 <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
In-Reply-To: <CACYkzJ60tmZEe3=T-yU3dF2x757_BYUxb_MQRm6tTp8Nj2A9KA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jul 2024 16:56:39 -0400
Message-ID: <CAHC9VhQ4qH-rtTpvCTpO5aNbFV4epJr5Xaj=TJ86_Y_Z3v-uyw@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 12:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, Jul 3, 2024 at 2:07=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > LSM hooks are currently invoked from a linked list as indirect calls
> > > which are invoked using retpolines as a mitigation for speculative
> > > attacks (Branch History / Target injection) and add extra overhead wh=
ich
> > > is especially bad in kernel hot paths:
>
> [...]
>
> > should fix the more obvious problems.  I'd like to know if you are
> > aware of any others?  If not, the text above should be adjusted and
> > we should reconsider patch 5/5.  If there are other problems I'd
> > like to better understand them as there may be an independent
> > solution for those particular problems.
>
> We did have problems with some other hooks but I was unable to dig up
> specific examples though, it's been a while. More broadly speaking, a
> default decision is still a decision. Whereas the intent from the BPF
> LSM is not to make a default decision unless a BPF program is loaded.
> I am quite worried about the holes this leaves open, subtle bugs
> (security or crashes) we have not caught yet and PATCH 5/5 engineers away
>  the problem of the "default decision".

The inode/xattr problem you originally mentioned wasn't really rooted
in a "bad" default return value, it was really an issue with how the
LSM hook was structured due to some legacy design assumptions made
well before the initial stacking patches were merged.  That should be
fixed now[1] and given that the inode/xattr set/remove hooks were
unique in this regard (individual LSMs were responsible for performing
the capabilities checks) I don't expect this to be a general problem.

There were also some issues caused by the fact that we were defining
the default return value in multiple places and these values had gone
out of sync in a number of hooks.  We've also fixed this problem by
only defining the default return value once for each hook, solving all
of those problems.

I'm not aware of any other existing problems relating to the LSM hook
default values, if there are any, we need to fix them independent of
this patchset.  The LSM framework should function properly if the
"default" values are used.

[1] I just realized that commit 61df7b828204 doesn't properly update
the removexattr implementations for SELinux and Smack, expect a patch
for that soon.  The current code is okay, it just does some
unnecessary work (see the setxattr changes to get an idea of the
changes needed).

> > > +#define lsm_for_each_hook(scall, NAME)                              =
         \
> > > +     for (scall =3D static_calls_table.NAME;                        =
   \
> > > +          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) =
 \
> > > +             if (static_key_enabled(&scall->active->key))
> >
> > This is probably a stupid question, but why use static_key_enabled()
> > here instead of static_branch_unlikely() as in the call_XXX_macros?
>
> The static_key_enabled is a check for the key being enabled, whereas
> the static_branch_likely is for laying out the right assembly code
> (jump tables etc.) and based on the value of the static key, here we
> are not using the static calls or even keys, rather we are following
> back from direct calls to indirect calls and don't really need any
> jump tables in the slow path.

Gotcha, thanks for the explanation.

--=20
paul-moore.com

