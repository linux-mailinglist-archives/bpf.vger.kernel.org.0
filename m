Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBB62A0DF
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiKOR7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKOR6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:58:11 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2692F3BE;
        Tue, 15 Nov 2022 09:58:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NBYdS3q2Dz9xs6c;
        Wed, 16 Nov 2022 01:51:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHcW7o0nNj73dpAA--.16599S6;
        Tue, 15 Nov 2022 18:57:46 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 4/4] security: Enforce limitations on return values from LSMs
Date:   Tue, 15 Nov 2022 18:56:52 +0100
Message-Id: <20221115175652.3836811-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHcW7o0nNj73dpAA--.16599S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZFykWF4kJF4UJF1xGw47XFb_yoW5Jw47pw
        4akFy5KF4j9Fy7XFZ3tanxua1Sv3yrKr4DCrZxXw15Za98Jwn8J3W8tF15tF1rCry8t34Y
        gF4Ut3y5Cw4DG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj4F5bgAAsw
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

LSMs should not be able to return arbitrary return values, as the callers
of the LSM infrastructure might not be ready to handle unexpected values
(e.g. positive values that are first converted to a pointer with ERR_PTR,
and then evaluated with IS_ERR()).

Modify call_int_hook() to call is_ret_value_allowed(), so that the return
value from each LSM for a given hook is checked. If for the interval the
return value falls into the corresponding flag is not set, change the
return value to the default value, just for the current LSM.

A misbehaving LSM would not have impact on the decision of other LSMs, as
the loop terminates whenever the return value is not zero.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/security/security.c b/security/security.c
index 4041d24e3283..cd417a8a0e65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -716,6 +716,35 @@ static int lsm_superblock_alloc(struct super_block *sb)
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/*
+ * The return value flags of the LSM hook are defined in linux/lsm_hook_defs.h
+ * and can be accessed with:
+ *
+ *	LSM_RET_FLAGS(<hook_name>)
+ *
+ * The macros below define static constants for the return value flags of each
+ * LSM hook.
+ */
+#define LSM_RET_FLAGS(NAME) (NAME##_ret_flags)
+#define DECLARE_LSM_RET_FLAGS(RET_FLAGS, NAME) \
+	static const u32 __maybe_unused LSM_RET_FLAGS(NAME) = (RET_FLAGS);
+#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...) \
+	DECLARE_LSM_RET_FLAGS(RET_FLAGS, NAME)
+
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+
+static bool is_ret_value_allowed(int ret, u32 ret_flags)
+{
+	if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
+	    (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
+	    (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
+	    (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
+		return false;
+
+	return true;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -741,6 +770,11 @@ static int lsm_superblock_alloc(struct super_block *sb)
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (!is_ret_value_allowed(RC, LSM_RET_FLAGS(FUNC))) { \
+				WARN_ONCE(1, "Illegal ret %d for " #FUNC " from %s, forcing %d\n", \
+					  RC, P->lsm, LSM_RET_DEFAULT(FUNC)); \
+				RC = LSM_RET_DEFAULT(FUNC);	\
+			}					\
 			if (RC != 0)				\
 				break;				\
 		}						\
-- 
2.25.1

