Return-Path: <bpf+bounces-35816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD293E2D1
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A32A1F21C37
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1113B295;
	Sun, 28 Jul 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLOsPk+r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8831957F9;
	Sun, 28 Jul 2024 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128095; cv=none; b=M93gDDCPk9ls6O4iLdSFPqhyZf2h883DEhR1zgKVoYpuKEUXsK8hWexGkbSySrHLTuLgQpZcBgV6b+qH8j/JdzW+UPgAjeUNrnwOW5SgqoNtCNmz1gtfXLZq4ZLqKWGJdCyAn0+2yOcJ8JsZJQ8HY5Ys1GM27wABXna1IOnYFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128095; c=relaxed/simple;
	bh=L/GoA1tF2gCu+94ZbsKDs/BVkRgk6FSJklJuagUeHJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeItV51kugLqlOwWPfBNDEedgWzt/BaCT8r1L1z1DzRwddnuwXDZ2qMMdJD6teKvjaUbVhFd+v2GdMOu1NhCDDgcQSnrLBXXqcTExiyeUT29jVD2ueDVlUAAmmVDVdOZ2c02DeHisjUuPwinLjC3fJA9CN2+FsnXig/yb3yc2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLOsPk+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C3C32781;
	Sun, 28 Jul 2024 00:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128094;
	bh=L/GoA1tF2gCu+94ZbsKDs/BVkRgk6FSJklJuagUeHJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLOsPk+ruoYKxAmTjLX4jFQr670L8Y4vnoDolBHUeDNsDzulUkHwbE1WVDAadfvQt
	 y5BgGXGYEFGISKoc4DO0y1QOuLwnPMUuBMNLuZE0aEdajGaGPriuAR8+1PXvzGz/Tq
	 EA4Rg83YIkeL9Z0namEl4bBCu+EI8YtfrN7Vvpaq7E+y96J2RYHkywdjdQeu3csUEC
	 2jdHa8+ii5koqBD/JFzYUEa60GuQZidcWjDV1gBVeri595sMOh4toRFNwROFKiAPNz
	 /1JslHzJj2ghmlpsKixxfGevrqHCjh/+FvPeBEc79qD74y5nnFmHmD1yZgVIDu8buY
	 /9ysH1M6sFqIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	pulehui@huawei.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/15] selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT
Date: Sat, 27 Jul 2024 20:54:26 -0400
Message-ID: <20240728005442.1729384-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 7015843afcaf68c132784c89528dfddc0005e483 ]

Alexei reported that send_signal test may fail with nested CONFIG_PARAVIRT
configs. In this particular case, the base VM is AMD with 166 cpus, and I
run selftests with regular qemu on top of that and indeed send_signal test
failed. I also tried with an Intel box with 80 cpus and there is no issue.

The main qemu command line includes:

  -enable-kvm -smp 16 -cpu host

