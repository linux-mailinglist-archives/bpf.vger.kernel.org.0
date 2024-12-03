Return-Path: <bpf+bounces-45988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A99E1166
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 03:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F75163757
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9841487CD;
	Tue,  3 Dec 2024 02:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0RkeAhh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24D17555
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193440; cv=none; b=E/1xoMb3tC9/g60b7f4VbMVMVb5B8gUBr1ZgDd3Q4f0GsAsR9aye2gbT1IqeEti1mIlhxdm2OqcWGoz08XCXZ+tGdV+a5Buq3z79TY5K43v01MTcFA6BBAFr3Jfsv39I/CSD/KgL3ci9VV3IwKyXLji9Jh+xP/U3upn4aLpQH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193440; c=relaxed/simple;
	bh=9T4gi0jq8oBtadnAc7FOsIgT3uDKLiTSdgN/rLO5g7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3JTx5tU4dWeRkteU5dsFVRj+pJDSxc1re8VR0BYDjfUWLNVG8NEvp0mr+AR5f9lHh+PWY9+b0jA1yAZ5GO2GTaX1bwCpMiUh/K6M6BICb2cPIMqEvdC72T8ng65COFMtO15ps6h+GMCBAeDBXTOpMNVDL9IGZ9k13si1TCMj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0RkeAhh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e2c52c21so1727847f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 18:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733193437; x=1733798237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ5Garw7f5JBRkXHkfEXAYyxLDQR/9XJirsyW+2wL2c=;
        b=N0RkeAhhVhfUpKDoeFL2gcNydCR4tIezL2WsVrcyP0sDH2zvA/+cYwBcMK6tEJ/3d1
         34nIoJKpRml9XIk490mJXpx1SH3cNv1OUnycPWZyh/HQYbUoE2FqmBSQnJbz++6RSFb+
         SL/z+EqQSk/r7yAgwzOVtUGsJcP36utF9I7HOJ3QWhtdM7oXZsX5ZA5pZOauwJHcc9pI
         UPoDrBJ1Wr9+CQvIRyey4PtmgeWsSR1W13EUZXbWipf7riIDXeVIv5Mrdu2QF0CU/nmh
         /PZcQlv4PH4uouYZUuImGQ2HW8y6BTV9/Hodh+Zl2XFob/d5GTD4Cc5srgLz2gJ7ufEg
         5RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193437; x=1733798237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ5Garw7f5JBRkXHkfEXAYyxLDQR/9XJirsyW+2wL2c=;
        b=Cn7OVKMiX0oL5xTGMAkgV3WsNEwXmyuwFXQEdLnH6DrBOinUlVI6kjAsLQMNFIgPye
         4wLk2KPeUT2S//J2LBiB41a+lKsXfdsTN3LdJOjSqbpqgc+maeMQQV6YqO1sGZ70SGz2
         g77WYU7cD9NsRq1ZdfSghLjkkpHPfrDHICvsGykERtW7xdgFW3N7weSKt7xAZu5n0+UV
         20RxzHXQY/zFEmIGzedttmqcqiWWoLjfQ+N9/pJXEwMQTvn+ab4wYLblcF0T87N93hsz
         Qv0UTlmLlp/q7b5qBW1b74A3Sln3hWcpFvho3LjgxzikUsrHLXYZ3RZzfKtaQeI5HuSE
         j9pA==
X-Gm-Message-State: AOJu0Yy2b4fDHps0DBLpBvOX/gpWYOOC3WNTLlvYheoyUaepPTHV5NYi
	SK0A8aq8TS6ZnP750mDpBcW7dA6A/3jA4enE6U2YJJu+Gzdh8Tf6B1Wql+m+IkPocOl4AJab63s
	PObfgGPVbiRDxACLXF3mTMRFtr3scbw==
X-Gm-Gg: ASbGncuJqAOv0OCozwIB2xvIKtyOxZeUwfq5GMHnrK5aypXUjmvXhd1T/zEO3l2deWT
	yIQtlydk4FqwB2qBNutRW5E2hH7W8nawNDDzvgZ2wth7+KT0=
