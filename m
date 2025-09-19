Return-Path: <bpf+bounces-68966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE9B8AE8F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD934E5D1A
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D825D1F5;
	Fri, 19 Sep 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6PJGt0B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D21AE877
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306423; cv=none; b=V7Tv8GbTdjfgz5p/bhxqh/M/OMvpZz+9QZJAMNLFzLQw/U2CGDXnw5g+XlHNQO+VMblJzHdhW/ojhGQBRezods4XrCyPIvOi0ZIwL3tgB77tOYxKmoD2N+GisVPd6TQjFtXs2HVd83JGVc2SDq2qHeGZNmpTgyEgmGtc0HDvKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306423; c=relaxed/simple;
	bh=E5SaRk1yfysbaxdRxwj26nnY2kidEnn5s4X3xmZo9v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckRxkmj1HdMXY1s7S1hb3I4LvWXzn4kPPeSRMrzH7QQFLCCSGA5e9mPqNqQ/acR2w99tlwjr06HUl4or0W28JrzRrrRqXUcRZ8wu5Sl0/MFVVBJophMWjCtJ6h2AHqHLnS1vC2ns0TXEuP+As4MFApiEajePqNhZKMhsjfs0Ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6PJGt0B; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso16196815e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306420; x=1758911220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0/YAjgWUGKSiQA01R+laVJ6Ma6BYktx0e7jNRZ8vT4=;
        b=E6PJGt0BX7e9ZM6YDttQTsjAxDOqUEeCBfYW6/ANHQ92BL5RuhoZZ6DQIbaSfJqwKx
         VF3ENV0ZZ79p0Ige5bBQO9eo8HIfM7NMJQWikF85U74unRtuRTtTAyr0znL4kvffDF0r
         2ldpmmDK3ftPUFxZkfAU73BV314JygKTQp+lIpc6lA3Iy1NMq2TXUnzv+0aUcjuU/XNK
         WA4679zn9Bs//P3Jgi1LNNS1v6SZj1484YMhmW+pEqYOqHMm/s7X8d4assrizXT56PkZ
         f0KgFpmrW1PlwJpqY2PevV3Caf5Cfc2o7gdtmuM7tuKSAiPaqg5fdPUZ5xbXEIivjDt8
         YqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306420; x=1758911220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0/YAjgWUGKSiQA01R+laVJ6Ma6BYktx0e7jNRZ8vT4=;
        b=wgQyTUhNNgg/VgOF6VryIdS4bjGbrOnfNPEbSvSyw+763z3+WlG4NEdXKP1X5aU25U
         U2KsOiLDYP//GUJfg7orZRa+Dt38+jJRnXbpuutnaH+NlucvDQa8vzB80ib//TBz7OOi
         sC4kMUTcVopSf8eq+zaXGcpSXHuYZ+bBuK5y18hOj8YOhB6Vs2+q7F/OUwuCWm2PxjRV
         QvkUzLkGIDvibJLLAoo76kO5WCfjJPU/3SIWB0eBTht4lRZg5CDSC1VmhjJZAciZguOX
         bVV05lewea0R0U4il9nFhdywerWOBo015ElWDWHNUtqisJ+4HS0HiFKg/aFV11tA/XuH
         MP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzHxew5fP9PvyuG86MA99EhQc7aI1hpmDQqlEhlM9qIAQltyWufhPbHYi69cO1eX6NmHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaSYZf0Io4qHIdpTK7rqFTqkbjsTN1kYBARvcsWIWA/kTYNKV
	TkLuGYFJT6p4sPwoNYLZ7heW1LZG1RHHeqNRiaTUJuml3DcQ+Cs6H7p6clUd3KVxJUS7tPSirEG
	TAbK9PhXofhxPdsvBePkVCOgVAyZ3/Ws=
X-Gm-Gg: ASbGncsnygbuBB3R+TUCORv1eK/Q9sSl5qAVfj/tqbGxnq9UoG1Iybfgf2Q2PmtKID1
	5d/nVFGBwVIIa/19pXhiy2BVjEJ9KPtKNRQhc21pKpzGEwMJJJ/T+tEJgb+u+afI04ZYT+xXw00
	JdoDYoZ66R/6mODsD0wZ85k7mV7AOOixTERBQ8miH6ul4ZAb4dg2BJN7+kYgLf9gXH40RWl0GLL
	5eVUXUHkxqPZCYt6Ml0BGU=
