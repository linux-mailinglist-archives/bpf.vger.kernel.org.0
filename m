Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAAEA380
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfJ3SkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 14:40:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfJ3SkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 14:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5yjTD0vSgrB/yBE3DW3WbNpFuPl1Y2o6+3IHmE5qv2E=; b=PyViZqtUR4cuRQwG7Cbsa+m62
        o14pLDdczzOHm7K8vK7BdPRpMPrAC1MoCCCEIGrwBTwSFZ7aZdbjUKSkjnzx9mQxplTJBaEHS20q0
        smnQU4y8FuEsVpPy1Nf1fdSSBxK1MsB+rBgII5iKsMUofCPK4lp6KMfe+rbEL5Y63Uv1qWT+3tsxg
        hoH+cdZPw0sXOphLTE4d6UMoYIiOxBf6PsUrDTuboxHS7H20Kb7OMA69rnz+ETqsl2vxqpWNVCnZ/
        AbZLh0GGc9H6P9KEeU4dXjhyImYQEWMUOPmGdYRdSWW9cV2/FRAWq/DZ/BsDxAhhxT24oQ6nTVDzi
        SI4x9Xnvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPssl-0001sb-7n; Wed, 30 Oct 2019 18:39:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490D330610C;
        Wed, 30 Oct 2019 19:38:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9261129AB4E95; Wed, 30 Oct 2019 19:39:44 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:39:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "bp@alien8.de" <bp@alien8.de>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191030183944.GV4114@hirez.programming.kicks-ass.net>
References: <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <20191028135521.GB4097@hirez.programming.kicks-ass.net>
 <0a35765f7412937c1775daa05177b20113760aee.camel@intel.com>
 <20191028210052.GM4643@worktop.programming.kicks-ass.net>
 <69c57f7fa9a1be145827673b37beff155a3adc3c.camel@intel.com>
 <20191030100418.GV4097@hirez.programming.kicks-ass.net>
 <CAADnVQ+3LeLWv-rpATyfAbdS1w9L=sCQFuyy=paCZVBUr0rK6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+3LeLWv-rpATyfAbdS1w9L=sCQFuyy=paCZVBUr0rK6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 30, 2019 at 08:35:09AM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 30, 2019 at 3:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 05:27:43PM +0000, Edgecombe, Rick P wrote:
> > > On Mon, 2019-10-28 at 22:00 +0100, Peter Zijlstra wrote:
> >
> > > > That should be limited to the module range. Random data maps could
> > > > shatter the world.
> > >
> > > BPF has one vmalloc space allocation for the byte code and one for the module
> > > space allocation for the JIT. Both get RO also set on the direct map alias of
> > > the pages, and reset RW when freed.
> >
> > Argh, I didn't know they mapped the bytecode RO; why does it do that? It
> > can throw out the bytecode once it's JIT'ed.
> 
> because of endless security "concerns" that some folks had.
> Like what if something can exploit another bug in the kernel
> and modify bytecode that was already verified
> then interpreter will execute that modified bytecode.

But when it's JIT'ed the bytecode is no longer of relevance, right? So
any scenario with a JIT on can then toss the bytecode and certainly
doesn't need to map it RO.

> Sort of similar reasoning why .text is read-only.
> I think it's not a realistic attack, but I didn't bother to argue back then.
> The mere presence of interpreter itself is a real security concern.
> People that care about speculation attacks should
> have CONFIG_BPF_JIT_ALWAYS_ON=y,

This isn't about speculation attacks, it is about breaking buffer limits
and being able to write to memory. And in that respect being able to
change the current task state (write it's effective PID to 0) is much
simpler than writing to text or bytecode, but if you cannot reach/find
the task struct but can reach/find text..

> so modifying bytecode via another exploit will be pointless.
> Getting rid of RO for bytecode will save a ton of memory too,
> since we won't need to allocate full page for each small programs.

So I'm thinking we can get rid of that for any scenario that has the JIT
enabled -- not only JIT_ALWAYS_ON.
