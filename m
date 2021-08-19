Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4193F1D53
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhHSPwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 11:52:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28027 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232895AbhHSPws (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 11:52:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17JFq2vb007929
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 08:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ELEBgf9uHeX+VbXcnFZeI+nxus2QoaOW//CJB1hxpaY=;
 b=U0FLHeeL2DNNh1utgRQ+kPb00wWzYjd6Z6ZyaYw2LzqNN/b343CTRw2lXnG0sXWzAvPL
 rJvvr7RFVyonR1z1xz+xzuOnIRD13KYgJpfwjTaTsLbThJmqLeHs2LQl7H/ZN1G/FLJp
 K+nRfqIrmutaeHEVp/fUgbgq30J1yCc9Rgo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3ahq08hd3j-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 08:52:11 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 08:52:10 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C37AA6135653; Thu, 19 Aug 2021 08:52:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: fix NULL event->prog pointer access in bpf_overflow_handler
Date:   Thu, 19 Aug 2021 08:52:09 -0700
Message-ID: <20210819155209.1927994-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: dA-qo7bnj3_LC33EUly0eXpgATdqlyeb
X-Proofpoint-GUID: dA-qo7bnj3_LC33EUly0eXpgATdqlyeb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_05:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii reported that libbpf CI hit the following oops when
running selftest send_signal:
  [ 1243.160719] BUG: kernel NULL pointer dereference, address: 000000000=
0000030
  [ 1243.161066] #PF: supervisor read access in kernel mode
  [ 1243.161066] #PF: error_code(0x0000) - not-present page
  [ 1243.161066] PGD 0 P4D 0
  [ 1243.161066] Oops: 0000 [#1] PREEMPT SMP NOPTI
  [ 1243.161066] CPU: 1 PID: 882 Comm: new_name Tainted: G           O   =
   5.14.0-rc5 #1
  [ 1243.161066] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.13.0-1ubuntu1.1 04/01/2014
  [ 1243.161066] RIP: 0010:bpf_overflow_handler+0x9a/0x1e0
  [ 1243.161066] Code: 5a 84 c0 0f 84 06 01 00 00 be 66 02 00 00 48 c7 c7=
 6d 96 07 82 48 8b ab 18 05 00 00 e8 df 55 eb ff 66 90 48 8d 75 48 48 89 =
e7 <ff> 55 30 41 89 c4 e8 fb c1 f0 ff 84 c0 0f 84 94 00 00 00 e8 6e 0f
  [ 1243.161066] RSP: 0018:ffffc900000c0d80 EFLAGS: 00000046
  [ 1243.161066] RAX: 0000000000000002 RBX: ffff8881002e0dd0 RCX: 0000000=
0b4b47cf8
  [ 1243.161066] RDX: ffffffff811dcb06 RSI: 0000000000000048 RDI: ffffc90=
0000c0d80
  [ 1243.161066] RBP: 0000000000000000 R08: 0000000000000000 R09: 1a9d56b=
b00000000
  [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: 0000000=
000000000
  [ 1243.161066] R13: ffffc900000c0e00 R14: ffffc900001c3c68 R15: 0000000=
000000082
  [ 1243.161066] FS:  00007fc0be2d3380(0000) GS:ffff88813bd00000(0000) kn=
lGS:0000000000000000
  [ 1243.161066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1243.161066] CR2: 0000000000000030 CR3: 0000000104f8e000 CR4: 0000000=
0000006e0
  [ 1243.161066] Call Trace:
  [ 1243.161066]  <IRQ>
  [ 1243.161066]  __perf_event_overflow+0x4f/0xf0
  [ 1243.161066]  perf_swevent_hrtimer+0x116/0x130
  [ 1243.161066]  ? __lock_acquire+0x378/0x2730
  [ 1243.161066]  ? __lock_acquire+0x372/0x2730
  [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
  [ 1243.161066]  ? find_held_lock+0x2b/0x80
  [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
  [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
  [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
  [ 1243.161066]  __hrtimer_run_queues+0x1a3/0x460
  [ 1243.161066]  hrtimer_interrupt+0x110/0x220
  [ 1243.161066]  __sysvec_apic_timer_interrupt+0x8a/0x260
  [ 1243.161066]  sysvec_apic_timer_interrupt+0x89/0xc0
  [ 1243.161066]  </IRQ>
  [ 1243.161066]  asm_sysvec_apic_timer_interrupt+0x12/0x20
  [ 1243.161066] RIP: 0010:finish_task_switch+0xaf/0x250
  [ 1243.161066] Code: 31 f6 68 90 2a 09 81 49 8d 7c 24 18 e8 aa d6 03 00=
 4c 89 e7 e8 12 ff ff ff 4c 89 e7 e8 ca 9c 80 00 e8 35 af 0d 00 fb 4d 85 =
f6 <58> 74 1d 65 48 8b 04 25 c0 6d 01 00 4c 3b b0 a0 04 00 00 74 37 f0
  [ 1243.161066] RSP: 0018:ffffc900001c3d18 EFLAGS: 00000282
  [ 1243.161066] RAX: 000000000000031f RBX: ffff888104cf4980 RCX: 0000000=
000000000
  [ 1243.161066] RDX: 0000000000000000 RSI: ffffffff82095460 RDI: fffffff=
f820adc4e
  [ 1243.161066] RBP: ffffc900001c3d58 R08: 0000000000000001 R09: 0000000=
000000001
  [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: ffff888=
13bd2bc80
  [ 1243.161066] R13: ffff8881002e8000 R14: ffff88810022ad80 R15: 0000000=
000000000
  [ 1243.161066]  ? finish_task_switch+0xab/0x250
  [ 1243.161066]  ? finish_task_switch+0x70/0x250
  [ 1243.161066]  __schedule+0x36b/0xbb0
  [ 1243.161066]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
  [ 1243.161066]  ? lockdep_hardirqs_on+0x79/0x100
  [ 1243.161066]  schedule+0x43/0xe0
  [ 1243.161066]  pipe_read+0x30b/0x450
  [ 1243.161066]  ? wait_woken+0x80/0x80
  [ 1243.161066]  new_sync_read+0x164/0x170
  [ 1243.161066]  vfs_read+0x122/0x1b0
  [ 1243.161066]  ksys_read+0x93/0xd0
  [ 1243.161066]  do_syscall_64+0x35/0x80
  [ 1243.161066]  entry_SYSCALL_64_after_hwframe+0x44/0xae

The oops can also be reproduced with the following steps:
  ./vmtest.sh -s
  # at qemu shell
  cd /root/bpf && while true; do ./test_progs -t send_signal

Further analysis showed that the failure is introduced with
commit b89fbfbb854c ("bpf: Implement minimal BPF perf link").
With the above commit, the following scenario becomes possible:
    cpu1                        cpu2
                                hrtimer_interrupt -> bpf_overflow_handler
    (due to closing link_fd)
    bpf_perf_link_release ->
    perf_event_free_bpf_prog ->
    perf_event_free_bpf_handler ->
      WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler)
      event->prog =3D NULL
                                bpf_prog_run(event->prog, &ctx)

In the above case, the event->prog is NULL for bpf_prog_run, hence
causing oops.

To fix the issue, check whether event->prog is NULL or not. If it
is, do not call bpf_prog_run. This seems working as the above
reproducible step runs more than one hour and I didn't see any
failures.

Fixes: b89fbfbb854c ("bpf: Implement minimal BPF perf link")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2d1e63dd97f2..011cc5069b7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9920,13 +9920,16 @@ static void bpf_overflow_handler(struct perf_even=
t *event,
 		.data =3D data,
 		.event =3D event,
 	};
+	struct bpf_prog *prog;
 	int ret =3D 0;
=20
 	ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
 		goto out;
 	rcu_read_lock();
-	ret =3D bpf_prog_run(event->prog, &ctx);
+	prog =3D READ_ONCE(event->prog);
+	if (prog)
+		ret =3D bpf_prog_run(prog, &ctx);
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
--=20
2.30.2

