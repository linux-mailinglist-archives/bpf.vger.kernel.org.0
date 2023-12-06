Return-Path: <bpf+bounces-16916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6F807832
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5CA1F2145F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7F4777D;
	Wed,  6 Dec 2023 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwbDqSsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D170484
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:56:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so151967a12.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888978; x=1702493778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaHcVlNK0z+dmNXBwrTsCkLRN584QGphlk/gBgCpV0w=;
        b=FwbDqSsZZY6PCZc57wY4ArNsjnFdgVaa0NN5utctVlrSq59Rk2Z95n/lceEOToukEW
         FiSEw05bw10D/2rot61H9hlRLnNnHdcIo90CjiDPGztgkixovPCGKSQsee0ZfKw71Xhg
         YdxnsJn5zwZi2Kp+nqJ7MDz/NHOGJZJJewEu6G+Nm5GK7Urqn6aH78c0c6bAB8eOvVrg
         5nDZslZZNAIRulXKsRPYbuZADkfxkvoM+sXrJ0RtuaaI2/oVa60NDVzCDK2Z2m6NAqu3
         P0cRX3Rc0WFJANjG/UKZ35j0I+LfrvKaPBYW+cjufJbzN148Ou+tIdoM6XV86TjXEWoD
         1cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888978; x=1702493778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaHcVlNK0z+dmNXBwrTsCkLRN584QGphlk/gBgCpV0w=;
        b=J1SRE8YPpnZH5vYsCRcqVE840vccddefVnFWq++aefGNZjg3N2ED9CrALAstt6g+F+
         Fou1uKH6qZ8YZbrl1cCi6aIPnI35SjYy2lnf3FJk5DLviUC8734O4khgAXuf4//EXoT6
         kfoLny7lN1s+RloToMgmvZaodNCNrp5OKMtytosbi1bio54OEPSYpVgrSo77cPt9z9X+
         /V0gjBQa3noG7Sn6UlIJn4ZlArzk6TG2hzoMTjt/TduHHgfZIapwgAgeiJ85/zvs08Ft
         95jeEN1aSc1PHybxbzz4aqI8GHDQv34Ws55E3VWu3G0PRINS4Ros5ZtgPFHLYyIWYsdY
         Eg4g==
X-Gm-Message-State: AOJu0YxGzD8dXbcm5sFKkxts5cJPTpZIBZAQhqxOKyy8HZym4Hskk6Fk
	d2cwMWaRHtPbOrHXcB+ViJVGSYMUGuvyvpYQYe4=
X-Google-Smtp-Source: AGHT+IHxIZzUy+h20VWjrHBjcY5RU00q1oicWOu0SZLVAz4z2wQaoKJLXsKGu6M9wcmMj7d0LzsCWMrs/HJ0cJ8HTK4=
X-Received: by 2002:a17:906:7e0f:b0:a1d:2e32:d28c with SMTP id
 e15-20020a1709067e0f00b00a1d2e32d28cmr646598ejr.146.1701888978122; Wed, 06
 Dec 2023 10:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206165802.380626-1-andreimatei1@gmail.com> <20231206165802.380626-2-andreimatei1@gmail.com>
