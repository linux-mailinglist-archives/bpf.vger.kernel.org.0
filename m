Return-Path: <bpf+bounces-47333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC719F7EE0
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2234C7A3D34
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE15226894;
	Thu, 19 Dec 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2VhsN0O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABDA143895;
	Thu, 19 Dec 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624357; cv=none; b=MHP4PRoEN1g0AEMtSoapv+JmHpU7GPSMsLhIXa9kcs5eJ0fLNzSl20ySwM25bZAeccolY01y60PclEr3nDBiC5+Z/+RECwubqEgWzILBC1vEg+1pce/nxGUZZB0I3Er1WZd/FMw2Rp0pBjxDlOzoamTbRCT010sNqqJ/lxDVcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624357; c=relaxed/simple;
	bh=K+jbPgvMzgj1ziZA052uh5kiEoslytI3nUGjoHGAEj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDZvsFoVe/HbTRPGOLfJTsnE2SB24ktBv584S7M457071Qzy1Ow1U+kmQRMyhyg97FCwVGyoauG79XVkG7FJ8ufnSmZxET5ve85lbcAqxlD84NQwQ9adm4G+oEgRB98+Z/H7UoubMCWZyLypgzuA6M9yicbqr1RhmyDGJgzxZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2VhsN0O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863c36a731so731773f8f.1;
        Thu, 19 Dec 2024 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734624353; x=1735229153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z917kOVPARb8dKIs9uBD/0/reoE5C4OJp1UlmVGQFbU=;
        b=k2VhsN0OF6/JOL7iws+lxAMlBXCMGDh2ZKrzI4N6kOP+pGcVWXbOys7Pv/H9xDAdlz
         v0Z8y0TfWwemuy+lN3e80tvHTwQ/30O7kCFAAzK60vGCVGfKpJlii2eqr1aK0LCQDiWA
         LqfJd+vOKxVam2cumvEzMPnLdFxEIh88aM/punqcHg2sIt+mxRD8w1YU8UpeNl4PJmar
         +FXvPrgmqmbMbPzu05zpKhOGlZpeSBPAomzCOGnXwSCuHt4B6rd49GpzE3vKqTGqeOzz
         /dxdRD1ou3jY0U0Mcs86xA/SiXmnXl/5qq3Y/f5oREBE2dci+4YhvsKBp+ytVdX4G9J0
         O3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624353; x=1735229153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z917kOVPARb8dKIs9uBD/0/reoE5C4OJp1UlmVGQFbU=;
        b=SUangQzzwuWDlv1zuZjTumzeKbppaxEBKQLeUKwOyqL61Mns2Uk0yNaTNbxS2wNpON
         LheIv9gPL0JQIYTn0s922YZ+elshsQuuvquVAa09UYAwiomo2H1BYTB4MQ1TFywK4zRR
         6CzVAKaDa7cmFbdfuhTvveyg9sdQbDZVxGj8vhwnpUF4DnOR9+SKQqVgVak+oX0Dj5Zf
         JkDniV6a8+hJpgKiocSAg1926WUbJW5oK4eAaXWm4IUcC/3tC+NSoXy9K/uXvSzJmNhh
         kIc5n6QjHrWhKh5wMNFfLUaoWS8xpI97lDdfbNdpExeUfMU/ViRemPx2A2zXkeXf6Yr/
         tteg==
X-Forwarded-Encrypted: i=1; AJvYcCUlcj6JXcKHoqKjIzv2vvvAKTKFDsvHXdu8jG4U8Qn4eK3sazzgPVYGVpGU8bciBERrd7I317JpIdzD5Li3@vger.kernel.org, AJvYcCXBd7IybVwqJ8FlNHQbRmgCby9a/vpCjvPvSQNKJ/cvT1NyNmu/ha9Tqx7RYNj5J6Wm4YjtdbhQ@vger.kernel.org, AJvYcCXUOqXa+vjx/VCjYZUi0ERK1usD4ImSVQo6RJHuGu99IvQ6CeeGiMc42TF/eRS6IB9O+aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+mP0sJDLRjjI0n1isgcZ2o4Q6GsiYBXhf2ul67AGSKcycS+C
	hRjsjbSdaBqlGR168VoiDjuCoyBpvDMLkm1xQnmICIQtzsGVOo+KH9gOiRctCVioiq/crGkfW5l
	9W5YeJSxDbRIuYT8Qgx7CQ6Ipa1A=
