Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB446B5080
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCJTFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 14:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCJTFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 14:05:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9A12FD12;
        Fri, 10 Mar 2023 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=++rrP4Cjvo+1VSixc4iffAuUXXF57XYeVVXnpi7PUsQ=; b=wcwiBo/YXzmFufYjQZ8tPGifRA
        bqFH2boUZlsZ1VB6Pfgs6uIR4eLHhU4jNvgaGsbfmcq0otSj7NVqpHzHS3qaB0E8AGsK5A/G2k9+1
        lbHgtA+tzkBl3fB7jTTfBbJUtMpCKZN1qWjQJeOyOtCnz9KZWdkLZj8lMcqdc/DMrWg2uRVlmdkmZ
        LOprCwegknRPdeWMYQw3yGkqBzVg3E0e7jhCAtkZWNJuVMtX7kabqflB0l4nia6tuS2bIja+fbkkO
        E/F/JHq/Zb3bgwrLr4lRKzXIHCHCAjRUaMKT2GSKLZ5dkcTnO22q7DPFA18AYJW/ZTHzNWZqZOvif
        fcNgomdQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pai30-00FrCm-07; Fri, 10 Mar 2023 19:04:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, bpf@vger.kernel.org
Cc:     christophe.leroy@csgroup.eu, jolsa@kernel.org, vmalik@redhat.com,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, nick.alcock@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, mcgrof@kernel.org
Subject: [PATCH] kernel/module: add documentation for try_module_get()
Date:   Fri, 10 Mar 2023 11:04:57 -0800
Message-Id: <20230310190457.3779415-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is quite a bit of tribal knowledge around proper use of try_module_get()
and requiring *somehow* the module to still exist to use this call in a way
that is safe. Document this bit of tribal knowledge. To be clear, you should
only use try_module_get() *iff* you are 100% sure the module already does
exist and is not on its way out.

You can be sure the module still exists and is alive through:

1) Direct protection with its refcount: you know some earlier caller called
   __module_get() safely
2) Implied protection: there is an implied protection against module removal

Having an idea of when you are sure __module_get() might be called earlier is
easy to understand however the implied protection requires an example. We use
sysfs an an example for implied protection without a direct module reference
count bump. kernfs / sysfs uses its own internal reference counting for files
being actively used, when such file are active they completely prevent
the module from being removed. kernfs protects this with its kernfs_active().
Effort has been put into verifying the kernfs implied protection works by
using a currently out-of-tree test_sysfs selftest test #32 [0]:

./tools/testing/selftests/sysfs/sysfs.sh -t 0032

Without kernfs / sysfs preventing module removal through its active reference
count (kernfs_active()) the write would fail or worse, a crash would happen in
this test and it does not.

Similar safeguards are required for other users of try_module_get() *iff*
they are not ensuring the above rule 1) is followed.

[0] https://lore.kernel.org/lkml/20211029184500.2821444-4-mcgrof@kernel.org/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

I had actually written an initial version of these docs [0] *two years* ago
through my test_sysfs patches [1]. Back then the only pushback I got to get this
test upstream was Greg's opposition to me using copyleft-next for my test driver.
Upon feedback from the comunity, we've now have passed that hurtle, and we
have proper SPDX tags for copyleft-next driver upstream. Before I follow up
again with that test_sysfs driver though *this* patch in particular seems
important enough to get upstream and so sending this separately because
I see some folks might still be in high need of these docs.

I'll reply to the thread / patch in question next.

[0] https://lore.kernel.org/all/20211029184500.2821444-7-mcgrof@kernel.org/
[1] https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/

 include/linux/module.h | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 91726444d55f..c3b357196470 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -671,10 +671,46 @@ void symbol_put_addr(void *addr);
    to handle the error case (which only happens with rmmod --wait). */
 extern void __module_get(struct module *module);
 
-/* This is the Right Way to get a module: if it fails, it's being removed,
- * so pretend it's not there. */
+/**
+ * try_module_get() - take module refcount unless module is being removed
+ * @module: the module we should check for
+ *
+ * Only try to get a module reference count if the module is not being removed.
+ * This call will fail if the module is already being removed.
+ *
+ * Care must also be taken to ensure the module exists and is alive prior to
+ * usage of this call. This can be gauranteed through two means:
+ *
+ * 1) Direct protection: you know an earlier caller must have increased the
+ *    module reference through __module_get(). This can typically be achieved
+ *    by having another entity other than the module itself increment the
+ *    module reference count.
+ *
+ * 2) Implied protection: there is an implied protection against module
+ *    removal. An example of this is the implied protection used by kernfs /
+ *    sysfs. The sysfs store / read file operations are guaranteed to exist
+ *    through the use of kernfs's active reference (see kernfs_active()) and a
+ *    sysfs / kernfs file removal cannot happen unless the same file is not
+ *    active. Therefore, if a sysfs file is being read or written to the module
+ *    which created it must still exist. It is therefore safe to use
+ *    try_module_get() on module sysfs store / read ops.
+ *
+ * One of the real values to try_module_get() is the module_is_live() check
+ * which ensures that the caller of try_module_get() can yield to userspace
+ * module removal requests and gracefully fail if the module is on its way out.
+ *
+ * Returns true if the reference count was successfully incremented.
+ */
 extern bool try_module_get(struct module *module);
 
+/**
+ * module_put() - release a reference count to a module
+ * @module: the module we should release a reference count for
+ *
+ * If you successfully bump a reference count to a module with try_module_get(),
+ * when you are finished you must call module_put() to release that reference
+ * count.
+ */
 extern void module_put(struct module *module);
 
 #else /*!CONFIG_MODULE_UNLOAD*/
-- 
2.39.1

