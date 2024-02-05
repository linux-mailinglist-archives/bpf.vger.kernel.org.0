Return-Path: <bpf+bounces-21238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9384A237
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0423F1F21FE6
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59869481AB;
	Mon,  5 Feb 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYzMuaoN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0350261
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157550; cv=none; b=SfwhNEK7WGpy0TD2165octDUvSLwyE9duxJOcfWPaCW8lnaABF4ErY/9BVv+l5QWBOV1nj8fkuVSZ6Hb8NNKXFLSoGnQlXM3atbKMyJQqLZxM0qZAUMyZW2WQtgu2pmFMEFHXrmTkuVYy7WHiWQd5TQ21z4Fx7ekBrHgUKPvPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157550; c=relaxed/simple;
	bh=dyYCetf5BHdnqFJske4wsI1/RjgTkCnxjOkzmM+p6e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVaZ3/Bos+O9HsmEBNgiVzqySdNtGJkkgP1IpE4IL2SiJaAGfKL2DCy8ccz52kvZPAYwUD11kxuhqJCVbrxmXdhvNwYbXPTKg9h6diHkFOg1qrXI0vFtLdSuWQs9XsTXfQJRVONKb5hNv5bajU+M/DzYhgTdWIYATrV6fA4qpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYzMuaoN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e04eceebb5so491866b3a.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157548; x=1707762348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzRLCUV6juWo0dkYyrKAVM2ql4lqhC4shODFixslxho=;
        b=AYzMuaoNVoGzWXiphIiKmRSlQqo2KvshuQARA1aj8cwe98IQVYhXGIjtAlQVqUjxOg
         QQ2PK3BVQ62bUiSbXuAvfVHBY0uBqYkyG13FiA/LQmcF4x1SEo8auVNfta0Eaz633PwA
         Ma6CWSPNIm7e2gdQ2CFrZScSbMznNeD+UavgCMrYXtWrdRY8Mc8Z90WOSiHMByPtAp6x
         vzFmq3pyg8hMfBjmCXUV52w6DbylPNleahbBknWKtrUCaeri5IRdWhtzkTOEHCR9rrBC
         2bno984T9DEW2Kyk7Z8lFMDcaWIzYI/oU4BuYQSlqnTiuSmNYpYNeSqS4Jd0BlAa4Uaz
         1HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157548; x=1707762348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzRLCUV6juWo0dkYyrKAVM2ql4lqhC4shODFixslxho=;
        b=w7w5megK02jf8wop6ROgGPUxvggfKJlAnH2X0fDHA8Od/XZi7F+weEGpinOAW6MrEz
         H1VGDQTLAhBvcvLoDoDsG3ReWDinYMacu5liK74SBPcKEVxXbyx7kw/n/N2v7b88oUmE
         KhImFHVIvvXpJ5l/+fDTg+2+HDx5v4ybAHjIMR0PaoAhMPVY5bAHeJZ2TCCWtZGV7HLV
         bhvVX3FtB7CLOiapsFuz9761CC9gD/F+PyaG5w6oqfmGQE32JTuOfX2xwC/UXFnOznVi
         tCSpyiQF+5K/7VmPzlUWqzTQTH+t760kj/hrlJI+q29cpnYLYnqQIFh966sVPAF7kW5U
         h++Q==
X-Gm-Message-State: AOJu0YwfEUSjSoFR5gK1lgHHThPjQlCNJqszSk2Je3g20DCv1mKumL+Q
	XSpsEOS1J+NFM0196bPFKdEAh35uHwyQOfTc7yD5YOPg0TKP00BCgvhOBDYg9+JnqYzUdIU82UT
	+EtjE45K0jqk7ZMcSY8EEUZHU7ac=
X-Google-Smtp-Source: AGHT+IG6x2zK88oJbVtp1U1KL6X4zGvpnOvxJJNNUjH0wsD/Iaa1cV5VtP6V/iLNj16ztzG1UD4NTu/QxJkrGEYNeWs=
X-Received: by 2002:a05:6a00:1ca0:b0:6e0:3bf5:40ba with SMTP id
 y32-20020a056a001ca000b006e03bf540bamr445463pfw.18.1707157548346; Mon, 05 Feb
 2024 10:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-5-laoar.shao@gmail.com>
 <CAEf4Bzanfe3X3NMce=WKg7LMdVU=USzc+NZw+4gViU6HJ18Ptw@mail.gmail.com>
 <CALOAHbApjK3MO+Hn-TiW9jR1cJuNEP9uHxZ=4WBMYLMrOANKLA@mail.gmail.com> <5497a6a9-1b41-4605-8220-041e5dff46f0@linux.dev>
