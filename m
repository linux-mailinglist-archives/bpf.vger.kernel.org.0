Return-Path: <bpf+bounces-35963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692D940227
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383391C21DE7
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45B441D;
	Tue, 30 Jul 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzddQzqg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126710E9
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299281; cv=none; b=DQR5Am5W5K+VZ6vHapdArEM43BAL8JJR4PmYZsPHyLs+gsPsy/smADeqtUHewi8RBJVTPNcrALshkQIIc24jVWde2h5MvFwm4yuUj4JQCkMM/P9jmZVtP3LCm2MikjBxiw1+sSs0S4gtpBJk6tRv14+mjo1cj8OxiRR7HBXRKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299281; c=relaxed/simple;
	bh=y4uf3at/AZc0K35b29fw4wrPJj4LrED6wuLVlVhQhKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7YFB8u8bqqSxNamNK5gaepXDzrjXxLSHYRBBrnsY75LRAXv9CrLLKviko5Q6YbKfKxGU6Wb60gIipuW992pN5h1JclMGyVSA89HUxHKs/RABMa3zanc/hJIscdH9L+kjSXfZTKcBPyKYRCiGbsT9ISV5mQ/rCY4O1YwBgsbKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzddQzqg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66c7aeac627so27051497b3.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299278; x=1722904078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb1IT8a2NRtJsOq6rWofW1mEzfnQIeoHlZepVA7unLc=;
        b=FzddQzqgeN1B0aR8FoMl0vpOJNDE/dhBmbhQr4FtC/Upv2B69ve5tds2ZiOP2suMyk
         xpwFIAfOz357IiMCaOpHDO+K3ggWes7BFLDrkZDJiqb9dRCMtCnDFIf8Ce7cAACCTxuB
         vggU85vjTD0B+0D7fBm7YOYQQciLuanBzTi5I2Eghafi8fYZ+aPldXN9JiZMGaxSbUQj
         uvveINDgZxLNWBn7V6gyVfJjyRCBb8GcD2Yp5jt/1+XDdpR2PbgoRnQh2Z5G3oThjpZa
         2417DfR6dwlEfipoMAlcBqTiu6pylUlmvR1dRH5mk/G0YKFVIO4OpN9vUTufDpezjdRD
         7jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299278; x=1722904078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb1IT8a2NRtJsOq6rWofW1mEzfnQIeoHlZepVA7unLc=;
        b=pBGXmaHRXdMTNLqXjKNDkIaGjUIHO8oQfmSXelHXSevrCpHMoZMLG5lq7u3WRNvmfW
         SfsmJkXg5iWO+vGjc14lDYPLPVFRlRDUrMcL75f5YATIajop7VAJTq8HtxpwVncMROrq
         Ds3Ma33V4mY7TGkTrFvIISKlC6s171dIKODo3i51Iw8/6ERXggin/HCQVutpErxCGxo1
         80ovmU0IKu4R1LhfBM+4OksyizUvDh5ITs+80vcine9SOMPYfEmtusiXTkvnVAWjyHCo
         0u1/cWZ/uZoJ6CIOEvQHH6b3uG7wAT3AiE9ad0EV6i942wzxwxNhIywvkBsdjRRzujqy
         spWQ==
X-Gm-Message-State: AOJu0YxVTCgBTiA80V8pciKGsTyYB2e3XUuXVRQBpyE6pRuUFMKCRokH
	/azau4R4jE7ihre0U3x7ShSgJv/OgyGG+AlonvU2tX7/uPvjW59N/by+jaWV
X-Google-Smtp-Source: AGHT+IHIjlKLTFvP9Gh6fQ79EE0dXZH74HKeDAnR2VthMIG9KORKUzfn5b4+lFlimzgyAHHQbeNEMw==
X-Received: by 2002:a05:690c:d92:b0:652:5838:54ef with SMTP id 00721157ae682-67a0a9ea615mr157867487b3.37.1722299278638;
        Mon, 29 Jul 2024 17:27:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:58 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Mon, 29 Jul 2024 17:27:45 -0700
Message-Id: <20240730002745.1484204-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 39 +++++++------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..1bb29137cd0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -37,9 +37,7 @@ static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static enum bpf_map_type inner_map_type;
 static int select_by_skb_data_prog;
-static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
-static int saved_tcp_fo = -1;
 static __u32 index_zero;
 static int epfd;
 
@@ -193,14 +191,6 @@ static int write_int_sysctl(const char *sysctl, int v)
 	return 0;
 }
 
-static void restore_sysctls(void)
-{
-	if (saved_tcp_fo != -1)
-		write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
-	if (saved_tcp_syncookie != -1)
-		write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
-}
-
 static int enable_fastopen(void)
 {
 	int fo;
@@ -795,6 +785,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	};
 	char s[MAX_TEST_NAME];
 	const struct test *t;
+	struct netns_obj *netns;
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
@@ -808,9 +799,23 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		netns = netns_new("test", true);
+		if (!ASSERT_OK_PTR(netns, "netns_new"))
+			continue;
+
+		system("ip link set dev lo up");
+
+		if (CHECK_FAIL(enable_fastopen()))
+			goto out;
+		if (CHECK_FAIL(disable_syncookie()))
+			goto out;
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+out:
+		netns_free(netns);
 	}
 }
 
@@ -850,21 +855,7 @@ void test_map_type(enum bpf_map_type mt)
 
 void serial_test_select_reuseport(void)
 {
-	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
-	if (saved_tcp_fo < 0)
-		goto out;
-	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	if (saved_tcp_syncookie < 0)
-		goto out;
-
-	if (enable_fastopen())
-		goto out;
-	if (disable_syncookie())
-		goto out;
-
 	test_map_type(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
 	test_map_type(BPF_MAP_TYPE_SOCKMAP);
 	test_map_type(BPF_MAP_TYPE_SOCKHASH);
-out:
-	restore_sysctls();
 }
-- 
2.34.1


