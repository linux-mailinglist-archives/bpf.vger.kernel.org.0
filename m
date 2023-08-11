Return-Path: <bpf+bounces-7590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A3D7794EA
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211DA1C216DC
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8A1172C;
	Fri, 11 Aug 2023 16:41:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014481170E
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:41:22 +0000 (UTC)
Received: from out-92.mta0.migadu.com (out-92.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432AA18F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:41:21 -0700 (PDT)
Message-ID: <a6e12fbc-dd1b-c8a6-6333-098a46706107@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691772079; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIAgBks8rX8MbXWJt5mxlHaYoP6dYGm7oKaDc/1K2rk=;
	b=ePz6J5W/ICkwqjO3FTJEIb+g0WHsf8mfhxp6ZHFfWxz008Almaav7sFZPmk7sK7idJAJdl
	yJzlj1iSF11DeR7PM43k/8ToshzGTbhblWlq7SnEMvuNaBwE2lvtUMmPCOtQY+Zy3zadZE
	JbA+lTeZMNgJiusrT22PQrkS+gTc8hg=
Date: Fri, 11 Aug 2023 09:41:14 -0700
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
> +
> +__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
> +				      struct task_struct *task, u64 addr)
> +{
> +	struct bpf_iter_task_vma_kern *i = (void *)it;
> +	bool irq_work_busy = false;
> +
> +	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
> +	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
> +
> +	BTF_TYPE_EMIT(struct bpf_iter_task_vma);
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

We might have an issue here as well if task is in __put_task_struct() 
stage. It is possible that we did i->mm from task->mm and then
task is freed and 'mm' is reused by somebody self.

To prevent such cases, I suggest we try to take a reference
of 'task' first. If we can get a reference then task is valid
and task->mm will not be freed and we will be fine.

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
[...]

