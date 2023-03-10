Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7616B396E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCJJBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjCJJA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:56 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F882CFCE;
        Fri, 10 Mar 2023 00:54:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PY04R49Ggz9xHN6;
        Fri, 10 Mar 2023 16:45:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmUy8ApkK+yFAQ--.17497S4;
        Fri, 10 Mar 2023 09:54:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 2/3] Revert "integrity: double check iint_cache was initialized"
Date:   Fri, 10 Mar 2023 09:54:00 +0100
Message-Id: <20230310085401.1964889-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnbmUy8ApkK+yFAQ--.17497S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4rAFWkGw4DZr43AF4DXFb_yoW8GrWxpF
        42gayUGr1UZFW0ka1vya45uaySk392gry5Wws8Gr97Aas8Zr1jqFs8KryUXFy5WrWFyw1S
        qrn09r4Uu3Wqyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4ZsBQAAsU
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

With the recent introduction of LSM_ORDER_LAST, the 'integrity' LSM is
always initialized (if selected in the kernel configuration) and the
iint_cache is always created (the kernel panics on error). Thus, the
additional check of iint_cache in integrity_inode_get() is no longer
necessary. If the 'integrity' LSM is not selected in the kernel
configuration, integrity_inode_get() just returns NULL.

This reverts commit 92063f3ca73aab794bd5408d3361fd5b5ea33079.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/iint.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index b97eb59e0e3..c73858e8c6d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -98,14 +98,6 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
 
-	/*
-	 * The integrity's "iint_cache" is initialized at security_init(),
-	 * unless it is not included in the ordered list of LSMs enabled
-	 * on the boot command line.
-	 */
-	if (!iint_cache)
-		panic("%s: lsm=integrity required.\n", __func__);
-
 	iint = integrity_iint_find(inode);
 	if (iint)
 		return iint;
-- 
2.25.1

