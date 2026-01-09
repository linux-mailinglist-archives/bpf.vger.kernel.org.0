Return-Path: <bpf+bounces-78422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727DD0C88D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8165E301F273
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E433B6D2;
	Fri,  9 Jan 2026 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g13lr3e0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AA339875
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001124; cv=none; b=srfonrZ69abgYEqnLlMuepdMT6uw0HDcmsMXVG5Qyz3EtAEhABx66irMqmQ0VDknGKmOnuyhPYkgiau3fimPWmaYtznbDSIoo4hmUyy3Y3/6eB6ncNO606gYkFzUvHLZanRfr5hQCHlaFSMBqn9WnXE111n/1FT9QikUtLsgYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001124; c=relaxed/simple;
	bh=iwmpH8iocSbCReiZR1ElIhFSqJoSw8Tt4Jqoav/hyys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV8vDSgcspZsL0kA9HXo4XEjT4ijycPHXaFpx448p+nnMijxlUtpjZfdoINoZYrl+RtuQ3jZkX757sGudYGuY6smajdSqbo2CZ8DLclgKT8QT8QYHjKNGdgWEUuOD/ZwHJg47W9V90pU8hPq28yudAxGEx5f7hLNl3Kx3m44xJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g13lr3e0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81345800791so2527364b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001122; x=1768605922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7sp0N3Dnmn1JQgIiii6nynRQWaOfDVX6qO6eQ+XVU0=;
        b=g13lr3e0bfswE+keoD6ug4k5mq9bPCVDbdYmGIK+iJDeUh0YGaRQPNPc2FoGE12sIO
         Xw81xPKjcnt63ZY6aBcKPt8Gk37Gh+3OeoPDkLhNxTOCFnfVkXtvNheLQHmA/Bbggf95
         1NVfIFlAnB7y22BB8bAaXCWXxXXSp3Gmx6Xn6wFzZtgDAJucWNvRN8StO9saB5QKQEU4
         gP6ikaobTMsC5v7QQTuuZzV7k9nYjUTQsRqGRxxUifQT8ycosywhd3XuocU20gURnTy8
         7qkNNy4tf9WgTeNPX1EnKBHeVShhpfZbCY0wSkn4nGXMrsOc/82ET2lQHf2Q5yAxqswt
         aFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001122; x=1768605922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7sp0N3Dnmn1JQgIiii6nynRQWaOfDVX6qO6eQ+XVU0=;
        b=HvPtoJXweETVJ0UyDCmG4D7oJyWCvFyY3XHmE9M7FDNCPo8gkF58K+Zzx1396Kp7Rk
         YPJ5345c8wh+mmT1Rk/+LlZcEXSQlHmxREYdUTO71jP0KQjk3aMiD30sHuSixhH+QnEj
         3MldUGeORiHyFJpXBhX8UT5385ttqbEWBgDYUphGLqYlyBd25R3Zkpw6zyRz3ETW1+iP
         dnZLjs4/JRtkpth+GJUnU6GHFkffThuOmHwOzou8oywPLsACGdtDb9XDPxG3uvQ94rQH
         +L61Wn/Ujj27DBUyhYnCPr8MbNYRRNP25pfd9mePnxrrf840wHpwPabrH6qbzP0H9dTj
         fFSg==
X-Forwarded-Encrypted: i=1; AJvYcCUCWZY3paT/FO4FDXgR4TMFwZkaUTAj3Q6HZlI27GbNiZ2hwjbqPGKpcaNT4I+7bt5xNyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vSy6wDqOeGjSkxQzN6njSJIfpaqkH5EuM+c/2a2+GmPLd2B4
	tnkbjaMHX9Khaf/P90LXhPzFz/gsfeFrs5x7vM02h4gHNGhKvzHA1Dby0JsWaIZSbZSZHUUTImx
	AtZ2mQDGCZpk30PaIPMmRaIRUFHPHJuE=
X-Gm-Gg: AY/fxX6BzwTmj+NsA9jcsEzwiH3QUHortEfaXQWg5oho7rTsME5OxMeE2CUv3Ha9qBe
	FUjAeWqzwK+bUYKrYbVXVj/rzlnQofbVqviYaU7Dw6lVTV8jXCy3h//9WHGPOWZIGZrF2ConNcN
	MZo3cLbvTp4Hj+vdeMhrsZa9Gv02cu8UYsJU8ew6o3/phxgnuENaUZXbbMDQFDAkoAXupN0oT8Y
	BR+c6ikVpWceVkYFTrEmg/gVviBufEP25Cd8zCE4W4kcwbQBFhX0Fdk9BBQkb72pRtueV7DkjvA
	9P2a8dsi
X-Google-Smtp-Source: AGHT+IHzGkHt014F4jyZJRL6KZqgTC0rk2hBWiSwMGIQS09ajNp4vSbMD1ZYpebcAcySO5O37mi2rWXGPjNyj/2bBuI=
X-Received: by 2002:a05:6a20:e290:b0:366:14b0:4b12 with SMTP id
 adf61e73a8af0-3898f9bde9fmr11009711637.78.1768001122334; Fri, 09 Jan 2026
 15:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:25:09 -0800
