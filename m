Return-Path: <bpf+bounces-7587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798357794A1
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE20281FAC
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C511738;
	Fri, 11 Aug 2023 16:22:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35B11730
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:22:26 +0000 (UTC)
Received: from out-67.mta0.migadu.com (out-67.mta0.migadu.com [IPv6:2001:41d0:1004:224b::43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129F92
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:22:24 -0700 (PDT)
Message-ID: <2ade9ea7-e4f5-9fc8-397c-006d37565360@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691770943; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EVW6LYcnHJuCtVcyaArnUeNbVM7z7J10CbSPpRukNA=;
	b=mldC5hWP7AMMjcnTNQ5FIXfoojfj0yqfriSda6HVU0yzfllTy57UA6rr/zk5gQGHjwP0j1
	M1LQ8z0p1GrEC0odWkKjn4Ihq+OfJU+3ffZJyPcq3inucJODKm5iyCjpAAHsXqa5nByDk/
	jXGg80mbP+/dKdB6tm4ugbjqX+AD1BQ=
Date: Fri, 11 Aug 2023 09:22:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 2/3] bpf: Introduce task_vma open-coded iterator
 kfuncs
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Nathan Slingerland <slinger@meta.com>
References: <20230810183513.684836-1-davemarchevsky@fb.com>
 <20230810183513.684836-3-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230810183513.684836-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 11:35 AM, Dave Marchevsky wrote:
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
> selftest for the seq_file task_vma iter's bpf skel, so the selftests/bpf/progs
> file is renamed in order to avoid the collision.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Nathan Slingerland <slinger@meta.com>
> ---
>   include/uapi/linux/bpf.h                      |  5 ++
>   kernel/bpf/helpers.c                          |  3 +
>   kernel/bpf/task_iter.c                        | 56 +++++++++++++++++++
>   tools/include/uapi/linux/bpf.h                |  5 ++
>   tools/lib/bpf/bpf_helpers.h                   |  8 +++
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 26 ++++-----
>   ...f_iter_task_vma.c => bpf_iter_task_vmas.c} |  0
>   7 files changed, 90 insertions(+), 13 deletions(-)
>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21deb46f49f..c4a65968f9f5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7291,4 +7291,9 @@ struct bpf_iter_num {
>   	__u64 __opaque[1];
>   } __attribute__((aligned(8)));
>   
> +struct bpf_iter_task_vma {
> +	__u64 __opaque[9]; /* See bpf_iter_num comment above */
> +	char __opaque_c[3];
> +} __attribute__((aligned(8)));

I do see we have issues with this struct. See below.

> +
>   #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb91cae0612a..7a06dea749f1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2482,6 +2482,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c4ab9d6cdbe9..76be9998a65a 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -8,6 +8,7 @@
>   #include <linux/fdtable.h>
>   #include <linux/filter.h>
>   #include <linux/btf_ids.h>
> +#include <linux/mm_types.h>
>   #include "mmap_unlock_work.h"
>   
>   static const char * const iter_task_type_names[] = {
> @@ -823,6 +824,61 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>   	.arg5_type	= ARG_ANYTHING,
>   };
>   
> +struct bpf_iter_task_vma_kern {
> +	struct mm_struct *mm;
> +	struct mmap_unlock_irq_work *work;
> +	struct vma_iterator vmi;
> +} __attribute__((aligned(8)));

Let us say in 6.5, There is an app developed with 6.5 and
everything works fine.

And in 6.6, vma_iterator size changed, either less or more than
the size in 6.5, then how you fix this issue? You need to update
uapi header bpf_iter_task_vma? Update the header file?
If the vma_iterator size is grew from 6.6, then the app won't work
any more.

So I suggest we do allocation for vma_iterator in bpf_iter_task_vma_new
to avoid this uapi issue.

> +
> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> +				      struct task_struct *task, u64 addr)
> +{
> +	struct bpf_iter_task_vma_kern *i = (void *)it;

i => kit?

> +	bool irq_work_busy = false;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
> +
> +	BTF_TYPE_EMIT(struct bpf_iter_task_vma);

This is not needed.

> +
> +	/* NULL i->mm signals failed bpf_iter_task_vma initialization.
> +	 * i->work == NULL is valid.
> +	 */
> +	i->mm = NULL;
> +	if (!task)
> +		return -ENOENT;
> +
> +	i->mm = task->mm;
> +	if (!i->mm)
> +		return -ENOENT;
> +
> +	irq_work_busy = bpf_mmap_unlock_get_irq_work(&i->work);
> +	if (irq_work_busy || !mmap_read_trylock(i->mm)) {
> +		i->mm = NULL;
> +		return -EBUSY;
> +	}
> +
> +	vma_iter_init(&i->vmi, i->mm, addr);
> +	return 0;
> +}
> +
> +__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
> +{
> +	struct bpf_iter_task_vma_kern *i = (void *)it;
> +
> +	if (!i->mm) /* bpf_iter_task_vma_new failed */
> +		return NULL;
> +	return vma_next(&i->vmi);
> +}
> +
> +__bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> +{
> +	struct bpf_iter_task_vma_kern *i = (void *)it;
> +
> +	if (i->mm)
> +		bpf_mmap_unlock_mm(i->work, i->mm);
> +}
> +
>   DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>   
[...]

