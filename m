Return-Path: <bpf+bounces-10753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DEE7AD7CD
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 14:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 048121C20503
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB81B27C;
	Mon, 25 Sep 2023 12:15:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2D1429D;
	Mon, 25 Sep 2023 12:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF9C433C7;
	Mon, 25 Sep 2023 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695644122;
	bh=7Fw7uRUWuftgMpI5JoPbFGbJmDlLGvCn25cyvj5+HIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EiF6f5DTN+v5PrSFYkhMEPn2qUMyLC1qTvV7CpmfgopDayMbJ+MhHH/XyuPbwDKVS
	 eH5+bi81uTnQOZWJU2K7WmRpaaUAobIztyPtEFB62bVfrYiUni3KdCBtZqYFQiLDF5
	 R7iBRUAC1QndlcVx2IVeccHfbNDXYEq1e2L/4xMzkq5s08kq1QcAJyHEfByA2TC1mJ
	 NuF1VlZjEd7ldEv1NMiFXlw74wXk6bEYg7Q3At8lAE8hD+ksqxaf2iI00WsRDOCBT3
	 48IKph3X6kTgsHyOkXM+/nBNxgr354620rERJMztWaa9R1ZeQmWHCy/rk25aXTBNJ7
	 GWFT3GI4dETuA==
Date: Mon, 25 Sep 2023 21:15:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 04/12] fprobe: Use ftrace_regs in fprobe entry
 handler
Message-Id: <20230925211515.41d26a160c546c7bce08ac64@kernel.org>
In-Reply-To: <ZRFj97DJtbXc4naO@krava>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
	<169556259571.146934.4558592076420704031.stgit@devnote2>
	<ZRFj97DJtbXc4naO@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri,

On Mon, 25 Sep 2023 12:41:59 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Sun, Sep 24, 2023 at 10:36:36PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > on arm64.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> 
> I was getting bpf selftests failures with this patchset and when
> bisecting I'm getting crash when running on top of this change

Thanks for bisecting!

> 
> looks like it's missing some of the regs NULL checks added later?

yeah, if the RIP (arch_rethook_prepare+0x0/0x30) is correct, 

void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *fregs, bool mcount)

RSI (the 2nd argument) is NULL. This means fregs == NULL and caused the crash.
I think ftrace_get_regs(fregs) for the entry handler may return NULL.

Ah, 

@@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
 		fp->ops.func = fprobe_kprobe_handler;
 	else
 		fp->ops.func = fprobe_handler;
-	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
+	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
 }
 
 static int fprobe_init_rethook(struct fprobe *fp, int num)

This may cause the issue, it should keep REGS at this point (this must be done in
[9/12]). But after applying [9/12], it shouldn't be a problem... 

Let me check it again.

Thank you!

