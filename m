Return-Path: <bpf+bounces-29971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E949B8C8C90
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE1284433
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DF13E417;
	Fri, 17 May 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfjVjc2g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFC13E3E6
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972771; cv=none; b=qv+HUsaHF8pggkcNPjdOtJCJoVa/ZCNTq31qS9S9t2FWntD85G2xMY9gWiLNKYpuWu7oh8ZmiwUsLq7OY7l9Fgk5l+BKzvervbxLKpYV7YcTXy0q3EgzQJrK7DNu5rMKRmsj3ijVQEUlERiO8K7kEPFnKTKmOyrJygX8slM90/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972771; c=relaxed/simple;
	bh=ZioFnZ3d1Vg35xANGhPTZ32CY+yYa1owDklEmy5rVm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkh1BLx9fhTYkwCyC19qlOZJPVdp/68tAMnto3OjTBMLa6G7teULYbyweiQ1rIBWMcp7zoBCARnMQdTVv24orFHTtXge3W6PRXCFLiTthy6hg6SM0qv9R64ziSPD8WaX4oPGi78Pi1l/j+32K4S64SCg6v8flaTfo6d08VAhCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfjVjc2g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ed835f3c3cso20318635ad.3
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715972769; x=1716577569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYh5uMJCF1r0KBlzHzNOaPta0GxxeMYUw422sU1IaAI=;
        b=WfjVjc2gGa4CtxH2Rdbv0s6QHfy/O7hOzZCFnDiz3DEoxbSgdzMog2cO8kMOX34nom
         CbNZnfne5r+ZlH3LUNsGHQoG9TGlYBTf1h7t6LbQ/Tu2uGCugfhIG5vnhh/RrzX4tR0e
         VR6ESYUzLhBGKu3gaJODD2MEzgfofNnHu6sMfQiEStxDDf2Oa46WH6nnZITYJlahrDJX
         HQW1SK5QMOBKRh/hQMxS/mkol6VAhe2BsnrbTveyekKOPJCh6xcGiiPgmgKZ8Rof2s0w
         unKsjc1yP1H3G6lP2751wXnhZ3LtoZPus9+CTr7o176hrMowrjjOiCBKPxw6iNtFGIWp
         uhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715972769; x=1716577569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYh5uMJCF1r0KBlzHzNOaPta0GxxeMYUw422sU1IaAI=;
        b=Vf/YA7Eogfzp8o2l0iab8QfPpHGbDki2Iy2HiAGj34gDFXhMAq/scwtkAdP45IQ3+b
         6YNfJVjqbg3GqLFkJc8y1ggIv9VechRdrqQLbDmzca+fPiJd22NFQe9TpXPEG1DB2ih/
         cMXTQtL3R/lz11T20mtXfo4K3GoP5tLhYBiZjpoiT+yXRqH4APCswiR+LYbZwd9w+Skv
         R+3HCfuT1eicnJ3OGf3G4BTo1Sav/+kCHqd5b4tmBTL5Rl6tgcHCrooo9vf+yxPtcuJK
         9J1ptWuwqfR+6BX/BouBASL3J8HqjSniXGg5+j9K+Zz+L+S5PecuUUz9itB9svgJV8u8
         7fDQ==
X-Gm-Message-State: AOJu0YyyeckH1nqbmYaoeP9CyLjilfr/C1ky7X2WwGLDlh8ei5CcA8cN
	aeCuCsnTHlA6ffzKHwNHdP4WvtUbtC709qVLc6sL7Y5KSqTnPpdnldXE1A==
X-Google-Smtp-Source: AGHT+IGykXHx9HX0S8BVJLL7/281g2RzA7QR39GlnQwPp2clhYCO4W6rIq9LGPQmysIYIq70ijKeTg==
X-Received: by 2002:a17:90b:3a8c:b0:2b3:2a3b:dd0f with SMTP id 98e67ed59e1d1-2b6cc14b8b5mr23311286a91.8.1715972769301;
        Fri, 17 May 2024 12:06:09 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b9ddbcf05csm5459747a91.45.2024.05.17.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:06:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: tests for btf_dump emit queue API
