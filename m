Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A6E607F58
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 21:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJUT50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJUT5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 15:57:25 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BFB29CB85
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:57:21 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id hh9so2332288qtb.13
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 12:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtzzI8rnFavIqszM0QAldCjh1ANkwfRiM3IzcBeISQw=;
        b=mRV8RJ+AsuwLDhSkSlgHJDl/T8AQBhZxAJGsMuoGXjSRTT1n67qiuIQu599W0a8zlL
         FwQgakxFsy0Sv7YplgNMQgGdhIMSYdPAgiaQsH052NbT6Dck9mkm60/lL/KMJrnBPeN7
         P3UtFvaimEifAtP6HEyUJtAhcwLLSSKpwVsixOwuDkfpa+ku8gZVjLznnukPOZj4VIit
         k2BhjSuljYu3nuuZRdkT3xHSZ9Jt376sHZ+joWAphsDx8fBhVqFS3ea/34hdF9h8iJn7
         zSn+GQ0YXaE7W03OPgudj/7J7qUzsbEwJaedpO/9APJZlauKwxGaF15OB48GVS4qSt9E
         3UmA==
X-Gm-Message-State: ACrzQf370uiNqzKr/oKevJWkNV/+S2M6S/gpgKcsy4WOdRnikscl9ODR
        6hcLvi+n2RFx8OJDnoWGwo7uuvssmrNBGA==
X-Google-Smtp-Source: AMsMyM7JmU8s130/q8UPTgX3TZ4aGPncVP3SURYCFkiPK0CqcM0+vOc3isizcMIvJ0tqAswdtskpYQ==
X-Received: by 2002:a05:622a:1316:b0:39c:e8e6:7038 with SMTP id v22-20020a05622a131600b0039ce8e67038mr18119605qtk.262.1666382239607;
        Fri, 21 Oct 2022 12:57:19 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ced5d3f921sm10453756qkp.52.2022.10.21.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:57:18 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:57:21 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Message-ID: <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
 <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
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

On Fri, Oct 21, 2022 at 10:33:41AM -0700, Yonghong Song wrote:

[...]

> > >   /* Note that tracing related programs such as
> > > @@ -5435,6 +5443,42 @@ union bpf_attr {
> > >    *		**-E2BIG** if user-space has tried to publish a sample which is
> > >    *		larger than the size of the ring buffer, or which cannot fit
> > >    *		within a struct bpf_dynptr.
> > > + *
> > > + * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
> > > + *	Description
> > > + *		Get a bpf_local_storage from the *cgroup*.
> > > + *
> > > + *		Logically, it could be thought of as getting the value from
> > > + *		a *map* with *cgroup* as the **key**.  From this
> > > + *		perspective,  the usage is not much different from
> > > + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
> > > + *		helper enforces the key must be a cgroup struct and the map must also
> > > + *		be a **BPF_MAP_TYPE_CGRP_STORAGE**.
> > > + *
> > > + *		Underneath, the value is stored locally at *cgroup* instead of
> > > + *		the *map*.  The *map* is used as the bpf-local-storage
> > > + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
> > > + *		searched against all bpf_local_storage residing at *cgroup*.
> > 
> > IMO this paragraph is a bit hard to parse. Please correct me if I'm
> > wrong, but I think what it's trying to convey is that when an instance
> > of cgroup bpf-local-storage is accessed by a program in e.g.
> > bpf_cgrp_storage_get(), all of the cgroup bpf_local_storage entries are
> > iterated over in the struct cgroup object until this program's local
> > storage instance is found. Is that right? If so, perhaps something like
> > this would be more clear:
> 
> yes. your above interpretation is correct.
> 
> > 
> > In reality, the local-storage value is embedded directly inside of the
> > *cgroup* object itself, rather than being located in the
> > **BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
> > queried for some *map* on a *cgroup* object, the kernel will perform an
> > O(n) iteration over all of the live local-storage values for that
> > *cgroup* object until the local-storage value for the *map* is found.
> 
> Sounds okay. I can change the explanation like the above.

Thanks!

> > > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > > index 341c94f208f4..3a12e6b400a2 100644
> > > --- a/kernel/bpf/Makefile
> > > +++ b/kernel/bpf/Makefile
> > > @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
> > >   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
> > >   endif
> > >   ifeq ($(CONFIG_CGROUPS),y)
> > 
> > I assume that you double checked that it's valid to compile the helper
> > with CONFIG_CGROUPS && !CONFIG_CGROUP_BPF, but I must admit that even if
> > that's the case, I'm not following why we would want the map to be
> > compiled with a different kconfig option than the helper that provides
> > access to it. If theres's a precedent for doing this then I suppose it's
> > fine, but it does seem wrong and/or at least wasteful to compile these
> > helpers in if CONFIG_CGROUPS is defined but CONFIG_CGROUP_BPF is not.
> 
> The following is my understanding.
> CONFIG_CGROUP_BPF guards kernel/bpf/cgroup.c which contains implementation
> mostly for cgroup-attached program types, helpers, etc.

Then why are we using it to guard
BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)?

> A lot of other cgroup-related implementation like cgroup_iter, some
> cgroup related helper (not related to cgroup-attached program types), etc.
> are guarded with CONFIG_CGROUPS and CONFIG_BPF_SYSCALL.
> 
> Note that it is totally possible CONFIG_CGROUP_BPF is 'n' while
> CONFIG_CGROUPS and CONFIG_BPF_SYSCALL are 'y'.
> 
> So for cgroup local storage implemented in this patch set,
> using CONFIG_CGROUPS and CONFIG_BPF_SYSCALL seems okay.

I agree that it's fine to use CONFIG_CGROUPS here. What I'm not
understanding is why we're using CONFIG_CGROUP_BPF to guard defining
BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops), and then
in the Makefile we're using CONFIG_CGROUPS to add bpf_cgrp_storage.o.

In other words, I think there's a mismatch between:

--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #ifdef CONFIG_CGROUP_BPF

^^ why this instead of CONFIG_CGROUPS for BPF_MAP_TYPE_CGRP_STORAGE?

 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)

and

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 341c94f208f4..3a12e6b400a2 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
 obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
 endif
 ifeq ($(CONFIG_CGROUPS),y)
-obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
 endif
 obj-$(CONFIG_CGROUP_BPF) += cgroup.o
 ifeq ($(CONFIG_INET),y)

> > > -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
> > > +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
> > >   endif
> > >   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
> > >   ifeq ($(CONFIG_INET),y)

[...]

> > > +	 * could be modifying the local_storage->list now.
> > > +	 * Thus, no elem can be added-to or deleted-from the
> > > +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> > > +	 *
> > > +	 * It is racing with bpf_local_storage_map_free() alone
> > > +	 * when unlinking elem from the local_storage->list and
> > > +	 * the map's bucket->list.
> > > +	 */
> > > +	bpf_cgrp_storage_lock();
> > > +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > +		bpf_selem_unlink_map(selem);
> > > +		free_cgroup_storage =
> > > +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > 
> > This still requires a comment explaining why it's OK to overwrite
> > free_cgroup_storage with a previous value from calling
> > bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
> > a pretty weird programming pattern, and IMO doing this feels more
> > intentional and future-proof:
> > 
> > if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
> > 	free_cgroup_storage = true;
> 
> We have a comment a few lines below.
>   /* free_cgroup_storage should always be true as long as
>    * local_storage->list was non-empty.
>    */
>   if (free_cgroup_storage)
> 	kfree_rcu(local_storage, rcu);

