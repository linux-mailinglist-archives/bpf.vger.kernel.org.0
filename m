Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE49127305
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfEVXqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 19:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEVXqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 19:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F88630832E6;
        Wed, 22 May 2019 23:46:38 +0000 (UTC)
Received: from treble (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC1660857;
        Wed, 22 May 2019 23:46:36 +0000 (UTC)
Date:   Wed, 22 May 2019 18:46:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190522234635.a47bettklcf5gt7c@treble>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
 <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522174517.pbdopvookggen3d7@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 22 May 2019 23:46:38 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 22, 2019 at 12:45:17PM -0500, Josh Poimboeuf wrote:
> On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
> > The one that is broken is prog_tests/stacktrace_map.c
> > There we attach bpf to standard tracepoint where
> > kernel suppose to collect pt_regs before calling into bpf.
> > And that's what bpf_get_stackid_tp() is doing.
> > It passes pt_regs (that was collected before any bpf)
> > into bpf_get_stackid() which calls get_perf_callchain().
> > Same thing with kprobes, uprobes.
> 
> Is it trying to unwind through ___bpf_prog_run()?
> 
> If so, that would at least explain why ORC isn't working.  Objtool
> currently ignores that function because it can't follow the jump table.

Here's a tentative fix (for ORC, at least).  I'll need to make sure this
doesn't break anything else.

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 242a643af82f..1d9a7cc4b836 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1562,7 +1562,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		BUG_ON(1);
 		return 0;
 }
-STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
 
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..2567027fce95 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1033,13 +1033,6 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
 
-		/*
-		 * Make sure the .rodata address isn't associated with a
-		 * symbol.  gcc jump tables are anonymous data.
-		 */
-		if (find_symbol_containing(rodata_sec, table_offset))
-			continue;
-
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
 		if (rodata_rela) {
 			/*