Date: Fri, 17 May 2024 12:05:54 -0700
Message-Id: <20240517190555.4032078-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517190555.4032078-1-eddyz87@gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test cases for btf_dump__dump_one_type() and company:
- peek a type, save it's dependencies to the emit queue,
  print the content of the emit queue, expect only relevant
  dependencies;
- print a forward declaration for a single type,
  expect no dependencies in the output;
- print a full dependencies for a type,
  expect no dependencies in the output.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index e9ea38aa8248..04f32472e221 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -255,6 +255,90 @@ static void test_btf_dump_incremental(void)
 	btf__free(btf);
 }
 
+static void test_btf_dump_emit_queue(void)
+{
+	struct btf_dump_emit_queue_item *items;
+	struct btf_dump *d = NULL;
+	struct btf *btf = NULL;
+	u32 union_simple;
+	int err, i, cnt;
+
+	btf = btf__parse_elf("btf_dump_test_case_syntax.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse_elf")) {
+		err = -PTR_ERR(btf);
+		btf = NULL;
+		goto err_out;
+	}
+
+	union_simple = btf__find_by_name_kind(btf, "union_simple", BTF_KIND_UNION);
+	ASSERT_GT(union_simple, 0, "'union_simple' id");
+
+	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
+	if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
+		return;
+	d = btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
+	if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new"))
+		goto err_out;
+
+	err = btf_dump__order_type(d, union_simple);
+	ASSERT_OK(err, "order type 'union_simple'");
+	cnt = btf_dump__emit_queue_cnt(d);
+	items = btf_dump__emit_queue(d);
+	for (i = 1; i < cnt; i++) {
+		err = btf_dump__dump_one_type(d, items[i].id, items[i].fwd);
+		if (err > 0)
+			fprintf(dump_buf_file, ";\n\n");
+	}
+
+	fflush(dump_buf_file);
+	dump_buf[dump_buf_sz] = 0;
+
+	ASSERT_STREQ(dump_buf,
+"union union_empty {};\n"
+"\n"
+"union union_simple {\n"
+"	void *ptr;\n"
+"	int num;\n"
+"	int_t num2;\n"
+"	union union_empty u;\n"
+"};\n\n", "c_dump1");
+
+	btf_dump__free(d);
+	d = btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
+	if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new")) {
+		d = NULL;
+		goto err_out;
+	}
+	err = btf_dump__order_type(d, union_simple);
+	ASSERT_OK(err, "order type 'union_simple'");
+
+	rewind(dump_buf_file);
+	btf_dump__dump_one_type(d, union_simple, true);
+	fflush(dump_buf_file);
+	dump_buf[dump_buf_sz] = 0;
+
+	ASSERT_STREQ(dump_buf, "union union_simple", "c_dump2");
+
+	rewind(dump_buf_file);
+	btf_dump__dump_one_type(d, union_simple, false);
+	fflush(dump_buf_file);
+	dump_buf[dump_buf_sz] = 0;
+
+	ASSERT_STREQ(dump_buf,
+"union union_simple {\n"
+"	void *ptr;\n"
+"	int num;\n"
+"	int_t num2;\n"
+"	union union_empty u;\n"
+"}", "c_dump3");
+
+err_out:
+	fclose(dump_buf_file);
+	free(dump_buf);
+	btf_dump__free(d);
+	btf__free(btf);
+}
+
 #define STRSIZE				4096
 
 static void btf_dump_snprintf(void *ctx, const char *fmt, va_list args)
@@ -873,6 +957,8 @@ void test_btf_dump() {
 	}
 	if (test__start_subtest("btf_dump: incremental"))
 		test_btf_dump_incremental();
+	if (test__start_subtest("btf_dump: emit queue"))
+		test_btf_dump_emit_queue();
 
 	btf = libbpf_find_kernel_btf();
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
-- 
2.34.1


