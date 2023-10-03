Return-Path: <bpf+bounces-11323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EA7B7430
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 60AD71F215B5
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B363E483;
	Tue,  3 Oct 2023 22:40:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1F3CD03
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 22:40:15 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A72EAB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:40:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso2560367a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696372811; x=1696977611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kGS2E2XhFyxr8r/ryKbvLD3Vb0qphQMVaTFPc398qY=;
        b=npox2lcLsoj36vUbQX85rh6AHW4+8wBUA3q15qpnA1I0RNQrOVwCMUMZ1l7gVdYLXA
         OuDMY4G0Fr83p6a8kqP2KwSDfjYLOdfqcIRUNQO/sL+A7yF6Ud3CGtUIjF9TN6gaOaKy
         nk4CK2MkJlehM5/12yvhCC9Y/dPRY7jEOEFJ/Pj9MBCE1E5/+sUnm5Y4cIu7rkbhPlhd
         Mr1Cc6wlyHpRVbhiOc8SkaF/hqgRpTbJ9HJSRmPqNqgJYF+D8+x7yOOyvOJYAm3pIKRN
         WjMF5I/nWXRCKeDCwSHjPXbEpM/oKIbnp9kXrXqjlfyWXUfajoVjx/rbaK6cH/OGSCAD
         FIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696372811; x=1696977611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kGS2E2XhFyxr8r/ryKbvLD3Vb0qphQMVaTFPc398qY=;
        b=WkOaq6QSXwMQBD4CMct9bDnxNFtR2CRwMs0XTPjeTFrrH+RmBIFKrjAWvXJcQ55wBU
         tRpU/jigOuH597nEm1jnv4/nr74DTWjQOrwCGkk6y34TYCHLYDsV0RaEmJtdrMFWoAt7
         gkALJ3KxK+G512lam7UsFLITj+D59pB5xlWpz5hQJ0jeNQPsQzP0CES+4PBRek82sCpP
         YpchH48tR+8rwAa/+Wiha0GOl0Enjgrhmb2c98a5+/VH8NVzAntXs8oqmSUxH1LG4kmQ
         RpiI8D0F1OgxwhBz/kJ3koDg7+LuqX6oM2rYP3XtBP+QRPAjCUgS6RLVvRqJtzMUj35Z
         GkVw==
X-Gm-Message-State: AOJu0Yy4TBmQ2Q3gUymdUPyl5V/nlNmlMQhE5WUJxde8UCbsqIC+McZn
	fDUZDY9IJdjVpHKwUMBHgHljmqWJbgDi3nTXYhc=
X-Google-Smtp-Source: AGHT+IH6uV3v1bgdJECO+AJVOUKewv2HHPHCAeGVT+xTUYNaVxyBjyl9DgpswHjDL/77ZpQiV3ICUPbLSG5HFMNj+Sc=
X-Received: by 2002:a17:906:530b:b0:9b2:b975:8327 with SMTP id
 h11-20020a170906530b00b009b2b9758327mr564975ejo.65.1696372811171; Tue, 03 Oct
 2023 15:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002195341.2940874-1-davemarchevsky@fb.com> <20231002195341.2940874-3-davemarchevsky@fb.com>
In-Reply-To: <20231002195341.2940874-3-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 15:39:59 -0700
Message-ID: <CAEf4Bzbsw__KHd6RYB_U_zTG_aOnSaLLkFQZ-87dpB2O2og+=A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: Introduce task_vma open-coded
 iterator kfuncs
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Nathan Slingerland <slinger@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 12:53=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
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
> A pointer to an inner data struct, struct bpf_iter_task_vma_data, is the
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
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 85 +++++++++++++++++++
>  tools/lib/bpf/bpf_helpers.h                   |  8 ++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++---
>  ...f_iter_task_vma.c =3D> bpf_iter_task_vmas.c} |  0
>  5 files changed, 109 insertions(+), 13 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c =3D> bpf_i=
ter_task_vmas.c} (100%)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index dd1c69ee3375..6b2373db65bd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2549,6 +2549,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 7473068ed313..5c8e559be5e5 100644
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
> @@ -803,6 +805,89 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
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
> +struct bpf_iter_task_vma {
> +       /* opaque iterator state; having __u64 here allows to preserve co=
rrect
> +        * alignment requirements in vmlinux.h, generated from BTF
> +        */
> +       __u64 __opaque[1];
> +} __attribute__((aligned(8)));
> +
> +/* Non-opaque version of bpf_iter_task_vma */
> +struct bpf_iter_task_vma_kern {
> +       struct bpf_iter_task_vma_kern_data *data;
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
> +       /* is_iter_reg_valid_uninit guarantees that kit hasn't been initi=
alized
> +        * before, so non-NULL kit->data doesn't point to previously
> +        * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
> +        */
> +       kit->data =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_ite=
r_task_vma_kern_data));
> +       if (!kit->data)
> +               return -ENOMEM;
> +
> +       kit->data->task =3D get_task_struct(task);
> +       kit->data->mm =3D task->mm;
> +       if (!kit->data->mm) {
> +               err =3D -ENOENT;
> +               goto err_cleanup_iter;
> +       }
> +
> +       /* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get=
_irq_work */
> +       irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
> +       if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> +               err =3D -EBUSY;
> +               goto err_cleanup_iter;
> +       }
> +
> +       vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> +       return 0;
> +
> +err_cleanup_iter:
> +       if (kit->data->task)
> +               put_task_struct(kit->data->task);
> +       bpf_mem_free(&bpf_global_ma, kit->data);
> +       /* NULL kit->data signals failed bpf_iter_task_vma initialization=
 */
