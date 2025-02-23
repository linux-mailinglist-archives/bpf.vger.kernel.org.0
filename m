Return-Path: <bpf+bounces-52266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6CA40CF7
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 07:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EF9189DA69
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000E1DC9B3;
	Sun, 23 Feb 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSP9OXe0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2813C81B;
	Sun, 23 Feb 2025 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740292096; cv=none; b=OmxUB6VAjqmIhQSITreCXUTc5FDH7txvS4wBZl5K3PI9MwzHEWEbkW+4+cieQx5iElwvSGO+NRkbcuHWgfNojZyAFpzX1Mr8GTvZOkTkcVEiXw53nwYBuMbFGQxTGp039agBpcQQgBWXkyoVik/HbQyc/JlTPI8xLra380hQdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740292096; c=relaxed/simple;
	bh=xMenmQOXZeusaB2wAk1sFb3rrJm7D9hxPzbSjCDRiX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsGWaU93OCnTRQP/ReyksuEK4AX15520KrupLBUnCIsSSg3uVwjUl5718ubupgQs0Oxwe9Jt8pb7k0xB/0X8c6New1/9n+EKe7GomQH+nJuM0lIBC5VvUNhwNf3TNnwzPxvqTRdwToHwI5tohVZFeleP4Iuiab2v8hVsp4/3Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSP9OXe0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8cf98bbso77506865ad.1;
        Sat, 22 Feb 2025 22:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740292094; x=1740896894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z50XpjZEy8SN1i3++1YEiQp8KHLYIK68Kyf7nn6t1w=;
        b=LSP9OXe04DLNau81yWY5V1/8NT+DbtCievhEgkleUjJqhzyjH1iIyIjJstQXiVQQ2Q
         27tfdFXJpTTrTo+XHlOCp/Q919b6iwKy9Z8Iz0CykgGPi8K52QxKYwY74srXPELlvB80
         C2Hlh4U9mnMGuwcIgwMgHQ3sjUmyMWBmPD1xsd1oxgl7QsVIKdS7FjIpCfJW60uHnOQk
         zciiZRXwXIA2ojCfRugePzYzT2FtLiVc/AflIk8M6IUcNwMYkbUIWad0HNkqij4YKmu3
         j1EXHiNkuJqIEjQ8LcZZ+jaXHETnloFa5gDbsc3zVpTqZylIOEwxvfXRu++DNyoufrEB
         fBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740292094; x=1740896894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z50XpjZEy8SN1i3++1YEiQp8KHLYIK68Kyf7nn6t1w=;
        b=GpFL0XmEYDqQmX7Fh++CyXsAbihAYJ2Ey268BRmWvUwUpRTtPYqAvEIg5uquIEWVRH
         n8gmxwN+UyTwRZl/6K/wiFeYzLWWBNEQPN5AFybd3QT6oL6WmtgyTFzCQ4ls323goi9k
         whl/VBSkq+wfGpcWPRIdVSSEqhxYYfe58ef42Od220OEZDnom9t92d09keq09faliOr4
         +mjwxfZkwwMFtY/6U3asCZBkdUSx4HYT5EMpgPdX2Lo9G3Qz06VZsszNsQPJwE8PPenf
         9duRTv80Jc2Ic2YqSHNc25JJuQwHoi2ghQmtNHaMO//XFoS+h8tYt9bDZiqwOZHTYSx7
         D0rA==
X-Forwarded-Encrypted: i=1; AJvYcCXqHpuFDZ0fmxIhRmvMp5Le3T/xND65q6WBYfwh5sDissNwTxSFrSADWmqJrMV0LccmzQNS67M0NF3/tGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRitxMdGXIRhg5dTouFM1H5ybP44s41g9d8EOFpZkKoqBXSu9a
	84f6oMrHJJTSv/PC9SGuf9pLDW1IehNvmdUNzTIHdSf1foM7TQjPROW0kwzj2Y8=
X-Gm-Gg: ASbGnculmHXYNp6F+tCnzimy0fos290SCzzTVMc0JnUG/T4oXWcVnJ5g/s9oBtvemOT
	d2COU76SSASiS3/UKUfwwV2Sh0/ZzpJWh8/hH6rLE9KI8+Mm7q5Pat8qK19dJsvk/RQC/TBLyOu
	GRjjRGuoC9p44t0y704FJSXtx4iwPvWRfMjzjMrSbSR0b9/xAkKplw7VqOms16rKjA8VawJfqXa
	MFkA8ehBECq9C84O/OHwSh6nqiqaC8fJ0K0P6juO1/GvEa/YjTsYyjxVpX3Zt0flYpv6UVSb7Y8
	aMdwtz2koQuNQYp/dQ6asqhwHFPmQ8AZLGopTUEsEvva86c0kX0=
X-Google-Smtp-Source: AGHT+IHckbejzyjx5+RLDqT6zfJmvmrq5p1M/D47jZFVL70rwbbhadQxp1Z4pVDLigM0MuhS3f9fbQ==
X-Received: by 2002:a05:6a00:847:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-73426cee82dmr13524379b3a.11.1740292093959;
        Sat, 22 Feb 2025 22:28:13 -0800 (PST)
Received: from localhost.localdomain ([39.144.244.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732521b82b3sm16693128b3a.92.2025.02.22.22.28.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Feb 2025 22:28:13 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
Date: Sun, 23 Feb 2025 14:27:35 +0800
Message-Id: <20250223062735.3341-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250223062735.3341-1-laoar.shao@gmail.com>
References: <20250223062735.3341-1-laoar.shao@gmail.com>
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


