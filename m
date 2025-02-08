Return-Path: <bpf+bounces-50843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FEA2D386
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 04:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D6C188F06F
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B21684A4;
	Sat,  8 Feb 2025 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A02lsO47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5527702;
	Sat,  8 Feb 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738985885; cv=none; b=d/jok7EbKIGObQ61ToJ/aOQrFsd16Iech1pd9smkYLlGjHWaQ38mTaN4SzCStgY+rPTC8j9fmL9IaaNmQ0c5sYbAb9QkZNwAeshXds13+pQE3l/4FuD8S25AZ09Ug3BlSlwVpa0UmwoAaW56eMRSCof3LR8t9rinsLdFSxSlwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738985885; c=relaxed/simple;
	bh=NunAJs4bH+Jj4+K96Vx34sPeS5kTxaTrScr8redH9YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8GAJIx31Z1HBbv+sba4zYYIbwgswMe8JBpf4rtCc8j13+fS+NCIF/lUIpf5MilmadDsPNuWFQF70/y+mXES4YED9D/VOIZKAfYz5mgKvkKujKKHlFP5ZRd/A7HbVZPzNyQo1coW+dkawHUYl/QjQQjDII0aLSKiOdmvw3d0Yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A02lsO47; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso2791973f8f.2;
        Fri, 07 Feb 2025 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738985882; x=1739590682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAajHkAcxxVCRGE1mUQ7VLgo1vxl4tsrpLghCF95uS8=;
        b=A02lsO47AQpC/bjD1AwsQk7vflj8Jtid80sfTo0c6kPdf3YGMGkcG11FdGRePmq6pP
         KLcCYMPdoXC3T1BGDMuHbuk/xajFyg4QN9p3bVpQA8PL/a4CGfYHgqv1qqYBz3Dh8YXF
         0qGixMuHqf/WTzTb9yjZIN0CrnSe0fphEoBWZ0f29mtvhrhP+BvfHTMdLJLgHJ3G/Vir
         g356VGhB4bIeANBgte40mXSrMKqSNr3tySRTHuFyYUO3ieSGlaupvrjad1AyC7ij0NyH
         sJcJGP6Py0RdgUl/G8XjtIf+7bznZuRr6PlssLFUXvWWwffHCCSgDcY876MNKEkYs2eN
         pLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738985882; x=1739590682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAajHkAcxxVCRGE1mUQ7VLgo1vxl4tsrpLghCF95uS8=;
        b=EbzPsqESFaxhUNmwO+OwywJyubdG1Gg7REtQ03JA+OBpbxanXrSPL2aSYFLPfW8/5U
         BwETSEnYKpfG944S8AJm8wEz7kePw46JxaWtL/vbbVFzAj8VSBQkntGz9Ciwb/w9TUvP
         07FpxbBVdAKuwvDdllINfsRPdhQMqYV0qbz8P+CiC4QNEP6mbpyvxZQi7ea4tyVvJYQW
         nb50cLCxxv3vOXZVIF8xpld+gnDj3dMzM7dlZThUuIjMm/2YYHSUqyuInQK1ZDU9gjx5
         C4gWZM2BJxoIOnGwhMCheVNAtlveI0K58vJsPLikh/YBQLbRuMPGSRGPFW++OgZHA9Dy
         PQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeXktnqAgWIJArBYFuvQ7MLNY0iQ8s/qgctqL+qeP3/3dmHXto2qkFz2IJkQXNhepgyjYc5FnOZfoDTVHT@vger.kernel.org, AJvYcCXmMxtQgT1nDWHf2+q6OlZ7KZT61uIvAsAGAT7HLovsjrCYoFwbiA5xMBphy9M9D3H1oxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqR5RFv2/5MbgK03RtCkw6CNVydAIYir9glN8ppDC1lESomDvt
	bVxLabN7wf7iVSsszUcpTHVjt70byFM73MKLHsJl1mXDF3EZZARORzVgY2W2gUehJLpCFD1AUKL
	T1MSZb0iPVfc+MzuSacOD1YMGJYc=
X-Gm-Gg: ASbGnctzo+7Q7+uzSIgY6bKJ1wF5SRvJgt+raSlYXBVOvfwYmW7f6elarWxxaPkcBeJ
	F3O8L/2RGs2fi2ndHClaZA9UKPqhLIFzKSjLHA3BbM+UP1HqX85BaclH9ruRBbFvuEF0vKpaMpU
	paVrro+6bhoarPQVEETOTU7YCxIx5j
X-Google-Smtp-Source: AGHT+IEqWSGNaokGM3+Q+Qi27BYRg7z8pN/7S0p7MVWi7u9FdwgIOo4FESwJAbGtXnIUFzUfBVmmHFgZPC2JzCquGFo=
X-Received: by 2002:a5d:588d:0:b0:38d:a883:b95b with SMTP id
 ffacd0b85a97d-38dc90f1277mr4650677f8f.28.1738985881846; Fri, 07 Feb 2025
 19:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 19:37:51 -0800
X-Gm-Features: AWEUYZk4QqmyiW49bO-_h28Xx_PqBsFr_xfZsG6i7y5oe-FBacwGLb75TqgjTh0
Message-ID: <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for scx_kfunc_ids_unlocked
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, changwoo@igalia.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:35=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds filter for scx_kfunc_ids_unlocked.
>
> The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit,
> cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
> cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
> operations.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7f039a32f137..955fb0f5fc5e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_R=
CU)
>  BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>
> +static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog, u3=
2 kfunc_id)
> +{
> +       u32 moff;
> +
> +       if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
> +           prog->aux->st_ops !=3D &bpf_sched_ext_ops)
> +               return 0;
> +
> +       moff =3D prog->aux->attach_st_ops_member_off;
> +       if (moff =3D=3D offsetof(struct sched_ext_ops, init) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, exit) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cpu_online) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cpu_offline) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, init_task) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, dump))
> +               return 0;
> +
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +       if (moff =3D=3D offsetof(struct sched_ext_ops, cgroup_init) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_exit) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_prep_move) =
||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_cancel_move=
) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_move) ||
> +           moff =3D=3D offsetof(struct sched_ext_ops, cgroup_set_weight)=
)
> +               return 0;
> +#endif
> +       return -EACCES;
> +}
> +
>  static const struct btf_kfunc_id_set scx_kfunc_set_unlocked =3D {
>         .owner                  =3D THIS_MODULE,
>         .set                    =3D &scx_kfunc_ids_unlocked,
> +       .filter                 =3D scx_kfunc_ids_unlocked_filter,
>  };

why does sched-ext use so many id_set-s ?

        if ((ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                             &scx_kfunc_set_select_cpu)) ||
            (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,

&scx_kfunc_set_enqueue_dispatch)) ||
            (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                             &scx_kfunc_set_dispatch)) ||
            (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                             &scx_kfunc_set_cpu_release)) |=
|
            (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                             &scx_kfunc_set_unlocked)) ||

Can they all be rolled into one id_set then
the patches 2-6 will be collapsed into one patch and
one filter callback that will describe allowed hook/kfunc combinations?

