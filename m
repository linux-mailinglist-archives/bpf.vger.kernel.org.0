Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087A4D23D1
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiCHWCf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 17:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiCHWCf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 17:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402C5674D;
        Tue,  8 Mar 2022 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xej0djaBkpDYdCPd5/P3C9RqitTM+38of8EHro6ghVM=; b=MXCWsn3K2klaZwlh863Q76i+xb
        dw81ytsvdtkfyC2LH+FHeVudYy/01TBz7ILKI0cE6pIp3cYFKlLBIgztQThQQqRGeligJ5P7evL/Q
        ndbyFJjpjZuhchDrk+i/KXyM1ewSWpK1N9b6INjvn9LY/PrItNZHuLocdYzTYC4VlZdEs5EICHELj
        b6CtmlLLzqN81SkS+IwMhKprz32WxPJsUfAz1ckCtnwTuVrPntkWxS+UKvIOkqsIeEQwvL7fJofpu
        j6GK3YtzM8OLrGoBM0xRECcNsE0rU+pNoE5brT84p5A688A3dEKT5aO7esvx3b1fB0mehRO1h7bSV
        3sw/0B1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRhtB-00GZo5-Pz; Tue, 08 Mar 2022 22:01:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A442A300261;
        Tue,  8 Mar 2022 23:01:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D6F6203DC8C8; Tue,  8 Mar 2022 23:01:04 +0100 (CET)
Date:   Tue, 8 Mar 2022 23:01:04 +0100
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
Message-ID: <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 08, 2022 at 12:00:52PM -0800, Alexei Starovoitov wrote:
> On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> > Hopefully last posting...
> > 
> > Since last time:
> > 
> >  - updated the ftrace_location() patch (naveen, rostedt)
> >  - added a few comments and clarifications (bpetkov)
> >  - disable jump-tables (joao)
> >  - verified clang-14-rc2 works
> >  - fixed a whole bunch of objtool unreachable insn issue
> >  - picked up a few more tags
> > 
> > Patches go on top of tip/master + arm64/for-next/linkage. Also available here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
> 
> I've tried to test it.

I could cleanly do:

git checkout tip/master
git merge bpf-next/master
git merge queue/x86/wip.ibt

You want me to push out that result somewhere?
