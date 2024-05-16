Return-Path: <bpf+bounces-29880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFA8C7EE0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1771C2173F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41F38F86;
	Thu, 16 May 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpz+PP0p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99E347B4
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900698; cv=none; b=BNDAiQMyejU04CzRDvCvAZRvqIoUpPYOR00ff8G2c2jrKF29JRLOSWBtFY4fLdpyWuTaY8LiKwMbyx2drTu+q/OdcddCGNSxED8nmiWb4IbNbeiHR0Uw/sPLBsqHHhbVwNKvMOWPCcSIzPLnvj5FCB87qqPZ17t2eGHBEoYY8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900698; c=relaxed/simple;
	bh=ZioFnZ3d1Vg35xANGhPTZ32CY+yYa1owDklEmy5rVm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha6HQk/SVCnb5tstRaWiMW+bRRe/SSxLM8MGSMwK0cEHZoO3yNeZaD2VQa4kIY7DCksyBlflVf31NT4OaebanXWhmroP72lmsbvrJjZRznBULI0/KR1GjyeHM9sNWD93HDpnesgFzZfTBrCKDf+wrUYMdR+uYXhyA6NYnrCrrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpz+PP0p; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso818424b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900696; x=1716505496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYh5uMJCF1r0KBlzHzNOaPta0GxxeMYUw422sU1IaAI=;
        b=Gpz+PP0pkTXD1UM9qOysodpRgtSFTFXPpVsPSxprN4ft1+fv2etIuAWo2PHkXXSHoM
         f7b7++VMKfssL0BE3ldg4LCrZWZBzOgkxOPsbr1yMviJHL+vhvaW9W02nv2ZW1pEuaIn
         jLupGapHrqVU3FDJ+p+Vuy3qfaBGFDdv0Gla3FfS/M3kiijq3QI/+R8nfODf8kWgxJO6
         NcpC1Bw6KSbvz9BxIjXYjhnEeBtHuDkgwQgcqqZCxSDGx69JTuLSjG3ydUAuU9oNL6oV
         ud6/Wbn/PjZN3PagylpuIjq3Aajl14Bc1U740twI2qtE7kLsFvY018tYCXQP3wJ5k7wy
         Navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900696; x=1716505496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYh5uMJCF1r0KBlzHzNOaPta0GxxeMYUw422sU1IaAI=;
        b=U+XRhci1k9eqDK+gkdE+XeQxA3SDmlB964kEcYoSOaMquUiO7RcNRNubevjZGv5K/j
         Q3lfjcmu2laQRTNzsJR9PEmMPhKPwwpmYz1o5YbMjas/4txhO6KvEz0vh5OL7zkghJpF
         If6rzSXm2vfW4Q2JFcY3srDJsotW4S0Cp+hmae48fFG6eyTy0bmFjJSU26mUVHTmybvv
         pjQ38P050B6G+DOxFZDcwOjZWRPpyLygVODOIjtCcpa6j2L6xu9uF0Ztiw9DE/rnUQkz
         L12BJENvjpJJJcU/FYv2S9fATaGziyJiBfqtciORu9rDhhoUq3efKGHjn/iUPWNOdkZY
         5mZA==
X-Gm-Message-State: AOJu0Yx1342kAfA78zwdFDFCPBUBjy49ThU2udLVKTvBsHKWWEsPItlZ
	eKs0t2fRA81oSXj+jg8buaJpg4RWpKVQIAARrZVR9GH5GuJ/cgfKyxKklA==
X-Google-Smtp-Source: AGHT+IER7sZRijjETZK/jmTvzAJfk4kht1x8JNPZKKUZSCF90Hxr3MO/Di9FSAyC+ftmIdpUPUneuQ==
X-Received: by 2002:a05:6a00:c93:b0:6f3:ea4b:d235 with SMTP id d2e1a72fcca58-6f4e01b91eamr25039725b3a.0.1715900696156;
        Thu, 16 May 2024 16:04:56 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67a5ffc54sm3013405b3a.34.2024.05.16.16.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:04:55 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: tests for btf_dump emit queue API
Date: Thu, 16 May 2024 16:04:43 -0700
Message-Id: <20240516230443.3436233-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516230443.3436233-1-eddyz87@gmail.com>
References: <20240516230443.3436233-1-eddyz87@gmail.com>
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


