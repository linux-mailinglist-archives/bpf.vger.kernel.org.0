Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D15E9BE1
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 10:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiIZIVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiIZIVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 04:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31641BE9E;
        Mon, 26 Sep 2022 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HP+NBtK01Xvhurj9YwQq7BAK/FHuyCvTkrH6hj5jx/E=; b=JWLVW8/61gZmddQzT9cn8bfyY7
        grCdQMS7/7KjdCvd28dtoU2eUymCvC2ldg+62KJ4HMXqf2CngSKPr5nttbTcAyEqi8kD4odTziWRd
        k+77IdPoTTBXRtpajfsq+xdG2H9P9amQaqVHGBFAbVTd9IoMci33tlGQCxVH1vEfvcXRyNQ5XnjCr
        CYR89HjdSyva8keWdlDYgJlpCmqVRipO5KZVs9HSMzOH9AfJC67HauG+x2/PF/kd1CO8h9hXMDOSk
        h2CEw9A0cKcqztQyxNdcl1mtqU5+0bnfyZBrrNWpL5kCeo82LPqiOCo/QiSNC+rGECTWJTQ3ZOE7i
        8Xe4w/2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocjMI-00AGfg-DE; Mon, 26 Sep 2022 08:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09DB3300023;
        Mon, 26 Sep 2022 10:20:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7BE820E5FD5C; Mon, 26 Sep 2022 10:20:52 +0200 (CEST)
Date:   Mon, 26 Sep 2022 10:20:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <YzFg5EGV35NxhHOo@hirez.programming.kicks-ass.net>
References: <00000000000076f3a305e97e9229@google.com>
 <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
 <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 02:55:46PM -0700, Alexei Starovoitov wrote:

> Steven Rostedt noticed that comment around the middle of August
> and told you and Peter about it.

He did indeed; and I was thinking he'd told you about it too so you
could fix, what is a very juicy security issue, ASAP.

> Then Peter added a WARN_ONCE in commit
> https://lore.kernel.org/all/YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net/
> to explicitly trigger that known issue.

Well, I had sincerely hoped you'd fixed it by now. You just don't let
things like that slide. Note how I didn't post that mostly trivial patch
in mid August. Giving you ample time to fix up.

> Now we're trying to urgently address it with:
> https://lore.kernel.org/bpf/20220923211837.3044723-1-song@kernel.org/

Glad to see it being fixed. Thanks!
