Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D514E74F4
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiCYOYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiCYOYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:24:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F671009;
        Fri, 25 Mar 2022 07:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86123B8288C;
        Fri, 25 Mar 2022 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2FC340E9;
        Fri, 25 Mar 2022 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648218179;
        bh=DltTo5IPp+afM/kBYNU4tPTueYUlNlIcT8OkeI7iSc4=;
        h=From:To:Cc:Subject:Date:From;
        b=mVs6t1TTgTES6UGTw6RJ8sDXSHojLSRLLWiNxhLt8we3mDe1b7WuYekeoJ83/sWl1
         2GJcqoQhSxFRPTM9r/L76MpjtXHYjdDCW3bIV7B9UszcKTvyd5hiJnXmakk8RcFiD+
         Cm7wV2QsaaE5W4c0Q2+wXO5ApBQQNxyk8kYA2xyatCIrW/HmpkqlzJdULF60g+frPV
         UvBAZ6J24a7QScYWI3uXkoZYoSg4Hd+LihWsqYrRLlOuoUreUHVziDf7VCZykzbK+w
         UttGpR9+Jy+LHbV1zVcITs5dmQldYAtm31KXosleoX9QDbRQk6VC+e6Htv/L4svaDd
         qXXObgd8ONnsQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] kprobes: rethook: x86: Replace kretprobe trampoline with rethook
Date:   Fri, 25 Mar 2022 23:22:53 +0900
Message-Id: <164821817332.2373735.12048266953420821089.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here are the 2nd version for generic kretprobe and kretprobe on x86 for
replacing the kretprobe trampoline with rethook. The previous version
is here[1]

[1] https://lore.kernel.org/all/164818251899.2252200.7306353689206167903.stgit@devnote2/T/#u

In this version I added completing pt_regs by saving regs->ss register
for rethook (from Peter) and optprobe.

Background:

This rethook came from Jiri's request of multiple kprobe for bpf[1].
He tried to solve an issue that starting bpf with multiple kprobe will
take a long time because bpf-kprobe will wait for RCU grace period for
sync rcu events.

Jiri wanted to attach a single bpf handler to multiple kprobes and
he tried to introduce multiple-probe interface to kprobe. So I asked
him to use ftrace and kretprobe-like hook if it is only for the
function entry and exit, instead of adding ad-hoc interface
to kprobes.
For this purpose, I introduced the fprobe (kprobe like interface for
ftrace) with the rethook (this is a generic return hook feature for
fprobe exit handler)[2].

[1] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#u
[2] https://lore.kernel.org/all/164191321766.806991.7930388561276940676.stgit@devnote2/T/#u

The rethook is basically same as the kretprobe trampoline. I just made
it decoupled from kprobes. Eventually, the all arch dependent kretprobe
trampolines will be replaced with the rethook trampoline instead of
cloning and set HAVE_RETHOOK=y.
When I port the rethook for all arch which supports kretprobe, the
legacy kretprobe specific code (which is for CONFIG_KRETPROBE_ON_RETHOOK=n)
will be removed eventually.

Worktree notice:

BTW, this patch can be applied to next-20220324, not the bpf-next tree
directly, because this depends on ANNOTATE_NOENDBR macro. However, since
the fprobe is merged in the bpf-next, I marked this for bpf-next.
So until merging the both of fprobes and ENDBR series, to compile this
you need below 2 lines in arch/x86/kernel/rethook.c.

#ifndef ANNOTATE_NOENDBR
#define ANNOTATE_NOENDBR

But after those are merged, these lines will be unneeded. How should I
handle this issue? (Just remove ANNOTATE_NOENDBR line in bpf-next?)


Thank you,

---

Masami Hiramatsu (3):
      kprobes: Use rethook for kretprobe if possible
      rethook: kprobes: x86: Replace kretprobe with rethook on x86
      x86,kprobes: Fix optprobe trampoline to generate complete pt_regs

Peter Zijlstra (1):
      Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs


 arch/Kconfig                     |    7 ++
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/unwind.h    |   23 +++----
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/kprobes/common.h |    1 
 arch/x86/kernel/kprobes/core.c   |  107 ---------------------------------
 arch/x86/kernel/kprobes/opt.c    |   25 +++++---
 arch/x86/kernel/rethook.c        |  123 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/unwind_orc.c     |   10 ++-
 include/linux/kprobes.h          |   51 +++++++++++++++-
 kernel/kprobes.c                 |  124 ++++++++++++++++++++++++++++++++------
 kernel/trace/trace_kprobe.c      |    4 +
 12 files changed, 319 insertions(+), 158 deletions(-)
 create mode 100644 arch/x86/kernel/rethook.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
