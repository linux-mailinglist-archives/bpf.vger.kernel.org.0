Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA194DCF09
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 20:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiCQTx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCQTx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 15:53:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A435282561;
        Thu, 17 Mar 2022 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ryH9ljonsXytXG2DnUpgXWcY+PPBTH4gQXM5AkXiazw=; b=QR2SAarMkc0tFPFJAN70d+qhN4
        eDSnM7lK3VRDc2q6lVgueIZIot+09iAue20w+oOwmUioWTvAJl9NFboeA1CSAbuP9dNBXepQhpXws
        jR1gJO7mi2VgfuSpy8KqY0svssuuAfmHDwWiCbG5FVuFfv6u/Ovp2TJihuIlCaMXx072X2Tge252E
        gihu/eVUVPyfwCMizEjIZ8/3Cjs5DkwefRYC4UJaduIszCes77HwUucLC2LCZRKeOchlb2unfvrzI
        V872oL4UxjwApro9n0ncBxmLcf1NCd2iYRGsps4mgKNBpKxP54bi0EY/3zIjNXvV5IxnO53f9Zzcg
        4+/T3FIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUwAR-001z0Y-Eu; Thu, 17 Mar 2022 19:52:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98B813001EA;
        Thu, 17 Mar 2022 20:52:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F1043021E88F; Thu, 17 Mar 2022 20:52:14 +0100 (CET)
Date:   Thu, 17 Mar 2022 20:52:14 +0100
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
Message-ID: <YjORbqKpn0QH/L7P@hirez.programming.kicks-ass.net>
References: <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net>
 <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com>
 <20220313085214.GK28057@worktop.programming.kicks-ass.net>
 <Yi9YOdn5Nbq9BBwd@hirez.programming.kicks-ass.net>
 <20220315081522.GA8939@worktop.programming.kicks-ass.net>
 <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 18, 2022 at 03:15:59AM +0900, Masahiro Yamada wrote:


This is somewhat similar to my first attempt, except I thought it had a
extra/superflous link pass in it..

> @@ -288,24 +289,24 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>         $(call if_changed_rule,cc_o_c)
>         $(call cmd,force_checksrc)
> 
> -ifdef CONFIG_LTO_CLANG
> +ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  # Module .o files may contain LLVM bitcode, compile them into native code
>  # before ELF processing
> -quiet_cmd_cc_lto_link_modules = LTO [M] $@
> -cmd_cc_lto_link_modules =                                              \
> +quiet_cmd_cc_prelink_modules = LD [M]  $@
> +      cmd_cc_prelink_modules =                                         \
>         $(LD) $(ld_flags) -r -o $@                                      \
> -               $(shell [ -s $(@:.lto.o=.o.symversions) ] &&            \
> -                       echo -T $(@:.lto.o=.o.symversions))             \
> +               $(shell [ -s $(@:.prelink.o=.o.symversions) ] &&
>          \
> +                       echo -T $(@:.prelink.o=.o.symversions))         \
>                 --whole-archive $(filter-out FORCE,$^)                  \
>                 $(cmd_objtool)
> 


> @@ -469,7 +470,7 @@ $(obj)/lib.a: $(lib-y) FORCE
>  # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
>  # module is turned into a multi object module, $^ will contain header file
>  # dependencies recorded in the .*.cmd file.
> -ifdef CONFIG_LTO_CLANG
> +ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  quiet_cmd_link_multi-m = AR [M]  $@
>  cmd_link_multi-m =                                             \
>         $(cmd_update_lto_symversions);                          \

Except I overlooked this part, where ar is used instead of ld to combine
the individual files.

Let me go make the change, Thanks!
