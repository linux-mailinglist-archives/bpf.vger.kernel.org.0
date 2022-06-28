Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2655C989
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiF1FBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 01:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiF1FBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 01:01:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7025C6C
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 22:01:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e2so15882039edv.3
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvXt0QKxGokC5Mv5jnCy49Hq+RV9N+QKHjY/AgslfQE=;
        b=Xvm/SGALCa2V/HdfC6/6G39xodSBynsjWfTEbvBnVzAklKNHzg6cl1Kg0cP/c1cmY9
         1QNgFL6sYK0KuRb7f7sKB0gbNFX1mxNl4Md3OMpJYbiiM+TjHhmkSubdZb+PWlTLsHRN
         VeaWNzlaYqSmgGQm88PZfNsQ1ANpXcUe5Lo9sxlTg/Stnqyz7PwxP4eAjOEwRCi8TYCL
         pcLxt3PpZVu4txlRD07gUsKZqiXSMXEhxuuFoom3oJI4j31ojni4FHFNTWKKEY+miQw0
         bvQakJyU1WBjogLnAA1osAAC6ZquqiKn+gojy7v9L6ZQWmGASDuoJ5EgYL/6oQXEIqJP
         MJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvXt0QKxGokC5Mv5jnCy49Hq+RV9N+QKHjY/AgslfQE=;
        b=EApYb6yic7O4eisfPTFCp7yy98gtd/zsGYn2qsE4LxtAvb/eYK0t1sVqd1e8TGKv6Z
         wAfo0oiLrfrk08VzQlvgYRRhHhMuuQl+krLLlF0JCw+JkCBchLK+BCXERflVR3TjE51M
         DFBJuy/W6Wle+l4D+8ILQisf9D7N7Wdt/lCVj2cTYgM5jIkhNfjnEv8Ig7+pH0JN5RCO
         Znz5zQMPMXjiOEzIuwNe3lIDXKs6f7/dftZV2QOpLDxpujNMP993cnqCibjSDy5w0zAV
         91+zpbzrCH8i0hnptMPcoC4WRGQurZR+0vB6nZOngD6ShDgj+H4ull+N7deNpon6gHgx
         qQnA==
X-Gm-Message-State: AJIora9aDzzcd506Idjvn261fzVdX4Z3Zn5tO0IV7HguHZwrhVoJRnjS
        uQBJ9XI5H5kJewxq3cIn6FH5wcsec3V9EX8wAh8=
X-Google-Smtp-Source: AGRyM1uzGh02quBk6k30rlvaoPSJftfTLX/CfrRCsVhdFDBzATRxnh9qlS6Inu2A13e+rniWlY8iJB0dTEuu7t+deks=
X-Received: by 2002:a05:6402:2398:b0:435:9685:1581 with SMTP id
 j24-20020a056402239800b0043596851581mr20821978eda.333.1656392493970; Mon, 27
 Jun 2022 22:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <YrlWLLDdvDlH0C6J@infradead.org> <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Jun 2022 22:01:22 -0700
Message-ID: <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Jun 27, 2022 at 5:17 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce any context BPF specific memory allocator.
> >
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> > Front-end kmalloc() with per-cpu per-bucket cache of free elements.
> > Refill this cache asynchronously from irq_work.
>
> GFP_ATOMIC etc is not going to work for you?

slab_alloc_node->slab_alloc->local_lock_irqsave
kprobe -> bpf prog -> slab_alloc_node -> deadlock.
In other words, the slow path of slab allocator takes locks.
Which makes it unsafe to use from tracing bpf progs.
That's why we preallocated all elements in bpf maps,
so there are no calls to mm or rcu logic.
bpf specific allocator cannot use locks at all.
try_lock approach could have been used in alloc path,
but free path cannot fail with try_lock.
Hence the algorithm in this patch is purely lockless.
bpf prog can attach to spin_unlock_irqrestore and
safely do bpf_mem_alloc.
