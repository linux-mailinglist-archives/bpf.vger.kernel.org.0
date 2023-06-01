Return-Path: <bpf+bounces-1618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1571F183
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 20:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB2F1C20AE4
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93648253;
	Thu,  1 Jun 2023 18:17:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BB47017
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 18:17:49 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766A123
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 11:17:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ae61354fbso1128394f8f.3
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685643466; x=1688235466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjYyzWfNQ03fbFE4AhIA4o7qqD+5Z759JZfJx9S6FJo=;
        b=ZfBwkShB9CSovA01HYc6RcJyQJJYD0mqL2AlHuvbX1uqolwrxzeE4XPt/zKJjFW49x
         f4PKzl4e88cTQ7UNqoQTBqxxizVgR+gXxM0cNHcaG4bPhKiUFNZE4AAz5l4eRoYScc+N
         ESFAeRXZtP+K8elawVgLpmuS1QL6ayVcjwaXkbZMuN/xfL2tPADn8wXozzM0gE7omr97
         flrolwYm1lloNvwnAPPObQ81KsdI3+4wLKY5MvPc+9TilEJ0IYJdCqPWbgF8JLKFZDl/
         g1FItjOIrUFgh48kZxHR6dbWD58Ufl9dHWFTAE4sk9nV2sZ9f7gtcHRewQHjCd/L/r1E
         SA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643466; x=1688235466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjYyzWfNQ03fbFE4AhIA4o7qqD+5Z759JZfJx9S6FJo=;
        b=Ri8Cqvs2KKmWPrzC8jb+3gyXH4DemD6cWz26PErKAU6q3mwIRTj0LarWt14d3Detls
         nGhSPooqWG4oW6eDF07pzA0+OgXKGhjYBHINlJvXYS7SwUWs3+v9hN8pb2vdrwdTQa9N
         y7atuD9aztmcESmcg3zH9/KlNlI4Xaf3LT8ETsZhFCkzdSJWzVaav/e8Hi3AJhDRqgTz
         YZ9+l1YjppAO0k/Wt/y/v2u+C7EDKlIdJ2lGEt2pbGKANY61xoxMg1YdeAAfefGyKZOv
         hZZBOhV9FP8RqV9ZH2Lh3A5NEjfXUWlrSjni+Srd6U6rcrFappCtw/LAkAOv6C9H7DT5
         Td9w==
X-Gm-Message-State: AC+VfDzm1ah3n9AIiYbspvnHKH7VqNMeuev57yRSSQvqhCzWAY+F0IgY
	XcTIFpqjAhzz5G2CQriSPd4ZGg==
X-Google-Smtp-Source: ACHHUZ4ppsokjzZAqY5YgJTj62Wvebv3lbE/3M3U7GOwSfbwiH0IpUOV8k7KdQmKWTrjYZa57jP+rA==
X-Received: by 2002:a5d:490f:0:b0:306:2c16:8359 with SMTP id x15-20020a5d490f000000b003062c168359mr2685199wrq.39.1685643466702;
        Thu, 01 Jun 2023 11:17:46 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b003063772a55bsm10871771wrv.61.2023.06.01.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:17:46 -0700 (PDT)
Date: Thu, 1 Jun 2023 18:18:44 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 01, 2023 at 09:39:43AM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 1, 2023 at 12:30 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Wed, May 31, 2023 at 11:24:29AM -0700, Alexei Starovoitov wrote:
> > > On Wed, May 31, 2023 at 11:05:10AM +0000, Anton Protopopov wrote:
> > > >  static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
> > > >  {
> > > >     htab_put_fd_value(htab, l);
> > > >
> > > > +   dec_elem_count(htab);
> > > > +
> > > >     if (htab_is_prealloc(htab)) {
> > > >             check_and_free_fields(htab, l);
> > > >             __pcpu_freelist_push(&htab->freelist, &l->fnode);
> > > >     } else {
> > > > -           dec_elem_count(htab);
> > > >             htab_elem_free(htab, l);
> > > >     }
> > > >  }
> > > > @@ -1006,6 +1024,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
> > > >                     if (!l)
> > > >                             return ERR_PTR(-E2BIG);
> > > >                     l_new = container_of(l, struct htab_elem, fnode);
> > > > +                   inc_elem_count(htab);
> > >
> > > The current use_percpu_counter heuristic is far from perfect. It works for some cases,
> > > but will surely get bad as the comment next to PERCPU_COUNTER_BATCH is trying to say.
> > > Hence, there is a big performance risk doing inc/dec everywhere.
> > > Hence, this is a nack: we cannot decrease performance of various maps for few folks
> > > who want to see map stats.
> >
> > This patch adds some inc/dec only for preallocated hashtabs and doesn't change
> > code for BPF_F_NO_PREALLOC (they already do incs/decs where needed). And for
> > preallocated hashtabs we don't need to compare counters,
> 
> exactly. that's why I don't like to add inc/dec that serves no purpose
> other than stats.
> 
> > so a raw (non-batch)
> > percpu counter may be used for this case.
> 
> and you can do it inside your own bpf prog.
> 
> > > If you want to see "pressure", please switch cilium to use bpf_mem_alloc htab and
> > > use tracing style direct 'struct bpf_htab' access like progs/map_ptr_kern.c is demonstrating.
> > > No kernel patches needed.
> > > Then bpf_prog_run such tracing prog and read all internal map info.
> > > It's less convenient that exposing things in uapi, but not being uapi is the point.
> >
> > Thanks for the pointers, this makes sense. However, this doesn't work for LRU
> > which is always pre-allocated. Would it be ok if we add non-batch percpu
> > counter for !BPF_F_NO_PREALLOC case and won't expose it directly to userspace?
> 
> LRU logic doesn't kick in until the map is full.

In fact, it can: a reproducable example is in the self-test from this patch
series. In the test N threads try to insert random values for keys 1..3000
simultaneously. As the result, the map may contain any number of elements,
typically 100 to 1000 (never full 3000, which is also less than the map size).
So a user can't really even closely estimate the number of elements in the LRU
map based on the number of updates (with unique keys). A per-cpu counter
inc/dec'ed from the kernel side would solve this.

> If your LRU map is not full you shouldn't be using LRU in the first place.

This makes sense, yes, especially that LRU evictions may happen randomly,
without a map being full. I will step back with this patch until we investigate
if we can replace LRUs with hashes.

Thanks for the comments!