X-Gm-Features: AQt7F2olKeEcZ-_O5kgIEStukCBUIxTmulE9ezgNy2zz2phakh8YecbP2fBcnck
Message-ID: <CAEf4Bza-ar8vFWdWf1Krtyg8zLNYBUxLSJ5mHYLniqNBJhBXqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> A kernel function bpf_foo marked with KF_IMPLICIT_ARGS flag is
> expected to have two associated types in BTF:
>   * `bpf_foo` with a function prototype that omits implicit arguments
>   * `bpf_foo_impl` with a function prototype that matches the kernel
>      declaration of `bpf_foo`, but doesn't have a ksym associated with
>      its name
>
> In order to support kfuncs with implicit arguments, the verifier has
> to know how to resolve a call of `bpf_foo` to the correct BTF function
> prototype and address.
>
> To implement this, in add_kfunc_call() kfunc flags are checked for
> KF_IMPLICIT_ARGS. For such kfuncs a BTF func prototype is adjusted to
> the one found for `bpf_foo_impl` (func_name + "_impl" suffix, by
> convention) function in BTF.
>
> This effectively changes the signature of the `bpf_foo` kfunc in the
> context of verification: from one without implicit args to the one
> with full argument list.
>
> Whether a kfunc argument is implicit or not is determined by
> is_kfunc_arg_implicit(). The values of implicit arguments by design
> are provided by the verifier, and so they can only be of particular
> types. In this patch the only allowed implicit arg type is a pointer
> to struct bpf_prog_aux. The __prog args (usually void *) are also
> considered implicit for backwards compatibility.
>
> In order to enable the verifier to correctly set an implicit
> bpf_prog_aux arg value at runtime, is_kfunc_arg_prog() is extended to
> check for the arg type. At a point when prog arg is determined in
> check_kfunc_args() the kfunc with implicit args already has a
> prototype with full argument list, so the existing value patch
> mechanism just works.
>
> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
> that uses a __prog argument (a legacy case), the prototype
> substitution works in exactly the same way, assuming the kfunc follows
> the _impl naming convention. The difference is only in how _impl
> prototype is added to the BTF, which is not the verifier's
> concern. See a subsequent resolve_btfids patch for details.
>
> In check_kfunc_call() reset the subreg_def of registers holding
> implicit arguments to correctly track zero extensions.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  include/linux/btf.h   |  1 +
>  kernel/bpf/verifier.c | 70 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 69 insertions(+), 2 deletions(-)
>

[...]

> +       impl_id =3D btf_find_by_name_kind(btf, impl_name, BTF_KIND_FUNC);
> +       if (impl_id <=3D 0) {
> +               verbose(env, "cannot find function %s in BTF\n", impl_nam=
e);
> +               return NULL;
> +       }
> +
> +       func =3D btf_type_by_id(btf, impl_id);
> +       if (!func || !btf_type_is_func(func)) {

btf_find_by_name_kind() above guarantees that we both will have
non-NULL func and it will be BTF_KIND_FUNC, drop these defensive
checks.

> +               verbose(env, "%s (btf_id %d) is not a function\n", impl_n=
ame, impl_id);
> +               return NULL;
> +       }
> +
> +       return btf_type_by_id(btf, func->type);
> +}
> +
>  static int fetch_kfunc_meta(struct bpf_verifier_env *env,
>                             s32 func_id,
>                             s16 offset,
> @@ -3308,7 +3340,16 @@ static int fetch_kfunc_meta(struct bpf_verifier_en=
v *env,
>         }
>
>         func_name =3D btf_name_by_offset(btf, func->name_off);
> -       func_proto =3D btf_type_by_id(btf, func->type);
> +
> +       /*
> +        * An actual prototype of a kfunc with KF_IMPLICIT_ARGS flag
> +        * can be found through the counterpart _impl kfunc.
> +        */
> +       if (unlikely(kfunc_flags && KF_IMPLICIT_ARGS & *kfunc_flags))

drop unlikely(), it's unnecessary micro-optimization (if at all)

(I'd also swap order to more conventional: `*kfunc_flags & KF_IMPLICIT_ARGS=
`)

> +               func_proto =3D find_kfunc_impl_proto(env, btf, func_name)=
;
> +       else
> +               func_proto =3D btf_type_by_id(btf, func->type);
> +
>         if (!func_proto || !btf_type_is_func_proto(func_proto)) {
>                 verbose(env, "kernel function btf_id %d does not have a v=
alid func_proto\n",
>                         func_id);

[...]

> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>         for (i =3D 0; i < nargs; i++) {
>                 u32 regno =3D i + 1;
>
> +               /*
> +                * Implicit kfunc arguments are set after main verificati=
on pass.
> +                * For correct tracking of zero-extensions we have to res=
et subreg_def for such
> +                * args. Otherwise mark_btf_func_reg_size() will be inspe=
cting subreg_def of regs
> +                * from an earlier (irrelevant) point in the program, whi=
ch may lead to an error
> +                * in opt_subreg_zext_lo32_rnd_hi32().
> +                */
> +               if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> +                               && is_kfunc_arg_implicit(desc_btf, &args[=
i])))
> +                       regs[regno].subreg_def =3D DEF_NOT_SUBREG;

ditto about unlikely(), this is used for rare cases where performance
matters a lot (and it's obvious which case is "common", so should be
kept linear in assembly code)


> +
>                 t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NUL=
L);
>                 if (btf_type_is_ptr(t))
>                         mark_btf_func_reg_size(env, regno, sizeof(void *)=
);
> --
> 2.52.0
>

