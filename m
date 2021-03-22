Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5AB345114
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhCVUrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 16:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231814AbhCVUrK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 16:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616446029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+oi3NGy0fqdvWX20KfojqhY9a2m8Ras3T9GfNG8vNw=;
        b=O37HT20xbzNzqjLcQrAXbvkTXiziOa085uAofIAeULxsZ/vBEZYTNkMpH/SbaQfeHhMbyf
        i7SVZtjKBrDHRc2iZ+YzzfCt3Ek5ajk/IRpVieCU4sjLZnywRLXri651zhrNEqb5JogymP
        DJrcOJVpDbanhPz17C9lLSKTTxdneV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-HO-H4MerMk-z7hSX-cefBA-1; Mon, 22 Mar 2021 16:47:07 -0400
X-MC-Unique: HO-H4MerMk-z7hSX-cefBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8956101371F;
        Mon, 22 Mar 2021 20:47:03 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B6695B6AD;
        Mon, 22 Mar 2021 20:47:01 +0000 (UTC)
Date:   Mon, 22 Mar 2021 21:47:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH bpf-next v3] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
Message-ID: <YFkCRY+HBvOYj1Y0@krava>
References: <20210320170201.698472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320170201.698472-1-yhs@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 10:02:01AM -0700, Yonghong Song wrote:
> Jiri Olsa reported a bug ([1]) in kernel where cgroup local
> storage pointer may be NULL in bpf_get_local_storage() helper.
> There are two issues uncovered by this bug:
>   (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
>        before prog run,
>   (2). due to change from preempt_disable to migrate_disable,
>        preemption is possible and percpu storage might be overwritten
>        by other tasks.
> 
> This issue (1) is fixed in [2]. This patch tried to address issue (2).
> The following shows how things can go wrong:
>   task 1:   bpf_cgroup_storage_set() for percpu local storage
>          preemption happens
>   task 2:   bpf_cgroup_storage_set() for percpu local storage
>          preemption happens
>   task 1:   run bpf program
> 
> task 1 will effectively use the percpu local storage setting by task 2
> which will be either NULL or incorrect ones.
> 
> Instead of just one common local storage per cpu, this patch fixed
> the issue by permitting 8 local storages per cpu and each local
> storage is identified by a task_struct pointer. This way, we
> allow at most 8 nested preemption between bpf_cgroup_storage_set()
> and bpf_cgroup_storage_unset(). The percpu local storage slot
> is released (calling bpf_cgroup_storage_unset()) by the same task
> after bpf program finished running.
> bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
> interface.
> 
> The patch is tested on top of [2] with reproducer in [1].
> Without this patch, kernel will emit error in 2-3 minutes.
> With this patch, after one hour, still no error.
> 
>  [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>  [2] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T

[1] and [2] are same link, you mean this one, right?
   05a68ce5fa51 bpf: Don't do bpf_cgroup_storage_set() for kuprobe/tp programs

I have troubles to apply this on bpf-next probably because
of dependencies, I'll wait for bpf-next is in sync with bpf
fixes.. or would you have a branch pushed out with this?

thanks for the fix,
jirka

> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf-cgroup.h | 57 ++++++++++++++++++++++++++++++++------
>  include/linux/bpf.h        | 22 ++++++++++++---
>  kernel/bpf/helpers.c       | 15 +++++++---
>  kernel/bpf/local_storage.c |  5 ++--
>  net/bpf/test_run.c         |  6 +++-
>  5 files changed, 86 insertions(+), 19 deletions(-)
> 
> Changelogs:
>   v2 -> v3:
>     . merge two patches as bpf_test_run() will have compilation error
>       and may fail with other changes.
>     . rewrite bpf_cgroup_storage_set() to be more inline with kernel
>       coding style.
>   v1 -> v2:
>     . fix compilation issues when CONFIG_CGROUPS is off or
>       CONFIG_CGROUP_BPF is off.
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index c42e02b4d84b..6a29fe11485d 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -20,14 +20,25 @@ struct bpf_sock_ops_kern;
>  struct bpf_cgroup_storage;
>  struct ctl_table;
>  struct ctl_table_header;
> +struct task_struct;
>  
>  #ifdef CONFIG_CGROUP_BPF
>  
>  extern struct static_key_false cgroup_bpf_enabled_key[MAX_BPF_ATTACH_TYPE];
>  #define cgroup_bpf_enabled(type) static_branch_unlikely(&cgroup_bpf_enabled_key[type])
>  
> -DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> -		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +#define BPF_CGROUP_STORAGE_NEST_MAX	8
> +
> +struct bpf_cgroup_storage_info {
> +	struct task_struct *task;
> +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> +};
> +
> +/* For each cpu, permit maximum BPF_CGROUP_STORAGE_NEST_MAX number of tasks
> + * to use bpf cgroup storage simultaneously.
> + */
> +DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
> +		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
>  
>  #define for_each_cgroup_storage_type(stype) \
>  	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
> @@ -161,13 +172,42 @@ static inline enum bpf_cgroup_storage_type cgroup_storage_type(
>  	return BPF_CGROUP_STORAGE_SHARED;
>  }
>  
> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
> -					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
> +static inline int bpf_cgroup_storage_set(struct bpf_cgroup_storage
> +					 *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>  {
>  	enum bpf_cgroup_storage_type stype;
> +	int i, err = 0;
> +
> +	preempt_disable();
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != NULL))
> +			continue;
> +
> +		this_cpu_write(bpf_cgroup_storage_info[i].task, current);
> +		for_each_cgroup_storage_type(stype)
> +			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
> +				       storage[stype]);
> +		goto out;
> +	}
> +	err = -EBUSY;
> +	WARN_ON_ONCE(1);
> +
> +out:
> +	preempt_enable();
> +	return err;
> +}
> +
> +static inline void bpf_cgroup_storage_unset(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +			continue;
>  
> -	for_each_cgroup_storage_type(stype)
> -		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
> +		this_cpu_write(bpf_cgroup_storage_info[i].task, NULL);
> +		return;
> +	}
>  }
>  
>  struct bpf_cgroup_storage *
> @@ -448,8 +488,9 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
>  	return -EINVAL;
>  }
>  
> -static inline void bpf_cgroup_storage_set(
> -	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
> +static inline int bpf_cgroup_storage_set(
> +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) { return 0; }
> +static inline void bpf_cgroup_storage_unset(void) {}
>  static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
>  					    struct bpf_map *map) { return 0; }
>  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a47285cd39c2..3a6ae69743ff 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1090,6 +1090,13 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  /* BPF program asks to set CN on the packet. */
>  #define BPF_RET_SET_CN						(1 << 0)
>  
> +/* For BPF_PROG_RUN_ARRAY_FLAGS and __BPF_PROG_RUN_ARRAY,
> + * if bpf_cgroup_storage_set() failed, the rest of programs
> + * will not execute. This should be a really rare scenario
> + * as it requires BPF_CGROUP_STORAGE_NEST_MAX number of
> + * preemptions all between bpf_cgroup_storage_set() and
> + * bpf_cgroup_storage_unset() on the same cpu.
> + */
>  #define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)		\
>  	({								\
>  		struct bpf_prog_array_item *_item;			\
> @@ -1102,10 +1109,12 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  		_array = rcu_dereference(array);			\
>  		_item = &_array->items[0];				\
>  		while ((_prog = READ_ONCE(_item->prog))) {		\
> -			bpf_cgroup_storage_set(_item->cgroup_storage);	\
> +			if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
> +				break;					\
>  			func_ret = func(_prog, ctx);			\
>  			_ret &= (func_ret & 1);				\
>  			*(ret_flags) |= (func_ret >> 1);			\
> +			bpf_cgroup_storage_unset();			\
>  			_item++;					\
>  		}							\
>  		rcu_read_unlock();					\
> @@ -1126,9 +1135,14 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  			goto _out;			\
>  		_item = &_array->items[0];		\
>  		while ((_prog = READ_ONCE(_item->prog))) {		\
> -			if (set_cg_storage)		\
> -				bpf_cgroup_storage_set(_item->cgroup_storage);	\
> -			_ret &= func(_prog, ctx);	\
> +			if (!set_cg_storage) {			\
> +				_ret &= func(_prog, ctx);	\
> +			} else {				\
> +				if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
> +					break;			\
> +				_ret &= func(_prog, ctx);	\
> +				bpf_cgroup_storage_unset();	\
> +			}				\
>  			_item++;			\
>  		}					\
>  _out:							\
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 074800226327..f306611c4ddf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -382,8 +382,8 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
>  };
>  
>  #ifdef CONFIG_CGROUP_BPF
> -DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> -		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
> +		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
>  
>  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  {
> @@ -392,10 +392,17 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  	 * verifier checks that its value is correct.
>  	 */
>  	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> -	struct bpf_cgroup_storage *storage;
> +	struct bpf_cgroup_storage *storage = NULL;
>  	void *ptr;
> +	int i;
>  
> -	storage = this_cpu_read(bpf_cgroup_storage[stype]);
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +			continue;
> +
> +		storage = this_cpu_read(bpf_cgroup_storage_info[i].storage[stype]);
> +		break;
> +	}
>  
>  	if (stype == BPF_CGROUP_STORAGE_SHARED)
>  		ptr = &READ_ONCE(storage->buf)->data[0];
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 2d4f9ac12377..bd11db9774c3 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -9,10 +9,11 @@
>  #include <linux/slab.h>
>  #include <uapi/linux/btf.h>
>  
> -DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> -
>  #ifdef CONFIG_CGROUP_BPF
>  
> +DEFINE_PER_CPU(struct bpf_cgroup_storage_info,
> +	       bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
> +
>  #include "../cgroup/cgroup-internal.h"
>  
>  #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 0abdd67f44b1..4aabf71cd95d 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -106,12 +106,16 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
>  
>  	bpf_test_timer_enter(&t);
>  	do {
> -		bpf_cgroup_storage_set(storage);
> +		ret = bpf_cgroup_storage_set(storage);
> +		if (ret)
> +			break;
>  
>  		if (xdp)
>  			*retval = bpf_prog_run_xdp(prog, ctx);
>  		else
>  			*retval = BPF_PROG_RUN(prog, ctx);
> +
> +		bpf_cgroup_storage_unset();
>  	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
>  	bpf_test_timer_leave(&t);
>  
> -- 
> 2.30.2
> 

