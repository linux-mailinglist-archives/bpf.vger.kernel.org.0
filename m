Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D16C363E
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCUPvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCUPvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 11:51:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C95497CE;
        Tue, 21 Mar 2023 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0kHu/d75TtHlWBlgZ0g+45H6u2TvQunwCRm448/2BYk=; b=e91pw2BBmcICNERBe3vmWCBfMl
        MGcy6WWBWcRW+NqHIa69mIfI8x9EFgHbypfzZHYr40buip9CJNG3e5Hsduulgf0J/ELxtNCKxnuUb
        4dGhbUfM+YHA4qdUcGrxH7Vlz2kwAF+qLlWLyzrgnuPclFdfmoQPUHirj0pJYKzEoPcHhyorWYjSz
        UEjac9Nvkq0H+06zhIIa5NmQ0fHsuw9O6Cs7huqRRCHFaLZik57rPz1nidtbJFFjPCNgu7o1W7KX9
        55ki08KwCp/Pa2wHp2V3DhsRz7/nNY9OrVuXizMO0PT2XrMimEMIcbBW273Sg2yk5xstMaeXOVZQR
        2zKfLxxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peeGJ-004IoW-2q;
        Tue, 21 Mar 2023 15:51:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0884930031E;
        Tue, 21 Mar 2023 16:50:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2FB820F030E0; Tue, 21 Mar 2023 16:50:55 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:50:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230321155055.GA2273492@hirez.programming.kicks-ass.net>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
 <20230321101711.625d0ccb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321101711.625d0ccb@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 10:17:11AM -0400, Steven Rostedt wrote:
> On Tue, 21 Mar 2023 02:01:03 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> > It hits below warning on my test machine when running
> > selftests/bpf/test_progs,
> > 
> > [  702.223611] ------------[ cut here ]------------
> > [  702.224168] RCU not on for: preempt_count_sub+0x0/0xa0
> > [  702.224770] WARNING: CPU: 14 PID: 5267 at include/linux/trace_recursion.h:162 fprobe_handler.part.0+0x1b8/0x1c0
> > [  702.231740] CPU: 14 PID: 5267 Comm: main_amd64 Kdump: loaded Tainted: G           O       6.2.0+ #584
> > [  702.233169] RIP: 0010:fprobe_handler.part.0+0x1b8/0x1c0
> > [  702.241388] Call Trace:
> > [  702.241615]  <TASK>
> > [  702.241811]  fprobe_handler+0x22/0x30
> > [  702.242129]  0xffffffffc04710f7
> > [  702.242417] RIP: 0010:preempt_count_sub+0x5/0xa0
> > [  702.242809] Code: c8 50 68 94 42 0e b5 48 cf e9 f9 fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 4b cd 38 0b <55> 8b 0d 9c d0 cf 02 48 89 e5 85 c9 75 1b 65 8b 05 be 78 f4 4a 89
> > [  702.244752] RSP: 0018:ffffaf6187d27f10 EFLAGS: 00000082 ORIG_RAX: 0000000000000000
> > [  702.245801] RAX: 000000000000000e RBX: 0000000001b6ab72 RCX: 0000000000000000
> > [  702.246804] RDX: 0000000000000000 RSI: ffffffffb627967d RDI: 0000000000000001
> > [  702.247801] RBP: ffffaf6187d27f30 R08: 0000000000000000 R09: 0000000000000000
> > [  702.248786] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ca
> > [  702.249782] R13: ffffaf6187d27f58 R14: 0000000000000000 R15: 0000000000000000
> > [  702.250785]  ? preempt_count_sub+0x5/0xa0
> > [  702.251540]  ? syscall_enter_from_user_mode+0x96/0xc0
> > [  702.252368]  ? preempt_count_sub+0x5/0xa0
> > [  702.253104]  ? syscall_enter_from_user_mode+0x96/0xc0
> > [  702.253918]  do_syscall_64+0x16/0x90
> > [  702.254613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [  702.255422] RIP: 0033:0x46b793
> > 
> > This issue happens under CONFIG_CONTEXT_TRACKING_USER=y. When a task
> > enters from user mode to kernel mode, or enters from user mode to irq,
> > it excutes preempt_count_sub before RCU begins watching, and thus this
> > warning is triggered.
> > 
> > We should not handle fprobe if RCU is not watching.
> > 
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Jiri Olsa <olsajiri@gmail.com>
> > ---
> >  kernel/trace/fprobe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index e8143e3..fe4b248 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -27,6 +27,9 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  	struct fprobe *fp;
> >  	int bit;
> >  
> > +	if (!rcu_is_watching())
> > +		return;
> 
> Hmm, at least on 6.3, this should not be an issue anymore. I believe that
> all locations that have ftrace callbacks should now have rcu watching?
> 
> I think we *want* a warn on when this happens.
> 
> Peter?

You always want a wanring, because silently dropping stuff is very poor
form. But yes, we must not enter tracing then RCU isn't watching, that's
a fundamental fail and should be fixed.
