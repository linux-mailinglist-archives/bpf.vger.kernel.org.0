Return-Path: <bpf+bounces-19355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0682A609
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 03:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92731F24367
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABEC15CA;
	Thu, 11 Jan 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvdNN/dl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827F137D
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680d2ec3459so37773776d6.0
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 18:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704940340; x=1705545140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQLQuWE2rLyeBFJtGgzWSLnQZedd3fYvu5wv5dx80s4=;
        b=FvdNN/dl8P9sYD7Mj+pgozb3LK1sPSYLsB2XNWrQtCHcaQfeBZB0sVX86e9Jq+cWcC
         R6zv+BZcQtUxdU05TB4BEJuzklqgFIEfoRX+Nydi2NydY/ZqwVgSskUFSbBKJCzdu+RG
         s+oYAosQBn85sPWxWfSih4BnqHG/EbRb2jrWo0vK6w+o/Q3q/4uM4CUCVSxXG7cUlVI1
         2CoL6a0w8t1aYML4SagAUtgm/bwTM+1CsaZyUS7u9RRyZ6g0dzYmBYUIYmAegbV9MVE3
         59vNs7rgGTF3TKYYrxRvz+VsNvhfFA0HDUnwREtqv1rngNSVwvGf+DBUsCzJz0fhkHBx
         hktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704940340; x=1705545140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQLQuWE2rLyeBFJtGgzWSLnQZedd3fYvu5wv5dx80s4=;
        b=jVhve4+Cv1gDstQoG1GW8aVAlvlaj5E8OfQ+TdpMn+7TUjxhDsXTwGeRH+cOMXVyHT
         M7ZclEnpE0MTEUn7qzZO3sYodqX/9J+bgjaZ75E8mWodDs9zsJFQGUNtxjAT9yODuOq5
         NLIyuYRzi7z/Bju1vKwZaLgFuN2ARys8XqUBupY+6av689WpLkahdx2UwygOQSpISmAL
         VORbhJ2sPLNhKnwM3yI6vmD0XdnyTh9arPMvdrdSSRN8KwMukg/K83yFUyLbjtNLryuO
         uWnep75WaeP3jczh4e6lGkLoKvS1m8VpBd0QCUSmaJrAH/396leRRY5ugQvpMWCscQwp
         7Eww==
X-Gm-Message-State: AOJu0YwM5CaeIEBVylpF1/kdChiFLmcVGmYF7Z9P//dHoj/U7DgdPoDN
	CX/Zmpggz4xxpMfG3/cfPiGKsSpxeNPO2It5xUY=
X-Google-Smtp-Source: AGHT+IGgL+RTMV6p8KOnkDy6sviCzl6tg7h4Bht2E8CuDNQQd5+zwkapMgMKZ4B3MOsDZPJwiF1kCdi2ajSZv9yGfUY=
X-Received: by 2002:a0c:e186:0:b0:680:ccbe:ff24 with SMTP id
 p6-20020a0ce186000000b00680ccbeff24mr45353qvl.17.1704940340324; Wed, 10 Jan
 2024 18:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110060037.4202-1-laoar.shao@gmail.com> <20240110060037.4202-3-laoar.shao@gmail.com>
 <CAADnVQJc8MzBey6fKu1K+WSCCWUCo81-9Pbro6sV77N3r3sTBA@mail.gmail.com>
In-Reply-To: <CAADnVQJc8MzBey6fKu1K+WSCCWUCo81-9Pbro6sV77N3r3sTBA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Jan 2024 10:31:44 +0800
Message-ID: <CALOAHbBN_3cXmrU1r9y_5ighS1M3wn6XbM7o6+rzP=U_wPoURQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpumask iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 9, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > +
> > +SEC("iter/cgroup")
> > +int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cg=
rp)
> > +{
> > +       u32 *cpu, nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0=
;
> > +       unsigned int tasks[NR_PSI_TASK_COUNTS];
> > +       struct psi_group_cpu *groupc;
> > +       struct bpf_cpumask *mask;
> > +       struct task_struct *p;
> > +       struct rq *rq;
> > +
> > +       /* epilogue */
> > +       if (cgrp =3D=3D NULL)
> > +               return 0;
> > +
> > +       mask =3D bpf_cpumask_create();
> > +       if (!mask)
> > +               return 1;
> > +
> > +       p =3D bpf_task_from_pid(target_pid);
> > +       if (!p) {
> > +               bpf_cpumask_release(mask);
> > +               return 1;
> > +       }
> > +
> > +       bpf_cpumask_copy(mask, p->cpus_ptr);
> > +       bpf_for_each(cpumask, cpu, &mask->cpumask) {
> > +               rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
> > +               if (!rq)
> > +                       continue;
> > +               nr_running +=3D rq->nr_running;
> > +               nr_cpus +=3D 1;
> > +
> > +               groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&sys=
tem_group_pcpu, *cpu);
> > +               if (!groupc)
> > +                       continue;
> > +               bpf_probe_read_kernel(&tasks, sizeof(tasks), &groupc->t=
asks);
> > +               psi_nr_running +=3D tasks[NR_RUNNING];
> > +       }
>
> Instead of probe_read_kernel (which is not fast) please use
> bpf_rdonly_cast() and access groups->tasks.
> array should already be recognized by the verifier, but if not let's
> fix the verifier instead of fallback to probe_read.

Thanks for your suggestion.
Will do it.

--=20
Regards
Yafang

