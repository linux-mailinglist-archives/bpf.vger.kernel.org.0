Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE518467E08
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353568AbhLCTWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:22:40 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36353 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbhLCTWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:39 -0500
Received: by mail-wr1-f46.google.com with SMTP id u17so415315wrt.3;
        Fri, 03 Dec 2021 11:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPyKSTQS13H+9PPu+yDZzjVvnXspKrenQt7rJS7SmrA=;
        b=Rgm2Baq6ELJvx3sI+wBoj3qZCIspQHz2yUStVgCFF1QuJmDtSXDCktr19YV9S0OZut
         /YV+yPbdSw986gV/clpook8sKDUog8trp1LI7CYZLSX8WbqQojT4DgtGtZ2GEaFAH4hN
         0O3Nb0W4s1zcvv94KpyKJ3spFdQCtD8ee1stsvbY2WoYn7RbG5KEe8K9rl/eSxCXYC/M
         ohJoPXBYTd0fSeo4G+zPMgEOGoU6hSqF5GUGIAcQmQgyl2R1J6eodJ5UiatzzJAXi2yb
         I036EKQxbbZwy3YQ5v/dLMMqPELz6Fi915mBvn8scsxkMejpxxqQLIBd+uX9u3I+El+X
         U8eg==
X-Gm-Message-State: AOAM532CX8fXMee4EtZrH8BMmpARzPh0+ZuLUdQ98T6gDJK6k1Qn7YSd
        Czm24Cw0lXosq5l0oUGX6LTQSmie+r+6Tg==
X-Google-Smtp-Source: ABdhPJyVBEniQKOVcHpV05kNmkTckdmdgN07HQFa7tNdGunospt36vtv01i0qp8wC56ukQH7TEJbpA==
X-Received: by 2002:adf:e512:: with SMTP id j18mr23876246wrm.532.1638559153960;
        Fri, 03 Dec 2021 11:19:13 -0800 (PST)
Received: from t490s.teknoraver.net (net-37-117-189-149.cust.vodafonedsl.it. [37.117.189.149])
        by smtp.gmail.com with ESMTPSA id z14sm3472374wrp.70.2021.12.03.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:19:13 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: add signature to eBPF instructions
Date:   Fri,  3 Dec 2021 20:18:42 +0100
Message-Id: <20211203191844.69709-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203191844.69709-1-mcroce@linux.microsoft.com>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When loading a BPF program, pass a signature which is used to validate
the instructions.
The signature type is the same used to validate the kernel modules.

This happens when loading a program with, respectively, an invalid and
a valid signature:

    # ./core-bad
    [ 8524.417567] Invalid BPF signature for '__loader.prog': -EKEYREJECTED
    failed to open and/or load BPF object
    # ./core-ok

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 crypto/asymmetric_keys/pkcs7_verify.c    |  7 +++-
 include/linux/verification.h             |  1 +
 include/uapi/linux/bpf.h                 |  2 +
 kernel/bpf/Kconfig                       |  8 ++++
 kernel/bpf/syscall.c                     | 47 +++++++++++++++++++++---
 6 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index ad8af3d70ac0..e4f2fee19c5f 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -26,6 +26,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_KEY_SIGNATURE]		= "key sig",
 	[VERIFYING_KEY_SELF_SIGNATURE]		= "key self sig",
 	[VERIFYING_UNSPECIFIED_SIGNATURE]	= "unspec sig",
+	[VERIFYING_BPF_SIGNATURE]		= "bpf sig",
 };
 EXPORT_SYMBOL_GPL(key_being_used_for);
 
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 0b4d07aa8811..ab645f23c021 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -411,12 +411,15 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 
 	switch (usage) {
 	case VERIFYING_MODULE_SIGNATURE:
+	case VERIFYING_BPF_SIGNATURE:
 		if (pkcs7->data_type != OID_data) {
-			pr_warn("Invalid module sig (not pkcs7-data)\n");
+			pr_warn("Invalid %s (not pkcs7-data)\n",
+				key_being_used_for[usage]);
 			return -EKEYREJECTED;
 		}
 		if (pkcs7->have_authattrs) {
-			pr_warn("Invalid module sig (has authattrs)\n");
+			pr_warn("Invalid %s (has authattrs)\n",
+				key_being_used_for[usage]);
 			return -EKEYREJECTED;
 		}
 		break;
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a655923335ae..71482644eea0 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -27,6 +27,7 @@ enum key_being_used_for {
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
+	VERIFYING_BPF_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
 extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c26871263f1f..bbb4435c7586 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1346,6 +1346,8 @@ union bpf_attr {
 		__aligned_u64	fd_array;	/* array of FDs */
 		__aligned_u64	core_relos;
 		__u32		core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
+		__aligned_u64	signature;	/* instruction's signature */
+		__u32		sig_len;	/* signature size */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index d24d518ddd63..735979bb8672 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -79,6 +79,14 @@ config BPF_UNPRIV_DEFAULT_OFF
 
 	  If you are unsure how to answer this question, answer Y.
 
+config BPF_SIG
+	bool "BPF signature verification"
+	select SYSTEM_DATA_VERIFICATION
+	depends on BPF_SYSCALL
+	help
+	  Check BPF programs for valid signatures upon load: the signature
+	  is passed via the bpf() syscall together with the instructions.
+
 source "kernel/bpf/preload/Kconfig"
 
 config BPF_LSM
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b3ada4085f85..5aaa74a72b46 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -32,6 +32,10 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 
+#ifdef CONFIG_BPF_SIG
+#include <linux/verification.h>
+#endif
+
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
@@ -2184,7 +2188,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD core_relo_rec_size
+#define	BPF_PROG_LOAD_LAST_FIELD sig_len
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -2302,6 +2306,43 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 			     bpf_prog_insn_size(prog)) != 0)
 		goto free_prog_sec;
 
+	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
+			       sizeof(attr->prog_name));
+	if (err < 0)
+		goto free_prog_sec;
+
+#ifdef CONFIG_BPF_SIG
+	if (attr->sig_len) {
+		char *signature;
+
+		signature = kmalloc(attr->sig_len, GFP_USER);
+		if (!signature) {
+			err = -ENOMEM;
+			goto free_prog_sec;
+		}
+
+		if (copy_from_user(signature, (char *)attr->signature, attr->sig_len)) {
+			err = -EFAULT;
+			kfree(signature);
+			goto free_prog_sec;
+		}
+
+		err = verify_pkcs7_signature(prog->insns,
+					     prog->len * sizeof(struct bpf_insn),
+					     signature, attr->sig_len,
+					     VERIFY_USE_SECONDARY_KEYRING,
+					     VERIFYING_BPF_SIGNATURE,
+					     NULL, NULL);
+		kfree(signature);
+
+		if (err) {
+			pr_warn("Invalid BPF signature for '%s': %pe\n",
+				prog->aux->name, ERR_PTR(err));
+			goto free_prog_sec;
+		}
+	}
+#endif
+
 	prog->orig_prog = NULL;
 	prog->jited = 0;
 
@@ -2320,10 +2361,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_prog_sec;
 
 	prog->aux->load_time = ktime_get_boottime_ns();
-	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
-			       sizeof(attr->prog_name));
-	if (err < 0)
-		goto free_prog_sec;
 
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr);
-- 
2.33.1

