Return-Path: <bpf+bounces-16980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C7807F2B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCAD1F21133
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035874C7D;
	Thu,  7 Dec 2023 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8vdEPaq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54F10E9
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 19:30:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1c8512349dso52356066b.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 19:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701919824; x=1702524624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDq6sy+vUrAT1en8Oi5jrQDUJ37HJQ1tdzilEY0VUWY=;
        b=I8vdEPaqZ5j31mNXfqbgATAXCb5CUCaYRAeOdIYzt/s381I0PslXAMArMq5WapoLOT
         CcgvsPbfJA2vVaHcynRiRYyyH8+Typu+GIzUNN/h2VoBcETVlptKyXibI8j/2fh4hyGp
         cQxaC7dnJjfFcSBYkMVhtrWdBf7wG5Pdfr5KW6sNd7C50rr5QJ1CabFqkoGYvLrJ6baV
         4V5MPbjhyUCNvP3/p1FLwjoCAg0OtCWX8FWEJthECH9cUa04llbq3uyg5Rnraiqhb24F
         l1Fndi5P//9ut4H1nPpM6zfQfMXJR8qIgSt31ru7aaSlRFhVMGuUZ1b1Jrro0RKsLMEk
         /Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701919824; x=1702524624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDq6sy+vUrAT1en8Oi5jrQDUJ37HJQ1tdzilEY0VUWY=;
        b=cGneYRD9S1XOteLRviZnrLuowDSihM+JNeJNBostr5sIiLscHfiHcVpZ89SRvTFxAm
         bB2uhF9QEESkFAIZSCguiffoKoeNFuQ37jn4nv+VHYM/uls6J70MZIVVWVJhKhP5Y+Tq
         xgxWn1bmGfTbopZ0pUxJx70ZTn1VT1BMrNmDgNSyuu8lX+CxudO60vdk6gRikKrhqFBI
         EZJCyswEr87Nm0gZ97I6Q83od6gpBzsIDUgiCYssPgQ2noSbxoa3cxmZMNAGBC6HuzV0
         vMch+8Bc8i2IxMV9BaK40MK68BJN7eidCzr8u6vQpkgI97P4tpJ/XTIgIPRp2bPmuRrK
         Nm7A==
X-Gm-Message-State: AOJu0Yw255wAc5IMFx8eehE9yuA6o2eiHWZGDlxxhLq32Vvf2yqWg5cY
	BYMXeZQ1+lco0RDqkwnAUNpw0saSo2ybhN4BF0ajhJ7Ivy9RIw==
X-Google-Smtp-Source: AGHT+IHSu1fUUA57rNTYdKM75VDluJwrAj+x2sIctV/X3Hm33FhstotdSfekr58XrIRoBIpMunYXbOnvDGBH3TLzMJI=
X-Received: by 2002:a17:907:2988:b0:a1a:bb89:e2ef with SMTP id
 eu8-20020a170907298800b00a1abb89e2efmr885036ejc.16.1701919823564; Wed, 06 Dec
 2023 19:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206165802.380626-1-andreimatei1@gmail.com>
 <20231206165802.380626-2-andreimatei1@gmail.com> <CAEf4BzZ_bRO+OjfdA0b_L5iMYnMRMB6kUMgReifRCvBBgDFbXw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ_bRO+OjfdA0b_L5iMYnMRMB6kUMgReifRCvBBgDFbXw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Wed, 6 Dec 2023 22:30:12 -0500
Message-ID: <CABWLsesWogeUmXV640-eU2-wijiCBuTiKRcBoTaGwXE14HhkdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: fix verification of indirect var-off
 stack access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 1:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 6, 2023 at 8:58=E2=80=AFAM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > This patch fixes a bug around the verification of possibly-zero-sized
