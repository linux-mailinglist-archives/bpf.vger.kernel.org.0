Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE19607CA6
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJUQrw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiJUQr0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:47:26 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192302D74E;
        Fri, 21 Oct 2022 09:47:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mv9FW07TczB045g;
        Sat, 22 Oct 2022 00:40:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBnXpL0zFJjUPbfAA--.42123S2;
        Fri, 21 Oct 2022 17:46:50 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Subject: [RFC][PATCH] bpf: Check xattr name/value pair from bpf_lsm_inode_init_security()
Date:   Fri, 21 Oct 2022 18:46:26 +0200
Message-Id: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnXpL0zFJjUPbfAA--.42123S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW3Kr13ur13JFW3Gw1UAwb_yoWrJw1xpF
        ZxG3W3Grn8AFsrWrZ3K3W29a1Sg3yrWr47GrZxJr1UA3Z2vrn7tr40yF1YvFyfJrWDKayF
        qa1aqr45Ww1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
        w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4CIhAAAs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

BPF LSM allows security modules to directly attach to the security hooks,
with the potential of not meeting the kernel expectation.

This is the case for the inode_init_security hook, for which the kernel
expects that name and value are set if the hook implementation returns
zero.

Consequently, not meeting the kernel expectation can cause the kernel to
crash. One example is evm_protected_xattr_common() which expects the
req_xattr_name parameter to be always not NULL.

Introduce a level of indirection in BPF LSM, for the inode_init_security
hook, to check the validity of the name and value set by security modules.

Encapsulate bpf_lsm_inode_init_security(), the existing attachment point,
with bpf_inode_init_security(), the new function. After the attachment
point is called, return -EOPNOTSUPP if the xattr name is not set, -ENOMEM
if the xattr value is not set.

As the name still cannot be set, rely on future patches to the eBPF
verifier or introducing new kfuncs/helpers to ensure its correctness.

Finally, as proposed by Nicolas, update the LSM hook documentation for the
inode_init_security hook, to reflect the current behavior (only the xattr
value is allocated).

Cc: stable@vger.kernel.org
Fixes: 520b7aa00d8cd ("bpf: lsm: Initialize the BPF LSM hooks")
Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hooks.h |  4 ++--
 security/bpf/hooks.c      | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e..f44d45f4737f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -229,8 +229,8 @@
  *	This hook is called by the fs code as part of the inode creation
  *	transaction and provides for atomic labeling of the inode, unlike
  *	the post_create/mkdir/... hooks called by the VFS.  The hook function
- *	is expected to allocate the name and value via kmalloc, with the caller
- *	being responsible for calling kfree after using them.
+ *	is expected to allocate the value via kmalloc, with the caller
+ *	being responsible for calling kfree after using it.
  *	If the security module does not use security attributes or does
  *	not wish to put a security attribute on this particular inode,
  *	then it should return -EOPNOTSUPP to skip this processing.
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..492c07ba6722 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,11 +6,36 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
+static int bpf_inode_init_security(struct inode *inode, struct inode *dir,
+				   const struct qstr *qstr, const char **name,
+				   void **value, size_t *len)
+{
+	int ret;
+
+	ret = bpf_lsm_inode_init_security(inode, dir, qstr, name, value, len);
+	if (ret)
+		return ret;
+
+	/*
+	 * As the name cannot be set by the eBPF programs directly, eBPF will
+	 * be responsible for its correctness through the verifier or
+	 * appropriate kfuncs/helpers.
+	 */
+	if (name && !*name)
+		return -EOPNOTSUPP;
+
+	if (value && !*value)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
+	LSM_HOOK_INIT(inode_init_security, bpf_inode_init_security),
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
-- 
2.25.1

