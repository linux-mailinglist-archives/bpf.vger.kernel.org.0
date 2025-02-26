Return-Path: <bpf+bounces-52615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40274A454DC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 06:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F45018978A1
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C522F383;
	Wed, 26 Feb 2025 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHUKbaGX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCA27702;
	Wed, 26 Feb 2025 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547482; cv=none; b=u5rFYhXpN4Ksy4+lAVP/kt38ymkm0fMJQ4T0sors18sWRQmhUNCMxH0bD9d8dLZF2Q+oIxPQb15QaK9iW1T7YpCLQQHvTNC/QkhghZT1Tff7QRaZiG/SU/uFOneLP3lDv8Q2vTkS4kbF6wtxo/pexg+pOziCaJWgLnDZJtj0kXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547482; c=relaxed/simple;
	bh=G90pOcWX1Z+SzDLPl0A42IQphLvwAP2qZb1GAd5q7v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlHtILmEelA8ckViIuWDktTJ3eXoLqII3pqQ11xTL5tBng2jcRM/3DDANBV5JGQmwb1pLhSE8ciodhvbMMvUuY0sVITOs4QZuDzmopZosUvqxnw2qwYp1w0SpmBkPzHc44mWEij3nmvUUjRWlvuiTO6Fci7Ctjk+A6noJIqh1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHUKbaGX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso42010015e9.2;
        Tue, 25 Feb 2025 21:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740547478; x=1741152278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi1ogS3Az0I6GJStO1RYp2yegcWsiDecxnayl6kiJM8=;
        b=PHUKbaGXF6KuEYjSMmbo0kwwOkOJ2EgBjpZYreoPZy1/+tsKgjJYMo/Y3gGkEcYcWK
         uLwDlTiIzpTkzBqi23PH02liHDYNjQ4QrAwYtxqqjHaBKlK4eeSsj4Hdp6g+XpOcto9j
         Z0nup7BiNvozus0G9BhwZgjkxNfbny3hFqXUP76xU2FyzYnPt8F0a7XgvVl7XtlCzvNm
         Xs26pcMvCYg7rF+whNcuEjl3ojPLOytGUb9d9P2I0WFvj3JkgdXVm9YCN6br7f8uV4E3
         mhvauxeA1nBRL3HyH46k8EhEmMzLOqzoR+MzLvYdSN18nTC0SkYUwPFgU8cSdyZJuAu3
         34Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740547478; x=1741152278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi1ogS3Az0I6GJStO1RYp2yegcWsiDecxnayl6kiJM8=;
        b=mmub+RHzWO03wpE908nwJZPNFsNPzFvxhDO3ZYRpicT+2rKoyRQy3G8tK/fKas5mlu
         TE8UB4ezZB0rWkpp63dRk8t1sa9WqAcrgsvK6vzuvUfGnnp6osARMNKF8jvjgRptgyLv
         42eWI8Sl7qBGL5oeeSytQuQ45aQE3dqrPIKldZztXmprlkY1nWx0NP/gt2VLGlgo2NXk
         PKaBCQ/8duFdv6rao+OhTUWQWvePSwdBZKss5Bmnti/mtMv+yw8IXHPZkcDbZKExov4S
         z1UBYcLju9Ourhqu8l35pUOHgyHsBtdaTVVBidU8vlutOaJAri22EpQeyLI/byGnxUZw
         qaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU44qhZ+V+pRlXmV3/VH0OHQao7fw/EeDPV+QRsWyzcB9O2zmpL7xQLrn+KsAe7Zniyn+A=@vger.kernel.org, AJvYcCWh3cPpfmAUHhj273WznDFV+rtmFEscWdbJPhLLKtWmg4R55TNaxl3wgWUHb7gGW2VMaLwEkWbjYESorEDO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/o09pAgLos6IbUBlWHPj7UETFHVpl0vTYQN9vlBIL6ZXkcUG
	9T5BWN/tPu2ZXBHORMedD0fPzStOxVsLlSOaPMTZ7zDsexURoktr+9ymBnuI7qdEyABPHxR73c3
	fgWOiFfJuUUWMb6yriKcvefRltGs=
X-Gm-Gg: ASbGnctK00lNWFHXzKhoSc6IpF01E563CDM1ORJE3tCIBXjjdxmYyWOcCErjUriqUIp
	CFYM5NAq2spAzfpStzVJxfc5cArge+TMfn52cgmGEmURkS3t9NPqZrDRI8GyQzyyAEUhHrF/ucb
	XQHAm+OSql0zau5Xp41goPP9I=
X-Google-Smtp-Source: AGHT+IH/wvoBjrtKyvFZospHbq6cBCwFLwpGP8TtU9MZ512+kxHDitWtBKTVcRhrgza9XtFLNJNwnKv1O5Z1gysZJ3A=
X-Received: by 2002:a05:6000:381:b0:390:d82d:6d51 with SMTP id
 ffacd0b85a97d-390d82d7242mr320054f8f.29.1740547478410; Tue, 25 Feb 2025
 21:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080D59AD7DD5B59E1FB14E599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080D59AD7DD5B59E1FB14E599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 21:24:27 -0800
X-Gm-Features: AQ5f1Jr2UIURRp1Lti-ppy57RX2Us7w0EeeDal7_mR6RAGvM0IXB54MGpg9AtXM
Message-ID: <CAADnVQKnJCdW5OCs338W4ts_mn6JVw7fD5U6w5o6dtc4DSJQrA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/5] sched_ext: Add scx_kfunc_ids_ops_context
 for unified filtering of context-sensitive SCX kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:13=E2=80=AFPM Juntong Deng <juntong.deng@outlook=
.com> wrote:
> +static int scx_kfunc_ids_ops_context_filter(const struct bpf_prog *prog,=
 u32 kfunc_id)
> +{
> +       u32 moff, flags;
> +
> +       if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context, kfunc_id))
> +               return 0;
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL &&
> +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> +               return 0;
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> +           prog->aux->st_ops !=3D &bpf_sched_ext_ops)
> +               return 0;
> +
> +       /* prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_op=
s =3D=3D &bpf_sched_ext_ops*/
> +
> +       moff =3D prog->aux->attach_st_ops_member_off;
> +       flags =3D scx_ops_context_flags[SCX_MOFF_IDX(moff)];
> +
> +       if ((flags & SCX_OPS_KF_UNLOCKED) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
> +               return 0;
> +
> +       if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
> +               return 0;
> +
> +       if ((flags & SCX_OPS_KF_DISPATCH) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
> +               return 0;
> +
> +       if ((flags & SCX_OPS_KF_ENQUEUE) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_i=
d))
> +               return 0;
> +
> +       if ((flags & SCX_OPS_KF_SELECT_CPU) &&
> +           btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
> +               return 0;
> +
> +       return -EACCES;
> +}

This looks great.
Very good cleanup and run-time speed up.
Please resend without RFC tag, so sched-ext folks can review.

From bpf pov, pls add my Ack to patch 1 when you respin.
The set can probably target sched-ext tree too.

