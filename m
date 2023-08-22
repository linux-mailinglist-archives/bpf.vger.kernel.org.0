Return-Path: <bpf+bounces-8320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F504784D7C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBC62811A7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFD20F03;
	Tue, 22 Aug 2023 23:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41B20EE3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:52:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21365184
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:52:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so6114480a12.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692748354; x=1693353154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAQ134vFqSj7GXR98nifg548PAJEPCj1KUcDhRpApqg=;
        b=L4Km4UXJQAGLCu7zLi9jLQNdTZYXOASPE1C09Da5X2JdArzr+W8SNrlD7V20DxrKCz
         kzAwEikQQ1k4pOfNHvx35s/oJ4FE9TQbe5Tbhur0EyzTzzlC11BFXtveM94xUDsgJ+nK
         a8rL0tQpRXXjAyM/Bxue4sr5ptbMjjgGF6/FfiFM7Ru20VOqcL/XlHE2UC40QcL7jIex
         b6z20qFbs8pEMRSoaTdeOT/9JBFskM3fl9qVZJUvsrsZVbUxsMcYRUQxegJl/IlG1o1B
         t+sJLNI10ukF61vxDnrHC+OWM3cEoeHn99I0UbolbuGEVGVE+vNhrnbXUUT0pHEaY4Y0
         UjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692748354; x=1693353154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAQ134vFqSj7GXR98nifg548PAJEPCj1KUcDhRpApqg=;
        b=gYCvNBO9kCxKFYbZqzSrVIDVfXnzfCMKW4z+bpYDNGJ2cYDafH2wvFDUeXQhcfYNYX
         BzzBp9C/dSW40/WOZPDGNIcov92CoXNd5BxW6aUyBWYrXa/IDxlHZqjyiFxtn71ai14l
         8gbxH9v3vlx99Xl1OF6ihgNajPjZm23HaHcoCfPNVBdUtNmhRb2biS/BIItvnrc9tQl3
         3mL91CegMgBcI3rLm/NT04D+Rcijnp3ydufhf4tKbsLJOZEEhcvRy6PLEIvV0v9XjQLM
         Hmef3Km8yK3tFsDqov6s4gJakGg92X1QzPD9v3oCFeyPoeP4yw0jekAujEw0P7eu4VLj
         NoRw==
X-Gm-Message-State: AOJu0YyqhsA28Cn5yCx6kGs4YWcE1L1+aOnptnkWSWJvE2PJIYLrsDLo
	/rh7Q1J/oB8eEW1UoNBreVc1W0L7GsCFr65QjqU=
X-Google-Smtp-Source: AGHT+IEJ11MfeyqZDKCpivr0Ss9GIEtuYqZTjN1QZFW71tqb7WMIiZD6CBfW/yK4CTVdYyn2sQE71p8nuzmoyAB9OKo=
X-Received: by 2002:aa7:c14e:0:b0:529:fa63:ef7d with SMTP id
 r14-20020aa7c14e000000b00529fa63ef7dmr7994883edp.7.1692748354368; Tue, 22 Aug
 2023 16:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050558.2937659-1-davemarchevsky@fb.com> <20230822050558.2937659-3-davemarchevsky@fb.com>
In-Reply-To: <20230822050558.2937659-3-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Aug 2023 16:52:22 -0700
Message-ID: <CAEf4BzZouNbzP7xOPxnU_Xzof2-L0fNE4CcjCcUJpJjAdyPJSw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, yonghong.song@linux.dev, 
	sdf@google.com, Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 10:06=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
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
> A pointer to an inner data struct, struct bpf_iter_task_vma_kern_data, is=
 the
> only field in struct bpf_iter_task_vma. This is because the inner data
> struct contains a struct vma_iterator (not ptr), whose size is likely to
> change under us. If bpf_iter_task_vma_kern contained vma_iterator directl=
y
> such a change would require change in opaque bpf_iter_task_vma struct's
> size. So better to allocate vma_iterator using BPF allocator, and since
> that alloc must already succeed, might as well allocate all iter fields,
> thereby freezing struct bpf_iter_task_vma size.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>  include/uapi/linux/bpf.h                      |  4 +
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 84 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                |  4 +
>  tools/lib/bpf/bpf_helpers.h                   |  8 ++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
>  7 files changed, 116 insertions(+), 13 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8790b3962e4b..49fc1989a548 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_task_vma {
> +       __u64 __opaque[1]; /* See bpf_iter_num comment above */
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
> index c4ab9d6cdbe9..51c2dce435c1 100644
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
> @@ -823,6 +825,88 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
>         .arg5_type      =3D ARG_ANYTHING,
>  };
>
> +struct bpf_iter_task_vma_kern_data {
> +       struct task_struct *task;
> +       struct mm_struct *mm;
> +       struct mmap_unlock_irq_work *work;
> +       struct vma_iterator vmi;
> +};
> +
> +/* Non-opaque version of uapi bpf_iter_task_vma */
> +struct bpf_iter_task_vma_kern {
> +       struct bpf_iter_task_vma_kern_data *data;
> +} __attribute__((aligned(8)));
> +

it's a bit worrying that we'll rely on memory allocation inside NMI to
be able to use this. I'm missing previous email discussion (I declared
email bankruptcy after long vacation), but I suppose the option to fix
bpf_iter_task_vma (to 88 bytes: 64 for vma_iterator + 24 for extra
pointers), or even to 96 to have a bit of headroom in case we need a
bit more space was rejected? It seems unlikely that vma_iterator will
have to grow, but if it does, it has 5 bytes of padding right now for
various flags, plus we can have extra 8 bytes reserved just in case.

I know it's a big struct and will take a big chunk of the BPF stack,
but I'm a bit worried about both the performance implication of mem
alloc under NMI, and allocation failing.

Maybe the worry is overblown, but I thought I'll bring it up anyways.

> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> +                                     struct task_struct *task, u64 addr)
> +{
> +       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> +       bool irq_work_busy =3D false;
> +       int err;
> +

[...]

>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 8790b3962e4b..49fc1989a548 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7311,4 +7311,8 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +struct bpf_iter_task_vma {
> +       __u64 __opaque[1]; /* See bpf_iter_num comment above */
> +} __attribute__((aligned(8)));
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index bbab9ad9dc5a..d885ffee4d88 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -302,6 +302,14 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it,=
 int start, int end) __weak
>  extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>  extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
>
> +struct bpf_iter_task_vma;
> +
> +extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> +                                struct task_struct *task,
> +                                unsigned long addr) __weak __ksym;
> +extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_tas=
k_vma *it) __weak __ksym;
> +extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __we=
ak __ksym;

my intent wasn't to add all open-coded iterators to bpf_helpers.h. I
think bpf_iter_num_* is rather an exception and isn't supposed to ever
change or be removed, while other iterators should be allowed to be
changed.

The goal is for all such kfuncs (and struct bpf_iter_task_vma state
itself, probably) to come from vmlinux.h, eventually, so let's leave
it out of libbpf's stable bpf_helpers.h header.


[...]

> @@ -1533,7 +1533,7 @@ static void test_task_vma_dead_task(void)
>  out:
>         waitpid(child_pid, &wstatus, 0);
>         close(iter_fd);
> -       bpf_iter_task_vma__destroy(skel);
> +       bpf_iter_task_vmas__destroy(skel);
>  }
>
>  void test_bpf_sockmap_map_iter_fd(void)
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tool=
s/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> rename to tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
> --
> 2.34.1
>

