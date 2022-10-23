Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9760966F
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJWVPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJWVPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 17:15:04 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489182D749
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 14:15:01 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id z30so5126673qkz.13
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 14:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtCyNe5+veWJWOQdiEqGla+wTM8Rc0m2Kv1/n778etM=;
        b=LagJvmX0ot46lfyHbDQLNciAOKxv3R1AN+7D8jS7FoFYGNbpo2/LGjUlGN0gJMhmM/
         ljevSYQ3IuuqS6B3EkptgKGucti/Spl6qPP42TDxviF3KOERIZM86wRk8vZCG+VlL77w
         6q9zLpWUDLADF5a0vuy2YakOcuzSt/ZPj+EbbqB6gb8uq5WbyMZFTRnCHYSsWa7iKCGT
         HGe/30ILTuNbv6Z+jzoaECSNUbv31mb/Dqp0SJPpKh1IHTEeJ8WegF+tvHyRh2t0h65U
         eeHm0uGIB1ZfIkGSkvTSvpfRMDFeoWnrduitQ6fkH4kJ3RYpPhlpfN+1lwEDOMKEngLQ
         ZTxA==
X-Gm-Message-State: ACrzQf3sDlRenEgJU12JXiRcPThh9WTIxwuPJSvjdv7k+7+C2oUQ2trc
        YUSQUTLMH1WYPdCtFZdlavo=
X-Google-Smtp-Source: AMsMyM6VwdLn3RrrThPeYZ3kWs4hLa8/Jw2q87R5+vgqdCDYos6xmHiKjB/3rRYGJr9avejzKF1frQ==
X-Received: by 2002:a05:620a:16d5:b0:6ec:52ab:e8bd with SMTP id a21-20020a05620a16d500b006ec52abe8bdmr20324302qkn.424.1666559700050;
        Sun, 23 Oct 2022 14:15:00 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a248800b006bb0f9b89cfsm14331181qkn.87.2022.10.23.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 14:14:58 -0700 (PDT)
Date:   Sun, 23 Oct 2022 16:14:53 -0500
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
Message-ID: <Y1WuzQxNExrOX8Xv@maniforge.dhcp.thefacebook.com>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
 <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
 <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
 <c815edb6-b008-07f4-2377-17b53ccdc289@meta.com>
 <Y1NdLah/c38isGT+@maniforge.dhcp.thefacebook.com>
 <95ff1fa3-124b-6886-64e0-adcf40085e55@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ff1fa3-124b-6886-64e0-adcf40085e55@meta.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 09:45:35AM -0700, Yonghong Song wrote:
> > > > > > > +	 * could be modifying the local_storage->list now.
> > > > > > > +	 * Thus, no elem can be added-to or deleted-from the
> > > > > > > +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> > > > > > > +	 *
> > > > > > > +	 * It is racing with bpf_local_storage_map_free() alone
> > > > > > > +	 * when unlinking elem from the local_storage->list and
> > > > > > > +	 * the map's bucket->list.
> > > > > > > +	 */
> > > > > > > +	bpf_cgrp_storage_lock();
> > > > > > > +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > > > > > +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > > > > > +		bpf_selem_unlink_map(selem);
> > > > > > > +		free_cgroup_storage =
> > > > > > > +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > > > > > 
> > > > > > This still requires a comment explaining why it's OK to overwrite
> > > > > > free_cgroup_storage with a previous value from calling
> > > > > > bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
> > > > > > a pretty weird programming pattern, and IMO doing this feels more
> > > > > > intentional and future-proof:
> > > > > > 
> > > > > > if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
> > > > > > 	free_cgroup_storage = true;
> > > > > 
> > > > > We have a comment a few lines below.
> > > > >     /* free_cgroup_storage should always be true as long as
> > > > >      * local_storage->list was non-empty.
> > > > >      */
> > > > >     if (free_cgroup_storage)
> > > > > 	kfree_rcu(local_storage, rcu);
> > > > 
> > > > IMO that comment doesn't provide much useful information -- it states an
> > > > assumption, but doesn't give a reason for it.
> > > > 
> > > > > I will add more explanation in the above code like
> > > > > 
> > > > > 	bpf_selem_unlink_map(selem);
> > > > > 	/* If local_storage list only have one element, the
> > > > > 	 * bpf_selem_unlink_storage_nolock() will return true.
> > > > > 	 * Otherwise, it will return false. The current loop iteration
> > > > > 	 * intends to remove all local storage. So the last iteration
> > > > > 	 * of the loop will set the free_cgroup_storage to true.
> > > > > 	 */
> > > > > 	free_cgroup_storage =
> > > > > 		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> > > > 
> > > > Thanks, this is the type of comment I was looking for.
> > > > 
> > > > Also, I realize this was copy-pasted from a number of other possible
> > > > locations in the codebase which are doing the same thing, but I still
> > > > think this pattern is an odd and brittle way to do this. We're relying
> > > > on an abstracted implementation detail of
> > > > bpf_selem_unlink_storage_nolock() for correctness, which IMO is a signal
> > > > that bpf_selem_unlink_storage_nolock() should probably be the one
> > > > invoking kfree_rcu() on behalf of callers in the first place.  It looks
> > > > like all of the callers end up calling kfree_rcu() on the struct
> > > > bpf_local_storage * if bpf_selem_unlink_storage_nolock() returns true,
> > > > so can we just move the responsibility of freeing the local storage
> > > > object down into bpf_selem_unlink_storage_nolock() where it's unlinked?
> > > 
> > > We probably cannot do this. bpf_selem_unlink_storage_nolock()
> > > is inside the rcu_read_lock() region. We do kfree_rcu() outside
> > > the rcu_read_lock() region.
> > 
> > kfree_rcu() is non-blocking and is safe to invoke from within an RCU
> > read region. If you invoke it within an RCU read region, the object will
> > not be kfree'd until (at least) you exit the current read region, so I
> > believe that the net effect here should be the same whether it's done in
> > bpf_selem_unlink_storage_nolock(), or in the caller after the RCU read
> > region is exited.
> 
> Okay. we probably still want to do kfree_rcu outside
> bpf_selem_unlink_storage_nolock() as the function is to unlink storage
> for a particular selem.

Meaning, it's for unlinking a specific element rather than the whole
list, so it's not the right place to free the larger struct
bpf_local_storage * container? If that's your point (and please clarify
if it's not and I'm misunderstanding) then I agree that's true, but
unfortunately whether the API likes it or not, it's tied itself to the
lifetime of the larger struct bpf_local_storage * by returning a bool
that says whether the caller needs to free that local storage pointer.
AFAICT, with the current API / implementation, if the caller drops this
value on the floor, the struct bpf_local_storage * is leaked, which
means that it's a leaky API.

That being said, I think I agree with you that just moving kfree_rcu()
into bpf_selem_unlink_storage_nolock() may not be appropriate, but
overall it feels like this pattern / API has room for improvement.
The fact that the (now) only three callers of this function have
copy-pasted code that's doing the exact same thing to free the is local
storage object is in my opinion a testament to that.

Anyways, none of that needs to block this patch set. I acked this in
your latest version, but I think this should be cleaned up by someone in
the near future; certainly before we add another local storage variant.

> We could move
> 	if (free_cgroup_storage)
> 		kfree_rcu(local_storage, rcu);
> immediately after hlist_for_each_entry_safe() loop.
> But I think putting that 'if' statement after rcu_read_unlock() is
> slightly better as it will not increase the code inside the lock region.

Yeah, if it's not abstracted by the bpf_local_storage APIs, it might as
well just be freed outside of the critical section.

Thanks,
David
