Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7B1E84F9
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgE2RfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgE2Reh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 13:34:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54824C08C5C8
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:34:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so2911821qkb.10
        for <bpf@vger.kernel.org>; Fri, 29 May 2020 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vv9ldXFCL4C/whPnS1mUqMWHmnWNvuasrevBys51oQY=;
        b=sCPj7zebj0mv/diKCtrYT+mdgdGgrILrkEIsuMU30qVuUgOq4rON4zv7t2IR2QCCiy
         3nrhEnxM2SGiLbEzjs2OAQIKXYa1L0JMAEQbxfGNecN9eTyx0U23ysaxMZTpjXa7RgHj
         5VnUzdZXxiTXHSkHixvkLr2YcT2kEKlE/x1Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vv9ldXFCL4C/whPnS1mUqMWHmnWNvuasrevBys51oQY=;
        b=tOzjiYQAQaOGnanh9BOoccN1HnPoMRlaF1mJSDzrOVWSzbXxHeDPFMmfg7/oQ/VwwU
         ZR2aPffuIBueG/dCp+iX/vuhqTinhaQJneUu4LGaSWE6i7nsynMKBR1SBzNWZYyfjVgb
         c4t6YhnmxJgr5lEyb7Oft9ZTYxq/soiwG/V/9giJeq+10VzBIwghGF4VwQe1z6TbVhgi
         oQaBhpuBbv5HnqQRRN3i1SOrK7JOzTGr34et8VeZz5sB0njchL9w7H/eRvrvzXhnYwXS
         bUv7yOMFdVFyy7dWGPmP2RMbmQ0LIAfN5CbRpGEEnTsxeETHBnQTJE2zQn4Sqf9JSjZ+
         owqg==
X-Gm-Message-State: AOAM531G/OrZBdKYg29PcbChhBvmvK2PbfiG7iJtq9uXuIQ3iJpNFD6y
        1cAPt+Qt6UthwoH0FU86tb9+hw==
X-Google-Smtp-Source: ABdhPJxz5eFaweAdvrOQ5gun2AGecvOqXo1dDL/sDItlOWdtKXVjyXlW9OZoa5CGn5BrWJOwTFbaZA==
X-Received: by 2002:a37:4d97:: with SMTP id a145mr8891186qkb.94.1590773673300;
        Fri, 29 May 2020 10:34:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w49sm9228391qth.74.2020.05.29.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:34:32 -0700 (PDT)
Date:   Fri, 29 May 2020 13:34:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, Peter Ziljstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH linux-rcu] docs/litmus-tests: add BPF ringbuf MPSC litmus
 tests
Message-ID: <20200529173432.GC196085@google.com>
References: <20200528062408.547149-1-andriin@fb.com>
 <20200528225427.GA225299@google.com>
 <CAEf4BzZ_g2RwOgaRL1Qa9yo-8dH4kpgNaBOWZznNxqxhJUM1aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ_g2RwOgaRL1Qa9yo-8dH4kpgNaBOWZznNxqxhJUM1aA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Thu, May 28, 2020 at 10:50:30PM -0700, Andrii Nakryiko wrote:
