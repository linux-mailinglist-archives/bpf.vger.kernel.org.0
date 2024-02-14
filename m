Return-Path: <bpf+bounces-21929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D38540D4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2521C20F99
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB56372;
	Wed, 14 Feb 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Sd5Zm6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F7F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870430; cv=none; b=GgcTYccEJV8TI0PNeQaUJj8C/AxSycOS09IWTG71+gQenNGPf01L2xl6WFNyKfB4LoKquIGBw0vfFjgwiKhqpBYRDfceVOlT1n5EZnOF05Ah3xy+mxeFdhe+V3KPkI0tgLMsNqrraFv3rz64bHdUJKvYBp57aG8sQ3Je3/lkEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870430; c=relaxed/simple;
	bh=1yXe7/qI/X66XG8dQLUmHKsXtb1FQAfeeVoq0fu2BKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBjj1oiPE/sjapSlsHQOZOZF9OFNR41VKbW/95O6wWIQzSCBVI76PQajZNUs8IwnnhOgcoPX3LGZTrImdn52Cu5fhWK6+lYTshY2cNzMeQyWSPs6oJqX7Uc0oRzycg/js8Vh735tRfjm/v3RCoCYuBG2qR3/t2cPEDXmfy6en04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Sd5Zm6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33cec911a31so20912f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707870426; x=1708475226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVrq6nMRBsw/SGkOy5fHBOuY1ivCN4ZLbbWxk/mKrsY=;
        b=E5Sd5Zm6cRpnpoY3j80iWupXMTNrsGVdkXHUoXoWnHtm3x59lW+a3NIpWyzsdBfPpf
         WHzS5SC1U96dDHbclxE67cEhAwqNwVgml0HdzO+EG3o8TMNzBMitRyxEyD9aAx0JGUDg
         s018phcr7SjiBQp90SaFmkxvZx1lVxBuAyJ+uyqk9vGW5T3AKvQvf5fkzU32VW+XOWFE
         L33p81wo4T/plc0AvDptI77oqw4whrKVw5g5HiAtF0q/HjCzHO4asLd8VZG5czPJWVHS
         B5wE8izkKtaLmiYOjmhrAOkDuOrKNxDR/blfJahXIThgZnveo68PGmjGIc8q6SUE/O5w
         E/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707870426; x=1708475226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVrq6nMRBsw/SGkOy5fHBOuY1ivCN4ZLbbWxk/mKrsY=;
        b=N745LVyCwAZcqjcag9Ex4MWvbBl96SDR6anv7uLLhqefVzrlZ5EeMN6g/k6hPbY+D9
         Wsc4WM62l6jBKfNU+QbZBTZPojE2p8KuRPlPNmE0INzJK4m7m4NGEYG68HhE3mv5KyqM
         A+6XFinKaNHKHe3hA0JsukxJTn0m3tJ0aTd9gWlnNQ9oB7IFviR9grKjYZbjdVyqhLww
         CWtWVcuwIEcia7fK2lLTeyT0V5IhlOgn01mEtu2yzcMpO1k2Cj+J5cxpRifN9H44My3C
         fml09HHitEK416MHrTkY88kV+OwY7JMHFPiZGumEVVaT7SOvyMqItMaOf2ipflfPTXSC
         qoOA==
X-Gm-Message-State: AOJu0Yxzk+VNJTFopziKGbFSmqPAP4/ln8rM2lJhZtlhIZMgQcxpjsB5
	9n9IENyMdbHY11szMH4kfwt+FnUsi3HgVPmL46W763nCH43l+sSeyLix3mLCOmpA6bu2v7OKhDJ
	7zwmKYHc0xKKcU1xNOJhdGowa1yvC9bLUyGY=
X-Google-Smtp-Source: AGHT+IFtyZUy3+7EA2UHfKG8+DSkPiPYZ9UHx9q8LeHkfS6JPgv+2WDYOOe2UVDXEqU0hmxu7JtEk6wVk/v3n61Lojo=
X-Received: by 2002:a5d:6ac5:0:b0:33c:e32f:fb7e with SMTP id
 u5-20020a5d6ac5000000b0033ce32ffb7emr471037wrw.2.1707870426098; Tue, 13 Feb
 2024 16:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-11-alexei.starovoitov@gmail.com> <CAEf4Bzb=G=S3=bqxSHRLO+zd+EjbqyPcMgXBWGEiC_29rdBXSQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb=G=S3=bqxSHRLO+zd+EjbqyPcMgXBWGEiC_29rdBXSQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 16:26:54 -0800