In-Reply-To: <5497a6a9-1b41-4605-8220-041e5dff46f0@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Feb 2024 10:25:36 -0800
Message-ID: <CAEf4BzbpJKPZNbYsc0o0i-OqwObJjobog3qoCXxkmgQaUdqmtw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, tj@kernel.org, void@manifault.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 9:09=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 2/3/24 7:30 PM, Yafang Shao wrote:
> > On Sat, Feb 3, 2024 at 6:03=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> >>> Add selftests for the newly added cpumask iter.
> >>> - cpumask_iter_success
> >>>    - The number of CPUs should be expected when iterating over the cp=
umask
> >>>    - percpu data extracted from the percpu struct should be expected
> >>>    - It can work in both non-sleepable and sleepable prog
> >>>    - RCU lock is only required by bpf_iter_cpumask_new()
> >>>    - It is fine without calling bpf_iter_cpumask_next()
> >>>
> >>> - cpumask_iter_failure
> >>>    - RCU lock is required in sleepable prog
> >>>    - The cpumask to be iterated over can't be NULL
> >>>    - bpf_iter_cpumask_destroy() is required after calling
> >>>      bpf_iter_cpumask_new()
> >>>    - bpf_iter_cpumask_destroy() can only destroy an initilialized ite=
r
> >>>    - bpf_iter_cpumask_next() must use an initilialized iter
> >> typos: initialized
> > will fix it.
> >
> >>> The result as follows,
> >>>
> >>>    #64/37   cpumask/test_cpumask_iter:OK
> >>>    #64/38   cpumask/test_cpumask_iter_sleepable:OK
> >>>    #64/39   cpumask/test_cpumask_iter_sleepable:OK
> >>>    #64/40   cpumask/test_cpumask_iter_next_no_rcu:OK
> >>>    #64/41   cpumask/test_cpumask_iter_no_next:OK
> >>>    #64/42   cpumask/test_cpumask_iter:OK
> >>>    #64/43   cpumask/test_cpumask_iter_no_rcu:OK
> >>>    #64/44   cpumask/test_cpumask_iter_no_destroy:OK
> >>>    #64/45   cpumask/test_cpumask_iter_null_pointer:OK
> >>>    #64/46   cpumask/test_cpumask_iter_next_uninit:OK
> >>>    #64/47   cpumask/test_cpumask_iter_destroy_uninit:OK
> >>>    #64      cpumask:OK
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> ---
> >>>   tools/testing/selftests/bpf/config            |   1 +
> >>>   .../selftests/bpf/prog_tests/cpumask.c        | 152 +++++++++++++++=
+++
> >>>   .../selftests/bpf/progs/cpumask_common.h      |   3 +
> >>>   .../bpf/progs/cpumask_iter_failure.c          |  99 ++++++++++++
> >>>   .../bpf/progs/cpumask_iter_success.c          | 126 +++++++++++++++
> >>>   5 files changed, 381 insertions(+)
> >>>   create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_f=
ailure.c
> >>>   create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_s=
uccess.c
> >>>
> >> LGTM overall, except for seemingly unnecessary use of a big macro
> >>
> >>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/too=
ls/testing/selftests/bpf/progs/cpumask_common.h
> >>> index 0cd4aebb97cf..cdb9dc95e9d9 100644
> >>> --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> >>> +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> >>> @@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, cons=
t struct cpumask *src) __ksym
> >>>   u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
> >>>   u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, cons=
t struct cpumask *src2) __ksym;
> >>>   u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
> >>> +int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct c=
pumask *mask) __ksym;
> >>> +int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
> >>> +void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
> >> let's mark them __weak so they don't conflict with definitions that
> >> will eventually come from vmlinux.h (that applies to all the kfunc
> >> definitions we currently have and we'll need to clean all that up, but
> >> let's not add non-weak kfuncs going forward)
> > will change it.
> >
> >>>   void bpf_rcu_read_lock(void) __ksym;
> >>>   void bpf_rcu_read_unlock(void) __ksym;
> >> [...]
> >>
> >>> diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_success.c=
 b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
> >>> new file mode 100644
> >>> index 000000000000..4ce14ef98451
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
> >>> @@ -0,0 +1,126 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> >>> +
> >>> +#include "vmlinux.h"
> >>> +#include <bpf/bpf_helpers.h>
> >>> +#include <bpf/bpf_tracing.h>
> >>> +
> >>> +#include "task_kfunc_common.h"
> >>> +#include "cpumask_common.h"
> >>> +
> >>> +char _license[] SEC("license") =3D "GPL";
> >>> +
> >>> +extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
> >>> +extern const struct rq runqueues __ksym __weak;
> >>> +
> >>> +int pid;
> >>> +
> >>> +#define READ_PERCPU_DATA(meta, cgrp, mask)                          =
                           \
> >>> +{                                                                   =
                           \
> >>> +       u32 nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0;   =
                                 \
> >>> +       struct psi_group_cpu *groupc;                                =
                           \
> >>> +       struct rq *rq;                                               =
                           \
> >>> +       int *cpu;                                                    =
                           \
> >>> +                                                                    =
                           \
> >>> +       bpf_for_each(cpumask, cpu, mask) {                           =
                           \
> >>> +               rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu)=
;                            \
> >>> +               if (!rq) {                                           =
                           \
> >>> +                       err +=3D 1;                                  =
                             \
> >>> +                       continue;                                    =
                           \
> >>> +               }                                                    =
                           \
> >>> +               nr_running +=3D rq->nr_running;                      =
                             \
> >>> +               nr_cpus +=3D 1;                                      =
                             \
> >>> +                                                                    =
                           \
> >>> +               groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&s=
ystem_group_pcpu, *cpu);     \
> >>> +               if (!groupc) {                                       =
                           \
> >>> +                       err +=3D 1;                                  =
                             \
> >>> +                       continue;                                    =
                           \
> >>> +               }                                                    =
                           \
> >>> +               psi_nr_running +=3D groupc->tasks[NR_RUNNING];       =
                             \
> >>> +       }                                                            =
                           \
