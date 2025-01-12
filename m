Return-Path: <bpf+bounces-48636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78C0A0A75D
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 07:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1563A8A6E
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162D14EC62;
	Sun, 12 Jan 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3v6phMk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96B2581;
	Sun, 12 Jan 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736664335; cv=none; b=Zg+VcQSQs5A2l34ak9PenZHXhCN/Ef72zoiW49Kf8UaA45E1nhp4NmJ+7FOS44GGEBPQ0PcHYwbLGKpQNv2Pn5MbFKjO4zsG82rfJbU8sbFGVX/O3BWrSd91aGVp+QO0pORwdo6ay+P3UTScERZ30r/YIDQJ8C+tnftFqWOk2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736664335; c=relaxed/simple;
	bh=yph9RWVp5+2gMT8lCxwb6Bk0YWFvTgCp/ifMNozXs1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJt1lUTStCWhrIX0LlS/uR/yMTMl3q+oJAoVIDv5rCGHEAufv4sQ93FEAD40WOaFl9u1KveVowuHYRcd+3/xE5h3jNXXxp/KJDWPvUIRwrPCPFjxkxFbfBWaMtmuf8Cujwd6+AnJ42Znb9i4A/1jdqsPVVNtJ4Afa5ag6Y5I6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3v6phMk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb95317so56113895ad.1;
        Sat, 11 Jan 2025 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736664333; x=1737269133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHJiOiyymPmTO+pR9BFdPEH9iK2DFBm9/nkjMVjpj48=;
        b=i3v6phMkLmgChpcTmArcTEKVg1cjIYJp6W6YyNOEa/d7YkOIbZUT/5HPNOSDIRxqUe
         nArXpMDyVII8mg+FQuPqv2821RAZ+U9amODdlkV2cA4DsHp8PJ3ptFOEHiuPdReg8qrr
         kO/ec4cruy2BfXT0uzGAfJUoVbv30s0Q0468dPTkZDaXzD66PxlYS1/n0qOJzTUTaOwK
         +88MaJjp/GrEEPajxffj0gh4czS1wXgP3azhWS/NjVulzjKnep/bYdZDLtjkdMqeqiTz
         Vc8aiPBdxqjlK5Qa5w8e0Ep5hrbvZAO4YTsWBYC686Qf+csjGkzp2vp4Ci9aaqCDFhVh
         PESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736664333; x=1737269133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHJiOiyymPmTO+pR9BFdPEH9iK2DFBm9/nkjMVjpj48=;
        b=PSqbPci5siZtpkdD13xxVgz+oy+FJb1q7N+KpAPsYz6wPSY6K/t9vPgvMATOcAtxmX
         dhAi+gr3CJe+jaVzipK8PY4GGpACkWGiIx4B53ZotRm2ysZA5/t67FAiYXh/P+dkCdZy
         MlZnORyOcjR2CO+RizPQBvavYIYu+xnwR47HgxglRm1fZHwnLaNuG4C1cBRp11va7xj3
         /3ZVSPQZkLEMbEkq47wlDcrupHgufnDU57mcIVFgXIUulDXNzvcCmvO5A6jSqlZmcppN
         dw/+KLvLRyW5SSLlGrMQiZtxNbzuqeiiriNzTBqpH+w181ed6TA4dzIrvKprtYqsEqtn
         DQrA==
X-Forwarded-Encrypted: i=1; AJvYcCW1aigbm89O7VjM+yb3Nq0Cz/Xq9LFhOfk4LxXiU6i4HkHi6THsm6Lgk3UipUg103vEWD4zNO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxofHOjUVi3fbkvxf7FW6ZzBtmeIEW24BtqSZxw38C5+h/z83TJ
	MStBTbPzzfdGAr25mEFzKSw4sHEJHXDWnXjtnpkXg2lGixb3W/+U
