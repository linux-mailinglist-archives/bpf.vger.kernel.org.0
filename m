Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB04E6D31
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 05:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350249AbiCYEaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbiCYEaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 00:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A949F6EC;
        Thu, 24 Mar 2022 21:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7A461899;
        Fri, 25 Mar 2022 04:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5918C340E9;
        Fri, 25 Mar 2022 04:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648182525;
        bh=gOiPWU8wrRmexEr1ivSLPchYDDewRCSdulnwqXQ4f/o=;
        h=From:To:Cc:Subject:Date:From;
        b=P4jVjsO+EHL1LKPavvbkOvI0HBq3wTyXS+FPSi5LmcBVvnfbXIO8GXShrfjalUnVv
         1E6f7COLYa9AZyYtDWwFqK8a+H1sl8bItlSMb85xpss6i8Mn9FIR9Y532cMV+dydZ8
         Nf2mCrz1DhXfjM/4eFUfZZyWg6WnbZ6bKy4ykh2PHaaDGPY68jYsslm4fZS0yxzA30
         g7EbJi683OqWQGxtvma29xs6lpRtpnP8wSdK/frKPOXWsh+F6Ss5zx5Ew/Rx19Lmsn
         IRtPkWjriX9XZCFITr6DGCNAppotJcD1OfLy/zGrbZ0UOGZ4ie1ZjnQofJf0f1RHsX
         rKhEgf/dLg+xA==
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
Subject: [PATCH bpf-next 0/2] kprobes: rethook: x86: Replace kretprobe trampoline with rethook
Date:   Fri, 25 Mar 2022 13:28:39 +0900
Message-Id: <164818251899.2252200.7306353689206167903.stgit@devnote2>
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

Here are the patch set for generic kretprobe and kretprobe on x86 for
replacing the kretprobe trampoline with rethook. For the other archs,
I will port rethook to those after this has been merged.
This is previously called as "rethook: x86: Add rethook x86 implementation"
The previous thread is here[1].

[1] https://lore.kernel.org/all/164800288611.1716332.7053663723617614668.stgit@devnote2/T/#u

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

Masami Hiramatsu (2):
      kprobes: Use rethook for kretprobe if possible
      rethook: kprobes: x86: Replace kretprobe with rethook on x86


 arch/Kconfig                     |    7 ++
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/unwind.h    |   23 +++----
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/kprobes/common.h |    1 
 arch/x86/kernel/kprobes/core.c   |  107 ---------------------------------
 arch/x86/kernel/rethook.c        |  121 +++++++++++++++++++++++++++++++++++++
 include/linux/kprobes.h          |   51 +++++++++++++++-
 kernel/kprobes.c                 |  124 ++++++++++++++++++++++++++++++++------
 kernel/trace/trace_kprobe.c      |    4 +
 10 files changed, 296 insertions(+), 144 deletions(-)
 create mode 100644 arch/x86/kernel/rethook.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
