Return-Path: <bpf+bounces-21144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C4848AE4
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5022E1F22A88
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388417E9;
	Sun,  4 Feb 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kASO4EnQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BF1385
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017439; cv=none; b=JMxuvxqFR/7g46/L0E9vBoEM1I4TcsadpJpzQsNI9iAALoWInrNBMUr+YGDWC3s4uTyg2QRFrDKjaiPhx6DqirxEXOOZI78ToFRSweydZxiWxAoQpC0cEZsZzdhRWXayh4fvmf4bDPrYhUMyCcnUDwk3LP883zDx1dIVyMwro84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017439; c=relaxed/simple;
	bh=bA27Ul16Y7yJrMZ0Sh9mg/ahgKtoqqZ0RyOdR/jNqpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNZZwpma81E07LpPx8IqDkbI0rK9TZQ8balT8g6zvaRmT4Jc7rholLz2o/EnFVRpLQ/tG7PIqIcjrtH2rTRBztTpJNkaTtwhkiw0mKsEUVYJoHd43HvL9I1ny+xNlCoT0nl5w/X+ydiACcsRj/gccmDkAYw1ftA/wlOcJ1fVOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kASO4EnQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d84ecb13so230024285a.0
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 19:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707017436; x=1707622236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGHWzvCduuqG873rQO9J2rFEK9SMNkFEBcqsIeat+s4=;
        b=kASO4EnQ/jg1zNdybay7vrKLeDtjUFSvSn5mSrnjpAuAfWRlJruJNBssNj0EovJeB5
         40DIWbmFx0uxAAlEsbZswvzwqF9AQKeV77BVWinkho1XmThJPY2EXXNET7NLRZpKQlSa
         njM2BTtrOLsmGxBuY7XcSPMd+67pMCEqvv76PKk8L8QlEfiF/YZ+7N40mA+Gr0RAG2LJ
         iEclw7WtSROQUzvUbAYUoXXlSeGCKn3Sj7Qy5HZakQKVU+9y+aC9FxcnjkIl3ncTnklH
         kJJcbW1YInet+J/U5ZnwilSCuaRCE8epfluTD7dFytz3KVKN9o8fQbEGj3cSh1rkIMPi
         z99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707017436; x=1707622236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGHWzvCduuqG873rQO9J2rFEK9SMNkFEBcqsIeat+s4=;
        b=D+OPkfBtlrlQvUco9QAFJKl/KXyi/Z77PsIxnsN8vsQI+mRQEG+iGjjrOGdC+gOgIC
         R0jzILgj0MWs0tOWCFtrhfFIxQkgVumDZV8r+peorjR8JHU7cVK2vi0ZKb7vw28iCED2
         H3Al5ypNtOTdJICJvmABCfFzqHKCylmZdSvFqlUDhHfwZbeaJiYeWqC0PG8KHXtBRbAm
         LPlePeChVCB6GCvXFjF9XF6rKaiknFoA4aSLJw4i8I7EEjDqLK94rr5GQgWshgv/8m2W
         LcSJutmpAIy/to3Nh/OwXzUbGTgppG13pD7S/KLb4V8s6M+IF4ToC/LchOP0mJLwJUc5
         uTDA==
X-Gm-Message-State: AOJu0YxVMNG0l6L6sxChR1XQD1p6xWRAmR6bq2XqHzB8Mkd43uFLVZyg
	GeTaoP0NCDSElCMI2XFfN8mRXiKnQ6cSWjsC6xmrajJ5fFEaG6jF/L2+vQ0OkwYoNSoi0L070mM
	JHxtg4C4V3C2VI9vVvm23lw8seCM=
X-Google-Smtp-Source: AGHT+IGaP/xiYmS1CXx8/iMr0Q1HGWAVFS9wAR+xdupRlQ8ueHuxQVLyBXihT3+6CExW8Xbqz5bf8Fto8g/GGvA8Zb0=
X-Received: by 2002:ad4:5be5:0:b0:68c:7b5b:a9df with SMTP id
 k5-20020ad45be5000000b0068c7b5ba9dfmr2633922qvc.55.1707017436272; Sat, 03 Feb
 2024 19:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-5-laoar.shao@gmail.com>
 <CAEf4Bzanfe3X3NMce=WKg7LMdVU=USzc+NZw+4gViU6HJ18Ptw@mail.gmail.com>
