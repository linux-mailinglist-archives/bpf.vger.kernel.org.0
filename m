Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F7F55B318
	for <lists+bpf@lfdr.de>; Sun, 26 Jun 2022 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFZRTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jun 2022 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiFZRTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jun 2022 13:19:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871DE0AD
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 10:19:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 184so6981743pga.12
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UMWk7J8g8bFvhtFEU4VTABaRORT/iHBBYfrLc3E0fm0=;
        b=dlE7t3Q/tauoeq/ugMNk1D2LmqmnjnAjN7XqWFmQJtAcaNebDovGmOl4p643mXLRYE
         mzBRadgWt0kMLTIrbRYV/88pGNYgNkHI17wd1+rS2Dao+CZwdbuZ5Axsd6vRSafsmgyK
         E7pgWlwHFj+VbYn3woIVR5E9svA6r/pxb7V1AZxMcnBusMfyWo2YD9RfAAAXcldpRTrS
         15qGeW7X6+YqEzU5oPzXFyN7fafspQmwrqWa3jCaGtwLrzLUEK8BKiEGYaVe/pIa/Jny
         QK4HjHQA99fVedJPM7Ofti5MkC0+LfrxiLkgYwKTOw/wd2YPv5pLFrHUvXfmft3Hepyb
         JPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMWk7J8g8bFvhtFEU4VTABaRORT/iHBBYfrLc3E0fm0=;
        b=EPT1j0JsLFFm759t2jhY3HB4JC1V5Afx0Apx1auZC7XTR/CKCB8b7UrVLw31w+myXe
         yCLU4TGILNctOVvILyJzl71dOHx0zkACq9K3UM+Gbt6FfG2Fv5sE/yAtske0ps+R5Zrg
         NG8OwsbR0Ub12fRvbTrf9NE6jHessekN1QrSmCJSCRHlJEHFg8+APeP5v5evfxAN/oKd
         oDTOOY2sthxNYRJUr5NTSlylFlxLmiM767n04jHoW2ruN3213zDPxepUfg46KfA7OLVu
         iwKeW/8VduVA/c5j4O5WgkMBUjQauu8ZqvsgRjZ5ama9FhVoDHsxRTW1YG1RQ1t/7gg/
         t4fw==
X-Gm-Message-State: AJIora9qtGoKcny+45fGXSvbZnKjxrOhkTOuZHe/3gj18KdtLtLhwdVI
        yEGRvw+EzglAAfDxgLI1Pjvs1ZKlOp8=
X-Google-Smtp-Source: AGRyM1vbwGaFwLFrygOc0srEY0Clu9OXkm4RMacJG32gy0ldo5rQUN60OmxKwSOvy7JyB34/vU3a7A==
X-Received: by 2002:a65:6a94:0:b0:40c:977c:9665 with SMTP id q20-20020a656a94000000b0040c977c9665mr8951730pgu.5.1656263956195;
        Sun, 26 Jun 2022 10:19:16 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:9232])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm5414442pjb.47.2022.06.26.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 10:19:15 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:19:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, kafai@fb.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/5] bpf: Introduce any context BPF specific
 memory allocator.
Message-ID: <20220626171913.b7wsixncfn42nfpv@macbook-pro-3.dhcp.thefacebook.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <20220623003230.37497-2-alexei.starovoitov@gmail.com>
 <62b6638e4e0d1_347af208e3@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b6638e4e0d1_347af208e3@john.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 06:23:26PM -0700, John Fastabend wrote:
> Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> > 
> > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > Refill this cache asynchronously from irq_work.
> > 
> > BPF programs always run with migration disabled.
> > It's safe to allocate from cache of the current cpu with irqs disabled.
> > Free-ing is always done into bucket of the current cpu as well.
> > irq_work trims extra free elements from buckets with kfree
> > and refills them with kmalloc, so global kmalloc logic takes care
> > of freeing objects allocated by one cpu and freed on another.
> > 
> > struct bpf_mem_alloc supports two modes:
> > - When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
> >   This is typical bpf hash map use case when all elements have equal size.
> > - When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
> >   kmalloc/kfree. Max allocation size is 4096 in this case.
> >   This is bpf_dynptr and bpf_kptr use case.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> 
> Some initial feedback but still looking over it. Figured it made more
> sense to dump current thoughts then drop it this evening for Monday.
> 
> [...]
> 
> > +static int bpf_mem_cache_idx(size_t size)
>     [...]
> 
> > +#define NUM_CACHES 11
> > +
> > +struct bpf_mem_cache {
> > +	/* per-cpu list of free objects of size 'unit_size'.
> > +	 * All accesses are done with preemption disabled
> > +	 * with __llist_add() and __llist_del_first().
> > +	 */
> > +	struct llist_head free_llist;
> > +
> > +	/* NMI only free list.
> > +	 * All accesses are NMI-safe llist_add() and llist_del_first().
> > +	 *
> > +	 * Each allocated object is either on free_llist or on free_llist_nmi.
> > +	 * One cpu can allocate it from NMI by doing llist_del_first() from
> > +	 * free_llist_nmi, while another might free it back from non-NMI by
> > +	 * doing llist_add() into free_llist.
> > +	 */
> > +	struct llist_head free_llist_nmi;
> 
> stupid nit but newline here helps me read this.

sure.

> > +	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
> > +	 * element size.
> > +	 */
> > +	struct kmem_cache *kmem_cache;
> 
> > +	struct irq_work refill_work;
> > +	struct mem_cgroup *memcg;
> > +	int unit_size;
> > +	/* count of objects in free_llist */
> > +	int free_cnt;
> > +	/* count of objects in free_llist_nmi */
> > +	atomic_t free_cnt_nmi;
> > +	/* flag to refill nmi list too */
> > +	bool refill_nmi_list;
> > +};
> 
> What about having two types one for fixed size cache and one for buckets?
> The logic below gets a bunch of if cases with just the single type. OTOH
> I messed around with it for a bit and then had to duplicate most of the
> codes so I'm not sure its entirely a good idea, but the __alloc() with
> the 'if this else that' sort of made me think of it.

Two 'if's in __alloc and __free are the only difference.
The rest of bpf_mem_cache logic is exactly the same between fixed size
and buckets.
I'm not sure what 'two types' would look like.

