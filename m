Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE26EB6BC
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 04:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDVCGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 22:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVCGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 22:06:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FBA2122
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 19:06:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-94f7a0818aeso323233566b.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 19:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682129200; x=1684721200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGiDtXxWlImwHOYrgr0rbnwW9dirhv/KE1aB4Ck+pbs=;
        b=fU3OqhFMvG/1i7QDFOWJ4Nccx/P6+X++WivzTLOt9OfSR8oG1CVFwTZO5j/5cLH+yz
         VFMsZVO4MGi19arkpbV+rvpcYLFFVzFcxH9RlVDLxNquJ7iifbTHJ+nD7D1g1bv50pQW
         4xt1rCfJXZR/R7dgX/W6EkMyUIJfEBYy/WoMy/MpA34PwQEb2S0bqg84u6WwdEVkJBHI
         3NBAK201J6JMFz5DQmbzICVVD7VFodm02Azkc9pgxeonPGBdqfdgFIo8wI+i30w/9qVi
         QYrHa7dGZT9QI4Ye/Ufn3tNU2p8j5dOx90x7djASP9hHnrXIdvG2SovBwdA2oC/2eWG/
         uyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682129200; x=1684721200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGiDtXxWlImwHOYrgr0rbnwW9dirhv/KE1aB4Ck+pbs=;
        b=KIZrkDL3vIo+KtLgb6KHqaDav1cu9Q/2oL73qEID1Klul6lzBRqmyLKCjm413Og8HP
         i5Te1pVb+JWp/svUUMKGi8TmxXOSEKBBKyBZ3o5kFsiQa/DkWDh/y+iBRAJ8FxEoguSW
         DYQnbEjdBW8F/+nzQ6AB2nffi7en3TbQjx5E3tfQV3g3Jujt4l0vG59TZmKlt08a/aIB
         YATu1DrvllJCY1oY1mnfEFQh56vwVBBHh9Jeq7Gy8G431USETxpSllwLPj+JDsPDqiM0
         fOd0t5nVsGv4uORJCxIOwn9xKYNyLOJEZ8/5hzrwDfOjX4vhXtxLFg/+rOW/d5ZmVsAD
         hQXg==
X-Gm-Message-State: AAQBX9fGq8bmOmw0gyfCTS5E/7QvK7WnL1DjQGNNzZdbpnZtCeDx7rzs
        ViawSwoYM88Ayq9iQRWVBxo=
X-Google-Smtp-Source: AKy350aNhRaIKixEUiZ+vBYZiZur/BF22+62TQK3vg+JLOVMoaoYfuv3WXe7JjXZ365h0dgy6Jrq4A==
X-Received: by 2002:a17:907:2a51:b0:94e:16d:4bf1 with SMTP id fe17-20020a1709072a5100b0094e016d4bf1mr2828183ejc.66.1682129199754;
        Fri, 21 Apr 2023 19:06:39 -0700 (PDT)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906338f00b0094c3ac3c2bbsm2729672eja.212.2023.04.21.19.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 19:06:39 -0700 (PDT)
Date:   Sat, 22 Apr 2023 04:06:38 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Message-ID: <4irsjhtdw4pf76jvlls6poso4yiruzevs3awu5bahzzl5zp5un@iao4jc3ihj7o>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-10-davemarchevsky@fb.com>
 <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
 <20230421234908.tixmdprfxz5ixh6m@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421234908.tixmdprfxz5ixh6m@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 22, 2023 at 01:49:08AM CEST, Alexei Starovoitov wrote:
> On Sat, Apr 22, 2023 at 12:17:47AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Apr 15, 2023 at 10:18:11PM CEST, Dave Marchevsky wrote:
> > > Test refcounted local kptr functionality added in previous patches in
> > > the series.
> > >
> > > Usecases which pass verification:
> > >
> > > * Add refcounted local kptr to both tree and list. Then, read and -
> > >   possibly, depending on test variant - delete from tree, then list.
> > >   * Also test doing read-and-maybe-delete in opposite order
> > > * Stash a refcounted local kptr in a map_value, then add it to a
> > >   rbtree. Read from both, possibly deleting after tree read.
> > > * Add refcounted local kptr to both tree and list. Then, try reading and
> > >   deleting twice from one of the collections.
> > > * bpf_refcount_acquire of just-added non-owning ref should work, as
> > >   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
> > >
> > > Usecases which fail verification:
> > >
> > > * The simple successful bpf_refcount_acquire cases from above should
> > >   both fail to verify if the newly-acquired owning ref is not dropped
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > ---
> > > [...]
> > > +SEC("?tc")
> > > +__failure __msg("Unreleased reference id=3 alloc_insn=21")
> > > +long rbtree_refcounted_node_ref_escapes(void *ctx)
> > > +{
> > > +	struct node_acquire *n, *m;
> > > +
> > > +	n = bpf_obj_new(typeof(*n));
> > > +	if (!n)
> > > +		return 1;
> > > +
> > > +	bpf_spin_lock(&glock);
> > > +	bpf_rbtree_add(&groot, &n->node, less);
> > > +	/* m becomes an owning ref but is never drop'd or added to a tree */
> > > +	m = bpf_refcount_acquire(n);
> >
> > I am analyzing the set (and I'll reply in detail to the cover letter), but this
> > stood out.
> >
> > Isn't this going to be problematic if n has refcount == 1 and is dropped
> > internally by bpf_rbtree_add? Are we sure this can never occur? It took me some
> > time, but the following schedule seems problematic.
> >
> > CPU 0					CPU 1
> > n = bpf_obj_new
> > lock(lock1)
> > bpf_rbtree_add(rbtree1, n)
> > m = bpf_rbtree_acquire(n)
> > unlock(lock1)
> >
> > kptr_xchg(map, m) // move to map
> > // at this point, refcount = 2
> > 					m = kptr_xchg(map, NULL)
> > 					lock(lock2)
> > lock(lock1)				bpf_rbtree_add(rbtree2, m)
> > p = bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) // A
> > bpf_rbtree_remove(rbtree1, p)
> > unlock(lock1)
> > bpf_obj_drop(p) // B
>
> You probably meant:
> p2 = bpf_rbtree_remove(rbtree1, p)
> unlock(lock1)
> if (p2)
>   bpf_obj_drop(p2)
>
> > 					bpf_refcount_acquire(m) // use-after-free
> > 					...
> >
> > B will decrement refcount from 1 to 0, after which bpf_refcount_acquire is
> > basically performing a use-after-free (when fortunate, one will get a
> > WARN_ON_ONCE splat for 0 to 1, otherwise, a silent refcount raise for some
> > different object).
>
> As discussed earlier we'll be switching all bpf_obj_new to use BPF_MA_REUSE_AFTER_RCU_GP

I probably missed that thread. In that case, is use of this stuff going to
require bpf_rcu_read_lock in sleepable programs?

>
> and to adress 0->1 transition.. it does look like we need to two flavors of bpf_refcount_acquire.
> One of owned refs and another for non-owned.
> The owned bpf_refcount_acquire() can stay KF_ACQUIRE with refcount_inc,
> while bpf_refcount_acquire() for non-own will use KF_ACQUIRE | KF_RET_NULL and refcount_inc_not_zero.
> The bpf prog can use bpf_refcount_acquire everywhere and the verifier will treat it on the spot
> differently depending on the argument.
> So the code:
> n = bpf_obj_new();
> if (!n) ...;
> m = bpf_refcount_acquire(n);
> doesn't need to check if (!m).

If memory reuse is prevented, than indeed the above should fix the problem.
Though it might be a bit surprising if a pointer from the same helper has to be
null checked in one context, and not in another. Though that's just a minor
point.