X-Google-Smtp-Source: AGHT+IHTzUCje7fIRRPg47D8h9JBDFO5seDDm/uQbwTuLtK2gcg9t1wrqLhEheDhAUSL1Tg7mMmk6LuLD2M3XKxhFwo=
X-Received: by 2002:a05:6000:2812:b0:385:f631:612 with SMTP id
 ffacd0b85a97d-385fd3f8f10mr382641f8f.17.1733193437033; Mon, 02 Dec 2024
 18:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129132813.1452294-1-aspsk@isovalent.com> <20241129132813.1452294-6-aspsk@isovalent.com>
In-Reply-To: <20241129132813.1452294-6-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 18:37:05 -0800
Message-ID: <CAADnVQKdsaxfYBn_SPOyUt4=r0uPXZ8ejP6ZFyy7EqdFGULg2A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:29=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Add a new set of tests to test the new field in PROG_LOAD-related
> part of bpf_attr: fd_array_cnt.
>
> Add the following test cases:
>
>   * fd_array_cnt/no-fd-array: program is loaded in a normal
>     way, without any fd_array present
>
>   * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
>     check that they're bound to the program
>
>   * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
>     only two of which are unique
>
>   * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
>     fd_array which is also referenced from within the program
>
>   * fd_array_cnt/fd-array-trash-input: pass array with some trash
>
>   * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=3D0)
>
>   * fd_array_cnt/fd-array-2big: pass too large array
>
> All the tests above are using the bpf(2) syscall directly,
> no libbpf involved.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/verifier.c                         |  30 +-
>  .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
>  2 files changed, 355 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d172f6974fd7..7102d85f580d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22620,7 +22620,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>         env->ops =3D bpf_verifier_ops[env->prog->type];
>         ret =3D init_fd_array(env, attr, uattr);
>         if (ret)
> -               goto err_free_aux_data;
> +               goto err_release_maps;
>
>         env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(env->prog->aux->toke=
n);
>         env->allow_uninit_stack =3D bpf_allow_uninit_stack(env->prog->aux=
->token);
> @@ -22773,11 +22773,11 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr, __u3
>             copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_tru=
e_size),
>                                   &log_true_size, sizeof(log_true_size)))=
 {
>                 ret =3D -EFAULT;
> -               goto err_release_maps;
> +               goto err_ext;
>         }
>
>         if (ret)
> -               goto err_release_maps;
> +               goto err_ext;
>
>         if (env->used_map_cnt) {
>                 /* if program passed verifier, update used_maps in bpf_pr=
og_info */
> @@ -22787,7 +22787,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>
>                 if (!env->prog->aux->used_maps) {
>                         ret =3D -ENOMEM;
> -                       goto err_release_maps;
> +                       goto err_ext;
>                 }
>
>                 memcpy(env->prog->aux->used_maps, env->used_maps,
> @@ -22801,7 +22801,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>                                                           GFP_KERNEL);
>                 if (!env->prog->aux->used_btfs) {
>                         ret =3D -ENOMEM;
> -                       goto err_release_maps;
> +                       goto err_ext;
>                 }
>
>                 memcpy(env->prog->aux->used_btfs, env->used_btfs,
> @@ -22817,15 +22817,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>
>         adjust_btf_func(env);
>
> -err_release_maps:
> -       if (!env->prog->aux->used_maps)
> -               /* if we didn't copy map pointers into bpf_prog_info, rel=
ease
> -                * them now. Otherwise free_used_maps() will release them=
.
> -                */
> -               release_maps(env);
> -       if (!env->prog->aux->used_btfs)
> -               release_btfs(env);
> -
> +err_ext:
>         /* extension progs temporarily inherit the attach_type of their t=
argets
>            for verification purposes, so set it back to zero before retur=
ning
>          */
> @@ -22838,7 +22830,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  err_unlock:
>         if (!is_priv)
>                 mutex_unlock(&bpf_verifier_lock);
> -err_free_aux_data:
> +err_release_maps:
> +       if (!env->prog->aux->used_maps)
> +               /* if we didn't copy map pointers into bpf_prog_info, rel=
ease
> +                * them now. Otherwise free_used_maps() will release them=
.
> +                */
> +               release_maps(env);
> +       if (!env->prog->aux->used_btfs)
> +               release_btfs(env);
> +
>         vfree(env->insn_aux_data);
>         kvfree(env->insn_hist);

verifier.c hunk shouldn't be mixed with the selftests.

Looks like it should be in patch 3?
Not sure what it does though.

