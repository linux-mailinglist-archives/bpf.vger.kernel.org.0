Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383EF647F7B
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLIIpT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 03:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIIpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 03:45:18 -0500
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 00:45:17 PST
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F494FF83;
        Fri,  9 Dec 2022 00:45:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NT3v26L37z9v7bc;
        Fri,  9 Dec 2022 16:23:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBnUG318ZJjXxnRAA--.238S3;
        Fri, 09 Dec 2022 09:29:55 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     corbet@lwn.net, paul@paul-moore.com, casey@schaufler-ca.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/2] doc: Fix fs_context_parse_param description in mount_api.rst
Date:   Fri,  9 Dec 2022 09:29:36 +0100
Message-Id: <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnUG318ZJjXxnRAA--.238S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4ruw48Xw1xGw4kCrW3ZFb_yoW8XFW5pa
        yF9r18K3s7Jr10kr98Ca1rXFWfCrs2yF4jgFWvvw18ZwsIqr1F9rnxKF1Y9r18Ga48uFWY
        qr4S9Fyj9F9rA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
        0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0An
        Y5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj4J1LgABsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Align with the description of fs_context_parse_param in lsm_hooks.h, which
seems the right one according to the code.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/filesystems/mount_api.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be27..fc3b12cb39d1 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -349,13 +349,12 @@ number of operations used by the new mount code for this purpose:
 					    struct fs_parameter *param);
 
      Called for each mount parameter, including the source.  The arguments are
-     as for the ->parse_param() method.  It should return 0 to indicate that
-     the parameter should be passed on to the filesystem, 1 to indicate that
-     the parameter should be discarded or an error to indicate that the
-     parameter should be rejected.
+     as for the ->parse_param() method.  It might reject the mount parameter
+     with an error and might return 0, if the mount parameter is used by an LSM;
+     otherwise returns -ENOPARAM to pass it on to the filesystem.
 
      The value pointed to by param may be modified (if a string) or stolen
-     (provided the value pointer is NULL'd out).  If it is stolen, 1 must be
+     (provided the value pointer is NULL'd out).  If it is stolen, 0 must be
      returned to prevent it being passed to the filesystem.
 
    * ::
-- 
2.25.1

