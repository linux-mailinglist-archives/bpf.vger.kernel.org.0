Return-Path: <bpf+bounces-38580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FD96680F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA17281AB8
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3F1BAEFB;
	Fri, 30 Aug 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbwXgxiH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AF15C153
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039263; cv=none; b=P69jg4iK7cxKWNnZQCmOiLlW+AjKyGyMHSvNzTeqWzw9xuflfKRhD3xMJL5n7Fmspber4vXeHvtT1DXFx6Ql9chCoObKHlLtEKpsD/0UH87qbFsjYGymeX0uKXoRU4l9x24hRRKaX+NOAVgf3mzoGgINO4ozEYyy12dixuTEEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039263; c=relaxed/simple;
	bh=gzTtA6KZd87b/c/OTmhe/x4bN6GJo38FrBy2PbTydWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbCoPNemhJ2hjvFckhqU86M4CGtzB9oW2RRPvwLPXbWZjx4KA6dQQFwOXyCoI2Rvqo/1gKumTVAgus7YjweEWLTwTg/jOY0N7/1HJ0OYeYI4ThWC/5Y+eJpRdwegpEgHJKZD6iyg6PgiwF/CHg6K98McW3bkVqVHO+1Ez6Tt3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbwXgxiH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2020b730049so19126255ad.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725039261; x=1725644061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMv4IDP78/5lUqvfivRe7eqWhVg9TLLpihpI5JqTmOE=;
        b=IbwXgxiH4AZLGqJ52l+exqnuBRCASf5JfeILACYUqxmuAgZIT49y/86VYFLGrmwIBY
         oxdNS60wrncvu+OuUZr/Cko3pyKNiVZph8O49yqCGD6ezutlFD5/nIFZBi8h88G3XfSJ
         hLNIlKGoS0tQAiaSL63L72mINFcD1iwijHy3e3cO8YUmpCMcykDyxdX1Cw98E7paMXcz
         RqP990DcyluVm0O0hUPV8gPE80X0Cq8Lptgmweswwjxnq/RSax3BvHV3hUoKCY9b/x0G
         VjEFDT2tcXgVoguu/RpCflJWVLTGDWloSWq8+3l88FECM0JuIVJ0/1QhykPCn31XPkhR
         rZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039261; x=1725644061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMv4IDP78/5lUqvfivRe7eqWhVg9TLLpihpI5JqTmOE=;
        b=gfEFMQSCDYhXgcCFqMp+9TJyLhpe2/arOXjvy1Q1vBQXDfNNHesJESS0bI1038RcMl
         9dJUoMhwyyp/+4eVeLxhg8K8AwG7fq4+FsSKcNMcg4hNCdaqY3xg9NcLG2muMWOj0/a4
         87YIZgJBQG/PL0yqWEUg5Q6aKTE29YwaNUG+L4zQ7tLzzsr92k/991FODcQ/AIB0v0OZ
         nRBDGx9N910eVfJvlgM8/3Jodgt0baWw4+kTHWYoA0vGGga7T0i7zqljIQAjT3+FANz7
         n7o7mOGX3V950x7i9u1tWpvumMdq0YrTfF+5ZdJUkFEA9SrDerWxLC3rAP5fnTL7lyRi
         c1Rg==
X-Gm-Message-State: AOJu0YyA9NHzgq4m3ijz0Sm8kTHlRGPExgVDMWlWcPmJCiI4pNqoBFLG
	2o2N8VQVUUB7bCfnyXkg/nbfxW7XB6kHusfZz/2psx9Wbfvmtn0MI5JcrQ==
X-Google-Smtp-Source: AGHT+IEs7EeAyE+poALtcOSTEmbYbi8+KJzczGJbLH/GYTUd0dDhKi/6OjRekL7VvKSYosvFYXuHzQ==
X-Received: by 2002:a17:902:e883:b0:202:38be:7b20 with SMTP id d9443c01a7336-2050c386c0bmr82362855ad.38.1725039261129;
        Fri, 30 Aug 2024 10:34:21 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515533ba3sm29326655ad.152.2024.08.30.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:34:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tony.ambardar@gmail.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: check if distilled base inherits source endianness
Date: Fri, 30 Aug 2024 10:34:06 -0700
Message-ID: <20240830173406.1581007-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a BTF with endianness different from host, make a distilled
base/split BTF pair from it, dump as raw bytes, import again and
verify that endianness is preserved.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index bfbe795823a2..810b2e434562 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -535,6 +535,77 @@ static void test_distilled_base_vmlinux(void)
 	btf__free(vmlinux_btf);
 }
 
+static bool is_host_big_endian(void)
+{
+	return htons(0x1234) == 0x1234;
+}
+
+/* Split and new base BTFs should inherit endianness from source BTF. */
+static void test_distilled_endianness(void)
+{
+	struct btf *base = NULL, *split = NULL, *new_base = NULL, *new_split = NULL;
+	struct btf *new_base1 = NULL, *new_split1 = NULL;
+	enum btf_endianness inverse_endianness;
+	const void *raw_data;
+	__u32 size;
+
+	printf("is_host_big_endian? %d\n", is_host_big_endian());
+	inverse_endianness = is_host_big_endian() ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
+	base = btf__new_empty();
+	btf__set_endianness(base, inverse_endianness);
+	if (!ASSERT_OK_PTR(base, "empty_main_btf"))
+		return;
+	btf__add_int(base, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	VALIDATE_RAW_BTF(
+		base,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	split = btf__new_empty_split(base);
+	if (!ASSERT_OK_PTR(split, "empty_split_btf"))
+		goto cleanup;
+	btf__add_ptr(split, 1);
+	VALIDATE_RAW_BTF(
+		split,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+	if (!ASSERT_EQ(0, btf__distill_base(split, &new_base, &new_split),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(new_base, "distilled_base") ||
+	    !ASSERT_OK_PTR(new_split, "distilled_split") ||
+	    !ASSERT_EQ(2, btf__type_cnt(new_base), "distilled_base_type_cnt"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		new_split,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+
+	raw_data = btf__raw_data(new_base, &size);
+	if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #1"))
+		goto cleanup;
+	new_base1 = btf__new(raw_data, size);
+	if (!ASSERT_OK_PTR(new_base1, "new_base1 = btf__new()"))
+		goto cleanup;
+	raw_data = btf__raw_data(new_split, &size);
+	if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #2"))
+		goto cleanup;
+	new_split1 = btf__new_split(raw_data, size, new_base1);
+	if (!ASSERT_OK_PTR(new_split1, "new_split1 = btf__new()"))
+		goto cleanup;
+
+	ASSERT_EQ(btf__endianness(new_base1), inverse_endianness, "new_base1 endianness");
+	ASSERT_EQ(btf__endianness(new_split1), inverse_endianness, "new_split1 endianness");
+	VALIDATE_RAW_BTF(
+		new_split1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+cleanup:
+	btf__free(new_split1);
+	btf__free(new_base1);
+	btf__free(new_split);
+	btf__free(new_base);
+	btf__free(split);
+	btf__free(base);
+}
+
 void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
@@ -549,4 +620,6 @@ void test_btf_distill(void)
 		test_distilled_base_multi_err2();
 	if (test__start_subtest("distilled_base_vmlinux"))
 		test_distilled_base_vmlinux();
+	if (test__start_subtest("distilled_endianness"))
+		test_distilled_endianness();
 }
-- 
2.46.0


