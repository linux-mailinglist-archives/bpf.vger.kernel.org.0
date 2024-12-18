Return-Path: <bpf+bounces-47276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168849F6F63
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F1B1633A3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E31FC7F0;
	Wed, 18 Dec 2024 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akEPXnmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D971991AA;
	Wed, 18 Dec 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556855; cv=none; b=JxUQNTzPlxPdKlb/viiFuzpx8/DVFfeEk71XoHnqEBa3jOcvlUIFBIrP7c8s7enTSPJ8pO8Tlvo+fxW5XdXU9xWnA0w8MefyqEc4g90cyFMkXWhWelKbV6cJ0qi2xKQ9dKAjXGBS90TNbzLdRyyPKIJHpjT8TncwIDp+KiQiE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556855; c=relaxed/simple;
	bh=ZAAXJis6h3Gxlks/b62d5xZgaFxE9MDxE2CLjMJAXKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HraPD7AflOwxl9pPmy44Eiv2GssqpJcSpOnTlkXKOmNzKQ4LdQPWktld+mkrwf6vnpxRtM2JOxgD1KYqddMhJpnOpzzZSuVje+gcy1CQESFbjaTcfNpAUIHsl5x+a/+BZmm3OIOqXEm060WXM0XWe040hqmJ/awFdsby8ngeDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akEPXnmG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7f19f20so60190f8f.1;
        Wed, 18 Dec 2024 13:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734556852; x=1735161652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fltd8tTrg2w0S2s+1CngFstb0NQogjTdUuyCOOE6GS8=;
        b=akEPXnmG2OjchyVoevTeC8gxPVfB/llLTascwMADdiqR8St2e6jf9l8bLoKSNT31fC
         ndu/8PJk+ZWc84c/D2XqlQUiJB0jyVCcDFRsBrO9AvhaZq1z4oQLKFVQiyq3vTM+yAd8
         ZA/2jdCHYq7uzNOIdNCpdHwuDo/EnGP2bsZWelXp9slUKOG4PbOWbw+zq+KikmXbqSga
         2h4Umkn/o8jncjKIqHg/HzrMOvMY+4pU3gM0oeNdFwAs1lrwa0VwYRf45MchGVG48Yix
         GjUtWcDQuY6+F6lWLnKmnAyI7UwLWtz7Lvpg57kTAIJ2TcL0b5sUOXnoyCWB73YH18S5
         syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734556852; x=1735161652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fltd8tTrg2w0S2s+1CngFstb0NQogjTdUuyCOOE6GS8=;
        b=pyjIgtvYYCZq1ulLF8LNwQt7Sl/nDQ3XppFoyHmw1eJwuvMAXxlg8F80hj4MeBoFq9
         R5iOZqozeHyQ3OHP3CZH/0g4xNiTkb/rxaYIIXKBRDb8vFt3LJqHjOvOEYR5oZmYtQsF
         UQYBS38BvXlEdvEK634ODFRHdxGfNl2d1sT+GQ3j0NAxZoGN2u5/WFMquzKzkaT1bfj2
         JgBj4SDUAzA6hRNRWM+u0Rvfb/oFnaSTJvktWeNEtoY5hT27qiS3I5BuzREPMEhhBPKx
         YI3C30eJZO8DlF1XyO7HOcum8xwIGD0LHB1CD5pz9v3XpmknMwPa9L5FJ5lO4NCy7XV+
         /ngg==
X-Forwarded-Encrypted: i=1; AJvYcCUFd1jcVcvZTJ23AJMXoAb1bz7el+CykZZWz4nVuHyBR+g10KgeIAf5DxXNiy87oXk/1BSLBwG7pLrtqD0=@vger.kernel.org, AJvYcCWwqr2Pas+i9p/2OXFbJfGFkodDjevAfx580jrk0H7dxHE4qNNUxGa0U4YNJIeh9ev/lNCKR7JdVUBZIAHipcEOfmtqX2kx@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpW81O+zduyMY26EN8dp3RPQ7GS3rJPC6Mu0iZCh/pW0nxGis
	060cptNa/r6GstqGFkB1Ct7eSfA+W66YSSwGkyBz3BqpaGEsAw8DPQPYhwSYfXFQBrKfTvqWCLs
	AYYFkbI6sU9RgQ8r0JwOVcosIAOc=
