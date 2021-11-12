Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F844E1AC
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhKLFsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:48:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37608 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhKLFsL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 00:48:11 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC5T4ji020998
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:45:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mjEUJsJziQQwmn+P/3yhywfNIRO8Hilhk8hoMqZicsQ=;
 b=gl5nVDBGPIab0cusGE1Lv34cvIJbYWkx4Frf499E8pvWSNhzR6cnHB9zFDtB0Gw8BL/6
 5QL81kXJF7FzYgCEEfjNvZntrkSGZSz1y8VEXpro9yU1CZmGDjNzv6gnkPEYkFmiEjwo
 dUv7J/TGWXRdl/JwlHC05aPltkfh4Zm5Ztg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k53mrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:45:20 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 21:45:18 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1D5C01F860C32; Thu, 11 Nov 2021 21:45:12 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/perf: fix snapshot_branch_stack warning in VM
Date:   Thu, 11 Nov 2021 21:45:10 -0800
Message-ID: <20211112054510.2667030-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: chX2l3DulPnSSXQ7IKB3xE_IeiceK7fJ
X-Proofpoint-GUID: chX2l3DulPnSSXQ7IKB3xE_IeiceK7fJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_02,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running in VM intel_pmu_snapshot_branch_stack triggers WRMSR warning
like:

[  252.599708] unchecked MSR access error: WRMSR to 0x3f1 (tried to write=
 0x0000000000000000) at rIP: 0xffffffff81011a5b (intel_pmu_snapshot_branc=
h_stack+0x3b/0xd0)
[  252.601886] Call Trace:
[  252.602215]  <TASK>
[  252.602516]  bpf_get_branch_snapshot+0x17/0x40
[  252.603109]  bpf_prog_5c58f41f99af93ce_test1+0x33/0xd54
[  252.603777]  bpf_trampoline_15032502913_0+0x4c/0x1000
[  252.604435]  bpf_testmod_loop_test+0x5/0x20 [bpf_testmod]
[  252.605127]  bpf_testmod_test_read+0x8f/0x3b0 [bpf_testmod]
[  252.605864]  ? bpf_testmod_loop_test+0x20/0x20 [bpf_testmod]
[  252.606612]  ? __kasan_kmalloc+0x84/0xa0
[  252.607146]  ? lock_is_held_type+0xd8/0x130
[  252.607736]  ? sysfs_kf_bin_read+0xbe/0x110
[  252.608513]  ? bpf_testmod_loop_test+0x20/0x20 [bpf_testmod]
[  252.609332]  kernfs_fop_read_iter+0x1ac/0x2c0
[  252.609901]  ? kernfs_create_link+0x110/0x110
[  252.610509]  new_sync_read+0x25a/0x380
[  252.610994]  ? __x64_sys_llseek+0x1e0/0x1e0
[  252.611538]  ? rcu_read_lock_sched_held+0xa1/0xd0
[  252.612165]  ? find_held_lock+0xac/0xd0
[  252.612700]  ? security_file_permission+0xe7/0x2c0
[  252.613326]  vfs_read+0x1a4/0x2a0
[  252.613780]  ksys_read+0xc0/0x160
[  252.614218]  ? vfs_write+0x510/0x510
[  252.614684]  ? ktime_get_coarse_real_ts64+0xe4/0xf0
[  252.615423]  do_syscall_64+0x3a/0x80
[  252.615886]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  252.616553] RIP: 0033:0x7f62aa7f08b2
[  252.617011] Code: 97 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0=
f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 96 db 20 00 85 c0 75 12 31 c0 0f 05=
 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
[  252.619333] RSP: 002b:00007ffe72c83628 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
[  252.620252] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f62a=
a7f08b2
[  252.621138] RDX: 0000000000000064 RSI: 0000000000000000 RDI: 000000000=
0000028
[  252.622035] RBP: 00007ffe72c83660 R08: 0000000000000000 R09: 00007ffe7=
2c83507
[  252.622951] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
040d090
[  252.623890] R13: 00007ffe72c83900 R14: 0000000000000000 R15: 000000000=
0000000
[  252.624829]  </TASK>

This can be triggered with BPF selftests:

  tools/testing/selftests/bpf/test_progs -t get_branch_snapshot

This warning is caused by __intel_pmu_pebs_disable_all() in the VM. Since
it is not necessary to disable PEBs for LBR, remove it from
intel_pmu_snapshot_branch_stack and intel_pmu_snapshot_arch_branch_stack.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/intel/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 42cf01ecdd131..ec6444f2c9dcb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2211,7 +2211,6 @@ intel_pmu_snapshot_branch_stack(struct perf_branch_=
entry *entries, unsigned int
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
@@ -2225,7 +2224,6 @@ intel_pmu_snapshot_arch_branch_stack(struct perf_br=
anch_entry *entries, unsigned
 	/* must not have branches... */
 	local_irq_save(flags);
 	__intel_pmu_disable_all(false); /* we don't care about BTS */
-	__intel_pmu_pebs_disable_all();
 	__intel_pmu_arch_lbr_disable();
 	/*            ... until here */
 	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
--=20
2.30.2