> 
> jirka
> 
> 
> ---
> [  124.089449][  T677] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [  124.090102][  T677] #PF: supervisor read access in kernel mode
> [  124.090568][  T677] #PF: error_code(0x0000) - not-present page
> [  124.091039][  T677] PGD 158fd8067 P4D 158fd8067 PUD 10896a067 PMD 0 
> [  124.091482][  T677] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [  124.091986][  T677] CPU: 1 PID: 677 Comm: test_progs Tainted: G           OE      6.6.0-rc2+ #768 1c8a8990289f2615e36dadd01915b80e8da29bf5
> [  124.092898][  T677] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [  124.093613][  T677] RIP: 0010:arch_rethook_prepare+0x0/0x30
> [  124.094060][  T677] Code: 90 90 90 90 90 90 90 90 90 90 48 89 b7 a8 00 00 00 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <48> 8b 86 98 00 00 00 48 8b 10 48 89 57 20 48 8b 96 98 00 00 00 48
> [  124.096239][  T677] RSP: 0018:ffffc90003d3bc98 EFLAGS: 00010286
> [  124.096708][  T677] RAX: 0000000000000000 RBX: ffff88815d9fbe50 RCX: ffff88815d9fbe40
> [  124.097332][  T677] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88815d9fbe40
> [  124.097946][  T677] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000004
> [  124.098554][  T677] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81fbb7b0
> [  124.099108][  T677] R13: ffffffff81fbd47b R14: fffffffffffffff7 R15: ffff88815d9fbe40
> [  124.099720][  T677] FS:  00007f9c2063ed00(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
> [  124.100403][  T677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  124.100908][  T677] CR2: 0000000000000098 CR3: 0000000108e02002 CR4: 0000000000770ee0
> [  124.101537][  T677] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  124.102096][  T677] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
> [  124.102689][  T677] PKRU: 55555554
> [  124.102988][  T677] Call Trace:
> [  124.103303][  T677]  <TASK>
> [  124.103580][  T677]  ? __die+0x1f/0x70
> [  124.103928][  T677]  ? page_fault_oops+0x176/0x4d0
> [  124.104348][  T677]  ? __pte_offset_map_lock+0xa5/0x190
> [  124.104818][  T677]  ? do_user_addr_fault+0x73/0x870
> [  124.105277][  T677]  ? exc_page_fault+0x81/0x250
> [  124.105709][  T677]  ? asm_exc_page_fault+0x22/0x30
> [  124.106171][  T677]  ? bpf_prog_test_run_tracing+0x14b/0x2c0
> [  124.106675][  T677]  ? __pfx_bpf_fentry_test1+0x10/0x10
> [  124.107135][  T677]  ? __pfx_arch_rethook_prepare+0x10/0x10
> [  124.107598][  T677]  rethook_hook+0x10/0x30
> [  124.107966][  T677]  fprobe_handler+0x129/0x210
> [  124.108351][  T677]  ? __pfx_bpf_fentry_test1+0x10/0x10
> [  124.108796][  T677]  ? bpf_prog_test_run_tracing+0x14b/0x2c0
> [  124.109276][  T677]  arch_ftrace_ops_list_func+0xf2/0x200
> [  124.109708][  T677]  ftrace_call+0x5/0x44
> [  124.110060][  T677]  ? bpf_fentry_test1+0x5/0x10
> [  124.110463][  T677]  bpf_fentry_test1+0x5/0x10
> [  124.110881][  T677]  bpf_prog_test_run_tracing+0x14b/0x2c0
> [  124.111337][  T677]  __sys_bpf+0x305/0x2820
> [  124.111705][  T677]  __x64_sys_bpf+0x1a/0x30
> [  124.112053][  T677]  do_syscall_64+0x38/0x90
> [  124.116245][  T677]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  124.116688][  T677] RIP: 0033:0x7f9c20806b5d
> [  124.117078][  T677] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7b 92 0c 00 f7 d8 64 89 01 48
> [  124.118487][  T677] RSP: 002b:00007ffc615e5228 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
> [  124.119090][  T677] RAX: ffffffffffffffda RBX: 00007f9c20918000 RCX: 00007f9c20806b5d
> [  124.119698][  T677] RDX: 0000000000000050 RSI: 00007ffc615e5260 RDI: 000000000000000a
> [  124.120298][  T677] RBP: 00007ffc615e5240 R08: 0000000000000000 R09: 00007ffc615e5260
> [  124.120893][  T677] R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000001
> [  124.121486][  T677] R13: 0000000000000000 R14: 00007f9c2094d000 R15: 00000000011a8db0
> [  124.122156][  T677]  </TASK>
> [  124.122421][  T677] Modules linked in: bpf_testmod(OE) intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
> [  124.125064][  T677] CR2: 0000000000000098
> [  124.125431][  T677] ---[ end trace 0000000000000000 ]---
> [  124.125861][  T677] RIP: 0010:arch_rethook_prepare+0x0/0x30
> [  124.126316][  T677] Code: 90 90 90 90 90 90 90 90 90 90 48 89 b7 a8 00 00 00 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <48> 8b 86 98 00 00 00 48 8b 10 48 89 57 20 48 8b 96 98 00 00 00 48
> [  124.127761][  T677] RSP: 0018:ffffc90003d3bc98 EFLAGS: 00010286
> [  124.128238][  T677] RAX: 0000000000000000 RBX: ffff88815d9fbe50 RCX: ffff88815d9fbe40
> [  124.128856][  T677] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88815d9fbe40
> [  124.129502][  T677] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000004
> [  124.130129][  T677] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81fbb7b0
> [  124.130767][  T677] R13: ffffffff81fbd47b R14: fffffffffffffff7 R15: ffff88815d9fbe40
> [  124.131410][  T677] FS:  00007f9c2063ed00(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
> [  124.132084][  T677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  124.132600][  T677] CR2: 0000000000000098 CR3: 0000000108e02002 CR4: 0000000000770ee0
> [  124.133128][  T677] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  124.133698][  T677] DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
> [  124.134302][  T677] PKRU: 55555554
> [  124.134584][  T677] note: test_progs[677] exited with irqs disabled
> [  124.135192][  T677] note: test_progs[677] exited with preempt_count 2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

