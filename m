Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8140236C
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 08:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhIGG2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 02:28:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhIGG2E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 02:28:04 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1876OCYS008405
        for <bpf@vger.kernel.org>; Mon, 6 Sep 2021 23:26:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=DH1HGdvc01RuTfkuqTNuctHgmKGQJXLgkwsP86K4S3w=;
 b=kfFPrJiiTOHYzc79nHWEVfG4olND7TEWAqX5E2KRkLWEWmVPn6o6+oL9ltTy9qpYyq6d
 j8mbta1T0oB5oSBWav5tO/gFFj1hXfK7N4Vq2wH/Qza1kPkeb/xbFU2nWk/zTdgUSRwv
 ODp2t8ysS8VYxiHw+JRHZPV47QmTvOgo2Js= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3awwxp1e73-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Sep 2021 23:26:57 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 6 Sep 2021 23:26:53 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E23AC6D800CF; Mon,  6 Sep 2021 23:26:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>
Subject: [PATCH mm] mm/mmap: relax mmap_assert_locked() for find_vma()
Date:   Mon, 6 Sep 2021 23:26:50 -0700
Message-ID: <20210907062650.1309736-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 2CL0F3ICkVoNZu2F3XGMlipSKOt57xH9
X-Proofpoint-ORIG-GUID: 2CL0F3ICkVoNZu2F3XGMlipSKOt57xH9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_02:2021-09-03,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070042
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:

  [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:16=
4 find_vma+0x47/0xa0
  [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_te=
stmod]
  [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        =
W  O      5.14.0+ #53
  [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
  [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4=
 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 =
d4 <0f> 0b 48 89 de 48 8
  [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
  [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000=
000000000
  [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: fffffff=
f977e1b0e
  [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 0000000=
0fffffffe
  [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf=
5c39ae0e0
  [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf=
5c39ae0e0
  [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) kn=
lGS:0000000000000000
  [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000=
000370ee0
  [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [ 1411.304512] Call Trace:
  [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
  [ 1411.304528]  __bpf_get_stack+0x18f/0x230
  [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
  [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000=
000000000
  [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: fffffff=
f977e1b0e
  [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd=
43ee02c04
  [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
  [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf=
5c2ef60e0
  [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf=
5c2ef6108
  [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
  [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) kn=
lGS:0000000000000000
  [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
  [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000=
000370ef0
  [ 1411.312291]  do_syscall_64+0x15/0x80
  [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
  [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
  [ 1411.315626] Call Trace:
  [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260

To reproduce, first build `test_progs` binary:
  make -C tools/testing/selftests/bpf -j60
and then run the binary at tools/testing/selftests/bpf directory:
  ./test_progs -t get_stack_raw_tp

The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_lo=
cked() annotations to find_vma*()")
which added mmap_assert_locked() in find_vma() function. The mmap_assert_=
locked() function
asserts that mm->mmap_lock needs to be held. But this is not the case for
bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), whic=
h
uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not he=
ld
in bpf_get_stack[id]() use case, the above warning is emitted during test=
 run.

This patch fixed the issue by replacing mmap_assert_locked() with rwsem_i=
s_locked(&mm->mmap_lock)
in find_vma().

Cc: Luigi Rizzo <lrizzo@google.com>
Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to =
find_vma*()")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Alternatively we could add a bool argument to find_vma to indicate whethe=
r
mm->mmap_lock has been held or not. But I would like to report and try th=
e
simpler solution first.

diff --git a/mm/mmap.c b/mm/mmap.c
index 88dcc5c25225..8c78b85475b1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2275,7 +2275,7 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
=20
-	mmap_assert_locked(mm);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 	/* Check the cache first. */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
--=20
2.30.2

