Return-Path: <bpf+bounces-30011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91588C91C7
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF18E1F21907
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46044642D;
	Sat, 18 May 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POK7Wotj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B61BC4B
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716055540; cv=none; b=SlsLV46IRq5oQa9GiTvJN+0OzYPyr/WolpAFcMI9ioHRxiBtMJ7Zdq0wALgE4nExPXyKYZ9msZ6ZUpae677HnPKyGqRJV/e7ggn6X+vOglyuJlBobZLYrARPrdj7bORbR/SbA/TG0zlcLyLA8x6U4I8d5P+GIqIyUTvbn7XwFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716055540; c=relaxed/simple;
	bh=AK4lihbNHXazc4fgbnPI7zt0mA69ORi7kA6WrBvLLBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDugOBg1RSH6yqBvBXNnBsIyIDO9dFe5Z2YpfWhF6pJPsyRITr7/YIn2qXlRboFK/800zwj5ZdEZ3lIt6z0MdAqK1+oq4n1/z9aZQ7O6VBKMnVMaCXP72aOSgpxSzY7dZmh+VYD0MUU3KQ+YnNoC07LO2v5s6IT5Nta09UkUilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POK7Wotj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-351d309bbcfso710907f8f.3
        for <bpf@vger.kernel.org>; Sat, 18 May 2024 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716055537; x=1716660337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7tDvxk1HqeGb3aX7zQXSgaiUf87wzgB2yUfYsZXIkE=;
        b=POK7WotjF+YG/1AWPh9EM+W0eOvzHBtxdMH2etQHMbNYl0dZacE+8joR8Gcsofpj0I
         Zxo4rPY3cLolgN6HUd/bl44CVYHBIB0l5LyWpPjIsqeURUFei27u8U6BGmw/KbCW2VhM
         vQsfigOk+As+gqXNeI7QXgRgI/CnlkPYtphOsghW4tUV1cWQfJG5tfLAffML5O6qiVpO
         T4trrpFJEatlEeEMzeFyJ+ofZxBtaJLlu1u6m4/oNGL97ioG90ND0d5qpH/qXjP104qS
         vJ+oOFFJ1w/tmZzJf0oEBXT8GVq2HSgi4IBBrLPPo3ZhP5BgryHCtLSJNnjTXgftoQJR
         MwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716055537; x=1716660337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7tDvxk1HqeGb3aX7zQXSgaiUf87wzgB2yUfYsZXIkE=;
        b=Uf1MylrPrwKo5wBTnqICZGpMg9xpy+V/drl0iXZlGrNa2mRnDDtDpPV8SociHepVBH
         p0E3sGL6LBpQOVAGmGpIWiCfyYP74+fB9oBr7ugglhJy0RhELfz3nbYszhBUxfGxnRh2
         E4KILcW9BwXdBeYaOLV5PbPEEp3MFSbe5hpn7ONywMzFJkrn+VU0FjOPmcO3BVm4Q0/0
         TtZCnbqlInm/9TrC88zz6Jm0KQIEP4Hw+ILmy0hG4woHbXOMA/hT/smKU/4EDNBLgekn
         /W45xpYXlUQAwKEDr096LGc8P8QQKpXQs7tcHxoESMA4nfuvwmyTZau1NOPL7pKLPLcM
         867A==
X-Gm-Message-State: AOJu0YyVQEwxzZKyGJw2LLCASRlIyXsGPno5OSh5l6vky4WPfX1KEsrp
	wSU9h6hz1Vzmfpo3MPH/1X9JkuvuuuDfPyfn3h49L/45OIhLTl7zLeOFDq9S/fN6GdaF7xVqZjk
	tsQjfHQiVHxgesaOjbe/qbrk8fII=
X-Google-Smtp-Source: AGHT+IGve1aiyUp/zWpys9lL122qEduU/Y5UYPWmTo0I/8ZiTalfrEtWuCNczpXu7fFHTPCX4+d5vUqPcjRDvxf/MKE=
X-Received: by 2002:a5d:6d8d:0:b0:351:d7d8:ef70 with SMTP id
 ffacd0b85a97d-351d7d8f0c2mr7982173f8f.13.1716055536821; Sat, 18 May 2024
 11:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518002942.3692677-1-ramasha@meta.com> <20240518002942.3692677-4-ramasha@meta.com>
In-Reply-To: <20240518002942.3692677-4-ramasha@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 18 May 2024 11:05:25 -0700
Message-ID: <CAADnVQJSF56NiROC6tmut3oq0Ln6T1smV1H+RHzDyi_=Ns3CSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] net: new cgrp_sysctl test suite
To: Raman Shukhau <ramasha@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 5:30=E2=80=AFPM Raman Shukhau <ramasha@meta.com> wr=
ote:
>
> Adding new prog_tests for sysctl BPF handlers, first version with
> a single test to validate bpf_sysctl_set_new_value call
>
> Signed-off-by: Raman Shukhau <ramasha@meta.com>
> ---
>  .../selftests/bpf/prog_tests/cgrp_sysctl.c    | 106 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/cgrp_sysctl.c |  51 +++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgrp_sysctl.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c b/tools=
/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
> new file mode 100644
> index 000000000000..dad847d397de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright 2022 Google LLC.
> + */

