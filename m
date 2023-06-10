Return-Path: <bpf+bounces-2314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628AF72AA1E
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBD32819EE
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA4BA55;
	Sat, 10 Jun 2023 07:59:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986BBA20
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 07:59:08 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31E3A86;
	Sat, 10 Jun 2023 00:59:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QdVQY13Jdz9xFrN;
	Sat, 10 Jun 2023 15:47:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBH0AsGLYRklC8oAw--.4566S5;
	Sat, 10 Jun 2023 08:58:36 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	keescook@chromium.org,
	nicolas.bouchinet@clip-os.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 3/4] evm: Align evm_inode_init_security() definition with LSM infrastructure
Date: Sat, 10 Jun 2023 09:57:37 +0200
Message-Id: <20230610075738.3273764-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
References: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBH0AsGLYRklC8oAw--.4566S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43tw1kKw15Kr1kur48WFg_yoWrCF1xpF
	Zxt3WUCr1rJFyUWryFyF47u3WSgFWrGr4Dt393G34jyF1Dtr1xtFW0yr15uryrXrW8JrnY
	qw429r1rWwn0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4qCJAABse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Change the evm_inode_init_security() definition to align with the LSM
infrastructure. Keep the existing behavior of including in the HMAC
calculation only the first xattr provided by LSMs.

Changing the evm_inode_init_security() definition requires passing the
xattr array allocated by security_inode_init_security(), and the number of
xattrs filled by previously invoked LSMs.

Use the newly introduced lsm_get_xattr_slot() to position EVM correctly in
the xattrs array, like a regular LSM, and to increment the number of filled
slots. For now, the LSM infrastructure allocates enough xattrs slots to
store the EVM xattr, without using the reservation mechanism.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 14 ++++++++------
 security/integrity/evm/evm_main.c | 16 ++++++++++------
 security/security.c               |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 7dc1ee74169..01fc495a83e 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -56,9 +56,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 {
 	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
 }
-extern int evm_inode_init_security(struct inode *inode,
-				   const struct xattr *xattr_array,
-				   struct xattr *evm);
+
+int evm_inode_init_security(struct inode *inode, struct inode *dir,
+			    const struct qstr *qstr, struct xattr *xattrs,
+			    int *xattr_count);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -157,9 +158,10 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_init_security(struct inode *inode,
-					  const struct xattr *xattr_array,
-					  struct xattr *evm)
+static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
+					  const struct qstr *qstr,
+					  struct xattr *xattrs,
+					  int *xattr_count)
 {
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cf24c525558..475196ce712 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -21,6 +21,7 @@
 #include <linux/evm.h>
 #include <linux/magic.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/lsm_hooks.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -864,23 +865,26 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 /*
  * evm_inode_init_security - initializes security.evm HMAC value
  */
-int evm_inode_init_security(struct inode *inode,
-				 const struct xattr *lsm_xattr,
-				 struct xattr *evm_xattr)
+int evm_inode_init_security(struct inode *inode, struct inode *dir,
+			    const struct qstr *qstr, struct xattr *xattrs,
+			    int *xattr_count)
 {
 	struct evm_xattr *xattr_data;
+	struct xattr *evm_xattr;
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattr->name))
+	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
+	    !evm_protected_xattr(xattrs->name))
 		return 0;
 
+	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
 	if (!xattr_data)
 		return -ENOMEM;
 
 	xattr_data->data.type = EVM_XATTR_HMAC;
-	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
+	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
 	if (rc < 0)
 		goto out;
 
diff --git a/security/security.c b/security/security.c
index d5ef7df1ce4..819294d91ad 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1645,8 +1645,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!xattr_count)
 		goto out;
 
-	ret = evm_inode_init_security(inode, new_xattrs,
-				      &new_xattrs[xattr_count]);
+	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs,
+				      &xattr_count);
 	if (ret)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
-- 
2.25.1


