Return-Path: <bpf+bounces-18489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD86681AE35
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 06:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26EB1C2288B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD88F69;
	Thu, 21 Dec 2023 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLcwuYoG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0009467
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2330a92ae6so42815366b.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 21:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703134815; x=1703739615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EWHi9BGs9aivEQycLHaY2v5QgCMI+ZxPrL21a6+PEE=;
        b=JLcwuYoGTBFFl5VHHlTa5ut17I2Hes18av9jYyWDbSUaUau7z8wG+3CuWhAfkXSRGv
         WH/sN2c3isrlFaPneh3FlhVmH0cJrqsNGU+CxzbcfN6ZQDI/xMyRfHzDkmg3Efmgt5Q4
         EpnoHJ/86D8qponwmWrULgaZOB7GUE/YzLlWEpfz5pHY+cF/eCtxGus7ZgEsSRdHJAdB
         VqsdjmRC+0BacXAp63oVlhKOtLvcUcmVS4/2Fm/EoI4O/LT3fh3FjpdlZoyeFU+BHkBX
         H5kTJkN8yVgTp7jSCohs2pFzRnH+OUjh63KgGerb3UpYLU5fs/sYuhySkLpE2V41uDu/
         Ms6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134815; x=1703739615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EWHi9BGs9aivEQycLHaY2v5QgCMI+ZxPrL21a6+PEE=;
        b=MBppMclHhU5O39TPJDEoNKWu/0VR5UQwTYycTKmeRDvvOIEuqbLmCwqtCaT7dAPCvN
         mDhjoxAuzjuSzfttfieMHfIHNtxP6tVod/JBZyDrMZ0wWioibKe/BtB9uLh2b+wOhY6s
         jJTlKQIA/sbk8/9zzDhbz2nRG8Z0380PQ51wqIEmVlTEObIndAnXxabuhNJg0NItLZd8
         T5EQf465F4HMNti55CKRvdM9XdI1PLsWBl6theoLz6xRrlJ9941amVCnCjUVEm1Ys3jY
         /G1YkO8zAuQ4qWrnMtAT784PC5ut96fVwdG0qMzc8gQaQhmmhF1775QTE67g3Le9ydZf
         xQtQ==
X-Gm-Message-State: AOJu0YySO1oerZCaaHipOk7D8tYzL93A2Ka6y4E5sNIqNJFQPq7PQKoT
	MxA0FIK/xmGVv48N/v9iobvHOYuEDbOWOaT9EKY=
X-Google-Smtp-Source: AGHT+IEPmxiHPtODHCSJeJfVtsfRNIzN4qD30qjmfo3cSopFqZiX6V2lCdhjQFWtggGz2noWmitp2fhKQPjinTIAivI=
X-Received: by 2002:a17:906:3849:b0:a19:a1ba:da2b with SMTP id
 w9-20020a170906384900b00a19a1bada2bmr10356712ejc.82.1703134814561; Wed, 20
 Dec 2023 21:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <CAEf4BzaHytYzZoV4wjapvJ1H87XJcM7WizEOfix02ZYJmxLCwQ@mail.gmail.com>
 <CABWLseuEBqu5Ty=LdhnUVyGOqySaCRXNjjT5A7bcgQoKWLfP0Q@mail.gmail.com>
