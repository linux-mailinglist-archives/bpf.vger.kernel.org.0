Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920424F61AB
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiDFOaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiDFOaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 10:30:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C9501B45;
        Wed,  6 Apr 2022 03:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6OzT4OmHz+L2j/EDCMxP9gXB/ot5T8KVaZBqTZv1Ez0=; b=n5X36hvd6MbjoxFRIpTKDcjiFW
        Jz5Y3vAxfgH8fP8YEKASBAXzQhZqeUQ9oYG/ytpO4hyasBMRkKI34KV9R6PH7ixw1miNLhmtXgI3G
        WLNABrkOzKfcnx6wXifQs0cm1VXdAxaco7bfUJwUzPdkdHHU+GWIb7Aza6qcu7hslbEO8u8UTwnsN
        2TBCrnJjmWAka8mmR660bNHsozgMIcf28LvZVNDPJICZ/kC4i5E6cLaOafRyejMFpfgT3vzRsgE+F
        FtC3qZY71RdKBijIqKT3OUsYX/lN0ZsiIuEtah9q3DLQT8nSTV0ktdfCH0aIACHwMLqUqIX1nXd9s
        6eDa4PoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc3BV-007iGk-KW; Wed, 06 Apr 2022 10:46:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 967C6986199; Wed,  6 Apr 2022 12:46:43 +0200 (CEST)
Date:   Wed, 6 Apr 2022 12:46:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86,bpf: Avoid IBT objtool warning
Message-ID: <20220406104643.GB2731@worktop.programming.kicks-ass.net>
References: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
 <CAADnVQJ1_9sBqRngG_J+84whx9j7d7qOSzMaJvhc0evDBQfE3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ1_9sBqRngG_J+84whx9j7d7qOSzMaJvhc0evDBQfE3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 05, 2022 at 09:58:28AM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 5, 2022 at 12:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > Clang can inline emit_indirect_jump() and then folds constants, which
> > results in:
> >
> >   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x6a4: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
> >   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x67d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
> >   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x386: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
> >   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x35d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
> >
> > Suppress the optimization such that it must emit a code reference to
> > the __x86_indirect_thunk_array[] base.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -412,6 +412,7 @@ static void emit_indirect_jump(u8 **ppro
> >                 EMIT_LFENCE();
> >                 EMIT2(0xFF, 0xE0 + reg);
> >         } else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> > +               OPTIMIZER_HIDE_VAR(reg);
> >                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
> >         } else
> >  #endif
> 
> Looks good. Please cc bpf@vger and all bpf maintainers in the future.

Oh right, I'll go add an alias for that.

> We can take it through the bpf tree if you prefer.

I'll take it through the x86/urgent tree if you don't mind.