Message-ID: <CAADnVQJuEWbYOe+i5Cgzhp4YnfozAuWZZx5cr0exGEjR66tYsA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/20] bpf: Recognize btf_decl_tag("arg:arena")
 as PTR_TO_ARENA.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 8:06=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > In global bpf functions recognize btf_decl_tag("arg:arena") as PTR_TO_A=
RENA.
> >
> > Note, when the verifier sees:
> >
> > __weak void foo(struct bar *p)
> >
> > it recognizes 'p' as PTR_TO_MEM and 'struct bar' has to be a struct wit=
h scalars.
> > Hence the only way to use arena pointers in global functions is to tag =
them with "arg:arena".
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf.h   |  1 +
> >  kernel/bpf/btf.c      | 19 +++++++++++++++----
> >  kernel/bpf/verifier.c | 15 +++++++++++++++
> >  3 files changed, 31 insertions(+), 4 deletions(-)
> >
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5eeb9bf7e324..fa49602194d5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9348,6 +9348,18 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
> >                                 bpf_log(log, "arg#%d is expected to be =
non-NULL\n", i);
> >                                 return -EINVAL;
> >                         }
> > +               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_A=
RENA) {
> > +                       /*
> > +                        * Can pass any value and the kernel won't cras=
h, but
> > +                        * only PTR_TO_ARENA or SCALAR make sense. Ever=
ything
> > +                        * else is a bug in the bpf program. Point it o=
ut to
> > +                        * the user at the verification time instead of
> > +                        * run-time debug nightmare.
> > +                        */
> > +                       if (reg->type !=3D PTR_TO_ARENA && reg->type !=
=3D SCALAR_VALUE) {
>
> the comment above doesn't explain why it's ok to pass SCALAR_VALUE. Is
> it because PTR_TO_ARENA will become SCALAR_VALUE after some arithmetic
> operations and we don't want to regress user experience? If that's the
> case, what's the way for user to convert SCALAR_VALUE back to
> PTR_TO_ARENA without going through global subprog? bpf_cast_xxx
> instruction through assembly?

bpf_cast_xx inline asm should never be used.
It's for selftests only until llvm 19 is released and in distros.
The scalar_value can come in lots of cases.
Any pointer dereference returns scalar.
Most of the time all arena math is on scalars.
Scalars are passed into global and static funcs and
become ptr_to_arena right before LDX/STX through that pointer.
Sometime llvm still does a bit of math after scalar became ptr_to_arena,
hence needs_zext flag to downgrade alu64 to alu32.
In these selftests that produce non trivial bpf progs
there are 4 such insns that needs_zext in arena_htab.bpf.o.
Also 23 cast_kern, zero cast_user,
and 57 ldx/stx from arena.

>
> > +                               bpf_log(log, "R%d is not a pointer to a=
rena or scalar.\n", regno);
> > +                               return -EINVAL;
> > +                       }
> >                 } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | ME=
M_RDONLY)) {
> >                         ret =3D process_dynptr_func(env, regno, -1, arg=
->arg_type, 0);
> >                         if (ret)
> > @@ -20329,6 +20341,9 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
> >                                 reg->btf =3D bpf_get_btf_vmlinux(); /* =
can't fail at this point */
> >                                 reg->btf_id =3D arg->btf_id;
> >                                 reg->id =3D ++env->id_gen;
> > +                       } else if (base_type(arg->arg_type) =3D=3D ARG_=
PTR_TO_ARENA) {
> > +                               /* caller can pass either PTR_TO_ARENA =
or SCALAR */
> > +                               mark_reg_unknown(env, regs, i);
>
> shouldn't we set the register type to PTR_TO_ARENA here?

No. It has to be scalar.
It's not ok to deref it with kern_vm_base yet.
It's a full 64-bit value here and upper 32-bit are likely correct user_vm_s=
tart.

Hence my struggle with this __arg_arena feature, since it's really for
the verifier not to complain at the call site only.

