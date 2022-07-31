Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346C585FC1
	for <lists+bpf@lfdr.de>; Sun, 31 Jul 2022 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiGaQST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiGaQSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 12:18:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646CE02B
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 09:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63084B80D86
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 16:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB05AC433C1;
        Sun, 31 Jul 2022 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659284295;
        bh=MuyAgoqIZD+cqDm8CsMc6vo/EnPl8z9KCDEOhgnJvyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z7+aY91NmwEqBeZmJuHrFciMrej6uRjQaGued6k+huzBRjqqBNJSILbAaEI/DcNym
         XALCPRjZAilwcMvKE0XzKBLPXQuVm/eEEQa4Nj4q70rJ1FrFsV3U5NB9Aq6+4t7Syd
         t/WWA5VqxpsH21mot4N2jcs1rGz3/UrWrjeB22qiOPy/CT5ig8vFWDhBAKOCvkwFeF
         5G+0gTGQSkbrl0EqggYyvM3p4Rvi6wMV6JpAK4TKjsB9ZRMvRMDZOToFyB+2Gnf2RC
         nGjQ2rRhFJ9XAfIP9PgqXvLo+cxLvdntFMdjJddKHgOaGbpiE3vH29Kx0zRJ90oq5/
         sHWaob9Gfhs/w==
Date:   Mon, 1 Aug 2022 01:18:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Daniel =?UTF-8?B?TcO8bGxlcg==?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, mhiramat@kernel.org, kernel-team@fb.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra (Intel) <peterz@infradead.org>
Subject: Re: [BUG] kernel NULL pointer dereference in kprobe_int3_handler
Message-Id: <20220801011811.0dab20cc218ee30691dcdae9@kernel.org>
In-Reply-To: <20220727210136.jjgc3lpqeq42yr3m@muellerd-fedora-PC2BDTX9>
References: <20220727210136.jjgc3lpqeq42yr3m@muellerd-fedora-PC2BDTX9>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 27 Jul 2022 21:01:36 +0000
Daniel Müller <deso@posteo.net> wrote:

> Hi,
> 
> I've seen a NULL pointer dereference in kprobe_int3_handler, in code that seems
> to have gotten added with 6256e668b7af9 ("x86/kprobes: Use int3 instead of debug
> trap for single-step").
> Specifically, our CI has reported the following (running test_progs-no_alu32):
> 
>   [ 1033.068258] test_progs-no_a[1177] is installing a program with bpf_probe_write_user helper that may corrupt user memory!
>   [ 1040.264691] BUG: kernel NULL pointer dereference, address: 0000000000000058
>   [ 1040.264856] #PF: supervisor read access in kernel mode
>   [ 1040.264890] #PF: error_code(0x0000) - not-present page
>   [ 1040.264961] PGD 0 P4D 0 
>   [ 1040.265183] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [ 1040.265183] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W  OE     5.19.0-rc7-g4129b786299d #1
>   [ 1040.265183] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   [ 1040.265183] RIP: 0010:kprobe_int3_handler+0xd4/0x1a0
>   [ 1040.265183] Code: 49 8b 06 48 83 e8 02 48 a9 fd ff ff ff 75 d0 48 c7 c7 32 cc 2b 82 e8 eb d5 9a 00 48 8b 95 80 00 00 00 65 48 8b 3d 74 62 fc 7e <48> 8b 47 58 48 39 d0 73 ac 48 8d 48 0f 48 39 ca 73 a3 48 8b 4f 28
>   [ 1040.265183] RSP: 0018:ffffb4140009bd40 EFLAGS: 00000092
>   [ 1040.265183] RAX: 0000000000000001 RBX: ffffffff81a04cb9 RCX: 0000000000000000
>   [ 1040.265183] RDX: ffffffff81a04cb9 RSI: ffffffff822bcc32 RDI: 0000000000000000
>   [ 1040.265183] RBP: ffffb4140009bd98 R08: 000000000003929b R09: 0000000000000000
>   [ 1040.265183] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   [ 1040.265183] R13: ffffffff81a04cb8 R14: ffff9490b9c5b1e0 R15: 0000000000000000
>   [ 1040.265183] FS:  0000000000000000(0000) GS:ffff9490b9c40000(0000) knlGS:0000000000000000
>   [ 1040.265183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1040.265183] CR2: 0000000000000058 CR3: 0000000028836000 CR4: 00000000000006e0
>   [ 1040.265183] Call Trace:
>   [ 1040.265183]  <TASK>
>   [ 1040.265183]  do_int3+0xf/0x50
>   [ 1040.265183]  exc_int3+0x87/0xd0
>   [ 1040.265183]  asm_exc_int3+0x35/0x40
>   [ 1040.265183] RIP: 0010:__schedule+0x3f9/0xbf0
>   [ 1040.265183] Code: 83 5a fe ff ff 65 ff 05 e5 61 61 7e 48 8b 05 3e cb 68 01 48 85 c0 74 16 48 8b 78 08 4c 89 f1 4c 89 ea 44 8b 45 ac 8b 75 b8 e8 <53> 6c 79 ff 65 ff 0d bc 61 61 7e 0f 85 0d fe ff ff e8 a0 cf 5f ff
>   [ 1040.265183] RSP: 0018:ffffb4140009be70 EFLAGS: 00000086
>   [ 1040.265183] RAX: ffff9490056e0b90 RBX: ffff9490002f39e8 RCX: ffff949008758000
>   [ 1040.265183] RDX: ffff9490002f3300 RSI: 0000000000000000 RDI: 0000000000000000
>   [ 1040.265183] RBP: ffffb4140009bec8 R08: 0000000000000000 R09: 1dc944f200000000
>   [ 1040.265183] R10: 0000000000000001 R11: 0000000000080000 R12: ffff9490b9c6c8c0
>   [ 1040.265183] R13: ffff9490002f3300 R14: ffff949008758000 R15: ffff9490b9c6c8d8
>   [ 1040.265183]  ? __schedule+0x3f9/0xbf0
>   [ 1040.265183]  schedule_idle+0x26/0x40
>   [ 1040.265183]  do_idle+0x177/0x250
>   [ 1040.265183]  cpu_startup_entry+0x19/0x20
>   [ 1040.265183]  start_secondary+0xed/0xf0
>   [ 1040.265183]  secondary_startup_64_no_verify+0xe0/0xeb
>   [ 1040.265183]  </TASK>
>   [ 1040.265183] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod]
>   [ 1040.265183] CR2: 0000000000000058
>   [ 1040.265183] ---[ end trace 0000000000000000 ]---
>   [ 1040.265183] RIP: 0010:kprobe_int3_handler+0xd4/0x1a0
>   [ 1040.265183] Code: 49 8b 06 48 83 e8 02 48 a9 fd ff ff ff 75 d0 48 c7 c7 32 cc 2b 82 e8 eb d5 9a 00 48 8b 95 80 00 00 00 65 48 8b 3d 74 62 fc 7e <48> 8b 47 58 48 39 d0 73 ac 48 8d 48 0f 48 39 ca 73 a3 48 8b 4f 28
>   [ 1040.265183] RSP: 0018:ffffb4140009bd40 EFLAGS: 00000092
>   [ 1040.265183] RAX: 0000000000000001 RBX: ffffffff81a04cb9 RCX: 0000000000000000
>   [ 1040.265183] RDX: ffffffff81a04cb9 RSI: ffffffff822bcc32 RDI: 0000000000000000
>   [ 1040.265183] RBP: ffffb4140009bd98 R08: 000000000003929b R09: 0000000000000000
>   [ 1040.265183] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   [ 1040.265183] R13: ffffffff81a04cb8 R14: ffff9490b9c5b1e0 R15: 0000000000000000
>   [ 1040.265183] FS:  0000000000000000(0000) GS:ffff9490b9c40000(0000) knlGS:0000000000000000
>   [ 1040.265183] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1040.265183] CR2: 0000000000000058 CR3: 0000000028836000 CR4: 00000000000006e0
>   [ 1040.265183] Kernel panic - not syncing: Fatal exception in interrupt
>   [ 1040.265183] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> (it was sync'ed to somewhere around 40b09653b1977 ("selftests/bpf: Adjust
> vmtest.sh to use local kernel configuration"); I can probably piece together the
> exact kernel configuration if needed, but the inquiry is of a more general
> nature)
> 
> I am wondering what is the reason for us not checking whether kprobe_running
> returned a non-NULL pointer here (as we do elsewhere):
> https://elixir.bootlin.com/linux/v5.18.13/source/arch/x86/kernel/kprobes/core.c#L986
> ? Is that an oversight or should some kind of invariant be upheld at this point?
> 
> kprobe_int3_handler+0xd4/0x1a0 maps to line 987 in the above file. Address
> 0000000000000058 is exactly the offset that p->ainsn.insn is at, so it seems as
> if p is NULL.

