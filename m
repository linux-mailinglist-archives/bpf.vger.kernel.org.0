Return-Path: <bpf+bounces-12206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A387C9110
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220A3B20B8C
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0D2C84B;
	Fri, 13 Oct 2023 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b18UG7yN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69197224DF
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:56:15 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E84CE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:56:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53406799540so4537395a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237771; x=1697842571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fgSECplcTiiogj0kolgsZq95bMuWhTDfz9dh8KhmKA=;
        b=b18UG7yNcX8UtoTmYgxIaMZzgwg2byuZf1KbGiYJX4etSNKgILksl0PKJdsSwJRZDI
         KieQEubCofuyue812ZLXxw66o+cMnheC1nttdmOpEuYqyVrD/DHtHsuRnP4uy6ILFlVi
         H84/tyrvTJSkgaOaLhOkhRSLolKaEWkG7HjJbu+7jUiF4k1HToNrETOpbElETWXWZLfB
         NgTp1WaGKuz6l4tbub2oSbhITukspS2YfUArqx8kZmSK1VzSfB0Js+cPqOjhp8WcQDbC
         t8MNj8a9Hf5+Q/37RPEuqY5YXYqA5kG+JiSRnXfLKEEWRulfh1eBdfje4NIswjopm3Ob
         D+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237771; x=1697842571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fgSECplcTiiogj0kolgsZq95bMuWhTDfz9dh8KhmKA=;
        b=XQV63zDFjywZJe7VkJ/nBLgGrGDOgdM3UMlNgM6yyE+8rL5g8JiX1mglmg+pcEdeJp
         ND0Vzd+t1yMW1AUo43JEkafljJ92k84QmBlUY6k+3Nv92xZQK7XRFaf5YQL6/IOZp8nL
         N8FmEx5Eh5DvQ0G6G3m9sG1UXVi5+Pbk1qjVizH9fPeAslYY3XSk1Zij2ANu4KFTR0s2
         dn6Y+nui47coTVUWfB8hgkuniyW6dyFCCrHl7jycwOoD06b47pFN5ZYBZu4tt/UQrb/R
         kjyQiSFeDJoqAVVIXFUqoO9KcHrsvIIKi1jDtmMa5gOO9n9lUJAjZRTXI9oQErF3j3K3
         n5Dw==
X-Gm-Message-State: AOJu0Yx+Onb20tUx/M5VVepTFXLk5fjsdg9On81GBNmwuAZIHwbxTFe8
	QoA9mGhWOOzfYvd+BYfw5HqNzQCI0xBILh99QZk=
X-Google-Smtp-Source: AGHT+IEELREQ3Ap+qc4N6qa5n9kVB489h0FPju2aDzC5iOo5ynTlQNSTfmwTzkwa3X+4CpxbH2blZfaUFkXtK9EXpHw=
X-Received: by 2002:aa7:d1d8:0:b0:523:4a4e:3b57 with SMTP id
 g24-20020aa7d1d8000000b005234a4e3b57mr24438035edp.13.1697237771491; Fri, 13
 Oct 2023 15:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013204426.1074286-1-davemarchevsky@fb.com> <17453ff8-895b-4684-9c7d-2c64d82cf9e1@linux.dev>
In-Reply-To: <17453ff8-895b-4684-9c7d-2c64d82cf9e1@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 15:56:00 -0700
Message-ID: <CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwqCTChK2Dcb1Xig@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 0/5] Open-coded task_vma iter
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 1:48=E2=80=AFPM David Marchevsky
<david.marchevsky@linux.dev> wrote:
>
> On 10/13/23 4:44 PM, Dave Marchevsky wrote:
> > At Meta we have a profiling daemon which periodically collects
> > information on many hosts. This collection usually involves grabbing
> > stacks (user and kernel) using perf_event BPF progs and later symbolica=
ting
> > them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
> > remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. I=
n
> > those cases we must fall back to digging around in /proc/PID/maps to ma=
p
> > virtual address to (binary, offset). The /proc/PID/maps digging does no=
t
> > occur synchronously with stack collection, so the process might already
> > be gone, in which case it won't have /proc/PID/maps and we will fail to
> > symbolicate.
> >
> > This 'exited process problem' doesn't occur very often as
> > most of the prod services we care to profile are long-lived daemons, bu=
t
> > there are enough usecases to warrant a workaround: a BPF program which
> > can be optionally loaded at data collection time and essentially walks
> > /proc/PID/maps. Currently this is done by walking the vma list:
> >
> >   struct vm_area_struct* mmap =3D BPF_CORE_READ(mm, mmap);
> >   mmap_next =3D BPF_CORE_READ(rmap, vm_next); /* in a loop */
> >
> > Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
> > longer a vma linked list to walk. Walking the vma maple tree is not as
> > simple as hopping struct vm_area_struct->vm_next. Luckily,
> > commit f39af05949a4 ("mm: add VMA iterator"), another commit in that se=
ries,
> > added struct vma_iterator and for_each_vma macro for easy vma iteration=
. If
> > similar functionality was exposed to BPF programs, it would be perfect =
for our
> > usecase.
> >
> > This series adds such functionality, specifically a BPF equivalent of
> > for_each_vma using the open-coded iterator style.
> >
> > Notes:
> >   * This approach was chosen after discussion on a previous series [0] =
which
> >     attempted to solve the same problem by adding a BPF_F_VMA_NEXT flag=
 to