> > +
> > +static struct llist_node notrace *__llist_del_first(struct llist_head *head)
>      [...]
> 
> > +
> > +#define BATCH 48
> > +#define LOW_WATERMARK 32
> > +#define HIGH_WATERMARK 96
> > +/* Assuming the average number of elements per bucket is 64, when all buckets
> > + * are used the total memory will be: 64*16*32 + 64*32*32 + 64*64*32 + ... +
> > + * 64*4096*32 ~ 20Mbyte
> > + */
> > +
> > +/* extra macro useful for testing by randomizing in_nmi condition */
> > +#define bpf_in_nmi() in_nmi()
> > +
> > +static void *__alloc(struct bpf_mem_cache *c, int node)
> 
> For example with two types this mostly drops out. Of course then the callers
> have to know the type so not sure. And you get two alloc_bulks and
> so on. Its not obviously this works out well.
> 
> [...]
> 
> > +static void free_bulk_nmi(struct bpf_mem_cache *c)
> > +{
> > +	struct llist_node *llnode;
> > +	int cnt;
> > +
> > +	do {
> > +		llnode = llist_del_first(&c->free_llist_nmi);
> > +		if (llnode)
> > +			cnt = atomic_dec_return(&c->free_cnt_nmi);
> > +		else
> > +			cnt = 0;
> > +		__free(c, llnode);
> > +	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
> > +}
> 
> Comment from irq_work_run_list,
> 
> 	/*
> 	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
> 	 * in a per-CPU thread in preemptible context. Only the items which are
> 	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
> 	 */
> 
> Not an RT expert but I read this to mean in PREEMPT_RT case we can't assume
> this is !preemptible? If I read correctly then is there a risk we get
> two runners here? And by extension would need to worry about free_cnt
> and friends getting corrupted.

Right. That's why there is local_irq_save:
                if (IS_ENABLED(CONFIG_PREEMPT_RT))
                        local_irq_save(flags);
                llnode = __llist_del_first(&c->free_llist);
                if (llnode)
                        cnt = --c->free_cnt;
in alloc/free_bulk specifically for RT.
So that alloc_bulk doesn't race with that kthread.
and free_cnt doesn't get corrupted.

> 
> > +
> > +static void bpf_mem_refill(struct irq_work *work)
> > +{
> > +	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
> > +	int cnt;
> > +
> > +	cnt = c->free_cnt;
> > +	if (cnt < LOW_WATERMARK)
> > +		/* irq_work runs on this cpu and kmalloc will allocate
> > +		 * from the current numa node which is what we want here.
> > +		 */
> > +		alloc_bulk(c, BATCH, NUMA_NO_NODE);
> > +	else if (cnt > HIGH_WATERMARK)
> > +		free_bulk(c);
> > +
> > +	if (!c->refill_nmi_list)
> > +		/* don't refill NMI specific freelist
> > +		 * until alloc/free from NMI.
> > +		 */
> > +		return;
> > +	cnt = atomic_read(&c->free_cnt_nmi);
> > +	if (cnt < LOW_WATERMARK)
> > +		alloc_bulk_nmi(c, BATCH, NUMA_NO_NODE);
> > +	else if (cnt > HIGH_WATERMARK)
> > +		free_bulk_nmi(c);
> > +	c->refill_nmi_list = false;
> > +}
> > +
> > +static void notrace irq_work_raise(struct bpf_mem_cache *c, bool in_nmi)
> > +{
> > +	c->refill_nmi_list = in_nmi;
> 
> Should this be,
> 
> 	c->refill_nmi_list |= in_nmi;
> 
> this would resolve comment in unit_alloc? We don't want to clear it if
> we end up calling irq_work_raise from in_nmi and then in another
> context. It would be really hard to debug if the case is possible and
> a busy box just doesn't refill nmi enough.

Excellent catch. Yes. That's a bug.

> 
> > +	irq_work_queue(&c->refill_work);
> > +}
> > +
> > +static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>     [...]
> 
> > +
> > +/* notrace is necessary here and in other functions to make sure
> > + * bpf programs cannot attach to them and cause llist corruptions.
> > + */
> 
> Thanks for the comment.
> 
> > +static void notrace *unit_alloc(struct bpf_mem_cache *c)
> > +{
> > +	bool in_nmi = bpf_in_nmi();
> > +	struct llist_node *llnode;
> > +	unsigned long flags;
> > +	int cnt = 0;
> > +
> > +	if (unlikely(in_nmi)) {
> > +		llnode = llist_del_first(&c->free_llist_nmi);
> > +		if (llnode)
> > +			cnt = atomic_dec_return(&c->free_cnt_nmi);
> 
> Dumb question maybe its Friday afternoon. If we are in_nmi() and preempt
> disabled why do we need the atomic_dec_return()?

atomic instead of normal free_cnt_nmi-- ?
because it's nmi. The if(in_nmi) bits of unit_alloc can be reentrant.

> 
> > +	} else {
> > +		/* Disable irqs to prevent the following race:
> > +		 * bpf_prog_A
> > +		 *   bpf_mem_alloc
> > +		 *      preemption or irq -> bpf_prog_B
> > +		 *        bpf_mem_alloc
> > +		 */
> > +		local_irq_save(flags);
> > +		llnode = __llist_del_first(&c->free_llist);
> > +		if (llnode)
> > +			cnt = --c->free_cnt;
> > +		local_irq_restore(flags);
> > +	}
> > +	WARN_ON(cnt < 0);
> > +
> 
> Is this a problem?
> 
>   in_nmi = false
>   bpf_prog_A
>    bpf_mem_alloc
>    irq_restore
>    irq -> bpf_prog_B
>             bpf_mem_alloc
>                in_nmi = true
>                irq_work_raise(c, true)
>    irq_work_raise(c, false)
> 
> At somepoint later
>  
>    bpf_mem_refill()
>     refill_nmi_list <- false
> 
> The timing is tight but possible I suspect. See above simple fix would
> be to just | the refill_nim_list bool? We shouldn't be clearing it
> from a raise op.

Yes. refill_nmi_list |= in_nmi or similar is necessary.
This |= is not atomic, so just |= may not be good enough.
Probably something like this would be better:

if (in_nmi)
  c->refill_nmi_list = in_nmi;

so that irq_work_raise() will only set it
and bpf_mem_refill() will clear it.

> > +	if (cnt < LOW_WATERMARK)
> > +		irq_work_raise(c, in_nmi);
> > +	return llnode;
> > +}
> >
> 
> OK need to drop for now. Will pick up reviewing the rest later.

Thanks a lot for quick review! Looking forward to the rest.
There is still a ton of work to improve this algo:
- get rid of call_rcu in hash map
- get rid of atomic_inc/dec in hash map
- tune watermarks per allocation size
- adopt this approach alloc_percpu_gfp

The watermarks are hacky now. The batch of ~64 for large units feels wasteful.
Probably should be lover for any unit larger than 1k.
Also explicit bpf_mem_prealloc(... cnt ...) is needed, so that bpf prog
can preallocate 'cnt' elements from safe context. This would mean that
watermarks will be floating, so that bpf_mem_refill doesn't go and
immediately free_bulk after user requested prealloc.
