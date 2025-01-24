Return-Path: <bpf+bounces-49670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285CCA1B810
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889B93AE6FB
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0B73446;
	Fri, 24 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIk0GBmN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416B14900B;
	Fri, 24 Jan 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729892; cv=none; b=Mr/xKaW6f2z+CcFnMGy4hcY/0E+lMzaH9SydfliQxtr8abFY1XSIMsPlDm+wIZ/qNFtWhKQLSDQzxw1PcGFd291/Q6UtHZdXtYTnOxnL6jyw2Aw95e/ROT8giy2p4wNFwrWClAzk6KItADwuGN2zFxRsXcI6Yy8nZiAM2j1Fy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729892; c=relaxed/simple;
	bh=B9i4zo+qPi6T5wYNVxp/WhS22mISPzkNc8kUWC3aJqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FOgwvA77M6W1Yr3BxJPXdB0ZjGnIVSafrbOa4rZY/Foz2PEO6ecx+y1bw4M1FxjA1aRi4zhYwZ559+umf5bwwF7Ev//FC5poii3F9JmcJWGDMtPOZkoQBriD1wgx5BJN7XJdvjohJMh+/G10HOsG8vGTGFiFc7ISfOb+m5XtZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIk0GBmN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166651f752so34317845ad.3;
        Fri, 24 Jan 2025 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729890; x=1738334690; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s9ufpMraNZm2hfeBqLDey4CmRwUJrB+/zBUHHA/6ktI=;
        b=fIk0GBmN56Q4UlrdHvBwv2GJxwuStmSzdOjKF3OAYeEkj8QjZZepwkDLjd8j6F056K
         VDmBm1iftsKUo0fiQaiJaLqw9mEbHDPLKPFO/iC1Q+RTtwbYaTx37IMO3YIkdUWihx9h
         BWOmvuvJqSa1pby3LdGuEgqjfBewkslifs6pGs7sqV2YPURlDIzdnRX0adfhtSEG4+gQ
         DuwP4wIq2nZxdSfKFO1O43D8rKeUFrTrfJzPortRRSM46MYGsdBmULcp+RgmxCFgTbTb
         sPf56VvjkEeXFiK1XuZ0Wxb2uJjSP8FnZJwxpaE+JtkdZ0pxsUgPEXGsk9xAh48CAvTB
         LSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729890; x=1738334690;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ufpMraNZm2hfeBqLDey4CmRwUJrB+/zBUHHA/6ktI=;
        b=M6mxM8JuozhMjToQvV3tltWz6xr4VLr1O27c2fAX4OxdOO2TOAMMqLTxcC2s2dpFzG
         HdCrjAFtItEMCd5rtRPaCUxWaiHbJf0B2D+mpusmtE5J7U4x1YYg+/pKe6vjEZDOFq4/
         bhB29ScGUScnJsYiKUEwaxv6Y4Nxd+nPnGrp8A90QeamNC3WTa67wpjo5B1oaGumb06f
         kZTza05pX7bkYqFeveRXQeCoYAvT1xkBz6XfZfDP11X9gli6uRhg4lXJ+HRMKYl2iFgg
         emE++DSn5BfJkG8PsEaKai3S1Bp/el8rBwQxpV7OwxSYhbYPPmQb+6vRw8G3zB4A3S6t
         19WA==
X-Forwarded-Encrypted: i=1; AJvYcCWGccVS849H7OMPopF6gDiBMmuFP7cRu4x31ipfmaX2u9+pJRRhvz2tbSWzkXg7uE1ckG1CJiPWT2hDqIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87+Yaq2Ua6f32pyV3c/yMU1SohP45gLIBXQEWXsSI8UnD2RB9
	a8LW5f7feHTNIoJ2W1aNs+oXxRUa1t2pAJxkGAO5t22KnTG/Zp5m
X-Gm-Gg: ASbGncvBLg+HWpiEkQHe1KsDndeEcbCZ8TsrpEtcb8676kA+m6hNpnXp+ZpDTXYTSTh
	Zvvelyt+xrgfTrG9nanmKeO6JYxP+yYNRIg4mRMjpigYpvvhEidy3ACRDqW0Op4PLMrMf3rlZ7P
	mQyX7iUNbNf2hWZLDkmi6rPiqp1Fb0WPR4J/weZvI6z/FQIhMzRJPBcjnxyGJSqe45VQkf/WzGZ
	HETqL1Sx5Mgo3NNqO5czp8Cc9arPCNNctAz+DAu5q7VnyUNnArjk6lHG30OfmeBFMFJ04b5fxNB
	SS/iAg==
X-Google-Smtp-Source: AGHT+IFHOB8MlReNwhAbNqCI+qxEslOHHLYJOV51dOSwm3AM7OV6fSk2eY04Ow+DgBfy5fBYxRs8Gg==
X-Received: by 2002:a17:902:cece:b0:216:3633:36e7 with SMTP id d9443c01a7336-21c3556ae9amr448115475ad.26.1737729890401;
        Fri, 24 Jan 2025 06:44:50 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424ee18sm16803635ad.247.2025.01.24.06.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2025 06:44:50 -0800 (PST)
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
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v3 2/3] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Fri, 24 Jan 2025 22:44:10 +0800
Message-Id: <20250124144411.13468-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250124144411.13468-1-chen.dylane@gmail.com>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 17 ++++++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..035829e22099 100644
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
+ * @param btf_fd The module BTF FD, 0 for vmlinux
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and kfunc is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
+				      int kfunc_id, __s16 btf_fd, const void *opts);
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
index b73345977b4e..cd7d16c1cc49 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -446,6 +446,36 @@ static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
 	return 0;
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
+			   __s16 btf_fd, const void *opts)
+{
+	struct bpf_insn insn;
+	int err;
+	char buf[4096];
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	insn.code = BPF_JMP | BPF_CALL;
+	insn.src_reg = BPF_PSEUDO_KFUNC_CALL;
+	insn.imm = kfunc_id;
+	insn.off = btf_fd;
+
+	err = probe_func_comm(prog_type, insn, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
+	 * it will emit "kernel btf_id 4294967295 is not a function".
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


