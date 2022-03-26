Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03534E7E59
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiCZBLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 21:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCZBLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 21:11:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15416D8E6;
        Fri, 25 Mar 2022 18:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C463B82ACC;
        Sat, 26 Mar 2022 01:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E1C2BBE4;
        Sat, 26 Mar 2022 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648257002;
        bh=2xiQISCsw2cy2y6MHShJ4Jqd9uPswPsIo+/nl7cHzog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u7TxL5wBkuAlU15aDeVXpEFVdmxwEHp9frlni9CwXVreMtiz/irA1vVwyeRfo8ZcY
         LgzdQEGx5vleNMqyJT636GsqvBAyJWNAty7wo0SvCvrzgqEXnn448oe3ZU7eLsPCP4
         9s5U6EjoL8yNonMtnWKR5Z2A6mo/QiM54lpmJOlypIMt7GBKCdRq71PXmdu/jn2KbL
         tBAow0/9xo7PXG2lpo4FlKLMdQXua4ZdoHqfgm7dDp//t2LLlUSPJp8U0zlPENnP0j
         tiO/b5rh/zvV1onpmurAETgfzGg2DwRExU/CpMrxf0kmbZxpusON8bgTgwKY3SD3EZ
         pynU1B70Q8MxA==
Date:   Sat, 26 Mar 2022 10:09:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace
 kretprobe trampoline with rethook
Message-Id: <20220326100956.2d8acf1df409a890403eefcc@kernel.org>
In-Reply-To: <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
        <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022 15:43:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:
> 
> > Masami Hiramatsu (3):
> >       kprobes: Use rethook for kretprobe if possible
> >       rethook: kprobes: x86: Replace kretprobe with rethook on x86
> >       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> > 
> > Peter Zijlstra (1):
> >       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
> 
> You fat-fingered the subject there ^
> 

Oops, I missed to import the patch...

> Other than that:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> 
> Hopefully the ftrace return trampoline can also be switched over..

The rethook clarifies the interfaces for the return trampoline, so
I think this can step the integration forward.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
