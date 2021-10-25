Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B9439695
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhJYMsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhJYMsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 08:48:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E320C061745;
        Mon, 25 Oct 2021 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RIUrXxUV4UbEv2DGGHaNGcFcvRKSfANE71br1DygmXE=; b=kUsxMs1Z4n8b+0909nSn+49Any
        grB324UAZJIgSY8CEqFEGD9kDcJlSbAXEHEM5uF1VJfACLytS5tLr0AOW3iRjvNMzkzI4EkzcstfR
        +nFtDTfAKYaWhoHjLDm7S8ldi+sD8pS6e1DY/rZKvpXjLrZqT0/FNOiZ/vFWTU34FE/LrJ0+1yb/T
        of/8Eu0kWXkmohp69S/6d4RSNk+03UsI999j/TpKjxfDyZW/5dXeQFnqLpLs+VIg8PPDqNXoCV+aB
        Cn2AT1e+d447yMvQr2vnM+AET2VoTaVsfd7VVv4506Nki8Y58U29DajzAiA6IcccwvVXKCeEfJRHG
        Rh9XIiFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mezJZ-00G7qw-94; Mon, 25 Oct 2021 12:43:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0556A3002AE;
        Mon, 25 Oct 2021 14:42:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2B74212E25E6; Mon, 25 Oct 2021 14:42:55 +0200 (CEST)
Date:   Mon, 25 Oct 2021 14:42:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXamT2EIUYW8t74A@hirez.programming.kicks-ass.net>
References: <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
 <20211021233852.gbkyl7wpunyyq4y5@treble>
 <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
 <YXKhLzd/DtkjURpc@hirez.programming.kicks-ass.net>
 <CAADnVQKJojWGaTCpUhkmU+vUxXORPacX_ByjyHWY0V03hGH7KA@mail.gmail.com>
 <YXa0uH0fA0P+dM8J@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXa0uH0fA0P+dM8J@boxer>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 03:44:24PM +0200, Maciej Fijalkowski wrote:
> On Fri, Oct 22, 2021 at 08:22:35AM -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 22, 2021 at 4:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 04:42:12PM -0700, Alexei Starovoitov wrote:
> > >
> > > > Ahh. Right. It's potentially a different offset for every prog.
> > > > Let's put it into struct jit_context then.
> > >
> > > Something like this...
> > 
> > Yep. Looks nice and clean to me.
> > 
> > > -       poke->tailcall_bypass = image + (addr - poke_off - X86_PATCH_SIZE);
> > > +       poke->tailcall_bypass = ip + (prog - start);
> > >         poke->adj_off = X86_TAIL_CALL_OFFSET;
> > > -       poke->tailcall_target = image + (addr - X86_PATCH_SIZE);
> > > +       poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
> > 
> > This part looks correct too, but this is Daniel's magic.
> > He'll probably take a look next week when he comes back from PTO.
> > I don't recall which test exercises this tailcall poking logic.
> > It's only used with dynamic updates to prog_array.
> > insmod test_bpf.ko and test_verifier won't go down this path.
> 
> Please run ./test_progs -t tailcalls from tools/testing/selftests/bpf and
> make sure that all of the tests are passing in there, especially the
> tailcall_bpf2bpf* subset.

Yeah, so nothing from that selftests crud wants to work for me; also I
*really* dislike how vmtest.sh as found there tramples all over my
source dir without asking.

Note that even when eventually supplied with O=builddir (confusingly in
front of it), it doesn't want to work and bails with lots of -ENOSPC
warnings (I double checked, my disks are nowhere near full). (and this
is after installing some horrendous python rst crap because clearly
running a test needs to build documentation :/)

I've spend hours on that, I'm not sinking more time into it. If you want
me to run that crap, fix it first.
