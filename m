Return-Path: <bpf+bounces-49649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCAA1AF9F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9243A8C04
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6D1D7994;
	Fri, 24 Jan 2025 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjSOG+wi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF41D88D0;
	Fri, 24 Jan 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737694336; cv=none; b=RmKksoWe6DDf1QY20Z38quOrxsZf/j4uIIYUHJIk5gG67qoYTA9raYF//r4nEBIeLjbJaQ5b/6fW3avrkjjJqX/QoXgnxCSU0bEPdlyyLrdGVW749ttIkHA3nkV+e32rF8fkZb8qLyIiiKDbodKbxVn4bJdG7irrXu5Arcod0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737694336; c=relaxed/simple;
	bh=OZzQ/YvXWJVqSWwT5v52gPPHBXTrmiJZJZKhOS2uiYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK4whzuZOwsuidyQTtelL31Y111H7eY7NYy+XUAc9h/ls8pEQB2w64Lo3MWRqW94tlNsHb7g8JBGQ5xwaUfrQ2qw+Xq46oLac4AskvVWCXLic/QdCsqxaaWJz5kisEct+FTvfvAzan2B62emvqup+ccOExL6rnxjnSVpJzGx4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjSOG+wi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so16842345e9.2;
        Thu, 23 Jan 2025 20:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737694332; x=1738299132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq59jD8hBz6G+KdST723bsfh225F3HIXrMqJxbfhVsQ=;
        b=FjSOG+wiTRYMVEXCDPY252ZUkmgiTtxeNGcbZbr4B1uWk3K0RghU8HELN+cDEKH4RP
         i/CEvvheQkmCqlz0tsyNZu+ESv21e65NyHNRnA8++VTE7zE1YrU3XtULDOGBp9IS2R4z
         0LyHTcSWaskKhhxfxNzB4cOfvy0G9KjhFhPNv5FACDqRRBfOvnukWydBYCt0eLBH/BNm
         czqtfg6Jf3T4Ci3x18H+AASpojSpUoIrJk2fVqGdcpPWC80fb22wWmH5flmU6uC+nZlO
         F9+BsQHQXFHAhGLdP8G/HwBNzEi2l2P1GUQ7Z3aWOA0Ncl/jv/UoQxnrQxPKBgEBSKD/
         u3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737694332; x=1738299132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq59jD8hBz6G+KdST723bsfh225F3HIXrMqJxbfhVsQ=;
        b=Grl1qlhqblXhu5BnzLYPlncP6Lfawoy6du9xDKCKHCtlcBnat7jjTuqbhXRNgB78bs
         4vr+h+7uld8oYR8jWCA3NYLELKv86q065FXb2IsiTGJEih/7leq0lWLC8OvO636X8lua
         6M6Zuclbw34teBtZj+9HDx5FTZbG6jjkq7x47js1rNvowkHHLpYDHcHgDDWtB7zaaSdJ
         iibBwn+8DWoF260CS82DRewx7ZWBI+9LhXcNykT22uY/oUMMTD1I4/lv5h3kXhtSakT1
         w0wa3uResLsexllVs4UmB6CfTSxAxvuVRSDHcAWPVpapgi9L/hBEMhU62rSli6MS6YMV
         DT1g==
X-Forwarded-Encrypted: i=1; AJvYcCWdvBrX4lLkpofGAh/DWzxdxhdlWKlIgW/pOkaMnBnYmVdATBI8iu3VQKg96cMLvGckyP4=@vger.kernel.org, AJvYcCXnaUUGwkgdkdA6tXYD2dlPHrqq5F+FOxMM0fl/s0z36xmmcotNECHzf7Quj7jtjS8Zb21BL6+YyZbT7Alr@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHIRNiyPhIDflBP6KlI+JttaE05uJowFtqAYJvonvAbYJMTJc
	E9KfGQwkElBdqHnZp946XS0ystbu6O42U4ZoyVbN46HzjumB9UL1u/QcwkF3237KwdZqFTZGKKP
	cl3ofTqkpNptLdGIJyVE8atP62ng=