> > stack accesses. When the access was done through a var-offset stack
> > pointer, check_stack_access_within_bounds was incorrectly computing the
> > maximum-offset of a zero-sized read to be the same as the register's mi=
n
> > offset. Instead, we have to take in account the register's maximum
> > possible value. The patch also simplifies how the max offset is checked=
;
> > the check is now simpler than for min offset.
> >
> > The bug was allowing accesses to erroneously pass the
> > check_stack_access_within_bounds() checks, only to later crash in
> > check_stack_range_initialized() when all the possibly-affected stack
> > slots are iterated (this time with a correct max offset).
> > check_stack_range_initialized() is relying on
> > check_stack_access_within_bounds() for its accesses to the
> > stack-tracking vector to be within bounds; in the case of zero-sized
> > accesses, we were essentially only verifying that the lowest possible
> > slot was within bounds. We would crash when the max-offset of the stack
> > pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> > not something anyone's code attempts to do in practice).
> >
> > Thanks Hao for reporting!
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> > Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1F=
Pxmkgb0Os_frnHiNdw@mail.gmail.com/
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 14 +++------
> >  .../selftests/bpf/progs/verifier_var_off.c    | 29 +++++++++++++++++++
> >  2 files changed, 33 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e5ce530641ba..137240681fa9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6620,10 +6620,7 @@ static int check_stack_access_within_bounds(
> >
> >         if (tnum_is_const(reg->var_off)) {
> >                 min_off =3D reg->var_off.value + off;
> > -               if (access_size > 0)
> > -                       max_off =3D min_off + access_size - 1;
> > -               else
> > -                       max_off =3D min_off;
> > +               max_off =3D min_off + access_size;
> >         } else {
> >                 if (reg->smax_value >=3D BPF_MAX_VAR_OFF ||
> >                     reg->smin_value <=3D -BPF_MAX_VAR_OFF) {
> > @@ -6632,15 +6629,12 @@ static int check_stack_access_within_bounds(
> >                         return -EACCES;
> >                 }
> >                 min_off =3D reg->smin_value + off;
> > -               if (access_size > 0)
> > -                       max_off =3D reg->smax_value + off + access_size=
 - 1;
> > -               else
> > -                       max_off =3D min_off;
> > +               max_off =3D reg->smax_value + off + access_size;
> >         }
> >
> >         err =3D check_stack_slot_within_bounds(min_off, state, type);
> > -       if (!err)
> > -               err =3D check_stack_slot_within_bounds(max_off, state, =
type);
> > +       if (!err && max_off > 0)
> > +               err =3D -EINVAL; /* out of stack access into non-negati=
ve offsets */
> >
>
> this part looks good to me, please add my ack on resubmission
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> >         if (err) {
> >                 if (tnum_is_const(reg->var_off)) {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/too=
ls/testing/selftests/bpf/progs/verifier_var_off.c
> > index 83a90afba785..9fb32b292017 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> > @@ -224,6 +224,35 @@ __naked void access_max_out_of_bound(void)
> >         : __clobber_all);
> >  }
> >
> > +/* Similar to the test above, but this time check the special case of =
a
> > + * zero-sized stack access. We used to have a bug causing crashes for =
zero-sized
> > + * out-of-bounds accesses.
> > + */
> > +SEC("socket")
> > +__description("indirect variable-offset stack access, zero-sized, max =
out of bound")
> > +__failure __msg("invalid variable-offset indirect access to stack R1")
> > +__naked void zero_sized_access_max_out_of_bound(void)
>
> as Eduard mentioned, please split off selftests from kernel-side changes
>
> > +{
> > +       asm volatile ("                     \
> > +       r0 =3D 0;                             \
> > +       /* Fill some stack */               \
> > +       *(u64*)(r10 - 16) =3D r0;             \
> > +       *(u64*)(r10 - 8) =3D r0;              \
> > +       /* Get an unknown value */          \
> > +       r1 =3D *(u32*)(r1 + 0);               \
> > +       r1 &=3D 64;                           \
>
> did you mean 63 here? and if yes, why does the test work? :)

I did mean 63, thanks. But the test worked either way, not much difference.
`r1 &=3D 64` gives you a positive value that's either 0 or 64 (i.e. all the=
 bits
except one are known), so for the relevant verification code path, it's pre=
tty
equivalent to [0, 64) -- all that matters are the bounds.


>
> > +       r1 +=3D -16;                          \
> > +       /* r1 is now anywhere in [-16,48)*/ \
>
> nit: space before */ ?
>
> > +       r1 +=3D r10;                          \
> > +       r2 =3D 0;                             \
> > +       r3 =3D 0;                             \
> > +       call %[bpf_probe_read_kernel];      \
> > +       exit;                               \
> > +"      :
> > +       : __imm(bpf_probe_read_kernel)
> > +       : __clobber_all);
> > +}
> > +
> >  SEC("lwt_in")
> >  __description("indirect variable-offset stack access, min out of bound=
")
> >  __failure __msg("invalid variable-offset indirect access to stack R2")
> > --
> > 2.39.2
> >

