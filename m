Return-Path: <bpf+bounces-60663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9EAD9A7C
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66986189ED33
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14AE1EBFF7;
	Sat, 14 Jun 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAHOtGlL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7D1ACED1
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883307; cv=none; b=IcjnrBGQB/oVTYYc0i34PM0Y0QgA2bCB/VCc8Dr9ly+lfkKuMs5t8iY2y0LdOCaiOgPg4zLJxMQQQvnsez4gP/wnsIE0wCSy9eE9M7ujx0gcWHPB/7a83pKspOjhiXCr3+kWH3Za2ltphMLqGw1gpsqJhWy1PLIUKfHJLkrRduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883307; c=relaxed/simple;
	bh=4wy8ZzIR2kGeMyDc1wFrWYpxqx+ZGtc0RSkQgq84CX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG/LkexzAzEJr5kuFsNUngTGzudOCBtdsqzrraaympqFPdIl125QJz8wk/GJs2Cs1AevrJ5vWHxf9usfSSF+ZZP7qLtluyQIbMAkwjOmzQgpJWHQkgW0kQ2xff7sJ5JWBE6yJib6dRzkcMj6/i54UlWwWGfzW8wmwwm9RONgKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAHOtGlL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2408703b3a.2
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 23:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749883305; x=1750488105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+1OuLqKg3A8EKA+XkcLTlTOkMtFkL1bW/FDTDfRYVE=;
        b=nAHOtGlLs/g9M/gqj6sSs6wuxMqulWnv2/5djU1w4tDb4fEdDYKArTENhDrQc2ECYX
         4K1wigtF3B3G16H7B6C2GKzx77gPBkx3y8lnfVBN2quhdx8LfxLfEVvamgCfKoC3ESng
         fYjUxqFU82Mc5bn+xZKJmwrh+TpB4VO7ok7FMl+UhRaH8VnOqOW9sv2EJZmplqumeKpb
         8hy3CjroVSIsSh4c+LO35EHvZA+PrBk2qvxPJAFspv8OTaG0sCMyNmI1PVJXBn5dfS2L
         mihZSuC2tiXMIinVZC9qIdAn/q9jtBy6yJ3VmCkM7cd7eX0tDHk6WKpvlnLmhuPmapBw
         55YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749883305; x=1750488105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+1OuLqKg3A8EKA+XkcLTlTOkMtFkL1bW/FDTDfRYVE=;
        b=JYyPfczq4N6gAkrUll0XwyrQ+WmSaL02KpMw6/ML/spjuyrTmgmb6RV7NaoiJgbfXV
         debf1Fe33o5IwGOBs9pPI8PWzJ1DwXE7XneAXigizSiaCrN5yNWWY0dpy6KZvzi9r1aZ
         Www95Da0Do1LydncXkXL8y59Ym0/I5VJv1d7sejgDhadFlU4dkYOs3IJu71o5LHhCC8F
         RLfZqbZRCykKxrlBKU6Hy09pUWfZjsXFvrEV6r37rpin3GW0bPq+ey3monky9nmz+TNP
         3ExjaC4wTxzT6A8wmG2VAMouFtxkXr/Z1+YBvC7JJYA6ECdAyj9hukSLfkXwqPkyZ+7t
         nOwg==
X-Gm-Message-State: AOJu0YySA3xHp9GqJxHAgWFcq3DwfSyeWo2BnqNl2aK8AWLtgKw1Ouxw
	SzSaHB2+lC/DS/BPCAblXAwIA0LTcRuBpOtFSe0YMKperL7wv+6CY8qdgN20k+zX
