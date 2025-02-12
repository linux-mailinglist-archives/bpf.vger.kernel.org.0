Return-Path: <bpf+bounces-51264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46188A32A00
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2433A799F
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D921480C;
	Wed, 12 Feb 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4SNJdsA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE621420D;
	Wed, 12 Feb 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374113; cv=none; b=F8jrfOOX4jD6/8XlrsqjNF6bsmOuBR6S1ym48/XHwyeAtpwT9zJ2V+uyj0wTLy/c40X4HfaC34yzTjjzpurRate4s2QSO/9IbV0m9WzGkxEz+oWPLpygFmc2L46YWfdO+VLpQT3IVbNCu0amxeiALhfsWAa3JyKfdSwM5I0mDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374113; c=relaxed/simple;
	bh=SAlGx2iFfKFLV+6jqVb8YsK0T0SSuWkKjvfLNn3A74w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kP7aGYlO5TPgzNjX0zvBMjeUaWGHjXdNOnQ1hfbXBO7Bc147C0eGnGlyeOQH7HgelkTH4cIZ/0gm6Kdk5Y1ebZTnWr2kAx/9u6+A+I8vlMw/LjCJ4erQVcxbfkpzWtAHaS64WBC+aqqBRwOObuNBzjmvNfbH2XLSzEdt/Kden1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4SNJdsA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f7f03d856so75724515ad.1;
        Wed, 12 Feb 2025 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374111; x=1739978911; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMwtErlgo9xeVFzj4w9zN8R+1ggkY6ZchTiZDGPxOh8=;
        b=R4SNJdsAGG2h1tdtwxtkyQ5DFCSIJng80DXWzsQFaLZ49LZC83ScCG6dobyJNQhylG
         8VoJ3sWm1BPkilLmBTqM7b9nz2mriuW6zyPy18joxM2Na6mAIBtn5sbYkQBoE+Nyw7G/
         BOWVc49zinO4b+H52mj5MX0zutZPG/dXISDEr7RzitTUvebuWv/3mquuZw0DLYNCUTnK
         FFGx/3m/v8EUYSNXtQU6c/oVEORd6272RfehR9+TXVBVBia2Del9Ntn4bLvGKG0DlcrB
         RyHl/uta/HyimmUYA4rQVNKDlX36DuGyH+1CjUdL9+3MPCFMhje0ZcZgGZ2OVUSboUnp
         ASlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374111; x=1739978911;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMwtErlgo9xeVFzj4w9zN8R+1ggkY6ZchTiZDGPxOh8=;
        b=lMOljty/a5ZaC+cNEIYAo6f2YhUpLvHjiyB3otuRm27COkLgsng6iVdUvQ+ThTOSSP
         zHHxc7/qYtFMFl7mTNon9zeGBSK33s6RuPseJ7qNArRxGnmSvZsDp5bJbw7LqDgyGBj6
         cj3kR63vHe++P1yeDykt8mSvc6/IKtCda7pnQ7PVm7KHrTTUpJ8xk74Pv4vGFTH1Af1w
         u+2I4pKM55g1R62oraAxdEwnmouYKcAJ58/Z/+QGTwNIZ+RNYF0KPlJ5MYfaaavogBT4
         SXCBlzORQDqAaNkFmGgtjgHY1FL96Mt/9la9bj2SAQXhraUTdF/1ewqEa2DhfGu/9ju4
         /pUg==
X-Forwarded-Encrypted: i=1; AJvYcCWs414/dFPyiJvS2ottdehhMAs5OXtcwu2BZjbuq1EL6dJmQvLcQk+e4Chdr6+KrDYMGKUjjIn1jbfv8+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwFtmK+7eic2yXHvmIN+1KrFDCR2/xR3ufSoM/zny0ephxGEt
	zsrrgYIJ+7XqjST2KcoD8UjBjhSe9tm1av/crx0YEKjxrYpGxd0K
X-Gm-Gg: ASbGnctPIOC8Xk2ZoGSt8nuFlyXyus9U3cYsV9aGdmY0pQoehrJOesNEXEbCKiP9T53
	FIUYN0nIE3ODxppNyLjCOaEBcVwdA5VexMlKKfLWHzCtHKds+Ht4FDSHAlSj6Uu8wBLrp2XxNlj
	6qlsvJtYWpJ59rcWeIqDx3fFUOJUXI50QARHOrFZuG8Awm183u922b9To6h+cqY5Z+k0IVgFc1z
	7XxJfVLFBexFEzcm9tWsgKVLs6xUcz5Zd6Z8jxADtaPt+79umkV+55GTII+n7MsQF5O/1j08xLn
	pC/xIw5/1BB2kbIi
X-Google-Smtp-Source: AGHT+IFsWymtupYXq0NtoFvAPPvj/Vr/yPiT5QaMGZWGu4ZnDAZ2KfxfLAWQ7yJTIPbmI72Fp6vNFQ==
X-Received: by 2002:a17:902:e545:b0:215:72aa:693f with SMTP id d9443c01a7336-220bbab37aemr58456405ad.9.1739374111283;
        Wed, 12 Feb 2025 07:28:31 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220cb6aeefasm2792705ad.63.2025.02.12.07.28.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:28:30 -0800 (PST)
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
	chen.dylane@gmail.com,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v7 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Wed, 12 Feb 2025 23:28:15 +0800
Message-Id: <20250212152816.18836-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212152816.18836-1-chen.dylane@gmail.com>
References: <20250212152816.18836-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 19 +++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 48 +++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..c79b4475b956 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1680,7 +1680,24 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
  */
 LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
-
+/**
+ * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
+ * use of a given BPF kfunc from specified BPF program type.
+ * @param prog_type BPF program type used to check the support of BPF kfunc
+ * @param kfunc_id The btf ID of BPF kfunc to check support for
+ * @param btf_fd The module BTF FD, if kfunc is defined in kernel module,
+ * btf_fd is used to point to module's BTF, which is >= 0, and < 0 means kfunc
+ * defined in vmlinux.
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and kfunc is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
+				      int kfunc_id, int btf_fd, const void *opts);
 /**
  * @brief **libbpf_num_possible_cpus()** is a helper function to get the
  * number of possible CPUs that the host kernel supports and expects.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5a838de6f47..3bbfe13aeb6a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		libbpf_probe_bpf_kfunc;
 } LIBBPF_1.5.0;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index de2b1205b436..49e520cc99b4 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
 	return true;
 }
 
+int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
+			   const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, kfunc_id),
+		BPF_EXIT_INSN(),
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	char buf[4096];
+	int fd_array[2] = {-1};
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
+
+	if (btf_fd >= 0)
+		fd_array[1] = btf_fd;
+	else
+		/* insn.off = 0, means vmlinux btf */
+		insns[0].off = 0;
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
+			      buf, sizeof(buf));
+	if (ret < 0)
+		return libbpf_err(ret);
+
+	if (ret > 0)
+		return 1; /* assume supported */
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * <name> is not allowed", if the kfunc id is invalid,
+	 * it will emit "kernel btf_id <id> is not a function". If BTF fd
+	 * invalid in module BTF, it will emit "invalid module BTF fd specified" or
+	 * "negative offset disallowed for kernel module function call"
+	 */
+	if (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
+	   (strstr(buf, "invalid module BTF fd")) ||
+	   (strstr(buf, "negative offset disallowed")))
+		return 0;
+
+	return 1;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
-- 
2.43.0


