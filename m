Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324D5E9BF0
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiIZIZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiIZIZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 04:25:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B56275D2;
        Mon, 26 Sep 2022 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J3tAO2GNJfTSgPUz6jLVcZhE4ZFSDnZgvEP1SbbHM5U=; b=lczrBNMZKticzvhKLcK5KSJSVG
        ZUPEc8xvEABLdjL1A82AG/orBsHEmNuNvpBTjFNJ72+9JxLUo60kvw3urmn1R+cDFpz781NBLFFAn
        JnOo9NfQudVIORQVFgh1NGBSwZIrXQ3rMamsS8CqayJh2cKGV7glk5EIznvVyaigTb4QhOARH9gBP
        2C6Ha1kHm9t1t59QwD6JqHoRslqUUm64V7P6GMe8+4TuWCT5iuVLsQp04n/wVyInt5NvdWV6aKUcG
        imbyk6n0sNY9BKfkTkAUn0GFGbZdHOL4j90T4TAL3EtyFmYapWfZhFvule/L2Jvc4RB4e8uK5aSs7
        L/0H2JQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocjPu-00FzCf-4R; Mon, 26 Sep 2022 08:24:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55F8430007E;
        Mon, 26 Sep 2022 10:24:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DA2D20E5FD5C; Mon, 26 Sep 2022 10:24:41 +0200 (CEST)
Date:   Mon, 26 Sep 2022 10:24:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board@lists.linuxfoundation.org,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Borislav Petkov <bp@alien8.de>, brijesh.singh@amd.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jane.chu@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, seanjc@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
Message-ID: <YzFhyd3LDdDFtP6l@hirez.programming.kicks-ass.net>
References: <00000000000076f3a305e97e9229@google.com>
 <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
 <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
 <a2673df8-cf8a-b94a-68cd-1e2777fb5cf4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2673df8-cf8a-b94a-68cd-1e2777fb5cf4@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 05:10:19PM -0700, Dave Hansen wrote:

> Peter, I remember an earlier version of your patch having some various
> enforcement modes.  Since the strict enforcement has actually broken a
> few things, should we resurrect the nicer soft detection mode?  Or,
> maybe make the soft one the only mode for now?

Well, I think we'll have to disable the whole thing for i386, but I'm
sincerely hoping this is the only one we'll hit on x86_64 -- I did spend
some effort fixing W^X issues a while back.

