Return-Path: <bpf+bounces-39264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07A970F62
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455671C21FCB
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA61AF4F1;
	Mon,  9 Sep 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngPK6jln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFC1AD9F7;
	Mon,  9 Sep 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866073; cv=none; b=bK/5n864/c2bW9hvMKPmKNBWsaSX8Px6EY0Qlw8RJSqCEVY+7FcVGbj3Zzd2LxDZD4woZb1x/qFHqfxotcfH6Om7wGETAIUA6mBqAVCrdpN/CKWq76BpupT9Ii2EV+IEPDBONCUgz2r/CfT//c6gh/V/bzIOu89ZVuSP8fJt0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866073; c=relaxed/simple;
	bh=PhZgrCcGMCZTOviiJZgUafvaXQRszMaBXduQ+jC25xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTgFiaRj6Ljp7O4Pqfpl5DqgaA2HvJQEFMm2uUbwA6t5xHksIqZs4hbi1qbO/A/pHwPjOEtCFkT/e+5NItUV11kCi2QmOCgfaA+txjjHldQSzzY4/vP+mnw3Yop4ZkWWR/EulFYQXn2XJjJoJBwAsGL88CUDtYzn4bzn7p74Tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngPK6jln; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d88690837eso3082395a91.2;
        Mon, 09 Sep 2024 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866070; x=1726470870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox67GsEmznfzwYrs9TCYyMXCYDvlYTDtJe/AR94Qk2g=;
        b=ngPK6jlnVP0DNg8lAN9j6BgbDlcNxltQWAbf/qRsiMJdrmqsCqbsxiumdBf7uXXHGc
         MIu9g0EG/WDaP7RD3Wq5DRFCruigtG0/mnPWNewre0ndGl9DwBGkBlgCZ3bWnGhGEXjx
         1mMMKYX7E7FI5qT0UNrk81h5oUHAcgUlWyS+hnBjTFcXErpAHyM0HFzAi4swb/lb19BL
         +ylTaHFkGRuOnN8vccHkIfgnR9oeSrViDyDFnYP5np1B0Pj6KTB3tnpvaUMU5E+jMq3r
         Z8oEsZx+B224x1w3Fu4RU3KpQvtbeF4BxStkZ3C2+qOR/rizuMneaAsqSwQn8eJ9Ki/u
         cQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866070; x=1726470870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox67GsEmznfzwYrs9TCYyMXCYDvlYTDtJe/AR94Qk2g=;
        b=NkUH0kY7PC0QZcaicYYC1AgaA0palQOWGSYpwixyCR0vm8WcFnknQqjHNtYHIXPnwr
         zgmrI3bIJadsBO9aoJ9SfwZ+O8r/RJSaKX4UEJuNNz9SwQj2nDG2hO64MUW598KzpT41
         jCXUXjiGD4koW9YGC4cM1VCNPeXBPgVRxkHLu9hgNG3LpGokgxudNiwl2QezNydnJplJ
         t1yDttIhdQ/NhjXXt7tNnP9HSraEyGk+w6mefKKRTNvNOKjrUa7O25Q14GZMPll9y8vk
         YTx8aHyhpV/b3h8FecZ55Dsftq6QH11kSDJEX8FiVo4JstNA5HTT72LGyUVJjhMsKYz+
         f1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoagLl5n8PzoItP0meWmZX9wXlCMGiRkyVuRgnaqSbwn+WT+pE+kM+s+lK5hUCg5G3j1RnwVQmzmfsfBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTqdX4P3jqIUMSbaBgojZBXH1tx/wWIwSOj0lvAjIo523y97T
	hzJXm5wMVgV18m3/kR1LHA1t9Z3HD09k3y7RcWFoaFw0VhkGA4vRiFa6Ug==
