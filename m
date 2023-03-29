Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFE6CF34D
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjC2Tkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjC2Tkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:42 -0400
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0755A3
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 12:40:40 -0700 (PDT)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     x86@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, peterz@infradead.org, keescook@chromium.org,
        tglx@linutronix.de, hsinweih@uci.edu, rostedt@goodmis.org,
        vegard.nossum@oracle.com, gregkh@linuxfoundation.org,
        alan.maguire@oracle.com, dylany@meta.com, riel@surriel.com,
        kernel-team@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Florian Lehner <dev@der-flo.net>
Subject: [RESUBMIT bpf-next 1/2] mm: Fix copy_from_user_nofault().
Date:   Wed, 29 Mar 2023 21:39:32 +0200
Message-Id: <20230329193931.320642-2-dev@der-flo.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329193931.320642-1-dev@der-flo.net>
References: <20230329193931.320642-1-dev@der-flo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

There are several issues with copy_from_user_nofault():

- access_ok() is designed for user context only and for that reason
it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
and perf on ppc are calling it from irq.

- it's missing nmi_uaccess_okay() which is a nop on all architectures
except x86 where it's required.
The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.

- __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Fix all three issues. At the end the copy_from_user_nofault() becomes
equivalent to copy_from_user_nmi() from safety point of view with
a difference in the return value.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Florian Lehner <dev@der-flo.net>
---
 mm/maccess.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 074f6b086671..6ee9b337c501 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -113,11 +114,18 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	pagefault_disable();
+	instrument_copy_from_user_before(dst, src, size);
+	ret = raw_copy_from_user(dst, src, size);
+	instrument_copy_from_user_after(dst, src, size, ret);
+	pagefault_enable();
 
 	if (ret)
 		return -EFAULT;
-- 
2.39.2

