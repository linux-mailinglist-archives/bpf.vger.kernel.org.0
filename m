Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA962585601
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiG2USB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2USB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 16:18:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1050E8AEED
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 13:18:00 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TKBvj9000996;
        Fri, 29 Jul 2022 20:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=yeU73JobSf31y1htvVc1Lu3gpVyceMTSgFx2S37IuVw=;
 b=Cyzl4EL+wk2dbbl3DuMAkamoeoqaZBemDrMTdGExo2buVEt2RWsZCvIx18i69JDf28ST
 OZJCsYL20FKIHJosSIUjlOZn0s3+9z0Mp0vEzt5F6e0bsNYt3u09NMSUhkYR+T28CwMc
 ytviTNnLll8qz2Tgs4cW03Sm00UioLL6YIk2F7+AG0mRqh7KtMl8HbkI2LTd872WQ/7j
 T0agIukR1dSLHWlP3d5e5ugXckJMNpB+2TrXgMybGqLeawj7MDDl4Nytp8wZciacokpZ
 EWlzAfi16H7kdS77IdqW9SVN9AxHAPeKeHi7c6RogyTOIKkuGlRvgNFiFWyf7oL8cCWl hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmpcbg49v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 20:17:34 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26TKFBoI026856;
        Fri, 29 Jul 2022 20:17:33 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmpcbg49b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 20:17:33 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26TK6a10029732;
        Fri, 29 Jul 2022 20:17:32 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b7rnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 20:17:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26TKHVIF9175962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 20:17:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4231EAC05F;
        Fri, 29 Jul 2022 20:17:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55C19AC062;
        Fri, 29 Jul 2022 20:17:30 +0000 (GMT)
Received: from fuzzy-bm.sl.cloud9.ibm.com (unknown [9.59.150.27])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 20:17:30 +0000 (GMT)
From:   Jinghao Jia <jinghao@linux.ibm.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, mvle@us.ibm.com,
        jinghao7@illinois.edu, Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH v2] BPF: Fix potential bad pointer dereference in bpf_sys_bpf()
Date:   Fri, 29 Jul 2022 20:17:13 +0000
Message-Id: <20220729201713.88688-1-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SM97Cx0Gvvmq3-MtZxZYUbD32JnobPSr
X-Proofpoint-GUID: VrqUTj6uBtG_fzoVUCsaNz0U0qeiADfv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=687 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_sys_bpf() helper function allows an eBPF program to load another
eBPF program from within the kernel. In this case the argument union
bpf_attr pointer (as well as the insns and license pointers inside) is a
kernel address instead of a userspace address (which is the case of a
usual bpf() syscall). To make the memory copying process in the syscall
work in both cases, bpfptr_t was introduced to wrap around the pointer
and distinguish its origin. Specifically, when copying memory contents
from a bpfptr_t, a copy_from_user() is performed in case of a userspace
address and a memcpy() is performed for a kernel address.

This can lead to problems because the in-kernel pointer is never checked
for validity. The problem happens when an eBPF syscall program tries to
call bpf_sys_bpf() to load a program but provides a bad insns pointer --
say 0xdeadbeef -- in the bpf_attr union. The helper calls __sys_bpf()
which would then call bpf_prog_load() to load the program.
bpf_prog_load() is responsible for copying the eBPF instructions to the
newly allocated memory for the program; it creates a kernel bpfptr_t for
insns and invokes copy_from_bpfptr(). Internally, all bpfptr_t
operations are backed by the corresponding sockptr_t operations, which
performs direct memcpy() on kernel pointers for copy_from/strncpy_from
operations. Therefore, the code is always happy to dereference the bad
pointer to trigger a un-handle-able page fault and in turn an oops.
However, this is not supposed to happen because at that point the eBPF
program is already verified and should not cause a memory error.

Sample KASAN trace:

