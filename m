Return-Path: <bpf+bounces-52336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85DA41E25
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CC2442BE5
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0922B248899;
	Mon, 24 Feb 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEFB9jwW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F3248867
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397598; cv=none; b=nNKTrr8N4zcRjtNGGFF1VN8rqhY2+iNTvIIXZ5v5YokSAeiinfQp+EdiapghPRwkBj95nrdUxCutrzxG4x4jS5c2r5f2chN4lsSvCb1xJdhN7e4dNDWjUUvpXgiIuBnviJUMIRnKJ82+h4y8FnIv9ca7DrCaQRqYqt3US8zXr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397598; c=relaxed/simple;
	bh=xMenmQOXZeusaB2wAk1sFb3rrJm7D9hxPzbSjCDRiX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsxQOz9n25yAGXnv1xq1PY+FWbbNPMrr8Ra+foULpFBfXy4AbznnVPHLwFXUFbaA8WOHT2HI5FsUDq68q5XZaWuEBu6nsbu1f6zI0i4rELA7XlT6EN3K8JV8IPNaIWyMolsZ4NzJkLOxm71jD3A1ApXVJ8g5qkKFFbbhLlW85s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEFB9jwW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2210d92292eso126443855ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397596; x=1741002396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z50XpjZEy8SN1i3++1YEiQp8KHLYIK68Kyf7nn6t1w=;
        b=fEFB9jwW0+ah+gvUNCUnybw7/YfDew3uubnnTuAi9KIzlVOtgmtgqsklaWs4FyYjv/
         1U79U7hbSw3C2u2j4XZbG3l/DUQoeM0I+quSnSacClPClRxrvBS2zaV+Z+dfPLQazF72
         xxt6GhYmkDMiOCjatILJRQ0LqCcoNRH5AJovbS+rj3fh7arfQa/FdND6kjYijqRPKry+
         DJFSK2rEYjNVL3GmWuETtSm+PEZHwHcnghKLe0xdZVRPOduFc7GUYmz3A8u70FH8c1Tm
         UbXp2oKslFOej6DgMCeKP5uMoYcgbE8OBIGomdpUM1fzToE8qzfehqp+ixxOfaTQoIdV
         t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397596; x=1741002396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z50XpjZEy8SN1i3++1YEiQp8KHLYIK68Kyf7nn6t1w=;
        b=Jpr2QCKioRcVu6l7ixVwlv+z4lJ+Y2W0xqtKzGGWIQhTY7BVHU1Yk8vvD72ocB9H+9
         mt75B7jRfk+8y7q0jHKq9qsLvg6ml6s89NR8vCLFvDL3Kf6P2Yn00vjTHjY9Yhn8h/ib
         VzVSsnbPiBrnFE+RSX+j4PAR/TeG4/VBbli8CJqCeMjUpkmJLMPqChyrNlui7oIYO2My
         kPb6ASkaZHJ1dA+bFbIzJk1/B5po9JTROndu8JFVcaqZiqJ4FuC3DRzaeGHUBzHcCHZI
         5D/CrItXqr/bJWVHL6zMnNbAmj1P5kM3BJPysz9mB6dADKA5phgjT0hZK+Wp9YAPoY6W
         JqLw==
X-Gm-Message-State: AOJu0YxC03mz2OeT8+mC34vzJJw3KEnOBVI+6sHdnRBJbn+ePzFvVqGd
	GUzM9QruyunuXyfeHyx+s7OxikJwhG3/ppSklrjdf02tnd44OekE
X-Gm-Gg: ASbGncthNInIliwnqGtmS+DxYlfjfP6JPiW6DGSA4GiNE3qzVePMQ8dJVLfYrbP0aNf
	CD74HjbWRuvbPwuK4o9/mOMd0j5FtiXA12nQ1lDFs2WBGDXMNEKaBJl96/SqWF8lh5gXmLR1kgY
	b2yhC/zDoNMBKs0sCjQOhZSAE9/rgXrLYRfVF4yWwsxB1JoZN0tiI31eocZj0SaJt+e2KOAn/Xl
	kRxP4LY0Loe46VrA7jUjBo4BX2aGuh9Hr9Y+uefLrHEbKmwsRAQBbsTxhsLgah1LERUY7vAXK9L
	N+FI4FcNmSGsaoXJEx+G0z2PKsxQ2DE8bpeO75SmZDHVn1c=
X-Google-Smtp-Source: AGHT+IG3/7jYVNf7oX2vuTHAShTTOqC9Jq8ATZ92sbYf7d5KJMdVdleygRx3rE0QZEwTq9GBzEZQug==
X-Received: by 2002:a05:6a00:cce:b0:732:6256:218a with SMTP id d2e1a72fcca58-73426c843a4mr17200336b3a.5.1740397596320;
        Mon, 24 Feb 2025 03:46:36 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325f063782sm18095080b3a.148.2025.02.24.03.46.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 03:46:35 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
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
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/2] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
Date: Mon, 24 Feb 2025 19:46:06 +0800
Message-Id: <20250224114606.3500-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250224114606.3500-1-laoar.shao@gmail.com>
References: <20250224114606.3500-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reuslt:

  $ tools/testing/selftests/bpf/test_progs --name=fexit_noreturns
  #99/1    fexit_noreturns/noreturns:OK
  #99      fexit_noreturns:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/fexit_noreturns.c    |  9 +++++++++
 .../testing/selftests/bpf/progs/fexit_noreturns.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
new file mode 100644
index 000000000000..568d3aa48a78
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "fexit_noreturns.skel.h"
+
+void test_fexit_noreturns(void)
+{
+	RUN_TESTS(fexit_noreturns);
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
new file mode 100644
index 000000000000..a8d25b21f7c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fexit/do_exit")
+__failure __msg("Attaching fexit to __noreturn functions is rejected.")
+int BPF_PROG(noreturns)
+{
+	return 0;
+}
-- 
2.43.5