X-Google-Smtp-Source: AGHT+IE18KtsTfvAw3HJuXhjvFzWfRFmqEH0c1tetlbkIQxeu8RF5ygobPHQ6ulxxSuHBl079d9M0g==
X-Received: by 2002:a17:90a:2c04:b0:2d8:bec7:930a with SMTP id 98e67ed59e1d1-2dad511611cmr7608543a91.40.1725866069565;
        Mon, 09 Sep 2024 00:14:29 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04966b6asm3780870a91.39.2024.09.09.00.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:14:29 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>,
	jinke han <jinkehan@didiglobal.com>
Subject: [v2 PATCH bpf-next 2/2] bpf/selftests: Check errno when percpu map value size exceeds
Date: Mon,  9 Sep 2024 15:13:46 +0800
Message-Id: <20240909071346.1300093-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909071346.1300093-1-chen.dylane@gmail.com>
References: <20240909071346.1300093-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case checks the errno message when percpu map value size
exceeds PCPU_MIN_UNIT_SIZE.

root@debian:~# ./test_progs -t map_init
 #160/1   map_init/pcpu_map_init:OK
 #160/2   map_init/pcpu_lru_map_init:OK
 #160/3   map_init/pcpu map value size:OK
 #160     map_init:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: jinke han <jinkehan@didiglobal.com>
---
 .../selftests/bpf/prog_tests/map_init.c       | 32 +++++++++++++++++++
 .../selftests/bpf/progs/test_map_init.c       |  6 ++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 14a31109dd0e..7f1a6fa3679f 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -6,6 +6,7 @@
 
 #define TEST_VALUE 0x1234
 #define FILL_VALUE 0xdeadbeef
+#define PCPU_MIN_UNIT_SIZE 32768
 
 static int nr_cpus;
 static int duration;
@@ -118,6 +119,35 @@ static int check_values_one_cpu(pcpu_map_value_t *value, map_value_t expected)
 
 	return 0;
 }
+/*
+ * percpu map value size is bound by PCPU_MIN_UNIT_SIZE
+ * check the errno when the value exceed PCPU_MIN_UNIT_SIZE
+ */
+static void test_pcpu_map_value_size(void)
+{
+	struct test_map_init *skel;
+	int err;
+	int value_sz = PCPU_MIN_UNIT_SIZE + 1;
+	enum bpf_map_type map_types[] = { BPF_MAP_TYPE_PERCPU_ARRAY,
+					  BPF_MAP_TYPE_PERCPU_HASH,
+					  BPF_MAP_TYPE_LRU_PERCPU_HASH };
+	for (int i = 0; i < ARRAY_SIZE(map_types); i++) {
+		skel = test_map_init__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+		err = bpf_map__set_type(skel->maps.hashmap2, map_types[i]);
+		if (!ASSERT_OK(err, "bpf_map__set_type"))
+			goto error;
+		err = bpf_map__set_value_size(skel->maps.hashmap2, value_sz);
+		if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+			goto error;
+
+		err = test_map_init__load(skel);
+		ASSERT_EQ(err, -E2BIG, "skel_load");
+error:
+		test_map_init__destroy(skel);
+	}
+}
 
 /* Add key=1 elem with values set for all CPUs
  * Delete elem key=1
@@ -211,4 +241,6 @@ void test_map_init(void)
 		test_pcpu_map_init();
 	if (test__start_subtest("pcpu_lru_map_init"))
 		test_pcpu_lru_map_init();
+	if (test__start_subtest("pcpu map value size"))
+		test_pcpu_map_value_size();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/testing/selftests/bpf/progs/test_map_init.c
index c89d28ead673..7a772cbf0570 100644
--- a/tools/testing/selftests/bpf/progs/test_map_init.c
+++ b/tools/testing/selftests/bpf/progs/test_map_init.c
@@ -15,6 +15,12 @@ struct {
 	__type(value, __u64);
 } hashmap1 SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} hashmap2 SEC(".maps");
 
 SEC("tp/syscalls/sys_enter_getpgid")
 int sysenter_getpgid(const void *ctx)
-- 
2.25.1