X-Gm-Gg: ASbGncsbaFck2teWBYNZviSEqoW7GKhL8Qlm2aDpnI4fH/CXQh1Q3h3PJcaTslA57Bc
	6WSlN5rirlIOwTJfexEehbcNTvrYXrWsDzq0hvA==
X-Google-Smtp-Source: AGHT+IHrmCRqfFExnAhLv9dcLlNdemkMwaW4bKMAmg7pQhiPbpFYK1+ayuIlWqVolZOXopVmQvTB0k3x3tm21tGUcfs=
X-Received: by 2002:a05:6000:1faa:b0:385:f17b:de54 with SMTP id
 ffacd0b85a97d-388e4d2f458mr4505774f8f.5.1734556852007; Wed, 18 Dec 2024
 13:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218044711.1723221-1-song@kernel.org> <20241218044711.1723221-5-song@kernel.org>
In-Reply-To: <20241218044711.1723221-5-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 13:20:40 -0800
Message-ID: <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:48=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
>
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -170,6 +330,10 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_AR=
GS)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr_locked, KF_SLEEPABLE | KF_TRUSTE=
D_ARGS)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr_locked, KF_SLEEPABLE | KF_TRU=
STED_ARGS)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)

The _locked() versions shouldn't be exposed to bpf prog.
Don't add them to the above set.

Also we need to somehow exclude them from being dumped into vmlinux.h

