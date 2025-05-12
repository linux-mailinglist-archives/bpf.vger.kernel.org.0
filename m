Return-Path: <bpf+bounces-57993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90287AB2CAC
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 02:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D826A1757B1
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7227456;
	Mon, 12 May 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWhMxDNe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A47E9
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747009861; cv=none; b=Bdlswx4gkrG9C5Xcgnd11L5yy7IU1mG/Lw2fDuDSgRYGWZmmPZ9po61w7suN+CHvKyK8yLMPhvEkX7tj/yEJAPniinzu0bLFz9axJniHo3q+qMxmjuKVvm0O20aui0j0cTeWPg+KKazEawbFSB8gKYQFz//eruaJnPAFomGXBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747009861; c=relaxed/simple;
	bh=QIvJwS+o8sBcxeH1fPjDHIOjw/VQUuN1TnPkZusc++k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGjaKKOSVrPWQtFQnGGyh4tKO7hwZ3beDvdA6y/rvHPvV52X3H4nPBVzpIVp7usqIuje5vse26WIAgm8TyL/bUpsNTR601TcQu6hUJmDbT96tDlH5LmlvnMtlIvffKMfGq1pcWbAQzOTvGfjW+LYtCFz49tPE8P3iPFndmx+RfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWhMxDNe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ede096d73so26881035e9.2
        for <bpf@vger.kernel.org>; Sun, 11 May 2025 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747009857; x=1747614657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SjPpFi6iJ8MjTceRjPlxkTzqqukagHq9VfzVIXZ81I=;
        b=DWhMxDNe643jEkfsZWlL/7VYQiVq6v1srjGqklkh6loaw89fjJjMlszj4CzpK9HrEE
         ACrqrF2tfGSlVsZsesvdSpT2NDq3Gqbmq3xJ/n5h8NNL07aXdQju6hLmhjB6ZjhNSPM0
         kTUSswxzNJ4VlAGUxsyb9eccyaqRrIxawgvsTw+apMP9Chz+lQbiYb9iZ7wlVdx/OZuj
         z0vG29jIB/j4DI6r+MPdiDNjoEj5HEaecKDG188uDv+TSYMcMnnvGSEnQSc7aQpd5kGw
         btUUFdsLZmfns/a3osGTWCBC2PfyG8G+ulBDXECYbp9lLse9uQwNRbngk2mwcSc+ejct
         L5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747009857; x=1747614657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SjPpFi6iJ8MjTceRjPlxkTzqqukagHq9VfzVIXZ81I=;
        b=HpWDvQb0+HDBTdMczKKfZjuAVZaox3J3YiL4+dM0nt4WCbyaknrjaYAJUZ7jlGUvY6
         1FA4RIlfcByWKJkm4+3+n1D81ufOU2LP9peNuqE1bf9y4xTlTJI5hXSXvQ7sChMf5aoF
         btfiDbRK2KK7eJwpCTRzI53eEDynjPhEN3/Tfh6tKbnQWfMTcpB07qBsdLWUxOpjkcXY
         llk2vLgUEYA6uE6h3NR/GgHURBmYkKf36ExQjR4BPOxMhbPxXvjqxEBRREXpcPYUMbiY
         XU4RvznbN5A9ZJ/Ylxf7bTuJ83bk4eJ/9uTuuudPOT4QsB9K2T/7iW9RBwcZwoHPOBBB
         lZ7g==
X-Gm-Message-State: AOJu0YxbEUJkyfivAd9a1vLw6mVxmgexfYyypAe2/Mu5otQGVMyKQC2R
	A60sTXYsBzerWeEa6KZX/NHtBBciIRz9eLpHORTe7yIlPcdXlwhAJVg0VCg2Vn8624YiekqkCt+
	YG7u9T6PPOKlmK5oCleLRDqKsxRo=
X-Gm-Gg: ASbGncswYI22CWTjJicMwVQzCjFJjX3q4hXy+q7klNR7gs19mB6jvPCqeVYKNEQ2GX/
	BFrVujKeuPb6JgnN8XPT7/KxHj7o3YG8VM6xJMDEJazIp0l0FBn5FCKjPHgB7RdsH5tp3Ym03e4
	/t37YM0DqbXDAMQMgRjbu8ALBY7ft8sO3EfrP1vz/ey/xIh87I1QRrAgfAGThq
X-Google-Smtp-Source: AGHT+IHFspm4vOnqs5UaVa/5pa5UfBkXxzcHaPJfJ9/vO2l9LXDZNCNTdNdBycYZ5qKVGTHxPo9/I/rMBXSfMWQAzpw=
X-Received: by 2002:a05:6000:3113:b0:3a0:7d15:1d8a with SMTP id
 ffacd0b85a97d-3a1f6488436mr9187395f8f.38.1747009857430; Sun, 11 May 2025
 17:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511182744.1806792-1-yonghong.song@linux.dev>
