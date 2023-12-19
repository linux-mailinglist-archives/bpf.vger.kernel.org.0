Return-Path: <bpf+bounces-18341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B6A81910B
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D20BB240AD
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC53985A;
	Tue, 19 Dec 2023 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmIkF6hX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A91CA8E
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-552fba34d69so4658682a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703015647; x=1703620447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8HxZLxA7T+6gGrSKdZToUUdg0jhT+Fw8EtquP4DxEc=;
        b=DmIkF6hXi1kVGI8cvIYvEmWc/OheQseHnOLVbVP9CVY+HBV/EBTexnZxol5v9Tl7RH
         bOjs2xxp56m8ws0WOtYpqok97SZ2W+IPz6ufyYEN1yyfCpOAPmzSVdLXp4APeK1UVRux
         N4vEPV2JwbsEe0UD+SlJRJnyV+sk7fiYiw7/rqUliw2NJp8kUs7GDgFXS9wUcqPJJ3hg
         nGz3xhOqaMJv1ES54x5kRavV5JAJsummrndwsLRqbDPDeirdmC3vFM6SSTYbr0i2I9kt
         SaIVzUDV1EXP1u5IsScNxfw3FfI8LrJtLT6ZrssOuuZcfak3p1tDGBZyEl7OeMqeBOzr
         MdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015647; x=1703620447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8HxZLxA7T+6gGrSKdZToUUdg0jhT+Fw8EtquP4DxEc=;
        b=CZcDTZOm87ov4eaManJKiYe4NO7dbsLqQMxl59UC1iWrQ+PHC35sU70LI1t3f9EFZm
         6syrtxcGlY37iLWNqDWyBPs+i++KppVRUNtyDFzrR5kicVmrxDwA0c6yZm7BgjPPo751
         qTRWhXZcODu0/VCEUbmdWE3xPo1bzmkxdKLjN2irw3QQiatobz7zk+laPPgwBs9I2ZYN
         FkNIK6EaOKAVO7Szu7BV+NCMmd7/N4VXd+4Nvms9fhOKBd3ptNKcL/C+T4DuPRxwI1Bw
         ec5QAtoMk/2HclnTC/235j9T5TbyxvvL3uPshO/WiHBsq7qL8VHSsZak00Rl2PD564R1
         /KIw==
X-Gm-Message-State: AOJu0Yzu+By1nCNzS0hHmusOUSzLKGyCpQRvI7msLFglW8SNZWOAJyOs
	Dqnd+ccqsjwOa6vNmJYvnKxVP+vxRSUTJ48Kmpg=
X-Google-Smtp-Source: AGHT+IFh95ZYLv4Kir65NPIDrvZA/gMNz7TJhW3fgH7zLmV5QBrskfo9nnXWSiRDwmmN6A6UejteRfcvW4nSlDG/WkQ=
X-Received: by 2002:a50:9fe6:0:b0:552:fd38:a9fa with SMTP id
 c93-20020a509fe6000000b00552fd38a9famr3540599edf.8.1703015646667; Tue, 19 Dec
 2023 11:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <CAEf4BzaHytYzZoV4wjapvJ1H87XJcM7WizEOfix02ZYJmxLCwQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaHytYzZoV4wjapvJ1H87XJcM7WizEOfix02ZYJmxLCwQ@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Tue, 19 Dec 2023 14:53:54 -0500
