Return-Path: <bpf+bounces-12105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4777C7AB5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 02:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5BB20902
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA4805;
	Fri, 13 Oct 2023 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrik/576"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CB7F1
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 00:03:58 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F924DD
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:03:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53da80ada57so2760926a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697155435; x=1697760235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AToyHNdJ2xO7C5AgQlI56+sd06EQngw3erdKahL80t0=;
        b=Wrik/576wmGDTeFbS00QeNZsOzW95D7XMII/LJ22uM6pZ9wlDDgAZEU47mPH8DBuTk
         yzfrQxc75hIAOOWlCy7BAlf/nyClEbKhuvUWJfCD4p625g5L2lf+J5iI5vs1Jdwek6iT
         TG22nHQIggJRKurmCtbJ7iZUzsmHZzkpjcBUOol8ajF4ODYSvzHzB0Euh66NxC3N9lq+
         JEDLNuLjagB9FUINk26K4Woci8e+8ktXy9uvs/QB2J6MWQUkjya2zbz8dR5IdjvtFqK/
         mAjmmB6TEAfeHN46PntfzeuNMGOJ69ls3YAK4KUOYCaw/DXby3x5aoyOucIWOHqxLTl1
         uYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155435; x=1697760235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AToyHNdJ2xO7C5AgQlI56+sd06EQngw3erdKahL80t0=;
        b=o1RazL6nPNeiGBgdI6k58qm68iWj/Pwv8IuV0SDdFujRNRMLbUvJ6fekQd8G59apUM
         tFsZF3XC4VsPxPmRH4NUfhVePfThrSkyC2v2tMEM5dMDBhXXY9XL95jt4ahqnQwKnwTn
         nh+QU4mIN2E7O8i4VcC7v3vlOJt2b7we7JgpaShsjNUC3Jo9euXvGZqPUtEucDYPX2e3
         /j/L8a2m7jnz4xmlnwUAVewh21Ns5lZmQA9iefuVaX07oOM9qWV3l75F135WYO/MJOdE
         80xOAXDDnkK3eWQ0Z1bV1qRl/I84zL08PuF+9CPQ8CgMMum4h7rKur6EOWHzzsXzM2Ie
         rbzQ==
X-Gm-Message-State: AOJu0Yxg3s//YJJiyfDZaSXaOHHx8PXEpzk2lpBa/+tXAjXuw1R79MPD
	jNvtEVac1QJscDKHIFntm1sgj+tGY0IL2IcOePY=
X-Google-Smtp-Source: AGHT+IH5z6FRCE98A/IPoieIB6A6KrGGEWGOj1WG7lTPH0EPF1wudsxMDV56auCpNVSV/IUJ3NgOQTjsuc72uyoC+Ho=
X-Received: by 2002:a05:6402:3592:b0:53e:12dd:f4be with SMTP id
 y18-20020a056402359200b0053e12ddf4bemr2324354edc.17.1697155434977; Thu, 12
 Oct 2023 17:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010185944.3888849-1-davemarchevsky@fb.com> <20231010185944.3888849-5-davemarchevsky@fb.com>
In-Reply-To: <20231010185944.3888849-5-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 17:03:43 -0700
Message-ID: <CAEf4BzbekC_ys6TjhgCySpztO5Zy-=tBOW6vYR-m2+NY3LC2NQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 4/4] selftests/bpf: Add tests for open-coded
 task_vma iter
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 12:00=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> The open-coded task_vma iter added earlier in this series allows for
> natural iteration over a task's vmas using existing open-coded iter
> infrastructure, specifically bpf_for_each.
>
> This patch adds a test demonstrating this pattern and validating
> correctness. The vma->vm_start and vma->vm_end addresses of the first
> 1000 vmas are recorded and compared to /proc/PID/maps output. As
> expected, both see the same vmas and addresses - with the exception of
> the [vsyscall] vma - which is explained in a comment in the prog_tests
> program.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
>  .../testing/selftests/bpf/prog_tests/iters.c  | 58 +++++++++++++++++++
>  .../selftests/bpf/progs/iters_task_vma.c      | 46 +++++++++++++++
>  3 files changed, 112 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
>

LGTM, I was going to apply, but CI is angry at you ([0]), please take
a look. Minor nits below, don't matter much.

  [0] https://github.com/kernel-patches/bpf/actions/runs/6489676263/job/176=
24379177

[...]

> diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/t=
esting/selftests/bpf/progs/iters_task_vma.c
> new file mode 100644
> index 000000000000..e3759e425420
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <limits.h>
> +#include <linux/errno.h>

do you need these two includes?

> +#include "vmlinux.h"
> +#include "bpf_experimental.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +pid_t target_pid =3D 0;
> +unsigned int vmas_seen =3D 0;
> +
> +struct {
> +       __u64 vm_start;
> +       __u64 vm_end;
> +} vm_ranges[1000];
> +
> +SEC("raw_tp/sys_enter")
> +int iter_task_vma_for_each(const void *ctx)
> +{
> +       struct task_struct *task =3D bpf_get_current_task_btf();
> +       struct vm_area_struct *vma;
> +       unsigned int seen =3D 0;
> +
> +       if (task->pid !=3D target_pid)
> +               return 0;
> +
> +       if (vmas_seen)
> +               return 0;
> +
> +       bpf_for_each(task_vma, vma, task, 0) {
> +               if (seen >=3D 1000)
> +                       break;
> +
> +               vm_ranges[seen].vm_start =3D vma->vm_start;
> +               vm_ranges[seen].vm_end =3D vma->vm_end;
> +               seen++;
> +       }
> +
> +       if (!vmas_seen)
> +               vmas_seen =3D seen;

you checked if (vmas_seen) above, so this check is probably
unnecessary, and presumably we'll arrive at the same seen even if we
run this many times for the same PID

> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>

