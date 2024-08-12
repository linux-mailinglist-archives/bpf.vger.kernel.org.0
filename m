Return-Path: <bpf+bounces-36951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15D94F91B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7C51C20DEA
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C41194A6C;
	Mon, 12 Aug 2024 21:49:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3B4D112
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499346; cv=none; b=NA0UjZy67xVZrpjRN8zziwdtf9xquqwERFcmd4A8kw2wtNg7CYWtY0/obbafzWMexb1yRcQxBojj491P2l5+d7xAXtjMo3ndKuR6G/Y0HFJcxPE7hqjCqvmj81kHjGDaRQD6RkY5nVY5//a6ctSlBetQYx+xAcu95oronGkyUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499346; c=relaxed/simple;
	bh=eNPVlfchbyHdZzTWUMi0tPH99vYLTnh18h87Vot3/Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr60Mlu1NJLsV2eBs6GdI+jvXLSnwMEOi0OpmR4JlqqOZZV1aVkCV/fIeEqsnJ9kYwrQRnnXKavQGhcDADw8kkgH1RF4eBaNtxrqQX9M9zbDdakBnSI8slnNf/ZjnhS85i5OLWxMcFhBKBZateIQz51K0E60ZGAdnfNpjPWpn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B7E117A9E9E6; Mon, 12 Aug 2024 14:48:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH bpf v2 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Date: Mon, 12 Aug 2024 14:48:47 -0700
Message-ID: <20240812214847.213612-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel Hodges reported a kernel verifier crash when playing with sched-ex=
t.
The crash dump looks like below:

  [   65.874474] BUG: kernel NULL pointer dereference, address: 000000000=
0000088
  [   65.888406] #PF: supervisor read access in kernel mode
  [   65.898682] #PF: error_code(0x0000) - not-present page
  [   65.908957] PGD 0 P4D 0
  [   65.914020] Oops: 0000 [#1] SMP
  [   65.920300] CPU: 19 PID: 9364 Comm: scx_layered Kdump: loaded Tainte=
d: G S          E      6.9.5-g93cea04637ea-dirty #7
  [   65.941874] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta La=
ke-Class1, BIOS F0E_3A19 04/27/2023
  [   65.960664] RIP: 0010:states_equal+0x3ee/0x770
  [   65.969559] Code: 33 85 ed 89 e8 41 0f 48 c7 83 e0 f8 89 e9 29 c1 48=
 63 c1 4c 89 e9 48 c1 e1 07 49 8d 14 08 0f
                 b6 54 10 78 49 03 8a 58 05 00 00 <3a> 54 08 78 0f 85 60 =
03 00 00 49 c1 e5 07 43 8b 44 28 70 83 e0 03
  [   66.007120] RSP: 0018:ffffc9000ebeb8b8 EFLAGS: 00010202
  [   66.017570] RAX: 0000000000000000 RBX: ffff888149719680 RCX: 0000000=
000000010
  [   66.031843] RDX: 0000000000000000 RSI: ffff88907f4e0c08 RDI: ffff888=
1572f0000
  [   66.046115] RBP: 0000000000000000 R08: ffff8883d5014000 R09: fffffff=
f83065d50
  [   66.060386] R10: ffff8881bf9a1800 R11: 0000000000000002 R12: 0000000=
000000000
  [   66.074659] R13: 0000000000000000 R14: ffff888149719a40 R15: 0000000=
000000007
  [   66.088932] FS:  00007f5d5da96800(0000) GS:ffff88907f4c0000(0000) kn=
lGS:0000000000000000
  [   66.105114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   66.116606] CR2: 0000000000000088 CR3: 0000000388261001 CR4: 0000000=
0007706f0
  [   66.130873] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [   66.145145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [   66.159416] PKRU: 55555554
  [   66.164823] Call Trace:
  [   66.169709]  <TASK>
  [   66.173906]  ? __die_body+0x66/0xb0
  [   66.180890]  ? page_fault_oops+0x370/0x3d0
  [   66.189082]  ? console_unlock+0xb5/0x140
  [   66.196926]  ? exc_page_fault+0x4f/0xb0
  [   66.204597]  ? asm_exc_page_fault+0x22/0x30
  [   66.212974]  ? states_equal+0x3ee/0x770
  [   66.220643]  ? states_equal+0x529/0x770
  [   66.228312]  do_check+0x60f/0x5240
  [   66.235114]  do_check_common+0x388/0x840
  [   66.242960]  do_check_subprogs+0x101/0x150
  [   66.251150]  bpf_check+0x5d5/0x4b60
  [   66.258134]  ? __mod_memcg_state+0x79/0x110
  [   66.266506]  ? pcpu_alloc+0x892/0xba0
  [   66.273829]  bpf_prog_load+0x5bb/0x660
  [   66.281324]  ? bpf_prog_bind_map+0x1e1/0x290
  [   66.289862]  __sys_bpf+0x29d/0x3a0
  [   66.296664]  __x64_sys_bpf+0x18/0x20
  [   66.303811]  do_syscall_64+0x6a/0x140
  [   66.311133]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Forther investigation shows that the crash is due to invalid memory acces=
s in stacksafe().
More specifically, it is the following code:

    if (exact !=3D NOT_EXACT &&
        old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
        cur->stack[spi].slot_type[i % BPF_REG_SIZE])
            return false;

If cur->allocated_stack is 0, cur->stack will be a ZERO_SIZE_PTR. If this=
 happens,
cur->stack[spi].slot_type[i % BPF_REG_SIZE] will crash the kernel as the =
memory
address is illegal. This is exactly what happened in the above crash dump=
.
If cur->allocated_stack is not 0, the above code could trigger array out-=
of-bound
access.

The patch added a condition 'i >=3D cur->allocated_stack' such that if
the condition is true, stacksafe() should fail. Otherwise,
cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access is always legal=
.

Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergen=
ce checks")
Cc: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Daniel Hodges <hodgesd@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Changelogs:
  v1 -> v2:
    - If 'i >=3D cur->allocated_stack' during !NOT_EXACT slot_type compar=
isoon, return false.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cb5441ad75f..d8520095ca03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16884,8 +16884,9 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
 		spi =3D i / BPF_REG_SIZE;
=20
 		if (exact !=3D NOT_EXACT &&
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		    (i >=3D cur->allocated_stack ||
+		     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
+		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
 			return false;
=20
 		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
--=20
2.43.5


