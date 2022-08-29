Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89555A5779
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH2XNZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 19:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2XNZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 19:13:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1166870A2
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:13:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t5so11986622edc.11
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=njl0hWSY2+DW45dmIHbGPxljycPGJABcIq0tfVBCbMI=;
        b=Gnzy/mJwzthlINXOBQKY8FxcmdfyK7QcqhL4O1eg5+EhbXGhJGkLI1Tw5eD7JU4ljj
         yc2fbolKCzjd4Ozhybkt27M0vkJmYOyLqZEZMEF2zgwpkjg1pBVmOhInnFiO8M18/AVq
         JUL0iI/MwooUDt92Gmx3ap2lfLmTbgOOI8QIhdRjEBAWCePGvSFeSE0f1WMCqFS3ECE3
         M4wi/p9Hi9rNsZU3k9P6B0Gab0DQT25T1GJ28PWGxhiXYi/wrWjj7nu+ozlJw2Twi9jw
         h611M9uEasV8WD6gKoD3eunzhRU+4OWLyUh90D6AGo6FItLb0PWpldVPa97MF9vSNoCC
         JyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=njl0hWSY2+DW45dmIHbGPxljycPGJABcIq0tfVBCbMI=;
        b=PH4o9Q6BMVJKSsR9qzsDcM45Wu9o7kHNYzRrsrwiIFM8858eWBzmJD8NFUxL07UveM
         4yDaXifLGSMd8hnMu9rov1ylB0/w070I5x6tM2XyfcepJ7alNErD85ICkIFHRdF+CJ+G
         heqtJjwFiBfjO8DymFHjiERp4wROVgYXyPNqnzRBzGljRO6i2lzHcLVJfQBpBIIiApdy
         myBlta+djNYMmVdZw7XK0W/qH+szsKdeTQGukoiDkf9y1h1qkHEDDdg7uS/ZvUlaWZ+d
         acPl1aPa6em59nIHyaGkwWF/NF8au2IpgYCV0cZPUwbwMaqHqqPWylksFZv1K3/gVPUQ
         7VDQ==
X-Gm-Message-State: ACgBeo1M9bxFgOMaNYkFwqT+D64VNyn2xMXob4dlW1fk6UE7byFxoieh
        TyHKCwUH+3hHTMT69jAa8H7bPLgB64Lp+llTifE=
X-Google-Smtp-Source: AA6agR4ldAz9I8cYfaVXak/8efOQwhZm9GnOVtPe+ix16DZOieVh02KAn3zJquhtnJO/viWxLjG7ZPDivFnGuIbQRUw=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr18364924edb.333.1661814802401; Mon, 29
 Aug 2022 16:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com> <20220829223946.vfu4hi64ybitvt27@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQLR4nBvJ0RpEdcGF1MFOW=MmA5xicofCyt8sP_AHMzAsA@mail.gmail.com> <CAP01T76qn=+WZ3jVb=ue=+Zf5FyKbdQy0b9KxExzK9SN_4DeBA@mail.gmail.com>
In-Reply-To: <CAP01T76qn=+WZ3jVb=ue=+Zf5FyKbdQy0b9KxExzK9SN_4DeBA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 16:13:11 -0700
Message-ID: <CAADnVQ+JU_r=Xord1SqD2NJuVmoyaVtP0RbHGgAJwUDvK1G=xw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 4:00 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 30 Aug 2022 at 00:43, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 3:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 07:44:16PM -0700, Alexei Starovoitov wrote:
> > > > +/* Mostly runs from irq_work except __init phase. */
> > > > +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> > > > +{
> > > > +     struct mem_cgroup *memcg = NULL, *old_memcg;
> > > > +     unsigned long flags;
> > > > +     void *obj;
> > > > +     int i;
> > > > +
> > > > +     memcg = get_memcg(c);
> > > > +     old_memcg = set_active_memcg(memcg);
> > > > +     for (i = 0; i < cnt; i++) {
> > > > +             obj = __alloc(c, node);
> > > > +             if (!obj)
> > > > +                     break;
> > > > +             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > +                     /* In RT irq_work runs in per-cpu kthread, so disable
> > > > +                      * interrupts to avoid preemption and interrupts and
> > > > +                      * reduce the chance of bpf prog executing on this cpu
> > > > +                      * when active counter is busy.
> > > > +                      */
> > > > +                     local_irq_save(flags);
> > > > +             if (local_inc_return(&c->active) == 1) {
> > > Is it because it is always '== 1' here so that there is
> > > no need to free the obj when it is '!= 1' ?
> >
> > Great catch. It's a bug indeed.
>
> Is it a bug? It seems it will always be true for alloc_bulk. IIUC it
> is only needed to prevent NMI's unit_alloc, unit_free touching
> free_llist, so that NMI llist_adds atomically to free_llist_nmi
> instead. Since this runs from irq_work, we run exclusive to other
> unit_free, otherwise the __llist_add wouldn't be safe either.
> unit_free already does local_irq_save.

Correct. It cannot happen in practice, but the code as written
will look 'buggy' to any static analyzer. So we have to 'fix' it.
I'm thinking to do:
WARN_ON_ONCE(local_inc_return(&c->active) != 1);
and the same in free_bulk.
