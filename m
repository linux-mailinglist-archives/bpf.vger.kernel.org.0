Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D971B55A5D0
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 03:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiFYBXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 21:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiFYBXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 21:23:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04D3AA6A
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:23:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a10so4352144ioe.9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/FCHavz2tt/1Cl6T6ARVGQ8GBxF+zFPDtUR7VPrACD4=;
        b=I5FsAtZOFHxnhJiUXc4/hlO51sKqNSFSi15U2+smkg0ccww8CWXdwXdkMxs6vzHQCP
         wuKtQJp5NqbbBSOpIinXap//l/Nk8LsCL9pzT23lNzkt/wjc6pXg/47xNZPFcXSN9m5r
         UJZqYPntmcQgjORywa7PP1Q3TUKT/Wp0D2x7XShZt4d9bEEOI74IuVCH/C0bjNlMcVqZ
         36p+NupjRWm0wNz1Q0eW/Pkm9nWyrfYtMMxCMkRw2O1vLVI9gqpcHrZXyNLFbSkLVtqZ
         ecOh6eiTnrdv1fNTba1LNIKnfV6/JoB3NZ6ebTJ728e3XQ2/aRGuErcidrcPn8OpB1AW
         E8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/FCHavz2tt/1Cl6T6ARVGQ8GBxF+zFPDtUR7VPrACD4=;
        b=NFMmWQ3pnT6U3EQxMhJWXbQsERam5EZMZJbFAZfvDnYQqHAchz9xRLAkjfp4p6Z5WO
         q0SSyYlv4UgPg0eNjTJmQ8vIXYiRn2XTb2QBlW4z8LgqltSKlYVxxtT7L7R/xIGBYzOU
         7GZcHYs8ByP9IufgqNEq7RRtF1a2SAgK4zh5jUVrp/TqNO9BoAcTu6xRjVPAknBvooax
         01cIk3i28MTD0fGalrsgj5M11Gj9W/koS14UqzwUz0Hu2l+1/bgCxcpPTOM1sLVFs7N+
         U1IrrxebLPsOQMR5C7an76mfL7FbRqkaD/+zZz74DkTDrOHAyXwBFdY2GQQN1Er+Am1F
         c2IQ==
X-Gm-Message-State: AJIora8dxog0BMQ0GqhZxNZ3e0dB3JUCB3Eer7xWUd+Fmn2MeMMFEB5B
        bPdI5WD8FLt4fondG/IDG17GSsEo+Rj9CQ==
X-Google-Smtp-Source: AGRyM1tVLoVKvdb38IizUlFdvXZw6NfTm8dLtN7JQMASUvhEpsMKCMKB7XL++aU/M2JWWPkUJ2En9w==
X-Received: by 2002:a02:a809:0:b0:339:e6ba:dee1 with SMTP id f9-20020a02a809000000b00339e6badee1mr1152543jaj.1.1656120214049;
        Fri, 24 Jun 2022 18:23:34 -0700 (PDT)
Received: from localhost ([172.243.153.43])
        by smtp.gmail.com with ESMTPSA id d18-20020a056602185200b00669e1a9588esm1913101ioi.43.2022.06.24.18.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 18:23:33 -0700 (PDT)
Date:   Fri, 24 Jun 2022 18:23:26 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Message-ID: <62b6638e4e0d1_347af208e3@john.notmuch>
In-Reply-To: <20220623003230.37497-2-alexei.starovoitov@gmail.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <20220623003230.37497-2-alexei.starovoitov@gmail.com>
Subject: RE: [PATCH bpf-next 1/5] bpf: Introduce any context BPF specific
 memory allocator.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> 
> Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> Refill this cache asynchronously from irq_work.
> 
> BPF programs always run with migration disabled.
> It's safe to allocate from cache of the current cpu with irqs disabled.
> Free-ing is always done into bucket of the current cpu as well.
> irq_work trims extra free elements from buckets with kfree
> and refills them with kmalloc, so global kmalloc logic takes care
> of freeing objects allocated by one cpu and freed on another.
> 
> struct bpf_mem_alloc supports two modes:
> - When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
>   This is typical bpf hash map use case when all elements have equal size.
> - When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
>   kmalloc/kfree. Max allocation size is 4096 in this case.
>   This is bpf_dynptr and bpf_kptr use case.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Some initial feedback but still looking over it. Figured it made more
sense to dump current thoughts then drop it this evening for Monday.

[...]

> +static int bpf_mem_cache_idx(size_t size)
    [...]

> +#define NUM_CACHES 11
> +
> +struct bpf_mem_cache {
> +	/* per-cpu list of free objects of size 'unit_size'.
> +	 * All accesses are done with preemption disabled
> +	 * with __llist_add() and __llist_del_first().
> +	 */
> +	struct llist_head free_llist;
> +
> +	/* NMI only free list.
> +	 * All accesses are NMI-safe llist_add() and llist_del_first().
> +	 *
> +	 * Each allocated object is either on free_llist or on free_llist_nmi.
> +	 * One cpu can allocate it from NMI by doing llist_del_first() from
> +	 * free_llist_nmi, while another might free it back from non-NMI by
> +	 * doing llist_add() into free_llist.
> +	 */
> +	struct llist_head free_llist_nmi;

stupid nit but newline here helps me read this.

> +	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
> +	 * element size.
> +	 */
> +	struct kmem_cache *kmem_cache;

> +	struct irq_work refill_work;
> +	struct mem_cgroup *memcg;
> +	int unit_size;
> +	/* count of objects in free_llist */
> +	int free_cnt;
> +	/* count of objects in free_llist_nmi */
> +	atomic_t free_cnt_nmi;
> +	/* flag to refill nmi list too */
> +	bool refill_nmi_list;
> +};

