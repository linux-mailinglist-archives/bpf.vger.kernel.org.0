Return-Path: <bpf+bounces-6624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D854776BE9E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA8D1C210DA
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3591253CE;
	Tue,  1 Aug 2023 20:41:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDE4DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:41:58 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC62122
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:41:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso90878821fa.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690922499; x=1691527299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cQJEpAvFEVUfq05wGt6CvqTIaTucMSpihmxWjGEJpw=;
        b=begiF5oUEEdCl/WU04vtMfoc1+c/QT0L4Jbbzd56fbEZ0LlacSsp3lPAiGMRwW75ws
         sz+0cOGHxuLMAU8U7HtPbP1Dw+ItFCV486KPM8VAgU+WZncMl0YhbWt1LvJ04u498QqH
         xL4l9ZManVUi/yPnCniN+zmr7GbfhkPttRiCrG0Kqzs7/dniTXUSztAsHlxpAuICqJbM
         hmuZexJ2IOY2kn8wCX/4Ym4YsiRoFNTZqexMdxnwRXP/jZYTxZQemZxiv27mji9nmw3s
         uS6G1+hXVLduRZR9DoOUVeSLBucxoKx+MQFdiyWw+fidtIBvYW5YeRri1YkK049povg9
         Ok5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922499; x=1691527299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cQJEpAvFEVUfq05wGt6CvqTIaTucMSpihmxWjGEJpw=;
        b=gxamcqcEadLfIzCj426xiwdi1d25VHoqebysYwE0gwAM68uwpURAEXEAZvF5R3wpLc
         I8OBfnTY8yfPFahReBb+RPu7xbOwZ7xgpbnRKE58Awpn01qdDFEehLRGbdAZD0FS8emm
         Y8hFT422pBI9sV+O6j5ANcsg1/a9GyGPy8RENAZ5CZYqmcDjubPvv069lf5kVhqU61GU
         XX0phcC20oN07bYneMZBJ4DEQzOFdjyEJANkqb63cMRb0HhaST8D04K4vHGNNYm0xea7
         FvQTlNsMxvBam/rC/1ZoKN1QD0StaV0O14bX6b+ubM2VZRKqT580zZkPtEFiP41yUo6y
         Ul4g==
X-Gm-Message-State: ABy/qLY/jXIlA9xBCG5N2cK4S2vsw/S8XksUW7sUuPpaTlnecwC7wkFV
	d2DUJB8EN+5DdvDFsSQjPi7k+cRsHuLP9OIliJjnq6oYCxw=
X-Google-Smtp-Source: APBJJlE40P97lkrOnMRAC+iJerxEM8dXWWJug7H1ONTyPiW2Rg+Puf6GPE2mXynygfmj4sWZ9rwkGEGrgeFkw2XpJEM=
X-Received: by 2002:a2e:9049:0:b0:2b9:e53f:e1fd with SMTP id
 n9-20020a2e9049000000b002b9e53fe1fdmr3217825ljg.34.1690922499099; Tue, 01 Aug
 2023 13:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801145414.418145-1-davemarchevsky@fb.com>
