Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91424DCEFA
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 20:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiCQTql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQTql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 15:46:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A5D23D461;
        Thu, 17 Mar 2022 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JIZOHSN9Cp/RhF5NPH12ZhlfFlJw2FESR1XfKMbt/b0=; b=Nnbn7ThouyfyEnMTAAbC/NugI/
        ReXFd9lVFS2bfNkuzgeHtM5x0ZTmQ/bBF4G83n23OhSw/hGN1bKocVK1hePguJn/Pm7Gw/cLqU580
        XSKL4YDgBE/HsRQd2DFIQR6IVCoT/B1eaVB2r1vZXID6aIOJ4T9ENGyY0ukV5TYZhVwm2q478CNmH
        NIFX1tkoTjnip9Dsr5xq/G6/B/aTqx9YD6f6os8lszxdGEKNIt92kqqMdh6h191C0LiJZR2gWRUgr
        OJHpv0Q/mtvNtxlzL5sreFFDINtblmHnPpxHVe4YnIpj723e7zUZtMV9T29wm8a+ZitvvUEuXZkqO
        PWXdfZ5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUw3G-001yvc-Bh; Thu, 17 Mar 2022 19:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B44530003A;
        Thu, 17 Mar 2022 20:44:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF2DD30C650C5; Thu, 17 Mar 2022 20:44:47 +0100 (CET)
Date:   Thu, 17 Mar 2022 20:44:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YjOPrwZSEYR96/5D@hirez.programming.kicks-ass.net>
References: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
 <20220315081522.GA8939@worktop.programming.kicks-ass.net>
 <CAK7LNAReAKXT97NHEnC-1UXozdcPdYNHR55knNRDatJr_GqrrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAReAKXT97NHEnC-1UXozdcPdYNHR55knNRDatJr_GqrrA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 01:28:08AM +0900, Masahiro Yamada wrote:
> On Tue, Mar 15, 2022 at 5:15 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Index: linux-2.6/scripts/Makefile.build
> > ===================================================================
> > --- linux-2.6.orig/scripts/Makefile.build
> > +++ linux-2.6/scripts/Makefile.build
> > @@ -86,12 +86,18 @@ ifdef need-builtin
> >  targets-for-builtin += $(obj)/built-in.a
> >  endif
> >
> > -targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > +targets-for-modules :=
> 
> 
> Why do you need to change this line?
> 
> 
> 
> >
> >  ifdef CONFIG_LTO_CLANG
> >  targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
> >  endif
> >
> > +ifdef CONFIG_X86_KERNEL_IBT
> > +targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
> > +endif
> > +
> > +targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > +
> >  ifdef need-modorder
> >  targets-for-modules += $(obj)/modules.order
> >  endif

The thinking was that by having the .objtool rule before the .mod rule,
objtool runs first. If mod runs before objtool, objtool will change the
timestamp and then mod will get remade, even if nothing's changed.
