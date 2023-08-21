Return-Path: <bpf+bounces-8191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A5783591
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BD9280F2A
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091A19BC1;
	Mon, 21 Aug 2023 22:24:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EE11720
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:24:50 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A488FD
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:24:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so19620601fa.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692656687; x=1693261487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0WuUs3MF0y7cxCxgEkH0x+NfOuw2bUhJw8gIlJaRfc=;
        b=c9AS+jaByGywXlHw5w+eMwAV8sKQFfyhTaRAAkQT60/NmLefmPtmmdGILv3QzDCmof
         kl5VIzIpH3XGGSXRxyoP8W85VyEaQ2X5SgMt4b2CQldz6vZa5g5S6ALZdw4RfgI/gYtl
         J+A06/wOO1PCxP1FY1srArVNJj5HtV27Nw1DUSA3UWKOrGLg9kY/MJU3a1bBNgzZVh6P
         SLY3Bjjv9DrWYIt2wjqFicgcd/CQe22YSlJcMtidfw2cQp072OsSgh3q48YoobSXqrk7
         Yen2wcw1McIjSgnyx6c79Jp0kCE/QteXsPyUl//rq0lhPMuohikw3N8j5dPHNKQ7EOjw
         PkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656687; x=1693261487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0WuUs3MF0y7cxCxgEkH0x+NfOuw2bUhJw8gIlJaRfc=;
        b=MhZ9Cg43LiclrVtzFY99i9KWgP0sksF//hovUswNP5nTsdFg0Vlrq/iaTeC+IOWzt9
         uEXSY6nMzoynWX7IhSilf6Y+sM61LTEL6LQmDO1WvRLWpoxKxyvBWKlGf3635RT/mKSo
         OGCHjzwyWbzU2Zlh11w8eWp8P1Q2129B+vR6FI195+uqjkrHDIKSmU9ZCZxzji0KMDDj
         cV2BqBLvQLFuGht3ztkWkDgzvzmZq4i1MBYbvG6O5xKat9LXhWxGgtS5gpEtEXrsWRMB
         HjTfXn3rbs1JXqiZD4ZZXSa8qAZLTmqafcOJ18yEZb3hgMn0hJQ/wfhtM50Tf3EySwhC
         aWJA==
X-Gm-Message-State: AOJu0YypwVCIACbVF50MuIf5OkmvvtP30L2EHjqFXK0LCZBXl/m92dAH
	5r2cPkDgTNZtXEwEB25x29Yksj/sHw52VySBMN0=
X-Google-Smtp-Source: AGHT+IFbcFX4UNEiplx3U68tb7fxHpfz2cV0VG99IAWOq1el53/0+RuU/Iccb74/6YZaHujB9UsvubjewIXq8WuxZP4=
X-Received: by 2002:a2e:b70a:0:b0:2b6:cc12:4cf3 with SMTP id
 j10-20020a2eb70a000000b002b6cc124cf3mr5975623ljo.48.1692656686904; Mon, 21
 Aug 2023 15:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821173415.1970776-1-davemarchevsky@fb.com> <20230821173415.1970776-3-davemarchevsky@fb.com>
In-Reply-To: <20230821173415.1970776-3-davemarchevsky@fb.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Aug 2023 15:24:35 -0700
Message-ID: <CAADnVQ+gZM4Gt4-C4ka5pkFsbAfQE4R=wt1on+xk02nv2KfLBg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 10:34=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task_vma in open-coded
> iterator style. BPF programs can use these kfuncs directly or through
> bpf_for_each macro for natural-looking iteration of all task vmas.
>
> The implementation borrows heavily from bpf_find_vma helper's locking -
> differing only in that it holds the mmap_read lock for all iterations
> while the helper only executes its provided callback on a maximum of 1
> vma. Aside from locking, struct vma_iterator and vma_next do all the
> heavy lifting.
>
> The newly-added struct bpf_iter_task_vma has a name collision with a
> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/=
progs
> file is renamed in order to avoid the collision.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>  include/uapi/linux/bpf.h                      |  4 +
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 79 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  5 ++
>  tools/lib/bpf/bpf_helpers.h                   |  8 ++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
>  7 files changed, 112 insertions(+), 13 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21deb46f49f..d90f9bf8080f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7291,4 +7291,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_task_vma {
> +       __u64 __opaque[4]; /* See bpf_iter_num comment above */
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb91cae0612a..7a06dea749f1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c4ab9d6cdbe9..fb934ca9e020 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -7,7 +7,9 @@
>  #include <linux/fs.h>
>  #include <linux/fdtable.h>
>  #include <linux/filter.h>
> +#include <linux/bpf_mem_alloc.h>
>  #include <linux/btf_ids.h>
> +#include <linux/mm_types.h>
>  #include "mmap_unlock_work.h"
>
>  static const char * const iter_task_type_names[] =3D {
> @@ -823,6 +825,83 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>         .arg5_type      =3D ARG_ANYTHING,
>  };
>
> +/* Non-opaque version of uapi bpf_iter_task_vma */
> +struct bpf_iter_task_vma_kern {
> +       struct task_struct *task;
> +       struct mm_struct *mm;
> +       struct mmap_unlock_irq_work *work;
> +       struct vma_iterator *vmi;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> +                                     struct task_struct *task, u64 addr)
> +{
> +       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> +       bool irq_work_busy =3D false;
> +       int err;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(st=
ruct bpf_iter_task_vma));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __al=
ignof__(struct bpf_iter_task_vma));
> +
> +       /* NULL i->mm signals failed bpf_iter_task_vma initialization.
> +        * i->work =3D=3D NULL is valid.
> +        */
> +       kit->mm =3D NULL;
> +       kit->task =3D NULL;
> +       if (!task)
> +               return -ENOENT;
> +
> +       kit->task =3D get_task_struct(task);
> +       kit->mm =3D task->mm;
> +       if (!kit->mm) {
> +               err =3D -ENOENT;
> +               goto err_put_task;
> +       }
> +
> +       kit->vmi =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct vma_iter=
ator));
> +       if (!kit->vmi) {
> +               err =3D -ENOMEM;
> +               goto err_put_task;
> +       }

Since alloc is done anyway, let's alloc the whole bpf_iter_task_vma_kern
and reduce bpf prog side to a single pointer?

