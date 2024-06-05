Return-Path: <bpf+bounces-31460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695128FD74E
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 22:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C953FB238C7
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77A15886C;
	Wed,  5 Jun 2024 20:12:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95B158858
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618345; cv=none; b=XnTpI953JW3rKrxjvGPCfvCrdLjqctknAZsbKEFQxzF1++ABqGedR7LBDWl70GAQQWqVAmDefWgX+D50GM4pIsd9nl2it/93sslkkjGECAYJ4mz16u3X2QxNNlvE1dBi4MGJDlGvo5f+SyCEdylF7/7C0OT3oFsP44rB/AgjQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618345; c=relaxed/simple;
	bh=dLkjqnHXznRDz8o+Ogs/2dkdg/rBl45DouhaTOVqTMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKUx6OSKle23eRdFKFb/cCdusQP5AxdsLoux/VzDJH8uXoolhW8zsDAHo7uefmQvPWY2GeJC0HYc+tmzk3W6moM0xJjOE6KhXLEssBxnP+aWu2Nn94sQVo/La5r0yLLi1URxI7Gi6sBPwoiqnu8sl7euurTHWuO0oQgE/kG33mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A53C5523CF4C; Wed,  5 Jun 2024 13:12:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT
Date: Wed,  5 Jun 2024 13:12:03 -0700
Message-ID: <20240605201203.2603846-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alexei reported that send_signal test may fail with
nested CONFIG_PARAVIRT configs. In this particular case,
the base vm is AMD with 166 cpus, and I run selftests
with regular qemu on top of that and indeed send_signal
test failed.  I also tried with an intel box with 80 cpus
and there is no issue.

The main qemu command line includes
  -enable-kvm -smp 16 -cpu host
The failure log looks like:
  $ ./test_progs -t send_signal
  [   48.501588] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [test_=
progs:2225]
  [   48.503622] Modules linked in: bpf_testmod(O)
  [   48.503622] CPU: 9 PID: 2225 Comm: test_progs Tainted: G           O=
       6.9.0-08561-g2c1713a8f1c9-dirty #69
  [   48.507629] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  [   48.511635] RIP: 0010:handle_softirqs+0x71/0x290
  [   48.511635] Code: 0f b7 25 f2 f4 fa 7e 65 81 05 cf f4 fa 7e 00 01 00=
 00 c7 44 24 10 0a 00 00 00 31 c0 65 66 89 05 d5 f4 fa 7e fb bb ff ff ff =
ff <49> c7 c2 cb
  [   48.518527] RSP: 0018:ffffc90000310fa0 EFLAGS: 00000246
  [   48.519579] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000=
0000006e0
  [   48.522526] RDX: 0000000000000006 RSI: ffff88810791ae80 RDI: 0000000=
000000000
  [   48.523587] RBP: ffffc90000fabc88 R08: 00000005a0af4f7f R09: 0000000=
000000000
  [   48.525525] R10: 0000000561d2f29c R11: 0000000000006534 R12: 0000000=
000000280
  [   48.528525] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
  [   48.528525] FS:  00007f2f2885cd00(0000) GS:ffff888237c40000(0000) kn=
lGS:0000000000000000
  [   48.531600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   48.535520] CR2: 00007f2f287059f0 CR3: 0000000106a28002 CR4: 0000000=
0003706f0
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
  [   48.556526] Code: 00 0f 1f 44 00 00 41 c7 44 24 34 00 00 00 00 49 8b=
 9f 58 0a 00 00 48 85 db 0f 85 89 01 00 00 4c 89 ff e8 53 d9 bd 00 fb 66 =
90 <4d> 85 ed 74
  [   48.562524] RSP: 0018:ffffc90000fabd38 EFLAGS: 00000282
  [   48.563589] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fffffff=
f83385620
  [   48.563589] RDX: ffff888237c73ae4 RSI: 0000000000000000 RDI: ffff888=
237c6fd00
  [   48.568521] RBP: ffffc90000fabd68 R08: 0000000000000000 R09: 0000000=
000000000
  [   48.569528] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888=
1009d0000
  [   48.573525] R13: ffff8881024e5400 R14: ffff88810791ae80 R15: ffff888=
237c6fd00
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
  [   48.587592] Code: ff ff eb c3 67 e8 2f c9 01 00 66 2e 0f 1f 84 00 00=
 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d c5 23 14 00 00 74 13 31 c0 0f =
05 <48> 3d 00 f0
  [   48.593534] RSP: 002b:00007ffd90f8cf88 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
  [   48.595589] RAX: ffffffffffffffda RBX: 00007ffd90f8d5e8 RCX: 00007f2=
f28703fa1
  [   48.595589] RDX: 0000000000000001 RSI: 00007ffd90f8cfb0 RDI: 0000000=
000000006
  [   48.599592] RBP: 00007ffd90f8d2f0 R08: 0000000000000064 R09: 0000000=
000000000
  [   48.602527] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000000
  [   48.603589] R13: 00007ffd90f8d608 R14: 00007f2f288d8000 R15: 0000000=
000f6bdb0
  [   48.605527]  </TASK>

In the test, two processes are communicated through pipe.
Furhter debugging with strace found that the above splat is
triggered as read() syscall could not receive the data
even if the corresponding write() syscall in another process
successfully wrote data into the pipe.

The failed subtest is "send_signal_perf". The corresponding perf event
has sample_period 1 and config PERF_COUNT_SW_CPU_CLOCK.
sample_period 1 means every overflow event will trigger a call to
bpf program. So I suspect this may overwhelm the system. So I increased
the sample_period to 100000 and the test passed. The sample_period 10000
still has the test failed.

In other parts of selftest, e.g., [1], sample_freq is used instead.
So I decided to use sample_freq =3D 1000 since the test can pass as well.

  [1] https://lore.kernel.org/bpf/20240604070700.3032142-1-song@kernel.or=
g/

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
index 920aee41bd58..6cc69900b310 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -156,7 +156,8 @@ static void test_send_signal_tracepoint(bool signal_t=
hread)
 static void test_send_signal_perf(bool signal_thread)
 {
 	struct perf_event_attr attr =3D {
-		.sample_period =3D 1,
+		.freq =3D 1,
+		.sample_freq =3D 1000,
 		.type =3D PERF_TYPE_SOFTWARE,
 		.config =3D PERF_COUNT_SW_CPU_CLOCK,
 	};
--=20
2.43.0


