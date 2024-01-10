Return-Path: <bpf+bounces-19329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74BB829FBA
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D971D1C21B1F
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD094D100;
	Wed, 10 Jan 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADSlyfcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA4878C
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3375a236525so3693380f8f.0
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704909139; x=1705513939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5a1/PeB0/x2QQ9GmeyF3u8gNKl+K/1e1Jf5A7J9crU=;
        b=ADSlyfcRixW4Zp3DJ9iNMeodEx6uKl9b7DDBzj0KIf4ctmY70HpQW02DcGfbP6M6Am
         qolFfm9cITQQi3pAb0l7POeHMUXMRds5Udvd97bGzEZMvjBRzkoixshWk1f4qNc3hZR3
         nOmdg/KaU5nFqpee2njrbSQQTuDBoLi3ia3equ/d7ZvWnGy0yzgbyCuUROZ3C5E4C4tg
         o0OAjdqvP1fkgBwY9WLuwZdAYAMigEJeUhsSWzmzfrYngRxv84f5FjD+fta4v0Q0m3rl
         Cn1rOwFAI0wCBld7npKCiKTWY9nfexk7N48Vo8yjKq7BcJcVpiufwok4A4S8R8rI/OCC
         hZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909139; x=1705513939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5a1/PeB0/x2QQ9GmeyF3u8gNKl+K/1e1Jf5A7J9crU=;
        b=Sclc311ckxWmuZC5BQRwDF5cCWO0O7agEjh6zz8NfH/b5wnkf2jd1HGnKrbLw9CMyE
         yGh+x/BT7oNyHOcretKF0cZ8VYeNuvWSYWV2pcesbRQtqiz/8/x13JqDakK704iaSTDt
         UFj1Wx41Zqx5bjiMJdYSa/+lbuH0lr9wurT1WPOlo9HagsJWBdKZwfm6v4fAkEc/+JSC
         MFx2/Sh0mOHSD979MhOVVWgXe17+VI5AismFqmnKllAvCqWFLPVxhOQ8iY++jUs/ZYGt
         IZsryULWX8PnMmTVO6oiiFi/ntojSHJU04L+wrWFeC68YQwbVgCnl4on9CvhHsSRXYog
         m8mw==
X-Gm-Message-State: AOJu0Yx6BDMf7z0Papz0hW5HDxPdslisL+Ez4lo2498SgUwZJEvsl6tx
	bCKokWcDcNt7EoOyZ9xpcNezGpplbAgxF9FHr/4=
X-Google-Smtp-Source: AGHT+IEH8DEBg6az7jbn3m2omuJ/CgHRz89+5r9iDiAFZxy8rxPfGvKQhQrIInYkgszohIO9w7ywiNL70Y2px9M9J88=
X-Received: by 2002:a5d:6984:0:b0:337:68ab:6184 with SMTP id
 g4-20020a5d6984000000b0033768ab6184mr812465wru.26.1704909138618; Wed, 10 Jan
 2024 09:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110060037.4202-1-laoar.shao@gmail.com> <20240110060037.4202-3-laoar.shao@gmail.com>
In-Reply-To: <20240110060037.4202-3-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jan 2024 09:52:07 -0800
Message-ID: <CAADnVQJc8MzBey6fKu1K+WSCCWUCo81-9Pbro6sV77N3r3sTBA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpumask iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
> +
> +SEC("iter/cgroup")
> +int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp=
)
> +{
> +       u32 *cpu, nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0;
> +       unsigned int tasks[NR_PSI_TASK_COUNTS];
> +       struct psi_group_cpu *groupc;
> +       struct bpf_cpumask *mask;
> +       struct task_struct *p;
> +       struct rq *rq;
> +
> +       /* epilogue */
> +       if (cgrp =3D=3D NULL)
> +               return 0;
> +
> +       mask =3D bpf_cpumask_create();
> +       if (!mask)
> +               return 1;
> +
> +       p =3D bpf_task_from_pid(target_pid);
> +       if (!p) {
> +               bpf_cpumask_release(mask);
> +               return 1;
> +       }
> +
> +       bpf_cpumask_copy(mask, p->cpus_ptr);
> +       bpf_for_each(cpumask, cpu, &mask->cpumask) {
> +               rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
> +               if (!rq)
> +                       continue;
> +               nr_running +=3D rq->nr_running;
> +               nr_cpus +=3D 1;
> +
> +               groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&syste=
m_group_pcpu, *cpu);
> +               if (!groupc)
> +                       continue;
> +               bpf_probe_read_kernel(&tasks, sizeof(tasks), &groupc->tas=
ks);
> +               psi_nr_running +=3D tasks[NR_RUNNING];
> +       }

Instead of probe_read_kernel (which is not fast) please use
bpf_rdonly_cast() and access groups->tasks.
array should already be recognized by the verifier, but if not let's
fix the verifier instead of fallback to probe_read.

