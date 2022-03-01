Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C034C8470
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiCAG6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiCAG6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:43 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4C5C642
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:03 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso1287234pjj.2
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0cqMHMX8EvwMmzhTS2PB/3S5xzGHQ8ewGQe4NLjkkM=;
        b=VhzHjP+/sYVmLsQnl/TNBUgHTE7OG+jlH1H6zXergEq3hyF7vSnqnn3jPWxfcQBvKQ
         ls7WeVUG6BSAGZ/cb/bVS16mv8Pt+GpfSh1+rofFE257+PFREwKTyHlTerFk00eDjrAa
         mFKGQ13cTqx73EpF1XUs2w8759iRfROPFblQEDk6cv6xuj/Mb7T7NPjO84K2i/sr0NHa
         wxFdC3TtDfn6PzwzofwJVsFmQsPKJFBTvOQzN7/3EPGmNXMQAnOSxG7KZ8oY5tgbc7A9
         MpqhmX2LD07N9wdPbb5Q738u2wppRZx/BRVP+mK4GTaQqKUfEzFnhkk25tNRTSivAz54
         AxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0cqMHMX8EvwMmzhTS2PB/3S5xzGHQ8ewGQe4NLjkkM=;
        b=JKtefkCeVbKcddQNmoMe4zGWNoXD61F7agq/5z2owJkoktjAbTJP96nKp+WXbc7u/4
         KY9CK5nr4rL3Eo7L9efNAGKq2+Lk2ibIKfY8P0T1PmIKSXTcXAiQWXHcr+zp9bjIh6gE
         RNIikZyLxNoKtGkwey2DDi7ptMLaLIfLpFQ2/T+0eikhrkK2z/7fzdrq4EPHdEf9CZOF
         s6wBMBRSIxjevFq18j4Ndvlfnt9jZWL6ZlNKjJLoqRWC4E+slbO4iJlU584C3P33/iCh
         XYvw6kSDab/zFS1DSAOFVBexCPWmLJsgcxyJEXBdu3ql2wt3nqnJ9zDeHU+rUGTRpVTL
         y60Q==
X-Gm-Message-State: AOAM5303pK0XFEye8i3FAZPJnk7lEoCjqwWKzjXIqVwfVegAczGd0GjC
        yN3Kgqp3mhoJVxMVCgOBrhej2RTN0is=
X-Google-Smtp-Source: ABdhPJyh2HqSWSANMX+6PAwVVoPlOBhY9bipj6gvreQx7oCKe74ulp5DcVP1xyRbl2MUan4bsc4bPQ==
X-Received: by 2002:a17:902:6bc1:b0:14a:c390:a44b with SMTP id m1-20020a1709026bc100b0014ac390a44bmr25021779plt.11.1646117883109;
        Mon, 28 Feb 2022 22:58:03 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id b1-20020a630c01000000b003758d1a40easm11956403pgl.19.2022.02.28.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:58:02 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 5/6] selftests/bpf: Update tests for new errstr
Date:   Tue,  1 Mar 2022 12:27:44 +0530
Message-Id: <20220301065745.1634848-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; h=from:subject; bh=48UgOj2SPzCnhSekS1nSYERyuI/x2WQlVQCXYhr4hfM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1Ho7s7L6T9gMFCJhW4UNuKTiKqsTeQ3AKvXwp IMHqjYSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RysUCD/ 9y4fs0pFZyu+nshB/mXOvzRDWQTAF87T47bm8lww5XOAoQOQhAxPzGL5z78bQvTTjnf1KVHOBy6zHM nQVsFwXax4jZXgUx4gyn78sVaHfMET/ca9rc6IlV2NmkoVH439RqUYSAhGkmoRJYxegp6GjPy9F/Lp 7t9eln8FHrntSUqVJF7Fnd8equVbEvu+uznll6Dx4a+1gcIkXBxNxPBnX4x/z+xF1dA5FSKM9tJ3Sw 5WA94T7+m7d6LgGfwST14HWteJ/uTaOcr63YALfSX3EemG4MElnkm7DexmCL3EM53OE1wScuX1ZT/F 34sr4O7zE9F3RsU/2dCwi8NMU3AJz6gygdWIBzx6+LOjvhkZLkPzdYeKInz+DiDjovfLGZKRVK473e 3VqsKSsLA81L7GoPaG56JO3NBSbmL8EcOLNbjyQ5bOWl3eOHzruAlYD+csW5KGFHO9J9IgRscOY9w4 LmsP4KZT9fBgP5Hn2YDeJDuKkzpjVHM1Dz1UAfoTOnHHVOHibvR7MxPkebZXtxxacE4+c2RWbnnu4Q io8Bn44iKNzjB8qDri2z03fx9wQxKp4Xf+uetY3GqLArm6HbZl2cD9PMQHOdHVSs+ic7rL5NBEo+oH SdS6ZVER5HyUXmPULRL+wIib0LOm4ie3FYkFoGepVDJhW1UZQYNLzK5HIZWw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier for negative offset case returns a different, more clear error
message. Update existing verifier selftests to work with that.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
 tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/bounds_deduction.c b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
index 91869aea6d64..3931c481e30c 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_deduction.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_deduction.c
@@ -105,7 +105,7 @@
 		BPF_EXIT_INSN(),
 	},
 	.errstr_unpriv = "R1 has pointer with unsupported alu operation",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-1 disallowed",
 	.result = REJECT,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index 23080862aafd..e47a001c2bcd 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -58,7 +58,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 2",
@@ -71,8 +71,8 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr_unpriv = "dereference of modified ctx ptr",
-	.errstr = "dereference of modified ctx ptr",
+	.errstr_unpriv = "negative offset ctx ptr R1 off=-612 disallowed",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass modified ctx pointer to helper, 3",
@@ -141,7 +141,7 @@
 	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG,
 	.result = REJECT,
-	.errstr = "dereference of modified ctx ptr",
+	.errstr = "negative offset ctx ptr R1 off=-612 disallowed",
 },
 {
 	"pass ctx or null check, 5: null (connect)",
-- 
2.35.1

