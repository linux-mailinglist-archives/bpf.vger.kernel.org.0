Return-Path: <bpf+bounces-22551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB48608DE
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 03:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C253F1C21116
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C428F6D;
	Fri, 23 Feb 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLTLopsC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96501BE6B
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655429; cv=none; b=TMmUIO/4+0D26dEl35+SdEmNEJkH84KrcBM2sMrL+ktiNWR+YW/EknWEmObqHbAVNXpe/oxAYk5OTf9oLyQwb0Oor/lS2Yt+eI2CRVC3VxiUEH2so37weNYZ43NkDgGrgESCTm5tYvgsAayf8J/l3LacqR/Ps2O9EExhGJqoEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655429; c=relaxed/simple;
	bh=XyqvKsxZ09XHsvUS5CYWu3sfpvHzNJsKrULcMJSJ7LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+Mr50vrBlntNqFPc6HE9zg64U+F/9Jxl1i3yKU4V2Xz393crMX7gVSHk9NcI1mNYX7v5VU3YjrEU7cGz61TzV0YSCW00EWOlT0Iwx5kgu9iZC7okQJo/tkNhrOna5+4Kb16v+QloGpMeSRsi8cMt/cbUoLK77JwBML8+5wgmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLTLopsC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6868823be58so1782386d6.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708655426; x=1709260226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2jppHheBAu1ajHO4WbeaRwoCfG+eF1z20lWr8PleYA=;
        b=TLTLopsCF6mt5a4LMzXvnl3K0WAS3vbmxSLRXQozmpq+LB2GvoUXAETLBgZQSWDzQv
         F66WTzH3BlAK2jrzbWupp7LAXRQeFhk/FSkNArMvSUzreSLcsPX0k2xhaLe/0XuJdG2t
         zFHo3346L8q+HOlQQHv9vC6DSFEHdr8fpKY+NN62MC6pWTLpZjc3YLLRsER1urmWFdf9
         MBIi/ll14zQh91tetKc2h8bkAtI3LhjydX2J5fJGPJaEIH265xFEgUXjkksfOWTRiWX+
         EfVd9+NUp0x5cYN7b2ZrTFRIetXrNayWGWl00/ynDt/f+0I5r4b6nuKppfVOK+0AdjHr
         97Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708655426; x=1709260226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2jppHheBAu1ajHO4WbeaRwoCfG+eF1z20lWr8PleYA=;
        b=wZMB2XIVkFVhXARNgreCs+ug2pnkUrm61nxNlwEhhCftKGHaRiQYxX9iwOlyVTqT/q
         5CWT9o6FvvBP5PkJG9rLRSBHv/wAj/nsp8qPklXp3wOxbG/kZpv9clIB6qOSSYIe6x6Q
         dLrRbVGRvloRj9N7Jvmt9tGZCJvP6Z9Sk/q8Pau63gqqd5C4xE0UYaLinGL0VQ593erp
         ePsbXQcgcDOm08aEB8RxuelnOzTuA0yNwyHcgLccerbIkJST8ou2HNDp9VLQTO4SCWy5
         8qzLFfU/ZZmzf5hVKdq2zHsjRu+OAprOO8oIfvCiCe9rsaYBiTyxT5Hhrp+MVj9Pe+N1
         kZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXgWCnABsEyONciqMuqc8wA7bcJJLB2CCsJamaEYnoJKBc+vSw1G5GEcRGu0CPOpesWBIGFbKhXiU9j3DLk4lkFpdqp
X-Gm-Message-State: AOJu0YxCsSDuj32zYT+KqF3pjFrykxmiMGtj+8T9bqxdhry+5nV9JVUP
	KlwN+YL7pX3GB9qlwV3wQyXi9hV+Zva07bn2Mh85m1PbuUKB65O3jW3/y8YGnly0/2wY4KbXWX4
	RlW/Gyct6hshKX6OIczugKQSBL3s=
X-Google-Smtp-Source: AGHT+IHPXH1GITJ6S2nJDe2JCL3mL0FppCNwGMyEy4DnSePjypBj5Zk2S1tjI4c0+kyRIlADFDPlVbREOp9mrwdeHsI=
X-Received: by 2002:a0c:f3cd:0:b0:68f:a308:bb4f with SMTP id
 f13-20020a0cf3cd000000b0068fa308bb4fmr890738qvm.2.1708655426423; Thu, 22 Feb
 2024 18:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218114818.13585-1-laoar.shao@gmail.com> <20240218114818.13585-3-laoar.shao@gmail.com>
 <CAADnVQKYWm0PrkZH05q133FwaD5zrDSuBH1sJ5aXxGrVua2SsQ@mail.gmail.com>