What about having two types one for fixed size cache and one for buckets?
The logic below gets a bunch of if cases with just the single type. OTOH
I messed around with it for a bit and then had to duplicate most of the
codes so I'm not sure its entirely a good idea, but the __alloc() with
the 'if this else that' sort of made me think of it.

> +
> +static struct llist_node notrace *__llist_del_first(struct llist_head *head)
     [...]

> +
> +#define BATCH 48
> +#define LOW_WATERMARK 32
> +#define HIGH_WATERMARK 96
> +/* Assuming the average number of elements per bucket is 64, when all buckets
> + * are used the total memory will be: 64*16*32 + 64*32*32 + 64*64*32 + ... +
> + * 64*4096*32 ~ 20Mbyte
> + */
> +
> +/* extra macro useful for testing by randomizing in_nmi condition */
> +#define bpf_in_nmi() in_nmi()
> +
> +static void *__alloc(struct bpf_mem_cache *c, int node)

For example with two types this mostly drops out. Of course then the callers
have to know the type so not sure. And you get two alloc_bulks and
so on. Its not obviously this works out well.

[...]

> +static void free_bulk_nmi(struct bpf_mem_cache *c)
> +{
> +	struct llist_node *llnode;
> +	int cnt;
> +
> +	do {
> +		llnode = llist_del_first(&c->free_llist_nmi);
> +		if (llnode)
> +			cnt = atomic_dec_return(&c->free_cnt_nmi);
> +		else
> +			cnt = 0;
> +		__free(c, llnode);
> +	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
> +}

Comment from irq_work_run_list,

	/*
	 * On PREEMPT_RT IRQ-work which is not marked as HARD will be processed
	 * in a per-CPU thread in preemptible context. Only the items which are
	 * marked as IRQ_WORK_HARD_IRQ will be processed in hardirq context.
	 */

Not an RT expert but I read this to mean in PREEMPT_RT case we can't assume
this is !preemptible? If I read correctly then is there a risk we get
two runners here? And by extension would need to worry about free_cnt
and friends getting corrupted.

> +
> +static void bpf_mem_refill(struct irq_work *work)
> +{
> +	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
> +	int cnt;
> +
> +	cnt = c->free_cnt;
> +	if (cnt < LOW_WATERMARK)
> +		/* irq_work runs on this cpu and kmalloc will allocate
> +		 * from the current numa node which is what we want here.
> +		 */
> +		alloc_bulk(c, BATCH, NUMA_NO_NODE);
> +	else if (cnt > HIGH_WATERMARK)
> +		free_bulk(c);
> +
> +	if (!c->refill_nmi_list)
> +		/* don't refill NMI specific freelist
> +		 * until alloc/free from NMI.
> +		 */
> +		return;
> +	cnt = atomic_read(&c->free_cnt_nmi);
> +	if (cnt < LOW_WATERMARK)
> +		alloc_bulk_nmi(c, BATCH, NUMA_NO_NODE);
> +	else if (cnt > HIGH_WATERMARK)
> +		free_bulk_nmi(c);
> +	c->refill_nmi_list = false;
> +}
> +
> +static void notrace irq_work_raise(struct bpf_mem_cache *c, bool in_nmi)
> +{
> +	c->refill_nmi_list = in_nmi;

Should this be,

	c->refill_nmi_list |= in_nmi;

this would resolve comment in unit_alloc? We don't want to clear it if
we end up calling irq_work_raise from in_nmi and then in another
context. It would be really hard to debug if the case is possible and
a busy box just doesn't refill nmi enough.

> +	irq_work_queue(&c->refill_work);
> +}
> +
> +static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
    [...]

> +
> +/* notrace is necessary here and in other functions to make sure
> + * bpf programs cannot attach to them and cause llist corruptions.
> + */

Thanks for the comment.

> +static void notrace *unit_alloc(struct bpf_mem_cache *c)
> +{
> +	bool in_nmi = bpf_in_nmi();
> +	struct llist_node *llnode;
> +	unsigned long flags;
> +	int cnt = 0;
> +
> +	if (unlikely(in_nmi)) {
> +		llnode = llist_del_first(&c->free_llist_nmi);
> +		if (llnode)
> +			cnt = atomic_dec_return(&c->free_cnt_nmi);

Dumb question maybe its Friday afternoon. If we are in_nmi() and preempt
disabled why do we need the atomic_dec_return()?

> +	} else {
> +		/* Disable irqs to prevent the following race:
> +		 * bpf_prog_A
> +		 *   bpf_mem_alloc
> +		 *      preemption or irq -> bpf_prog_B
> +		 *        bpf_mem_alloc
> +		 */
> +		local_irq_save(flags);
> +		llnode = __llist_del_first(&c->free_llist);
> +		if (llnode)
> +			cnt = --c->free_cnt;
> +		local_irq_restore(flags);
> +	}
> +	WARN_ON(cnt < 0);
> +

Is this a problem?

  in_nmi = false
  bpf_prog_A
   bpf_mem_alloc
   irq_restore
   irq -> bpf_prog_B
            bpf_mem_alloc
               in_nmi = true
               irq_work_raise(c, true)
   irq_work_raise(c, false)

At somepoint later
 
   bpf_mem_refill()
    refill_nmi_list <- false

The timing is tight but possible I suspect. See above simple fix would
be to just | the refill_nim_list bool? We shouldn't be clearing it
from a raise op.

> +	if (cnt < LOW_WATERMARK)
> +		irq_work_raise(c, in_nmi);
> +	return llnode;
> +}
>

OK need to drop for now. Will pick up reviewing the rest later.
