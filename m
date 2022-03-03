Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD224CB5FC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiCCEvg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCCEvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:31 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED99144F7B
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:46 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id 195so4537456iou.0
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZZl/wbB3/klWsaC/srR2PnDnJ+346S3rmfP6JBRMeQ=;
        b=onBHxbxSdqWSrCffTMnEdUZXMyv+bNv0OH+ZpplPzpmocPEcd+smZKBJT9IiyV8NHS
         4HiFGET0LB73EsTX4wuYbbpUzMW9/XOxre3YptRz97CfBSyNRHrH5sqKSsrKf+n4UtFw
         +ebaPkxhw9qF+iR5Xy3npng++n2xwsFBQxmV8MQRe0Zib0uousOBTSTTrHghX6xpSFRm
         NaKLUkLcUEmHvLsraUfpjYUTkQpNvmPRPHwZAPuLMSLLyBUOWfvScbZH+rp6fix+r4Gf
         1nryoWGB87Fjb+VS3eqqnNavkyaj4kcf8ENMXcNISlDQkxwUk10ZC9o6tkZ733C+/5VK
         SDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZZl/wbB3/klWsaC/srR2PnDnJ+346S3rmfP6JBRMeQ=;
        b=dOUwptTB5QhlZ9ii6XQO0PWUgCgaugq4NEn+wACYX+t5PAfRKrr0XDyQeOmokyLn+X
         QUnYKuB0pJw1zAT7uVzpyMJw5uKG1rb+pZZc90JstTrAi+OkvexUuRrP4qxr1JIA3B1d
         Ve24x5e9DAcayIoWeycbsA2UKpdOjDTXLofB0nBnGy9Wd4ux7OQsYi0195V4DeNSAYO3
         xIJXDIFWjsRyadL0CCgqYQkQuFPTZA/bibt1fXDu8wZg5OR4DNyzOXcV+V0+cVHP53Pw
         tCCjyjwbq8suFrtMAqrC+D1cMLN97TPCUyVEBlBUKGEMTjDG4S/WNqq6jQ2vvICsl9zi
         kzcw==
X-Gm-Message-State: AOAM533vX0bTzzgeOet6Fof0c+07wass+tZ7ifvpeZnB/LwXvvOpXV/+
        PB4cYrVbvEyi6kHuCWf5hAoxb6cYc4Y=
X-Google-Smtp-Source: ABdhPJwmsp18xpJA5FOhmkzxbIiH0V9XJIPYuJODBaX/EzpgSD9XXGd07cG4gjcBlnn0x0QS8Hjzgw==
X-Received: by 2002:a6b:ce01:0:b0:610:8f2:3b7 with SMTP id p1-20020a6bce01000000b0061008f203b7mr26252447iob.25.1646283046146;
        Wed, 02 Mar 2022 20:50:46 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id o7-20020a056e02092700b002bdf00b573esm698857ilt.6.2022.03.02.20.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 3/8] bpf: Disallow negative offset in check_ptr_off_reg
Date:   Thu,  3 Mar 2022 10:20:24 +0530
Message-Id: <20220303045029.2645297-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; h=from:subject; bh=Med6/YzAHbbDWCvhM5HtUKjhXrUlLaEKO3Rdl9NoNWo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/nMeKHJDZeqP/X0Dd6dzjnxDbMqjn16DMrzoM 7CGG9/qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RyuztD/ wLhsRo2rB6i2XP5kzF47QamAUznBct1W2626kKOKtHwlr6/njhdhFUGQpDrleMllxtCbCzIcuJJXAv 8CX5dusTEDvAqN5q1yXNdtFjH9TCje5f3+qkDzmju1+O9PwCo1rDT9hwybOyS8+vzPx8pZDaRoOx2o G6FNSFwuTw/QQZLTe7Ym85ZE6VoH+igMF27IjjKtyn36FeSLyY8sOtmSsFeU6rZ1p14okx4KgDC+x9 64Iy7q/8xGuFPYevz3wLJp4ImlySQkuteKZXFNxhtqzdHMQBNDfGGfeNAREc5YEBEzx9NGaVeAf7v3 qieGYNICOxGcQ4jeOeBeHdwoC5D9VOs67PpT/gmotZ2Ykf6kAYrD0P53Oir8ds9dBdakmS7OwtN4Rs qEBNc5T0U9WKHRSGOrF8fWuNe5EExejUm1u1jBNNF8tgnhbJ2RDLB7HstxQAVqoDc7d2Q7rke44H8X PjXn8i9ON5wddnRACPg5uqy/fb8+D1apKEvoPkjsIxQEHZAJYzYZm0wJ5s1O8OMItbZRWE/Hzgq80m qGeHvLzs22KJOU5ksGop1jr1MsKQVXWTMVfsJs1IITv2yHBfLFz/pedp/hMZnUSUVZ0aseIUPXy436 lAmY4EW0KObUMaC2/7bOyN8u8KXmJP/CSUMMp8r3bSCBi3io7r0ZFcwe763g==
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

check_ptr_off_reg only allows fixed offset to be set for PTR_TO_BTF_ID,
where reg->off < 0 doesn't make sense. This would shift the pointer
backwards, and fails later in btf_struct_ids_match or btf_struct_walk
due to out of bounds access (since offset is interpreted as unsigned).

Improve the verifier by rejecting this case by using a better error
message for BPF helpers and kfunc, by putting a check inside the
check_func_arg_reg_off function.

Also, update existing verifier selftests to work with new error string.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                   | 6 ++++++
 tools/testing/selftests/bpf/verifier/bounds_deduction.c | 2 +-
 tools/testing/selftests/bpf/verifier/ctx.c              | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a641e61767b4..9f12a343bb6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3984,6 +3984,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	 * is only allowed in its original, unmodified form.
 	 */
 
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
 	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
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