> > [...]
> > > diff --git a/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus
> > > new file mode 100644
> > > index 000000000000..558f054fb0b4
> > > --- /dev/null
> > > +++ b/Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+bounded.litmus
> > > @@ -0,0 +1,91 @@
> > > +C bpf-rb+1p1c+bounded
> > > +
> > > +(*
> > > + * Result: Always
> > > + *
> > > + * This litmus test validates BPF ring buffer implementation under the
> > > + * following assumptions:
> > > + * - 1 producer;
> > > + * - 1 consumer;
> > > + * - ring buffer has capacity for only 1 record.
> > > + *
> > > + * Expectations:
> > > + * - 1 record pushed into ring buffer;
> > > + * - 0 or 1 element is consumed.
> > > + * - no failures.
> > > + *)
> > > +
> > > +{
> > > +     atomic_t dropped;
> > > +}
> > > +
> > > +P0(int *lenFail, int *len1, int *cx, int *px)
> > > +{
> > > +     int *rLenPtr;
> > > +     int rLen;
> > > +     int rPx;
> > > +     int rCx;
> > > +     int rFail;
> > > +
> > > +     rFail = 0;
> > > +
> > > +     rCx = smp_load_acquire(cx);
> > > +     rPx = smp_load_acquire(px);
> >
> > Is it possible for you to put some more comments around which ACQUIRE is
> > paired with which RELEASE? And, in general more comments around the reason
> > for a certain memory barrier and what pairs with what. In the kernel sources,
> > the barriers needs a comment anyway.

This was the comment earlier that was missed.

> > > +     if (rCx < rPx) {
> > > +             if (rCx == 0) {
> > > +                     rLenPtr = len1;
> > > +             } else {
> > > +                     rLenPtr = lenFail;
> > > +                     rFail = 1;
> > > +             }
> > > +
> > > +             rLen = smp_load_acquire(rLenPtr);
> > > +             if (rLen == 0) {
> > > +                     rFail = 1;
> > > +             } else if (rLen == 1) {
> > > +                     rCx = rCx + 1;
> > > +                     smp_store_release(cx, rCx);
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +P1(int *lenFail, int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped)
> > > +{
> > > +     int rPx;
> > > +     int rCx;
> > > +     int rFail;
> > > +     int *rLenPtr;
> > > +
> > > +     rFail = 0;
> > > +
> > > +     rCx = smp_load_acquire(cx);
> > > +     spin_lock(rb_lock);
> > > +
> > > +     rPx = *px;
> > > +     if (rPx - rCx >= 1) {
> > > +             atomic_inc(dropped);
> >
> > Why does 'dropped' need to be atomic if you are always incrementing under a
> > lock?
> 
> It doesn't, strictly speaking, but making it atomic in litmus test was
> just more convenient, especially that I initially also had a lock-less
> variant of this algorithm.

Ok, that's fine.

> >
> > > +             spin_unlock(rb_lock);
> > > +     } else {
> > > +             if (rPx == 0) {
> > > +                     rLenPtr = len1;
> > > +             } else {
> > > +                     rLenPtr = lenFail;
> > > +                     rFail = 1;
> > > +             }
> > > +
> > > +             *rLenPtr = -1;
> >
> > Clarify please the need to set the length intermittently to -1. Thanks.
> 
> This corresponds to setting a "busy bit" in kernel implementation.
> These litmus tests are supposed to be correlated with in-kernel
> implementation, I'm not sure I want to maintain extra 4 copies of
> comments here and in kernel code. Especially for 2-producer cases,
> there are 2 identical P1 and P2, which is unfortunate, but I haven't
> figured out how to have a re-usable pieces of code with litmus tests
> :)

I disagree that comments related to memory ordering are optional. IMHO, the
documentation should be clear from a memory ordering standpoint. After all,
good Documentation/ always clarifies something / some concept to the reader
right? :-) Please have mercy on me, I am just trying to learn *your*
Documentation ;-)

> > > diff --git a/Documentation/litmus-tests/bpf-rb/bpf-rb+2p1c+bounded.litmus b/Documentation/litmus-tests/bpf-rb/bpf-rb+2p1c+bounded.litmus
[...]
> > > +P1(int *lenFail, int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped)
> > > +{
> > > +     int rPx;
> > > +     int rCx;
> > > +     int rFail;
> > > +     int *rLenPtr;
> > > +
> > > +     rFail = 0;
> > > +     rLenPtr = lenFail;
> > > +
> > > +     rCx = smp_load_acquire(cx);
> > > +     spin_lock(rb_lock);
> > > +
> > > +     rPx = *px;
> > > +     if (rPx - rCx >= 1) {
> > > +             atomic_inc(dropped);
> > > +             spin_unlock(rb_lock);
> > > +     } else {
> > > +             if (rPx == 0) {
> > > +                     rLenPtr = len1;
> > > +             } else if (rPx == 1) {
> > > +                     rLenPtr = len1;
> > > +             } else {
> > > +                     rLenPtr = lenFail;
> > > +                     rFail = 1;
> > > +             }
> > > +
> > > +             *rLenPtr = -1;
> > > +             smp_store_release(px, rPx + 1);
> > > +
> > > +             spin_unlock(rb_lock);
> > > +
> > > +             smp_store_release(rLenPtr, 1);
> >
> > I ran a test replacing the last 2 statements above with the following and it
> > still works:
> >
> >                 spin_unlock(rb_lock);
> >                 WRITE_ONCE(*rLenPtr, 1);
> >
> > Wouldn't you expect the test to catch an issue? The spin_unlock is already a
> > RELEASE barrier.
> 
> Well, apparently it's not an issue and WRITE_ONCE would work as well
> :) My original version actually used WRITE_ONCE here. See [0] and
> discussion in [1] after which I removed all the WRITE_ONCE/READ_ONCE
> in favor of store_release/load_acquire for consistency.
> 
>   [0] https://patchwork.ozlabs.org/project/netdev/patch/20200513192532.4058934-3-andriin@fb.com/
>   [1] https://patchwork.ozlabs.org/project/netdev/patch/20200513192532.4058934-2-andriin@fb.com/

Huh. So you are replacing the test to use WRITE_ONCE instead? Why did you
favor the acquire/release memory barriers over the _ONCE annotations, if that
was not really needed then?

> > Suggestion: It is hard to review the patch because it is huge, it would be
> > good to split this up into 4 patches for each of the tests. But upto you :)
> 
> Those 4 files are partial copies of each other, not sure splitting
> them actually would be easier. If anyone else thinks the same, though,
> I'll happily split.

I personally disagree. It would be much easier IMHO to review 4 different
files since some of them are also quite dissimilar. I frequently keep jumping
between diffs to find a different file and it makes the review that much
harder. But anything the LKMM experts decide in this regard is acceptable to me :)

thanks,

 - Joel