X-Gm-Gg: ASbGncuSVaragiGD1esTZGuI38ELNoilwavdOGvpNaQTIU7L5N4z06RayTTUEyeEOAq
	s98boseNLQwhenSijgZ+p5vyCMvvlsZVW96hW0hMh
X-Google-Smtp-Source: AGHT+IF4qH4MjsPrc029Wu90m92Gv0fVSgURCC1A2GlOpIw7H3s64v8s4SE4MhgK/yfKS7M/UQE4Ej/xAHod+0Uwx5Q=
X-Received: by 2002:a5d:5f4f:0:b0:386:3262:28c6 with SMTP id
 ffacd0b85a97d-388e4d310d8mr7377658f8f.5.1734624353030; Thu, 19 Dec 2024
 08:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-bpf-cond-ids-v2-1-8f121cae5374@weissschuh.net>
In-Reply-To: <20241219-bpf-cond-ids-v2-1-8f121cae5374@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Dec 2024 08:05:42 -0800
Message-ID: <CAADnVQJQpVziHzrPCCpGE5=8uzw2OkxP8gqe1FkJ6_XVVyVbNw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: fix configuration-dependent BTF function references
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 11:24=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> These BTF functions are not available unconditionally,
> only reference them when they are available.
>
> Avoid the following build warnings:
>
>   BTF     .tmp_vmlinux1.btf.o
> btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in BT=
F
> btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
>   NM      .tmp_vmlinux1.syms
>   KSYMS   .tmp_vmlinux1.kallsyms.S
>   AS      .tmp_vmlinux1.kallsyms.o
>   LD      .tmp_vmlinux2
>   NM      .tmp_vmlinux2.syms
>   KSYMS   .tmp_vmlinux2.kallsyms.S
>   AS      .tmp_vmlinux2.kallsyms.o
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Properly use BTF_ID_UNUSED in special_kfunc_list()
> - Link to v1: https://lore.kernel.org/r/20241213-bpf-cond-ids-v1-1-881849=
997219@weissschuh.net
> ---
>  kernel/bpf/helpers.c  |  4 ++++
>  kernel/bpf/verifier.c | 11 +++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 751c150f9e1cd7f56e6a2b68a7ebb4ae89a30d2d..5edf5436a7804816b7dcf1bbe=
f2624d71a985f20 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3089,7 +3089,9 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
> +#ifdef CONFIG_BPF_EVENTS
>  BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> +#endif
>  BTF_KFUNCS_END(generic_btf_ids)
>
>  static const struct btf_kfunc_id_set generic_kfunc_set =3D {
> @@ -3135,7 +3137,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +#ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> +#endif
>  BTF_ID_FLAGS(func, bpf_wq_init)
>  BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
>  BTF_ID_FLAGS(func, bpf_wq_start)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 77f56674aaa99a0b88ced5100ba57409e255fd29..2704fa4477ee2504897c82f04=
16aa7d61fb086ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5507,7 +5507,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
>
>  /* Once GCC supports btf_type_tag the following mechanism will be replac=
ed with tag check */
>  BTF_SET_START(rcu_protected_types)
> +#ifdef CONFIG_NET
>  BTF_ID(struct, prog_test_ref_kfunc)
> +#endif
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(struct, cgroup)
>  #endif
> @@ -5515,7 +5517,9 @@ BTF_ID(struct, cgroup)
>  BTF_ID(struct, bpf_cpumask)
>  #endif
>  BTF_ID(struct, task_struct)
> +#ifdef CONFIG_CRYPTO
>  BTF_ID(struct, bpf_crypto_ctx)
> +#endif
>  BTF_SET_END(rcu_protected_types)
>
>  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> @@ -11486,8 +11490,10 @@ BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rbtree_remove)
>  BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
> +#ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
> +#endif
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
>  BTF_ID(func, bpf_dynptr_clone)
> @@ -11515,8 +11521,13 @@ BTF_ID(func, bpf_rcu_read_unlock)
>  BTF_ID(func, bpf_rbtree_remove)
>  BTF_ID(func, bpf_rbtree_add_impl)
>  BTF_ID(func, bpf_rbtree_first)
> +#ifdef CONFIG_NET
>  BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
> +#else
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +#endif

The previous patch was already applied and it's too late
to revert.
Pls send an incremental fix with:
Fixes: 00a5acdbf398 ("bpf: Fix configuration-dependent BTF function referen=
ces")

pw-bot: cr

