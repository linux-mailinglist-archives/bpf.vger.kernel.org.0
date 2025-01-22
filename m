Return-Path: <bpf+bounces-49496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6D2A19741
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F0D7A480E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349821517C;
	Wed, 22 Jan 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gphGXp5l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B941BEF79;
	Wed, 22 Jan 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566052; cv=none; b=qLFIKRpVLuQoFF23nluK+MhVY3iHj+JjAu15hT2OFoDhPxTK/UWkv0I5jgzgqpeUTmbrjvngD1AeudBqUAMZuAHFYwv6dIEmRnfV6hrc6WK8oZ/1Z6L7JTMdt1J4+0/cQ6dbo/AdyRBlCa49t11jkD7go+xEApA2Pkrp3/jwQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566052; c=relaxed/simple;
	bh=b8TR2iiU2iZKAKFmGJOHWvB4sosonYGhQTkdWiUS54o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRVbRXiZWXUlYuFFrRhFVQqIeTTGNVcm2uuhhiTSxqLmGSPp2uxSTaX/SrPL0oHKNJnlrps03eflukOZBnb3vrsBOrxunlWcE+4q4eoca7iYBvnxnbZpCf2t7Qbegk8qGpfUusp+lkR8bXdXfNb8S6oBLF7MLt8wOcN5pI2rjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gphGXp5l; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso46082a91.2;
        Wed, 22 Jan 2025 09:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566050; x=1738170850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yndnz8ctYn+NfVrDvN1e55mXp5ZR9QmhfeAPAHYP5kg=;
        b=gphGXp5lMuBlczs0//lUURv/5r61+dKSue9fv+gutBhQ8p9M7pe0C+mHK39UPUxvDA
         HwB0JswRJrhc0ayvCNAsLIynXOarKO4Yvip+c0Rx3OOxgwS8wksYhSH7lnN7p9Mc4a0n
         OR7/GixXCf6dz7IyU+U1uHEQvTswWrAMpFP3NzWrdVmnwdywZkxjHTDM290i5wJ3xIMv
         ueSRz6ehc2NVrQZp9eaTgDHQ+MKePGdcLSPAmjIfufy+sygJPKO5mIaAcPHCKn82mEBp
         XXEewn6dI7+vlVafw5P3T1cfLwk4aR+dSODtf9dY82E+roWMaR1/oALxafQMbpTWpUeo
         c7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566050; x=1738170850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yndnz8ctYn+NfVrDvN1e55mXp5ZR9QmhfeAPAHYP5kg=;
        b=sXobu0mn77ZF1tnkLojrDO+zbXnjWIkldrDBKcHPps+VEMgaVuEDo6KXzMngmT785y
         7g5TO3wc0i2s5ddAkuXf72lhELMiyovRd8sOjk6NMobVHe+JP8u2VE8Th+C/4moHoIG5
         pEsEWo7rty2gFJl2KtJ6+mGKHCTwFaBnoQnS3LL8CWQLnSZy9v3h5u8SZGa7+6jax31x
         +AqldhPVc8OzWVqhCFTUwwcXKGN9PDUnH2Le80g7fMvWESWbu8vFy0q4LKsWVUMKC7PZ
         ArRJk5hmOmDGWbLtDhWYm66sySFrE/LTq5sKZR33wClp428fiy8Z7ZvepvPgY2Fd4m9J
         uEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS90+zRIooe4RkFHxR1SRBu7P2ceBUnTMepWpTag5uhMeHhBWRP0kIcDIMGF+aCbcJaLyxfV/TWqhawvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bR7lzQ0lemzh8fqRRsEJJSIZhIc1CZnsDQ5CIRXhsAkkt/3N
	NJ3/xdFmCxOuccKUxqsTAH/kManBH8AM8fFklsSf5rYAU++oNOa4
X-Gm-Gg: ASbGncsb9sVMZ8+6vyW0z+fIrSe9/Q+Ij9RJvFcO+loOYDPJoO8ONSdYvhRSsTwRPx3
	aiN4O/l2wlAFiMNh36TMtb5aHtQ6iu4BMwdeNMK6k4NYXEdTAu2Ulsl+QY631WvKPg5PKXi4ZyW
	GVIsLgfDo7bu6EWURpdlDF0VGaWZILyF0+JMjapd1SYgd++vNZalBnCC9w5WJwAa+NH6uvJ1+zW
	KXkvpkISCSXW3LUX+50uKNZx+fBYvq6ufscg4Zp2JWBHEuLUGMtyAXciZkgeJ0zZQ9Sv/K8gmDu
	3k0=
X-Google-Smtp-Source: AGHT+IH1e832M+vGusmvLzd24ErF6eGDo1FaBj5SSWHBTWE/n7rdibbv+9eSSO09N2kcIgiPEg+Tdg==
X-Received: by 2002:a05:6a00:4616:b0:72a:bb83:7804 with SMTP id d2e1a72fcca58-72dafb9d647mr25141681b3a.17.1737566050251;
        Wed, 22 Jan 2025 09:14:10 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f06c3sm11155600b3a.20.2025.01.22.09.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:14:09 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Thu, 23 Jan 2025 01:13:58 +0800
Message-Id: <20250122171359.232791-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122171359.232791-1-chen.dylane@gmail.com>
References: <20250122171359.232791-1-chen.dylane@gmail.com>
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


