Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD12A5690FF
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGFRoL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiGFRnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104FB2B196
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:43:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i17so5458480pfk.1
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U8RDIjaz0+fXEx3uqi/jOmLPcygV9XMbpDJVew9ijlg=;
        b=SwsKV8KtbCrcOUNyLknyYbvuvPKCxhptX92Pih/BS3o+yOj4UdLpLlQLW+N3rC236T
         Lsxp6ZW+zdNIUCj6ZBO3jsAG+61zVBj4oCLqMkCKrJUm7aqNTXVfl484QufU8AWnGdPR
         zQSSCm2icWznFGi+nBu683nwfhD6f9Jk6yr1/+QownsA49Fe8AVUjWAtObYd7JHmdxDa
         zyb4eLQsHkhN58dEzIEJHRUPo6usYmpj23K0KvEGw77TVthq4OHsBsvfSo4XMJ5S24nB
         b069B7rvTBwuteoXMfcAzGRHS1emSQdNLPWvV/ujFw1uB/dFeXSbPEHl4GjlV+gMRxAL
         nfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8RDIjaz0+fXEx3uqi/jOmLPcygV9XMbpDJVew9ijlg=;
        b=vQMzvdD5uPgeMwPBpJEmwaE+58JFBhpe4cqDSUEgKFSmHWmp/UIgmo4y36zY7pXy7H
         RGv4mpBMTPQDh3K7d+0YEljaMlat3wQgNnOS5ykqsCP90GbAR9dxOWiP7D3C3D2glmBx
         VEL3mKGbgN1CYhGPKgH712bGOxgf1a1YiLoHKNonzU2e16kO/IAY9wYqkRRau6ERzg1q
         //62fJ+wiuEk0lnkuBcE0RKkE/0wwKeYCZbtqsSofM39vskHUhi2tYrS8HDUd8SuSmK2
         nf/QjAItQ64woJQAyns+3maRQ1oECpHbqTHcLOaMJD+b7isPZRt4d5Na1eRzLOID1FiH
         vtNw==
X-Gm-Message-State: AJIora9LfjN3tS2pMLnMTolMljvRwqNi7geWjoFjdie3KyAEZTqDoPR+
        4v2bG5EetX3oDti1ua0uCZ0=
X-Google-Smtp-Source: AGRyM1vKoa2DmuabAmTZ2hPr/9xAAB4oiaToQhSSqpIW6Xdq5sj4R43bnvlHd0GZzG4/BYQgJM7mhw==
X-Received: by 2002:a63:1921:0:b0:412:407f:f012 with SMTP id z33-20020a631921000000b00412407ff012mr15301509pgl.125.1657129411876;
        Wed, 06 Jul 2022 10:43:31 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0052534ade61dsm25124018pfr.185.2022.07.06.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:31 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:43:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <20220706174328.xqfyu4ikjvutnpr4@MacBook-Pro-3.local>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
 <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
 <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de>
 <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
 <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
 <CAADnVQ+6BQsunu+ipDJpEuikUU402bZPevK9+MuaBoNC_rAu_A@mail.gmail.com>
 <8a160205-99fe-a632-aeed-6b59eadc2aa2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a160205-99fe-a632-aeed-6b59eadc2aa2@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 04, 2022 at 06:13:17PM +0200, Vlastimil Babka wrote:
> On 6/29/22 04:49, Alexei Starovoitov wrote:
> > On Tue, Jun 28, 2022 at 7:35 PM Christoph Lameter <cl@gentwo.de> wrote:
> >>
> >> On Tue, 28 Jun 2022, Alexei Starovoitov wrote:
> >>
> >> > > That is a relatively new feature due to RT logic support. without RT this
> >> > > would be a simple irq disable.
> >> >
> >> > Not just RT.
> >> > It's a slow path:
> >> >         if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
> >> >             unlikely(!object || !slab || !node_match(slab, node))) {
> >> >               local_unlock_irqrestore(&s->cpu_slab->lock,...);
> >> > and that's not the only lock in there.
> >> > new_slab->allocate_slab... alloc_pages grabbing more locks.
> >>
> >>
> >> Its not a lock for !RT.
> >>
> >> The fastpath is lockless if hardware allows that but then we go into more
> >> and more serialiation needs as the allocation gets more into the page
> >> allocator logic.
> 
> Yeah I don't think the recent RT-related changes made this much worse than
> it already was. In alloc side you could perhaps try the really lockless
> fastpaths only and fail if e.g. the per-cpu slabs were empty (but would BPF
> be happy with that?). On the free side though you could end up having to
> move a slab from partial to free list as a result, and now a spin lock is
> needed (even before the RT changes), and you can't really fail a free...
> 
> > On RT fast path == slow path with a lock.
> > On !RT fast path is lock less.
> > That's all correct.
> > bpf side has to make sure safety in all possible paths
> > therefore RT or !RT makes no difference.
> 
> So AFAIK we don't right now have what BFP needs - an extra-constrained kind
> of GFP_ATOMIC. I don't object you adding it privately. But it's another
> reason to think about if these things can be generalized. For example we had
> a discussion about the Maple tree having kinda similar kinds of requirements
> to avoid its tree node preallocations always for the worst possible case.

What kind of maple tree needs? Does it need to be fully reentrant and nmi safe?
Not really. The caller knows the context and can choose appropriate flags.
While bpf alloc doesn't know the context. The bpf prog can be called from
places where slab/page/kasan specific locks are held which makes all these
pieces non-reentrable.
The full prealloc of bpf maps (read: waste a lot of memory) was our solution until now.
This is specific to tracing bpf programs, of course.
bpf networking, bpf security, sleepable bpf are completely different.

> I'm not sure we can sanely implement this within each of SLAB/SLUB/SLOB, or
> rather provide a generic cache on top...

Notice that all of bpf cache functions are notrace/nokprobe/no locks.
The main difference vs all other allocators is bpf_mem_alloc from cache
and refill of the cache are two asynchronous operations. It allows the former
to be reentrant and nmi safe.
All in tree allocators sooner or later synchornously call into page_alloc,
kasan, memleak and other debugging facilites that grab locks.