Message-ID: <CABWLseuEBqu5Ty=LdhnUVyGOqySaCRXNjjT5A7bcgQoKWLfP0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Dec 16, 2023 at 5:07=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > This patch simplifies the verification of size arguments associated to
> > pointer arguments to helpers and kfuncs. Many helpers take a pointer
> > argument followed by the size of the memory access performed to be
> > performed through that pointer. Before this patch, the handling of the
> > size argument in check_mem_size_reg() was confusing and wasteful: if th=
e
> > size register's lower bound was 0, then the verification was done twice=
:
> > once considering the size of the access to be the lower-bound of the
> > respective argument, and once considering the upper bound (even if the
> > two are the same). The upper bound checking is a super-set of the
> > lower-bound checking(*), except: the only point of the lower-bound chec=
k
> > is to handle the case where zero-sized-accesses are explicitly not
> > allowed and the lower-bound is zero. This static condition is now
> > checked explicitly, replacing a much more complex, expensive and
> > confusing verification call to check_helper_mem_access().
> >
> > Now that check_mem_size_reg() deals directly with the zero_size_allowed
> > checking, the single remaining call to check_helper_mem_access() can
> > pass a static value for the zero_size_allowed arg, instead of
> > propagating a dynamic one. I think this is an improvement, as tracking
> > the wide propagation of zero_sized_allowed is already complicated.
> >
> > This patch also results in better error messages for rejected zero-size
> > reads. Before, the message one would get depended on the type of the
> > pointer and on other conditions, and sometimes the message was plain
> > wrong: in some tests that changed you'll see that the old message was
> > something like "R1 min value is outside of the allowed memory range",
> > where R1 is the pointer register; the error was wrongly claiming that
> > the pointer was bad instead of the size being bad. Other times the
> > information that the size came for a register with a possible range of
> > values was wrong, and the error presented the size as a fixed zero.
> >
> > (*) Besides standing to reason that the checks for a bigger size access
> > are a super-set of the checks for a smaller size access, I have also
> > mechanically verified this by reading the code for all types of
> > pointers. I could convince myself that it's true for all but
> > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > line-by-line does not immediately prove what we want. If anyone has any
> > qualms, let me know.
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 85 +++++++++++++++++--
> >  .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++-
> >  .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
> >  3 files changed, 120 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1863826a4ac3..cf2a09408bdc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7256,6 +7256,65 @@ static int check_helper_mem_access(struct bpf_ve=
rifier_env *env, int regno,
> >         }
> >  }
> >
> > +/* Helper function for logging an error about an invalid attempt to pe=
rform a
> > + * (possibly) zero-sized memory access. The pointer being dereferenced=
 is in
> > + * register @ptr_regno, and the size of the access is in register @siz=
e_regno.
> > + * The size register is assumed to either be a constant zero or have a=
 zero lower
> > + * bound.
> > + *
> > + * Logs a message like:
> > + * invalid zero-size read. Size comes from R2=3D0. Attempting to deref=
erence *map_value R1: off=3D[0,4] value_size=3D48
> > + */
> > +static void log_zero_size_access_err(struct bpf_verifier_env *env,
> > +                             int ptr_regno,
> > +                             int size_regno)
> > +{
> > +       struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[ptr_regno];
> > +       struct bpf_reg_state *size_reg =3D &cur_regs(env)[size_regno];
> > +       const bool size_is_const =3D tnum_is_const(size_reg->var_off);
> > +       const char *ptr_type_str =3D reg_type_str(env, ptr_reg->type);
> > +       /* allocate a few buffers to be used as parts of the error mess=
age */
> > +       char size_range_buf[64] =3D {0}, max_size_buf[64] =3D {0}, off_=
buf[64] =3D {0};
>
> this is quite a lot of stack usage, adding this on top of all the
> other stuff we have feels a bit bad

I could be less wasteful and have a single, smaller buffer.
But do we really care for a leaf function?

>
> > +       s64 min_off, max_off;
> > +       if (!size_is_const) {
> > +               snprintf(size_range_buf, sizeof(size_range_buf),
> > +                       "[0,%lld]", size_reg->umax_value);
> > +       }
> > +
> > +       if (tnum_is_const(ptr_reg->var_off)) {
> > +               min_off =3D (s64)ptr_reg->var_off.value + ptr_reg->off;
> > +               snprintf(off_buf, sizeof(off_buf), "%lld", min_off);
> > +       } else {
> > +               min_off =3D ptr_reg->smin_value + ptr_reg->off;
> > +               max_off =3D ptr_reg->smax_value + ptr_reg->off;
> > +               snprintf(off_buf, sizeof(off_buf), "[%lld,%lld]", min_o=
ff, max_off);
> > +       }
> > +
> > +       /* attempt to figure out info about the maximum offset that cou=
ld be allowed */
> > +       switch (ptr_reg->type) {
> > +       case PTR_TO_MAP_KEY:
> > +               snprintf(max_size_buf, sizeof(max_size_buf), "key_size=
=3D%d", ptr_reg->map_ptr->key_size);
> > +               break;
> > +       case PTR_TO_MAP_VALUE:
> > +               snprintf(max_size_buf, sizeof(max_size_buf), "value_siz=
e=3D%d", ptr_reg->map_ptr->value_size);
> > +               break;
> > +       case PTR_TO_PACKET:
> > +       case PTR_TO_PACKET_META:
> > +               snprintf(max_size_buf, sizeof(max_size_buf), "packet_si=
ze=3D%d", ptr_reg->range);
> > +               break;
> > +       case PTR_TO_MEM:
> > +       default:
> > +               snprintf(max_size_buf, sizeof(max_size_buf), "max_size=
=3DN/A");
>
> we do know the size, reg->mem_size contains addressable memory range
> size for PTR_TO_MEM
>
> > +       }
> > +
> > +       verbose(env, "invalid %szero-size read. Size comes from R%d=3D%=
s. "
> > +               "Attempting to dereference *%s R%d: off=3D%s %s\n",
> > +               size_is_const ? "" : "possibly ",
> > +               size_regno, size_is_const ? "0" : size_range_buf,
> > +               ptr_type_str, ptr_regno, off_buf, max_size_buf);
> > +}
> > +
> > +
> >  /* verify arguments to helpers or kfuncs consisting of a pointer and a=
n access
> >   * size.
> >   *
> > @@ -7268,6 +7327,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >                               struct bpf_call_arg_meta *meta)
> >  {
> >         int err;
> > +       const bool size_is_const =3D tnum_is_const(reg->var_off);
> >
> >         /* This is used to refine r0 return value bounds for helpers
> >          * that enforce this value as an upper bound on return values.
> > @@ -7282,7 +7342,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >         /* The register is SCALAR_VALUE; the access check
> >          * happens using its boundaries.
> >          */
> > -       if (!tnum_is_const(reg->var_off))
> > +       if (!size_is_const)
> >                 /* For unprivileged variable accesses, disable raw
> >                  * mode so that the program is required to
> >                  * initialize all the memory that the helper could
> > @@ -7296,12 +7356,9 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                 return -EACCES;
> >         }
> >
> > -       if (reg->umin_value =3D=3D 0) {
> > -               err =3D check_helper_mem_access(env, regno - 1, 0,
> > -                                             zero_size_allowed,
> > -                                             meta);
> > -               if (err)
> > -                       return err;
> > +       if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> > +               log_zero_size_access_err(env, regno-1, regno);
> > +               return -EACCES;
> >         }
> >
> >         if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> > @@ -7309,9 +7366,21 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                         regno);
> >                 return -EACCES;
> >         }
> > +       /* If !zero_size_allowed, we already checked that umin_value > =
0, so
> > +        * umax_value should also be > 0.
> > +        */
> > +       if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> > +               verbose(env, "verifier bug: !zero_size_allowed should h=
ave been handled already\n");
> > +               return -EFAULT;
> > +       }
> >         err =3D check_helper_mem_access(env, regno - 1,
> >                                       reg->umax_value,
> > -                                     zero_size_allowed, meta);
> > +                                     /* zero_size_allowed: we asserted=
 above that umax_value is
> > +                                      * not zero if !zero_size_allowed=
, so we don't need any
> > +                                      * further checks.
> > +                                      */
> > +                                     true ,
>
> if this is the last remaining call, why even have this true parameter
> instead of assuming zero_size_allowed  inside
> check_helper_mem_access() ?

This is the last remaining call to check_helper_mem_access()
in this function, but not globally. There
are many other calls to check_helper_mem_access(),
and some pass `false`. E.g. [1]. Btw, I did generally try to get
a better code structure that would not require this zero_size_allowed
in a million places, but so far failed.

[1] https://github.com/torvalds/linux/blob/ee5cc0363ea0d587f62349ff3b3e2dfa=
751832e4/kernel/bpf/verifier.c#L4279

>
> nit: dangling space
>
> > +                                     meta);
> >         if (!err)
> >                 err =3D mark_chain_precision(env, regno);
> >         return err;
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_ac=
cess.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > index 692216c0ad3d..9fe10f63c931 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > @@ -89,9 +89,14 @@ l0_%=3D:       exit;                                =
           \
> >         : __clobber_all);
> >  }
> >
> > +/* Call a function taking a pointer and a size which doesn't allow the=
 size to
> > + * be zero (i.e. bpf_trace_printk() declares the second argument to be
> > + * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass zer=
o for the
> > + * size and expect to fail.
> > + */
> >  SEC("tracepoint")
> >  __description("helper access to map: empty range")
> > -__failure __msg("invalid access to map value, value_size=3D48 off=3D0 =
size=3D0")
> > +__failure __msg("invalid zero-size read. Size comes from R2=3D0. Attem=
pting to dereference *map_value R1: off=3D0 value_size=3D48")
>
> This comes from "BPF old-timer", so take it with a grain of salt, but
> current error doesn't feel too bad already and is quite
> understandable, tbh.
>
> In any case, let's split off the error formatting changes (they are
> quire big) from the check logic change and post it as two separate
> patches (they might be in a single patch set)

Just to clarify -- in v1 I had not done anything about error handling, and =
you
observed that some error messages now had less information than before (but=
,
for the record, at the same time some of the errors before were misleading =
or
even wrong because sometimes they didn't even reference the size register a=
nd
even when they did, they pretended that the size register was the constant
zero). In order to keep the information that the errors had before, somehow=
 the
type of pointer involved needs to be taken into account; the error needs to
look differently for different kinds of pointers. That's how I ended up goi=
ng
medieval and writing the error logging function. You don't seem enthused ab=
out
all the code that was required; neither was I. I spent some time looking ar=
ound
for something better and more code reuse. I've considered writing some more
generic register-printing functions because it seems to me that the verifie=
r
has too many duplicate and incomplete printing logic in error messages. But=
 in
the end I didn't come up with anything better.

Now, one might argue that getting a proper per-pointer-type was an advantag=
e of
calling check_helper_mem_access() twice -- so maybe this whole patch is
misguided. But then again, the error messages were not actually good, and a=
lso
I'd argue that it'd be a case of the tail wagging the dog to leave the
check_helper_mem_access() call for the benefit of the errors.

Having said all this, I definitely don't want to push unwanted code on you,=
 so
please confirm that you don't hate the error logging function or... somethi=
ng
else.

>
> >  __naked void access_to_map_empty_range(void)
> >  {
> >         asm volatile ("                                 \
>
> [...]

