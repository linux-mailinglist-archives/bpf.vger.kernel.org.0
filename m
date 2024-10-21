Return-Path: <bpf+bounces-42644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6139A6BE1
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4250D1F213F4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375841F471B;
	Mon, 21 Oct 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1HaB0/3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6F17BA5
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520197; cv=none; b=sXRhEO7E2WpAozVUflXruksMtCzjQ51rvFl++L5MvM4lw63fsQohTUV4U+prBBdpYwxJ537pNhqGxEApCTt3AWbLBwnuimuXfd9Fk85sOatm/8xqVj11PSGcZOvz06gNlpml4VY11GmNhplripXUHKtCHdPa0wIWTiWUbnIVkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520197; c=relaxed/simple;
	bh=DzXspKrC9vdnkpkCmxgvo28kuk2aLbBseLKyJweLQr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OunZlmnPBjVvysH0Cargy+yg+orQOxliAOEL9uAKwvCqXE+e/X8p1mfNJamuK6kKKrFMTpOkN1m6pj4LOaqJfO1AUT4SL2ilqua+JpNCWAH/QWUs4eym5mskyXV00Tj/QXSvoat00EKJZGLon5BRhootmEaqYodpHukYTHeTmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1HaB0/3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f7606199so4963537e87.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729520194; x=1730124994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mG9C20PzkMJ1pAXdc8llOp8aT2sDqOYUNUx/YjdLjL8=;
        b=K1HaB0/3cKOvsOv9FZO+rtmBej5+nDxHhDo+/wjtfuqfKVrBt6P4UQhlnxcDGngJEK
         GaB6Hulj1IL7rNYo00Dw7kZ49Hvjxe8Bqxclivr1N98plSXBitAJsIDYe7ilsPSmgYoi
         87xluZFMec+jPyVtV69TW9P0uK1n1s7N+En21YyjOb50tTs3C16byZebsMem4c64iovK
         hm+MkawUz9J+8Nq2adzHPAQNH4DHJ6ChZHbtRPrhjMPgQeY0QKzL+nVXyd0Qcefi9H/Q
         cJIUurahn8Iw9RsaVinXS5I6jon1z8nLLA14T6iZMbPDii6eKDblQKH73bgTxWTzJu+X
         5RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520194; x=1730124994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG9C20PzkMJ1pAXdc8llOp8aT2sDqOYUNUx/YjdLjL8=;
        b=oWwOhJzjDlWykX4+hM4Ob0VGGtU5FmtbvPFZJjzH3/Jm8XFTUc85+Aso1c825phjBF
         mDjBcGXSTHhyXGRmks5EItl8bDFkllpcp8TevWVC37VyTGjTLa4MpOWbJDv4xI1/EKea
         kObKWm7zMxjSmKfBs6YbjOlrgNNZ9SdWVwKYa45jXGzVBkVhYCTVwe/+2Ow36oaCg5rd
         wFZ7c95siEgmK4a+8don3j+G+x1fdXET0uvnYr0GK9sobZpz31pd2UnsVo8k1/Nzu+uB
         UUfrUWhUXLUa9jq2al9KRHJzH4fUZlx89nNFWyF05L1siwBDTEZeR6tgE5GW4Byrly7l
         Pqpw==
X-Gm-Message-State: AOJu0YyoDDkPSVBo0oktR430eecU14RJWHkBPvpTMeh5dsmBX4PvtbZc
	ycGsOY4tAQ/Q7cbaIJnApDm4artP93x1+atr+vrOrkZV0VHKkmhU7DVVvw==
X-Google-Smtp-Source: AGHT+IGB9QvDNNFYzDDDMMrkvnwhxvDpvgbG5ekfiPgm8otgZjzYmn/iAXK/2grJk6JMvZEBFmSqmQ==
X-Received: by 2002:a05:6512:318b:b0:539:fb7f:6288 with SMTP id 2adb3069b0e04-53b12c0bde6mr42673e87.35.1729520193479;
        Mon, 21 Oct 2024 07:16:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:a302:ae00:2a0:8923:a788:9a73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f661esm206955166b.83.2024.10.21.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:16:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: increase verifier log limit in veristat
Date: Mon, 21 Oct 2024 15:16:16 +0100
Message-ID: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c8efd44590d9..1d0708839f4b 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -16,10 +16,12 @@
 #include <sys/stat.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <bpf/bpf.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <float.h>
 #include <math.h>
+#include <linux/filter.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -1109,6 +1111,42 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 	return;
 }
 
+static int max_verifier_log_size(void)
+{
+	const int big_log_size = UINT_MAX >> 2;
+	const int small_log_size = UINT_MAX >> 8;
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, insn_cnt = ARRAY_SIZE(insns);
+	char *log_buf;
+	static int log_size;
+
+	if (log_size != 0)
+		return log_size;
+
+	log_size = small_log_size;
+	log_buf = malloc(big_log_size);
+
+	if (!log_buf)
+		return log_size;
+
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .log_buf = log_buf,
+		    .log_size = big_log_size,
+		    .log_level = 2
+	);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
+	free(log_buf);
+
+	if (ret > 0) {
+		log_size = big_log_size;
+		close(ret);
+	}
+	return log_size;
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1132,7 +1170,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	memset(stats, 0, sizeof(*stats));
 
 	if (env.verbose || env.top_src_lines > 0) {
-		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
+		buf_sz = env.log_size ? env.log_size : max_verifier_log_size();
 		buf = malloc(buf_sz);
 		if (!buf)
 			return -ENOMEM;
-- 
2.47.0


