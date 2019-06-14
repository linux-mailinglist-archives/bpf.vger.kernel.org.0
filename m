Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB354515C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2019 03:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNBwy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 21:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfFNBwy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 21:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DED081F0C;
        Fri, 14 Jun 2019 01:52:54 +0000 (UTC)
Received: from treble (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE8460A9A;
        Fri, 14 Jun 2019 01:52:52 +0000 (UTC)
Date:   Thu, 13 Jun 2019 20:52:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>
Subject: Re: [PATCH 6/9] x86/bpf: Fix JIT frame pointer usage
Message-ID: <20190614015251.xyfzl5djr7zurtvj@treble>
References: <cover.1560431531.git.jpoimboe@redhat.com>
 <03ddea21a533b7b0e471c1d73ebff19dacdcf7e3.1560431531.git.jpoimboe@redhat.com>
 <20190613215807.wjcop6eaadirz5xm@ast-mbp.dhcp.thefacebook.com>
 <20190614012248.ztruzocusb2vu7bl@treble>
 <20190614013904.v2tpiunrjukzlxsu@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614013904.v2tpiunrjukzlxsu@ast-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 01:52:54 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 13, 2019 at 06:39:05PM -0700, Alexei Starovoitov wrote:
> On Thu, Jun 13, 2019 at 08:22:48PM -0500, Josh Poimboeuf wrote:
> > On Thu, Jun 13, 2019 at 02:58:09PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Jun 13, 2019 at 08:21:03AM -0500, Josh Poimboeuf wrote:
> > > > The BPF JIT code clobbers RBP.  This breaks frame pointer convention and
> > > > thus prevents the FP unwinder from unwinding through JIT generated code.
> > > > 
> > > > RBP is currently used as the BPF stack frame pointer register.  The
> > > > actual register used is opaque to the user, as long as it's a
> > > > callee-saved register.  Change it to use R12 instead.
> > > > 
> > > > Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> > > > Reported-by: Song Liu <songliubraving@fb.com>
> > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++----------------
> > > >  1 file changed, 25 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index e649f977f8e1..bb1968fea50a 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -100,9 +100,8 @@ static int bpf_size_to_x86_bytes(int bpf_size)
> > > >  /*
> > > >   * The following table maps BPF registers to x86-64 registers.
> > > >   *
> > > > - * x86-64 register R12 is unused, since if used as base address
> > > > - * register in load/store instructions, it always needs an
> > > > - * extra byte of encoding and is callee saved.
> > > > + * RBP isn't used; it needs to be preserved to allow the unwinder to move
> > > > + * through generated code stacks.
> > > 
> > > Extra register save/restore is kinda annoying just to fix ORC.
> > 
> > It's not just for the ORC unwinder.  It also fixes the frame pointer
> > unwinder (see above commit msg).  And it's standard frame pointer
> > practice to not clobber RBP.
> 
> not true.
> generated JITed code has no issues with regular stack unwinder.
> it breaks down under ORC only.
> 
> > > Also every stack access from bpf prog will be encoded via r12 and consume
> > > extra byte of encoding. I really don't like this approach.
> > 
> > Do you have another callee-saved register you'd prefer to use as the
> > stack pointer?
> 
> RBP must be used.
> 
> > > Can you teach ORC to understand JIT-ed frames instead?
> > 
> > We could, but it would add a lot more complexity than this.  And anyway,
> > the frame pointer unwinder would still be broken.
> 
> I disagree. See above. Only ORC is broken. Hence ORC should be fixed.

You're clobbering RBP.  Frame pointer unwinding is broken.  Period.

-- 
Josh