In-Reply-To: <CABWLseuEBqu5Ty=LdhnUVyGOqySaCRXNjjT5A7bcgQoKWLfP0Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Dec 2023 21:00:01 -0800
Message-ID: <CAEf4BzbtMOe5PmUvdpCTsqQpWvvq1-G6X=ugY9_4FvN_12erwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:54=E2=80=AFAM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
>
> On Tue, Dec 19, 2023 at 2:03=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Dec 16, 2023 at 5:07=E2=80=AFPM Andrei Matei <andreimatei1@gmai=
l.com> wrote:
> > >
> > > This patch simplifies the verification of size arguments associated t=
o
> > > pointer arguments to helpers and kfuncs. Many helpers take a pointer
> > > argument followed by the size of the memory access performed to be
> > > performed through that pointer. Before this patch, the handling of th=
e
> > > size argument in check_mem_size_reg() was confusing and wasteful: if =
the
> > > size register's lower bound was 0, then the verification was done twi=
ce:
> > > once considering the size of the access to be the lower-bound of the
> > > respective argument, and once considering the upper bound (even if th=
e
> > > two are the same). The upper bound checking is a super-set of the
> > > lower-bound checking(*), except: the only point of the lower-bound ch=
eck
> > > is to handle the case where zero-sized-accesses are explicitly not
> > > allowed and the lower-bound is zero. This static condition is now
> > > checked explicitly, replacing a much more complex, expensive and
> > > confusing verification call to check_helper_mem_access().
> > >
> > > Now that check_mem_size_reg() deals directly with the zero_size_allow=
ed
> > > checking, the single remaining call to check_helper_mem_access() can
> > > pass a static value for the zero_size_allowed arg, instead of
> > > propagating a dynamic one. I think this is an improvement, as trackin=
g
> > > the wide propagation of zero_sized_allowed is already complicated.
> > >
> > > This patch also results in better error messages for rejected zero-si=
ze
> > > reads. Before, the message one would get depended on the type of the
> > > pointer and on other conditions, and sometimes the message was plain
> > > wrong: in some tests that changed you'll see that the old message was
> > > something like "R1 min value is outside of the allowed memory range",
> > > where R1 is the pointer register; the error was wrongly claiming that
> > > the pointer was bad instead of the size being bad. Other times the
> > > information that the size came for a register with a possible range o=
f
> > > values was wrong, and the error presented the size as a fixed zero.
> > >
> > > (*) Besides standing to reason that the checks for a bigger size acce=
ss
> > > are a super-set of the checks for a smaller size access, I have also
> > > mechanically verified this by reading the code for all types of
> > > pointers. I could convince myself that it's true for all but
> > > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > > line-by-line does not immediately prove what we want. If anyone has a=
ny
> > > qualms, let me know.
> > >
> > > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c                         | 85 +++++++++++++++++=
--
> > >  .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++-
> > >  .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
> > >  3 files changed, 120 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 1863826a4ac3..cf2a09408bdc 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7256,6 +7256,65 @@ static int check_helper_mem_access(struct bpf_=
verifier_env *env, int regno,
> > >         }
> > >  }
> > >
> > > +/* Helper function for logging an error about an invalid attempt to =
perform a
> > > + * (possibly) zero-sized memory access. The pointer being dereferenc=
ed is in
> > > + * register @ptr_regno, and the size of the access is in register @s=
ize_regno.
> > > + * The size register is assumed to either be a constant zero or have=
 a zero lower
> > > + * bound.
> > > + *
> > > + * Logs a message like:
> > > + * invalid zero-size read. Size comes from R2=3D0. Attempting to der=
eference *map_value R1: off=3D[0,4] value_size=3D48
> > > + */
> > > +static void log_zero_size_access_err(struct bpf_verifier_env *env,
> > > +                             int ptr_regno,
> > > +                             int size_regno)
> > > +{
> > > +       struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[ptr_regno];
> > > +       struct bpf_reg_state *size_reg =3D &cur_regs(env)[size_regno]=
;
> > > +       const bool size_is_const =3D tnum_is_const(size_reg->var_off)=
;
> > > +       const char *ptr_type_str =3D reg_type_str(env, ptr_reg->type)=
;
> > > +       /* allocate a few buffers to be used as parts of the error me=
ssage */
> > > +       char size_range_buf[64] =3D {0}, max_size_buf[64] =3D {0}, of=
f_buf[64] =3D {0};
> >
> > this is quite a lot of stack usage, adding this on top of all the
> > other stuff we have feels a bit bad
>
> I could be less wasteful and have a single, smaller buffer.
> But do we really care for a leaf function?
>

It's kernel, so that's at least a consideration, I think.

> >
> > > +       s64 min_off, max_off;
> > > +       if (!size_is_const) {
> > > +               snprintf(size_range_buf, sizeof(size_range_buf),
> > > +                       "[0,%lld]", size_reg->umax_value);
> > > +       }
> > > +
> > > +       if (tnum_is_const(ptr_reg->var_off)) {
> > > +               min_off =3D (s64)ptr_reg->var_off.value + ptr_reg->of=
f;
> > > +               snprintf(off_buf, sizeof(off_buf), "%lld", min_off);
> > > +       } else {
> > > +               min_off =3D ptr_reg->smin_value + ptr_reg->off;
> > > +               max_off =3D ptr_reg->smax_value + ptr_reg->off;
> > > +               snprintf(off_buf, sizeof(off_buf), "[%lld,%lld]", min=
_off, max_off);
> > > +       }
> > > +
> > > +       /* attempt to figure out info about the maximum offset that c=
ould be allowed */
> > > +       switch (ptr_reg->type) {
> > > +       case PTR_TO_MAP_KEY:
> > > +               snprintf(max_size_buf, sizeof(max_size_buf), "key_siz=
e=3D%d", ptr_reg->map_ptr->key_size);
> > > +               break;
> > > +       case PTR_TO_MAP_VALUE:
> > > +               snprintf(max_size_buf, sizeof(max_size_buf), "value_s=
ize=3D%d", ptr_reg->map_ptr->value_size);
> > > +               break;
> > > +       case PTR_TO_PACKET:
> > > +       case PTR_TO_PACKET_META:
> > > +               snprintf(max_size_buf, sizeof(max_size_buf), "packet_=
size=3D%d", ptr_reg->range);
> > > +               break;
> > > +       case PTR_TO_MEM:
> > > +       default:
> > > +               snprintf(max_size_buf, sizeof(max_size_buf), "max_siz=
e=3DN/A");
> >
> > we do know the size, reg->mem_size contains addressable memory range
> > size for PTR_TO_MEM
> >
> > > +       }
> > > +
> > > +       verbose(env, "invalid %szero-size read. Size comes from R%d=
=3D%s. "
> > > +               "Attempting to dereference *%s R%d: off=3D%s %s\n",
> > > +               size_is_const ? "" : "possibly ",
> > > +               size_regno, size_is_const ? "0" : size_range_buf,
> > > +               ptr_type_str, ptr_regno, off_buf, max_size_buf);
> > > +}
> > > +
> > > +
> > >  /* verify arguments to helpers or kfuncs consisting of a pointer and=
 an access
> > >   * size.
> > >   *
> > > @@ -7268,6 +7327,7 @@ static int check_mem_size_reg(struct bpf_verifi=
er_env *env,
> > >                               struct bpf_call_arg_meta *meta)
> > >  {
> > >         int err;
> > > +       const bool size_is_const =3D tnum_is_const(reg->var_off);
> > >
> > >         /* This is used to refine r0 return value bounds for helpers
> > >          * that enforce this value as an upper bound on return values=
.
> > > @@ -7282,7 +7342,7 @@ static int check_mem_size_reg(struct bpf_verifi=
er_env *env,
> > >         /* The register is SCALAR_VALUE; the access check
> > >          * happens using its boundaries.
> > >          */
> > > -       if (!tnum_is_const(reg->var_off))
> > > +       if (!size_is_const)
> > >                 /* For unprivileged variable accesses, disable raw
> > >                  * mode so that the program is required to
> > >                  * initialize all the memory that the helper could
> > > @@ -7296,12 +7356,9 @@ static int check_mem_size_reg(struct bpf_verif=
ier_env *env,
> > >                 return -EACCES;
> > >         }
> > >
> > > -       if (reg->umin_value =3D=3D 0) {
> > > -               err =3D check_helper_mem_access(env, regno - 1, 0,
> > > -                                             zero_size_allowed,
> > > -                                             meta);
> > > -               if (err)
> > > -                       return err;
> > > +       if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> > > +               log_zero_size_access_err(env, regno-1, regno);
> > > +               return -EACCES;
> > >         }
> > >
> > >         if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> > > @@ -7309,9 +7366,21 @@ static int check_mem_size_reg(struct bpf_verif=
ier_env *env,
> > >                         regno);
> > >                 return -EACCES;
> > >         }
> > > +       /* If !zero_size_allowed, we already checked that umin_value =
> 0, so
> > > +        * umax_value should also be > 0.
> > > +        */
> > > +       if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> > > +               verbose(env, "verifier bug: !zero_size_allowed should=
 have been handled already\n");
> > > +               return -EFAULT;
> > > +       }
> > >         err =3D check_helper_mem_access(env, regno - 1,
> > >                                       reg->umax_value,
> > > -                                     zero_size_allowed, meta);
> > > +                                     /* zero_size_allowed: we assert=
ed above that umax_value is
> > > +                                      * not zero if !zero_size_allow=
ed, so we don't need any
> > > +                                      * further checks.
> > > +                                      */
> > > +                                     true ,
> >
> > if this is the last remaining call, why even have this true parameter
> > instead of assuming zero_size_allowed  inside
> > check_helper_mem_access() ?
>
> This is the last remaining call to check_helper_mem_access()
> in this function, but not globally. There
> are many other calls to check_helper_mem_access(),
> and some pass `false`. E.g. [1]. Btw, I did generally try to get
> a better code structure that would not require this zero_size_allowed
> in a million places, but so far failed.
>
> [1] https://github.com/torvalds/linux/blob/ee5cc0363ea0d587f62349ff3b3e2d=
fa751832e4/kernel/bpf/verifier.c#L4279
>
> >
> > nit: dangling space
> >
> > > +                                     meta);
> > >         if (!err)
> > >                 err =3D mark_chain_precision(env, regno);
> > >         return err;
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_=
access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> > > index 692216c0ad3d..9fe10f63c931 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.=
c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.=
c
> > > @@ -89,9 +89,14 @@ l0_%=3D:       exit;                              =
             \
> > >         : __clobber_all);
> > >  }
> > >
> > > +/* Call a function taking a pointer and a size which doesn't allow t=
he size to
> > > + * be zero (i.e. bpf_trace_printk() declares the second argument to =
be
> > > + * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass z=
ero for the
> > > + * size and expect to fail.
> > > + */
> > >  SEC("tracepoint")
> > >  __description("helper access to map: empty range")
> > > -__failure __msg("invalid access to map value, value_size=3D48 off=3D=
0 size=3D0")
> > > +__failure __msg("invalid zero-size read. Size comes from R2=3D0. Att=
empting to dereference *map_value R1: off=3D0 value_size=3D48")
> >
> > This comes from "BPF old-timer", so take it with a grain of salt, but
> > current error doesn't feel too bad already and is quite
> > understandable, tbh.
> >
> > In any case, let's split off the error formatting changes (they are
> > quire big) from the check logic change and post it as two separate
> > patches (they might be in a single patch set)
>
> Just to clarify -- in v1 I had not done anything about error handling, an=
d you
> observed that some error messages now had less information than before (b=
ut,
> for the record, at the same time some of the errors before were misleadin=
g or
> even wrong because sometimes they didn't even reference the size register=
 and
> even when they did, they pretended that the size register was the constan=
t
> zero). In order to keep the information that the errors had before, someh=
ow the
> type of pointer involved needs to be taken into account; the error needs =
to
> look differently for different kinds of pointers. That's how I ended up g=
oing
> medieval and writing the error logging function. You don't seem enthused =
about

medieval, lol :)

> all the code that was required; neither was I. I spent some time looking =
around
> for something better and more code reuse. I've considered writing some mo=
re
> generic register-printing functions because it seems to me that the verif=
ier
> has too many duplicate and incomplete printing logic in error messages. B=
ut in
> the end I didn't come up with anything better.

yes, I already replied to the latest version of the patch. It feels
like a bit too much code and effort for just saying "you might
dereference memory with zero size read from register Rx". Duplicating
register states nicely inside that message seems to be the source of
most verbosity in code, and we already do that generically in verifier
log anyways. So perhaps just keeping what you have in patch #1 is the
way to go. Again, sorry for making you go "medieval" (still lol) and
doing all this extra work.

>
> Now, one might argue that getting a proper per-pointer-type was an advant=
age of
> calling check_helper_mem_access() twice -- so maybe this whole patch is
> misguided. But then again, the error messages were not actually good, and=
 also
> I'd argue that it'd be a case of the tail wagging the dog to leave the
> check_helper_mem_access() call for the benefit of the errors.

agreed, that seems like an overkill

>
> Having said all this, I definitely don't want to push unwanted code on yo=
u, so
> please confirm that you don't hate the error logging function or... somet=
hing
> else.
>
> >
> > >  __naked void access_to_map_empty_range(void)
> > >  {
> > >         asm volatile ("                                 \
> >
> > [...]

