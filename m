Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2C6083BD
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 05:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJVDCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 23:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVDCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 23:02:08 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8A24C950
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 20:02:03 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id l28so2820879qtv.4
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 20:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxExvUQjt+lDQ3TisvNOo5CZ4fpXklqpr40kUV4EEa4=;
        b=BeWURTDkaUoBSwM5RFAyD+oSmXkPS+3zJ5/elrCk2kcnKTf+TOvXO4Pp81J3oZRtbN
         mhwkDavqiMfPIRLDl3iLSIbGGYPv5aRaKWe7X3sPL6o3X2UZKe2Yhus7griBOg3CMj10
         EietVdKWS3PCtU8jI1eWxRZxRI0dS+U5lzecdLLJtkGwDkcgBn5Xo0TWtc9209yaKwB5
         SWu4UTLRyOJlviDJwORSeeUzdfCTqfPAKylxdMFxtMTR38ZH233HQGjA8q+vUq8lGIJr
         AX3VECcgXq4rxFOzmJnV33Tn3fEc19Lx9QqKNBnMVJfyddyAIUJnAZBWPHFUsSUnWBwo
         Rvdg==
X-Gm-Message-State: ACrzQf26lZCpunTUtLhPuIaqvGFDtGkITPpre15EQny/Vp6vfxHms8N3
        t0rN8Jz5LPLd1eaU7sBRc7E=
X-Google-Smtp-Source: AMsMyM5k6J0KqkFYjL9VbaxvvcotTVhEQdaGvPu8crsEoYZEK7KT6BUXn4RJSCIrYEVrWdXKc6KBFA==
X-Received: by 2002:ac8:5f10:0:b0:39d:290:3f6e with SMTP id x16-20020ac85f10000000b0039d02903f6emr13964763qta.108.1666407722187;
        Fri, 21 Oct 2022 20:02:02 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id gc12-20020a05622a59cc00b0039a3df76a26sm8963406qtb.18.2022.10.21.20.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 20:02:01 -0700 (PDT)
Date:   Fri, 21 Oct 2022 22:02:05 -0500
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
Message-ID: <Y1NdLah/c38isGT+@maniforge.dhcp.thefacebook.com>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
 <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
 <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
 <c815edb6-b008-07f4-2377-17b53ccdc289@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c815edb6-b008-07f4-2377-17b53ccdc289@meta.com>
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

On Fri, Oct 21, 2022 at 03:57:15PM -0700, Yonghong Song wrote:

[...]

> > > > > +	 * could be modifying the local_storage->list now.
> > > > > +	 * Thus, no elem can be added-to or deleted-from the
> > > > > +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> > > > > +	 *
> > > > > +	 * It is racing with bpf_local_storage_map_free() alone
> > > > > +	 * when unlinking elem from the local_storage->list and
> > > > > +	 * the map's bucket->list.
> > > > > +	 */
> > > > > +	bpf_cgrp_storage_lock();
> > > > > +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > > > +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > > > +		bpf_selem_unlink_map(selem);
> > > > > +		free_cgroup_storage =
> > > > > +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > > > 
> > > > This still requires a comment explaining why it's OK to overwrite
> > > > free_cgroup_storage with a previous value from calling
> > > > bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
> > > > a pretty weird programming pattern, and IMO doing this feels more
> > > > intentional and future-proof:
> > > > 
> > > > if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
> > > > 	free_cgroup_storage = true;
> > > 
> > > We have a comment a few lines below.
> > >    /* free_cgroup_storage should always be true as long as
> > >     * local_storage->list was non-empty.
> > >     */
> > >    if (free_cgroup_storage)
> > > 	kfree_rcu(local_storage, rcu);
> > 
> > IMO that comment doesn't provide much useful information -- it states an
> > assumption, but doesn't give a reason for it.
> > 
> > > I will add more explanation in the above code like
> > > 
> > > 	bpf_selem_unlink_map(selem);
> > > 	/* If local_storage list only have one element, the
> > > 	 * bpf_selem_unlink_storage_nolock() will return true.
> > > 	 * Otherwise, it will return false. The current loop iteration
> > > 	 * intends to remove all local storage. So the last iteration
> > > 	 * of the loop will set the free_cgroup_storage to true.
> > > 	 */
> > > 	free_cgroup_storage =
> > > 		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > 
> > Thanks, this is the type of comment I was looking for.
> > 
> > Also, I realize this was copy-pasted from a number of other possible
> > locations in the codebase which are doing the same thing, but I still
> > think this pattern is an odd and brittle way to do this. We're relying
> > on an abstracted implementation detail of
> > bpf_selem_unlink_storage_nolock() for correctness, which IMO is a signal
> > that bpf_selem_unlink_storage_nolock() should probably be the one
> > invoking kfree_rcu() on behalf of callers in the first place.  It looks
> > like all of the callers end up calling kfree_rcu() on the struct
> > bpf_local_storage * if bpf_selem_unlink_storage_nolock() returns true,
> > so can we just move the responsibility of freeing the local storage
> > object down into bpf_selem_unlink_storage_nolock() where it's unlinked?
> 
> We probably cannot do this. bpf_selem_unlink_storage_nolock()
> is inside the rcu_read_lock() region. We do kfree_rcu() outside
> the rcu_read_lock() region.

