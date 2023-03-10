Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E26B3971
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCJJBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjCJJA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:56 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218E104910;
        Fri, 10 Mar 2023 00:54:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PY04K2Sfwz9xHMn;
        Fri, 10 Mar 2023 16:45:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmUy8ApkK+yFAQ--.17497S3;
        Fri, 10 Mar 2023 09:54:24 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 1/3] security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
Date:   Fri, 10 Mar 2023 09:53:59 +0100
Message-Id: <20230310085401.1964889-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnbmUy8ApkK+yFAQ--.17497S3
X-Coremail-Antispam: 1UD129KBjvJXoWxury7WFWfZw13Kry7JrW7CFg_yoW5Aw45pa
        yDtFWxGr18AFWru3ZrC3ZIk3WrK395CFy7GrZ8Ww1DAa95Zry0vr1SyryakFyUXFyqyF1I
        yF4avr4ak3WDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4pqNwAAsv
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
and put at the end of the LSM list, if selected in the kernel
configuration. Setting one of these orders alone, does not cause the LSMs
to be selected and compiled built-in in the kernel.

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

