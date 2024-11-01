Return-Path: <bpf+bounces-43794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C508E9B9AF3
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 23:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F891F21C64
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AC1D0E18;
	Fri,  1 Nov 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED1/ZkTZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BF1547DC
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730501766; cv=none; b=AoZ51Nc4z/5mkbpaFZH2DVtoTRl83su6mepTYfxsMssRs+yngSMCL1YHMTtnWdQNn6objmHGAIinHF/1py1O5ktUn8X1HM1rYIBI2fZ9ZCSyTG0WtOrhN4lyeA7eREEtN72N49XXxaFPp980pM2dvxc/OLd8OqHWYkVWJzyw9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730501766; c=relaxed/simple;
	bh=HQ+OTR9XhJqSEbXgxn5UgjQJsDh9M1kmz9xh3cSrIJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF0tW2coBc1TVtNXq+VZBl7Bne6FjZ5WcsDKxct+q2vAhqPlf58PEIaYaqPaf/pQcIttCt/SPkLCz8iNWRbMJolVgYZYXcR4kwJQM0ooE/c7fXwpi9adIVrgw1GSSm1mqrqRaCTPvsLWC30fRshVYr+4tW3oAMRgQ6h7vqM6+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED1/ZkTZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4c482844so1417922f8f.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730501763; x=1731106563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA2GMRZy2WBeJFn4gooXbK9DGHEJ+PRZSagnKTrMxHc=;
        b=ED1/ZkTZb5868Df4C93ZTU80NNhGDGYt+QDtOJYxhclMDWaJWYNxkSnGFolzmw/2+V
         Hoyo8sgXVySX9e0aq/eOl6MVm2QBfrh0sQCoQ5ANsKXcja735rRL977BWlHivCwBX14z
         v8DKJKgVqRwEBqJJFJ2hGCWfUoYB5yYm8wlMJ9o8Q+KXL9RMpxtr6cjH4tXny3uvEV9Q
         ElGUg7FR/aLOITP7KBcGp4qSAusz5Zq/QtwDEXAcPXd+tAu90Sb2vSYTB4iM6ZG0aQTy
         YZmJjmI9gRGaS+3wfXR9zcDl0xy891XLOI14/WiVYHjSlFxWA0FKM7dbEs50WyMK63xt
         /jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730501763; x=1731106563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA2GMRZy2WBeJFn4gooXbK9DGHEJ+PRZSagnKTrMxHc=;
        b=dXQymhOpsrhHNlxXnPt++kNX3V/CCF9kOqs1uqobv1ULRtPQxh25ai2kgmyCUUjC8D
         NHfaA0hDwFC1aLW0EQLFmzMZc4yhjZncT4ahWQEkZGtQ9OyYfqk6bBxXLt3YLYWhMw0q
         5MwZLMr5Fw8xZADRsG7WoOhXlOpz5J2FxWOrJZm0CYyXGsen3AQGnbLhBBbuuUo3CwUK
         RzYpN8h8B2s5FRoMD3XgHHt887/fsAr2fQd7BwJ2G5wVfi7LN5b03veqFfMfW6IbiumH
         kns9AuYrkwHIMgM08L1vIH/J3x/a/vknkHuzTj3JeKDuwJUlJ+6pK35OtViWIRpiriNU
         HCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwGUVajfuPDUrm2dUjjx3EawCzQAn27B1gTihacooCXWhmRjFacjM6XJvxsiDC23iPrNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+q+b7An5vZwiqR5j2X6Zt3w3z7LpQbd4XnJBddom9+/6YYlx
	ln7EBjM4urp45Bv+mxlgPaI04ilyYs9pdVK73U+ec38R5rWm4idl1v0iG5IYE4+QsaB2XJ/BBZi
	oyvzrsi/wo3bsdLxwOY2pyoRcjD0=
X-Google-Smtp-Source: AGHT+IHPTCgouyWtbAypVYRRes8NPl1/czWMCAwAfjsy7ADcP+HLTA8d2SN1AD4i4A47o7adAwUryVyROQnhGk6sP1I=
X-Received: by 2002:a5d:448c:0:b0:37d:51f8:46fd with SMTP id
 ffacd0b85a97d-380611279c0mr16805377f8f.22.1730501762763; Fri, 01 Nov 2024
 15:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com> <20241101000017.3424165-2-memxor@gmail.com>
 <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
In-Reply-To: <CAEf4BzaS9+Zs7cRKXPxD1zxNu4DLQw1VmPbJ4_cUMrSfc0R7sg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 15:55:51 -0700
Message-ID: <CAADnVQL0DHb5Qev9X09w87URJabX44YpH5L-XE9+V-h9ge7KwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Juri Lelli <juri.lelli@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bpf_ve=
rifier_env *env,
> >
> >         if (ret < 0)
> >                 return ret;
> > -
> > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
> > +        * trusted PTR_TO_BTF_ID, these are the ones that are possibly
> > +        * arguments to the raw_tp. Since internal checks in for truste=
d
> > +        * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
> > +        * modifier as problematic, mask it out temporarily for the
> > +        * check. Don't apply this to pointers with ref_obj_id > 0, as
> > +        * those won't be raw_tp args.
> > +        *
> > +        * We may end up applying this relaxation to other trusted
> > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
> > +        * tagging, but that should expand allowed behavior, and not
> > +        * cause regression for existing behavior.
> > +        */
>
> Yeah, I'm not sure why this has to be raw tp-specific?.. What's wrong
> with the same behavior for BPF iterator programs, for example?
>
> It seems nicer if we can avoid this temporary masking and instead
> support this as a generic functionality? Or are there complications?
>
> > +       mask =3D mask_raw_tp_reg(env, reg);
> >         if (ret !=3D PTR_TO_BTF_ID) {
> >                 /* just mark; */
> >
> > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bpf_ve=
rifier_env *env,
> >                 clear_trusted_flags(&flag);
> >         }
> >
> > -       if (atype =3D=3D BPF_READ && value_regno >=3D 0)
> > +       if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, =
btf_id, flag);
> > +               /* We've assigned a new type to regno, so don't undo ma=
sking. */
> > +               if (regno =3D=3D value_regno)
> > +                       mask =3D false;
> > +       }
> > +       unmask_raw_tp_reg(reg, mask);

Kumar,

I chatted with Andrii offline. All other cases of mask/unmask
should probably stay raw_tp specific, but it seems we can make
this particular case to be generic.
Something like the following:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..bbd4c03460e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6703,7 +6703,11 @@ static int check_ptr_to_btf_access(struct
bpf_verifier_env *env,
                 */
                flag =3D PTR_UNTRUSTED;

+       } else if (reg->type =3D=3D (PTR_TO_BTF_ID | PTR_TRUSTED |
PTR_MAYBE_NULL)) {
+                       flag |=3D PTR_MAYBE_NULL;
+                       goto trusted;
        } else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
+trusted:

With the idea that trusted_or_null stays that way for all prog
types and bpf_iter__task->task deref stays trusted_or_null
instead of being downgraded to ptr_to_btf_id without any flags.
So progs can do few less !=3D null checks.
Need to think it through.