kfree_rcu() is non-blocking and is safe to invoke from within an RCU
read region. If you invoke it within an RCU read region, the object will
not be kfree'd until (at least) you exit the current read region, so I
believe that the net effect here should be the same whether it's done in
bpf_selem_unlink_storage_nolock(), or in the caller after the RCU read
region is exited.

> > IMO this can be done in a separate patch set, if we decide it's worth
> > doing at all.
> > 
> > > > 
> > > > > +	}
> > > > > +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > > +	bpf_cgrp_storage_unlock();
> > > > > +	rcu_read_unlock();
> > > > > +
> > > > > +	/* free_cgroup_storage should always be true as long as
> > > > > +	 * local_storage->list was non-empty.
> > > > > +	 */
> > > > > +	if (free_cgroup_storage)
> > > > > +		kfree_rcu(local_storage, rcu);
> > > > > +}
> > > > > +
> > > > > +static struct bpf_local_storage_data *
> > > > > +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
> > > > > +{
> > > > > +	struct bpf_local_storage *cgroup_storage;
> > > > > +	struct bpf_local_storage_map *smap;
> > > > > +
> > > > > +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
> > > > > +					       bpf_rcu_lock_held());
> > > > > +	if (!cgroup_storage)
> > > > > +		return NULL;
> > > > > +
> > > > > +	smap = (struct bpf_local_storage_map *)map;
> > > > > +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> > > > > +}
> > > > > +
> > > > > +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
> > > > > +{
> > > > > +	struct bpf_local_storage_data *sdata;
> > > > > +	struct cgroup *cgroup;
> > > > > +	int fd;
> > > > > +
> > > > > +	fd = *(int *)key;
> > > > > +	cgroup = cgroup_get_from_fd(fd);
> > > > > +	if (IS_ERR(cgroup))
> > > > > +		return ERR_CAST(cgroup);
> > > > > +
> > > > > +	bpf_cgrp_storage_lock();
> > > > > +	sdata = cgroup_storage_lookup(cgroup, map, true);
> > > > > +	bpf_cgrp_storage_unlock();
> > > > > +	cgroup_put(cgroup);
> > > > > +	return sdata ? sdata->data : NULL;
> > > > > +}
> > > > 
> > > > Stanislav pointed out in the v1 revision that there's a lot of very
> > > > similar logic in task storage, and I think you'd mentioned that you were
> > > > going to think about generalizing some of that. Have you had a chance to
> > > > consider?
> > > 
> > > It is hard to have a common function for
> > > lookup_elem/update_elem/delete_elem(). They are quite different as each
> > > heavily involves
> > > task/cgroup-specific functions.
> > 
> > Yes agreed, each implementation is acquiring their own references, and
> > finding the backing element in whatever way it was implemented, etc.
> > 
> > > but map_alloc and map_free could have common helpers.
> > 
> > Agreed, and many of the static functions that are invoked on those paths
> > such as bpf_cgrp_storage_free(), bpf_cgrp_storage_lock(), etc possibly
> > as well. In general this feels like something we could pretty easily
> > simplify using something like a structure with callbacks to implement
> > the pieces of logic that are specific to each local storage type, such
> > as getting the struct bpf_local_storage __rcu
> > * pointer from some context (e.g.  cgroup_storage_ptr()). It doesn't
> > necessarily need to block this change, but IMO we should clean this up
> > soon because a lot of this is nearly a 100% copy-paste of other local
> > storage implementations.
> 
> Further refactoring is possible. Martin is working to simplify the
> locking mechanism. We can wait for that done before doing refactoring.

Sounds great, thanks!

- David
