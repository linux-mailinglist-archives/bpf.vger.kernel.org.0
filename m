Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60913508F63
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiDTSbC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381470AbiDTSbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 14:31:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03351EEC9;
        Wed, 20 Apr 2022 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T1t1cTSum3OzRMUjY8k+SNYpptc4cLa0jL7we78Ggyc=; b=GEPlYe+XYe3dHkUmdDio8B/BN6
        +ikXU0KkvaMRv/XNsGUpfWuxTFJ76oGWO9rpd1tdhAehY5Qgwqgc7vAnYetBB2n0yIv3BYnjZuZU5
        1eau5eyzqsO/Uif2KnpsaYjX/GJpAXn9zTK0f7ICSyOjlpY9r5mbjcvYzTDV8AdNKUxOAR28F+NJ8
        tkg++xBYRcoMum3dt+K8yUA2PHrM3AVGXApvXYuk3c4KKLTI1E/ZZKtUP966BuR/ZIw07vJMEcdNn
        2I3ZKzlzm+vBj4/WdA4aol5LzvRLUCCstV8r6Ev9CBBKTUh5g5SWYsCRA8YFCaEqL7OQViSSnjYfI
        ksG5l2ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhF3f-00A38V-Ql; Wed, 20 Apr 2022 18:28:07 +0000
Date:   Wed, 20 Apr 2022 11:28:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <YmBQt1RjDY1hGQlJ@bombadil.infradead.org>
References: <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com>
 <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com>
 <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
 <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
 <3F75142B-3E87-4195-A026-3A7F1E595960@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F75142B-3E87-4195-A026-3A7F1E595960@fb.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 20, 2022 at 02:42:37PM +0000, Song Liu wrote:
> For (b), we have seen direct map fragmentation causing visible
> performance drop for our major services. This is the shadow 
> production benchmark, so it is not possible to run it out of 
> our data centers. Tracing showed that BPF program was the top 
> trigger of these direct map splits. 

It's often not easy to reproduce issues like these, but I've
ran into that before for other Proof of Concept issues before
and the solution has been a Linux selftest. For instance a
"multithreaded" bombing for kmod can be triggered with
lib/test_kmod.c and tools/testing/selftests/kmod/kmod.sh

Would desinging a selftest to abuse eBPF JIT be a possible
way to reproduce the issue?

  Luis
