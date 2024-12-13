Return-Path: <bpf+bounces-46880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA69F145F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB09188D4A4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6171E570B;
	Fri, 13 Dec 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeSlPe4i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CD1E22E6
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112297; cv=none; b=ZWXlw2qcK9IPV1kkhtWH5/O3JQ97PdRoMkXGuw4T2TPJN8A24L6xaj2PH2gw4NSlRgtUHu+eoomc4Zpmx7hboICCNvg+PaQDWtZwH6Brv7XmThFIh+WG4aRiQHkMtXfvBOx/glvsMkGKlVtK7P/NW3p1rMrOh0XIqf33STEKjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112297; c=relaxed/simple;
	bh=vsRKSkz/fZOFZmIfl7f9CCgSIMhv+zZmOd+PgYxJzDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw5ObapFmvJxuVh5XeUXAP/ao77NKV+e9nvtnCsOFuabXzrb/P/EYEC9V7Ol/Mn62WECk56Oz40RL7aAwkQOTIGv5Qeqh14hcrnNjjfiD28uCjRHliDEwIpbiS/NB7r4ixKqWY8Ji/OK8JpmlIgHtTimrGG9r+XjSKcK2wSLBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeSlPe4i; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3862f32a33eso994582f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734112293; x=1734717093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/xdfUQsKZfCf1D4VPdEjPDkdQjmt7uCtafMZN5T7vY=;
        b=ZeSlPe4inPjdVRWuhdbGkBXEBHUT5zH4hmXuwyEg5RzHBwhuf+8Wtycx9qOxh6gh4X
         bnUqHFmsj1Ee5b9rnAENTlR5EF2sFZaUtWceftTP22GskigY0TdIxzletMNZBuZL/8OK
         IhiUzKfu7DrIE7n81l1GqUR3Nw3PeGMBtmsDVapLgAcHkaFh85IFJVaLU0Vzu2jLxFbc
         pKyIAsh+JkSTOvDd20Z0etMmynwZVtRpfAQXLWq+jKuf9LUpMUa2vcZkGGtNkIkC2a3V
         ucsvRofzvncI4dzFKkPc5huMhCpeP1EgGt8to1j0/e02kixS9DVsWAxe9tECJVu0j2x/
         +UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112293; x=1734717093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/xdfUQsKZfCf1D4VPdEjPDkdQjmt7uCtafMZN5T7vY=;
        b=qu5G5yKJdMtxYd9DPPSH98iKlJpN4DFGIFjqFixqHsRX6LISX5/EOS8bKflvPXhWRw
         IhNcUzV19fXF33AhiIJklFc3Y9ycgzS5ydow0vSpJm+yptpXo6EHspJyMtfdpOWT8xxR
         33WB96rs0xzGsJ42SFkuh++bUQQbbfBJh8D9Gi4KHnI+2FOMnOUgQj99b6Ix0AzqgOV/
         et7VG0iOo+faEcrVjLaqV8Ufas9mzPXAVOSnzYlJt+DAOEi+U9MgrdJ3/HS19ugLGvIR
         y2JormBJH1jgUrc63QwYUyjWTjVTzppTQ07IvHFd7D2UoX5/azchvJfGY9f4LcU7fACy
         X0hw==
X-Gm-Message-State: AOJu0YyaGH9ZamgbP4SXesxgFH/+YEZeVgzGOXdT0zd67ZMJYzDHI0DQ
	IQ7+KY+wTlP4FBQWNdRHlxC3eQ6cHVEM1kT7dC+VkNz5fNnqb/s8ZHczDsUUrfnexg==
X-Gm-Gg: ASbGnct1EBCp7PDXfrvgIldwrt1X7WbSRpIMWCPRtEmvvHyVGTgFWjYocmbN1oOOxhO
	Zoo2CWE+bDl3/4lxBkOf9epgJMAHKHIzHPz7FvCMfA0UbZHp/D5G2F1qYXnURv+gvZU6A2KldB1
	e5vUwtkrSB+EGWWIF/hiu03+ecDdqdnxIivzsCLdXCWtL7p30FUw5iV/KaChrarQEvbJsllyJLu
	gwGSUWHVVXwoZ6xLxDi2gBcVNd/PCKygsC1ilIiweV7MSamT+lB0hoxsjXcTJnKIzmuwEOe4D+k
	IARBf0mR
