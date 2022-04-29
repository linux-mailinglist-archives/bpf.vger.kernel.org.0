Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96151507E
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiD2QPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Apr 2022 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378728AbiD2QPM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Apr 2022 12:15:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA8CA0E9;
        Fri, 29 Apr 2022 09:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB126CE3381;
        Fri, 29 Apr 2022 16:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30C4C385AE;
        Fri, 29 Apr 2022 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248709;
        bh=FBoMneeOrnrJ3BE/m6VhhFiGFXn7KCDa6+5nhSmlnJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bNGJBQrmzpLgYVTZgguyfdQc1HT76btHUuq4hcwOr8jLNUXpZ2XO5DWfiOApqxJIC
         jHJ4QKTKV2aZ+mraTlmDb4/bUU+CfEum7xMSzpnVyTsRiiUUJNpgvYUH31y7uF7GuK
         ip402yOvPJkvcEgK5k44MV97X808qOXiektWBkBbnKIB9xfviUiJ6fFBTnICCIjGU8
         72v2j3d5yeSKjIA/W20vxAZV9xcb4fWvfkcig/qqa/wyhGlXbZZM77fc3o00oklQvl
         0N0c/cx6XpXuCFnd/ADJ9gvmKf2VoZS+ODVWLptnb+LQJCK1E9w2vxss0KaeRMebD+
         3sJzgPXVp9IwA==
Date:   Sat, 30 Apr 2022 01:11:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf v2 0/4] kprobes: rethook,ARM,arm64: Replace
 kretprobe trampoline with rethook
Message-Id: <20220430011143.81fbf5ad78bae43753aa2af4@kernel.org>
In-Reply-To: <YlW/CdzKGeSYqtHY@FVFF77S0Q05N.cambridge.arm.com>
References: <164937903547.1272679.7244379141135199176.stgit@devnote2>
        <YlW/CdzKGeSYqtHY@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mark,

Sorry for replying this late.

On Tue, 12 Apr 2022 19:03:53 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Apr 08, 2022 at 09:50:35AM +0900, Masami Hiramatsu wrote:
> > Hi,
> 
> Hi,
> 
> > Here is the 2nd version of the series for replacing kretprobe trampoline
> > with rethook on ARM/arm64. I fixed some compiler warnings in this version.
> 
> What tree is this based on? It doesn't cleanly apply atop v5.18-rc1:

I worked on bpf tree, but I'll try rebasing on the latest linus tree
(or arm/arm64 tree) in the next version.

> 
> | [mark@lakrids:~/src/linux]% git am v2_20220408_mhiramat_kprobes_rethook_arm_arm64_replace_kretprobe_trampoline_with_rethook.mbx
> | Applying: ARM: unwind: Initialize the lr_addr field of unwind_ctrl_block
> | Applying: rethook,fprobe,kprobes: Check a failure in the rethook_hook()
> | Applying: ARM: rethook: Replace kretprobe trampoline with rethook
> | error: patch failed: arch/arm/kernel/stacktrace.c:66
> | error: arch/arm/kernel/stacktrace.c: patch does not apply
> | Patch failed at 0003 ARM: rethook: Replace kretprobe trampoline with rethook
> | hint: Use 'git am --show-current-patch=diff' to see the failed patch
> | When you have resolved this problem, run "git am --continue".
> | If you prefer to skip this patch, run "git am --skip" instead.
> | To restore the original branch and stop patching, run "git am --abort".
> 
> I've done a `git am -3` locally to make that work for now.
> 
> > The previous version is here[1];
> > 
> > [1] https://lore.kernel.org/all/164915121498.982637.12787715964983738566.stgit@devnote2/T/#u
> > 
> > This series includes a trivial bugfix for the arm unwinder to initialize
> > an internal data structure([1/4]). This is not critical for stack trace,
> > but required for rethook to find the LR register from the stack.
> > This also have an update for the rethook interface, which allows us to
> > check the rethook_hook() failure ([2/4]). This is also required for the
> > rethook on arm because unwinder is able to fail.
> > The rest of patches are replacing kretprobe trampoline with rethook on
> > ARM ([3/4]) and arm64 ([4/4]).
> 
> Generally, the arm and arm64 bits go via different trees, and for unwinding the
> two are quite different.

OK, Should I split this into 2 series?
Anyway, I'll send the first one for arm tree because this is a real bug.