X-Gm-Gg: ASbGncsuNRDEILiM/ZTCjVOsSvqE/bGKmzMINp3YHr15DQql9H2YOYSDVT56OhHXT1t
	RkQmq+eUDHYV8iYgh/WMq2L2/NPnMjomRZgTIByWIUTkAgOsh86EOR3HTktRorNfF34Wa97Gnu6
	B4PEpolOrG/Q7eeo0u34Qkh3gAdkPzVj/2kNHhNeElbsL260l3H5EXk+BxiBiKi0bg/Cu0e5J0f
	yFQQjkPQUevjv/GJ2qmjy+QiCmwJjulHS0AJZ901Rs7fWEUL3XScIGT0HB1gEWOUbiVBTCiyDhz
	HYCpDUA=
X-Google-Smtp-Source: AGHT+IG1lANNaN61ZaBr3NfIM4fnRkOGdOCCjstNr+lOM6C264BEFW9sRINYjXTNcJgXHth73N14LQ==
X-Received: by 2002:a05:6a21:3993:b0:1db:e509:c0a8 with SMTP id adf61e73a8af0-1e88cfd3c7emr25137907637.21.1736664332824;
        Sat, 11 Jan 2025 22:45:32 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4059485bsm3791166b3a.83.2025.01.11.22.45.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jan 2025 22:45:32 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	dxu@dxuuu.xyz
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>
Subject: [RFC PATCH v2 1/2] libbpf: Add support for dynamic tracepoint
Date: Sun, 12 Jan 2025 14:45:12 +0800
Message-Id: <20250112064513.883-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250112064513.883-1-laoar.shao@gmail.com>
References: <20250112064513.883-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic tracepoints can be created using debugfs, perf or similar tools.
For example:

  $ perf probe -a 'tcp_listendrop sk'

This command creates a new tracepoint under debugfs:

  $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
  enable  filter  format  hist  id  trigger

Notably, the probed function tcp_listendrop() is an inlined kernel function.

Although this dynamic tracepoint appears as a tracepoint, it is internally
implemented as a kprobe. Therefore, if we want to attach a bpf prog to
it, the bpf prog must be loaded as a kprobe prog.

The primary motivation for adding support for dynamic tracepoints is to
simplify tracing of inlined kernel functions using BPF tools, such as
bpftrace. By leveraging tools like perf, users can create a dynamic
tracepoint for an inlined kernel function and then attach a BPF program to
it.

To achieve this, a new section, SEC("kprobe/SUBSYSTEM/PROBE"), has been
introduced.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..23ea9272491b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11600,11 +11600,34 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	return libbpf_err_ptr(err);
 }
 
+/* A dynamic tracepoint: "kprobe/SUBSYSTEM/PROBE" */
+static int attach_dynamic_tracepoint(const struct bpf_program *prog, const char *func_name,
+				     struct bpf_link **link)
+{
+	char *tp_subsys, *tp_name;
+
+	tp_subsys = strdup(func_name);
+	if (!tp_subsys)
+		return -ENOMEM;
+
+	tp_name = strchr(tp_subsys, '/');
+	if (!tp_name) {
+		free(tp_subsys);
+		return -EINVAL;
+	}
+
+	*tp_name = '\0';
+	tp_name++;
+	*link = bpf_program__attach_tracepoint(prog, tp_subsys, tp_name);
+	free(tp_subsys);
+	return libbpf_get_error(*link);
+}
+
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
+	const char *func_name, *dynamic_tp;
 	unsigned long offset = 0;
-	const char *func_name;
 	char *func;
 	int n;
 
@@ -11620,6 +11643,10 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 	else
 		func_name = prog->sec_name + sizeof("kprobe/") - 1;
 
+	dynamic_tp = strchr(func_name, '/');
+	if (dynamic_tp)
+		return attach_dynamic_tracepoint(prog, func_name, link);
+
 	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
 		pr_warn("kprobe name is invalid: %s\n", func_name);
-- 
2.43.5


