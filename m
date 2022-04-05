Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6234F2DE5
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbiDEJyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 05:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348324AbiDEJrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 05:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36B6C4A5;
        Tue,  5 Apr 2022 02:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F3D616AE;
        Tue,  5 Apr 2022 09:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E929C385A3;
        Tue,  5 Apr 2022 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151222;
        bh=w3c3dan6gpCZQWuTtnrIYnuAybUzjLeMz5IygurzhmA=;
        h=From:To:Cc:Subject:Date:From;
        b=kgLWiwy+Hds+vv7jtXz+wCEvuU7WwMF35CGW4fvseZE4OkaO0Yd3mlyo8JYC5iVGO
         uFXJNuwwYiufvhErVF9rtRAmdMAf9QFUlIw7s4KblEqu3jiJThyfpg3Pdj8+c7iwdf
         UxPLbiN7DMMyuPqEy3eAHogBox9WvZxN+3hMUE1ZTkeIKi7wPxwfHpYUhsa5/P74Ip
         zvAM9pulY79SC6AVH6lREf4lMS+2cmOaJ9F38NH5jfAM9NjVU3vXQWjDxTkRizs/UN
         55Sb9mjiEDKfpWKYqFrIicR2UZpZH1V8ZYuPdzHZ2hjvMM4KXrADZ6HtyUUoFAZsj/
         H8FpvMavHtPzQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf 0/4] kprobes: rethook,ARM,arm64: Replace kretprobe trampoline with rethook
Date:   Tue,  5 Apr 2022 18:33:35 +0900
Message-Id: <164915121498.982637.12787715964983738566.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is a series for replacing kretprobe trampoline with rethook on ARM/arm64.
This series are applicable to bpf tree (not arm tree) because the basement
patch is still only on that tree.

Actually, this series includes a trivial bugfix for the arm unwinder to
initialize an internal data structure([1/4]). This is not critical for
stack trace, but required for rethook to find LR register on the stack.
This also have an update for the rethook interface, which allows us to
check the rethook_hook() failure ([2/4]). This is also required for the
rethook on arm because unwinder is able to fail.
The rest of patches are replacing kretprobe trampoline with rethook on
ARM ([3/4]) and arm64 ([4/4]).

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
cloning the code.

When I port the rethook for all arch which supports kretprobe, the
legacy kretprobe specific code (which is for CONFIG_KRETPROBE_ON_RETHOOK=n)
will be removed eventually.

BTW, the arm Clang support for rethook is for kretprobes only. fprobe
and ftrace seems not working with Clang yet.

Thank you,

---

Masami Hiramatsu (4):
      ARM: unwind: Initialize the lr_addr field of unwind_ctrl_block
      rethook,fprobe,kprobes: Check a failure in the rethook_hook()
      ARM: rethook: Replace kretprobe trampoline with rethook
      arm64: rethook: Replace kretprobe trampoline with rethook


 arch/arm/Kconfig                              |    1 
 arch/arm/include/asm/stacktrace.h             |    5 +
 arch/arm/kernel/stacktrace.c                  |   13 +--
 arch/arm/kernel/unwind.c                      |    1 
 arch/arm/probes/Makefile                      |    1 
 arch/arm/probes/kprobes/core.c                |   62 ------------
 arch/arm/probes/rethook.c                     |  127 +++++++++++++++++++++++++
 arch/arm64/Kconfig                            |    1 
 arch/arm64/include/asm/kprobes.h              |    2 
 arch/arm64/include/asm/stacktrace.h           |    2 
 arch/arm64/kernel/Makefile                    |    1 
 arch/arm64/kernel/probes/Makefile             |    1 
 arch/arm64/kernel/probes/kprobes.c            |   15 ---
 arch/arm64/kernel/probes/kprobes_trampoline.S |   86 -----------------
 arch/arm64/kernel/rethook.c                   |   26 +++++
 arch/arm64/kernel/rethook_trampoline.S        |   87 +++++++++++++++++
 arch/arm64/kernel/stacktrace.c                |    9 +-
 arch/x86/kernel/rethook.c                     |    4 +
 include/linux/rethook.h                       |    4 -
 kernel/kprobes.c                              |    8 +-
 kernel/trace/fprobe.c                         |    5 +
 kernel/trace/rethook.c                        |   12 ++
 22 files changed, 285 insertions(+), 188 deletions(-)
 create mode 100644 arch/arm/probes/rethook.c
 delete mode 100644 arch/arm64/kernel/probes/kprobes_trampoline.S
 create mode 100644 arch/arm64/kernel/rethook.c
 create mode 100644 arch/arm64/kernel/rethook_trampoline.S

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