> +       kit->data =3D NULL;
> +       return err;
> +}
> +
> +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
> +{
> +       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> +
> +       if (!kit->data) /* bpf_iter_task_vma_new failed */
> +               return NULL;
> +       return vma_next(&kit->data->vmi);
> +}
> +
> +__bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> +{
> +       struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> +
> +       if (kit->data) {
> +               bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +               put_task_struct(kit->data->task);
> +               bpf_mem_free(&bpf_global_ma, kit->data);
> +       }
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 77ceea575dc7..c6abb7fd8d73 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -303,6 +303,14 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it,=
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

hm... still in bpf_helpers.h

Also, let's split this change out from kernel changes, there is no
need to couple these changes with kernel patches.

> +
>  #ifndef bpf_for_each
>  /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct=
 for
>   * using BPF open-coded iterators without having to write mundane explic=
it
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..41aba139b20b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -10,7 +10,7 @@
>  #include "bpf_iter_task.skel.h"
>  #include "bpf_iter_task_stack.skel.h"
>  #include "bpf_iter_task_file.skel.h"
> -#include "bpf_iter_task_vma.skel.h"
> +#include "bpf_iter_task_vmas.skel.h"
>  #include "bpf_iter_task_btf.skel.h"
>  #include "bpf_iter_tcp4.skel.h"
>  #include "bpf_iter_tcp6.skel.h"
> @@ -1399,19 +1399,19 @@ static void str_strip_first_line(char *str)
>  static void test_task_vma_common(struct bpf_iter_attach_opts *opts)
>  {
>         int err, iter_fd =3D -1, proc_maps_fd =3D -1;
> -       struct bpf_iter_task_vma *skel;
> +       struct bpf_iter_task_vmas *skel;
>         int len, read_size =3D 4;
>         char maps_path[64];
>
> -       skel =3D bpf_iter_task_vma__open();
> -       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
> +       skel =3D bpf_iter_task_vmas__open();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
>                 return;
>
>         skel->bss->pid =3D getpid();
>         skel->bss->one_task =3D opts ? 1 : 0;
>
> -       err =3D bpf_iter_task_vma__load(skel);
> -       if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
> +       err =3D bpf_iter_task_vmas__load(skel);
> +       if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
>                 goto out;
>
>         skel->links.proc_maps =3D bpf_program__attach_iter(
> @@ -1462,25 +1462,25 @@ static void test_task_vma_common(struct bpf_iter_=
attach_opts *opts)
>  out:
>         close(proc_maps_fd);
>         close(iter_fd);
> -       bpf_iter_task_vma__destroy(skel);
> +       bpf_iter_task_vmas__destroy(skel);
>  }
>
>  static void test_task_vma_dead_task(void)
>  {
> -       struct bpf_iter_task_vma *skel;
> +       struct bpf_iter_task_vmas *skel;
>         int wstatus, child_pid =3D -1;
>         time_t start_tm, cur_tm;
>         int err, iter_fd =3D -1;
>         int wait_sec =3D 3;
>
> -       skel =3D bpf_iter_task_vma__open();
> -       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
> +       skel =3D bpf_iter_task_vmas__open();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vmas__open"))
>                 return;
>
>         skel->bss->pid =3D getpid();
>
> -       err =3D bpf_iter_task_vma__load(skel);
> -       if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
> +       err =3D bpf_iter_task_vmas__load(skel);
> +       if (!ASSERT_OK(err, "bpf_iter_task_vmas__load"))
>                 goto out;
>
>         skel->links.proc_maps =3D bpf_program__attach_iter(
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

let's do this in a separate pre-patch?

> --
> 2.34.1
>

