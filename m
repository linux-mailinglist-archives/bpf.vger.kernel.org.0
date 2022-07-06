Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3656915E
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGFSFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiGFSFa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 14:05:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18AE1CFD7
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 11:05:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so6734093pjr.4
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/uw/dcSlMSSrdMGqGMlhLWezxnqW48ImhZuLtj9UNk=;
        b=AAuxWvp3lkLUJhlzLCNTmZbwMj75lW5f+cB2htn/fK/HebPMnNioSuUAWvsiB0Qt7q
         ifjkYiLVqafHvqzE4cxTeiDmzvYO16Qz539kjK1wHmTa/de7lwTj2r1s4GhAh4yz+ABh
         +/Peau72XSNz4pW1dffLZQ+GRvMy6cZurSXl8d+p1UwwuxwgNHn0FijZ23V51SJiyNkQ
         KBzdBsgrPw5b4yv6k+jl4BfcJu3ubtVHGI9wF2JFfDUgWzAiSiK5BSsgo0ZTmIYCQ1Sx
         48lfYjzLhph7OdSPqSw7HmRBxE3IY4Q8UgmNTleQ/dSlh0a2+YjKFmNfOWk5nN9E2ZFe
         /k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/uw/dcSlMSSrdMGqGMlhLWezxnqW48ImhZuLtj9UNk=;
        b=3Ktp6tFUWmDaiGs363JKwpgfV9HJ3SIrIE1meU8e6ITAHO2AA5LtOfx/gfVFtkf1V+
         LuCCAgJsy2iwJ7bdsKFXL3ZzeDpOGOICPYrQZ+h2INUgxZTisHrnxJy/kIThP6zMKwQg
         2X0xu1gnVhqp20lbCnW9T9WRSkRJ4QwpbAxBP8AlnO4R8oU1x/lhX7dl+U8HSiFfn0Sf
         1XV6q5mDEgtLVOHKKndQEyN9T4i5VICSyVQ3OSAVL8opIJNoxu3BLFMuoy6aKYibmuCY
         Cdnphudesa9U/KFqpn5j+OwN6aAr69BjhhOlfZbK2GxtGw5RkP67A1YcHOxD2YulG27Y
         jEig==
X-Gm-Message-State: AJIora87qiFTZqHyFeJaiBAyUeDEdFOfHysj6Lz/pn1uHKebLOyH6fbf
        A1dzojjIKhlLuxxjTUEF1uU=
X-Google-Smtp-Source: AGRyM1uY/bT0SLXQLiK9eq+6CtGzvVK6V9wnN2EPI/XRYcv/M8B3WZE/CLB999i40J2VTSSoJ5U/1Q==
X-Received: by 2002:a17:90b:1d8f:b0:1ec:cd0c:23fe with SMTP id pf15-20020a17090b1d8f00b001eccd0c23femr51893129pjb.147.1657130729149;
        Wed, 06 Jul 2022 11:05:29 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b0015e8d4eb1easm26173434pla.52.2022.07.06.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:05:28 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:05:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsXMmBf9Xsp61I0m@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 10:50:34AM -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 04, 2022 at 09:34:23PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jun 27, 2022 at 12:03:08AM -0700, Christoph Hellwig wrote:
> > > > I'd suggest you discuss you needs with the slab mainainers and the mm
> > > > community firs.
> > > > 
> > > > On Wed, Jun 22, 2022 at 05:32:25PM -0700, Alexei Starovoitov wrote:
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > 
> > > > > Introduce any context BPF specific memory allocator.
> > > > > 
> > > > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > > > run in unknown context where calling plain kmalloc() might not be safe.
> > > > > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > > > > Refill this cache asynchronously from irq_work.
> > > 
> > > I can't tell from your description whether a bump allocator would work
> > > for you.  That is, can you tell which allocations need to persist past
> > > program execution (and use kmalloc for them) and which can be freed as
> > > soon as the program has finished (and can use the bump allocator)?
> > > 
> > > If so, we already have one for you, the page_frag allocator
> > > (Documentation/vm/page_frags.rst).  It might need to be extended to meet
> > > your needs, but it's certainly faster than the kmalloc allocator.
> > 
> > Already looked at it, and into mempool, and everything we could find.
> > All 'normal' allocators sooner or later synchornously call into page_alloc,
> 
> Today it does, yes.  But it might be adaptable to your needs if only I
> knew what those needs were.  

needs: fully reentrant, nmi safe, any context safe.
I feel you're still failing to grasp 'any context' part.
bpf prog can attach to all available_filter_functions and should be able
to alloc from there.
Or kprobe anywhere and everywhere in the kernel .text that is not marked notrace/nokprobe.

> For example, I assume that a BPF program
> has a fairly tight limit on how much memory it can cause to be allocated.
> Right?

No. It's constrained by memcg limits only. It can allocate gigabytes.
