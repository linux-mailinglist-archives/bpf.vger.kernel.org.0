Return-Path: <bpf+bounces-18282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56481888E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E8E2840B5
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517018EAE;
	Tue, 19 Dec 2023 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQTVaq0p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57D18E13;
	Tue, 19 Dec 2023 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2340c803c6so324060166b.0;
        Tue, 19 Dec 2023 05:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702992207; x=1703597007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwcaPbKi8QnFAxKSbYWNRfJwjYBPl0UD3EkTy1k1RjI=;
        b=GQTVaq0p6ubvFbGrjS1/OLKzkdoxKaQ7MTuSrIP1jrseBWILFfPLH0l25e7O31voRI
         HDDYdXKimX1uXkw2+ajQCA2OR8SyJrQdkESq4/WSBNj2GSuTtfD7sZTc7+ZFbNBANM/n
         QPElhVvWhZAlc6YDTb1zAvp0ygSKazLDqmbvUhr3SuXZGxCGujotutWTL/PvurcmAEDX
         FGIyWrq8oggYS2hjnv7fFDzSAwPFyWKUaw1vC9h3q/lDykmOjD6ouXaVvcrHWDgo8472
         S8/y1vIaDGYYOzfo629QsJMy8GnJIbHgUwKCzpiT9adawPZJD/6Qc8wV75vSrKq7w3Ly
         41EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992207; x=1703597007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwcaPbKi8QnFAxKSbYWNRfJwjYBPl0UD3EkTy1k1RjI=;
        b=mQbD4QIboqJeFUNp0xqjXRWayjskSA/tRhVIxpMoJMw4Da0uFH4lpPw3FN2Lgbb/Bh
         EwJUGTcS02AwaghtFmVrh/pSK4lLoZdfIazB9yli5+GKaVv5bi+oC4KEdGtbc8cPPeOt
         Yrw5DpOoxMWs+J0tDORdX4THf5HKAw/yVLty+CumpVmVhr1aF2Zp1oeXuEoSzp+3UCqf
         XlizFZlEtskScJ4wAt0WRAkR3Z7rIHWDwI5sUwRgVVc0hmbAbkEvIwdObY4CQp00U3En
         l2DTkoXBeHtTR9CsGZ3Wsb5mI7ddaKlDO8EUk2MLA4fXohsAdLEhJxagy6BCK4PF7evt
         df2Q==
X-Gm-Message-State: AOJu0YxuFm0CYGRN8j08gXhfZ8ddaqh4gP33R5Y9ll19bGqWc9SnoufN
	mdl/7xKvMFOYSier1lSOYYA=
X-Google-Smtp-Source: AGHT+IEZ1Amm7e+11O4wvzisyYuM6SsjCmPFI7PGFSWOcJR3aOzCoXHG/Pwh8lzOtiMuJM/qi5IQ1g==
X-Received: by 2002:a17:906:bc56:b0:a23:5f70:a5f with SMTP id s22-20020a170906bc5600b00a235f700a5fmr1354003ejv.92.1702992206554;
        Tue, 19 Dec 2023 05:23:26 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id kt17-20020a1709079d1100b00a015eac52dcsm15306406ejc.108.2023.12.19.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:23:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Dec 2023 14:23:23 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 24/34] fprobe: Use ftrace_regs in fprobe entry handler
Message-ID: <ZYGZS190qqH-zUAB@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290538307.220107.14964448383069008953.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290538307.220107.14964448383069008953.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:16:23PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>

this change breaks kprobe multi bpf tests (crash below), which are
partially fixed by [1] later on, but I think we have to keep
bisecting crash free

it looks like the rethook will get wrong pointer.. I'm still trying
to digest the whole thing, so I might have some updates later ;-)

jirka


