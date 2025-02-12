Return-Path: <bpf+bounces-51269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EDA32A4A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D11188B800
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF4624E4A8;
	Wed, 12 Feb 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAThmvkk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5824C692;
	Wed, 12 Feb 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374768; cv=none; b=HtajungyU2fxSe/COSnysRiLboaZDAlcLOkG3GAJy8veNU2mQYq+nut7IyhyyIwpFL9XeHGIa4EzuJNxG2zM8qMX0EL8ilmnpQtX2J2yGyHj8cV15h1JIOvDYxlMmj0wnKRXdaalNLsvjzgIN6VBVb5GNM8cSvpfZcl05V/rMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374768; c=relaxed/simple;
	bh=dQzH36RcNcQy6t6sYQqwsrQ+lpAk9gQ/KLhqW/Ipw2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CvC15rY+Gr/T/+9Yhqb9mghzdBVfKetpNtdK26ySPkGCTJxB0ju7lmxXrE/JyM/zemGgmI7rER6YYC3ibr3QddqW1UM4xlnGzNUet/6pnCyWRuSvvjJNaMWIzAtNLxQLc8BTbUqn5mNz4hWtmF/TADkqjpFgyotlJL8wapYo/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAThmvkk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f6d2642faso113516185ad.1;
        Wed, 12 Feb 2025 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374766; x=1739979566; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEy5dE7OE7YfdILPn08Fz71Ut4QUxuvJtwXqTxUsqKo=;
        b=dAThmvkkyNsXDdgQhEf8rcHKcnk1vL1BUGekZnIg5rDTvUqdqWQLHGsFlfxcEt7DGO
         V91dyWI9P5AO/9cmDTdDnjn2xIHT7FHgAaMsfPN3Bh1mJIkNCvni01LX281rHpcMv/0T
         PJ5FikqFrogD7hi2TMawt1fDUfazet+DYQetkC07pyqWvkJDvgWdb4XSUewF4p/91BZq
         UbehxncIyN04QA1l6dE7dcfMM3H1fTeOgtm8Ytlm9F4qAo2N/D+Dzd5DJQbNdIylF/9c
         Fb2E3Wj9ruWfoooCr3I4d/t3zwcPfLkFNEuJtzOzHGkoCu3Bxy5fKQFlHPuDtJM89OVA
         Q4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374766; x=1739979566;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEy5dE7OE7YfdILPn08Fz71Ut4QUxuvJtwXqTxUsqKo=;
        b=XRDxlgedAxl+Vtb5zlK9d5zS3AMDYEiXfPPCKsO0jltnk0T0QegNnlmC/dxS2EOMvb
         8QmSjs5S0Y5AY7lWNSjVZJwkoYr7AzMrs184LruNWeH3kfS9FdQ6ZGjW0MAYN4mvN18J
         xdnPWPVbzBFFE5b0mjR6mpTuueBwpyXgiO7EQICOUqmX6uvIxKyeIiGxVkMa1sBTt9tK
         IWmZO+yzH7cWdkevYS2DzqVDth0GAmJYCGQIpnEwaasCLY9Yv76vT6K/Yj1Syrf9oNw2
         Uzpn7X3r+RMlNdDqcVnE3n6Y4DLpRKvB7e6CZQ+9+wMv6QbfT+b81EzThaSt/THsvHZA
         iASg==
X-Forwarded-Encrypted: i=1; AJvYcCVij83i8vHiicgL8zdJRHnMjdSYpHOZSRuGekV74Awo+XFp1siNYt6ODdsWYJ9QzNbJXSFTDc4UGHU82dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2ytpXTmntygz0oYbUVAzQQpGkIfOEFC9q4BBPXIcZuVz/Biz
	WKyoUn6TDgzAqGnv/U2IfDwjf60yt77CS50DE4P3Wehnjyc58/MJ
X-Gm-Gg: ASbGncu7MThDfJjo93gfEghH4yd7dVcXO6cLRyaH72xInsIhz/QOLMh9BuCy27Gqouw
	uw7KpUmmpyeLx26EVXOODP65/PyX4Jx3X+RRPeOrYkOlY/mXexrPYR8zOg0ovOWbLtLBu9QY266
	aiudhOoynIzcWZTUPLGVK9M0CMGawESuMW7t6lgzTUTVchCgJ349tVPZ7qCezUUvYhGYl9CqIKw
	/zVc36dhWSk2To0n4iCG4JcG3C2MjCVBscPC2g257rfxO4+t35Tqv31FziVQDZnnS3LgEKs6P7Y
	GjXEc4tLC6ehat2l
X-Google-Smtp-Source: AGHT+IFfXAEQqDmrijYWUgRIZWDOeWCec+WCAvgWHNMxVf8WZpzwcMRU2iSYBbpJRAgnyi5R1CqFnQ==
X-Received: by 2002:a05:6a00:807:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7322c37418bmr5314835b3a.4.1739374766381;
        Wed, 12 Feb 2025 07:39:26 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730759e007csm7911882b3a.42.2025.02.12.07.39.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2025 07:39:26 -0800 (PST)
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
Date: Wed, 12 Feb 2025 23:39:11 +0800
Message-Id: <20250212153912.24116-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212153912.24116-1-chen.dylane@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
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
index de2b1205b436..74928e26b5b9 100644
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
+	   strstr(buf, "invalid module BTF fd") ||
+	   strstr(buf, "negative offset disallowed"))
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