hmm ?

> +
> +#define SYSCTL_ROOT_PATH "/proc/sys/"
> +#define SYSCTL_NAME_LEN 128
> +#define RESERVED_PORTS_SYSCTL_NAME "net/ipv4/ip_local_reserved_ports"
> +#define RESERVED_PORTS_OVERRIDE_VALUE "31337"
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +
> +#include <sys/mount.h>
> +
> +#include "test_progs.h"
> +#include "cgrp_sysctl.skel.h"
> +
> +struct sysctl_test {
> +       const char *sysctl;
> +       int open_flags;
> +       const char *newval;
> +       const char *updval;
> +};
> +
> +static void subtest(int cgroup_fd, struct cgrp_sysctl *skel, struct sysc=
tl_test *test_data)
> +{
> +       int fd;
> +
> +       fd =3D open(SYSCTL_ROOT_PATH RESERVED_PORTS_SYSCTL_NAME, test_dat=
a->open_flags | O_CLOEXEC);
> +       if (!ASSERT_GT(fd, 0, "sysctl-open"))
> +               return;
> +
> +       if (test_data->open_flags =3D=3D O_RDWR) {
> +               int wr_ret;
> +
> +               wr_ret =3D write(fd, test_data->newval, strlen(test_data-=
>newval));
> +               if (!ASSERT_GT(wr_ret, 0, "sysctl-write"))
> +                       goto out;
> +
> +               char buf[SYSCTL_NAME_LEN];
> +               char updval[SYSCTL_NAME_LEN];
> +
> +               sprintf(updval, "%s\n", test_data->updval);
> +               if (!ASSERT_OK(lseek(fd, 0, SEEK_SET), "sysctl-seek"))
> +                       goto out;
> +               if (!ASSERT_GT(read(fd, buf, sizeof(buf)), 0, "sysctl-rea=
d"))
> +                       goto out;
> +               if (!ASSERT_OK(strncmp(buf, updval, strlen(updval)), "sys=
ctl-updval"))
> +                       goto out;
> +       }
> +
> +out:
> +       close(fd);
> +}
> +
> +void test_cgrp_sysctl(void)
> +{
> +       struct cgrp_sysctl *skel;
> +       int cgroup_fd;
> +
> +       cgroup_fd =3D test__join_cgroup("/cgrp_sysctl");
> +       if (!ASSERT_GE(cgroup_fd, 0, "cg-create"))
> +               return;
> +
> +       skel =3D cgrp_sysctl__open();
> +       if (!ASSERT_OK_PTR(skel, "skel-open"))
> +               goto close_cgroup;
> +
> +       struct sysctl_test test_data;
> +
> +       if (test__start_subtest("overwrite_success")) {
> +               test_data =3D (struct sysctl_test){
> +                       .sysctl =3D RESERVED_PORTS_SYSCTL_NAME,
> +                       .open_flags =3D O_RDWR,
> +                       .newval =3D "22222",
> +                       .updval =3D RESERVED_PORTS_OVERRIDE_VALUE,
> +               };
> +               memcpy(skel->rodata->sysctl_name, RESERVED_PORTS_SYSCTL_N=
AME,
> +                      sizeof(RESERVED_PORTS_SYSCTL_NAME));
> +               skel->rodata->name_len =3D sizeof(RESERVED_PORTS_SYSCTL_N=
AME);
> +               memcpy(skel->rodata->sysctl_updval, RESERVED_PORTS_OVERRI=
DE_VALUE,
> +                      sizeof(RESERVED_PORTS_OVERRIDE_VALUE));
> +               skel->rodata->updval_len =3D sizeof(RESERVED_PORTS_OVERRI=
DE_VALUE);
> +       }
> +
> +       if (!ASSERT_OK(cgrp_sysctl__load(skel), "skel-load"))
> +               goto close_cgroup;
> +
> +       skel->links.cgrp_sysctl_overwrite =3D
> +               bpf_program__attach_cgroup(skel->progs.cgrp_sysctl_overwr=
ite, cgroup_fd);
> +       if (!ASSERT_OK_PTR(skel->links.cgrp_sysctl_overwrite, "cg-attach-=
sysctl"))
> +               goto skel_destroy;
> +
> +       subtest(cgroup_fd, skel, &test_data);
> +       goto skel_destroy;
> +
> +skel_destroy:
> +       cgrp_sysctl__destroy(skel);
> +
> +close_cgroup:
> +       close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_sysctl.c b/tools/test=
ing/selftests/bpf/progs/cgrp_sysctl.c
> new file mode 100644
> index 000000000000..99b202835f85
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgrp_sysctl.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook

Another odd copy-paste.

Also this new test is failing in CI.

pw-bot: cr