[1] fprobe: Rewrite fprobe on function-graph tracer
---
Dec 19 13:50:04 qemu kernel: BUG: kernel NULL pointer dereference, address: 0000000000000098
Dec 19 13:50:04 qemu kernel: #PF: supervisor read access in kernel mode
Dec 19 13:50:04 qemu kernel: #PF: error_code(0x0000) - not-present page
Dec 19 13:50:04 qemu kernel: PGD 10955f067 P4D 10955f067 PUD 103113067 PMD 0 
Dec 19 13:50:04 qemu kernel: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
Dec 19 13:50:04 qemu kernel: CPU: 1 PID: 747 Comm: test_progs Tainted: G    B      OE      6.7.0-rc3+ #194 85bc8297edbc7f21acfc743dabbd52cac073a6bf
Dec 19 13:50:04 qemu kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Dec 19 13:50:04 qemu kernel: RIP: 0010:arch_rethook_prepare+0x18/0x60
Dec 19 13:50:04 qemu kernel: Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 48 89 f5 53 48 89 fb 48 8d be 98 00 00 00 e8 68 8f 59 >
Dec 19 13:50:04 qemu kernel: RSP: 0018:ffff888125f97a88 EFLAGS: 00010286
Dec 19 13:50:04 qemu kernel: RAX: 0000000000000001 RBX: ffff88818a231410 RCX: ffffffff812190b6
Dec 19 13:50:04 qemu kernel: RDX: fffffbfff0c42e95 RSI: 0000000000000008 RDI: ffffffff862174a0
Dec 19 13:50:04 qemu kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0c42e94
Dec 19 13:50:04 qemu kernel: R10: ffffffff862174a7 R11: 0000000000000000 R12: ffff88818a231420
Dec 19 13:50:04 qemu kernel: R13: ffffffff8283ee8e R14: ffff88818a231410 R15: fffffffffffffff7
Dec 19 13:50:04 qemu kernel: FS:  00007ff8a16cfd00(0000) GS:ffff88842c600000(0000) knlGS:0000000000000000
Dec 19 13:50:05 qemu kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 19 13:50:05 qemu kernel: CR2: 0000000000000098 CR3: 000000010633c005 CR4: 0000000000770ef0
Dec 19 13:50:05 qemu kernel: PKRU: 55555554
Dec 19 13:50:05 qemu kernel: Call Trace:
Dec 19 13:50:05 qemu kernel:  <TASK>
Dec 19 13:50:05 qemu kernel:  ? __die+0x1f/0x70
Dec 19 13:50:05 qemu kernel:  ? page_fault_oops+0x215/0x620
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  ? __pfx_page_fault_oops+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
Dec 19 13:50:05 qemu kernel:  ? do_user_addr_fault+0x4b3/0x910
Dec 19 13:50:05 qemu kernel:  ? exc_page_fault+0x77/0x130
Dec 19 13:50:05 qemu kernel:  ? asm_exc_page_fault+0x22/0x30
Dec 19 13:50:05 qemu kernel:  ? bpf_prog_test_run_tracing+0x1ce/0x2d0
Dec 19 13:50:05 qemu kernel:  ? add_taint+0x26/0x90
Dec 19 13:50:05 qemu kernel:  ? arch_rethook_prepare+0x18/0x60
Dec 19 13:50:05 qemu kernel:  ? arch_rethook_prepare+0x18/0x60
Dec 19 13:50:05 qemu kernel:  ? bpf_prog_test_run_tracing+0x1ce/0x2d0
Dec 19 13:50:05 qemu kernel:  rethook_hook+0x1e/0x50
Dec 19 13:50:05 qemu kernel:  ? __pfx_bpf_fentry_test1+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? bpf_prog_test_run_tracing+0x1ce/0x2d0
Dec 19 13:50:05 qemu kernel:  fprobe_handler+0x1ca/0x350
Dec 19 13:50:05 qemu kernel:  ? __pfx_bpf_fentry_test1+0x10/0x10
Dec 19 13:50:05 qemu kernel:  arch_ftrace_ops_list_func+0x143/0x2e0
Dec 19 13:50:05 qemu kernel:  ? bpf_prog_test_run_tracing+0x1ce/0x2d0
Dec 19 13:50:05 qemu kernel:  ftrace_call+0x5/0x44
Dec 19 13:50:05 qemu kernel:  ? __pfx_lock_release+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  ? bpf_prog_test_run_tracing+0xcd/0x2d0
Dec 19 13:50:05 qemu kernel:  ? bpf_fentry_test1+0x5/0x10
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  bpf_fentry_test1+0x5/0x10
Dec 19 13:50:05 qemu kernel:  bpf_prog_test_run_tracing+0x1ce/0x2d0
Dec 19 13:50:05 qemu kernel:  ? __pfx_lock_release+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? __pfx_bpf_prog_test_run_tracing+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? __pfx_lock_release+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? __fget_light+0xdf/0x100
Dec 19 13:50:05 qemu kernel:  ? __bpf_prog_get+0x107/0x150
Dec 19 13:50:05 qemu kernel:  __sys_bpf+0x552/0x2ef0
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  ? __pfx___sys_bpf+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? __pfx_lock_release+0x10/0x10
Dec 19 13:50:05 qemu kernel:  ? vfs_write+0x1fa/0x740
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  ? rcu_is_watching+0x34/0x60
Dec 19 13:50:05 qemu kernel:  ? lockdep_hardirqs_on_prepare+0xe/0x250
Dec 19 13:50:05 qemu kernel:  ? seqcount_lockdep_reader_access.constprop.0+0x105/0x120
Dec 19 13:50:05 qemu kernel:  ? seqcount_lockdep_reader_access.constprop.0+0xb2/0x120
Dec 19 13:50:05 qemu kernel:  __x64_sys_bpf+0x44/0x60
Dec 19 13:50:05 qemu kernel:  do_syscall_64+0x3f/0xf0
Dec 19 13:50:05 qemu kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
Dec 19 13:50:05 qemu kernel: RIP: 0033:0x7ff8a1897b4d
Dec 19 13:50:05 qemu kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f >
Dec 19 13:50:05 qemu kernel: RSP: 002b:00007fff34f7d158 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
Dec 19 13:50:05 qemu kernel: RAX: ffffffffffffffda RBX: 00007ff8a19aa000 RCX: 00007ff8a1897b4d
Dec 19 13:50:05 qemu kernel: RDX: 0000000000000050 RSI: 00007fff34f7d190 RDI: 000000000000000a
Dec 19 13:50:05 qemu kernel: RBP: 00007fff34f7d170 R08: 0000000000000000 R09: 00007fff34f7d190
Dec 19 13:50:05 qemu kernel: R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000004
Dec 19 13:50:05 qemu kernel: R13: 0000000000000000 R14: 00007ff8a19df000 R15: 0000000000e56db0
Dec 19 13:50:05 qemu kernel:  </TASK>
Dec 19 13:50:05 qemu kernel: Modules linked in: bpf_testmod(OE) intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_inte>
Dec 19 13:50:05 qemu kernel: CR2: 0000000000000098
Dec 19 13:50:05 qemu kernel: ---[ end trace 0000000000000000 ]---

