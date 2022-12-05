Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D910642C8D
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLEQKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 11:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLEQKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 11:10:18 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A11D0C6;
        Mon,  5 Dec 2022 08:10:16 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id i12so8507608qvs.2;
        Mon, 05 Dec 2022 08:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAHDMv10mwaXywsSbTClOPAW5tc+W/UH4dCDoxz59Vs=;
        b=oCBdhVcTfx7X3XxhLclvvQXBlqiWY3rrcFvvvqdpI5px7qm3NcbNE/+SN9+XIg/uSs
         NQe06cW/vYjBG5xkE+rWSmOnUk0bjamsBnvmZ5vDbZN5/Cr51YIEN9ZnCftmm2xME7cb
         9L+EJbCYtsPSlTyV8KIlo5jDSa6kqh6V4glC1gIt10BmS+rdkNjihut+qTMN2EXLKrmF
         nffQqAJ7v7g2VrNQhZ0lEtZCki0Wj+rm0RRyd3+5sefTEH0lkbvK8wdg9Tt6GPgH5Z1S
         z45LJpr7WRMBooRDAq1f7EAcU+xyjLtKo00Yb1U0dQkcGn3O3EcwX754KkTVxqnGPv5y
         iLsA==
X-Gm-Message-State: ANoB5pnd3TLVNUr24lgiqfuOHZbMUWxwOXmSyCuk2tH7c1g2b9WFrZnK
        5+C4/2B1tOJfx/cqF9jr7xAttD84VH2ISiz5
X-Google-Smtp-Source: AA0mqf7wXslcZUOiK+xbKXG5qb9s4ioNMJalcASEf1F78mzZeUdDcM+PdHW4tsX/7jOiuNCMq5y1Iw==
X-Received: by 2002:a05:6214:c6d:b0:4c7:557c:35de with SMTP id t13-20020a0562140c6d00b004c7557c35demr9007338qvj.120.1670256615854;
        Mon, 05 Dec 2022 08:10:15 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:b2ee])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a0c4f00b006bb2cd2f6d1sm12682052qki.127.2022.12.05.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:10:15 -0800 (PST)
Date:   Mon, 5 Dec 2022 10:10:14 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, F@maniforge.lan
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] bpf/docs: Document struct task_struct *
 kfuncs
Message-ID: <Y44X5uQ0tJoCvQ96@maniforge.lan>
References: <20221202220736.521227-1-void@manifault.com>
 <20221202220736.521227-2-void@manifault.com>
 <20221203021500.okerdcfwhgykrxxg@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203021500.okerdcfwhgykrxxg@macbook-pro-6.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 02, 2022 at 06:15:00PM -0800, Alexei Starovoitov wrote:

[...]

