Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E944D985D
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbiCOKI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 06:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiCOKIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 06:08:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01C4F9C5;
        Tue, 15 Mar 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i6Es+miNOhVFoYvPslhvsNAp95qNKVCECTxVycj5tYw=; b=EHqFIFhbEzudn+v67MJF2tGlky
        7Dhjow/ap/VQwtms4x+CVa6hOBbqIE+25PnM227wriMRmMdTNUi3568Q0fzkOt4vceMGj/9FdbJnK
        NktO1E0SxlGZoOoMoIQvWJAcxfdOxVF8IylGBqQ6vGDNKDooMnYRcJ5MkpgpL/o6zDMLG8y7ngVBH
        VMr5tOPcxmziICVkdI4TIY3CWglMK/TfhVQYQhIMtfKE6MbgruKjL6NuXpzxNa0UumMPk6Tjn/jMa
        +t6S5ul8kGr22VM10PXandtYLdK7iDRK8LzNTNsDwG62cUCQ54bFwcgrpvoqbEtpQG/B3E6Jb64hr
        l0KyoqhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU456-001BNV-Lo; Tue, 15 Mar 2022 10:07:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8068D98620D; Tue, 15 Mar 2022 11:07:06 +0100 (CET)
Date:   Tue, 15 Mar 2022 11:07:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20220315100706.GA14330@worktop.programming.kicks-ass.net>
References: <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net>
 <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220314204402.rpd5hqzzev4ugtdt@apollo>
 <20220315090043.GB8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315090043.GB8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 10:00:43AM +0100, Peter Zijlstra wrote:
> I don't seem able to run this mod_race test, it keeps saying:
> 
>   tgl-build# ./test_progs -v -t mod_race
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   Summary: 0/0 PASSED, 0 SKIPPED, 0 FAILED
>   Successfully unloaded bpf_testmod.ko.
> 
> Which I'm taking to mean I'm doing it wrong... 

That.. I was building the wrong tree, mod_race comes from bpf-next and I
was building a tree without that merged in... let me to see what it does
now.
