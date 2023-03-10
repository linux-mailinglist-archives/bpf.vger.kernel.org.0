Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E236B3974
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCJJBp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJJA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:57 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8DB10E278;
        Fri, 10 Mar 2023 00:54:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PY0593rGsz9v7H9;
        Fri, 10 Mar 2023 16:46:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmUy8ApkK+yFAQ--.17497S5;
        Fri, 10 Mar 2023 09:54:37 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 3/3] security: Remove integrity from the LSM list in Kconfig
Date:   Fri, 10 Mar 2023 09:54:01 +0100
Message-Id: <20230310085401.1964889-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnbmUy8ApkK+yFAQ--.17497S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykCF13uw4rJw4xWr18Grg_yoW8Kr1fpF
        srKay7trnrZFyF9r4DWrnxCFyxC3s5Wr98Cay3WF4DKa43Aa4qqrsrKr15CFy5Wrs7AFZ8
        Gryagw1a93ZFgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4ZsBQABsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Remove 'integrity' from the list of LSMs in Kconfig, as it is no longer
necessary. Since the recent change (set order to LSM_ORDER_LAST), the
'integrity' LSM is always enabled (if selected in the kernel
configuration).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b..1699dda6821 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -246,15 +246,17 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-	  Any LSMs left off this list will be ignored. This can be
-	  controlled at boot with the "lsm=" parameter.
+	  Any LSMs left off this list, except for those with order
+	  LSM_ORDER_FIRST and LSM_ORDER_LAST, which are always enabled
+	  if selected in the kernel configuration, will be ignored.
+	  This can be controlled at boot with the "lsm=" parameter.
 
 	  If unsure, leave this as the default.
 
-- 
2.25.1

