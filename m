Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AC609149
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 07:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJWF1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 01:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWF07 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 01:26:59 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42766EF2F
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 22:26:54 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h24so4057617qta.7
        for <bpf@vger.kernel.org>; Sat, 22 Oct 2022 22:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Alub9NkKoxCyj47ZN1OJZ8R95kZtxjbdWdaw/sbAvns=;
        b=je0xGe9zghu6XSw9j2M0tUiAcvZdhM2Uvc4C1MU/RtrjAPlmK+MODfucJFold3A0bf
         1c2vjL/5MKexoiaJTTYryl1PEU9i5rZXphTN/44Lj1pAqcLJuvpGgu3VmpLC5A1dpz8q
         bVBWL2Bs6chC2T8DW6TUYSwDPdiIZrHegr07hzXPG+f5DSZ+8Qk1FmFCOwMWcBefcxdq
         zjquBDMQuysNaGiLD5chX5SOZ0IGLhlfR54ZkVMoy6x6o0ggwPyCy7UetEA1JYhcFiwI
         ZhzXRgDCiFkUrZ7nMd3dfQYWXqoFacNtA7yAT1BLrJ75hLH60i/A/gCQmQ1R052yVvES
         UQ6Q==
X-Gm-Message-State: ACrzQf3+Wghh0+l4V5ezJ1Y0qhkc2ZLCjocibdtmPiuqS97vYQRdanmF
        453lKAjUUs2AwKg0PCQWudE=
X-Google-Smtp-Source: AMsMyM7yRDv/tkr40KcMs8iVYH6idB0wzz98znafEIke10KHXzMOg7VVXm8zKg6s8rbMakhOB5HWug==
X-Received: by 2002:ac8:7dd4:0:b0:39c:ed86:f4a5 with SMTP id c20-20020ac87dd4000000b0039ced86f4a5mr22637048qte.107.1666502813776;
        Sat, 22 Oct 2022 22:26:53 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::484b])
        by smtp.gmail.com with ESMTPSA id hf8-20020a05622a608800b0039cbbcc7da8sm10515138qtb.7.2022.10.22.22.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 22:26:53 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:26:57 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Message-ID: <Y1TQof8LPg1Btdbq@maniforge.dhcp.thefacebook.com>
References: <20221021234416.2328241-1-yhs@fb.com>
 <20221021234432.2330783-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021234432.2330783-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 04:44:32PM -0700, Yonghong Song wrote:
> Similar to sk/inode/task storage, implement similar cgroup local storage.
> 
> There already exists a local storage implementation for cgroup-attached
> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> bpf_get_local_storage(). But there are use cases such that non-cgroup
> attached bpf progs wants to access cgroup local storage data. For example,
> tc egress prog has access to sk and cgroup. It is possible to use
> sk local storage to emulate cgroup local storage by storing data in socket.
> But this is a waste as it could be lots of sockets belonging to a particular
> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
> But this will introduce additional overhead to manipulate the new map.
> A cgroup local storage, similar to existing sk/inode/task storage,
> should help for this use case.
> 
> The life-cycle of storage is managed with the life-cycle of the
> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> with a callback to the bpf_cgrp_storage_free when cgroup itself

Small nit: This isn't really done as a callback, it's just a normal
function call, right?

> is deleted.
> 
> The userspace map operations can be done by using a cgroup fd as a key
> passed to the lookup, update and delete operations.
> 
> Typically, the following code is used to get the current cgroup:
>     struct task_struct *task = bpf_get_current_task_btf();
>     ... task->cgroups->dfl_cgrp ...
> and in structure task_struct definition:
>     struct task_struct {
>         ....
>         struct css_set __rcu            *cgroups;
>         ....
>     }
> With sleepable program, accessing task->cgroups is not protected by rcu_read_lock.
> So the current implementation only supports non-sleepable program and supporting
> sleepable program will be the next step together with adding rcu_read_lock
> protection for rcu tagged structures.
> 
> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
> storage support, the new map name BPF_MAP_TYPE_CGRP_STORAGE is used
> for cgroup storage available to non-cgroup-attached bpf programs. The old
> cgroup storage supports bpf_get_local_storage() helper to get the cgroup data.
> The new cgroup storage helper bpf_cgrp_storage_get() can provide similar
> functionality. While old cgroup storage pre-allocates storage memory, the new
> mechanism can also pre-allocate with a user space bpf_map_update_elem() call
> to avoid potential run-time memory allocation failure.
> Therefore, the new cgroup storage can provide all functionality w.r.t.
> the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is alias to
> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage can
> be deprecated since the new one can provide the same functionality.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

