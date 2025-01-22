Return-Path: <bpf+bounces-49494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5AA19723
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E32160E4C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E721516A;
	Wed, 22 Jan 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSlbEUKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B0322E;
	Wed, 22 Jan 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565589; cv=none; b=ounw9fMoquYcGf6SQ9K5MCp5K3VzjqysD+9yyKcoycoT3Yn+sWVb7yx0nIjDif0Uqkw0wx8fR0Y82I6CjA7xhi6dj4lPRHElGIOA4/wW4noYtI2XLPTvIhYQz/wdQFvYR5y2oKmdFZvk7rFOXmUIbhxKV2+M4sNxSTUIJ+HUiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565589; c=relaxed/simple;
	bh=b8TR2iiU2iZKAKFmGJOHWvB4sosonYGhQTkdWiUS54o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eOutWxkT4LPJQunH1iyG9xC6j4CLTESI4YkGHyi9I3lS0fCGrB64vkkscc6ZBhre3kB+Rtk51Xw6wLD3W38ps+xFptUbhwYaZnullhXXwT29zw8nF/xFHY/OVLndigbNy117pXlt9zOd1BJjiHrmGYe+HrsAYTl3nRiDBDj/jgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSlbEUKa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21680814d42so117693085ad.2;
        Wed, 22 Jan 2025 09:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737565587; x=1738170387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yndnz8ctYn+NfVrDvN1e55mXp5ZR9QmhfeAPAHYP5kg=;
        b=CSlbEUKaikxfkQixb6+X0h7vDmBMYTirDvfiapbh6x0Rfy16btmWZGJ4AxndCfEzWg
         116bB9vFIRwGvA1qqlGE8X2YN+wgsTz5b3LWPM8YyUzTU+/t6kcQfnnVJ+MD22TTbj7v
         FtBMYhg3RPw/1PQCoOEf6IMmFQ81xkiBflDc16S7ZPNhmRRaZvE3i0undDyaBxnHEHhw
         pp7ifujWcj7hOOO2DY6YjdXfA7cG+m0B9BFOURlsM1s2gOZNaChM/xrCA2+Zi4B5x191
         msZR9U/a1vcOXGwzg35UArf2c3UX8AYljn7+mlzpyckLQLXXdT8iKz4MWc95mDfDugfO
         QcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737565587; x=1738170387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yndnz8ctYn+NfVrDvN1e55mXp5ZR9QmhfeAPAHYP5kg=;
        b=ICArBWIzgy/F1Uo5NXELljWpWL9Q8BtmN2rfnUZrNM/yUffptrzCVMwEgW7BVg0eYE
         K/IjQnkEeF2rkqMjIuEi/VdXQbbK2p8VmcouoTkWlCP8Aw6BuxwpasU2lmKjU9PB41aU
         eSgyw2jjdGNL2zjwTePVypDjGVl0E2gLm2GwE++4vxNTOOMbDqyisE2pOZ179KfMF0Gb
         aI4VtOO8GTpQ9JAC8RTiLI74T7P1cawWQ/UvGx3VkguXMh5Z3ExeZqhzPidDOmS88Mqh
         yPsfYu0DN0EoQ7vQ72+8xKRSek7VTX+Qqs8ZAB2aWoMFMb5XrEbyrJ8aG1WZVCmNvLiW
         pLZA==
X-Forwarded-Encrypted: i=1; AJvYcCU94x5r5p1RWX4yL9w2VvSbFFM5MT5HS7Q8Qr05EmosPuAg3VNF7DU74pklVkC0zAGm+BO/RNZv/0eDPg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGcco86yQZdnYwCc0nXaIEPkop1VYayu20Te8XOOFHUjO8P8S
	1ylFOAAKBW7YNaKCsBWfVGVy87I+A/ygEz7laCRAFgSVvmia5zd7
X-Gm-Gg: ASbGncvZkh4/sPiSqGJfWVuNMHR46SalBCLh09e2ShIud0YRg3JFHCqAufw38D1dsdS
	OodHRE5UaP6e1MYKwQjAOeQou9zm3roU1Z5hyCQvzHlHnj+RAX6XY7UhTjUWVb0lm34QUbxvN8i
	KaANuAFuoEIdnHeiATnOioUWSHyjUnLcsKH4Q5UBhJiAQD8y3m50jl+drxMRMLQSm0UYInyaHxk
	JO9/TkFaqRD9Slr1p2+mzR0mdfp0Q6z0PvgVjWfezS+Su63CtuNPqdM7gwbrQ+RM0M+U40047p0
	wtI=
X-Google-Smtp-Source: AGHT+IG0uxjNOY1WaQvslsvAfi2E/JLoCk9ATqmKCzDBfOL3OYC0nMtYdty1GF/P1jO4nj7AN9QZSw==
X-Received: by 2002:a05:6a20:a12a:b0:1e6:51d2:c8a3 with SMTP id adf61e73a8af0-1eb21481781mr33004060637.10.1737565587313;
        Wed, 22 Jan 2025 09:06:27 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8f6dsm11091488b3a.114.2025.01.22.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:06:26 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Thu, 23 Jan 2025 01:06:19 +0800
Message-Id: <20250122170620.218533-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 tools/lib/bpf/libbpf.h        | 16 +++++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 36 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..3b6d33578a16 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1680,7 +1680,21 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
  */
 LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
-
+/**
+ * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
+ * use of a given BPF kfunc from specified BPF program type.
+ * @param prog_type BPF program type used to check the support of BPF kfunc
+ * @param kfunc_id The btf ID of BPF kfunc to check support for
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and kfunc is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
+				      int kfunc_id, const void *opts);
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
index 9dfbe7750f56..bc1cf2afbe87 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,42 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
+			   const void *opts)
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
+	insns[0].code = BPF_JMP | BPF_CALL;
+	insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
+	insns[0].imm = kfunc_id;
+
+	/* Now only support kfunc from vmlinux */
+	insns[0].off = 0;
+
+	buf[0] = '\0';
+	err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	if (err < 0)
+		return libbpf_err(err);
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * bpf_cpumask_create is not allowed"
+	 */
+	if (err == 0 && strstr(buf, "not allowed"))
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


