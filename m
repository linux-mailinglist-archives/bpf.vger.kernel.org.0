Return-Path: <bpf+bounces-49584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3281A1A88B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36CC3AF5DF
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2D15A843;
	Thu, 23 Jan 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+GLwRyl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71A2153E0;
	Thu, 23 Jan 2025 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651965; cv=none; b=H7Qt7sVvyoDyPf+sMFpnnOvf3dosIQLWMfyhTF5bSnTCnjiQXMCl1sQfpYYB0LqyvpoIDpaGOEdx0ZBIOtoTI5693cRXvpElmNi6oIQd7QUnac55jCJX90TZUBjkTNYUm59tJiyrCI5/SmhmzN2DKOwo59splbT1qiSKcZcBK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651965; c=relaxed/simple;
	bh=wph3aDXUne9+3+05ABeaMobAhUCM/4X3pkH2X8Tzq9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuoFxPPknQ3wSTat7Y/s9ZNdhV2w4L+3ivUFXx74jJ7RiHrzqPSvvGuO2xMs9hzQHBydMGClI2ASjVuWsv1pkmb2A66HvPQZgbJOPk77WQWcHLAQkFUArUAF65kcPUAtd6gEfmE/kxcmAXdius43lwLplo1Jg67yre4c+RCyj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+GLwRyl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21675fd60feso26055925ad.2;
        Thu, 23 Jan 2025 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651962; x=1738256762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9xy2ERYdfTbZqCRKsReSP/A3tr47zfn3k7WTpKW7mM=;
        b=M+GLwRylqgtQrK8TO4lJihjTDiqKS8KY6DM04iR7UVASdH9KxqZZGmdCFaQB4gtJPh
         VGuvfGFPwt0EEbLlMquwMQMj7QGwXCLIzAkC4PN8wNdbVYgEGRICAZYO/G++IU62eysZ
         AneztBoL4dNF/f9toiKn8IrW3uopbVAYi6SaGcsKaRtHxnwxDPhcL0a8etwUWc84vQD+
         qvUiBFh8e94VPqmFa29tz+X0zOHd+67YV7UwlTEVCE5f6wDGgRHhmOEOxjJJshb+zBOF
         My2kyyNYwxHC9YgxLXoFD+8zgdPbJ4Ie786tnA8RfYrz8f0pxw9TTPGIggOPmkYZjxIC
         Eciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651962; x=1738256762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9xy2ERYdfTbZqCRKsReSP/A3tr47zfn3k7WTpKW7mM=;
        b=vO4d6o+ueOARqM6bDhvm6jHkNZ74CDEwBYZOK471gtyXfsiDoAEU6mq2RDwb8e63wX
         OQHx7eQe97ueb4deKcRJ/mMSTd9+S5pXJxE7eBhrKLnd5Z8AlADQnYzAC9Q+QJWySIBR
         TiGLUJUzGRWXqfq5rc60a7g5h8mRLYuFsgzQPGb6kwkVV1G0LJPN/f1oL8SQOiz09hlU
         FGIRRGmMpVL9VPs/8SN2hRWEy7kSiWt9G3Pqu7ku3juXz0ZYPS7FQvwTEv0cZriYYiJt
         m+2A/GN1CFADzD3+LdYEUoS3WTNxPHPKE7I99cMWy7VJ7jo1j9a/2sD/AOIiwhG0ZOA8
         sewA==
X-Forwarded-Encrypted: i=1; AJvYcCW9on0/gYDR5rUPEknDRRJrj8ikeQf7vMAVu6Ji7U4kY/OAIXBpo+bu+/Rv6FvPf/+4C3eFz5wEJ3ytHNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VMNRqjDFu7qy5HzcQASLA/XDHugyfDSct6k+Vb2nkm9R+88D
	urj8jaLOH+1/GMszClwGWLOMqdM3gfb52T3fbVE9NAjrV1tfoYfg
X-Gm-Gg: ASbGncvAOEj0Jx6/dFQIa8FeGgB10gsdc13lepHlH5TwuPS/bbDt3yyONXngP9kGTyl
	CIPkb5RPySP9qMIWCMO1nhyzKX5kGb7zaYBDO686HDGNpGemtY9UWqUb2+Et46UN+eMRnijBykO
	+5mJ0QZxxXu4+QockShwXzSxZvrrXViaHPMcbka5wm7MXutlU0DENVTgQ7kM1L+JWTk/9dl67xS
	+JvX93FdorJ0u/lT3IAj8BLMrSWDvQV9joHkXLWq7868b1xEHrI/57MfW43S8t43yQtQlxPI23g
	zH4hP23wtkrx3A==
X-Google-Smtp-Source: AGHT+IEdTw4pnjL41rwQIN6p0/20IzSP1hHSlb0opeNUELRCWRnZlwyiSmNPo6aZxsk7m25+BnhpEg==
X-Received: by 2002:a05:6a20:3d8e:b0:1ea:ddd1:2fb6 with SMTP id adf61e73a8af0-1eb2158170dmr49995045637.30.1737651962489;
        Thu, 23 Jan 2025 09:06:02 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac49745c0b9sm89438a12.78.2025.01.23.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:06:02 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Fri, 24 Jan 2025 01:05:54 +0800
Message-Id: <20250123170555.291896-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123170555.291896-1-chen.dylane@gmail.com>
References: <20250123170555.291896-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 17 ++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 47 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..ac0b46d8d8f9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1680,7 +1680,22 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
  */
 LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
-
+/**
+ * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
+ * use of a given BPF kfunc from specified BPF program type.
+ * @param prog_type BPF program type used to check the support of BPF kfunc
+ * @param kfunc_id The btf ID of BPF kfunc to check support for
+ * @param off The module BTF FD, 0 for vmlinux
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and kfunc is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
+				      int kfunc_id, __s16 off, const void *opts);
 /**
  * @brief **libbpf_num_possible_cpus()** is a helper function to get the
  * number of possible CPUs that the host kernel supports and expects.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a8b2936a1646..e93fae101efd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		libbpf_probe_bpf_kfunc;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..641b1b008eeb 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,53 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
+			   __s16 off, const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_EXIT_INSN(),
+		BPF_EXIT_INSN(),
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	int err;
+	char buf[4096];
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	/* Same logic as probe_bpf_helper check */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	insns[0].code = BPF_JMP | BPF_CALL;
+	insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
+	insns[0].imm = kfunc_id;
+	insns[0].off = off;
+
+	buf[0] = '\0';
+	err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	if (err < 0)
+		return libbpf_err(err);
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
+	 * it will emit "kernel btf_id 4294967295 is not a function"
+	 */
+	if (err == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function")))
+		return 0;
+
+	return 1; /* assume supported */
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
-- 
2.43.0


