Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859BED86EA
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 05:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfJPDot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 23:44:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfJPDos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 23:44:48 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKaEw-0000Wg-Tw; Wed, 16 Oct 2019 03:44:46 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kafai@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, yhs@fb.com, Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v3 1/3] bpf: use check_zeroed_user() in bpf_check_uarg_tail_zero()
Date:   Wed, 16 Oct 2019 05:44:30 +0200
Message-Id: <20191016034432.4418-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016034432.4418-1-christian.brauner@ubuntu.com>
References: <20191016004138.24845-1-christian.brauner@ubuntu.com>
 <20191016034432.4418-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In v5.4-rc2 we added a new helper (cf. [1]) check_zeroed_user() which
does what bpf_check_uarg_tail_zero() is doing generically. We're slowly
switching such codepaths over to use check_zeroed_user() instead of
using their own hand-rolled version.

[1]: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
Acked-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191009160907.10981-2-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191016004138.24845-2-christian.brauner@ubuntu.com
- Alexei Starovoitov <ast@kernel.org>:
  - Add a comment in bpf_check_uarg_tail_zero() to clarify that
    copy_struct_from_user() should be used whenever possible instead.

/* v3 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - use correct checks for check_zeroed_user()
---
 kernel/bpf/syscall.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 82eabd4e38ad..40edcaeccd71 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -58,35 +58,28 @@ static const struct bpf_map_ops * const bpf_map_types[] = {
  * There is a ToCToU between this function call and the following
  * copy_from_user() call. However, this is not a concern since this function is
  * meant to be a future-proofing of bits.
+ *
+ * Note, instead of using bpf_check_uarg_tail_zero() followed by
+ * copy_from_user() use the dedicated copy_struct_from_user() helper which
+ * performs both tasks whenever possible.
  */
 int bpf_check_uarg_tail_zero(void __user *uaddr,
 			     size_t expected_size,
 			     size_t actual_size)
 {
-	unsigned char __user *addr;
-	unsigned char __user *end;
-	unsigned char val;
+	size_t size = min(expected_size, actual_size);
+	size_t rest = max(expected_size, actual_size) - size;
 	int err;
 
 	if (unlikely(actual_size > PAGE_SIZE))	/* silly large */
 		return -E2BIG;
 
-	if (unlikely(!access_ok(uaddr, actual_size)))
-		return -EFAULT;
-
 	if (actual_size <= expected_size)
 		return 0;
 
-	addr = uaddr + expected_size;
-	end  = uaddr + actual_size;
-
-	for (; addr < end; addr++) {
-		err = get_user(val, addr);
-		if (err)
-			return err;
-		if (val)
-			return -E2BIG;
-	}
+	err = check_zeroed_user(uaddr + expected_size, rest);
+	if (err <= 0)
+		return err ?: -E2BIG;
 
 	return 0;
 }
-- 
2.23.0

