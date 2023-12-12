Return-Path: <bpf+bounces-17624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EB080FB8D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EABB20F51
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A18E745C4;
	Tue, 12 Dec 2023 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsO/HPUQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C8B2
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:47:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a22fb5f71d9so4898666b.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702424848; x=1703029648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCK5X5h4wuI1zSeRtoquGr0LdUht8Ynaapu3lamZis=;
        b=QsO/HPUQzOdGgL4GJ+ZmR6dx/O4QDZXUfy53IprmXwWhMfNEu4o9FTjwZ83skO4wfl
         79k23egTSWIhBkjPNjZkmKweSfUZTF69oQx+pWEZAxBRdVCthTkBq5XwMtQ+CbjRVt3u
         Uy464A4R0WfQtPBDKD3xJ23zCzzJc3pjV3GJeSSyWuwk+rO99TaH1+kOQcxfkhoegVpv
         kYTrkE6r685WdtFqPWAqLJ9NSt8Bon2pk9YBRzZpoww56BvDh9R+PstEKV/DaGTfXrJg
         CpfUJ86RzdgUqjArvo0l7VHu5UM5smu1SulLG7stsj7/pD0Lgpii3YG/bmu6RbiPGfGw
         PNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424848; x=1703029648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCK5X5h4wuI1zSeRtoquGr0LdUht8Ynaapu3lamZis=;
        b=jwGoJUurLxwp6cA4BsW8utRQYVZNW6a7jMwLvfM3nN+AAwAFFJRh40Gjqqug/SXtQL
         +L1Y4fmOahkAzFPZObQzSQVf+SiTpWBV9qY8cBTyaKbZ2jHwjFgRnGL6Vbznmhlksxgf
         w7NTnLloHF/KIflWGYRbARqJCGbLwuNKW0lknLR0dOjtNcvfiY+uyvVE6ItGUILXUnsY
         4BNgBMNBq4I5zGzzTj5GawzbsiiAW+9co01gUKeTlEUFm5wH1Xugk1HrE5/2n+6FcUo5
         sSwMxrwJbhHdLBaixH6V8ebSBR0YW9ESdZSjokmV1MtL5aklUPRgLVupxn9fnkGF2U4g
         AfBQ==
X-Gm-Message-State: AOJu0YxNBM/OwAKVJOn1NKxwvZczIno/nd3C9Xyot+Rvt8mD/+gaHMie
	DmjYJlpWjrARkOyr1oP6ejpzllOqAa1h184thjpGOBvq
X-Google-Smtp-Source: AGHT+IF4yGr4GLl5UF/nBZ0JaWGZkpOLICT6QsZJFL2Xex0el/i1tN+dpCIu4y6/LulRPNwkOgCDfRVmj+v7gl8Pn5s=
X-Received: by 2002:a17:906:ef8b:b0:a1b:619e:53f7 with SMTP id
 ze11-20020a170906ef8b00b00a1b619e53f7mr7222424ejb.27.1702424847696; Tue, 12
 Dec 2023 15:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210225536.70322-1-andreimatei1@gmail.com>
In-Reply-To: <20231210225536.70322-1-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Dec 2023 15:47:15 -0800
Message-ID: <CAEf4BzZ+LYPacn5hKCo+EK31NQu+p6iNFx42PdQZHu1hxSMZBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Simplify checking size of helper accesses
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 2:55=E2=80=AFPM Andrei Matei <andreimatei1@gmail.co=
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
> This patch also results in better error messages for rejected zero-size
> reads. Before, the message one would get depended on the type of the
> pointer and on other conditions, and sometimes the message was plain
> wrong: in some tests that changed you'll see that the old message was
> something like "R1 min value is outside of the allowed memory range",
> where R1 is the pointer register; the error was wrongly claiming that
> the pointer was bad instead of the size being bad. Other times the
> information that the size came for a register with a possible range of
> values was wrong, and the error presented the size as a fixed zero.
>
> (*) Besides standing to reason that the checks for a bigger size access
> are a super-set of the checks for a smaller size access, I have also
> mechanically verified this by reading the code for all types of
> pointers. I could convince myself that it's true for all but
> PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> line-by-line does not immediately prove what we want. If anyone has any
> qualms, let me know.

yeah, I think for PTR_TO_BTF_ID (at least conceptually, I don't know
if we support this now or not) actual range is important, we can't
just assume [0, umax] range. [umin, umax] might be valid if it falls
completely inside, say, array, but if it crosses two fields, then it
would be rejected. Again, not saying we do these checks today, but
this is where I see the problem. Simplifying [umin, umax] into [0,
umax] will be valid only for dumb opaque memory regions, which
PTR_TO_BTF_ID isn't really

>
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 34 ++++++++++----
>  .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
>  .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
>  3 files changed, 68 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb690539d5f6..022833903157 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7258,6 +7258,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>                               struct bpf_call_arg_meta *meta)
>  {
>         int err;
> +       const bool size_is_const =3D tnum_is_const(reg->var_off);
>
>         /* This is used to refine r0 return value bounds for helpers
>          * that enforce this value as an upper bound on return values.
> @@ -7272,7 +7273,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>         /* The register is SCALAR_VALUE; the access check
>          * happens using its boundaries.
>          */
> -       if (!tnum_is_const(reg->var_off))
> +       if (!size_is_const)
>                 /* For unprivileged variable accesses, disable raw
>                  * mode so that the program is required to
>                  * initialize all the memory that the helper could
> @@ -7286,12 +7287,17 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
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
> +               if (size_is_const) {
> +                       verbose(env, "R%d invalid zero-sized read\n", reg=
no);
> +               } else {
> +                       char tn_buf[48];
> +
> +                       tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +                       verbose(env, "R%d invalid possibly-zero-sized rea=
d: u64=3D[%#llx, %#llx] var_off=3D%s\n",
> +                               regno, reg->umin_value, reg->umax_value, =
tn_buf);

for retval checks we decided to not care about tnum at all, so I think
it makes sense to do that here as well. tnum provides no benefits in
range checking and will be just an eye sore for users


> +               }
> +               return -EACCES;
>         }
>
>         if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> @@ -7299,9 +7305,21 @@ static int check_mem_size_reg(struct bpf_verifier_=
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
>         err =3D check_helper_mem_access(env, regno - 1,
>                                       reg->umax_value,
> -                                     zero_size_allowed, meta);
> +                                     /* zero_size_allowed: we asserted a=
bove that umax_value is
> +                                      * not zero if !zero_size_allowed, =
so we don't need any
> +                                      * further checks.
> +                                      */
> +                                     true ,
> +                                     meta);
>         if (!err)
>                 err =3D mark_chain_precision(env, regno);
>         return err;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_acce=
ss.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
> index 692216c0ad3d..7c99c7bae09e 100644
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
> + */
> +SEC("tracepoint")
> +__description("helper access to map: possibly-empty range")
> +__failure __msg("R2 invalid possibly-zero-sized read: u64=3D[0x0, 0x4] v=
ar_off=3D(0x0; 0x4)")
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

I wouldn't say this the new message is strictly an improvement, tbh.
Offset is definitely useful, value_size is a nice hint as well. So I
personally would prefer details in the original message

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

btw, it's "*possible" zero-sized read", right?

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

