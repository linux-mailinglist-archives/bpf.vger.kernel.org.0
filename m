Return-Path: <bpf+bounces-62490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F4AFB275
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDF41AA2F65
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EA29A9CD;
	Mon,  7 Jul 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0JtoiJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFF299A85;
	Mon,  7 Jul 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888451; cv=none; b=jIjBMl/tO4Z0M3w6XLlg19yaDG+6G2/RFqW8Hic5N0tlS6CSsnHeLZ4vY2RfTmmOhGHAFQC+qq0vMYn8jso0dUhtJc1vfHPxFhtkTK5/BXgRbkwRuBWgflYHEVj3O6iYCCa5q038WAcK3ULn2Xjk+dP93bAHJaAA+tByGm+0abQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888451; c=relaxed/simple;
	bh=TBB5VKm8Ip2OBXmBLCzsvp4tYv+QIET8QncFz4GIo4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTAOvd+IgDz31awHMr2yrHdYK5NOcrkPn3lsElBkLaZDlaOK13elJ6n33eCJNjPWhlh3vZbCLu/z5CD31PZCCgSOeVWeYj3gBUib0URwc6H25riO+3La5C5MlW9W2j4YvHHeT+2Gd0RBkxTIY8gsxhpn5A33pdXQMfIQ/gnmEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0JtoiJd; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1728258b3a.1;
        Mon, 07 Jul 2025 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751888449; x=1752493249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6N2lwFDeBxpdj+xu2gSGUcRobXnUkCGs6+LBZY90J9E=;
        b=Q0JtoiJd0lJngrySzUL65qINyf4ydtpuMnWzjMpsiWeoAunVNKVjnSMADLyRM10iXQ
         f2+cEWkudHq/or384C03X65zf/UpCOjFZfina3VON12nNAigivd8Kp06AOK5B8XSwu8/
         vUlP1DwHwYs87ias5bwbC1uSWHAOuE5+23dLPFAg5qAQt1TPR9yB73a8+27/SqtUbZKM
         38GjULi558dDkxbQY7pHwM6UWq5LT+wh+eOf4HhS+ovQXyzMnA926fJH2z8VkWnyIxaq
         g0u8+JSkSWDRDWG1JARq0CTxWHckhbdZFJAKjzNd304nTgOL1L11POf2AOatU7J2S363
         0JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751888449; x=1752493249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N2lwFDeBxpdj+xu2gSGUcRobXnUkCGs6+LBZY90J9E=;
        b=AYm0d/xTm6nA2JwoTQMhsHXcQwDLivo8XZ7FRwvTanhroplaRnaENCiBwsmEBrmIQD
         pkxwYfoOq9XOoiD67IknopXdM4MdXDlzT6ThE6w8mAOYIGrKWd1xM3Zei1g9JThwi022
         d1sh9l/eYmdot+87nTaCxJ+Z9jENCoZn2Ai+vghPn0aFdKQ5T9WO5S1QUQzKBotxhm4D
         gwzAPhYV8ZqMBr3xTlb6954jPTB4hXDJ+0z6hyZuk6XHSKgtX6UzwwtYTsj47lwcLQen
         +OwY2SuYAf1eb0UFVYOxMqQsSNPm5C4l0lhthPo2UT+BYOSf+mZRwPTPbhHw/FZEKsM4
         LHfw==
X-Forwarded-Encrypted: i=1; AJvYcCW155L1R2WhS1U3SA5hGwziXTa4GkH8cNa/js7SLm6OKS1vsBgX95zG1uEdqkqWqCbi+tggkVfehaML4Lub@vger.kernel.org, AJvYcCWizKwXdbsmg3FrBjf+SDASdNIVI4zBqpgeObyOgFPMniNraFttAumrtNyr+Ox/P9h7Ais=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUp9nPvSR6/ZvvTt6FvkCrXGwjfLQ1wmCpjgZSNU+2wM6qQ2lU
	nhfREuRY1WWfk4bEObUggVYIrblc+EA8MEkBqq9wSiCgH5Wx9cym4Vki