In-Reply-To: <20250511182744.1806792-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 May 2025 17:30:45 -0700
X-Gm-Features: AX0GCFtENy5JQsWIA90r21ZMgjNo5LRr9a0V5F64WG1RnnZ69ZZjdPuujkVydNA
Message-ID: <CAADnVQKi30n+BkRpWKztBnFJ1tsejJYE6f=XtGUodvozZar6PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Warn with new bpf_unreachable() kfunc
 maybe due to uninitialized var
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 11:28=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
> uninitialized variable caused generating bpf prog binary code not
> working as expected. The reproducer is in [1] where the flags
> =E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning and =
compiler
> may take advantage of uninit variable to do aggressive optimization.
>
> In llvm internals, uninitialized variable usage may generate
> 'unreachable' IR insn and these 'unreachable' IR insns may indicate
> uninit var impact on code optimization. With clang21 patch [2],
> those 'unreachable' IR insn are converted to func bpf_unreachable().
>
> In kernel, a new kfunc bpf_unreachable() is added. If this kfunc
> (generated by [2]) is the last insn in the main prog or a subprog,
> the verifier will suggest the verification failure may be due to
> uninitialized var, so user can check their source code to find the
> root cause.
>
> Without this patch, the verifier will output
>   last insn is not an exit or jmp
> and user will not know what is the potential root cause and
> it will take more time to debug this verification failure.
>
>   [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
>   [2] https://github.com/llvm/llvm-project/pull/131731
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/helpers.c  |  5 +++++
>  kernel/bpf/verifier.c | 17 ++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> In order to compile kernel successfully with the above [2], the following
> change is needed due to clang21 changes:
>
>   --- a/Makefile
>   +++ b/Makefile
>   @@ -852,7 +852,7 @@ endif
>    endif # may-sync-config
>    endif # need-config
>
>   -KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks
>   +KBUILD_CFLAGS  +=3D -fno-delete-null-pointer-checks -Wno-default-const=
-init-field-unsafe
>
>   --- a/scripts/Makefile.extrawarn
>   +++ b/scripts/Makefile.extrawarn
>   @@ -19,6 +19,7 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, frame-a=
ddress)
>    KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member=
)
>    KBUILD_CFLAGS +=3D -Wmissing-declarations
>    KBUILD_CFLAGS +=3D -Wmissing-prototypes
>   +KBUILD_CFLAGS +=3D -Wno-default-const-init-var-unsafe
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fed53da75025..6048d7e19d4c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3283,6 +3283,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
>         local_irq_restore(*flags__irq_flag);
>  }
>
> +__bpf_kfunc void bpf_unreachable(void)
> +{
> +}

Does it have to be an actual function with the body?
Can it be a kfunc that doesn't consume any .text ?

> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3388,6 +3392,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITE=
R_NEXT | KF_RET_NULL | KF_SLE
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLE=
EPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_unreachable)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 28f5a7899bd6..d26aec0a90d0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env=
 *env,
>  static void specialize_kfunc(struct bpf_verifier_env *env,
>                              u32 func_id, u16 offset, unsigned long *addr=
);
>  static bool is_trusted_reg(const struct bpf_reg_state *reg);
> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *=
insn);
>
>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>  {
> @@ -3398,7 +3399,10 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>         int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
>         struct bpf_subprog_info *subprog =3D env->subprog_info;
>         struct bpf_insn *insn =3D env->prog->insnsi;
> +       bool is_bpf_unreachable =3D false;
>         int insn_cnt =3D env->prog->len;
> +       const struct btf_type *t;
> +       const char *tname;
>
>         /* now check that all jumps are within the same subprog */
>         subprog_start =3D subprog[cur_subprog].start;
> @@ -3433,7 +3437,18 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>                         if (code !=3D (BPF_JMP | BPF_EXIT) &&
>                             code !=3D (BPF_JMP32 | BPF_JA) &&
>                             code !=3D (BPF_JMP | BPF_JA)) {
> -                               verbose(env, "last insn is not an exit or=
 jmp\n");
> +                               verbose_insn(env, &insn[i]);
> +                               if (btf_vmlinux && insn[i].code =3D=3D (B=
PF_CALL | BPF_JMP) &&
> +                                   insn[i].src_reg =3D=3D BPF_PSEUDO_KFU=
NC_CALL) {
> +                                       t =3D btf_type_by_id(btf_vmlinux,=
 insn[i].imm);
> +                                       tname =3D btf_name_by_offset(btf_=
vmlinux, t->name_off);
> +                                       if (strcmp(tname, "bpf_unreachabl=
e") =3D=3D 0)

the check by name is not pretty.

> +                                               is_bpf_unreachable =3D tr=
ue;
> +                               }
> +                               if (is_bpf_unreachable)
> +                                       verbose(env, "last insn is bpf_un=
reachable, due to uninitialized var?\n");
> +                               else
> +                                       verbose(env, "last insn is not an=
 exit or jmp\n");

This is too specific imo.
add_subprog_and_kfunc() -> add_kfunc_call()
should probably handle it instead,
and print that error.
It doesn't matter that call bpf_unreachable is the last insn
of a program or subprogram.
I suspect llvm can emit it anywhere.

