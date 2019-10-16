Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB079D8F3D
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbfJPLTV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Oct 2019 07:19:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40236 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392706AbfJPLTV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Oct 2019 07:19:21 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKhKp-0003tb-89; Wed, 16 Oct 2019 11:19:19 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kafai@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, yhs@fb.com, Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH bpf-next v4 3/3] bpf: use copy_struct_from_user() in bpf() syscall
Date:   Wed, 16 Oct 2019 13:18:10 +0200
Message-Id: <20191016111810.1799-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016111810.1799-1-christian.brauner@ubuntu.com>
References: <20191016034432.4418-1-christian.brauner@ubuntu.com>
 <20191016111810.1799-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In v5.4-rc2 we added a new helper (cf. [1]) copy_struct_from_user().
This helper is intended for all codepaths that copy structs from
userspace that are versioned by size. The bpf() syscall does exactly
what copy_struct_from_user() is doing.
Note that copy_struct_from_user() is calling min() already. So
technically, the min_t() call could go. But the size is used further
below so leave it.

[1]: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191009160907.10981-4-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191016004138.24845-4-christian.brauner@ubuntu.com
- Alexei Starovoitov <ast@kernel.org>:
  - remove unneeded initialization

/* v3 */
Link: https://lore.kernel.org/r/20191016034432.4418-4-christian.brauner@ubuntu.com
unchanged

/* v4 */
- Alexei Starovoitov <ast@kernel.org>:
  - move misplaced min after copy_struct_from_user()
---
 kernel/bpf/syscall.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d554ca7671b6..47bf4a81002d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2812,21 +2812,18 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
-	union bpf_attr attr = {};
+	union bpf_attr attr;
 	int err;
 
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
+	/* copy attributes from user space, may be less than sizeof(bpf_attr) */
+	err = copy_struct_from_user(&attr, sizeof(attr), uattr, size);
 	if (err)
 		return err;
 	size = min_t(u32, size, sizeof(attr));
 
-	/* copy attributes from user space, may be less than sizeof(bpf_attr) */
-	if (copy_from_user(&attr, uattr, size) != 0)
-		return -EFAULT;
-
 	err = security_bpf(cmd, &attr, size);
 	if (err < 0)
 		return err;
-- 
2.23.0

