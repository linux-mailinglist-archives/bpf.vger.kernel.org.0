Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9678569118
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiGFRuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGFRuj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:50:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEE56459
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:50:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z1so8453295plb.1
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fe8Q2UUclVbaN//xksGPDN/FPyfgVOHDsw8MqncmWZI=;
        b=b64OOiZgE7soHHxKtHffWVVok+++6eFqAB4q3hQg/lBq6l3Ze4xIzBmHXBfXGlapPo
         rAVd6oCLfVL1xn4G9uoaVxKWNls/ZU17uJv4uvQ7/ePWexOOLaJJMEwjbtZp9wRmEWLl
         g8RtOy58ardTZRwpWyfrp/h+VlC6o/51LJwMGnJItVY+pKArdzMj9CtxjGSOi0eXHF5l
         TbMclnjUxiuyLScwlRLpNxv60d6NNcMKaTwtfDteJ/c51mchlHPT6SfSB0KcZMmtwpNl
         a17iaWCJpDTOMbOVcfhG9EqlR0U3sBq0KQZB5/Id86eDWWSX7k+3pIX2Fq0gXhts6KCZ
         K+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fe8Q2UUclVbaN//xksGPDN/FPyfgVOHDsw8MqncmWZI=;
        b=oSkQY5FQ698DI4KydY7XLQ6+jKQtbRpeUZPHZHp+tr/bEjVZvPKgOnNAwiIXE5UA39
         A2zvamEAzgFLZk2syi3ubh5RqdQ0Lyr5+5qmNSCfdKZ8qx6LHZB64Zh3kifOROMAxor2
         wY1Is2TQFVlzvPDbfYRxJs3XGQzHMd/oHkOOZGMQvHJVyMPd3wv4wNuUF40lVRx7Y614
         jGdcWJktTI3Sgy89ygnyjo/wdsyXCZYJKoeG+BUTStbOEwtFwTLzkMD8CT5xTszZ1hlN
         vmE9F8doRDvU5AYQ1VvBL5IJ2sVPKCztwdmoUj23PJvcOv33P5TuS8SY9sWO7kzibxwm
         giaQ==
X-Gm-Message-State: AJIora+JT2NR6ymmU/1B9lvtLEvLAD5493ZV4L7SGXzMHC0XbYvVsPSx
        N9DqRKesHKoHcFNhJ1i7JrU=
X-Google-Smtp-Source: AGRyM1s+iahg02Bpk2EnSzbzRcnr2mtDT4ApnSHUmAQAgW6yLoAtrRkD328H3ucsSETDujo2et3RxQ==
X-Received: by 2002:a17:90a:fa05:b0:1ef:89d1:1255 with SMTP id cm5-20020a17090afa0500b001ef89d11255mr20275204pjb.73.1657129837984;
        Wed, 06 Jul 2022 10:50:37 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:8597])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b00524f29903e0sm25048734pfu.56.2022.07.06.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:50:37 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:50:34 -0700
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
Message-ID: <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsNOzwNztBsBcv7Q@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 04, 2022 at 09:34:23PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 27, 2022 at 12:03:08AM -0700, Christoph Hellwig wrote:
> > I'd suggest you discuss you needs with the slab mainainers and the mm
> > community firs.
> > 
> > On Wed, Jun 22, 2022 at 05:32:25PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > > 
> > > Introduce any context BPF specific memory allocator.
> > > 
> > > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > > run in unknown context where calling plain kmalloc() might not be safe.
> > > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > > Refill this cache asynchronously from irq_work.
> 
> I can't tell from your description whether a bump allocator would work
> for you.  That is, can you tell which allocations need to persist past
> program execution (and use kmalloc for them) and which can be freed as
> soon as the program has finished (and can use the bump allocator)?
> 
> If so, we already have one for you, the page_frag allocator
> (Documentation/vm/page_frags.rst).  It might need to be extended to meet
> your needs, but it's certainly faster than the kmalloc allocator.

Already looked at it, and into mempool, and everything we could find.
All 'normal' allocators sooner or later synchornously call into page_alloc,
kasan, memleak and other debugging facilites that grab locks which
make them unusable for bpf tracing progs.
The main difference of bpf specific alloc vs the rest is bpf_mem_alloc from
the cache and refill of the cache are two asynchronous operations.
It allows the former to be reentrant and nmi safe.

The speed of bpf mem alloc is secondary here.
The lock less free list is there to absorb async refill.
irq_work_queue is not instant while bpf prog might do several bpf_mem_alloc
before irq_work has a chance to refill.
We're thinking about self adjusting low/high watermarks that will be tunned by
the bpf verifier that has visibility into what program is going to do.
