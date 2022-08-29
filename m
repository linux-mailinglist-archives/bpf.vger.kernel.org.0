Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18D5A56AE
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiH2WEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiH2WEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:04:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF205FD5
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:04:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u9so18482191ejy.5
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+2/tWyBw6EVMqKBP1tkDJvkirD5YivPxkiDFhJQgs4A=;
        b=bZp3gJokNF9bgWgaI4KskhgWjxm0VdRObygQVbSrormhUrj/tr+eehO8xLm9qgLk26
         uQXFp8g7vJ13vK10SD9xPHYouCvp+bM8G8yqYqi/k6hsM861bEGbdbsH+dY67T3ihqVK
         8o/YWWikLhlokvbO+SqkLpwhReS6UinOHudtvHw2+u7K4uD58SlO3ZeiyD5ZhAQKRPF2
         KmLl1JMGP0FyP8KzxLRjP19hxTGqDM5kw4WUy4qgZgopM+oxFBANQ1vfCM9MU4GDKTmj
         g6J+wojQ78Tyb+U+bKn1g/GyvkaY0BjBVYDT2lLiQiMYuMrtLkTJB0xkiCj9iKm8DuOV
         VzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+2/tWyBw6EVMqKBP1tkDJvkirD5YivPxkiDFhJQgs4A=;
        b=VFF9B6Cezrub5F6GeYmmQUUXDePfM8hFFmXeJPBccImaOZD0vJXJScYzRmoEp+4sEn
         HYN44JehEnAyA/Icr0alGsJnn2CiiCLznBIqG3GvjIPsrVNYQDt6UYP2XirK5FQcSyFr
         UucemMN6RTIuRO24C+iXGUT4ZhP1ic/0GNU7ULRmSY0cX36Qlle6glDIYJA09seuVULG
         sLxrCy/RIm7LBfGalEZLklzKBXRuHUpHC5jIcJJ137aAw+HM7Vp/S65nZItqF5WoOcH2
         PbRBHjmBRZ5ey982EeCVvUpU/0TkXCHWKUUYnApoLxkSHjw3bbhoSQWI6Lqko3jww94V
         5SLQ==
X-Gm-Message-State: ACgBeo0AiMwweBkW9oncNTyhBK86YNenkP74IgZOBUKDVWwkOKkF8xix
        bbvqM+lxJ3Xw7Kh6iVWepI9iae8EeizES7La5lw=
X-Google-Smtp-Source: AA6agR52sLcptiwhGO0QXHf/Z8uAvyU2Q2cwPmarb6cdc2UaEB1nJa6crwc1RzYSPV9zIVYi0y00eWprJ/KrYKAW3KY=
X-Received: by 2002:a17:906:847c:b0:73f:d7cf:bf2d with SMTP id
 hx28-20020a170906847c00b0073fd7cfbf2dmr11239757ejc.327.1661810690559; Mon, 29
 Aug 2022 15:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com> <181cb6ae-9d98-8986-4419-5013662b0189@iogearbox.net>
In-Reply-To: <181cb6ae-9d98-8986-4419-5013662b0189@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 15:04:39 -0700
Message-ID: <CAADnVQK4dwF+7O0b8i+xDyAKCHCKTJqZVStAxwcPMVNW1SDn7Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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

On Mon, Aug 29, 2022 at 2:59 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs can attach to kprobe and fentry. Hence they
> > run in unknown context where calling plain kmalloc() might not be safe.
> >
> > Front-end kmalloc() with minimal per-cpu cache of free elements.
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
> >    This is typical bpf hash map use case when all elements have equal size.
> > - When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
> >    kmalloc/kfree. Max allocation size is 4096 in this case.
> >    This is bpf_dynptr and bpf_kptr use case.
> >
> > bpf_mem_alloc/bpf_mem_free are bpf specific 'wrappers' of kmalloc/kfree.
> > bpf_mem_cache_alloc/bpf_mem_cache_free are 'wrappers' of kmem_cache_alloc/kmem_cache_free.
> >
> > The allocators are NMI-safe from bpf programs only. They are not NMI-safe in general.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   include/linux/bpf_mem_alloc.h |  26 ++
> >   kernel/bpf/Makefile           |   2 +-
> >   kernel/bpf/memalloc.c         | 476 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 503 insertions(+), 1 deletion(-)
> >   create mode 100644 include/linux/bpf_mem_alloc.h
> >   create mode 100644 kernel/bpf/memalloc.c
> >
> [...]
> > +#define NUM_CACHES 11
> > +
> > +struct bpf_mem_cache {
> > +     /* per-cpu list of free objects of size 'unit_size'.
> > +      * All accesses are done with interrupts disabled and 'active' counter
> > +      * protection with __llist_add() and __llist_del_first().
> > +      */
> > +     struct llist_head free_llist;
> > +     local_t active;
> > +
> > +     /* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill
> > +      * are sequenced by per-cpu 'active' counter. But unit_free() cannot
> > +      * fail. When 'active' is busy the unit_free() will add an object to
> > +      * free_llist_extra.
> > +      */
> > +     struct llist_head free_llist_extra;
> > +
> > +     /* kmem_cache != NULL when bpf_mem_alloc was created for specific
> > +      * element size.
> > +      */
> > +     struct kmem_cache *kmem_cache;
> > +     struct irq_work refill_work;
> > +     struct obj_cgroup *objcg;
> > +     int unit_size;
> > +     /* count of objects in free_llist */
> > +     int free_cnt;
> > +};
> > +
> > +struct bpf_mem_caches {
> > +     struct bpf_mem_cache cache[NUM_CACHES];
> > +};
> > +
>
> Could we now also completely get rid of the current map prealloc infra (pcpu_freelist*
> I mean), and replace it with above variant altogether? Would be nice to make it work
> for this case, too, and then get rid of percpu_freelist.{h,c} .. it's essentially a
> superset wrt functionality iiuc?

Eventually it would be possible to get rid of prealloc logic completely,
but not so fast. LRU map needs to be converted first.
Then a lot of production testing is necessary to gain confidence
and make sure we didn't miss any corner cases.