X-Gm-Gg: ASbGnctKkq9AOf5+Rr66LQys6f7kjsdLxQSgoFIVnTVduJtB96OWrGEB/kmMTIZdNnK
	7ro1jwpqEmYTp+/s0w2q7HzYLXvNOErlPWEaYavOUTAJDloGuChZ91o3OR7jGBVWKmtqz6OycxE
	3Iuw/NDIY1cXVy5PAfYw==
X-Google-Smtp-Source: AGHT+IG/oZ75RKuUyqkyCKd3S/QIpA2XO8DFqiEgq5UXBnxHb0Jhc5w/25wEOPIrUDSCpbZYJ82+WdWWVQjL6KmFSoE=
X-Received: by 2002:a5d:64a1:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-38bf577ffacmr30534591f8f.16.1737694332256; Thu, 23 Jan 2025
 20:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Jan 2025 20:52:01 -0800
X-Gm-Features: AWEUYZmItfnIElcpoqQtr1JY41xU8xAIQiwKcgkLYSAY8FfwY7pPrSXCAaPQii0
Message-ID: <CAADnVQLidcL-WU-VWXZtBph=qjJfAhoyrsYWyL7JwB0ZEH5KFQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:47=E2=80=AFAM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
> This patch modifies SCX to use BPF capabilities.
>
> Make all SCX kfuncs register to BPF capabilities instead of
> BPF_PROG_TYPE_STRUCT_OPS.
>
> Add bpf_scx_bpf_capabilities_adjust as bpf_capabilities_adjust
> callback function.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/sched/ext.c | 74 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7fff1d045477..53cc7c3ed80b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5765,10 +5765,66 @@ bpf_scx_get_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
>         }
>  }

'capabilities' name doesn't fit.
The word already has its meaning in the kernel.
It cannot be reused for a different purpose.

> +static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabiliti=
es,
> +                                          u32 context_info, bool enter)
> +{
> +       if (enter) {
> +               switch (context_info) {
> +               case offsetof(struct sched_ext_ops, select_cpu):
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_SELECT_CPU);
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_ENQUEUE);
> +                       break;
> +               case offsetof(struct sched_ext_ops, enqueue):
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_ENQUEUE);
> +                       break;
> +               case offsetof(struct sched_ext_ops, dispatch):
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_DISPATCH);
> +                       break;
> +               case offsetof(struct sched_ext_ops, running):
> +               case offsetof(struct sched_ext_ops, stopping):
> +               case offsetof(struct sched_ext_ops, enable):
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_REST);
> +                       break;
> +               case offsetof(struct sched_ext_ops, init):
> +               case offsetof(struct sched_ext_ops, exit):
> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_S=
CX_KF_UNLOCKED);
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       } else {
> +               switch (context_info) {
> +               case offsetof(struct sched_ext_ops, select_cpu):
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_SELECT_CPU);
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_ENQUEUE);
> +                       break;
> +               case offsetof(struct sched_ext_ops, enqueue):
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_ENQUEUE);
> +                       break;
> +               case offsetof(struct sched_ext_ops, dispatch):
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_DISPATCH);
> +                       break;
> +               case offsetof(struct sched_ext_ops, running):
> +               case offsetof(struct sched_ext_ops, stopping):
> +               case offsetof(struct sched_ext_ops, enable):
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_REST);
> +                       break;
> +               case offsetof(struct sched_ext_ops, init):
> +               case offsetof(struct sched_ext_ops, exit):
> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_=
SCX_KF_UNLOCKED);
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}

and this callback defeats the whole point of u32 bitmask.

In earlier patch
env->context_info =3D __btf_member_bit_offset(t, member) / 8; // moff

is also wrong.
The context_info name is too generic and misleading.
and 'env' isn't a right place to save moff.

Let's try to implement what was discussed earlier:

1
After successful check_struct_ops_btf_id() save moff in
prog->aux->attach_st_ops_member_off.

2
Add .filter callback to sched-ext kfunc registration path and
let it allow/deny kfuncs based on st_ops attach point.

3
Remove scx_kf_allow() and current->scx.kf_mask.

That will be a nice perf win and will prove that
this approach works end-to-end.

