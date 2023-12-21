Return-Path: <bpf+bounces-18483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE781AE07
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD721C23148
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7C8C00;
	Thu, 21 Dec 2023 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKVEHj43"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867081A
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so370299a12.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 20:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703133024; x=1703737824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWF8mPXdMz5Ds2AxTtqVwvSp/mBUd2nicxkvPqSCkGM=;
        b=VKVEHj43SDVhXG7k4KBVjn1mWEirY9GBZ0DBXC9Yo3J6y3PgAabpmT4AF2yXl3iOdu
         a13Iu4JuLa6tyPHnMqTpOEuly+SRoHYV5lt/ExjNtJTxkgUdDLSdXKJECwtJxZuMo16I
         4a6iuVXCxG2WCr85lQKTFCsPxJkoy+Bazhi+jNypYzqYmvGM4hPcguGxQ+7bZxDYFyHB
         yhwrR9FI1Tmprx53DnJT/tM/bbjm1bmcQdQ2PTTLsKfqNHTygAF8dsErRwfI9XIWhzP/
         mCPJHqGTlcOsU8T/0y/RWPSPmlVntsUdjlW+bbKllUutVjDZbWQFBAtwIUGr/WB5DZ6j
         Rq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703133024; x=1703737824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWF8mPXdMz5Ds2AxTtqVwvSp/mBUd2nicxkvPqSCkGM=;
        b=JiHVwXbM0Gv5PiCDfOEtM+I+vRKFAj8yjYc93imWAL2k0ca2lMGw7KMiXYOP1CjA/q
         u1pXzbzk0Ff8/5k5wnOhjtaQLPfAPV4UKEpptQtSxGdBImem0c1WKyGvu9Ox+K1lLD/0
         xWIbJMaxPBP3TLPlrieR6ISm6bLFd6plPw3+5+rvCPLuyy8W4XJ7Ie6z0s2t2kVkjC7t
         z1BRKwWF2RsUi0XhAWFOssrSGdD/3YByL4Rjv4XruPc8XAYgKTZmtMO7cE0StYfKhTD4
         QuSLyA/4F3G5R+6OKKNhwTXEC1ap12rahBC9rQG2nz/KjJL6xDhAQK1M0dN3vznAe9nz
         2Hbg==
X-Gm-Message-State: AOJu0Yw9WHQnjIOoTW5NPmvLjxFr2Dgv71FZrIdqoVjcqw8F0Brg/rC3
	zqXIRRx2SXqBNCan9YCk6CE/Ph67/IfQP3Di5GyJ6Hc9doo=
X-Google-Smtp-Source: AGHT+IEtL+aydTk3kHem6SFBKPNiDIyfV/GNNPaH32QKfzRFZ1KSK4bCsV79J1ObKCPw4LpAWhXIbN+0JjVgjNPWNrg=
X-Received: by 2002:a50:8add:0:b0:553:35fa:31e4 with SMTP id
 k29-20020a508add000000b0055335fa31e4mr1900027edk.138.1703133023621; Wed, 20
 Dec 2023 20:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220170604.183380-1-andreimatei1@gmail.com> <20231220170604.183380-2-andreimatei1@gmail.com>
