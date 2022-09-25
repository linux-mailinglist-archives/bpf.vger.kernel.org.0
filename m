Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABA5E96DF
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIYXS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiIYXS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 19:18:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699723143;
        Sun, 25 Sep 2022 16:18:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28PNGrMT001745
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Sep 2022 19:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664147821; bh=da9jQuNWBOYtDW1IPt/q34HmRXLfvRq67qaZEcnXCxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gECWnrIo9+3OSV3jvVy6YC/pGxCUN9+n3Q6/Nhdz1ch35b1yrJCauKZ9YZEPLczzT
         CgTtpjSxw3gB+CT0BOukaNmBoxSgn0vqg+PkRxZko1LDhzZM4+UcNJ0XCpgcEtqaHS
         UPdtE04CEsR4coBh9hUG9QyZ4KlVISnK+FaPQjpPcxdGYVtykpEQ/zRLKTJbpn55JS
         3v+PeB3JsRQQ5b9CkqgkcTby+iq4+/nRivIsiHef/V2CwWF8vOG3efqQSW1TZ3S/nc
         TfALy+UHv5h8ytrvS9zU65/JQUHXb+X5PoRgCNH6OhzNyc7JQ4P7ayWZq8G71QAvnt
         +LMD6dWnWhnVQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD2E015C5274; Sun, 25 Sep 2022 19:16:53 -0400 (EDT)
Date:   Sun, 25 Sep 2022 19:16:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, seanjc@google.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Subject: Re: [syzbot] WARNING in __change_page_attr_set_clr
Message-ID: <YzDhZSsf82RekI+n@mit.edu>
References: <00000000000076f3a305e97e9229@google.com>
 <a68d118d-ee03-399c-df02-82848e2197a2@intel.com>
 <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+SpNuUSRFte2Lm13QZiTXcWfn2eZw5Q+MP0SKwuJEXFg@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 02:55:46PM -0700, Alexei Starovoitov wrote:
> 
> So instead of pinging us with your w^x concern you've decided
> to fail hard in -next to force the issue and
> now acting like this is something surprising to you?!
> 
> This is Code of Conduct "worthy" behavior demonstrated
> by a newly elected member of the Technical Advisory Board.

I must be missing something.  Why/what do you think this is
specifically a Code of Conduct violation?

				- Ted
