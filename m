Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CDF43BC03
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhJZVHp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbhJZVHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 17:07:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D1C061570;
        Tue, 26 Oct 2021 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lwEflbs752Kv3f25fSJrzwMWFiehOBIeT1BkquusHT4=; b=l1hLIFLnoJl/06pPtHA5tLi6dW
        bzbST+Lugh79kcFt34x+T+rjqcdsEsnatpeuG+Q5RrgCXsSzCyN0vuI0S0KjtqB3cTZ2SCaopXwvz
        1cAr07yF1sApR2qWT9T7oanRaNdh/PCL7sS8OkBbY7hgdzPJauaN3htlEazRamziyTVjCaMhx2njr
        tQGmSmGseB9XccIZAAINEy1X/1rWfEUh+tn4U4DZ+dpcx/1uQsxY2UEAiBONoQTiNcMFzMIqNK5Xt
        EjI9MIQejV2VgzxgF4eml9ouro7hVUzbzHvB6/QuvfbsFPhT6uZgUqo6pLaPzNLLttjjGv5Sfw3bX
        z0wri+Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfTd8-00CQaR-AS; Tue, 26 Oct 2021 21:05:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 551B5981FD5; Tue, 26 Oct 2021 23:05:09 +0200 (CEST)
Date:   Tue, 26 Oct 2021 23:05:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Message-ID: <20211026210509.GH174703@worktop.programming.kicks-ass.net>
References: <20211026120132.613201817@infradead.org>
 <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
 <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net>
 <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 01:00:04PM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 26, 2021 at 11:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 26, 2021 at 11:26:57AM -0700, Alexei Starovoitov wrote:
> >
> > > It's a merge conflict. The patchset failed to apply to both bpf and
> > > bpf-next trees:
> >
> > Figures :/ I suspect it relies on tip/objtool/core at the very least and
> > possibly some of the x86 trees as well.
> >
> > I can locally merge tip/master with bpf, but getting a CI to do that
> > might be tricky.
> 
> We have an ability in CI to supply few additional patches on top bpf/bpf-next
> trees, but that's usually done for the cases where we've merged a fix into
> one tree, but it's needed in both while bpf->net->linus->net-next->bpf-next
> circle is still pending.
> 
> Does tip/objtool/core dependency relevant for this set?
> Can you rebase the current set on top of bpf-next and send it to the list
> just to get CI to run it? We won't be merging it into bpf-next, of course.
> I'm mainly interested in seeing all that additional tests passing that
> we have in bpf-next.

I should be able to rebase it just to that, let me try that in the am
though, brain is fairly fried atm. Do you really want me to post it to
the list, or is a git repo good enough?
