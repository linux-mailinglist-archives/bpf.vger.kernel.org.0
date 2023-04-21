Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C66EB5CE
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjDUXtQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjDUXtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 19:49:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179A269A
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 16:49:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2335802b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120952; x=1684712952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwu16qh1V/GyV82zpD2/gkTBBGQiP7a1RNAclzcE0SA=;
        b=XvRL9pDDVLgKMTe+Ru+jAHyu7aP0ktiP/RG/VrSdXJ1tsi9y6kpECYmT/Cn5eEvV0I
         uelLIR0XaQoW4G+WezfVxxtUn23xQWFKVa6I0HC0uCoD8RWxP1DneNJ8zyGNGp+b2FZV
         hPmcBK0Sr96lsFUvP4uKstztukS4vdEiSEZxsLHBtWDdZpBQCvQ49MFdVXrnXoRGbu4L
         0jDlZGKaivVAFYXeguXoTkU/hTAWB+k6XfkHlKw6Tc4WL/cQuQfbpKKqPnjkF5q8/B71
         0CGNJ3dx2+xCGor+l+Ntw+M3lrKXTdHZFydeueZQQXXg0qez2PT0GVHCSCZoJutdQbCQ
         HkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120952; x=1684712952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwu16qh1V/GyV82zpD2/gkTBBGQiP7a1RNAclzcE0SA=;
        b=QJ4owtb+6Mdn7aRu/xsbkbr363v1uG0PtZWRFkg24XDipdpIiVvihDd4lBhCWAkkgK
         tdkquBPepD3y7v/4DN7fxnXF7KMxEJ8P9FQNPqbZo5XRgcqbU5Xxg2P2xL3i4X9eRo6E
         SXsZo2wApz9EP377jq/WrKDnKavrARhOrj1J81Vyd8+mlxMlt8D+F2n3wFRczEdIppfp
         deh+vKV7NvbS4Pmj7rlNyXHdfSCAd0sy+xAQ0zEhykPKLtMD+GV445X30FPq8gu2ZhYR
         JeBmFqnO/fDQOpn07fNSO3taH+FpT4sYbo+zlFfI0pde3E1J2QdWkuxIN5GI/iCtasCX
         qARg==
X-Gm-Message-State: AAQBX9dB2gX18ZSml+LVdOCIhEEQxk5VeCdjFxYkppHRTYuJ7h3YNlYs
        6ATPar/CGTl83xsXjI7KJQo=
X-Google-Smtp-Source: AKy350ZDohTI3wcuOxZfZWr2TLG7VZ83mHKjanXodpOLPX8Z2cxCjZxzO4+XxQhHx7fyXbo2txziTA==
X-Received: by 2002:a05:6a00:178c:b0:63d:3ae1:e3ba with SMTP id s12-20020a056a00178c00b0063d3ae1e3bamr9313015pfg.6.1682120951839;
        Fri, 21 Apr 2023 16:49:11 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ef5e])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b0063d3fbf4783sm3436837pfg.80.2023.04.21.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 16:49:10 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:49:08 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Message-ID: <20230421234908.tixmdprfxz5ixh6m@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-10-davemarchevsky@fb.com>
 <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 22, 2023 at 12:17:47AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat, Apr 15, 2023 at 10:18:11PM CEST, Dave Marchevsky wrote:
> > Test refcounted local kptr functionality added in previous patches in
> > the series.
> >
> > Usecases which pass verification:
> >
> > * Add refcounted local kptr to both tree and list. Then, read and -
> >   possibly, depending on test variant - delete from tree, then list.
> >   * Also test doing read-and-maybe-delete in opposite order
> > * Stash a refcounted local kptr in a map_value, then add it to a
> >   rbtree. Read from both, possibly deleting after tree read.
> > * Add refcounted local kptr to both tree and list. Then, try reading and
> >   deleting twice from one of the collections.
> > * bpf_refcount_acquire of just-added non-owning ref should work, as
> >   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
> >
> > Usecases which fail verification:
> >
> > * The simple successful bpf_refcount_acquire cases from above should
> >   both fail to verify if the newly-acquired owning ref is not dropped
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> > [...]
> > +SEC("?tc")
> > +__failure __msg("Unreleased reference id=3 alloc_insn=21")
> > +long rbtree_refcounted_node_ref_escapes(void *ctx)
> > +{
> > +	struct node_acquire *n, *m;
> > +
> > +	n = bpf_obj_new(typeof(*n));
> > +	if (!n)
> > +		return 1;
> > +
> > +	bpf_spin_lock(&glock);
> > +	bpf_rbtree_add(&groot, &n->node, less);
> > +	/* m becomes an owning ref but is never drop'd or added to a tree */
> > +	m = bpf_refcount_acquire(n);
> 
> I am analyzing the set (and I'll reply in detail to the cover letter), but this
> stood out.
> 
> Isn't this going to be problematic if n has refcount == 1 and is dropped
> internally by bpf_rbtree_add? Are we sure this can never occur? It took me some
> time, but the following schedule seems problematic.
> 
> CPU 0					CPU 1
> n = bpf_obj_new
> lock(lock1)
> bpf_rbtree_add(rbtree1, n)
> m = bpf_rbtree_acquire(n)
> unlock(lock1)
> 
> kptr_xchg(map, m) // move to map
> // at this point, refcount = 2
> 					m = kptr_xchg(map, NULL)
> 					lock(lock2)
> lock(lock1)				bpf_rbtree_add(rbtree2, m)
> p = bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) // A
> bpf_rbtree_remove(rbtree1, p)
> unlock(lock1)
> bpf_obj_drop(p) // B

You probably meant:
p2 = bpf_rbtree_remove(rbtree1, p)
unlock(lock1)
if (p2)
  bpf_obj_drop(p2)

> 					bpf_refcount_acquire(m) // use-after-free
> 					...
> 
> B will decrement refcount from 1 to 0, after which bpf_refcount_acquire is
> basically performing a use-after-free (when fortunate, one will get a
> WARN_ON_ONCE splat for 0 to 1, otherwise, a silent refcount raise for some
> different object).

As discussed earlier we'll be switching all bpf_obj_new to use BPF_MA_REUSE_AFTER_RCU_GP.

and to adress 0->1 transition.. it does look like we need to two flavors of bpf_refcount_acquire.
One of owned refs and another for non-owned.
The owned bpf_refcount_acquire() can stay KF_ACQUIRE with refcount_inc,
while bpf_refcount_acquire() for non-own will use KF_ACQUIRE | KF_RET_NULL and refcount_inc_not_zero.
The bpf prog can use bpf_refcount_acquire everywhere and the verifier will treat it on the spot
differently depending on the argument.
So the code:
n = bpf_obj_new();
if (!n) ...;
m = bpf_refcount_acquire(n);
doesn't need to check if (!m).