>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> @@ -186,6 +350,37 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_se=
t =3D {
>         .filter =3D bpf_fs_kfuncs_filter,
>  };
>
> +/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
> + * KF_SLEEPABLE, so they are only available to sleepable hooks with
> + * dentry arguments.
> + *
> + * Setting and removing xattr requires exclusive lock on dentry->d_inode=
.
> + * Some hooks already locked d_inode, while some hooks have not locked
> + * d_inode. Therefore, we need different kfuncs for different hooks.
> + * Specifically, hooks in the following list (d_inode_locked_hooks)
> + * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
> + * should call bpf_[set|remove]_dentry_xattr.
> + */
> +BTF_SET_START(d_inode_locked_hooks)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
> +BTF_ID(func, bpf_lsm_inode_post_setattr)
> +BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
> +BTF_ID(func, bpf_lsm_inode_rmdir)
> +BTF_ID(func, bpf_lsm_inode_setattr)
> +BTF_ID(func, bpf_lsm_inode_setxattr)
> +BTF_ID(func, bpf_lsm_inode_unlink)
> +#ifdef CONFIG_SECURITY_PATH
> +BTF_ID(func, bpf_lsm_path_unlink)
> +BTF_ID(func, bpf_lsm_path_rmdir)
> +#endif /* CONFIG_SECURITY_PATH */
> +BTF_SET_END(d_inode_locked_hooks)
> +
> +bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> +{
> +       return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->atta=
ch_btf_id);
> +}
> +
>  static int __init bpf_fs_kfuncs_init(void)
>  {
>         return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc=
_set);
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index aefcd6564251..5147b10e16a2 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -48,6 +48,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *pr=
og, bpf_func_t *bpf_func)
>
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>                              struct bpf_retval_range *range);
> +
> +bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
> +
>  #else /* !CONFIG_BPF_LSM */
>
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> @@ -86,6 +89,11 @@ static inline int bpf_lsm_get_retval_range(const struc=
t bpf_prog *prog,
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *pro=
g)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_BPF_LSM */
>
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f27274e933e5..f0d240d46e54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -206,6 +206,7 @@ static int ref_set_non_owning(struct bpf_verifier_env=
 *env,
>  static void specialize_kfunc(struct bpf_verifier_env *env,
>                              u32 func_id, u16 offset, unsigned long *addr=
);
>  static bool is_trusted_reg(const struct bpf_reg_state *reg);
> +static void remap_kfunc_locked_func_id(struct bpf_verifier_env *env, str=
uct bpf_insn *insn);
>
>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>  {
> @@ -3224,10 +3225,12 @@ static int add_subprog_and_kfunc(struct bpf_verif=
ier_env *env)
>                         return -EPERM;
>                 }
>
> -               if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
> +               if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
>                         ret =3D add_subprog(env, i + insn->imm + 1);
> -               else
> +               } else {
> +                       remap_kfunc_locked_func_id(env, insn);
>                         ret =3D add_kfunc_call(env, insn->imm, insn->off)=
;
> +               }
>
>                 if (ret < 0)
>                         return ret;
> @@ -11690,6 +11693,10 @@ enum special_kfunc_type {
>         KF_bpf_get_kmem_cache,
>         KF_bpf_local_irq_save,
>         KF_bpf_local_irq_restore,
> +       KF_bpf_set_dentry_xattr,
> +       KF_bpf_remove_dentry_xattr,
> +       KF_bpf_set_dentry_xattr_locked,
> +       KF_bpf_remove_dentry_xattr_locked,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -11719,6 +11726,12 @@ BTF_ID(func, bpf_wq_set_callback_impl)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(func, bpf_iter_css_task_new)
>  #endif
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID(func, bpf_set_dentry_xattr)
> +BTF_ID(func, bpf_remove_dentry_xattr)
> +BTF_ID(func, bpf_set_dentry_xattr_locked)
> +BTF_ID(func, bpf_remove_dentry_xattr_locked)
> +#endif
>  BTF_SET_END(special_kfunc_set)

Do they need to be a part of special_kfunc_set ?
Where is the code that uses that?

>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -11762,6 +11775,44 @@ BTF_ID_UNUSED
>  BTF_ID(func, bpf_get_kmem_cache)
>  BTF_ID(func, bpf_local_irq_save)
>  BTF_ID(func, bpf_local_irq_restore)
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID(func, bpf_set_dentry_xattr)
> +BTF_ID(func, bpf_remove_dentry_xattr)
> +BTF_ID(func, bpf_set_dentry_xattr_locked)
> +BTF_ID(func, bpf_remove_dentry_xattr_locked)
> +#else
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +#endif
> +
> +/* Sometimes, we need slightly different verions of a kfunc for differen=
t

versions

> + * contexts/hooks, for example, bpf_set_dentry_xattr vs.
> + * bpf_set_dentry_xattr_locked. The former kfunc need to lock the inode
> + * rwsem, while the latter is called with the inode rwsem held (by the
> + * caller).
> + *
> + * To avoid burden on the users, we allow either version of the kfunc in
> + * either context. Then the verifier will remap the kfunc to the proper
> + * version based the context.
> + */
> +static void remap_kfunc_locked_func_id(struct bpf_verifier_env *env, str=
uct bpf_insn *insn)
> +{
> +       u32 func_id =3D insn->imm;
> +
> +       if (bpf_lsm_has_d_inode_locked(env->prog)) {
> +               if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_x=
attr])
> +                       insn->imm =3D  special_kfunc_list[KF_bpf_set_dent=
ry_xattr_locked];
> +               else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_=
dentry_xattr])
> +                       insn->imm =3D special_kfunc_list[KF_bpf_remove_de=
ntry_xattr_locked];
> +       } else {
> +               if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_x=
attr_locked])
> +                       insn->imm =3D  special_kfunc_list[KF_bpf_set_dent=
ry_xattr];

This part is not necessary.
_locked() shouldn't be exposed and it should be an error
if bpf prog attempts to use invalid kfunc.

> +               else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_=
dentry_xattr_locked])
> +                       insn->imm =3D special_kfunc_list[KF_bpf_remove_de=
ntry_xattr];
> +       }
> +}
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> --
> 2.43.5
>

