Return-Path: <bpf+bounces-46916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029329F18F7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F5188B9C4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094A1EBFFD;
	Fri, 13 Dec 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASphRER/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F31AB52F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128337; cv=none; b=OAvmQ5w//2euB+94xD5NUd8V0m83kUghyhXOLpEskl35ZpIx7084HghBKiKKDrgDS9RebxqTWtM47wic78xr2m4lMCLTV1w6F9Urtfo9Z1lX8iDklt1dHjYW+BZ0Pd2ZTHDwyWJP5LfoqkJO14Zb3vshWxjo4DHvCOXE6xAM0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128337; c=relaxed/simple;
	bh=PdK1PvQNsQQG0bCdDGfEc7HKZjWjYHYF6LpZDX67txc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBGQ2aRTNf7cQyaKmuHp72kH3T9Usskx5Xd8qLYyPwv8Hs2PLv1n28vZOx+Vblgt0GxlFPq/bZ+V8jKMwmTBfqbT80KxkyVBu1Ks9nM1VwyGNISavQ2aRObF+pp7O6ewgp0ZXIWDv0MOO6cNxWgqZwncYmQld+rSbpaYxa0yfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASphRER/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so1808353a12.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128335; x=1734733135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3nYDmOorfv73ucKf4jKeqSUcSRzNKY1J7V5uHw9EkE=;
        b=ASphRER/wmnnsS1hz61L7O/nYsCaRgasHXqlv+eRLRFfOLgFhPyptriXMdcJX6HSsp
         A3/JW35IyCPcBJ5WadzrbFNUOVXCpNdMkl/3H8sMvZbtAGLYTqs4oC8m0CRkZ2i3JWlQ
         G6u8Y0iepfSgawo8yTrK0OykuuG2EKe7Wp0b+oA3fBvmsdfd6gjs62rRvr6NUyNMxlEb
         ENvM8GTi0cM8VqwGoWR1gW5y8+Qtw5v2ZRcPCDrl2cETq8JnZaL4vw2Fyxn76P15gUaw
         9PPghqSrLj2dFwYcxBbjkcw+JRiNfSsBjUx3pUuG/k/NQG6voM5t+DfiLZE5cbZfMWuk
         12aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128335; x=1734733135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3nYDmOorfv73ucKf4jKeqSUcSRzNKY1J7V5uHw9EkE=;
        b=RMvZ0hly3RKBdrJUQYlEyBnAM/j1xN4zkSb4PmpD/qxkSgh/fUDHG7TsNSXeFAEIkh
         0DuzEyaMrzHUHFPbd6mnAaWCq2YLt0Mcadwp4F5Ji3TxUrFh7OW0lescRNzYvloQ5uBM
         CnaIuOWgY8lBEYKebetYPOSAQINQMl3BiVuB/eLUMyDx3+nap4iAgg2F7A+ONXZZ6F+A
         qm9WVAXMgaB006C/giqtvWal961YRBvR163/D2IrPXa50/UoC0enmi5XdBQqJyDWyArA
         P842acQKdCWRLfutfNzTL++H3zAvg88WFQFnkmHDETqbyEwYZgscRWzVAl9SAtHdMaf5
         t46A==
X-Gm-Message-State: AOJu0YxNcrpQp4A4OATbQnH7lVxDWbS0eBAFIW/ur/ThKAcBPgkUQN0u
	m1AdW5aSAwCFq798gB2lST9hUn9MO+2mUkhB1zTGdthgctpVpTRUSjw8zG6H/yqPYg2sFMgxT6v
	EVfsZMpDcUM3VtEA2mtx09NIjJGPSj7xR
X-Gm-Gg: ASbGncsKIOha6vmpseKnpjvyvwZ0HrI7ILWqnMuNQQXMjhQIPrcmLR/fHajulh0fWid
	VWOAKdPJlOL7+aKzwTOqCSdMwUi6AnEmBi0qz//nkp03kefQE0fHFmA==
X-Google-Smtp-Source: AGHT+IGOfevXMVQkqJ0zWYdTNESHCEw0mLWOMDUnRfByt8g5wpeOxXBp9he40znZCIIc1yldZ9hA6YU9EPpMYmxRNe8=
X-Received: by 2002:a17:90b:2652:b0:2ea:8d1e:a85f with SMTP id
 98e67ed59e1d1-2f28fd6b90bmr7505468a91.17.1734128335124; Fri, 13 Dec 2024
 14:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213130934.1087929-1-aspsk@isovalent.com> <20241213130934.1087929-5-aspsk@isovalent.com>
In-Reply-To: <20241213130934.1087929-5-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 14:18:43 -0800
Message-ID: <CAEf4BzYqRyNCb5WB7JPA_N597LnpLm3e0ykPTP7m1eco_wyYpQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:08=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> of file descriptors: maps or btfs. This field was introduced as a
> sparse array. Introduce a new attribute, fd_array_cnt, which, if
> present, indicates that the fd_array is a continuous array of the
> corresponding length.
>
> If fd_array_cnt is non-zero, then every map in the fd_array will be
> bound to the program, as if it was used by the program. This
> functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> maps can be used by the verifier during the program load.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/uapi/linux/bpf.h       |  10 ++++
>  kernel/bpf/syscall.c           |   2 +-
>  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
>  tools/include/uapi/linux/bpf.h |  10 ++++
>  4 files changed, 112 insertions(+), 16 deletions(-)
>

[...]

>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr, __u32 uattr_size)
>  {
>         u64 start_time =3D ktime_get_ns();
> @@ -22881,7 +22954,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>                 env->insn_aux_data[i].orig_idx =3D i;
>         env->prog =3D *prog;
>         env->ops =3D bpf_verifier_ops[env->prog->type];
> -       env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
>
>         env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(env->prog->aux->toke=
n);
>         env->allow_uninit_stack =3D bpf_allow_uninit_stack(env->prog->aux=
->token);
> @@ -22904,6 +22976,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (ret)
>                 goto err_unlock;
>
> +       ret =3D process_fd_array(env, attr, uattr);
> +       if (ret)
> +               goto err_release_maps;

I think this should be goto skip_full_check, so that we can finalize
verifier log (you do log an error if fd_array FD is invalid, right?)

If this is the only issue, this can probably be just patched up while apply=
ing.

> +
>         mark_verifier_state_clean(env);
>
>         if (IS_ERR(btf_vmlinux)) {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 4162afc6b5d0..2acf9b336371 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1573,6 +1573,16 @@ union bpf_attr {
>                  * If provided, prog_flags should have BPF_F_TOKEN_FD fla=
g set.
>                  */
>                 __s32           prog_token_fd;
> +               /* The fd_array_cnt can be used to pass the length of the
> +                * fd_array array. In this case all the [map] file descri=
ptors
> +                * passed in this array will be bound to the program, eve=
n if
> +                * the maps are not referenced directly. The functionalit=
y is
> +                * similar to the BPF_PROG_BIND_MAP syscall, but maps can=
 be
> +                * used by the verifier during the program load. If provi=
ded,
> +                * then the fd_array[0,...,fd_array_cnt-1] is expected to=
 be
> +                * continuous.
> +                */
> +               __u32           fd_array_cnt;
>         };
>
>         struct { /* anonymous struct used by BPF_OBJ_* commands */
> --
> 2.34.1
>
>

