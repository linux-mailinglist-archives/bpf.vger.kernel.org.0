Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13124E7E88
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiCZC2i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCZC2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 22:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F017587B;
        Fri, 25 Mar 2022 19:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACCA6192B;
        Sat, 26 Mar 2022 02:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E8CC004DD;
        Sat, 26 Mar 2022 02:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648261620;
        bh=cEglIADM0ElTnrN0MKu6BxGtirnD7NT5oa3/G7079pU=;
        h=From:To:Cc:Subject:Date:From;
        b=ccf5vFr+EOw+GqI3PwdjNMhMY+wzOaALKumvV0Z5O1roUV32yWALYURJXLI4WxPM+
         XWfnjdmChTjGysG9hg+AWDc2S5rBNfPN0PlMBoix5Fotr/LHT8ZE8aUYyv8BDyVww7
         ZxC+qVv6wt7HlBAIWcPECyJSW38Uf9+FrSKt8zMyigRCRhEpLljDaB9Oxd0ic10+87
         nL4YJz/kyt362bh3pl+k1d3yxj8iCJ3gI3Kdlz7dURkpnPiVv2/EZhp8YUFBnTnwbe
         Vws7QiAqbbrJqnb+HeyLcjHYRpWyUa6RFtvLM+R1Z7jAnKEsIIG9gekc4OLWFjsu0u
         WMyxGgAysP0ZQ==
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
Subject: [PATCH bpf-next v3 0/4] kprobes: rethook: x86: Replace kretprobe trampoline with rethook
Date:   Sat, 26 Mar 2022 11:26:49 +0900
Message-Id: <164826160914.2455864.505359679001055158.stgit@devnote2>
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

Here are the 3rd version for generic kretprobe and kretprobe on x86 for
replacing the kretprobe trampoline with rethook. The previous version
is here[1]

[1] https://lore.kernel.org/all/164821817332.2373735.12048266953420821089.stgit@devnote2/T/#u

This version fixed typo and build issues for bpf-next and CONFIG_RETHOOK=y
error. I also add temporary mitigation lines for ANNOTATE_NOENDBR macro
issue for bpf-next tree [2/4].

#ifndef ANNOTATE_NOENDBR
#define ANNOTATE_NOENDBR
#endif

This will be removed after merging kernel IBT series.

Background:

This rethook came from Jiri's request of multiple kprobe for bpf[2].
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
fprobe exit handler)[3].

[2] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#u
[3] https://lore.kernel.org/all/164191321766.806991.7930388561276940676.stgit@devnote2/T/#u

The rethook is basically same as the kretprobe trampoline. I just made
it decoupled from kprobes. Eventually, the all arch dependent kretprobe
trampolines will be replaced with the rethook trampoline instead of
cloning and set HAVE_RETHOOK=y.
When I port the rethook for all arch which supports kretprobe, the
legacy kretprobe specific code (which is for CONFIG_KRETPROBE_ON_RETHOOK=n)
will be removed eventually.


Thank you,

---

Masami Hiramatsu (3):
      kprobes: Use rethook for kretprobe if possible
      x86,rethook,kprobes: Replace kretprobe with rethook on x86
      x86,kprobes: Fix optprobe trampoline to generate complete pt_regs

Peter Zijlstra (1):
      x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs


 arch/Kconfig                     |    8 ++
 arch/x86/Kconfig                 |    1 
 arch/x86/include/asm/unwind.h    |   23 +++----
 arch/x86/kernel/Makefile         |    1 
 arch/x86/kernel/kprobes/common.h |    1 
 arch/x86/kernel/kprobes/core.c   |  106 --------------------------------
 arch/x86/kernel/kprobes/opt.c    |   25 +++++--
 arch/x86/kernel/rethook.c        |  127 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/unwind_orc.c     |   10 +--
 include/linux/kprobes.h          |   51 +++++++++++++++
 kernel/Makefile                  |    1 
 kernel/kprobes.c                 |  124 +++++++++++++++++++++++++++++++------
 kernel/trace/trace_kprobe.c      |    4 +
 13 files changed, 325 insertions(+), 157 deletions(-)
 create mode 100644 arch/x86/kernel/rethook.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