> > +.. code-block:: c
> > +
> > +	/**
> > +	 * A trivial example tracepoint program that shows how to
> > +	 * acquire and release a struct task_struct * pointer.
> > +	 */
> > +	SEC("tp_btf/task_newtask")
> > +	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
> > +	{
> > +		struct task_struct *acquired;
> > +
> > +		acquired = bpf_task_acquire(task);
> > +
> > +		/*
> > +		 * In a typical program you'd do something like store
> > +		 * the task in a map. Here, we just release it.
> 
> There is a sentence later in this patch about what happens with the pointer
> that was stored in a map, but I would add some part of it here as well. Like:
> 
>  * In a typical program you'd do something like store
>  * the task in a map and the map will automatically release it later.
>  * Here, we release it manually.

Will do

> > +		 */
> > +		bpf_task_release(acquired);
> > +		return 0;
> > +	}
> > +
> > +If you want to acquire a reference to a ``struct task_struct`` kptr that's
> > +already stored in a map, you can use bpf_task_kptr_get():
> > +
> > +.. kernel-doc:: kernel/bpf/helpers.c
> > +   :identifiers: bpf_task_kptr_get
> > +
> > +Here's an example of how it can be used:
> > +
> > +.. code-block:: c
> > +
> > +	/* struct containing the struct task_struct kptr which is actually stored in the map. */
> > +	struct __tasks_kfunc_map_value {
> > +		struct task_struct __kptr_ref * task;
> > +	};
> > +
> > +	/* The map containing struct __tasks_kfunc_map_value entries. */
> > +	struct hash_map {
> > +		__uint(type, BPF_MAP_TYPE_HASH);
> > +		__type(key, int);
> > +		__type(value, struct __tasks_kfunc_map_value);
> > +		__uint(max_entries, 1);
> > +	} __tasks_kfunc_map SEC(".maps");
> > +
> > +	/* ... */
> > +
> > +	/**
> > +	 * A simple example tracepoint program showing how a
> > +	 * struct task_struct kptr that is stored in a map can
> > +	 * be acquired using the bpf_task_kptr_get() kfunc.
> > +	 */
> > +	 SEC("tp_btf/task_newtask")
> > +	 int BPF_PROG(task_kptr_get_example, struct task_struct *task, u64 clone_flags)
> > +	 {
> > +		struct task_struct *kptr;
> > +		struct __tasks_kfunc_map_value *v;
> > +		s32 pid;
> > +		long status;
> > +
> > +		status = bpf_probe_read_kernel(&pid, sizeof(pid), &task->pid);
> 
> why use the slow bpf_probe_read_kernel() here?
> I think the example should follow modern coding practices.
> Just: pid = task->pid; instead ?

Yeah, I'll fix this.

[...]

> > +		if (status)
> > +			return status;
> > +
> > +		/* Assume a task kptr was previously stored in the map. */
> > +		v = bpf_map_lookup_elem(&__tasks_kfunc_map, &pid);
> > +		if (!v)
> > +			return -ENOENT;
> > +
> > +		/* Acquire a reference to the task kptr that's already stored in the map. */
> > +		kptr = bpf_task_kptr_get(&v->task);
> > +		if (!kptr)
> > +			/* If no task was present in the map, it's because
> > +			 * we're racing with another CPU that removed it with
> > +			 * bpf_kptr_xchg() between the bpf_map_lookup_elem()
> > +			 * above, and our call to bpf_task_kptr_get().
> > +			 * bpf_task_kptr_get() internally safely handles this
> > +			 * race, and will return NULL if the task is no longer
> > +			 * present in the map by the time we invoke the kfunc.
> > +			 */
> > +			return -EBUSY;
> > +
> > +		/* Free the reference we just took above. Note that the
> > +		 * original struct task_struct kptr is still in the map.
> > +		 * It will be freed either at a later time if another
> > +		 * context deletes it from the map, or automatically by
> > +		 * the BPF subsystem if it's still present when the map
> > +		 * is destroyed.
> > +		 */
> > +		bpf_task_release(kptr);
> > +
> > +		return 0;
> > +        }
> > +
> > +Finally, a BPF program can also look up a task from a pid. This can be useful
> > +if the caller doesn't have a trusted pointer to a ``struct task_struct *``
> > +object that it can acquire a reference on with bpf_task_acquire().
> > +
> > +.. kernel-doc:: kernel/bpf/helpers.c
> > +   :identifiers: bpf_task_from_pid
> > +
> > +Here is an example of it being used:
> > +
> > +.. code-block:: c
> > +
> > +	SEC("tp_btf/task_newtask")
> > +	int BPF_PROG(task_get_pid_example, struct task_struct *task, u64 clone_flags)
> > +	{
> > +		struct task_struct *lookup;
> > +
> > +		lookup = bpf_task_from_pid(task->pid);
> > +		if (!lookup)
> > +			/* A task should always be found, as %task is a tracepoint arg. */
> > +			return -ENOENT;
> > +
> > +		if (lookup->pid != task->pid) {
> > +			/* The pid of the lookup task should be the same as the input task. */
> 
> I suspect both "errors" are actually possible in practice,
> since bpf_task_from_pid is using init_pid_ns.
> But this taskd might be in different pid_ns. See task_active_pid_ns.
> Probably worth mentioning this aspect of bpf_task_from_pid.

Yep, agreed. Will add

[...]

Thanks,
David