X-Gm-Gg: ASbGncvioPdCx8jMm0lofDUNoNWW5MSPKzQYj+Kpuz0trI4/c9P9Q65QZn1ZvvP1N/K
	DJFIWdAcc5i/95HUcxq0XZYp2QRM+l1CL5lQL0loi3YevCncZIoNytZ+huaXgW1LVjw/nhUQ/o8
	LJJmvkXwRKhwl4jVstjNw4YfhnH1PX19ZrqCzzdZmp2TziJEzE9RmNnXVSRzudG4zvSbmP/uOHg
	lMXOD0NKAj0z2obf6qT+OcZxabqd6A2wssgA69kM94Wyv3ULMJG38h0Hg4ddMucgFYD3vXizkpI
	K6Vm0GIuCs3hxL0vnjAHAvP4JpNddkoVzWmHqxOGLkq817WrzjmaPo6LL4kfNnzcfZ3nxhnEJGu
	O9o6JdlJ0XVfTjqpA7ld9wOaxe7srFLmMSlbg3aCjSsTLhPoMRXV6kcNlQTVjbZc=
X-Google-Smtp-Source: AGHT+IHe881pEKYIFi9ZWuBbdOf4yqJRFeSAUuWIJYJPa00dQq7/so8RybJ5yeo0l1klxgtmMC1Fow==
X-Received: by 2002:a05:6a00:4613:b0:740:b5f8:ac15 with SMTP id d2e1a72fcca58-7489ce46ea2mr2432668b3a.10.1749883304901;
        Fri, 13 Jun 2025 23:41:44 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083ba7sm2812124b3a.102.2025.06.13.23.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 23:41:44 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	Raj Sahu <rjsu26@gmail.com>
Subject: [RFC bpf-next v2 4/4] selftests/bpf: Adds selftests to check termination of long running nested bpf loops
Date: Sat, 14 Jun 2025 06:40:56 +0000
Message-ID: <20250614064056.237005-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250614064056.237005-1-sidchintamaneni@gmail.com>
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds tests checks for loops termination which are nested.
Additionally it ensure the termination of loops in both inlining
and non-inlining case.

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_termination.c | 39 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_termination.c	  | 38 ++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_termination.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_termination.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_termination.c b/tools/testing/selftests/bpf/prog_tests/bpf_termination.c
new file mode 100644
index 000000000000..d060073db8f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_termination.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/socket.h>
+
+#include "bpf_termination.skel.h"
+
+void test_loop_termination(void)
+{
+	struct bpf_termination *skel;
+	int err;
+	
+	skel = bpf_termination__open();
+	if (!ASSERT_OK_PTR(skel, "bpf_termination__open"))
+	        return;
+	
+	err = bpf_termination__load(skel);
+	if (!ASSERT_OK(err, "bpf_termination__load"))
+	        goto out;
+	
+	skel->bss->pid = getpid();
+	err = bpf_termination__attach(skel);
+	if (!ASSERT_OK(err, "bpf_termination__attach"))
+	        goto out;
+	
+	/* Triggers long running BPF program */
+	socket(AF_UNSPEC, SOCK_DGRAM, 0);
+
+	/* If the program is not terminated, it doesn't reach this point */
+	ASSERT_TRUE(true, "Program is terminated");
+out:
+       bpf_termination__destroy(skel);
+}
+
+void test_bpf_termination(void)
+{
+	if (test__start_subtest("bpf_termination"))
+		test_loop_termination();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_termination.c b/tools/testing/selftests/bpf/progs/bpf_termination.c
new file mode 100644
index 000000000000..bd8f499f2507
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_termination.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int pid;
+
+#define LOOPS_CNT 1 << 10
+
+static int callback_fn4(void *ctx) {
+	return 0;
+}
+
+static int callback_fn3(void *ctx) {
+	bpf_loop(LOOPS_CNT, callback_fn4, NULL, 0);
+	return 0;
+}
+
+
+static int callback_fn2(void *ctx) {
+	bpf_loop(LOOPS_CNT, callback_fn3, NULL, 0);
+	return 0;
+}
+
+static int callback_fn(void *ctx) {
+	bpf_loop(LOOPS_CNT, callback_fn2, NULL, 0);
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_socket")
+int bpf_loop_lr(void *ctx) {
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	bpf_loop(LOOPS_CNT, callback_fn, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