In-Reply-To: <20231206165802.380626-2-andreimatei1@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 10:56:05 -0800
Message-ID: <CAEf4BzZ_bRO+OjfdA0b_L5iMYnMRMB6kUMgReifRCvBBgDFbXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 8:58=E2=80=AFAM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> This patch fixes a bug around the verification of possibly-zero-sized
> stack accesses. When the access was done through a var-offset stack
> pointer, check_stack_access_within_bounds was incorrectly computing the
> maximum-offset of a zero-sized read to be the same as the register's min
> offset. Instead, we have to take in account the register's maximum
> possible value. The patch also simplifies how the max offset is checked;
> the check is now simpler than for min offset.
>
> The bug was allowing accesses to erroneously pass the
> check_stack_access_within_bounds() checks, only to later crash in
> check_stack_range_initialized() when all the possibly-affected stack
> slots are iterated (this time with a correct max offset).
> check_stack_range_initialized() is relying on
> check_stack_access_within_bounds() for its accesses to the
> stack-tracking vector to be within bounds; in the case of zero-sized
> accesses, we were essentially only verifying that the lowest possible
> slot was within bounds. We would crash when the max-offset of the stack
> pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> not something anyone's code attempts to do in practice).
>
> Thanks Hao for reporting!
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1FPx=
mkgb0Os_frnHiNdw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 14 +++------
>  .../selftests/bpf/progs/verifier_var_off.c    | 29 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e5ce530641ba..137240681fa9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6620,10 +6620,7 @@ static int check_stack_access_within_bounds(
>
>         if (tnum_is_const(reg->var_off)) {
>                 min_off =3D reg->var_off.value + off;
> -               if (access_size > 0)
> -                       max_off =3D min_off + access_size - 1;
> -               else
> -                       max_off =3D min_off;
> +               max_off =3D min_off + access_size;
>         } else {
>                 if (reg->smax_value >=3D BPF_MAX_VAR_OFF ||
>                     reg->smin_value <=3D -BPF_MAX_VAR_OFF) {
> @@ -6632,15 +6629,12 @@ static int check_stack_access_within_bounds(
>                         return -EACCES;
>                 }
>                 min_off =3D reg->smin_value + off;
> -               if (access_size > 0)
> -                       max_off =3D reg->smax_value + off + access_size -=
 1;
> -               else
> -                       max_off =3D min_off;
> +               max_off =3D reg->smax_value + off + access_size;
>         }
>
>         err =3D check_stack_slot_within_bounds(min_off, state, type);
> -       if (!err)
> -               err =3D check_stack_slot_within_bounds(max_off, state, ty=
pe);
> +       if (!err && max_off > 0)
> +               err =3D -EINVAL; /* out of stack access into non-negative=
 offsets */
>

this part looks good to me, please add my ack on resubmission

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>         if (err) {
>                 if (tnum_is_const(reg->var_off)) {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c
> index 83a90afba785..9fb32b292017 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -224,6 +224,35 @@ __naked void access_max_out_of_bound(void)
>         : __clobber_all);
>  }
>
> +/* Similar to the test above, but this time check the special case of a
> + * zero-sized stack access. We used to have a bug causing crashes for ze=
ro-sized
> + * out-of-bounds accesses.
> + */
> +SEC("socket")
> +__description("indirect variable-offset stack access, zero-sized, max ou=
t of bound")
> +__failure __msg("invalid variable-offset indirect access to stack R1")
> +__naked void zero_sized_access_max_out_of_bound(void)

as Eduard mentioned, please split off selftests from kernel-side changes

> +{
> +       asm volatile ("                     \
> +       r0 =3D 0;                             \
> +       /* Fill some stack */               \
> +       *(u64*)(r10 - 16) =3D r0;             \
> +       *(u64*)(r10 - 8) =3D r0;              \
> +       /* Get an unknown value */          \
> +       r1 =3D *(u32*)(r1 + 0);               \
> +       r1 &=3D 64;                           \

did you mean 63 here? and if yes, why does the test work? :)

> +       r1 +=3D -16;                          \
> +       /* r1 is now anywhere in [-16,48)*/ \

nit: space before */ ?

> +       r1 +=3D r10;                          \
> +       r2 =3D 0;                             \
> +       r3 =3D 0;                             \
> +       call %[bpf_probe_read_kernel];      \
> +       exit;                               \
> +"      :
> +       : __imm(bpf_probe_read_kernel)
> +       : __clobber_all);
> +}
> +
>  SEC("lwt_in")
>  __description("indirect variable-offset stack access, min out of bound")
>  __failure __msg("invalid variable-offset indirect access to stack R2")
> --
> 2.39.2
>

