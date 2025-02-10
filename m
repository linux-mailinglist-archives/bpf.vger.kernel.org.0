Return-Path: <bpf+bounces-50913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BDA2E3F2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CD2188933F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A31ADC61;
	Mon, 10 Feb 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoWyCVjp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48461B81DC;
	Mon, 10 Feb 2025 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167215; cv=none; b=fnvYzUzIqnpcOYhjzlxemtBNCBcLWLL36o6V9Lv7znEBME4b6IUJgYH90r3zUfDUFWbOp4J6fEYHW06GHZ35amnU2k4IIvSLoOdDu39dBAPWpia6mibzwXD3gzApwv5rd4Q6b1Z2rwU2QYHq46uCnPbIRfLy0kfK5/RoGf736Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167215; c=relaxed/simple;
	bh=BnFHIyOUO6ntZJJVsVyhlGnrRN02+vZLBazfD1fvsBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kpsi4fF2NTYDp8Uh+foAqB0kZf2V1qyaLZ0zB0POWaIeLGLqpZH0nJWgs8/yiOJhOOBGuCY4JalM3HmdsOUW7+dJUSCG/JUhBhMbpeDu7LhLyNldgJCdk4WLq9mDZxHdAZRaVTOymdFO0UaBCK88NYFPhtLqi6pQ3goJIdyja1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoWyCVjp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa286ea7e8so3680499a91.2;
        Sun, 09 Feb 2025 22:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167213; x=1739772013; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vAZG7mXz0xoGUnsfB//6r6I5IhNsMCU9G3zuMwRgHzE=;
        b=BoWyCVjpTcx9KW0CMHhD2s7Mikb9/CuZvfM54NoxzXdrUSU3I8cGLjzsMeFK+kG9/G
         5AIWOS0YAfx7I8yPauteOsBpRae/PwYqODI7MVZJ9O56UQFkKKWXj8CXMX8aVQoljMRF
         YZxtmk3rffphBfCmuSQNn4lm/Spnw8OPRHroEje34cSHnUPPckFa5g4QmfYEXOYbxvcc
         +SXSZ0Ctwm3KJQLCEc+acbbV4MRJ3Sx0o3z8l3F+/f0XGTOZNJzbc7VO8sTeEJgbyMhc
         FxOWdnGTFJuSGGn0ibpucmRV7VMsMuRge607i8D/bk1x01ZQEzBdJtye6TeRH7vGtEKO
         Do7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167213; x=1739772013;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAZG7mXz0xoGUnsfB//6r6I5IhNsMCU9G3zuMwRgHzE=;
        b=QlHpDYHHfrpDH2cOZnORwG/LF3bCqFGeCex0jrefeGz57F921JB/rpGO0b9/5+3eDi
         X+5mbwQSkdCYCJL8t+fkBJ66N8PllZmLVUxUCaKt04ntYO6InmLDLN3OI3oX9zqhCX/z
         dVE/AvFqYoCdgca/7HVdcHTolhsO3mAZ8EUCLn74+HNbFp6LK+T12EZUG6kPbZxsmL9w
         djc9XGMwplSP+vGQTZ/+nLwsSa1iNXj/S51lvxMaK1ClFPfFqVOymEYeFAhSAj7gahpO
         TVTaVZJUYW8zdjWNoc6ryyqvzuSmOtxcnx6dR2niZJN2LgjpsZduJcGifJvv4T0gwpwI
         2sKw==
X-Forwarded-Encrypted: i=1; AJvYcCUdF0Ff2p+bD3w3wq/YfsmrVZ1ElimXC2KkwVSLEoRs8RPYrdi1BFxp0+4m7Y4ny8iD5rkL+Oqo4nL2qEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzohx4/BgCSgcoqRw7TKD77y09WnE2bO0+gYRrLTDstznraDvBt
	QWun9GQbzj9FmL3IMeb3HGIkhd7NTbNez02mNac2w0IXx7emzvKm
X-Gm-Gg: ASbGncsjSIs0ORnIE4PzoguCvGMJ/bU6CjTtzX1LNgkMz7c8409X5re2/C7OrQz6YTQ
	Qh6TWs96zj0byb2LFs7T80iDDC3p9iX3viQ/bEobddIOXz7j1wwdAzG0/NaQjzo4ByeC2oSNGp1
	rsVK5y7Jgq0zXfjiVgDLlnRCXVEQM93LD/VvH1zdwvS3VlUa4HaTk8qi+J4IV2so9m3yFV2+JXF
	L0P2mD5jtFJZyMYa0JxY86LKNek2fXTHd90nsOJu5NepvGUM4DdyKRfWEQ7Rm7ZHfj5Q3hFewav
	0Qcs95THkBVKQows
X-Google-Smtp-Source: AGHT+IEalNiKGA95O3F2bAWtCkK3zLSHDLpfbnPffg/s/JOowSzujHWcEhK7xshUSvjDkrESRihliA==
X-Received: by 2002:a05:6a00:815:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-7305d4508d6mr19266129b3a.7.1739167212690;
        Sun, 09 Feb 2025 22:00:12 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730789aee96sm3209182b3a.96.2025.02.09.22.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2025 22:00:12 -0800 (PST)
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
Subject: [PATCH bpf-next v5 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
Date: Mon, 10 Feb 2025 13:59:44 +0800
Message-Id: <20250210055945.27192-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210055945.27192-1-chen.dylane@gmail.com>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
used to test the availability of the different eBPF kfuncs on the
current system.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.h        | 19 +++++++++++++-
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 48 +++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..e796e38cf255 100644
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
+ * btf_fd is used to point to module's BTF, which is >= 0, and -1 means kfunc
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
index e142130cb83c..53f1196394bf 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -433,6 +433,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
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
+		return -EOPNOTSUPP;
+
+	if (btf_fd >= 0) {
+		fd_array[1] = btf_fd;
+	} else if (btf_fd == -1) {
+		/* insn.off = 0, means vmlinux btf */
+		insns[0].off = 0;
+	} else {
+		return libbpf_err(-EINVAL);
+	}
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
+			      0, buf, sizeof(buf));
+	if (ret < 0)
+		return libbpf_err(ret);
+
+	/* If BPF verifier recognizes BPF kfunc but it's not supported for
+	 * given BPF program type, it will emit "calling kernel function
+	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
+	 * it will emit "kernel btf_id 4294967295 is not a function". If btf fd
+	 * invalid in module btf, it will emit "invalid module BTF fd specified" or
+	 * "negative offset disallowed for kernel module function call"
+	 */
+	if (ret == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
+			(strstr(buf, "invalid module BTF fd")) ||
+			(strstr(buf, "negative offset disallowed"))))
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