> 
> IIUC the dependency between the two is just because patch 2 changes the
> prototypes of some functions. Is that right?

Yes. I can push it one by one. What is the best way, would you think?
If I split this into some series, I will;

- Send [1/4] to arm tree as a bugfix.
- Send [2/4] and [3/4] to arm tree as an enhancement.
- Send [4/4] to arm64 when above 2 series are merged.

Is that good for you?

> 
> 
> > Background:
> > 
> > This rethook came from Jiri's request of multiple kprobe for bpf[2].
> > He tried to solve an issue that starting bpf with multiple kprobe will
> > take a long time because bpf-kprobe will wait for RCU grace period for
> > sync rcu events.
> > 
> > Jiri wanted to attach a single bpf handler to multiple kprobes and
> > he tried to introduce multiple-probe interface to kprobe. So I asked
> > him to use ftrace and kretprobe-like hook if it is only for the
> > function entry and exit, instead of adding ad-hoc interface
> > to kprobes.
> > For this purpose, I introduced the fprobe (kprobe like interface for
> > ftrace) with the rethook (this is a generic return hook feature for
> > fprobe exit handler)[3].
> > 
> > [2] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#u
> > [3] https://lore.kernel.org/all/164191321766.806991.7930388561276940676.stgit@devnote2/T/#u
> > 
> > The rethook is basically same as the kretprobe trampoline. I just made
> > it decoupled from kprobes. Eventually, the all arch dependent kretprobe
> > trampolines will be replaced with the rethook trampoline instead of
> > cloning the code.
> > 
> > When I port the rethook for all arch which supports kretprobe, the
> > legacy kretprobe specific code (which is for CONFIG_KRETPROBE_ON_RETHOOK=n)
> > will be removed eventually.
> > 
> > BTW, the arm Clang support for rethook is for kretprobes only. fprobe
> > and ftrace seems not working with Clang yet.
> 
> Do you mean that's an existing issue?

Yes, but the above is not enough, Clang on arm and dynamic ftrace doesn't work.
Perhaps, Clang on arm doesn't support -mrecord-mcount? 

Thank you,

> 
> Thanks,
> Mark.
> 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >       ARM: unwind: Initialize the lr_addr field of unwind_ctrl_block
> >       rethook,fprobe,kprobes: Check a failure in the rethook_hook()
> >       ARM: rethook: Replace kretprobe trampoline with rethook
> >       arm64: rethook: Replace kretprobe trampoline with rethook
> > 
> > 
> >  arch/arm/Kconfig                              |    1 
> >  arch/arm/include/asm/stacktrace.h             |    5 +
> >  arch/arm/kernel/stacktrace.c                  |   13 +--
> >  arch/arm/kernel/unwind.c                      |    1 
> >  arch/arm/probes/Makefile                      |    1 
> >  arch/arm/probes/kprobes/core.c                |   62 ------------
> >  arch/arm/probes/rethook.c                     |  127 +++++++++++++++++++++++++
> >  arch/arm64/Kconfig                            |    1 
> >  arch/arm64/include/asm/kprobes.h              |    2 
> >  arch/arm64/include/asm/stacktrace.h           |    2 
> >  arch/arm64/kernel/Makefile                    |    1 
> >  arch/arm64/kernel/probes/Makefile             |    1 
> >  arch/arm64/kernel/probes/kprobes.c            |   15 ---
> >  arch/arm64/kernel/probes/kprobes_trampoline.S |   86 -----------------
> >  arch/arm64/kernel/rethook.c                   |   28 ++++++
> >  arch/arm64/kernel/rethook_trampoline.S        |   87 +++++++++++++++++
> >  arch/arm64/kernel/stacktrace.c                |    9 +-
> >  arch/x86/kernel/rethook.c                     |    4 +
> >  include/linux/rethook.h                       |    4 -
> >  kernel/kprobes.c                              |    8 +-
> >  kernel/trace/fprobe.c                         |    5 +
> >  kernel/trace/rethook.c                        |   12 ++
> >  22 files changed, 287 insertions(+), 188 deletions(-)
> >  create mode 100644 arch/arm/probes/rethook.c
> >  delete mode 100644 arch/arm64/kernel/probes/kprobes_trampoline.S
> >  create mode 100644 arch/arm64/kernel/rethook.c
> >  create mode 100644 arch/arm64/kernel/rethook_trampoline.S
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
