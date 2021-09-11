Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE340744C
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 02:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhIKBBH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 21:01:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16186 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhIKBBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 21:01:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H5vWk5BsDz1DGp2;
        Sat, 11 Sep 2021 08:58:58 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 08:59:53 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 08:59:53 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: [PATCH -next v2] bpf: Add oversize check before call kvcalloc()
Date:   Sat, 11 Sep 2021 08:55:57 +0800
Message-ID: <20210911005557.45518-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 7661809d493b ("mm: don't allow oversized kvmalloc() calls") add the
oversize check. When the allocation is larger than what kmalloc() supports,
the following warning triggered:

WARNING: CPU: 0 PID: 8408 at mm/util.c:597 kvmalloc_node+0x108/0x110 mm/util.c:597
Modules linked in:
CPU: 0 PID: 8408 Comm: syz-executor221 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvmalloc_node+0x108/0x110 mm/util.c:597
Call Trace:
 kvmalloc include/linux/mm.h:806 [inline]
 kvmalloc_array include/linux/mm.h:824 [inline]
 kvcalloc include/linux/mm.h:829 [inline]
 check_btf_line kernel/bpf/verifier.c:9925 [inline]
 check_btf_info kernel/bpf/verifier.c:10049 [inline]
 bpf_check+0xd634/0x150d0 kernel/bpf/verifier.c:13759
 bpf_prog_load kernel/bpf/syscall.c:2301 [inline]
 __sys_bpf+0x11181/0x126e0 kernel/bpf/syscall.c:4587
 __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
 __x64_sys_bpf+0x78/0x90 kernel/bpf/syscall.c:4689
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported-by: syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
Chang in v2:
* Change 'if (nr_linfo * sizeof(struct bpf_line_info) > INT_MAX)' to
  'if (nr_lifo > INT_MAX / sizeof(struct bpf_line_info))'.

 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0dd972d5b41..de006552be8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9912,6 +9912,8 @@ static int check_btf_line(struct bpf_verifier_env *env,
 	nr_linfo = attr->line_info_cnt;
 	if (!nr_linfo)
 		return 0;
+	if (nr_linfo > INT_MAX / sizeof(struct bpf_line_info))
+		return -EINVAL;
 
 	rec_size = attr->line_info_rec_size;
 	if (rec_size < MIN_BPF_LINEINFO_SIZE ||
-- 
2.17.1