In-Reply-To: <20231220170604.183380-2-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Dec 2023 20:30:11 -0800
Message-ID: <CAEf4BzajeEa970Jm6MQCOiT-7++o_dA+KcoE_pQL-yGBZhtKUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Simplify checking size of helper accesses
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:06=E2=80=AFAM Andrei Matei <andreimatei1@gmail.co=
m> wrote:
>
> This patch simplifies the verification of size arguments associated to
> pointer arguments to helpers and kfuncs. Many helpers take a pointer
> argument followed by the size of the memory access performed to be
> performed through that pointer. Before this patch, the handling of the
> size argument in check_mem_size_reg() was confusing and wasteful: if the
> size register's lower bound was 0, then the verification was done twice:
> once considering the size of the access to be the lower-bound of the
> respective argument, and once considering the upper bound (even if the
> two are the same). The upper bound checking is a super-set of the
> lower-bound checking(*), except: the only point of the lower-bound check
> is to handle the case where zero-sized-accesses are explicitly not
> allowed and the lower-bound is zero. This static condition is now
> checked explicitly, replacing a much more complex, expensive and
> confusing verification call to check_helper_mem_access().
>
> Now that check_mem_size_reg() deals directly with the zero_size_allowed
> checking, the single remaining call to check_helper_mem_access() can
> pass a static value for the zero_size_allowed arg, instead of
> propagating a dynamic one. I think this is an improvement, as tracking
> the wide propagation of zero_sized_allowed is already complicated.
>
> Error messages change in this patch. Before, messages about illegal
> zero-size accesses depended on the type of the pointer and on other
> conditions, and sometimes the message was plain wrong: in some tests
> that changed you'll see that the old message was something like "R1 min
> value is outside of the allowed memory range", where R1 is the pointer
> register; the error was wrongly claiming that the pointer was bad
> instead of the size being bad. Other times the information that the size
> came for a register with a possible range of values was wrong, and the
> error presented the size as a fixed zero. Now the errors refer to the
> right register. However, the old error messages did contain useful
> information about the pointer register which is now lost. The next patch
> will bring that information back.
>
> (*) Besides standing to reason that the checks for a bigger size access
> are a super-set of the checks for a smaller size access, I have also
> mechanically verified this by reading the code for all types of
> pointers. I could convince myself that it's true for all but
> PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> line-by-line does not immediately prove what we want. If anyone has any
> qualms, let me know.
>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 28 ++++++++----
>  .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
>  .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
>  3 files changed, 61 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1863826a4ac3..4409b8f2b0f3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7267,6 +7267,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>                               bool zero_size_allowed,
>                               struct bpf_call_arg_meta *meta)
>  {
> +       const bool size_is_const =3D tnum_is_const(reg->var_off);
>         int err;
>
>         /* This is used to refine r0 return value bounds for helpers
> @@ -7282,7 +7283,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>         /* The register is SCALAR_VALUE; the access check
>          * happens using its boundaries.
>          */
> -       if (!tnum_is_const(reg->var_off))
> +       if (!size_is_const)
>                 /* For unprivileged variable accesses, disable raw
>                  * mode so that the program is required to
>                  * initialize all the memory that the helper could
> @@ -7296,12 +7297,9 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>                 return -EACCES;
>         }
>
> -       if (reg->umin_value =3D=3D 0) {
> -               err =3D check_helper_mem_access(env, regno - 1, 0,
> -                                             zero_size_allowed,
> -                                             meta);
> -               if (err)
> -                       return err;
> +       if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> +               verbose(env, "R%d invalid zero-sized read\n", regno);
> +               return -EACCES;
>         }
>

I feel like this simplification is the only one necessary. Code change
below (for umax) seems unnecessary.

>         if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> @@ -7309,9 +7307,21 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>                         regno);
>                 return -EACCES;
>         }
> +       /* If !zero_size_allowed, we already checked that umin_value > 0,=
 so
> +        * umax_value should also be > 0.
> +        */
> +       if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> +               verbose(env, "verifier bug: !zero_size_allowed should hav=
e been handled already\n");
> +               return -EFAULT;
> +       }

This check seems unnecessary. If we have a bug and umax < umin, then
a) we should detect it earlier in reg bounds sanity check and b)
check_helper_mem_access would still reject umax=3D=3D0 case if
!zero_size_allowed. On the other hand, this check does nothing if
zero_size_allowed=3D=3Dtrue.

So it's at best partially useful, I'd just drop it. If you do drop it,
please add my ack to the next revision, thanks. (I might disappear due
to holidays, so might be slow to review/reply going forward).

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         err =3D check_helper_mem_access(env, regno - 1,
> -                                     reg->umax_value,
> -                                     zero_size_allowed, meta);
> +                               reg->umax_value,
> +                               /* zero_size_allowed: we asserted above t=
hat umax_value is not
> +                                * zero if !zero_size_allowed, so we don'=
t need any further
> +                                * checks.
> +                                */
> +                               true,
> +                               meta);

and here if we leave zero_size_allowed, what's the worst that can
happen? I'd keep the original call as is.

>         if (!err)
>                 err =3D mark_chain_precision(env, regno);
>         return err;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_acce=
ss.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> index 692216c0ad3d..137cce939711 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> @@ -89,9 +89,14 @@ l0_%=3D:       exit;                                  =
         \
