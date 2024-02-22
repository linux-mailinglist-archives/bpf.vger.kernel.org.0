Return-Path: <bpf+bounces-22517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E001185FF86
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22161B21EA5
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE920155A25;
	Thu, 22 Feb 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+jGkCIw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9487153BFD
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623421; cv=none; b=WVnlZ75vKxSuNnF8aL8a7Qn9GvLfKg4ciZqJ+fIoRhLLxwCiwGMjwFHtbIdYXmjcRfEl8QAKUw/i/OOfC4S1+9tHXiJAWyqGZi+QBDWRvr/cijJZzJlEHQZdedFqaAHPtQiX2MGc+iaKleMw7IkfNahpgAhIjy38/Zc2AIomJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623421; c=relaxed/simple;
	bh=WwAjaDJ+O4bbPjEu6nHRQtQSff9Ggdo5p7pAKHF+mzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKFC+f1j6bvsLEzE7cG0MbnA5iuSvlC+Qrh73XRiqY0iaA7GJriS7wBPWdxxk5T4DB/zN/y/c0uQagMpRlFAnT2Hk4hHtyc8rJDBgqzAt9+MtzgkXGtNzTBGA4hg56aKN4OQpacEL7zz0rJmcv5vrsyr1Tp2JmcqPGZlWsZhT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+jGkCIw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d36736d4eso3783626f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708623418; x=1709228218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JrU5xUzGLyCO9tEgw1sV3t+N3Hg2nw1nxbEr8hYYbo=;
        b=S+jGkCIwx8TEHcKNZEhDMauXPuKTopaJlhwGN4/lseeZnf6iTfgp95raTamB5dhbk/
         x+6QdTI8M2VLdC5yoips5Gl2axOZLbEBYKyo8OSDymjBw1Oq4wT/3OAGwm3hrIbbbcfb
         9ZiVCgCuK4gjuIhuteqSG97cmudTlepw1X+Uvhwd/dTAdETmLLUGCKdn1oj0Bgg91ZiR
         NennUvzJcl91wMetFqTFXn56hScgxUWDuOgGXtV+vuhhQPMX1dnv2RmDMlmBDLSzMw2d
         PZtoCei/wwlp8L0wCAAFdPf0HdemqmkLlwoXMYYXizWxfl+a0DEg0euzsHEzpwYjUJ+b
         K/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623418; x=1709228218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JrU5xUzGLyCO9tEgw1sV3t+N3Hg2nw1nxbEr8hYYbo=;
        b=mhjerPEbu5uhaspNZHtxAWFEQoC0hp7LX6rW9+jYs3CfsUMMGNbDxt8g6WdRf2DJNX
         7YAhMmtrsexZfsOVmrYU8JVJSTq34ybR8RdRNJAyt9OJ+m/WUSngCLIwQRgNDJLntoDF
         kKpepW40TwI1DfBXmHRwhXeIKQULqoq1mZz+F+UDrAHLRcrGtw60H9yKCeVHntf/ruet
         MIGKgRF2ifj0bvNDErilrPMS3doOQU7FfGuKAqKtCu6PbV+JSmXMA6Lc7s0WmvxnyHfo
         Ou6apHxvjKYpAm8++rUacMq2u7OWUVbyOLE9OMl0HwS/qNSsYYGwDrkiTjtg851rfREu
         iGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWp5QdbRv1jul4dNKjNsys48rqh3gg/cGrL2jYIajtgubXZC4jAiWTEpiTE0K0LJBltnvuXv4vDEx3WZC6XYu3Nv+3T
X-Gm-Message-State: AOJu0YxLhqZEBYU5tGBUuhlXyeHOdZFLqdIvR6u1deEpudcf+3fXTr3X
	QrEeTxI4F50zyccDrZna9DGGHqwmmJbHUPwx9fS+/ZJRxonRitU4eACuxOxV8CS+82z/6TuGH1E
	1viOOD30JI495GiUHRM9yXZzDvww=
X-Google-Smtp-Source: AGHT+IEjOO68VMGeNLT/diMuukLGFAVUbuODihaKHEDZPPs7u5WBHfurWdsOWLKiciwIA0/G6zFU7SmxTtd2YkIDivA=
X-Received: by 2002:adf:f647:0:b0:33d:7e42:e3de with SMTP id
 x7-20020adff647000000b0033d7e42e3demr3467524wrp.16.1708623417747; Thu, 22 Feb
 2024 09:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218114818.13585-1-laoar.shao@gmail.com> <20240218114818.13585-3-laoar.shao@gmail.com>