X-Google-Smtp-Source: AGHT+IGGKiuD2+fSyf42k5WSyr7oMbbf3dZW4ZqB21yvwbZEHRLQBoKIdfiWGXo8tUHMXqQVoArmXw==
X-Received: by 2002:a05:6000:18a7:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-3888e0ae6ccmr2868711f8f.28.1734112293253;
        Fri, 13 Dec 2024 09:51:33 -0800 (PST)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046f8bsm107590f8f.68.2024.12.13.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:51:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add tests for raw_tp NULL args
Date: Fri, 13 Dec 2024 09:51:27 -0800
Message-ID: <20241213175127.2084759-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213175127.2084759-1-memxor@gmail.com>
References: <20241213175127.2084759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; h=from:subject; bh=vsRKSkz/fZOFZmIfl7f9CCgSIMhv+zZmOd+PgYxJzDg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXHItZKmTsj99EWTjLG1rmpgQTQk6XSjfFdqe8PQb tfxJShKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1xyLQAKCRBM4MiGSL8Rys3iD/ 979ZFNTUvVAZrqCgqaJz6A8fXhua2jN8/724KmWxAutdx3n8iQaN2MwlbUTQfCXU+Jjsa9trszM1pQ f1zAhEgSF3RcL803K0PreLbCU9fK847ebP2B1ag4n0mZ8u0xTcsBXe43e/ZJtGCZVSlqaPnk3dgtdu IfNCR+apMeuW5FGvjlQ2O2SO7OX6LbLrnCxeKk4j+dNmPdiY5cOGkBQKS/XAXkhwN6wLd2OQPL0nu1 aGKV7eJFy7uSWT74nu3MlvCWqM6lwP8JRwNO0OooYQoJf8ohg6V99STghjB1zEw40IObatmjxnmi8R ZEz77OejOJ1H8YoN0YTHBmQ8Q8JsDq0chuYTzWPc7TzWeIqjuhpBh3eW00vG6djS96mudnE/QmJKGA YRuzYk4V9l5Q3AFtaLF71qVqkcWiEr8TroKictNwY79+VPIzKvj+ju26s4gMDzZ3C825qz4z7BotU3 HZaDpM8KLM4xE64kfudO7QK3l80thip/2cSlFhu+bvvZyrV73oauWdQh8Irb7MgTWUQ3tj+2cgebfQ DW+flQqqDqdJvhjMraec0ucqwdEbib3keY+mrknl6DPbFlWVfNyLb4/hX8Nu6CcxMInBZMAa/PBUTZ sL6PZaeOLZgiexu4EGhkYCdPoglhwR5gQdJX29wEHo8wG96hG4XYcwWrg2ag==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests to ensure that arguments are correctly marked based on their
specified positions, and whether they get marked correctly as maybe
null. For modules, all tracepoint parameters should be marked
PTR_MAYBE_NULL by default.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  3 +++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
index 6fa19449297e..43676a9922dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -3,11 +3,14 @@
 
 #include <test_progs.h>
 #include "raw_tp_null.skel.h"
+#include "raw_tp_null_fail.skel.h"
 
 void test_raw_tp_null(void)
 {
 	struct raw_tp_null *skel;
 
+	RUN_TESTS(raw_tp_null_fail);
+
 	skel = raw_tp_null__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
new file mode 100644
index 000000000000..38d669957bf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Ensure module parameter has PTR_MAYBE_NULL */
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_bpf_testmod_test_raw_tp_null_arg_1(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
+
+/* Check NULL marking */
+SEC("tp_btf/sched_pi_setprio")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int test_raw_tp_null_sched_pi_setprio_arg_2(void *ctx) {
+    asm volatile("r1 = *(u64 *)(r1 +8); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
+    return 0;
+}
-- 
2.43.5


