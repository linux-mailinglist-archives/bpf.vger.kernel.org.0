Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200F4DCF56
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiCQU31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCQU31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 16:29:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EAD184B47;
        Thu, 17 Mar 2022 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xR0Xh4vh08GEl/31xYqetrKFkUBS7jcWFuxXcXOUiME=; b=G9VgrZnwukc9WnA56jnt1JnSCn
        ueDpys8XWKhJlTH4ahmaGBXsQJUFZ50tnyCEBWYsKl30epdutFgvh0irWbEpe0mIZYcRS8mH1nK4o
        QA6YkQ1618lPwoIiMzC+6ZcWBl5f7l7LGbnLQbbv9jTvZ0Pz/4iLJH2aPmdyKGt206i7HGa2QIRTU
        8NfXL99Pl44PXadqMmU/AGzs2uhNUdqcIMw3as8FwAbeG8tTxInU8OK6jFg4qYHvZ9dAxT33m9DFD
        VDSFNtc+USneRVDuSwFBgPKLAydAOLXDG6XzudS5bts1WPKceRkcBEvmu7gyu39FQ5Z51M5VPCAa5
        UfetWT/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUwik-001zXL-0y; Thu, 17 Mar 2022 20:27:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 558339882B3; Thu, 17 Mar 2022 21:27:41 +0100 (CET)
Date:   Thu, 17 Mar 2022 21:27:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        X86 ML <x86@kernel.org>, joao@overdrivepizza.com,
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
Message-ID: <20220317202741.GP8939@worktop.programming.kicks-ass.net>
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
 <CAADnVQ+TMPpwEc_S7ayijzem-SOCQzuAeJAX=3mQXqgTPBW22A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+TMPpwEc_S7ayijzem-SOCQzuAeJAX=3mQXqgTPBW22A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 11:26:10AM -0700, Alexei Starovoitov wrote:
> The bpf trampoline can attach to both indirect and non-indirect
> functions. My understanding is that only indirect targets will have
> endbr first insn. So the fix totally makes sense.

Correct, the compiler is free to not emit endbr if it can determine the
function will never be called indirectly (or it is explicitly marked so
with a function attribute).