In-Reply-To: <20230801145414.418145-1-davemarchevsky@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 13:41:27 -0700
Message-ID: <CAADnVQKo5VTkmS+DdYc5a8Hns4meptn7g76dOjxmJCHgpo29hQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/2] [RFC] bpf: Introduce BPF_F_VMA_NEXT flag
 for bpf_find_vma helper
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 7:54=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.c=
om> wrote:
>
> At Meta we have a profiling daemon which periodically collects
> information on many hosts. This collection usually involves grabbing
> stacks (user and kernel) using perf_event BPF progs and later symbolicati=
ng
> them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
> remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
> those cases we must fall back to digging around in /proc/PID/maps to map
> virtual address to (binary, offset). The /proc/PID/maps digging does not
> occur synchronously with stack collection, so the process might already
> be gone, in which case it won't have /proc/PID/maps and we will fail to
> symbolicate.
>
> This 'exited process problem' doesn't occur very often as
> most of the prod services we care to profile are long-lived daemons,
> there are enough usecases to warrant a workaround: a BPF program which
> can be optionally loaded at data collection time and essentially walks
> /proc/PID/maps. Currently this is done by walking the vma list:
>
>   struct vm_area_struct* mmap =3D BPF_CORE_READ(mm, mmap);
>   mmap_next =3D BPF_CORE_READ(rmap, vm_next); /* in a loop */
>
> Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
> longer a vma linked list to walk. Walking the vma maple tree is not as
> simple as hopping struct vm_area_struct->vm_next. That commit replaces
> vm_next hopping with calls to find_vma(mm, addr) helper function, which
> returns the vma containing addr, or if no vma contains addr,
> the closest vma with higher start addr.
>
> The BPF helper bpf_find_vma is unsurprisingly a thin wrapper around
> find_vma, with the major difference that no 'closest vma' is returned if
> there is no VMA containing a particular address. This prevents BPF
> programs from being able to use bpf_find_vma to iterate all vmas in a
> task in a reasonable way.
>
> This patch adds a BPF_F_VMA_NEXT flag to bpf_find_vma which restores
> 'closest vma' behavior when used. Because this is find_vma's default
> behavior it's as straightforward as nerfing a 'vma contains addr' check
> on find_vma retval.
>
> Also, change bpf_find_vma's address parameter to 'addr' instead of
> 'start'. The former is used in documentation and more accurately
> describes the param.
>
> [
>   RFC: This isn't an ideal solution for iteration of all vmas in a task
>        in the long term for a few reasons:
>
>      * In nmi context, second call to bpf_find_vma will fail because
>        irq_work is busy, so can't iterate all vmas
>      * Repeatedly taking and releasing mmap_read lock when a dedicated
>        iterate_all_vmas(task) kfunc could just take it once and hold for
>        all vmas
>
>     My specific usecase doesn't do vma iteration in nmi context and I
>     think the 'closest vma' behavior can be useful here despite locking
>     inefficiencies.
>
>     When Alexei and I discussed this offline, two alternatives to
>     provide similar functionality while addressing above issues seemed
>     reasonable:
>
>       * open-coded iterator for task vma. Similar to existing
>         task_vma bpf_iter, but no need to create a bpf_link and read
>         bpf_iter fd from userspace.
>       * New kfunc taking callback similar bpf_find_vma, but iterating
>         over all vmas in one go
>
>      I think this patch is useful on its own since it's a fairly minimal
>      change and fixes my usecase. Sending for early feedback and to
>      solicit further thought about whether this should be dropped in
>      favor of one of the above options.

- In theory this patch can work, but patch 2 didn't attempt to actually
use it in a loop to iterate all vma-s.
Which is a bit of red flag whether such iteration is practical
(either via bpf_loop or bpf_for).

- This behavior of bpf_find_vma() feels too much implementation detail.
find_vma will probably stay this way, since different parts of the kernel
rely on it, but exposing it like BPF_F_VMA_NEXT leaks implementation too mu=
ch.

- Looking at task_vma_seq_get_next().. that's how vma iter should be done a=
nd
I don't think bpf prog can do it on its own.
Because with bpf_find_vma() the lock will drop at every step the problems
described at that large comment will be hit sooner or later.

All concerns combined I feel we better provide a new kfunc that iterates vm=
a
and drops the lock before invoking callback.
It can be much simpler than task_vma_seq_get_next() if we don't drop the lo=
ck.
Maybe it's ok.
Doing it open coded iterators style is likely better.
bpf_iter_vma_new() kfunc will do
bpf_mmap_unlock_get_irq_work+mmap_read_trylock
while bpf_iter_vma_destroy() will bpf_mmap_unlock_mm.

I'd try to do open-code-iter first. It's a good test for the iter infra.
bpf_iter_testmod_seq_new is an example of how to add a new iter.

Another issue with bpf_find_vma is .arg1_type =3D ARG_PTR_TO_BTF_ID.
It's not a trusted arg. We better move away from this legacy pointer.
bpf_iter_vma_new() should accept only trusted ptr to task_struct.
fwiw bpf_get_current_task_btf_proto has
.ret_type =3D RET_PTR_TO_BTF_ID_TRUSTED and it matters here.
The bpf prog might look like:
task =3D bpf_get_current_task_btf();
err =3D bpf_iter_vma_new(&it, task);
while ((vma =3D bpf_iter_vma_next(&it))) ...;
assuming lock is not dropped by _next.