[...]

> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> new file mode 100644
> index 000000000000..770c9c28215a
> --- /dev/null
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_local_storage.h>
> +#include <uapi/linux/btf.h>
> +#include <linux/btf_ids.h>
> +
> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
> +
> +static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
> +
> +static void bpf_cgrp_storage_lock(void)
> +{
> +	migrate_disable();
> +	this_cpu_inc(bpf_cgrp_storage_busy);
> +}
> +
> +static void bpf_cgrp_storage_unlock(void)
> +{
> +	this_cpu_dec(bpf_cgrp_storage_busy);
> +	migrate_enable();
> +}
> +
> +static bool bpf_cgrp_storage_trylock(void)
> +{
> +	migrate_disable();
> +	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
> +		this_cpu_dec(bpf_cgrp_storage_busy);
> +		migrate_enable();
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> +{
> +	struct cgroup *cg = owner;
> +
> +	return &cg->bpf_cgrp_storage;
> +}
> +
> +void bpf_cgrp_storage_free(struct cgroup *cgroup)

I was originally going to ask what you thought about also merging this
logic into bpf_local_storage.h, but I think it's fine to just land this
as is and refactor after.

I do think it would be a good cleanup to later refactor a lot of the
local storage logic to be callback based (assuming we're ok with an
extra indirect call), as much of what it's doing is almost the exact
same thing in a very slightly different way. For example,
bpf_pid_task_storage_lookup_elem() is looking up a pid by an fd,
acquiring a reference, and then returning the struct
bpf_local_storage_data * embedded in the task struct. If doing that in
general sounds like a reasonable idea, I can take care of it as
follow-on work after this lands.

> +{
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_elem *selem;
> +	bool free_cgroup_storage = false;
> +	struct hlist_node *n;
> +	unsigned long flags;
> +
> +	rcu_read_lock();
> +	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
> +	if (!local_storage) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/* Neither the bpf_prog nor the bpf_map's syscall
> +	 * could be modifying the local_storage->list now.
> +	 * Thus, no elem can be added to or deleted from the
> +	 * local_storage->list by the bpf_prog or by the bpf_map's syscall.
> +	 *
> +	 * It is racing with __bpf_local_storage_map_free() alone
> +	 * when unlinking elem from the local_storage->list and
> +	 * the map's bucket->list.
> +	 */
> +	bpf_cgrp_storage_lock();
> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> +		bpf_selem_unlink_map(selem);
> +		/* If local_storage list has only one element, the
> +		 * bpf_selem_unlink_storage_nolock() will return true.
> +		 * Otherwise, it will return false. The current loop iteration
> +		 * intends to remove all local storage. So the last iteration
> +		 * of the loop will set the free_cgroup_storage to true.
> +		 */
> +		free_cgroup_storage =
> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> +	}
> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +	bpf_cgrp_storage_unlock();
> +	rcu_read_unlock();
> +
> +	if (free_cgroup_storage)
> +		kfree_rcu(local_storage, rcu);
> +}
> +
> +static struct bpf_local_storage_data *
> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
> +{
> +	struct bpf_local_storage *cgroup_storage;
> +	struct bpf_local_storage_map *smap;
> +
> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
> +					       bpf_rcu_lock_held());
> +	if (!cgroup_storage)
> +		return NULL;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> +}
> +
> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct cgroup *cgroup;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	cgroup = cgroup_get_from_fd(fd);
> +	if (IS_ERR(cgroup))
> +		return ERR_CAST(cgroup);
> +
> +	bpf_cgrp_storage_lock();
> +	sdata = cgroup_storage_lookup(cgroup, map, true);
> +	bpf_cgrp_storage_unlock();
> +	cgroup_put(cgroup);
> +	return sdata ? sdata->data : NULL;

Do you think it's worth it to add a WARN_ON_ONCE(!rcu_read_lock_held());
somewhere in this function?

[...]

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 764bdd5fd8d1..7e80e15fae4e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
>  	struct cgroup_subsys *ss = css->ss;
>  	struct cgroup *cgrp = css->cgroup;
>  
> +#ifdef CONFIG_CGROUP_BPF

I think this should be #ifdef CONFIG_BPF_SYSCALL?

> +	bpf_cgrp_storage_free(cgrp);
> +#endif
> +

This looks pretty close to ready from my end, just a couple more
small questions / comments.

Thanks,
David
