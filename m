Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF634D25B1
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 02:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiCIBON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 20:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCIBNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94760169387;
        Tue,  8 Mar 2022 17:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+/EchvKqxgDAiC0CiCuu0yIQfeE12gsf0GdAJi2W9UI=; b=jXhGdy313jO3pVD7GRnGQSmECg
        AV6Ef3Id/uA26FvlY05gO1nlFjqt2F0MEVNhh7d83Kh/I/F2cVKZBbFVYyqyWQ2L7DGHBBBQupNOp
        qr4dBLBId3aKMVXDn/igkF0YqS3+2J/7V9LhU97BKP5NNf5j0046VQyh7NE+6TcpuzVbJsds8A5Yd
        cMmiFB4XGE8UoY78oVc1ZMvCWL+BCEG7KzjEmfp+wkZT40fkLhRpiZOX+B0d9aJIWhESB8Yo13f9S
        i2Nk74TOO4+ssQJbuhBtshUOj3/fnlV2w/cBe963WPGcybKw/CN4OK6VgZL2/gFw6Jke8KeSXCv3p
        Pv03Jqcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRkic-00GglB-NJ; Wed, 09 Mar 2022 01:02:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E88430037F;
        Wed,  9 Mar 2022 02:02:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ADD42BCCB298; Wed,  9 Mar 2022 02:02:20 +0100 (CET)
Date:   Wed, 9 Mar 2022 02:02:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 08, 2022 at 11:32:37PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 08, 2022 at 11:01:04PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 08, 2022 at 12:00:52PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> > > > Hopefully last posting...
> > > > 
> > > > Since last time:
> > > > 
> > > >  - updated the ftrace_location() patch (naveen, rostedt)
> > > >  - added a few comments and clarifications (bpetkov)
> > > >  - disable jump-tables (joao)
> > > >  - verified clang-14-rc2 works
> > > >  - fixed a whole bunch of objtool unreachable insn issue
> > > >  - picked up a few more tags
> > > > 
> > > > Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
> > > 
> > > I've tried to test it.
> > 
> > I could cleanly do:
> > 
> > git checkout tip/master
> > git merge bpf-next/master
> > git merge queue/x86/wip.ibt
> > 
> > You want me to push out that result somewhere?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
> 
> includes bpf-next/master.

I just managed to run bpf selftests with that kernel on a tigerlake
platform.  Seems to still work.