In-Reply-To: <CAADnVQKYWm0PrkZH05q133FwaD5zrDSuBH1sJ5aXxGrVua2SsQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 23 Feb 2024 10:29:50 +0800
Message-ID: <CALOAHbCSXrX-igGH0TJTWcKSGg7u6KOfGQrqpwymxf4y1+f2kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Feb 18, 2024 at 3:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add selftests for the newly added bits iter.
> > - bits_iter_success
> >   - The number of CPUs should be expected when iterating over a cpumask
> >   - percpu data extracted from the percpu struct should be expected
> >   - RCU lock is not required
> >   - It is fine without calling bpf_iter_cpumask_next()
> >   - It can work as expected when invalid arguments are passed
> >
> > - bits_iter_failure
> >   - bpf_iter_bits_destroy() is required after calling
> >     bpf_iter_bits_new()
> >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> >   - bpf_iter_bits_next() must use an initialized iter
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   1 +
> >  .../selftests/bpf/prog_tests/bits_iter.c      | 180 ++++++++++++++++++
> >  .../bpf/progs/test_bits_iter_failure.c        |  53 ++++++
> >  .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++
> >  4 files changed, 380 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_fa=
ilure.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_su=
ccess.c
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> > index 01f241ea2c67..dd4b0935e35f 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=3Dy
> >  CONFIG_NF_DEFRAG_IPV4=3Dy
> >  CONFIG_NF_DEFRAG_IPV6=3Dy
> >  CONFIG_NF_NAT=3Dy
> > +CONFIG_PSI=3Dy
> >  CONFIG_RC_CORE=3Dy
> >  CONFIG_SECURITY=3Dy
> >  CONFIG_SECURITYFS=3Dy
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools=
/testing/selftests/bpf/prog_tests/bits_iter.c
> > new file mode 100644
> > index 000000000000..778a7c942dba
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
> > @@ -0,0 +1,180 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> > +
> > +#include <test_progs.h>
> > +#include "test_bits_iter_success.skel.h"
> > +#include "test_bits_iter_failure.skel.h"
> > +#include "cgroup_helpers.h"
> > +
> > +static const char * const positive_testcases[] =3D {
> > +       "cpumask_iter",
> > +};
> > +
> > +static const char * const negative_testcases[] =3D {
> > +       "null_pointer",
> > +       "zero_bit",
> > +       "no_mem",
> > +       "invalid_bits"
> > +};
> > +
> > +static int read_percpu_data(struct bpf_link *link, int nr_cpu_exp, int=
 nr_running_exp)
> > +{
> > +       int iter_fd, len, item, nr_running, psi_running, nr_cpus, err =
=3D -1;
> > +       char buf[128];
> > +       size_t left;
> > +       char *p;
> > +
> > +       iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> > +       if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
> > +               return -1;
> > +
> > +       memset(buf, 0, sizeof(buf));
> > +       left =3D ARRAY_SIZE(buf);
> > +       p =3D buf;
> > +       while ((len =3D read(iter_fd, p, left)) > 0) {
> > +               p +=3D len;
> > +               left -=3D len;
> > +       }
> > +
> > +       item =3D sscanf(buf, "nr_running %u nr_cpus %u psi_running %u\n=
",
> > +                     &nr_running, &nr_cpus, &psi_running);
> > +       if (!ASSERT_EQ(item, 3, "seq_format"))
> > +               goto out;
> > +       if (!ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus"))
> > +               goto out;
> > +       if (!ASSERT_GE(nr_running, nr_running_exp, "nr_running"))
> > +               goto out;
> > +       if (!ASSERT_GE(psi_running, nr_running_exp, "psi_running"))
> > +               goto out;
> > +
> > +       err =3D 0;
> > +out:
> > +       close(iter_fd);
> > +       return err;
> > +}
>
> ..
> > +
> > +       /* Case 1): Enable all possible CPUs */
> > +       CPU_ZERO(&set);
> > +       for (i =3D 0; i < nr_cpus; i++)
> > +               CPU_SET(i, &set);
> > +       err =3D sched_setaffinity(skel->bss->pid, sizeof(set), &set);
> > +       if (!ASSERT_OK(err, "setaffinity_all_cpus"))
> > +               goto free_link;
> > +       err =3D read_percpu_data(link, nr_cpus, 1);
> > +       if (!ASSERT_OK(err, "read_percpu_data"))
> > +               goto free_link;
>
> The patch 1 looks good, but this test fails on s390.
>
> read_percpu_data:FAIL:nr_cpus unexpected nr_cpus: actual 0 !=3D expected =
2
> verify_iter_success:FAIL:read_percpu_data unexpected error: -1 (errno 95)
>
> Please see CI.
>
> So either add it to DENYLIST.s390x in the same commit or make it work.
>
> pw-bot: cr

The reason for the failure on s390x architecture is currently unclear.
One plausible explanation is that total_nr_cpus remains 0 when
executing the following code:

    bpf_for_each(bits, cpu, p->cpus_ptr, total_nr_cpus)

This is despite setting total_nr_cpus to the value obtained from
libbpf_num_possible_cpus():

    skel->bss->total_nr_cpus =3D libbpf_num_possible_cpus();

A potential workaround could involve using a hardcoded number of CPUs,
such as 8192, instead of relying on total_nr_cpus. This approach might
mitigate the issue temporarily.

--=20
Regards
Yafang