IMO that comment doesn't provide much useful information -- it states an
assumption, but doesn't give a reason for it.

> I will add more explanation in the above code like
> 
> 	bpf_selem_unlink_map(selem);
> 	/* If local_storage list only have one element, the
> 	 * bpf_selem_unlink_storage_nolock() will return true.
> 	 * Otherwise, it will return false. The current loop iteration
> 	 * intends to remove all local storage. So the last iteration
> 	 * of the loop will set the free_cgroup_storage to true.
> 	 */
> 	free_cgroup_storage =
> 		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);

Thanks, this is the type of comment I was looking for.

Also, I realize this was copy-pasted from a number of other possible
locations in the codebase which are doing the same thing, but I still
think this pattern is an odd and brittle way to do this. We're relying
on an abstracted implementation detail of
bpf_selem_unlink_storage_nolock() for correctness, which IMO is a signal
that bpf_selem_unlink_storage_nolock() should probably be the one
invoking kfree_rcu() on behalf of callers in the first place.  It looks
like all of the callers end up calling kfree_rcu() on the struct
bpf_local_storage * if bpf_selem_unlink_storage_nolock() returns true,
so can we just move the responsibility of freeing the local storage
object down into bpf_selem_unlink_storage_nolock() where it's unlinked?

IMO this can be done in a separate patch set, if we decide it's worth
doing at all.

> > 
> > > +	}
> > > +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > +	bpf_cgrp_storage_unlock();
> > > +	rcu_read_unlock();
> > > +
> > > +	/* free_cgroup_storage should always be true as long as
> > > +	 * local_storage->list was non-empty.
> > > +	 */
> > > +	if (free_cgroup_storage)
> > > +		kfree_rcu(local_storage, rcu);
> > > +}
> > > +
> > > +static struct bpf_local_storage_data *
> > > +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
> > > +{
> > > +	struct bpf_local_storage *cgroup_storage;
> > > +	struct bpf_local_storage_map *smap;
> > > +
> > > +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
> > > +					       bpf_rcu_lock_held());
> > > +	if (!cgroup_storage)
> > > +		return NULL;
> > > +
> > > +	smap = (struct bpf_local_storage_map *)map;
> > > +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> > > +}
> > > +
> > > +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
> > > +{
> > > +	struct bpf_local_storage_data *sdata;
> > > +	struct cgroup *cgroup;
> > > +	int fd;
> > > +
> > > +	fd = *(int *)key;
> > > +	cgroup = cgroup_get_from_fd(fd);
> > > +	if (IS_ERR(cgroup))
> > > +		return ERR_CAST(cgroup);
> > > +
> > > +	bpf_cgrp_storage_lock();
> > > +	sdata = cgroup_storage_lookup(cgroup, map, true);
> > > +	bpf_cgrp_storage_unlock();
> > > +	cgroup_put(cgroup);
> > > +	return sdata ? sdata->data : NULL;
> > > +}
> > 
> > Stanislav pointed out in the v1 revision that there's a lot of very
> > similar logic in task storage, and I think you'd mentioned that you were
> > going to think about generalizing some of that. Have you had a chance to
> > consider?
> 
> It is hard to have a common function for
> lookup_elem/update_elem/delete_elem(). They are quite different as each
> heavily involves
> task/cgroup-specific functions.

Yes agreed, each implementation is acquiring their own references, and
finding the backing element in whatever way it was implemented, etc.

> but map_alloc and map_free could have common helpers.

Agreed, and many of the static functions that are invoked on those paths
such as bpf_cgrp_storage_free(), bpf_cgrp_storage_lock(), etc possibly
as well. In general this feels like something we could pretty easily
simplify using something like a structure with callbacks to implement
the pieces of logic that are specific to each local storage type, such
as getting the struct bpf_local_storage __rcu
* pointer from some context (e.g.  cgroup_storage_ptr()). It doesn't
necessarily need to block this change, but IMO we should clean this up
soon because a lot of this is nearly a 100% copy-paste of other local
storage implementations.

Thanks,
David
