Return-Path: <bpf+bounces-79426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF9D39F46
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7613304BD1A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128D2D3A69;
	Mon, 19 Jan 2026 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbbyfEJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A796299948
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806194; cv=none; b=MQ+RVzr7WFuVKq2rCJbaFtU5gP71sG+briuT3VdJ1uzQdKeQf2qoBAojisf4RU1o8ORH9YXvJw3J4Gyvj8xBqVKRkFnHzFiOh7zMdxcdhGIgqur7q/RnqEulZOmNsBfPx/aVuxDfdM0roDt8MamyOIWV28w/ohfzcKPXPXNjM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806194; c=relaxed/simple;
	bh=E/tkA7w9WWDmbfkNKYISzjMSp/U2pRPxGq4HARC6vZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1pHAFGX6C2yAWfG5cjD3QhzD23DiFOQcy/bBo4vmJVGHgysawuE6pRvXjLHoOm0JKlXKeuu/BtgXK0zGDXe4Z86Ied9KCJ5QtbDZPOyucpYw0oKpATPGFhqek9/kyNZYGsw0NfCWcoQ+JEt83X9c1qInY++e914UCUGJbNGxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbbyfEJ4; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f39438187so2114469b3a.2
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 23:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768806193; x=1769410993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm4jeH98Vgcx0inG/SSLZR49gdamhbduwf0TgJLnrGI=;
        b=BbbyfEJ4/UJAfcMLmvggcAaGfxKKL5RN/0/9lJCXTALPbjHOkBrSiCY3bPY42X/ODK
         oNHgo3tOG8+9OVPfH9oRK47Tk7xqIE0NIPbfRFopRI2OmN7NN2SheGDEFEYzD/QrZSQk
         RG++HlJqGmOsVjMBy0dn0MVbMqs8siaUADrxNszCk58ctg7VvuQ9zrcdO51UPr48cY1S
         3Gp+qt+ehPhxvtv2a90L0RoF456j+ZRI/vmcziXvsOa1dI7cUYl9kUoTtz4G4loyHrME
         Ho0Uigpy/qCln0eXf7EwZDek7d1QipcuQsMB48ZAjLhp9Syqms4RUu6mJjnHuM0WSosL
         CWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806193; x=1769410993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm4jeH98Vgcx0inG/SSLZR49gdamhbduwf0TgJLnrGI=;
        b=TdnwJhfwesKbnrcA6LhaL8/eIYsqEEGUmeE5/BfBFpDauPOcyP+Lm/fLUhKHINHvHg
         YLaEt9n0e732ujLzSDq7R9aF/WSq0UTP5dQSecwcbZDO123ZN0ICg2sF4zrLcRgttbKu
         zAIi+8h57SkOQAuQ0+rRDoNi7rEEHQdAD5GvkiiiJyd73ou8gwkx4zyppSrwSiTgh8F8
         IJvozsxvKoJm37kRdIfRT6YEGUYRFoI5XIw0tCTBrqj18Fr1ipQESCYsQBD/v3J53rx4
         E9Uv3dggkRaRT/D+LwD2xOZMRLrKbLibuwlEBuWn5rDgEngZmlKbTsWA5hyvuJSBe3/H
         0IKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjm3ReM8DQdaNnhl9A3GAYbeReeuzwXvHxDnvJkylTn0jJ05r/lKb+Wxg13yUC1Dy5WCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNT2qJQh5gePcarOAMYpF3HrPj9/SJzSNcbadcV6VnWDhcSST
	qSCgWUWWaXG2W6FaAgUC0cq4VcQWXnT/Mlvj5ujURZbXQZ3eoL4mz0IQ
X-Gm-Gg: AY/fxX676r5Q+8leydNDn5fc39DltV6rjVY3y0nR0OtztVpCjuWxIkCk2tEFpFL6OcM
	UFU5ljLvP5Sz+KfHrzOoP5xd0IteuiLlcFganKNob0pnzr2OBSk9AaruHr8QKcV+RKpJXvh429a
	z5d0xyLtoJ8cjVKbY63guu1q9CqG8wzdPNC7V4xlQUgmpq1+UGIySFd85NdWMC/FFvTvQbQw+vM
	ABGKNQpi6smCkVXo8C7UJ33HZzHc33m9zjN6ufbHVhPrTN8nCjMsA7KkhmxADrs6iComMqf17u4
	+6iKGFmp78MnaOHCjeeIPJBBaGSEkZPYIdEw9QNNcnj1JI+4wGkD4BvIP6B/jvjNvuwRqGU+gLp
	xJ0fH1iwFhz2b09zk5Gteshnf0VVSeQQgJPvO9H1dnLjRlwcXIZu/P/rwWcGWpf55y9J9rodEoh
	ETa+rSVJJ5
X-Received: by 2002:a05:6a21:339c:b0:35f:aa1b:bbff with SMTP id adf61e73a8af0-38dfe590741mr9912368637.11.1768806192917;
        Sun, 18 Jan 2026 23:03:12 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec7dasm10772027a91.8.2026.01.18.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:03:12 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Mon, 19 Jan 2026 15:02:46 +0800
Message-ID: <20260119070246.249499-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119070246.249499-1-dongml2@chinatelecom.cn>
References: <20260119070246.249499-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testcase for the jited inline of bpf_get_current_task().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 38c5ba70100c..2ae7b096bd64 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -111,6 +111,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
+void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
new file mode 100644
index 000000000000..0938ca1dac87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+SEC("fentry/bpf_fentry_test1")
+__description("Jit inline, bpf_get_current_task")
+__success __retval(0)
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %rax")
+__arch_arm64
+__jited("	mrs	x7, SP_EL0")
+int inline_bpf_get_current_task(void)
+{
+	bpf_get_current_task();
+
+	return 0;
+}
+
+#else
+
+SEC("kprobe")
+__description("Jit inline is not supported, use a dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


