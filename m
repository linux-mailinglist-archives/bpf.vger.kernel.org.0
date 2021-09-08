Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AD403B05
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhIHNyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhIHNyg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 09:54:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97416C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 06:53:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c19so1873831qte.7
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDgcgZCZK6wPUyIqC9/xK51/0tzDMUPB+N6gWTIQaXE=;
        b=oC3gFobF/KXOztZCgVNzrkqYllEVSkqf63kKsmOXG49BfYKsb+RAPhmL80TPQ+rdFe
         SvnG5bRwGcHAd+/jMHiV39Qln9Q1PbETuikz+PnzalwcKWTuNreax4cOxVZE8hIyW5Nh
         o1yUpzgFvJBtB2zK8+SsWMnPdV2kKA94kkAw08BAYF7O0Ay0aYaiZr5dt05MKdzQQiYY
         Au+PrHjuvALI18M3ja2FnJfYCX4njMQ5yruciqqhZwwMP3PHAzNqBuxuGaHdr1mnTRNz
         GN6Y4+LT/96ZeBQ5nLKVBgNEgS/56w9Z7NDoQldA9S0zwlPAHaRvBOTyafQ2eKVbj5ub
         VbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDgcgZCZK6wPUyIqC9/xK51/0tzDMUPB+N6gWTIQaXE=;
        b=OIxzcJj3GC6hxswr2PS0NonD4R7bV+96ijCHKiTF/EfLUM/jTwn9+2Eoit2mVuuZdc
         49AD52znvyvelIHQZP1l9Nu/dsrZDvY1kOfcbgoZaL42C1z2l4tutl1hpQWtA+x8TiFo
         Sk9zwCPr2hZ9EuXa0FpU2ugBt95FDnZR737aKFNVfrlYRDjIhHRAWUV6oskdF+8u0PwJ
         WRWHQmmd17MQbpVY7oGiaCoPfe966fC5a1V/irWqH1uYK4Vjftoql44FsCBmZhMruoEn
         EP58y394N6TPEJvheNOI+5Fp1lC9f8cgsl+ujubn3zfSCqwVCw/47cr05dc7jZzD8WCs
         IOxQ==
X-Gm-Message-State: AOAM531PKqeJ5VWvocK1VlHrsastjBJoAMvCucVPyLYxTK10Zydzye4P
        ZrsSgCiGYeE4FCdoIEO1fbLHLw==
X-Google-Smtp-Source: ABdhPJxb/RU1j6Y9l8LZ3zB9jwVoPziqRchUxN2JMaF+gjX4++L/gWm1E/TQTft6El5dUsc/ZMdZHg==
X-Received: by 2002:ac8:701b:: with SMTP id x27mr3897866qtm.270.1631109207724;
        Wed, 08 Sep 2021 06:53:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s7sm1821081qkp.18.2021.09.08.06.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:53:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mNy10-00EWqQ-JG; Wed, 08 Sep 2021 10:53:26 -0300
Date:   Wed, 8 Sep 2021 10:53:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>, liam.howlett@oracle.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <20210908135326.GZ1200268@ziepe.ca>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:

> > The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> > asserts that mm->mmap_lock needs to be held. But this is not the case for
> > bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> > uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> > in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> > 
> > This patch added function find_vma_no_check() which does not have mmap_assert_locked() call and
> > bpf_get_stack[id]() helpers call find_vma_no_check() instead. This resolved the above warning.
> > 
> > I didn't use __find_vma() name because it has been used in drivers/gpu/drm/i915/i915_gpu_error.c:
> >      static struct i915_vma_coredump *
> >      __find_vma(struct i915_vma_coredump *vma, const char *name) { ... }
> > 
> > Cc: Luigi Rizzo <lrizzo@google.com>
> > Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
> fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?

Michel added this remark along with the mmap_read_trylock_non_owner:

    It's still not ideal that bpf/stackmap subverts the lock ownership in this
    way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
    way of addressing this in the short term.

Subverting lockdep and then adding more and more core MM APIs to
support this seems quite a bit more ugly than originally expected.

Michel's original idea to split out the lockdep abuse and put it only
in BPF is probably better. Obtain the mmap_read_trylock normally as
owner and then release ownership only before triggering the work. At
least lockdep will continue to work properly for the find_vma.

Jason