> >     bpf_find_vma.
> >   * Unlike the task_vma bpf_iter, the open-coded iterator kfuncs here d=
o not
> >     drop the vma read lock between iterations. See Alexei's response in=
 [0].
> >   * The [vsyscall] page isn't really part of task->mm's vmas, but
> >     /proc/PID/maps returns information about it anyways. The vma iter a=
dded
> >     here does not do the same. See comment on selftest in patch 3.
> >   * bpf_iter_task_vma allocates a _data struct which contains - among o=
ther
> >     things - struct vma_iterator, using BPF allocator and keeps a point=
er to
> >     the bpf_iter_task_vma_data. This is done in order to prevent change=
s to
> >     struct ma_state - which is wrapped by struct vma_iterator - from
> >     necessitating changes to uapi struct bpf_iter_task_vma.
> >
> > Changelog:
> >
> > v6 -> v7: https://lore.kernel.org/bpf/20231010185944.3888849-1-davemarc=
hevsky@fb.com/
> >
> > Patch numbers correspond to their position in v6
> >
> > Patch 2 ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vm=
as.c")
> >   * Add Andrii ack
> > Patch 3 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> >   * Add Andrii ack
> >   * Add missing __diag_ignore_all for -Wmissing-prototypes (Song)
> > Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
> >   * Remove two unnecessary header includes (Andrii)
> >   * Remove extraneous !vmas_seen check (Andrii)
>
> Whoops, forgot to add another bullet here:
>   * Initialize FILE *f =3D NULL to address llvm-16 CI warnings (Andrii)
>
> > New Patch ("bpf: Add BPF_KFUNC_{START,END}_defs macros")
> >   * After talking to Andrii, this is an attempt to clean up __diag_igno=
re_all
> >     spam everywhere kfuncs are defined. If nontrivial changes are neede=
d,
> >     let's apply the other 4 and I'll respin as a standalone patch.
> >
> > v5 -> v6: https://lore.kernel.org/bpf/20231010175637.3405682-1-davemarc=
hevsky@fb.com/
> >
> > Patch 4 ("selftests/bpf: Add tests for open-coded task_vma iter")
> >   * Remove extraneous blank line. I did this manually to the .patch fil=
e
> >     for v5, which caused BPF CI to complain about failing to apply the
> >     series
> >
> > v4 -> v5: https://lore.kernel.org/bpf/20231002195341.2940874-1-davemarc=
hevsky@fb.com/
> >
> > Patch numbers correspond to their position in v4
> >
> > New Patch ("selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_=
vmas.c")
> >   * Patch 2's renaming of this selftest, and associated changes in the
> >     userspace runner, are split out into this separate commit (Andrii)
> >
> > Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> >   * Remove bpf_iter_task_vma kfuncs from libbpf's bpf_helpers.h, they'l=
l be
> >     added to selftests' bpf_experimental.h in selftests patch below (An=
drii)
> >   * Split bpf_iter_task_vma.c renaming into separate commit (Andrii)
> >
> > Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
> >   * Add bpf_iter_task_vma kfuncs to bpf_experimental.h (Andrii)
> >   * Remove '?' from prog SEC, open_and_load the skel in one operation (=
Andrii)
> >   * Ensure that fclose() always happens in test runner (Andrii)
> >   * Use global var w/ 1000 (vm_start, vm_end) structs instead of two
> >     MAP_TYPE_ARRAY's w/ 1k u64s each (Andrii)
> >
> >
> > v3 -> v4: https://lore.kernel.org/bpf/20230822050558.2937659-1-davemarc=
hevsky@fb.com/
> >
> > Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
> >   * Add Andrii ack
> > Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> >   * Mark bpf_iter_task_vma_new args KF_RCU and remove now-unnecessary !=
task
> >     check (Yonghong)
> >     * Although KF_RCU is a function-level flag, in reality it only appl=
ies to
> >       the task_struct *task parameter, as the other two params are a sc=
alar int
> >       and a specially-handled KF_ARG_PTR_TO_ITER
> >    * Remove struct bpf_iter_task_vma definition from uapi headers, defi=
ne in
> >      kernel/bpf/task_iter.c instead (Andrii)
> > Patch 3 ("selftests/bpf: Add tests for open-coded task_vma iter")
> >   * Use a local var when looping over vmas to track map idx. Update vma=
s_seen
> >     global after done iterating. Don't start iterating or update vmas_s=
een if
> >     vmas_seen global is nonzero. (Andrii)
> >   * Move getpgid() call to correct spot - above skel detach. (Andrii)
> >
> > v2 -> v3: https://lore.kernel.org/bpf/20230821173415.1970776-1-davemarc=
hevsky@fb.com/
> >
> > Patch 1 ("bpf: Don't explicitly emit BTF for struct btf_iter_num")
> >   * Add Yonghong ack
> >
> > Patch 2 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> >   * UAPI bpf header and tools/ version should match
> >   * Add bpf_iter_task_vma_kern_data which bpf_iter_task_vma_kern points=
 to,
