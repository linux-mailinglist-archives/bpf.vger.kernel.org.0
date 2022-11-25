Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40084639144
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKYWGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKYWGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 17:06:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E0823380
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 14:06:21 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so5243639pjb.0
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/pxS9RJFI7fAjYqEZHRfzq5HX/+7vQRHfWRJmxesTA=;
        b=eD3wmT27iOu3RzNRZDKWdFBO5LmlMsUPSqF0lnJe5kUJRKDFVOiGw/mrtY1uMT/qiA
         ntx5tKVx2Q/IoxoNiWHxfn77ZoTRICFa3oO/iK7R+DH/7et8E/fWo+e7QuhbTmnJ2XVq
         OKoVqEJ4eCos8bArtbYtbTdvA6htOTvNY0M5Qy2YX8D+L5JRGhf3OumjepEyCzm2Gbc1
         ZX0nty83+e3jZICw2EyHP3wrxtZxG5YpsM69n/3qwn7FEePdCdk2SsmM0YavzncdT11C
         BC47Gv4guO8ytDuyxNm2pLTBUht30u9hv5QgGRD/xCCxuEW2oCTOzPSPZdODminuUBoD
         +xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/pxS9RJFI7fAjYqEZHRfzq5HX/+7vQRHfWRJmxesTA=;
        b=pyrxD11rAP1xv1jx7e4e9h2BOOKg+754VTfXxWAIybCdSx+Jd9GvCX/wxjMP/ueUXI
         u04f1l/QbVQ+1bmawTrg24/sY4sywQa6Q88UikYOzNoi45sZTG+tDAtQ9R/uqtJN1P5M
         t9IWx//5R1f097Sg9KpcolICWwYauJX0O6A+Bw2vTMEFUHQiVEMg9llSpSuL+pvaRJT1
         fszktAooJ5q53I7jfjgNdqM7xgxWUR1KG2mAx11mHNXkjSKC+MH9zss+ugnqXZnWMBw+
         /xibr9+g2MGEwcLf83dbD4cn3chpm1YYZt8FvnEiY83nMQJZd7R9+fhH4CuAHu9NcSBL
         MfcQ==
X-Gm-Message-State: ANoB5plvlCpRjPCzumABMBdf3DEdn53mqOhy8iWp/E58zVx5iREr3DWV
        i87XyLGK2WsiPX00IPMjjbg=
X-Google-Smtp-Source: AA0mqf6DmkTpB1WuRy0xxLSPwOnYIlvlM6uPRVljiiAzTSSxXDmB23jWIPsaUw+8s0G3o3FkrHj6CA==
X-Received: by 2002:a17:902:f08d:b0:189:6b32:27dc with SMTP id p13-20020a170902f08d00b001896b3227dcmr3576411pla.29.1669413981084;
        Fri, 25 Nov 2022 14:06:21 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:9e9c])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903404c00b001891b01addfsm3826359pla.274.2022.11.25.14.06.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 14:06:20 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next] bpf: Tighten ptr_to_btf_id checks.
Date:   Fri, 25 Nov 2022 14:06:17 -0800
Message-Id: <20221125220617.26846-1-alexei.starovoitov@gmail.com>
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
such case enforce CAP_PERFMON.
Also make sure that only GPL programs can access kernel data structures.
All kfuncs require GPL already.

Also remove allow_ptr_to_map_access. It's the same as allow_ptr_leaks and
different name for the same check only causes confusion.

Fixes: fd264ca02094 ("bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx")
Fixes: 50c6b8a9aea2 ("selftests/bpf: Add a test for btf_type_tag "percpu"")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                             |  5 -----
 include/linux/bpf_verifier.h                    |  1 -
 kernel/bpf/verifier.c                           | 17 ++++++++++++++---
 .../selftests/bpf/progs/btf_type_tag_percpu.c   |  1 +
 tools/testing/selftests/bpf/verifier/map_ptr.c  |  8 ++++----
 5 files changed, 19 insertions(+), 13 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 8feddb8289cf..38f78d9345de 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -64,3 +64,4 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testing/selftests/bpf/verifier/map_ptr.c
index 1f82021429bf..17ee84dc7766 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr.c
@@ -9,7 +9,7 @@
 	},
 	.fixup_map_array_48b = { 1 },
 	.result_unpriv = REJECT,
-	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
+	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "R1 is bpf_array invalid negative access: off=-8",
 },
@@ -26,7 +26,7 @@
 	},
 	.fixup_map_array_48b = { 3 },
 	.result_unpriv = REJECT,
-	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
+	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "only read from bpf_array is supported",
 },
@@ -41,7 +41,7 @@
 	},
 	.fixup_map_array_48b = { 1 },
 	.result_unpriv = REJECT,
-	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
+	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = REJECT,
 	.errstr = "cannot access ptr member ops with moff 0 in struct bpf_map with off 1 size 4",
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
@@ -57,7 +57,7 @@
 	},
 	.fixup_map_array_48b = { 1 },
 	.result_unpriv = REJECT,
-	.errstr_unpriv = "bpf_array access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
+	.errstr_unpriv = "access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN",
 	.result = ACCEPT,
 	.retval = 1,
 },
-- 
2.30.2

