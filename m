Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50464132A
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 03:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiLCCPH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 21:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiLCCPG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 21:15:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E638DB6BB;
        Fri,  2 Dec 2022 18:15:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so5809023pgm.6;
        Fri, 02 Dec 2022 18:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vep6IUB7ai0bh6PtCGcGOQtXg6nOVxsrlqgL1oOPeU=;
        b=QjJKYcAp71jYjH4LMC4sjaEQdEw8hjlQZUbKHprV4EF3K0JxbZXPOJtgDD9w3wI+ej
         z6x9n/lysIDW9OR9mYvCJVo2jz4hx0VNd2O9nIe669j5xpLGrSvzRx1GiNKDiRLdYkxm
         0I+BS3GdYyOjw0hqkNJgJb69JJJ+h8+PgptBcqiQ28wVM6Bf3d5XI3pFd6upzrmAd4+X
         X64eZ0OjyYYCdHBAve2Q77Qj+Zi6Hzem0X2HQLvjcNFwiziqW0oays7TewHYU6lXdl72
         JlxXvSftzd4EpOJGspPyzhQN9cQ4d9Z+b4mxcwEtKuH0IuasEIeY1p52oUHl8ZUi8pvD
         spcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vep6IUB7ai0bh6PtCGcGOQtXg6nOVxsrlqgL1oOPeU=;
        b=AK2AmLycdFL4fKC/TpMJYd0zKQFQ2Yu4Fm02sGvv0bY8rsxEEBQdZBk+p2d0+PBJKV
         tuzJfIKVcPDW2B/ifxylSgj+lIF7iExVfRlRAxpUXyZIR1z11VQmKafrfPQLZ6IgJD1D
         eUNUk7WjJp6zEFYcqIpUs6PIFiI85SwseUDeDM3hx3KGVZG1j9D5MJhOY/v65up/EIMV
         wzLI7uWDllP0XNF5dV5UoupVufTRoDqOqTcUNgeo+PSrd1khPUioH1JkU4oW/dmi44sK
         qNp9hL2da9tflLF6ip+iCF61ZRkgLdacz5UlOQo1IaTiMpE3BBbNBS5yXmKMfyJB5Gbv
         Ha1A==
X-Gm-Message-State: ANoB5plcdd6CoqjwoIeJKuOm4xhZdNBzl0Qx8Yk3DSWhU4l9p/YvJ7w5
        gbmRPWcvm6nVtpOrCLacSk8=
X-Google-Smtp-Source: AA0mqf71q0dRxzym4uE3tTAA0mBcKI/VX/vAi8u7TAuKmz865r33xWXiycgLr2Ax95mjo24fnn8Eow==
X-Received: by 2002:a63:4908:0:b0:477:e0b4:3f5 with SMTP id w8-20020a634908000000b00477e0b403f5mr34585532pga.265.1670033704604;
        Fri, 02 Dec 2022 18:15:04 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:c181])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001872999f58esm6194253plk.189.2022.12.02.18.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:15:03 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:15:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] bpf/docs: Document struct task_struct *
 kfuncs
Message-ID: <20221203021500.okerdcfwhgykrxxg@macbook-pro-6.dhcp.thefacebook.com>
References: <20221202220736.521227-1-void@manifault.com>
 <20221202220736.521227-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202220736.521227-2-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 02, 2022 at 04:07:35PM -0600, David Vernet wrote:
> bpf_task_acquire(), bpf_task_release(), bpf_task_kptr_get(), and
> bpf_task_from_pid() are kfuncs that were recently added to
> kernel/bpf/helpers.c. These are "core" kfuncs in that they're available
> for use for any tracepoint or struct_ops BPF program. Though they have
> no ABI stability guarantees, we should still document them. This patch
> adds a new Core kfuncs section to the BPF kfuncs doc, and adds entries
> for all of these task kfuncs.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  Documentation/bpf/kfuncs.rst | 148 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c         |   8 +-
>  2 files changed, 152 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 90774479ab7a..b0c35ad6fad4 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -213,3 +213,151 @@ type. An example is shown below::
>                  return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_task_kfunc_set);
>          }
>          late_initcall(init_subsystem);
> +
> +3. Core kfuncs
> +==============
> +
> +The BPF subsystem provides a number of "core" kfuncs that are potentially
> +applicable to a wide variety of different possible use cases and programs.
> +Those kfuncs are documented here.
> +
> +3.1 struct task_struct * kfuncs
> +-------------------------------
> +
> +There are a number of kfuncs that allow ``struct task_struct *`` objects to be
> +used as kptrs:
> +
> +.. kernel-doc:: kernel/bpf/helpers.c
> +   :identifiers: bpf_task_acquire bpf_task_release
> +
> +These kfuncs are useful when you want to acquire or release a reference to a
> +``struct task_struct *`` that was passed as e.g. a tracepoint arg, or a
> +struct_ops callback arg. For example:
> +
> +.. code-block:: c
> +
> +	/**
> +	 * A trivial example tracepoint program that shows how to
> +	 * acquire and release a struct task_struct * pointer.
> +	 */
> +	SEC("tp_btf/task_newtask")
> +	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
> +	{
> +		struct task_struct *acquired;
> +
> +		acquired = bpf_task_acquire(task);
> +
> +		/*
> +		 * In a typical program you'd do something like store
> +		 * the task in a map. Here, we just release it.

There is a sentence later in this patch about what happens with the pointer
that was stored in a map, but I would add some part of it here as well. Like:

 * In a typical program you'd do something like store
 * the task in a map and the map will automatically release it later.
 * Here, we release it manually.

> +		 */
> +		bpf_task_release(acquired);
> +		return 0;
> +	}
> +
> +If you want to acquire a reference to a ``struct task_struct`` kptr that's
> +already stored in a map, you can use bpf_task_kptr_get():
> +
> +.. kernel-doc:: kernel/bpf/helpers.c
> +   :identifiers: bpf_task_kptr_get
> +
> +Here's an example of how it can be used:
> +
> +.. code-block:: c
> +
> +	/* struct containing the struct task_struct kptr which is actually stored in the map. */
> +	struct __tasks_kfunc_map_value {
> +		struct task_struct __kptr_ref * task;
> +	};
> +
> +	/* The map containing struct __tasks_kfunc_map_value entries. */
> +	struct hash_map {
> +		__uint(type, BPF_MAP_TYPE_HASH);
> +		__type(key, int);
> +		__type(value, struct __tasks_kfunc_map_value);
> +		__uint(max_entries, 1);
> +	} __tasks_kfunc_map SEC(".maps");
> +
> +	/* ... */
> +
> +	/**
> +	 * A simple example tracepoint program showing how a
> +	 * struct task_struct kptr that is stored in a map can
> +	 * be acquired using the bpf_task_kptr_get() kfunc.
> +	 */
> +	 SEC("tp_btf/task_newtask")
> +	 int BPF_PROG(task_kptr_get_example, struct task_struct *task, u64 clone_flags)
> +	 {
> +		struct task_struct *kptr;
> +		struct __tasks_kfunc_map_value *v;
> +		s32 pid;
> +		long status;
> +
> +		status = bpf_probe_read_kernel(&pid, sizeof(pid), &task->pid);

why use the slow bpf_probe_read_kernel() here?
I think the example should follow modern coding practices.
Just: pid = task->pid; instead ?

> +		if (status)
> +			return status;
> +
> +		/* Assume a task kptr was previously stored in the map. */
> +		v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> +		if (!v)
> +			return -ENOENT;
> +
> +		/* Acquire a reference to the task kptr that's already stored in the map. */
> +		kptr = bpf_task_kptr_get(&v->task);
> +		if (!kptr)
> +			/* If no task was present in the map, it's because
> +			 * we're racing with another CPU that removed it with
> +			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
> +			 * above, and our call to bpf_task_kptr_get().
> +			 * bpf_task_kptr_get() internally safely handles this
> +			 * race, and will return NULL if the task is no longer
> +			 * present in the map by the time we invoke the kfunc.
> +			 */
> +			return -EBUSY;
> +
> +		/* Free the reference we just took above. Note that the
> +		 * original struct task_struct kptr is still in the map.
> +		 * It will be freed either at a later time if another
> +		 * context deletes it from the map, or automatically by
> +		 * the BPF subsystem if it's still present when the map
> +		 * is destroyed.
> +		 */
> +		bpf_task_release(kptr);
> +
> +		return 0;
> +        }
> +
> +Finally, a BPF program can also look up a task from a pid. This can be useful
> +if the caller doesn't have a trusted pointer to a ``struct task_struct *``
> +object that it can acquire a reference on with bpf_task_acquire().
> +
> +.. kernel-doc:: kernel/bpf/helpers.c
> +   :identifiers: bpf_task_from_pid
> +
> +Here is an example of it being used:
> +
> +.. code-block:: c
> +
> +	SEC("tp_btf/task_newtask")
> +	int BPF_PROG(task_get_pid_example, struct task_struct *task, u64 clone_flags)
> +	{
> +		struct task_struct *lookup;
> +
> +		lookup = bpf_task_from_pid(task->pid);
> +		if (!lookup)
> +			/* A task should always be found, as %task is a tracepoint arg. */
> +			return -ENOENT;
> +
> +		if (lookup->pid != task->pid) {
> +			/* The pid of the lookup task should be the same as the input task. */

I suspect both "errors" are actually possible in practice,
since bpf_task_from_pid is using init_pid_ns.
But this taskd might be in different pid_ns. See task_active_pid_ns.
Probably worth mentioning this aspect of bpf_task_from_pid.

> +			bpf_task_release(lookup);
> +			return -EINVAL;
> +		}
> +
> +		/* bpf_task_from_pid() returns an acquired reference,
> +		 * so it must be dropped before returning from the
> +		 * tracepoint handler.
> +		 */
> +		bpf_task_release(lookup);
> +		return 0;
> +	}
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a5a511430f2a..004afbc14bbf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1868,10 +1868,10 @@ struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
>  }
>  
>  /**
> - * bpf_task_release - Release the reference acquired on a struct task_struct *.
> - * If this kfunc is invoked in an RCU read region, the task_struct is
> - * guaranteed to not be freed until the current grace period has ended, even if
> - * its refcount drops to 0.
> + * bpf_task_release - Release the reference acquired on a task.  If this kfunc
> + * is invoked in an RCU read region, the task_struct is guaranteed to not be
> + * freed until the current grace period has ended, even if its refcount drops
> + * to 0.
>   * @p: The task on which a reference is being released.
>   */
>  void bpf_task_release(struct task_struct *p)
> -- 
> 2.38.1
> 
