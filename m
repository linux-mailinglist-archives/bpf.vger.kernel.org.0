Return-Path: <bpf+bounces-21087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFC6847BF1
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56642880A8
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074565E04;
	Fri,  2 Feb 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBDgKW7m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D82943C
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911382; cv=none; b=A69k9ZCMSed7gM+C7b+5niV3ByPk2SvYkGS2itxsDHu+Qh1nH68uMQxNNPzBStagIyvAy1A1RBfLKndWFQXvJyKlkYscsvacLHqbCDdJKiZTZUUCBAKRq4AYW5d01UsedxHcdVmaPEPPBpyHkTCqW/ymgGZroDPgIfCChy+Qs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911382; c=relaxed/simple;
	bh=rXSD1QjgojtXinG5ZEZfNhivPcfi9/Iy+Pm2kQwFw9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVAhB+ExWq5C1lqalXDe/f6PXr+U6IztVyNPuQ7VB32QcDOyKelLxyF2RJgjv8D5vuanlLps1qByG1Fn0z5Nu0Q+h/nP8/UMhgnEzrG+WLqX0B/IL5/hBfAwL2TVvWYTFIMVsG1Xhy6hRHaYeJj+tXAIwILDMKMPQMPYWY+N8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBDgKW7m; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2167193a12.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911380; x=1707516180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxpD6wv0sZW8DQvtlJkqtg560tkPuD4LyUXcyo7UuVY=;
        b=gBDgKW7mrNqhlcmdo4gUH0aTjMKbIcZHW2MFauzbNU2XsFl5lzQTBgeiftTRTkp8bH
         GJm/9qGiCYSINHZbGS1U3hg1DRNuyw7mBTij5BuhtkEY8D4rIK+SWTY6FwblCB8XihZE
         evuMQSj9zVDQSoh23gFhv8qpAEP8carvZxeqSh4mQOOQET2uysHqBqHjHSDGyOHafIU8
         9iIZfqv5ppTOGHp9P1uMPYAGDZybQNSkWcBguACya8o3RnFYsCaQTodihHfkeBh68K9L
         qntO6YCZVOnJz8gzSO6TQ2EXYnZmll7TuNeGjzbpSfQryzXBs/wYfBt3nVDiZVSnA+sn
         wFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911380; x=1707516180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxpD6wv0sZW8DQvtlJkqtg560tkPuD4LyUXcyo7UuVY=;
        b=v57cdAdwGkrVd29Fck3dThdIt13yZLAcj8BXEOfOr6rCbyatzr+zzNbzgcmM673ztv
         nIDl05TSPZfve4JM3gWpimmI5p9M0ezHt68IZMjVGtEXy1UqmPWqmEcbI5eu8BcG1V9I
         Neir+FTtQrFoV343OYIa82PCJLPKfa6dhs3VayoG3TdBFMSi1FWKj4f/qWqa+47miDsX
         TBxSXj1XJBLnR3jN3nu2gZa0fdyOXoCT3GkLPks5dZfotD2rN1xCukjK85FNPuEcfltj
         a3FeMukevLtGfP+a2t1QwMMaDn6QsrGOp6CudVUXl8XVPbqXxiHBG7hQWhX9TQPJDpP6
         qV+g==
X-Gm-Message-State: AOJu0YxinqEh2wyAdzUGXyxO+b4riRd9iyzhH1+J2vvtYNPpDI/tCxYm
	4hqHWLgrhfkBJnUl8fJazEbz3jKvzt23XSwxHfDkCtzufFdrMGrHNiW2djQW5X3W0qLI8kZA+rM
	KLLol7/BwpEfi0GwxGQ8MKnFU1gc=
X-Google-Smtp-Source: AGHT+IEceYEr3APnSld5JHw5htp1xdEJpVX2iK370WVso9+9HMGQYu141DX/VvkGOijO47n+4NsO525YfYBv+1N4C3s=
X-Received: by 2002:a05:6a21:9207:b0:19c:8cd8:305d with SMTP id
 tl7-20020a056a21920700b0019c8cd8305dmr3674733pzb.58.1706911379634; Fri, 02
 Feb 2024 14:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-5-laoar.shao@gmail.com>
In-Reply-To: <20240131145454.86990-5-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:02:47 -0800
Message-ID: <CAEf4Bzanfe3X3NMce=WKg7LMdVU=USzc+NZw+4gViU6HJ18Ptw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftests for the newly added cpumask iter.
> - cpumask_iter_success
>   - The number of CPUs should be expected when iterating over the cpumask
>   - percpu data extracted from the percpu struct should be expected
>   - It can work in both non-sleepable and sleepable prog
>   - RCU lock is only required by bpf_iter_cpumask_new()
>   - It is fine without calling bpf_iter_cpumask_next()
>
> - cpumask_iter_failure
>   - RCU lock is required in sleepable prog
>   - The cpumask to be iterated over can't be NULL
>   - bpf_iter_cpumask_destroy() is required after calling
>     bpf_iter_cpumask_new()
>   - bpf_iter_cpumask_destroy() can only destroy an initilialized iter
>   - bpf_iter_cpumask_next() must use an initilialized iter

