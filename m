Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65152F750
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 03:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354321AbiEUBVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354320AbiEUBVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 21:21:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD223F589;
        Fri, 20 May 2022 18:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aLneGAaicP7hJgLs7K/60mukpOwB1SE1HTp33RQdMZQ=; b=YNnS5d8zRhoTzc1eQrHEqej/2F
        uVR0V63Dhw61OSkUKQFZRgkIAJ0a4ikH2bZnBElWAoFR7xsCp5b6b2EVkpTmhqahUiigxiEJCU8W8
        ygeuv8STRXY8QgwPHvdwu/eLe5mHIJPWjUGiLID/KuQVBeEHOWfKMPs/M5n0zDPguIi7/iR/evOfd
        GRl1XxGTr+een5l5ie/9FWjkLVH3Q8PWIEYbCxUzXL2cIzHe2SoOHlkorxnuxLG83Dw8UmFNdN+gp
        lWQJlJcW7r9+sRWL2/FygwFkb8rxZU+9wXfvSQlMboTeawcnLq16mBJmdK5D/EwDcaW6ofHQ3RSxb
        mf2dyGLg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsDnb-00F7xk-M2; Sat, 21 May 2022 01:20:55 +0000
Date:   Fri, 20 May 2022 18:20:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, torvalds@linux-foundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Message-ID: <Yog+d+oR5TtPp2cs@bombadil.infradead.org>
References: <20220520031548.338934-1-song@kernel.org>
 <20220520031548.338934-6-song@kernel.org>
 <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 06:00:57PM -0700, Luis Chamberlain wrote:
> On Thu, May 19, 2022 at 08:15:45PM -0700, Song Liu wrote:
> > Use module_alloc_huge for bpf_prog_pack so that BPF programs sit on
> > PMD_SIZE pages. This benefits system performance by reducing iTLB miss
> > rate. Benchmark of a real web service workload shows this change gives
> > another ~0.2% performance boost on top of PAGE_SIZE bpf_prog_pack
> > (which improve system throughput by ~0.5%).

Also, seems like a is a missed opportunity to show iTLB misses with more
detail. If there was a selftest to stress bpf JIT you could use perf and
enable anyone to quanitfy gains. Dave hinted with some ideas with perf:

perf stat -e cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/ some_bpf_jit_test

  Luis