X-Gm-Gg: ASbGncvjZ6JZs+22KFHPGMw2NgMBkxUWSB2s0ERbxROc6yj1wugqCHnkE1wolWnG3R+
	EbJOmp4s55L8ZcXSmxM7sUjPqWY40+VThQvKOKdswr41ggZahWcIVdLm6CF6jViucpe9FvYXNSP
	gNNRR7D3TukHIVnrtbcPSO8WTIk4xPaVXV14QBOueLd/YufH8XsUwYPWEmV+c38cR7wNfk6NPce
	8jqMzVcqO6dG0PNSUY8tsxfryNvQJvmKKkf7pS3rtggx93IqIMil1VvnJm3MjZ+LlZFe6SBVzoV
	t6QsSwOvRd6zFYt6Qkvae3ORJbm3RjwI5GauVs8BcspdxsqC8M+oanaAsQ29Mq+C5egPCd9kBq7
	RwXI=
X-Google-Smtp-Source: AGHT+IG2205mR589RM3rlU4Ix7jntnifujjs2m6SK4wtKGTVyIiDeqwIh0ptTSeUNUU9kn3mPfuzCA==
X-Received: by 2002:a05:6a00:140f:b0:742:aecc:c46b with SMTP id d2e1a72fcca58-74cf6fb8582mr11492344b3a.15.1751888448644;
        Mon, 07 Jul 2025 04:40:48 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cdaaasm8793211b3a.61.2025.07.07.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 04:40:48 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next] bpf: make the attach target more accurate
Date: Mon,  7 Jul 2025 19:35:28 +0800
Message-Id: <20250707113528.378303-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we lookup the address of the attach target in
bpf_check_attach_target() with find_kallsyms_symbol_value or
kallsyms_lookup_name, which is not accurate in some cases.

For example, we want to attach to the target "t_next", but there are
multiple symbols with the name "t_next" exist in the kallsyms. The one
that kallsyms_lookup_name() returned may have no ftrace record, which
makes the attach target not available. So we want the one that has ftrace
record to be returned.

Meanwhile, there may be multiple symbols with the name "t_next" in ftrace
record. In this case, the attach target is ambiguous, so the attach should
fail.

Introduce the function bpf_lookup_attach_addr() to do the address lookup,
which is able to solve this problem.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c | 76 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f6cc2275695..9a7128da6d13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23436,6 +23436,72 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+struct symbol_lookup_ctx {
+	const char *name;
+	unsigned long addr;
+};
+
+static int symbol_callback(void *data, unsigned long addr)
+{
+	struct symbol_lookup_ctx *ctx = data;
+
+	if (!ftrace_location(addr))
+		return 0;
+
+	if (ctx->addr)
+		return -EADDRNOTAVAIL;
+
+	ctx->addr = addr;
+
+	return 0;
+}
+
+static int symbol_mod_callback(void *data, const char *name, unsigned long addr)
+{
+	if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) != 0)
+		return 0;
+
+	return symbol_callback(data, addr);
+}
+
+/**
+ * bpf_lookup_attach_addr: Lookup address for a symbol
+ *
+ * @mod: kernel module to lookup the symbol, NULL means to lookup the kernel
+ * symbols
+ * @sym: the symbol to resolve
+ * @addr: pointer to store the result
+ *
+ * Lookup the address of the symbol @sym, and the address should has
+ * corresponding ftrace location. If multiple symbols with the name @sym
+ * exist, the one that has ftrace location will be returned. If more than
+ * 1 has ftrace location, -EADDRNOTAVAIL will be returned.
+ *
+ * Returns: 0 on success, -errno otherwise.
+ */
+static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
+				  unsigned long *addr)
+{
+	struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
+	int err;
+
+	if (!mod)
+		err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);
+	else
+		err = module_kallsyms_on_each_symbol(mod->name, symbol_mod_callback,
+						     &ctx);
+
+	if (!ctx.addr)
+		return -ENOENT;
+
+	if (err)
+		return err;
+
+	*addr = ctx.addr;
+
+	return 0;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -23689,18 +23755,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
 				if (mod)
-					addr = find_kallsyms_symbol_value(mod, tname);
+					ret = bpf_lookup_attach_addr(mod, tname, &addr);
 				else
-					addr = 0;
+					ret = -ENOENT;
 			} else {
-				addr = kallsyms_lookup_name(tname);
+				ret = bpf_lookup_attach_addr(NULL, tname, &addr);
 			}
-			if (!addr) {
+			if (ret) {
 				module_put(mod);
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
 					tname);
-				return -ENOENT;
+				return ret;
 			}
 		}
 
-- 
2.39.5