[   25.685056][  T228] ==================================================================
[   25.685680][  T228] BUG: KASAN: user-memory-access in copy_from_bpfptr+0x21/0x30
[   25.686210][  T228] Read of size 80 at addr 00000000deadbeef by task poc/228
[   25.686732][  T228]
[   25.686893][  T228] CPU: 3 PID: 228 Comm: poc Not tainted 5.19.0-rc7 #7
[   25.687375][  T228] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
[   25.687991][  T228] Call Trace:
[   25.688223][  T228]  <TASK>
[   25.688429][  T228]  dump_stack_lvl+0x73/0x9e
[   25.688747][  T228]  print_report+0xea/0x200
[   25.689061][  T228]  ? copy_from_bpfptr+0x21/0x30
[   25.689401][  T228]  ? _printk+0x54/0x6e
[   25.689693][  T228]  ? _raw_spin_lock_irqsave+0x70/0xd0
[   25.690071][  T228]  ? copy_from_bpfptr+0x21/0x30
[   25.690412][  T228]  kasan_report+0xb5/0xe0
[   25.690716][  T228]  ? copy_from_bpfptr+0x21/0x30
[   25.691059][  T228]  kasan_check_range+0x2bd/0x2e0
[   25.691405][  T228]  ? copy_from_bpfptr+0x21/0x30
[   25.691734][  T228]  memcpy+0x25/0x60
[   25.692000][  T228]  copy_from_bpfptr+0x21/0x30
[   25.692328][  T228]  bpf_prog_load+0x604/0x9e0
[   25.692653][  T228]  ? cap_capable+0xb4/0xe0
[   25.692956][  T228]  ? security_capable+0x4f/0x70
[   25.693324][  T228]  __sys_bpf+0x3af/0x580
[   25.693635][  T228]  bpf_sys_bpf+0x45/0x240
[   25.693937][  T228]  bpf_prog_f0ec79a5a3caca46_bpf_func1+0xa2/0xbd
[   25.694394][  T228]  bpf_prog_run_pin_on_cpu+0x2f/0xb0
[   25.694756][  T228]  bpf_prog_test_run_syscall+0x146/0x1c0
[   25.695144][  T228]  bpf_prog_test_run+0x172/0x190
[   25.695487][  T228]  __sys_bpf+0x2c5/0x580
[   25.695776][  T228]  __x64_sys_bpf+0x3a/0x50
[   25.696084][  T228]  do_syscall_64+0x60/0x90
[   25.696393][  T228]  ? fpregs_assert_state_consistent+0x50/0x60
[   25.696815][  T228]  ? exit_to_user_mode_prepare+0x36/0xa0
[   25.697202][  T228]  ? syscall_exit_to_user_mode+0x20/0x40
[   25.697586][  T228]  ? do_syscall_64+0x6e/0x90
[   25.697899][  T228]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   25.698312][  T228] RIP: 0033:0x7f6d543fb759
[   25.698624][  T228] Code: 08 5b 89 e8 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 a6 0e 00 f7 d8 64 89 01 48
[   25.699946][  T228] RSP: 002b:00007ffc3df78468 EFLAGS: 00000287 ORIG_RAX: 0000000000000141
[   25.700526][  T228] RAX: ffffffffffffffda RBX: 00007ffc3df78628 RCX: 00007f6d543fb759
[   25.701071][  T228] RDX: 0000000000000090 RSI: 00007ffc3df78478 RDI: 000000000000000a
[   25.701636][  T228] RBP: 00007ffc3df78510 R08: 0000000000000000 R09: 0000000000300000
[   25.702191][  T228] R10: 0000000000000005 R11: 0000000000000287 R12: 0000000000000000
[   25.702736][  T228] R13: 00007ffc3df78638 R14: 000055a1584aca68 R15: 00007f6d5456a000
[   25.703282][  T228]  </TASK>
[   25.703490][  T228] ==================================================================
[   25.704050][  T228] Disabling lock debugging due to kernel taint

Update copy_from_bpfptr() and strncpy_from_bpfptr() so that:
 - for a kernel pointer, it uses the safe copy_from_kernel_nofault() and
   strncpy_from_kernel_nofault() functions.
 - for a userspace pointer, it performs copy_from_user() and
   strncpy_from_user().

Fixes: af2ac3e13e45 ("bpf: Prepare bpf syscall to be used from kernel and user space.")
Link: https://lore.kernel.org/bpf/20220727132905.45166-1-jinghao@linux.ibm.com/
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
---
Changelog v2:
Applied Yonghong's comments and directly modified copy_from_bpfptr() and
strncpy_from_bpfptr() rather than the sockptr APIs.

 include/linux/bpfptr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 46e1757d06a3..79b2f78eec1a 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -49,7 +49,9 @@ static inline void bpfptr_add(bpfptr_t *bpfptr, size_t val)
 static inline int copy_from_bpfptr_offset(void *dst, bpfptr_t src,
 					  size_t offset, size_t size)
 {
-	return copy_from_sockptr_offset(dst, (sockptr_t) src, offset, size);
+	if (!bpfptr_is_kernel(src))
+		return copy_from_user(dst, src.user + offset, size);
+	return copy_from_kernel_nofault(dst, src.kernel + offset, size);
 }
 
 static inline int copy_from_bpfptr(void *dst, bpfptr_t src, size_t size)
@@ -78,7 +80,9 @@ static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
 
 static inline long strncpy_from_bpfptr(char *dst, bpfptr_t src, size_t count)
 {
-	return strncpy_from_sockptr(dst, (sockptr_t) src, count);
+	if (bpfptr_is_kernel(src))
+		return strncpy_from_kernel_nofault(dst, src.kernel, count);
+	return strncpy_from_user(dst, src.user, count);
 }
 
 #endif /* _LINUX_BPFPTR_H */

base-commit: 64893e83f916145fd23182209009e9d2ce36d2df
-- 
2.35.1