In-Reply-To: <CAEf4Bzanfe3X3NMce=WKg7LMdVU=USzc+NZw+4gViU6HJ18Ptw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Feb 2024 11:30:00 +0800
Message-ID: <CALOAHbApjK3MO+Hn-TiW9jR1cJuNEP9uHxZ=4WBMYLMrOANKLA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 6:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add selftests for the newly added cpumask iter.
> > - cpumask_iter_success
> >   - The number of CPUs should be expected when iterating over the cpuma=
sk
> >   - percpu data extracted from the percpu struct should be expected
> >   - It can work in both non-sleepable and sleepable prog
> >   - RCU lock is only required by bpf_iter_cpumask_new()
> >   - It is fine without calling bpf_iter_cpumask_next()
> >
> > - cpumask_iter_failure
> >   - RCU lock is required in sleepable prog
> >   - The cpumask to be iterated over can't be NULL
> >   - bpf_iter_cpumask_destroy() is required after calling
> >     bpf_iter_cpumask_new()
> >   - bpf_iter_cpumask_destroy() can only destroy an initilialized iter
> >   - bpf_iter_cpumask_next() must use an initilialized iter
>
> typos: initialized

will fix it.

>
> >
> > The result as follows,
> >
> >   #64/37   cpumask/test_cpumask_iter:OK
> >   #64/38   cpumask/test_cpumask_iter_sleepable:OK
> >   #64/39   cpumask/test_cpumask_iter_sleepable:OK
> >   #64/40   cpumask/test_cpumask_iter_next_no_rcu:OK
> >   #64/41   cpumask/test_cpumask_iter_no_next:OK
> >   #64/42   cpumask/test_cpumask_iter:OK
> >   #64/43   cpumask/test_cpumask_iter_no_rcu:OK
> >   #64/44   cpumask/test_cpumask_iter_no_destroy:OK
> >   #64/45   cpumask/test_cpumask_iter_null_pointer:OK
> >   #64/46   cpumask/test_cpumask_iter_next_uninit:OK
> >   #64/47   cpumask/test_cpumask_iter_destroy_uninit:OK
> >   #64      cpumask:OK
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config            |   1 +
> >  .../selftests/bpf/prog_tests/cpumask.c        | 152 ++++++++++++++++++
> >  .../selftests/bpf/progs/cpumask_common.h      |   3 +
> >  .../bpf/progs/cpumask_iter_failure.c          |  99 ++++++++++++
> >  .../bpf/progs/cpumask_iter_success.c          | 126 +++++++++++++++
> >  5 files changed, 381 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_fail=
ure.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_succ=
ess.c
> >
>
> LGTM overall, except for seemingly unnecessary use of a big macro
>
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools=
/testing/selftests/bpf/progs/cpumask_common.h
> > index 0cd4aebb97cf..cdb9dc95e9d9 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_common.h
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
> > @@ -55,6 +55,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const =
struct cpumask *src) __ksym
> >  u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
> >  u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const s=
truct cpumask *src2) __ksym;
> >  u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
> > +int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const struct cpu=
mask *mask) __ksym;
> > +int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
> > +void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
>
> let's mark them __weak so they don't conflict with definitions that
> will eventually come from vmlinux.h (that applies to all the kfunc
> definitions we currently have and we'll need to clean all that up, but
> let's not add non-weak kfuncs going forward)

will change it.

>
> >
> >  void bpf_rcu_read_lock(void) __ksym;
> >  void bpf_rcu_read_unlock(void) __ksym;
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_iter_success.c b=
/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
> > new file mode 100644
> > index 000000000000..4ce14ef98451
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_iter_success.c
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#include "task_kfunc_common.h"
> > +#include "cpumask_common.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +extern const struct psi_group_cpu system_group_pcpu __ksym __weak;
> > +extern const struct rq runqueues __ksym __weak;
> > +
> > +int pid;
> > +
> > +#define READ_PERCPU_DATA(meta, cgrp, mask)                            =
                         \
> > +{                                                                     =
                         \
> > +       u32 nr_running =3D 0, psi_nr_running =3D 0, nr_cpus =3D 0;     =
                               \
> > +       struct psi_group_cpu *groupc;                                  =
                         \
> > +       struct rq *rq;                                                 =
                         \
> > +       int *cpu;                                                      =
                         \
> > +                                                                      =
                         \
> > +       bpf_for_each(cpumask, cpu, mask) {                             =
                         \
> > +               rq =3D (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu); =
                           \
> > +               if (!rq) {                                             =
                         \
> > +                       err +=3D 1;                                    =
                           \
> > +                       continue;                                      =
                         \
> > +               }                                                      =
                         \
> > +               nr_running +=3D rq->nr_running;                        =
                           \
> > +               nr_cpus +=3D 1;                                        =
                           \
> > +                                                                      =
                         \
> > +               groupc =3D (struct psi_group_cpu *)bpf_per_cpu_ptr(&sys=
tem_group_pcpu, *cpu);     \
> > +               if (!groupc) {                                         =
                         \
> > +                       err +=3D 1;                                    =
                           \
> > +                       continue;                                      =
                         \
> > +               }                                                      =
                         \
> > +               psi_nr_running +=3D groupc->tasks[NR_RUNNING];         =
                           \
> > +       }                                                              =
                         \
> > +       BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running=
 %u\n",                  \
> > +                      nr_running, nr_cpus, psi_nr_running);           =
                         \
> > +}
> > +
>
> Does this have to be a gigantic macro? Why can't it be just a function?

It seems that the verifier can't identify a function call between
bpf_rcu_read_lock() and bpf_rcu_read_unlock().
That said, if there's a function call between them, the verifier will fail.
Below is the full verifier log if I define it as :
static inline void read_percpu_data(struct bpf_iter_meta *meta, struct
cgroup *cgrp, const cpumask_t *mask)

VERIFIER LOG:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: R1=3Dctx() R10=3Dfp0
; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
*meta, struct cgroup *cgrp)
0: (b4) w7 =3D 0                        ; R7_w=3D0
; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
*meta, struct cgroup *cgrp)
1: (79) r2 =3D *(u64 *)(r1 +8)          ; R1=3Dctx()
R2_w=3Dtrusted_ptr_or_null_cgroup(id=3D1)
; if (!cgrp)
2: (15) if r2 =3D=3D 0x0 goto pc+16       ; R2_w=3Dtrusted_ptr_cgroup()
; int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta
*meta, struct cgroup *cgrp)
3: (79) r6 =3D *(u64 *)(r1 +0)
func 'bpf_iter_cgroup' arg0 has btf_id 10966 type STRUCT 'bpf_iter_meta'
4: R1=3Dctx() R6_w=3Dtrusted_ptr_bpf_iter_meta()
; bpf_rcu_read_lock();
4: (85) call bpf_rcu_read_lock#84184          ;
; p =3D bpf_task_from_pid(pid);
5: (18) r1 =3D 0xffffbc1ad3f72004       ;
R1_w=3Dmap_value(map=3Dcpumask_.bss,ks=3D4,vs=3D8,off=3D4)
7: (61) r1 =3D *(u32 *)(r1 +0)          ;
R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)=
)
; p =3D bpf_task_from_pid(pid);
8: (85) call bpf_task_from_pid#84204          ;
R0=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3) refs=3D3
9: (bf) r8 =3D r0                       ;
R0=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3)
R8_w=3Dptr_or_null_task_struct(id=3D3,ref_obj_id=3D3) refs=3D3
10: (b4) w7 =3D 1                       ; R7_w=3D1 refs=3D3
; if (!p) {
11: (15) if r8 =3D=3D 0x0 goto pc+6       ;
R8_w=3Dptr_task_struct(ref_obj_id=3D3) refs=3D3
; read_percpu_data(meta, cgrp, p->cpus_ptr);
12: (79) r2 =3D *(u64 *)(r8 +984)       ; R2_w=3Drcu_ptr_cpumask()
R8_w=3Dptr_task_struct(ref_obj_id=3D3) refs=3D3
; read_percpu_data(meta, cgrp, p->cpus_ptr);
13: (bf) r1 =3D r6                      ;
R1_w=3Dtrusted_ptr_bpf_iter_meta() R6=3Dtrusted_ptr_bpf_iter_meta() refs=3D=
3
14: (85) call pc+6
caller:
 R6=3Dtrusted_ptr_bpf_iter_meta() R7_w=3D1
R8_w=3Dptr_task_struct(ref_obj_id=3D3) R10=3Dfp0 refs=3D3
callee:
 frame1: R1_w=3Dtrusted_ptr_bpf_iter_meta() R2_w=3Drcu_ptr_cpumask() R10=3D=
fp0 refs=3D3
21: frame1: R1_w=3Dtrusted_ptr_bpf_iter_meta() R2_w=3Drcu_ptr_cpumask()
R10=3Dfp0 refs=3D3
; static inline void read_percpu_data(struct bpf_iter_meta *meta,
struct cgroup *cgrp, const cpumask_t *mask)
21: (bf) r8 =3D r1                      ; frame1:
R1_w=3Dtrusted_ptr_bpf_iter_meta() R8_w=3Dtrusted_ptr_bpf_iter_meta()
refs=3D3
22: (bf) r7 =3D r10                     ; frame1: R7_w=3Dfp0 R10=3Dfp0 refs=
=3D3
;
23: (07) r7 +=3D -24                    ; frame1: R7_w=3Dfp-24 refs=3D3
; bpf_for_each(cpumask, cpu, mask) {
24: (bf) r1 =3D r7                      ; frame1: R1_w=3Dfp-24 R7_w=3Dfp-24=
 refs=3D3
25: (85) call bpf_iter_cpumask_new#77163      ; frame1: R0=3Dscalar()
fp-24=3Diter_cpumask(ref_id=3D4,state=3Dactive,depth=3D0) refs=3D3,4
; bpf_for_each(cpumask, cpu, mask) {
26: (bf) r1 =3D r7                      ; frame1: R1=3Dfp-24 R7=3Dfp-24 ref=
s=3D3,4
27: (85) call bpf_iter_cpumask_next#77165     ; frame1: R0_w=3D0
fp-24=3Diter_cpumask(ref_id=3D4,state=3Ddrained,depth=3D0) refs=3D3,4
28: (bf) r7 =3D r0                      ; frame1: R0_w=3D0 R7_w=3D0 refs=3D=
3,4
29: (b4) w1 =3D 0                       ; frame1: R1_w=3D0 refs=3D3,4
30: (63) *(u32 *)(r10 -40) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0
fp-40=3D????0 refs=3D3,4
31: (b4) w1 =3D 0                       ; frame1: R1_w=3D0 refs=3D3,4
32: (7b) *(u64 *)(r10 -32) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0
fp-32_w=3D0 refs=3D3,4
33: (b4) w9 =3D 0                       ; frame1: R9_w=3D0 refs=3D3,4
; bpf_for_each(cpumask, cpu, mask) {
34: (15) if r7 =3D=3D 0x0 goto pc+57      ; frame1: R7_w=3D0 refs=3D3,4
; bpf_for_each(cpumask, cpu, mask) {
92: (bf) r1 =3D r10                     ; frame1: R1_w=3Dfp0 R10=3Dfp0 refs=
=3D3,4
; bpf_for_each(cpumask, cpu, mask) {
93: (07) r1 +=3D -24                    ; frame1: R1_w=3Dfp-24 refs=3D3,4
94: (85) call bpf_iter_cpumask_destroy#77161          ; frame1: refs=3D3
; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
95: (61) r1 =3D *(u32 *)(r10 -40)       ; frame1: R1_w=3D0 R10=3Dfp0
fp-40=3D????0 refs=3D3
96: (bc) w1 =3D w1                      ; frame1: R1_w=3D0 refs=3D3
97: (7b) *(u64 *)(r10 -8) =3D r1        ; frame1: R1_w=3D0 R10=3Dfp0 fp-8_w=
=3D0 refs=3D3
98: (79) r1 =3D *(u64 *)(r10 -32)       ; frame1: R1_w=3D0 R10=3Dfp0 fp-32=
=3D0 refs=3D3
99: (7b) *(u64 *)(r10 -16) =3D r1       ; frame1: R1_w=3D0 R10=3Dfp0 fp-16_=
w=3D0 refs=3D3
100: (7b) *(u64 *)(r10 -24) =3D r9      ; frame1: R9=3D0 R10=3Dfp0 fp-24_w=
=3D0 refs=3D3
101: (79) r1 =3D *(u64 *)(r8 +0)        ; frame1:
R1_w=3Dtrusted_ptr_seq_file() R8=3Dtrusted_ptr_bpf_iter_meta() refs=3D3
102: (bf) r4 =3D r10                    ; frame1: R4_w=3Dfp0 R10=3Dfp0 refs=
=3D3
; bpf_for_each(cpumask, cpu, mask) {
103: (07) r4 +=3D -24                   ; frame1: R4_w=3Dfp-24 refs=3D3
; BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u psi_running %u\n",
104: (18) r2 =3D 0xffff9bce47e0e210     ; frame1:
R2_w=3Dmap_value(map=3Dcpumask_.rodata,ks=3D4,vs=3D41) refs=3D3
106: (b4) w3 =3D 41                     ; frame1: R3_w=3D41 refs=3D3
107: (b4) w5 =3D 24                     ; frame1: R5_w=3D24 refs=3D3
108: (85) call bpf_seq_printf#126     ; frame1: R0=3Dscalar() refs=3D3
; }
109: (95) exit
bpf_rcu_read_unlock is missing
processed 45 insns (limit 1000000) max_states_per_insn 0 total_states
5 peak_states 5 mark_read 3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Another workaround is using the __always_inline :
static __always_inline void read_percpu_data(struct bpf_iter_meta
*meta, struct cgroup *cgrp, const cpumask_t *mask)

>
> > +SEC("iter.s/cgroup")
> > +int BPF_PROG(test_cpumask_iter_sleepable, struct bpf_iter_meta *meta, =
struct cgroup *cgrp)
> > +{
> > +       struct task_struct *p;
> > +
> > +       /* epilogue */
> > +       if (!cgrp)
> > +               return 0;
> > +
> > +       bpf_rcu_read_lock();
> > +       p =3D bpf_task_from_pid(pid);
> > +       if (!p) {
> > +               bpf_rcu_read_unlock();
> > +               return 1;
> > +       }
> > +
> > +       READ_PERCPU_DATA(meta, cgrp, p->cpus_ptr);
> > +       bpf_task_release(p);
> > +       bpf_rcu_read_unlock();
> > +       return 0;
> > +}
> > +
>
> [...]



--=20
Regards
Yafang

