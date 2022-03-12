Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B474D6FC9
	for <lists+bpf@lfdr.de>; Sat, 12 Mar 2022 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiCLPpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Mar 2022 10:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiCLPpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Mar 2022 10:45:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B813CA67;
        Sat, 12 Mar 2022 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4QEBebUaifZcj/TbJPAnWkVaUA1yr6/N7uY1h3AI5c=; b=Fg2Yg7p5QIHUfT85fRxcArBEjw
        bqeKPYLrLU2OIIlPlzsfVVCUoEQT6XofF+v4HECm3I8/zRbDVWjAseHRCUxu5e4UXLJ3DqTpfjuJf
        rsOQ1/1NpB3iKlKU62G7gZX4foThloIu5ECK892g8VKeQIfoDGvuWTbIGqNnjZ7aQAW5FWT+ga8Qj
        wb+Df/rx9JW5QZIISJ8olPEfTr/zchhGx1m/If4XxsB4bfKgwESm7UgfbzANW56G/R9ETMbrRNyue
        7S2YJAS1iekYHhhW5FBqs0VAupXGds00vOdMDKlZ4zsGgUcWYdByJaBOfGkr6H42JjzO+nJZ3DeIC
        LKYl6q9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT3ub-002Vd3-ET; Sat, 12 Mar 2022 15:44:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB954987D0D; Sat, 12 Mar 2022 16:44:07 +0100 (CET)
Date:   Sat, 12 Mar 2022 16:44:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20220312154407.GF28057@worktop.programming.kicks-ass.net>
References: <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net>
 <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net>
 <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 11, 2022 at 09:09:38AM -0800, Alexei Starovoitov wrote:
> On Fri, Mar 11, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 10, 2022 at 05:29:11PM +0100, Peter Zijlstra wrote:
> >
> > > This seems to cure most of the rest. I'm still seeing one failure:
> > >
> > > libbpf: prog 'connect_v4_prog': BPF program load failed: Invalid argument
> > > libbpf: failed to load program 'connect_v4_prog'
> > > libbpf: failed to load object './connect4_prog.o'
> > > test_fexit_bpf2bpf_common:FAIL:tgt_prog_load unexpected error: -22 (errno 22)
> > > #48/4 fexit_bpf2bpf/func_replace_verify:FAIL
> >
> >
> > Hmm, with those two patches on I get:
> >
> > root@tigerlake:/usr/src/linux-2.6/tgl-build# ./test_progs -t fexit
> > #46 fentry_fexit:OK
> > #48 fexit_bpf2bpf:OK
> > #49 fexit_sleep:OK
> > #50 fexit_stress:OK
> > #51 fexit_test:OK
> > Summary: 5/9 PASSED, 0 SKIPPED, 0 FAILED
> >
> > On the tigerlake, I suppose I'm doing something wrong on the other
> > machine because there it's even failing on the pre-ibt kernel image.
> >
> > I'll go write up changelogs and stick these on.
> 
> What is the latest branch I can use to test it?

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt

that also include bpf-next. Thanks!