> >     bpf_mem_alloc/free it instead of just vma_iterator. (Alexei)
> >     * Inner data ptr =3D=3D NULL implies initialization failed
> >
> >
> > v1 -> v2: https://lore.kernel.org/bpf/20230810183513.684836-1-davemarch=
evsky@fb.com/
> >   * Patch 1
> >     * Now removes the unnecessary BTF_TYPE_EMIT instead of changing the
> >       type (Yonghong)
> >   * Patch 2
> >     * Don't do unnecessary BTF_TYPE_EMIT (Yonghong)
> >     * Bump task refcount to prevent ->mm reuse (Yonghong)
> >     * Keep a pointer to vma_iterator in bpf_iter_task_vma, alloc/free
> >       via BPF mem allocator (Yonghong, Stanislav)
> >   * Patch 3
> >
> >   [0]: https://lore.kernel.org/bpf/20230801145414.418145-1-davemarchevs=
ky@fb.com/
> >
> > Dave Marchevsky (5):
> >   bpf: Don't explicitly emit BTF for struct btf_iter_num
> >   selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
> >   bpf: Introduce task_vma open-coded iterator kfuncs
> >   selftests/bpf: Add tests for open-coded task_vma iter
> >   bpf: Add BPF_KFUNC_{START,END}_defs macros

I dropped patch #5 from the series and applied the rest, thanks.

For BPF_KFUNC_{START,END}_DEFS, I like the clean up, but I feel like
we might want to follow similar function-call like syntax as with
__diag_push() and make sure we use semicolon to terminate their
"invocations". If you agree, please adjust and submit separately, I'd
be curious to see what others think.

Also, keep in mind that __diag_ignore_all("-Wmissing-prototypes") that
we use right now might not be enough. We started getting more and more
reports with different warnings recently, so we probably would need to
ignore more warnings for kfuncs:

kernel/bpf/helpers.c:1906:19: warning: no previous declaration for
'bpf_percpu_obj_new_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:1942:18: warning: no previous declaration for
'bpf_percpu_obj_drop_impl' [-Wmissing-declarations]
kernel/bpf/helpers.c:2477:18: warning: no previous declaration for
'bpf_throw' [-Wmissing-declarations]

Which just means that this refactoring is even more important and timely :)


> >
> >  include/linux/btf.h                           |  7 ++
> >  kernel/bpf/bpf_iter.c                         |  8 +-
> >  kernel/bpf/cpumask.c                          |  6 +-
> >  kernel/bpf/helpers.c                          |  9 +-
> >  kernel/bpf/map_iter.c                         |  6 +-
> >  kernel/bpf/task_iter.c                        | 89 +++++++++++++++++++
> >  kernel/trace/bpf_trace.c                      |  6 +-
> >  net/bpf/test_run.c                            |  7 +-
> >  net/core/filter.c                             | 13 +--
> >  net/core/xdp.c                                |  6 +-
> >  net/ipv4/fou_bpf.c                            |  6 +-
> >  net/netfilter/nf_conntrack_bpf.c              |  6 +-
> >  net/netfilter/nf_nat_bpf.c                    |  6 +-
> >  net/xfrm/xfrm_interface_bpf.c                 |  6 +-
> >  .../testing/selftests/bpf/bpf_experimental.h  |  8 ++
> >  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
> >  .../testing/selftests/bpf/prog_tests/iters.c  | 58 ++++++++++++
> >  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
> >  .../selftests/bpf/progs/iters_task_vma.c      | 43 +++++++++
> >  19 files changed, 248 insertions(+), 68 deletions(-)
> >  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf=
_iter_task_vmas.c} (100%)
> >  create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
> >