Ah, good catch! I guess there is other int3 user in the kernel which is not
handled by kprobes. And kprobes missed to reset(clear) the state when !post_handler.


https://elixir.bootlin.com/linux/v5.18.13/source/arch/x86/kernel/kprobes/core.c#L814

static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
			       struct kprobe_ctlblk *kcb)
{
	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
		kcb->kprobe_status = KPROBE_HIT_SSDONE;	// this only set if cur->post_handler.
		cur->post_handler(cur, regs, 0);
	}

	/* Restore back the original saved kprobes variables and continue. */
	if (kcb->kprobe_status == KPROBE_REENTER)
		restore_previous_kprobe(kcb);
	else
		reset_current_kprobe();	// This only clear the current_kprobe (== kprobe_running())
}
NOKPROBE_SYMBOL(kprobe_post_process);

What about below patch?


From 66ac2a39c7d3d8a76d1ef989c0033831be24165e Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 1 Aug 2022 01:14:09 +0900
Subject: [PATCH] x86/kprobes: Fix to update kcb status flag after
 singlestepping
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix kprobes to update kcb (kprobes control block) status flag to
KPROBE_HIT_SSDONE even if the kp->post_handler is not set.
This may cause a kernel panic if another int3 user runs right
after kprobes because kprobe_int3_handler() misunderstands the
int3 is kprobe's single stepping int3.

Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Daniel Müller <deso@posteo.net>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7c4ab8870da4..74167dc5f55e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -814,16 +814,20 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
 			       struct kprobe_ctlblk *kcb)
 {
-	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		cur->post_handler(cur, regs, 0);
-	}
-
 	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER)
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		/* This will restore both kcb and current_kprobe */
 		restore_previous_kprobe(kcb);
-	else
+	} else {
+		/*
+		 * Always update the kcb status because
+		 * reset_curent_kprobe() doesn't update kcb.
+		 */
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (cur->post_handler)
+			cur->post_handler(cur, regs, 0);
 		reset_current_kprobe();
+	}
 }
 NOKPROBE_SYMBOL(kprobe_post_process);
 
-- 
2.25.1

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