In-Reply-To: <20240218114818.13585-3-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 09:36:46 -0800
Message-ID: <CAADnVQKYWm0PrkZH05q133FwaD5zrDSuBH1sJ5aXxGrVua2SsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 3:49=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftests for the newly added bits iter.
> - bits_iter_success
>   - The number of CPUs should be expected when iterating over a cpumask
>   - percpu data extracted from the percpu struct should be expected
>   - RCU lock is not required
>   - It is fine without calling bpf_iter_cpumask_next()
>   - It can work as expected when invalid arguments are passed
>
> - bits_iter_failure
>   - bpf_iter_bits_destroy() is required after calling
>     bpf_iter_bits_new()
>   - bpf_iter_bits_destroy() can only destroy an initialized iter
>   - bpf_iter_bits_next() must use an initialized iter
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/bits_iter.c      | 180 ++++++++++++++++++
>  .../bpf/progs/test_bits_iter_failure.c        |  53 ++++++
>  .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++
>  4 files changed, 380 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_fail=
ure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_succ=
ess.c
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 01f241ea2c67..dd4b0935e35f 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=3Dy
>  CONFIG_NF_DEFRAG_IPV4=3Dy
>  CONFIG_NF_DEFRAG_IPV6=3Dy
>  CONFIG_NF_NAT=3Dy
> +CONFIG_PSI=3Dy
>  CONFIG_RC_CORE=3Dy
>  CONFIG_SECURITY=3Dy
>  CONFIG_SECURITYFS=3Dy
> diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/t=
esting/selftests/bpf/prog_tests/bits_iter.c
> new file mode 100644
> index 000000000000..778a7c942dba
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +
> +#include <test_progs.h>
> +#include "test_bits_iter_success.skel.h"
> +#include "test_bits_iter_failure.skel.h"
> +#include "cgroup_helpers.h"
> +
> +static const char * const positive_testcases[] =3D {
> +       "cpumask_iter",
> +};
> +
> +static const char * const negative_testcases[] =3D {
> +       "null_pointer",
> +       "zero_bit",
> +       "no_mem",
> +       "invalid_bits"
> +};
> +
> +static int read_percpu_data(struct bpf_link *link, int nr_cpu_exp, int n=
r_running_exp)
> +{
> +       int iter_fd, len, item, nr_running, psi_running, nr_cpus, err =3D=
 -1;
> +       char buf[128];
> +       size_t left;
> +       char *p;
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(link));
> +       if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
> +               return -1;
> +
> +       memset(buf, 0, sizeof(buf));
> +       left =3D ARRAY_SIZE(buf);
> +       p =3D buf;
> +       while ((len =3D read(iter_fd, p, left)) > 0) {
> +               p +=3D len;
> +               left -=3D len;
> +       }
> +
> +       item =3D sscanf(buf, "nr_running %u nr_cpus %u psi_running %u\n",
> +                     &nr_running, &nr_cpus, &psi_running);
> +       if (!ASSERT_EQ(item, 3, "seq_format"))
> +               goto out;
> +       if (!ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus"))
> +               goto out;
> +       if (!ASSERT_GE(nr_running, nr_running_exp, "nr_running"))
> +               goto out;
> +       if (!ASSERT_GE(psi_running, nr_running_exp, "psi_running"))
> +               goto out;
> +
> +       err =3D 0;
> +out:
> +       close(iter_fd);
> +       return err;
> +}

..
> +
> +       /* Case 1): Enable all possible CPUs */
> +       CPU_ZERO(&set);
> +       for (i =3D 0; i < nr_cpus; i++)
> +               CPU_SET(i, &set);
> +       err =3D sched_setaffinity(skel->bss->pid, sizeof(set), &set);
> +       if (!ASSERT_OK(err, "setaffinity_all_cpus"))
> +               goto free_link;
> +       err =3D read_percpu_data(link, nr_cpus, 1);
> +       if (!ASSERT_OK(err, "read_percpu_data"))
> +               goto free_link;

The patch 1 looks good, but this test fails on s390.

read_percpu_data:FAIL:nr_cpus unexpected nr_cpus: actual 0 !=3D expected 2
verify_iter_success:FAIL:read_percpu_data unexpected error: -1 (errno 95)

Please see CI.

So either add it to DENYLIST.s390x in the same commit or make it work.

pw-bot: cr