typos: initialized

>
> The result as follows,
>
>   #64/37   cpumask/test_cpumask_iter:OK
>   #64/38   cpumask/test_cpumask_iter_sleepable:OK
>   #64/39   cpumask/test_cpumask_iter_sleepable:OK
>   #64/40   cpumask/test_cpumask_iter_next_no_rcu:OK
>   #64/41   cpumask/test_cpumask_iter_no_next:OK
>   #64/42   cpumask/test_cpumask_iter:OK
>   #64/43   cpumask/test_cpumask_iter_no_rcu:OK
>   #64/44   cpumask/test_cpumask_iter_no_destroy:OK
>   #64/45   cpumask/test_cpumask_iter_null_pointer:OK
>   #64/46   cpumask/test_cpumask_iter_next_uninit:OK
>   #64/47   cpumask/test_cpumask_iter_destroy_uninit:OK
>   #64      cpumask:OK
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/cpumask.c        | 152 ++++++++++++++++++
>  .../selftests/bpf/progs/cpumask_common.h      |   3 +
>  .../bpf/progs/cpumask_iter_failure.c          |  99 ++++++++++++
>  .../bpf/progs/cpumask_iter_success.c          | 126 +++++++++++++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failur=
e.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_succes=
s.c
>

LGTM overall, except for seemingly unnecessary use of a big macro

> diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/t=
esting/selftests/bpf/progs/cpumask_common.h
> index 0cd4aebb97cf..cdb9dc95e9d9 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> @@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const st=
ruct cpumask *src) __ksym
>  u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
>  u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const str=
uct cpumask *src2) __ksym;
>  u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
> +int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpuma=
sk *mask) __ksym;
> +int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
> +void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;

let's mark them __weak so they don't conflict with definitions that
will eventually come from vmlinux.h (that applies to all the kfunc
definitions we currently have and we'll need to clean all that up, but
let's not add non-weak kfuncs going forward)

>
>  void bpf_rcu_read_lock(void) __ksym;
>  void bpf_rcu_read_unlock(void) __ksym;

[...]

> diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_success.c b/t=
ools/testing/selftests/bpf/progs/cpumask_iter_success.c
> new file mode 100644
> index 000000000000..4ce14ef98451
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include "task_kfunc_common.h"
> +#include "cpumask_common.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
> +extern const struct rq runqueues __ksym __weak;
> +
> +int pid;
> +
> +#define READ_PERCPU_DATA(meta, cgrp, mask)                              =
                       \
> +{                                                                       =
                       \
> +       u32 nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0;       =
                             \
> +       struct psi_group_cpu *groupc;                                    =
                       \
> +       struct rq *rq;                                                   =
                       \
> +       int *cpu;                                                        =
                       \
> +                                                                        =
                       \
> +       bpf_for_each(cpumask, cpu, mask) {                               =
                       \
> +               rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);   =
                         \
> +               if (!rq) {                                               =
                       \
> +                       err +=3D 1;                                      =
                         \
> +                       continue;                                        =
                       \
> +               }                                                        =
                       \
> +               nr_running +=3D rq->nr_running;                          =
                         \
> +               nr_cpus +=3D 1;                                          =
                         \
> +                                                                        =
                       \
> +               groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&syste=
m_group_pcpu, *cpu);     \
> +               if (!groupc) {                                           =
                       \
> +                       err +=3D 1;                                      =
                         \
> +                       continue;                                        =
                       \
> +               }                                                        =
                       \
> +               psi_nr_running +=3D groupc->tasks[NR_RUNNING];           =
                         \
> +       }                                                                =
                       \
> +       BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %=
u\n",                  \
> +                      nr_running, nr_cpus, psi_nr_running);             =
                       \
> +}
> +

Does this have to be a gigantic macro? Why can't it be just a function?

> +SEC("iter.s/cgroup")
> +int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta *meta, st=
ruct cgroup *cgrp)
> +{
> +       struct task_struct *p;
> +
> +       /* epilogue */
> +       if (!cgrp)
> +               return 0;
> +
> +       bpf_rcu_read_lock();
> +       p =3D bpf_task_from_pid(pid);
> +       if (!p) {
> +               bpf_rcu_read_unlock();
> +               return 1;
> +       }
> +
> +       READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
> +       bpf_task_release(p);
> +       bpf_rcu_read_unlock();
> +       return 0;
> +}
> +

[...]

