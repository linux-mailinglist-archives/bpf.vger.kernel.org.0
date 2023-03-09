Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02F6B1F13
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCII5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCII5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 03:57:21 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED87E34A6;
        Thu,  9 Mar 2023 00:56:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PXN8X4Dv2z9xtnB;
        Thu,  9 Mar 2023 16:46:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHE1rqnglk6JWBAQ--.23851S3;
        Thu, 09 Mar 2023 09:55:21 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
Date:   Thu,  9 Mar 2023 09:54:31 +0100
Message-Id: <20230309085433.1810314-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBHE1rqnglk6JWBAQ--.23851S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrZw4xKw1kur47tr4rAFb_yoW5WFy3pa
        9rtFWfGr18AFWru3ZrC3ZIk3WrK395CFy7GrZ8Ww1DAa95Zry0vr4ayrySkFyUXFyqyF1I
        yr4avr4ak3WDAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
        0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUn89
        N3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj4Ze4wAAsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
last, e.g. the 'integrity' LSM, without changing the kernel command line or
configuration.

Also, set this order for the 'integrity' LSM. While not enforced, this is
the only LSM expected to use it.

Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
and put at the end of the LSM list.

Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
LSM is found, regardless of its order. In this way, the kernel would not
wrongly report that the LSM is not built-in in the kernel if its order is
LSM_ORDER_LAST.

Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hooks.h |  1 +
 security/integrity/iint.c |  1 +
 security/security.c       | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acff..c55761d93a2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1716,6 +1716,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
 	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
 };
 
 struct lsm_info {
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f799..b97eb59e0e3 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -182,6 +182,7 @@ static int __init integrity_iintcache_init(void)
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
 	.init = integrity_iintcache_init,
+	.order = LSM_ORDER_LAST,
 };
 
 
diff --git a/security/security.c b/security/security.c
index cf6cc576736..2f36229d5b6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -284,9 +284,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (lsm->order == LSM_ORDER_MUTABLE &&
-			    strcmp(lsm->name, name) == 0) {
-				append_ordered_lsm(lsm, origin);
+			if (strcmp(lsm->name, name) == 0) {
+				if (lsm->order == LSM_ORDER_MUTABLE)
+					append_ordered_lsm(lsm, origin);
 				found = true;
 			}
 		}
@@ -306,6 +306,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		}
 	}
 
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "   last");
+	}
+
 	/* Disable all LSMs not in the ordered list. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (exists_ordered_lsm(lsm))
-- 
2.25.1

