Return-Path: <bpf+bounces-42913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195D9ACF7B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50C61F255C2
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AE01ADFF7;
	Wed, 23 Oct 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPPMeehX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59509136E21
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698804; cv=none; b=XZFg1T0kYbqbjNTj0IRvGnJpVBo+v+n7NhkbD8T5fkbaIiYtWzT9/vmfCRHWSlFo8afWHGxOzreXUzJKElDYACa8PVaj2oKzErktWRMpSGNLIHZFYW1Xv+d6wxqbYdXT524b26UckzAytnhPSRxILRN0R68z177ziUu/VJRphBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698804; c=relaxed/simple;
	bh=7Je0PaLrR+PFsqT7fk3yT/3riIdOpoOur062BMhy/YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wr11lT4EEAHlDMM4ibVHHaXdAiAMT/FUCNsp6GrEEeMCg2JdVuL1n0EBJBRaNlDNCaI8C9yF7sY7TsXX8U09OyK9E4/0Ip+NCdxExrtjdfj5teBoDRaKY9heIESf5UVdIguzEVotNAcGwb52lEJBpGqMpXn8p9ESHtZ0VYvTKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPPMeehX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so69981335e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729698801; x=1730303601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xg6vG0+Cs4aSqZryuQzFbJBWKXZFot9wr/2C17Wp6G0=;
        b=hPPMeehXWZwfILRp4gBaSh0Qxl2k1eGBnCrhWFol5LHFmaEUttT4bcuSWPKUFkLLyp
         w8WQ8EjCV2lYosMHtzqtcD7LdD5dbGH/U6WTx+PqaaUALUNgONnBZtVyr9EH/gd/lbpe
         NXQWcy7FqE2Inwp3CcgU/kff6UAG8lCrQlES93Jp/PtDwKjjpDZpUJDXROMiYydkmYH/
         k+9qSRnIGxrI9jAQCcWV2emjaFY2ILkExz/wouUwrc67QxCQ3p80FNBGl9afQVa1TOTJ
         wY/tkBNSx1lxTG+iCmL1zkTMEOp1F8vfcz0WVHHNvnxVx1ECinjvlwA2Xe3SyktkJSsY
         4aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698801; x=1730303601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg6vG0+Cs4aSqZryuQzFbJBWKXZFot9wr/2C17Wp6G0=;
        b=DtkE7qHykX1FJ/YfAtyHaRlWyF4Fh9KS5RwkJc01hq1TdY398xO+HU7zvkXlQyx1VV
         T9AeDsvxLF3bwKGcrOmIRjQ/9EXNguTXOmfcRDW35kzo/F9PrQWDLCPZ8VHE1BnqWjdx
         g6mGCAcgu92Xc6GjvhmEu2IlvuDTKEOz1G8MCy/lzLHYOGodYU/ciyOcgaNINrazlILT
         5lHBsxFpgeKddmSaNaNrOX/KxXz8zYvs+34JH6FDvndchLuJGopsVMpIhY6C568EvYdd
         NrIgLO7p+ZiMeZeZYUFiW5fG2hr4tCZecn0pM19UO9bSPKAkX2hNVnkZhtgmZg6h4E1x
         sYYw==
X-Gm-Message-State: AOJu0Ywa5V563znW5yZy/cEESsLzvdC5KlpJyng8VWnLyq7UgqdbTUXx
	AddWt5Z4RRgfIyBBmspW9D1wOUD8Arj3xZ/MNxYLPcC42E+Des5NPZivlw==
X-Google-Smtp-Source: AGHT+IEuwVwD/wboJAqhWKTqKeF8H4TvLlmFA6ILM4ybnBygMuPdf5NH4VjqE6VVTeJqiDrFpn9Qtw==
X-Received: by 2002:a05:600c:190b:b0:431:5632:448b with SMTP id 5b1f17b1804b1-4318419a81bmr25387665e9.25.1729698800181;
        Wed, 23 Oct 2024 08:53:20 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317dde46a3sm37734305e9.1.2024.10.23.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:53:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: increase verifier log limit in veristat
Date: Wed, 23 Oct 2024 16:53:14 +0100
Message-ID: <20241023155314.126255-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

The current default buffer size of 16MB allocated by veristat is no
longer sufficient to hold the verifier logs of some production BPF
programs. To address this issue, we need to increase the verifier log
limit.
Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
increased the supported buffer size by the kernel, but veristat users
need to explicitly pass a log size argument to use the bigger log.

This patch adds a function to detect the maximum verifier log size
supported by the kernel and uses that by default in veristat.
This ensures that veristat can handle larger verifier logs without
requiring users to manually specify the log size.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 42 +++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c8efd44590d9..a8498b1a2898 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -16,6 +16,7 @@
 #include <sys/stat.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <bpf/bpf.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <float.h>
@@ -1109,6 +1110,45 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 	return;
 }
 
+static int max_verifier_log_size(void)
+{
+	const int SMALL_LOG_SIZE = UINT_MAX >> 8;
+	const int BIG_LOG_SIZE = UINT_MAX >> 2;
+	struct bpf_insn insns[] = {
+		{
+		.code  = BPF_ALU | BPF_MOV | BPF_X,
+		.dst_reg = BPF_REG_0,
+		.src_reg = 0,
+		.off   = 0,
+		.imm   = 0 },
+		{
+		.code  = BPF_JMP | BPF_EXIT,
+		.dst_reg = 0,
+		.src_reg = 0,
+		.off   = 0,
+		.imm   = 0 },
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .log_size = BIG_LOG_SIZE,
+		    .log_buf = (void *)-1,
+		    .log_level = 4
+	);
+	int ret, insn_cnt = ARRAY_SIZE(insns);
+	static int log_size;
+
+	if (log_size != 0)
+		return log_size;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+
+	if (ret == -EFAULT)
+		log_size = BIG_LOG_SIZE;
+	else /* ret == -EINVAL, big log size is not supported by the verifier */
+		log_size = SMALL_LOG_SIZE;
+
+	return log_size;
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1132,7 +1172,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	memset(stats, 0, sizeof(*stats));
 
 	if (env.verbose || env.top_src_lines > 0) {
-		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
+		buf_sz = env.log_size ? env.log_size : max_verifier_log_size();
 		buf = malloc(buf_sz);
 		if (!buf)
 			return -ENOMEM;
-- 
2.47.0