X-Google-Smtp-Source: AGHT+IE72LDjUt8YUQAOJMsjVf5cV82LRH5htIcXBYXbdQ0h+d00g6OJmDg2E9EqJuEaU2g+WHtOwOLYF7mXsHBnpAE=
X-Received: by 2002:a05:600c:8b4b:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-467e7f7d89dmr36802945e9.13.1758306419781; Fri, 19 Sep 2025
 11:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-6-a.s.protopopov@gmail.com> <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
 <aM0AuFAnqGJgI0Kf@mail.gmail.com> <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
In-Reply-To: <6f9b59010382d1410ecad7d03f36ce44702ed1e5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 11:26:46 -0700
X-Gm-Features: AS18NWDw6oL6dTxZvr-6ojBfI-ZRvi6AEEeGgPEv2utoJwSy5jp_4deL2yE-K24
Message-ID: <CAADnVQKsZnOXo-+sK-+=aov80WLgouVPbUXvdg8Na9uU-CmCew@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-09-19 at 07:05 +0000, Anton Protopopov wrote:
> > On 25/09/18 11:35PM, Eduard Zingerman wrote:
> > > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > >
> > > [...]
> > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index a7ad4fe756da..5c1e4e37d1f8 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier=
_env *env)
> > > >   struct bpf_insn *insn;
> > > >   void *old_bpf_func;
> > > >   int err, num_exentries;
> > > > + int old_len, subprog_start_adjustment =3D 0;
> > > >
> > > >   if (env->subprog_cnt <=3D 1)
> > > >           return 0;
> > > > @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier=
_env *env)
> > > >           func[i]->aux->func_idx =3D i;
> > > >           /* Below members will be freed only at prog->aux */
> > > >           func[i]->aux->btf =3D prog->aux->btf;
> > > > -         func[i]->aux->subprog_start =3D subprog_start;
> > > > +         func[i]->aux->subprog_start =3D subprog_start + subprog_s=
tart_adjustment;
> > > >           func[i]->aux->func_info =3D prog->aux->func_info;
> > > >           func[i]->aux->func_info_cnt =3D prog->aux->func_info_cnt;
> > > >           func[i]->aux->poke_tab =3D prog->aux->poke_tab;
> > > > @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifie=
r_env *env)
> > > >           func[i]->aux->might_sleep =3D env->subprog_info[i].might_=
sleep;
> > > >           if (!i)
> > > >                   func[i]->aux->exception_boundary =3D env->seen_ex=
ception;
> > > > +
> > > > +         /*
> > > > +          * To properly pass the absolute subprog start to jit
> > > > +          * all instruction adjustments should be accumulated
> > > > +          */
> > > > +         old_len =3D func[i]->len;
> > > >           func[i] =3D bpf_int_jit_compile(func[i]);
> > > > +         subprog_start_adjustment +=3D func[i]->len - old_len;
> > > > +
> > > >           if (!func[i]->jited) {
> > > >                   err =3D -ENOTSUPP;
> > > >                   goto out_free;
> > >
> > > This change makes sense, however, would it be possible to move
> > > bpf_jit_blind_constants() out from jit to verifier.c:do_check,
> > > somewhere after do_misc_fixups?
> > > Looking at the source code, bpf_jit_blind_constants() is the first
> > > thing any bpf_int_jit_compile() does.
> > > Another alternative is to add adjust_subprog_starts() call to this
> > > function. Wdyt?
> >
> > Yes, it makes total sense. Blinding was added to x86 jit initially and =
then
> > every other jit copy-pasted it.  I was considering to move blinding up =
some
> > time back (see https://lore.kernel.org/bpf/20250318143318.656785-1-asps=
k@isovalent.com/),
> > but then I've decided to avoid this, as this requires to patch every JI=
T, and I
> > am not sure what is the way to test such a change (any hints?)
>
> We have the following covered by CI:
> - arch/x86/net/bpf_jit_comp.c
> - arch/s390/net/bpf_jit_comp.c
> - arch/arm64/net/bpf_jit_comp.c
>
> People work on these jits actively:
> - arch/riscv/net/bpf_jit_core.c
> - arch/loongarch/net/bpf_jit.c
> - arch/powerpc/net/bpf_jit_comp.c
>
> So, we can probably ask to test the patch-set.
>
> The remaining are:
> - arch/x86/net/bpf_jit_comp32.c
> - arch/parisc/net/bpf_jit_core.c
> - arch/mips/net/bpf_jit_comp.c
> - arch/arm/net/bpf_jit_32.c
> - arch/sparc/net/bpf_jit_comp_64.c
> - arch/arc/net/bpf_jit_core.c
>
> The change to each individual jit is not complicated, just removing
> the transformation call. Idk, I'd just go for it.
> Maybe Alexei has concerns?

No concerns.
I don't remember why JIT calls it instead of the verifier.

Daniel,
do you recall? Any concern?

