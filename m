Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E5638FE5
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 19:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKYSfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 13:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKYSfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 13:35:51 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1654755
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 10:35:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t17so4303769pjo.3
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ql/f6C0KatNsw796d2F8H00l4lkKqoiDEV1Oq0E2AIc=;
        b=Wn1/zdfwH23KRXEGVT+zDd6hzo64Olpzbk7sPXgpdQUDcXiAQUDcWuGc6IBajQJVX+
         LKN7HpF4XfcltUwFaJv9d+9IordVdiUN6y9zvoWwPLc5y+BUoxdnv/qK/w8VHxYjtfl6
         cwye5GudquBGeFDmETPsORY6f70wpyWegbaDS0GEIfB3JdsGRfRSrk9Khyi9gu+SEe5h
         dhF6k79b7xEHa2Dr7J/tUO/mX7shn6VG5732e4AbqG9Q16538D5DdRWHnjtRFefb7O2+
         oq/nLTuHUkO2zBtH9QfJ21UA1t2+EA2d/5DaR6q1cfntrIBosMflGtp/V7Ka0nzAhvyz
         +E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql/f6C0KatNsw796d2F8H00l4lkKqoiDEV1Oq0E2AIc=;
        b=iAkwoNEhIzvo21fr/RF7+eY+Uu8Jx25KuFr/1HAkXGmmgR1wMPPtlr1THykzSSXXxB
         O18M6AIGqJDymY/8AiHqhvUSCX/Oxz+G5deqO9igCYQBhyINR/oYshp9NKKOG9FQy6Pv
         +UjC8U1uyp+bQlfuCMXcUQUr3ZIPl9dOvVKtm4X8yfSLO8u6IqoUmT7ENYWm/69DBy3w
         9XwwnljHW00jizvPGQjJNgmiMdsnmFN/ynqHjJN44mp7lEDQ1JBfGm+62UiXPnl/3apr
         MAEApXpwKdKShlhcrCa5veuE5zpDPNFDKfzPZ9Ef1uVdrBapKDj6tn7xLx0kOp9qVbbq
         jUrw==
X-Gm-Message-State: ANoB5pm8OpclHsJMTZgg0nxp9e0FCOsKZfFp5809LHhw31pQQOldVriB
        3QMw+Upb0AAjarAPW2HiiL8=
X-Google-Smtp-Source: AA0mqf48BHBhCR+c7d0+siCG4ZkGdJTTBNX0fGpp0I174PiT5t4db1LJSL5zc/UUZQmHVeFRqXySMQ==
X-Received: by 2002:a17:90b:4b4a:b0:214:6fc:31cf with SMTP id mi10-20020a17090b4b4a00b0021406fc31cfmr46405210pjb.21.1669401349941;
        Fri, 25 Nov 2022 10:35:49 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9e9c])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b005745635c5b5sm3389180pfp.183.2022.11.25.10.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 10:35:49 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Tighten ptr_to_btf_id checks.
Date:   Fri, 25 Nov 2022 10:35:46 -0800
Message-Id: <20221125183546.1964-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The networking programs typically don't require CAP_PERFMON, but through kfuncs
like bpf_cast_to_kern_ctx() they can access memory through PTR_TO_BTF_ID. In
such case enforce CAP_PERFMON. Also make sure that those programs are GPL if
they access kernel data structures. All kfuncs require GPL anyway.

Also remove allow_ptr_to_map_access. It's the same as allow_ptr_leaks and
different name for the same check only causes confusion.

Fixes: fd264ca02094 ("bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  5 -----
 include/linux/bpf_verifier.h |  1 -
 kernel/bpf/verifier.c        | 17 ++++++++++++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c6aa6912ea16..4235ac4ed1c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1891,11 +1891,6 @@ static inline bool bpf_allow_uninit_stack(void)
 	return perfmon_capable();
 }
 
-static inline bool bpf_allow_ptr_to_map_access(void)
-{
-	return perfmon_capable();
-}
-
 static inline bool bpf_bypass_spec_v1(void)
 {
 	return perfmon_capable();
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c05aa6e1f6f5..b5090e89cb3f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -531,7 +531,6 @@ struct bpf_verifier_env {
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	bool allow_uninit_stack;
-	bool allow_ptr_to_map_access;
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6599d25dae38..69040c09f4f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4703,6 +4703,18 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	u32 btf_id;
 	int ret;
 
+	if (!env->allow_ptr_leaks) {
+		verbose(env,
+			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+			tname);
+		return -EPERM;
+	}
+	if (!env->prog->gpl_compatible && btf_is_kernel(reg->btf)) {
+		verbose(env,
+			"Cannot access kernel 'struct %s' from non-GPL compatible program\n",
+			tname);
+		return -EINVAL;
+	}
 	if (off < 0) {
 		verbose(env,
 			"R%d is ptr_%s invalid negative access: off=%d\n",
@@ -4823,9 +4835,9 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	t = btf_type_by_id(btf_vmlinux, *map->ops->map_btf_id);
 	tname = btf_name_by_offset(btf_vmlinux, t->name_off);
 
-	if (!env->allow_ptr_to_map_access) {
+	if (!env->allow_ptr_leaks) {
 		verbose(env,
-			"%s access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
 			tname);
 		return -EPERM;
 	}
@@ -16675,7 +16687,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks();
 	env->allow_uninit_stack = bpf_allow_uninit_stack();
-	env->allow_ptr_to_map_access = bpf_allow_ptr_to_map_access();
 	env->bypass_spec_v1 = bpf_bypass_spec_v1();
 	env->bypass_spec_v4 = bpf_bypass_spec_v4();
 	env->bpf_capable = bpf_capable();
-- 
2.30.2

