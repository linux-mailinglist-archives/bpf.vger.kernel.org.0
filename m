Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F054E7E6D
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 02:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiCZB2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 21:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCZB2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 21:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599863387;
        Fri, 25 Mar 2022 18:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688FD618FB;
        Sat, 26 Mar 2022 01:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B4C2BBE4;
        Sat, 26 Mar 2022 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648257995;
        bh=RC+BEGuNVMZhMjCmzDiJ6C8Er/DhjeIkXm3qc1XisbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cm3FW1XdDVekMPRjk8s84UOCdFl57xZTeI6av5miMXE97C6X9NcGIuEt+AyCCrDJT
         ViwirGqDPU8wGn7MNCcIjJYiuY5DoI8mfn7pmCeqhweJa/OHBxzNgQ2CgZ7EL1Yzle
         4PLByvZhta7iAfDj9R/B9SlVpauUqC5nOCCbBLa05RsgbKRhu5Eg4QAPDy4PWEUeA2
         i33ueBryrGNzKAQRv265yhWny3nWYgFp4jP7z3qtwa+iFIWFxRtDJMq54zsHTrafuD
         MiLsv9yWmZXqvR8lQuHvDEhyN4UlEl9E4CAw5Zpl7hEpijQAWaguTJh+LTR6gJxALT
         cDLdL5C9OaAiQ==
Date:   Sat, 26 Mar 2022 10:26:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace
 kretprobe trampoline with rethook
Message-Id: <20220326102629.ab36e0f5f71371426e2d36a5@kernel.org>
In-Reply-To: <CAADnVQLg0h7aJBPSfmQdL_M=S9QHWe+xLXZPL4gzMYejz=Mf0Q@mail.gmail.com>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
        <Yj3VAsgGA9zJvxgs@hirez.programming.kicks-ass.net>
        <CAADnVQLg0h7aJBPSfmQdL_M=S9QHWe+xLXZPL4gzMYejz=Mf0Q@mail.gmail.com>
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

On Fri, 25 Mar 2022 09:49:47 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Mar 25, 2022 at 7:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 25, 2022 at 11:22:53PM +0900, Masami Hiramatsu wrote:
> >
> > > Masami Hiramatsu (3):
> > >       kprobes: Use rethook for kretprobe if possible
> > >       rethook: kprobes: x86: Replace kretprobe with rethook on x86
> > >       x86,kprobes: Fix optprobe trampoline to generate complete pt_regs
> > >
> > > Peter Zijlstra (1):
> > >       Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
> >
> > You fat-fingered the subject there ^
> >
> > Other than that:
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Hopefully the ftrace return trampoline can also be switched over..
> 
> Thanks Peter. What's an ETA on landing endbr set?
> Did I miss a pull req?
> I see an odd error in linux-next with bpf selftests
> which may or may not be related. Planning to debug it
> when everything settles in Linus's tree.

That is what I pointed in cover mail.

> BTW, this patch can be applied to next-20220324, not the bpf-next tree
> directly, because this depends on ANNOTATE_NOENDBR macro. However, since
> the fprobe is merged in the bpf-next, I marked this for bpf-next.
> So until merging the both of fprobes and ENDBR series, to compile this
> you need below 2 lines in arch/x86/kernel/rethook.c.
> 
> #ifndef ANNOTATE_NOENDBR
> #define ANNOTATE_NOENDBR

> 
> Masami, could you do another respin?

OK, I will add above temporary mitigation.

> 
> Also do you mind squashing patches 2,3,4 ?
> It's odd to have the same lines of code patched up 3 times.
> Just do it right once.

Hmm, I think those are different commit for different features.
I would like to keep those 3 patches separated (for the case if
we find any issue to introduce regs->ss later)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
