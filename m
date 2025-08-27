Return-Path: <bpf+bounces-66615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8971B37798
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF71207ECF
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA2A25B302;
	Wed, 27 Aug 2025 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uRJo7goV"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EF257835
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260822; cv=none; b=vAFMbn8cyOa5CaktI5NvKeCOfFr3QY69RdhbAQXZJPJrA6pvOhgsqjPJ9U4xKHvBPGDHsJcOJE8cUmf8+TvTt1HeVFJLma3HhZbF8QPzbaSFVizUPDEwPAl15cgApS05ZsaRG2QdDAGgI0DG3CpINensQ2OnsxYH0uxPd0EuUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260822; c=relaxed/simple;
	bh=aEbabt2clGxrEvCjNu5XUsBO5UC+QSq0Et+UeMUF3l0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BBu7WgGjZgiEzJj65w51D8uAPL0tbCt7BnGYKKJZ2YO9ixHusbc0Go6NIqK5s3WO13QbNle2iayEJLEIBMWCeaIKl42FOIHChszkJY9E/QD8bkbQ/rRu24Q3zRPR3UOzD0LXWWh15B8pofw7yjc6oWfZROh/AZOCYfbRUwC7VOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uRJo7goV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756260817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCxJZrKr0J60oso6+FPbYEnE1yQgvmOV+jzf3yRSjD4=;
	b=uRJo7goVD8B4pIr4m1IKNAHSdBDFXMcklIwWWpf+3Yeuh/CkkJGwkB5E7De+L+VfVoGSI1
	7JhCniElyZIEYAIPJRYCTD2FvDRaj6UXZg6FSr1dxP9vcUyhaWxierZB2xTfVpQTqrtYir
	vKqrw4EzX0KVIKn7sjWXCbnq5Ijny4A=
Date: Wed, 27 Aug 2025 10:13:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Subject: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

I’ve encountered a reproducible deadlock while developing the funcgraph
feature for bpfsnoop [0].