The failure log looks like:

  $ ./test_progs -t send_signal
  [   48.501588] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [test_progs:2225]
  [   48.503622] Modules linked in: bpf_testmod(O)
  [   48.503622] CPU: 9 PID: 2225 Comm: test_progs Tainted: G           O       6.9.0-08561-g2c1713a8f1c9-dirty #69
  [   48.507629] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  [   48.511635] RIP: 0010:handle_softirqs+0x71/0x290
  [   48.511635] Code: [...] 10 0a 00 00 00 31 c0 65 66 89 05 d5 f4 fa 7e fb bb ff ff ff ff <49> c7 c2 cb
  [   48.518527] RSP: 0018:ffffc90000310fa0 EFLAGS: 00000246
  [   48.519579] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 00000000000006e0
  [   48.522526] RDX: 0000000000000006 RSI: ffff88810791ae80 RDI: 0000000000000000
  [   48.523587] RBP: ffffc90000fabc88 R08: 00000005a0af4f7f R09: 0000000000000000
  [   48.525525] R10: 0000000561d2f29c R11: 0000000000006534 R12: 0000000000000280
  [   48.528525] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [   48.528525] FS:  00007f2f2885cd00(0000) GS:ffff888237c40000(0000) knlGS:0000000000000000
  [   48.531600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   48.535520] CR2: 00007f2f287059f0 CR3: 0000000106a28002 CR4: 00000000003706f0
  [   48.537538] Call Trace:
  [   48.537538]  <IRQ>
  [   48.537538]  ? watchdog_timer_fn+0x1cd/0x250
  [   48.539590]  ? lockup_detector_update_enable+0x50/0x50
  [   48.539590]  ? __hrtimer_run_queues+0xff/0x280
  [   48.542520]  ? hrtimer_interrupt+0x103/0x230
  [   48.544524]  ? __sysvec_apic_timer_interrupt+0x4f/0x140
  [   48.545522]  ? sysvec_apic_timer_interrupt+0x3a/0x90
  [   48.547612]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
  [   48.547612]  ? handle_softirqs+0x71/0x290
  [   48.547612]  irq_exit_rcu+0x63/0x80
  [   48.551585]  sysvec_apic_timer_interrupt+0x75/0x90
  [   48.552521]  </IRQ>
  [   48.553529]  <TASK>
  [   48.553529]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
  [   48.555609] RIP: 0010:finish_task_switch.isra.0+0x90/0x260
  [   48.556526] Code: [...] 9f 58 0a 00 00 48 85 db 0f 85 89 01 00 00 4c 89 ff e8 53 d9 bd 00 fb 66 90 <4d> 85 ed 74
  [   48.562524] RSP: 0018:ffffc90000fabd38 EFLAGS: 00000282
  [   48.563589] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83385620
  [   48.563589] RDX: ffff888237c73ae4 RSI: 0000000000000000 RDI: ffff888237c6fd00
  [   48.568521] RBP: ffffc90000fabd68 R08: 0000000000000000 R09: 0000000000000000
  [   48.569528] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8881009d0000
  [   48.573525] R13: ffff8881024e5400 R14: ffff88810791ae80 R15: ffff888237c6fd00
  [   48.575614]  ? finish_task_switch.isra.0+0x8d/0x260
  [   48.576523]  __schedule+0x364/0xac0
  [   48.577535]  schedule+0x2e/0x110
  [   48.578555]  pipe_read+0x301/0x400
  [   48.579589]  ? destroy_sched_domains_rcu+0x30/0x30
  [   48.579589]  vfs_read+0x2b3/0x2f0
  [   48.579589]  ksys_read+0x8b/0xc0
  [   48.583590]  do_syscall_64+0x3d/0xc0
  [   48.583590]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
  [   48.586525] RIP: 0033:0x7f2f28703fa1
  [   48.587592] Code: [...] 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d c5 23 14 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0
  [   48.593534] RSP: 002b:00007ffd90f8cf88 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [   48.595589] RAX: ffffffffffffffda RBX: 00007ffd90f8d5e8 RCX: 00007f2f28703fa1
  [   48.595589] RDX: 0000000000000001 RSI: 00007ffd90f8cfb0 RDI: 0000000000000006
  [   48.599592] RBP: 00007ffd90f8d2f0 R08: 0000000000000064 R09: 0000000000000000
  [   48.602527] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  [   48.603589] R13: 00007ffd90f8d608 R14: 00007f2f288d8000 R15: 0000000000f6bdb0
  [   48.605527]  </TASK>

In the test, two processes are communicating through pipe. Further debugging
with strace found that the above splat is triggered as read() syscall could
not receive the data even if the corresponding write() syscall in another
process successfully wrote data into the pipe.

The failed subtest is "send_signal_perf". The corresponding perf event has
sample_period 1 and config PERF_COUNT_SW_CPU_CLOCK. sample_period 1 means every
overflow event will trigger a call to the BPF program. So I suspect this may
overwhelm the system. So I increased the sample_period to 100,000 and the test
passed. The sample_period 10,000 still has the test failed.

In other parts of selftest, e.g., [1], sample_freq is used instead. So I
decided to use sample_freq = 1,000 since the test can pass as well.

  [1] https://lore.kernel.org/bpf/20240604070700.3032142-1-song@kernel.org/

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240605201203.2603846-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index b15b343ebb6b1..9adcda7f1fedc 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -156,7 +156,8 @@ static void test_send_signal_tracepoint(bool signal_thread)
 static void test_send_signal_perf(bool signal_thread)
 {
 	struct perf_event_attr attr = {
-		.sample_period = 1,
+		.freq = 1,
+		.sample_freq = 1000,
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
-- 
2.43.0


