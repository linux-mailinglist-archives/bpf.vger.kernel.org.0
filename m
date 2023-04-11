Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3336DE261
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDKRW4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDKRWz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 13:22:55 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C7122;
        Tue, 11 Apr 2023 10:22:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Pwsqt00lBz9v7Hv;
        Wed, 12 Apr 2023 01:13:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAHukBMlzVkOgEUAg--.766S2;
        Tue, 11 Apr 2023 18:22:29 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] Smack modifications for: security: Allow all LSMs to provide xattrs for inode_init_security hook
Date:   Tue, 11 Apr 2023 19:23:37 +0200
Message-Id: <20230411172337.340518-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
References: <c7f38789-fe47-8289-e73a-4d07fbaf791d@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAHukBMlzVkOgEUAg--.766S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fXF4DZrWxWFy5Ary3twb_yoW5KryDpF
        W7K3ZxKF4rtF1DWryFyF4UW3yakan5WrWUWwnxXws3ZFnFqw1xKF95Xr1YkF1xXrykZr9Y
        gF4qqr13WFn0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
        w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4fclgACs8
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Very very quick modification. Not tested.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack.h     |  2 +-
 security/smack/smack_lsm.c | 42 ++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index e2239be7bd6..f00c8498c60 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -127,7 +127,7 @@ struct task_smack {
 
 #define	SMK_INODE_INSTANT	0x01	/* inode is instantiated */
 #define	SMK_INODE_TRANSMUTE	0x02	/* directory is transmuting */
-#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted */
+#define	SMK_INODE_CHANGED	0x04	/* smack was transmuted (unused) */
 #define	SMK_INODE_IMPURE	0x08	/* involved in an impure transaction */
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8392983334b..b43820bdbd0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -54,12 +54,12 @@
 
 /*
  * Smack uses multiple xattrs.
- * SMACK64 - for access control, SMACK64EXEC - label for the program,
- * SMACK64MMAP - controls library loading,
+ * SMACK64 - for access control,
  * SMACK64TRANSMUTE - label initialization,
- * Not saved on files - SMACK64IPIN and SMACK64IPOUT
+ * Not saved on files - SMACK64IPIN and SMACK64IPOUT,
+ * Must be set explicitly - SMACK64EXEC and SMACK64MMAP
  */
-#define SMACK_INODE_INIT_XATTRS 4
+#define SMACK_INODE_INIT_XATTRS 2
 
 #ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
@@ -957,11 +957,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
 				     struct xattr *xattrs, int *xattr_count)
 {
-	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr2;
 	int may;
 
 	if (xattr) {
@@ -979,7 +979,17 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
 		    smk_inode_transmutable(dir)) {
 			isp = dsp;
-			issp->smk_flags |= SMK_INODE_CHANGED;
+			xattr2 = lsm_get_xattr_slot(xattrs, xattr_count);
+			if (xattr2) {
+				xattr2->value = kmemdup(TRANS_TRUE,
+							TRANS_TRUE_SIZE,
+							GFP_NOFS);
+				if (xattr2->value == NULL)
+					return -ENOMEM;
+
+				xattr2->value_len = TRANS_TRUE_SIZE;
+				xattr2->name = XATTR_NAME_SMACKTRANSMUTE;
+			}
 		}
 
 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
@@ -3512,20 +3522,12 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			 * If there is a transmute attribute on the
 			 * directory mark the inode.
 			 */
-			if (isp->smk_flags & SMK_INODE_CHANGED) {
-				isp->smk_flags &= ~SMK_INODE_CHANGED;
-				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
-					XATTR_NAME_SMACKTRANSMUTE,
-					TRANS_TRUE, TRANS_TRUE_SIZE,
-					0);
-			} else {
-				rc = __vfs_getxattr(dp, inode,
-					XATTR_NAME_SMACKTRANSMUTE, trattr,
-					TRANS_TRUE_SIZE);
-				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
-						       TRANS_TRUE_SIZE) != 0)
-					rc = -EINVAL;
-			}
+			rc = __vfs_getxattr(dp, inode,
+					    XATTR_NAME_SMACKTRANSMUTE, trattr,
+					    TRANS_TRUE_SIZE);
+			if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
+					       TRANS_TRUE_SIZE) != 0)
+				rc = -EINVAL;
 			if (rc >= 0)
 				transflag = SMK_INODE_TRANSMUTE;
 		}
-- 
2.25.1