Even on the latest bpf-next_base commit
2465bb83e0b4 ("Merge branch
's390-bpf-add-s390-jit-support-for-timed-may_goto'"),
the issue still persists.

Reproduction:
1. Build bpfsnoop with Go 1.24 and LLVM 20.
2. Start a VM using vmtest [1].
3. Trigger the deadlock with:
   './bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug'

Logs:
[  126.934205] watchdog: CPU1: Watchdog detected hard LOCKUP on cpu 1
[  126.934406] Modules linked in:
[  126.934713] irq event stamp: 283284
[  126.934806] hardirqs last  enabled at (283283): [<ffffffffa7fa89f8>]
default_idle_call+0xb8/0x1d0
[  126.934925] hardirqs last disabled at (283284): [<ffffffffa73ac21f>]
tick_nohz_idle_exit+0x8f/0x110
[  126.935026] softirqs last  enabled at (283262): [<ffffffffa72a4a06>]
__irq_exit_rcu+0xa6/0xd0
[  126.935124] softirqs last disabled at (283255): [<ffffffffa72a4a06>]
__irq_exit_rcu+0xa6/0xd0
[  126.935518] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted
6.17.0-rc1-gcb708c11617a #23 PREEMPT(full)
[  126.935662] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  126.935865] RIP: 0010:__lock_acquire+0x30f/0x2590
[  126.935973] Code: 89 f8 45 89 f7 49 89 de 4c 89 e3 41 89 cc 48 89 c1
eb 3e 48 8d 04 80 48 8d 04 80 48 8d 34 c5 40 78 87 a9 0f b6 86 c4 00 00
00 <84> c0 74 12 41 38 c0 44 0f 47 c0 80 be c6 00 00 00 02 44 0f 44 c0
[  126.936062] RSP: 0018:ffffad20800ab008 EFLAGS: 00000007
[  126.936219] RAX: 0000000000000003 RBX: ffff97af803f2d18 RCX:
0000000000000000
[  126.936308] RDX: 0000000000000001 RSI: ffffffffa9877c28 RDI:
0000000000000007
[  126.936394] RBP: ffffad20800ab080 R08: 0000000000000003 R09:
0000000000000005
[  126.936480] R10: 0000000000000000 R11: 0000000000000007 R12:
0000000000000003
[  126.936566] R13: ffff97af803f2240 R14: ffff97af803f2db8 R15:
0000000000000000
[  126.936655] FS:  0000000000000000(0000) GS:ffff97b0126d8000(0000)
knlGS:0000000000000000
[  126.936744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.936830] CR2: 000000c0285a3000 CR3: 0000000102c62004 CR4:
0000000000770ef0
[  126.936918] PKRU: 55555554
[  126.937038] Call Trace:
[  126.937133]  <TASK>
[  126.937222]  ? __lock_acquire+0x43d/0x2590
[  126.937620]  lock_acquire+0xb1/0x2c0
[  126.937706]  ? __bpf_prog_enter_recur+0x2a/0x110
[  126.937826]  ? lock_release+0xc6/0x280
[  126.937910]  ? lock_release+0xc6/0x280
[  126.938006]  __bpf_prog_enter_recur+0x3e/0x110
[  126.938090]  ? __bpf_prog_enter_recur+0x2a/0x110
[  126.938204]  bpf_trampoline_6442539790+0x88/0x110
[  126.938301]  rcu_lockdep_current_cpu_online+0x9/0x70
[  126.938392]  ? rcu_read_lock_held+0x31/0x60
[  126.938501]  bpf_trampoline_6442539812+0x66/0x110
[  126.938594]  rcu_read_lock_held+0x9/0x60
[  126.938678]  ? __htab_map_lookup_elem+0x25/0xf0
[  126.938798]  bpf_trampoline_6442491246+0x79/0x123
[  126.938894]  __htab_map_lookup_elem+0x9/0xf0
[  126.938991]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x129/0x14a
[  126.939080]  ? __htab_map_lookup_elem+0x9/0xf0
[  126.939182]  bpf_prog_1d471894f1fc624c_bpfsnoop_fgraph+0x12e/0x3e8
[  126.939285]  ? lock_release+0xc6/0x280
[  126.939381]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.939473]  bpf_trampoline_6442539790+0x4b/0x110
[  126.939566]  rcu_lockdep_current_cpu_online+0x9/0x70
[  126.939649]  ? rcu_read_lock_held+0x31/0x60
[  126.939737]  bpf_trampoline_6442539812+0x66/0x110
[  126.939829]  rcu_read_lock_held+0x9/0x60
[  126.939913]  ? __htab_map_lookup_elem+0x25/0xf0
[  126.940010]  bpf_trampoline_6442491246+0x79/0x123
[  126.940105]  __htab_map_lookup_elem+0x9/0xf0
[  126.940212]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x129/0x14a
[  126.940300]  ? rcu_lockdep_current_cpu_online+0x9/0x70
[  126.940402]  bpf_prog_1ed83077283e3ded_bpfsnoop_fgraph+0x12e/0x423
[  126.940517]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.940609]  bpf_trampoline_6442491246+0xac/0x123
[  126.940705]  __htab_map_lookup_elem+0x9/0xf0
[  126.940796]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x95/0x14a
[  126.940895]  ? bpf_prog_1d471894f1fc624c_bpfsnoop_fgraph+0x12e/0x3e8
[  126.940980]  ? bpf_prog_1d471894f1fc624c_bpfsnoop_fgraph+0x12e/0x3e8
[  126.941080]  bpf_prog_8c9f4824b35e5d8e_bpfsnoop_fgraph+0x12e/0x423
[  126.941181]  ? lock_release+0xc6/0x280
[  126.941265]  ? lock_release+0xc6/0x280
[  126.941360]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.941452]  bpf_trampoline_6442539790+0x99/0x110
[  126.941544]  rcu_lockdep_current_cpu_online+0x9/0x70
[  126.941627]  ? rcu_read_lock_held+0x31/0x60
[  126.941715]  bpf_trampoline_6442539812+0x66/0x110
[  126.941813]  rcu_read_lock_held+0x9/0x60
[  126.941896]  ? __htab_map_lookup_elem+0x25/0xf0
[  126.941993]  bpf_trampoline_6442491246+0x79/0x123
[  126.942089]  __htab_map_lookup_elem+0x9/0xf0
[  126.942186]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x95/0x14a
[  126.942276]  ? bpf_trampoline_6442539812+0x4b/0x110
[  126.942360]  ? bpf_trampoline_6442539812+0x4b/0x110
[  126.942446]  bpf_prog_8c9f4824b35e5d8e_bpfsnoop_fgraph+0x12e/0x423
[  126.942552]  ? __bpf_tramp_exit+0x72/0x130
[  126.942647]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.942739]  bpf_trampoline_6442539812+0x99/0x110
[  126.942832]  rcu_read_lock_held+0x9/0x60
[  126.942915]  ? __htab_map_lookup_elem+0x25/0xf0
[  126.943012]  bpf_trampoline_6442491246+0x79/0x123
[  126.943108]  __htab_map_lookup_elem+0x9/0xf0
[  126.943209]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x95/0x14a
[  126.943299]  ? bpf_trampoline_6442491246+0x79/0x123
[  126.943383]  ? bpf_trampoline_6442491246+0x79/0x123
[  126.943469]  bpf_prog_1d471894f1fc624c_bpfsnoop_fgraph+0x12e/0x3e8
[  126.943571]  ? lock_release+0xc6/0x280
[  126.943666]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.943758]  bpf_trampoline_6442539812+0x4b/0x110
[  126.943851]  rcu_read_lock_held+0x9/0x60
[  126.943934]  ? __htab_map_lookup_elem+0x25/0xf0
[  126.944031]  bpf_trampoline_6442491246+0x79/0x123
[  126.944126]  __htab_map_lookup_elem+0x9/0xf0
[  126.944235]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x129/0x14a
[  126.944345]  ? bpf_prog_5c5e9b8ca18045f2_bpfsnoop_fgraph+0x12e/0x3f2
[  126.944442]  bpf_prog_5c5b59f2388bb72a_bpfsnoop_fgraph+0x12e/0x3f2
[  126.944545]  ? lock_release+0xc6/0x280
[  126.944640]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.944732]  bpf_trampoline_6442491246+0x56/0x123
[  126.944828]  __htab_map_lookup_elem+0x9/0xf0
[  126.944931]  ?
bpf_prog_243665d136749c2c_bpfsnoop_fgraph_tailcallee+0x129/0x14a
[  126.945019]  ? tick_nohz_idle_exit+0xc9/0x110
[  126.945108]  bpf_prog_5c5e9b8ca18045f2_bpfsnoop_fgraph+0x12e/0x3f2
[  126.945210]  ? lock_release+0xc6/0x280
[  126.945305]  ? __bpf_prog_enter_recur+0x43/0x110
[  126.945411]  bpf_trampoline_6442519845+0x5e/0x133
[  126.945510]  hrtimer_start_range_ns+0x9/0x4b0
[  126.945603]  ? tick_nohz_restart_sched_tick+0x89/0xe0
[  126.945694]  tick_nohz_idle_exit+0xc9/0x110
[  126.945789]  do_idle+0x150/0x250
[  126.945890]  cpu_startup_entry+0x2d/0x30
[  126.945976]  start_secondary+0xfc/0x100
[  126.946069]  common_startup_64+0x12c/0x138
[  126.946197]  </TASK>

Full log: [2].

Additional information:
* Kernel version: 6.17.0-rc1-gcb708c11617a
* Config: [3].

Links:
[0] https://github.com/bpfsnoop/bpfsnoop
[1] https://github.com/danobi/vmtest
[2]
https://gist.githubusercontent.com/Asphaltt/88d11c49e62485f4d4f4a7664089c3cd/raw/f26c123c0ec5f3e5ac588844db51bbec0bb0f9c7/deadlock-crash.log
[3]
https://gist.githubusercontent.com/Asphaltt/88d11c49e62485f4d4f4a7664089c3cd/raw/f26c123c0ec5f3e5ac588844db51bbec0bb0f9c7/config

Thanks,
Leon


