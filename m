Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60FD4CE062
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiCDWru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCDWrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:47 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD004BB0B8
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:46:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a5so8784196pfv.9
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2Uyl6EuVV+v9i9O9qSFOFqOGNoRQLpqVevKf453Lbg=;
        b=i3kfawYpHzzl7xKrBRMleBsRQz7T8sC58ooqBNUjytSJYqPs+rZW8i1dae3SWEnr7J
         vEBQe1WnYwqLWM2XRsw3Tf7zWoBAk5gQHDE42d717XvaKaBGP+dHAow0T/1AzVVit467
         lqxyW/LZg0Xwa57lE9RlWBTiM762KpDO2V/Ta5BV3EjnWTJIKmXRD555KP121469zKmw
         VO/ftFFeOjwObrHFlEpv88ep9TfCXr0zkWkcfWPCHQ91Rq3TMxxAxeIXAX2cteuTajdg
         5EfnbAEnnwLZZ2vPC37yj7ePS1FwW2mRziwWaQtHvpmDmmDtn4/h5ArBnlkMFC44pHx9
         CfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2Uyl6EuVV+v9i9O9qSFOFqOGNoRQLpqVevKf453Lbg=;
        b=I0x4wrlezHqQP1RIbTwJPMVjR+1RxzEiN9malry9QkzzG2pjKjVgmfOKTpVjtDuvop
         dLYpvxrPtRtN6DOOv8m2ETsVvXPYkeV0tiwctKojwZ096A/QhvFb0yJo3RFely0aVfaO
         gz5bXCqHpfVO5FNNB4YQaDCDU+pzpCW2Tiwl+0GMtyffYxfAIMn49Fnpr8B24xcKoJQg
         ohTMhBwSz3DXygakexlLT3VOr0UsGd3WM8c5Biwf7BO+L14Xkj4ssS0MdwtbYg5BJavD
         xBGEy4L6HIABilb75VTHHjgZOoAbAsZjVQuE6j5rLxk5yGceSwBAp/5wUGLkKOqMpjP9
         +5sQ==
X-Gm-Message-State: AOAM533jlrR2A+ZBc+34MUL0WoaK14DFGRaLY+ZJoj5byIYspbEDj2x1
        xCyPqYPw6LzQmlSCSbNq1zFjLvZlvWA=
X-Google-Smtp-Source: ABdhPJx3a3nZtctQ/d/QAdHEnjs5/t2pJn9c8nJAB2fb970dsjyNgopA60QHJMzklkRI/u0Npy6tNg==
X-Received: by 2002:a05:6a00:acf:b0:4e1:9222:1ef3 with SMTP id c15-20020a056a000acf00b004e192221ef3mr982036pfl.18.1646434018007;
        Fri, 04 Mar 2022 14:46:58 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b004e1cee6f6b4sm7229024pfu.47.2022.03.04.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:46:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 3/8] bpf: Disallow negative offset in check_ptr_off_reg
Date:   Sat,  5 Mar 2022 04:16:40 +0530
Message-Id: <20220304224645.3677453-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3278; h=from:subject; bh=pEpU6G1I9N1XMJYQpA1QlFeL1WGf18b2wJyMc0kT3lM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpassU1CPunjESd8TaehffV6Bn0ATVIOXuv/qmaY y3/vHdOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8Ryj0tD/ 9mxnRlF9leIn9qqJys350nhVdeh8QGJYGUR4iZSUD4VopE9lHqna36Ony+JD4MHfzONVtEJ6MjgFVp GIrVDPehInzZqiYBLKDOlHxBt0OHnwdtYQZ351Ykj/AhnL/pClbAnVdL8rGG0W4xjhzngKVr5dFdlY vDU9xDszQ+TwnEs7G+kDvF6q8JfxpZWcS87Kc3rnsFdE6zfJjdxp+wd9pqoIiTAGMZnJN7bx4ARcn7 YsuwcbPdcxqw+EqpjIjm19dOHzXKNZtduv8fSMKmNOxeFVYplrxCMdwUMn4SwgD3I1oN+d6zZ3Pul0 pNyAq7Pa+8dNmizusbyOP94uWDbkto72jBSJro89bw2m29BL2xu7MTkalVpnYjRvXyG7zY+sL+na+j OP0vhZb1WWscVwIjBfX959SOcSwpF/l9REz0D+BtTqNpcGTMjHE/02XNGYfYod+ynG1D/BvgEYNLGO t0DAsgZFX+aa0Z9AICFb6xgXfhz3RXxXmzChpg5DtaxDEtEXkleVeWR2OLQJMMGBOK9I8dT3wfBkUL SJOb4DrhKQTOI1Ly0pMITr/hRtz3NX+78MyVyEE0T5cEZqvPDeQdwRQQChxMq0lu85S5xV0Nn4srzt Szz3PUEAur0MWoIOe0mKHUc9KpNl7wVJhc6DjFdcfnU6u8us5u/yZZRwQk5Q==
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
index e37eb6020253..455b4ab69e47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3990,6 +3990,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
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
index 60f6fbe03f19..c8eaf0536c24 100644
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