>         : __clobber_all);
>  }
>
> +/* Call a function taking a pointer and a size which doesn't allow the s=
ize to
> + * be zero (i.e. bpf_trace_printk() declares the second argument to be
> + * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass zero =
for the
> + * size and expect to fail.
> + */
>  SEC("tracepoint")
>  __description("helper access to map: empty range")
> -__failure __msg("invalid access to map value, value_size=3D48 off=3D0 si=
ze=3D0")
> +__failure __msg("R2 invalid zero-sized read")
>  __naked void access_to_map_empty_range(void)
>  {
>         asm volatile ("                                 \
> @@ -113,6 +118,38 @@ l0_%=3D:     exit;                                  =
         \
>         : __clobber_all);
>  }
>
> +/* Like the test above, but this time the size register is not known to =
be zero;
> + * its lower-bound is zero though, which is still unacceptible.

typo: unacceptable

we normally add new tests in a separate patch. Fixing existing tests
to make them pass together with kernel change is the only case were we
mix selftests changes and kernel changes.

> + */
> +SEC("tracepoint")
> +__description("helper access to map: possibly-empty range")
> +__failure __msg("R2 invalid zero-sized read")
> +__naked void access_to_map_possibly_empty_range(void)
> +{
> +       asm volatile ("                                         \
> +       r2 =3D r10;                                               \
> +       r2 +=3D -8;                                               \
> +       r1 =3D 0;                                                 \
> +       *(u64*)(r2 + 0) =3D r1;                                   \
> +       r1 =3D %[map_hash_48b] ll;                                \
> +       call %[bpf_map_lookup_elem];                            \
> +       if r0 =3D=3D 0 goto l0_%=3D;                                  \
> +       r1 =3D r0;                                                \
> +       /* Read an unknown value */                             \
> +       r7 =3D *(u64*)(r0 + 0);                                   \
> +       /* Make it small and positive, to avoid other errors */ \
> +       r7 &=3D 4;                                                \
> +       r2 =3D 0;                                                 \
> +       r2 +=3D r7;                                               \
> +       call %[bpf_trace_printk];                               \
> +l0_%=3D: exit;                                               \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +         __imm(bpf_trace_printk),
> +         __imm_addr(map_hash_48b)
> +       : __clobber_all);
> +}
> +
>  SEC("tracepoint")
>  __description("helper access to map: out-of-bound range")
>  __failure __msg("invalid access to map value, value_size=3D48 off=3D0 si=
ze=3D56")
> @@ -221,7 +258,7 @@ l0_%=3D:      exit;                                  =
         \
>
>  SEC("tracepoint")
>  __description("helper access to adjusted map (via const imm): empty rang=
e")
> -__failure __msg("invalid access to map value, value_size=3D48 off=3D4 si=
ze=3D0")
> +__failure __msg("R2 invalid zero-sized read")
>  __naked void via_const_imm_empty_range(void)
>  {
>         asm volatile ("                                 \
> @@ -386,7 +423,7 @@ l0_%=3D:      exit;                                  =
         \
>
>  SEC("tracepoint")
>  __description("helper access to adjusted map (via const reg): empty rang=
e")
> -__failure __msg("R1 min value is outside of the allowed memory range")
> +__failure __msg("R2 invalid zero-sized read")
>  __naked void via_const_reg_empty_range(void)
>  {
>         asm volatile ("                                 \
> @@ -556,7 +593,7 @@ l0_%=3D:      exit;                                  =
         \
>
>  SEC("tracepoint")
>  __description("helper access to adjusted map (via variable): empty range=
")
> -__failure __msg("R1 min value is outside of the allowed memory range")
> +__failure __msg("R2 invalid zero-sized read")
>  __naked void map_via_variable_empty_range(void)
>  {
>         asm volatile ("                                 \
> diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/too=
ls/testing/selftests/bpf/progs/verifier_raw_stack.c
> index f67390224a9c..3dbda85e2997 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> @@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
>
>  SEC("tc")
>  __description("raw_stack: skb_load_bytes, zero len")
> -__failure __msg("invalid zero-sized read")
> +__failure __msg("R4 invalid zero-sized read")
>  __naked void skb_load_bytes_zero_len(void)
>  {
>         asm volatile ("                                 \
> --
> 2.40.1
>