> >>> +       BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_runni=
ng %u\n",                  \
> >>> +                      nr_running, nr_cpus, psi_nr_running);         =
                           \
> >>> +}
> >>> +
> >> Does this have to be a gigantic macro? Why can't it be just a function=
?
> > It seems that the verifier can't identify a function call between
> > bpf_rcu_read_lock() and bpf_rcu_read_unlock().
> > That said, if there's a function call between them, the verifier will f=
ail.
> > Below is the full verifier log if I define it as :
> > static inline void read_percpu_data(struct bpf_iter_meta *meta, struct
> > cgroup *cgrp, const cpumask_t *mask)
> >
> > VERIFIER LOG:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 0: R1=3Dctx() R10=3Dfp0
> > ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> > *meta, struct cgroup *cgrp)
> > 0: (b4) w7 =3D 0                        ; R7_w=3D0
> > ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> > *meta, struct cgroup *cgrp)
> > 1: (79) r2 =3D *(u64 *)(r1 +8)          ; R1=3Dctx()
> > R2_w=3Dtrusted_ptr_or_null_cgroup(id=3D1)
> > ; if (!cgrp)
> > 2: (15) if r2 =3D=3D 0x0 goto pc+16       ; R2_w=3Dtrusted_ptr_cgroup()
> > ; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
> > *meta, struct cgroup *cgrp)
> > 3: (79) r6 =3D *(u64 *)(r1 +0)
> > func 'bpf_iter_cgroup' arg0 has btf_id 10966 type STRUCT 'bpf_iter_meta=
'
> > 4: R1=3Dctx() R6_w=3Dtrusted_ptr_bpf_iter_meta()
> > ; bpf_rcu_read_lock();
> > 4: (85) call bpf_rcu_read_lock#84184          ;
> > ; p =3D bpf_task_from_pid(pid);
> > 5: (18) r1 =3D 0xffffbc1ad3f72004       ;
> > R1_w=3Dmap_value(map=3Dcpumask_.bss,ks=3D4,vs=3D8,off=3D4)
> > 7: (61) r1 =3D *(u32 *)(r1 +0)          ;
> > R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffff=
fff))
> > ; p =3D bpf_task_from_pid(pid);
> > 8: (85) call bpf_task_from_pid#84204          ;
> > R0=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3) refs=3D3
> > 9: (bf) r8 =3D r0                       ;
> > R0=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3)
> > R8_w=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3) refs=3D3
> > 10: (b4) w7 =3D 1                       ; R7_w=3D1 refs=3D3
> > ; if (!p) {
> > 11: (15) if r8 =3D=3D 0x0 goto pc+6       ;
> > R8_w=3Dptr_task_struct(ref_obj_id=3D3) refs=3D3
> > ; read_percpu_data(meta, cgrp, p->cpus_ptr);
> > 12: (79) r2 =3D *(u64 *)(r8 +984)       ; R2_w=3Drcu_ptr_cpumask()
> > R8_w=3Dptr_task_struct(ref_obj_id=3D3) refs=3D3
> > ; read_percpu_data(meta, cgrp, p->cpus_ptr);
> > 13: (bf) r1 =3D r6                      ;
> > R1_w=3Dtrusted_ptr_bpf_iter_meta() R6=3Dtrusted_ptr_bpf_iter_meta() ref=
s=3D3
> > 14: (85) call pc+6
> > caller:
> >   R6=3Dtrusted_ptr_bpf_iter_meta() R7_w=3D1
> > R8_w=3Dptr_task_struct(ref_obj_id=3D3) R10=3Dfp0 refs=3D3
> > callee:
> >   frame1: R1_w=3Dtrusted_ptr_bpf_iter_meta() R2_w=3Drcu_ptr_cpumask() R=
10=3Dfp0 refs=3D3
> > 21: frame1: R1_w=3Dtrusted_ptr_bpf_iter_meta() R2_w=3Drcu_ptr_cpumask()
> > R10=3Dfp0 refs=3D3
> > ; static inline void read_percpu_data(struct bpf_iter_meta *meta,
> > struct cgroup *cgrp, const cpumask_t *mask)
> > 21: (bf) r8 =3D r1                      ; frame1:
> > R1_w=3Dtrusted_ptr_bpf_iter_meta() R8_w=3Dtrusted_ptr_bpf_iter_meta()
> > refs=3D3
> > 22: (bf) r7 =3D r10                     ; frame1: R7_w=3Dfp0 R10=3Dfp0 =
refs=3D3
> > ;
> > 23: (07) r7 +=3D -24                    ; frame1: R7_w=3Dfp-24 refs=3D3
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 24: (bf) r1 =3D r7                      ; frame1: R1_w=3Dfp-24 R7_w=3Df=
p-24 refs=3D3
> > 25: (85) call bpf_iter_cpumask_new#77163      ; frame1: R0=3Dscalar()
> > fp-24=3Diter_cpumask(ref_id=3D4,state=3Dactive,depth=3D0) refs=3D3,4
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 26: (bf) r1 =3D r7                      ; frame1: R1=3Dfp-24 R7=3Dfp-24=
 refs=3D3,4
> > 27: (85) call bpf_iter_cpumask_next#77165     ; frame1: R0_w=3D0
> > fp-24=3Diter_cpumask(ref_id=3D4,state=3Ddrained,depth=3D0) refs=3D3,4
> > 28: (bf) r7 =3D r0                      ; frame1: R0_w=3D0 R7_w=3D0 ref=
s=3D3,4
> > 29: (b4) w1 =3D 0                       ; frame1: R1_w=3D0 refs=3D3,4
> > 30: (63) *(u32 *)(r10 -40) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0
> > fp-40=3D????0 refs=3D3,4
> > 31: (b4) w1 =3D 0                       ; frame1: R1_w=3D0 refs=3D3,4
> > 32: (7b) *(u64 *)(r10 -32) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0
> > fp-32_w=3D0 refs=3D3,4
> > 33: (b4) w9 =3D 0                       ; frame1: R9_w=3D0 refs=3D3,4
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 34: (15) if r7 =3D=3D 0x0 goto pc+57      ; frame1: R7_w=3D0 refs=3D3,4
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 92: (bf) r1 =3D r10                     ; frame1: R1_w=3Dfp0 R10=3Dfp0 =
refs=3D3,4
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 93: (07) r1 +=3D -24                    ; frame1: R1_w=3Dfp-24 refs=3D3=
,4
> > 94: (85) call bpf_iter_cpumask_destroy#77161          ; frame1: refs=3D=
3
> > ; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n"=
,
> > 95: (61) r1 =3D *(u32 *)(r10 -40)       ; frame1: R1_w=3D0 R10=3Dfp0
> > fp-40=3D????0 refs=3D3
> > 96: (bc) w1 =3D w1                      ; frame1: R1_w=3D0 refs=3D3
> > 97: (7b) *(u64 *)(r10 -8) =3D r1        ; frame1: R1_w=3D0 R10=3Dfp0 fp=
-8_w=3D0 refs=3D3
> > 98: (79) r1 =3D *(u64 *)(r10 -32)       ; frame1: R1_w=3D0 R10=3Dfp0 fp=
-32=3D0 refs=3D3
> > 99: (7b) *(u64 *)(r10 -16) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0 fp=
-16_w=3D0 refs=3D3
> > 100: (7b) *(u64 *)(r10 -24) =3D r9      ; frame1: R9=3D0 R10=3Dfp0 fp-2=
4_w=3D0 refs=3D3
> > 101: (79) r1 =3D *(u64 *)(r8 +0)        ; frame1:
> > R1_w=3Dtrusted_ptr_seq_file() R8=3Dtrusted_ptr_bpf_iter_meta() refs=3D3
> > 102: (bf) r4 =3D r10                    ; frame1: R4_w=3Dfp0 R10=3Dfp0 =
refs=3D3
> > ; bpf_for_each(cpumask, cpu, mask) {
> > 103: (07) r4 +=3D -24                   ; frame1: R4_w=3Dfp-24 refs=3D3
> > ; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n"=
,
> > 104: (18) r2 =3D 0xffff9bce47e0e210     ; frame1:
> > R2_w=3Dmap_value(map=3Dcpumask_.rodata,ks=3D4,vs=3D41) refs=3D3
> > 106: (b4) w3 =3D 41                     ; frame1: R3_w=3D41 refs=3D3
> > 107: (b4) w5 =3D 24                     ; frame1: R5_w=3D24 refs=3D3
> > 108: (85) call bpf_seq_printf#126     ; frame1: R0=3Dscalar() refs=3D3
> > ; }
> > 109: (95) exit
> > bpf_rcu_read_unlock is missing
> > processed 45 insns (limit 1000000) max_states_per_insn 0 total_states
> > 5 peak_states 5 mark_read 3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The error is due to the following in verifier:
>
>                          } else if (opcode =3D=3D BPF_EXIT) {
>                                 ...
>                                  if (env->cur_state->active_rcu_lock &&
>                                      !in_rbtree_lock_required_cb(env)) {
>                                          verbose(env, "bpf_rcu_read_unloc=
k is missing\n");
>                                          return -EINVAL;
>                                  }
>
>
> I guess, we could relax the condition not to return -EINVAL if
> it is a static function.
>
> >
> >
> > Another workaround is using the __always_inline :
> > static __always_inline void read_percpu_data(struct bpf_iter_meta
> > *meta, struct cgroup *cgrp, const cpumask_t *mask)
>
> __always_inline is also work. But let us improve verifier so we
> can avoid such workarounds in the future. Note that Kumar just
> submitted a patch set to relax spin_lock for static functions:
>    https://lore.kernel.org/bpf/20240204120206.796412-1-memxor@gmail.com/


Agreed, let's improve verifier, but I wouldn't block on it for this
patch set and just use __always_inline for now.

I think we should also work on extending this RCU support to global
functions. We can add per-function annotation (similar to __arg_xxx,
but which will be applied to a function itself), just __rcu or
something like __func_assume_rcu or whatnot, and then there should be
no difference between static and global functions in this regard.

In general, global functions are basically mandatory nowadays for big
production BPF programs (to reduce verification complexity), so we
should strive to keep global functions/subprogs on par with static
subprogs as much as we can.

>
> >
> >>> +SEC("iter.s/cgroup")
> >>> +int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta *meta=
, struct cgroup *cgrp)
> >>> +{
> >>> +       struct task_struct *p;
> >>> +
> >>> +       /* epilogue */
> >>> +       if (!cgrp)
> >>> +               return 0;
> >>> +
> >>> +       bpf_rcu_read_lock();
> >>> +       p =3D bpf_task_from_pid(pid);
> >>> +       if (!p) {
> >>> +               bpf_rcu_read_unlock();
> >>> +               return 1;
> >>> +       }
> >>> +
> >>> +       READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
> >>> +       bpf_task_release(p);
> >>> +       bpf_rcu_read_unlock();
> >>> +       return 0;
> >>> +}
> >>> +
> >> [...]
> >
> >

