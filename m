Return-Path: <bpf+bounces-77782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF79CF0FC4
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB5C3073150
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E34303A1A;
	Sun,  4 Jan 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUZbYBBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC73016FA
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532645; cv=none; b=s/rnEiyDK6/cAAhexrCceXbqTDMlLwicChgomeQWrRoJVmHnc93Cb0XOCEaVn8TngJ79DspMpdbk6gydotTx+k85ZwUM66XVW5+0hBlEhnNbeE2vEUkZ5Ob9aAGKtP9mMoX/NzDl2GAqcyM5fFYtrTHx6thbTV2ENeSj2ugTIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532645; c=relaxed/simple;
	bh=l/pB7uVblz5yUYx9vVEAQ9iGeAfGiUcxBP+M7nG1v3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvrOZSd/cb84AuGmVcp6JuEAZsPfGoy22mof/SxKkTSt0tc40UU8KwZF+8w8PdoUlUZYWgyizoC4FWXnPZBCLg61ncvBKRo3Avk89CPi5VPP+IecMQfuMsxkF1TDukETeWt2MDld/8bKFG8WOqfWZcheCwtcPfzAoAXVEyXVnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUZbYBBt; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso15631816b3a.2
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532636; x=1768137436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhOaRHrMPgBGQqZ9JTk0YwCbrcBEBCvTMf35tIgKBVg=;
        b=DUZbYBBtSz5EMkmaiD/TX/nbeenMJOM7dQ//1B7lghg8wbDyEG59+NCs7QRrxi1XW5
         R5eRBf4kk9rGoNBhtjgSYljFuGNdSenmlnoAl1D1OWwsJXj9vlGyJ4I4ffPE5R1dyyxf
         LtxrpShg8X/MDEp0YqSv9REW0tLKiMn37LZI0qqBt2tATP+bVRoGOffd9k+hTI65bR01
         0+nxlPJO6KA2y4QnmQb2KQ1yt8oNsInZ9tA27k/alR2dZRYM/Lf2EfDJ75wpKQ4odJ8j
         oT67ra+uB7n4FOmV4oZRD1vGIsa4bTNcHdIfJkl4I8HarPT2Y9s91P+ikCM+4fWUH7UP
         ZxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532636; x=1768137436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhOaRHrMPgBGQqZ9JTk0YwCbrcBEBCvTMf35tIgKBVg=;
        b=NM1n+dTMibtpqiSwYo3dXruXdfQYDLu+X3Iu6CuveCSzC8ILWhmyvqSE4ZzDUIJjwN
         v928e5rUdLS0FSBA8UQ8d5C6bppOxGHYeHFEtMEUjS4LfzG83W8NVtWUHT7j4fYmMBpc
         lV2nbTKVKnhyX5gu5wbOhgKVhAunUKACkhIiGjL9It98KrD2NaYvc2Rr3i/EAEeX+nSd
         NpFD5X6zzfeUQi2cZEcyR7lmlTLyDTdw9AfwH+HphRkdprSQLagaHzEgF35jft0fmZSn
         BOqBOUOguDI/Zg0SXDL5Vo6ft/uUD5MNPfV2onquw8o92hY4i280WliGUAJ4+akgey32
         zMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWMmtBAg3HO5G27BtM++3UvBZO7UPxqtN3o/DgiizsjbwURLDuWnXllphGpfCt5TlRdIk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfB9Ju2BpKK36oVqxmGmGbQPqdBZpDC8lCyxhy9B64W1JOtE7
	WsC9ZOxNB/lLSgoyO3KGWY1sT7Hk6ONbXc9QW7MyTBwhL/BXoWlMmSo2
X-Gm-Gg: AY/fxX6bOpjqD0qdmhrrppmrULe6b3Bw1N/lZSl50uUD8SLjZpM8PfVGw/+XF14bP7g
	aUbEtH5pCfNEJHbHWFzflL6J0BHSZRsIHQNisIF4idw1X7UIDjQkMImFcdmcsbsdE8ZA2BvwvEs
	hRY9Q1DU+k+0mLKPxXEO4DUVBNwjpo20uKPpumib6LBuXz61unX2RIZ9I6wfOo4nwO2w+C500Aw
	Qsl0iCEhgKOyyHob/FdD5dbNlOWZUqGIxScD3sEkmbHGVoWBkIRG2vRehapkW0Q/ZNpwaSw3icx
	ocRzZY04uwGub9SAHXoMJWkzgckS8fjV9p+SSDuHnGbqYqDc30haVE7pTVKeyPQOTS8E0t6Fkmv
	74hmBevqCjyd61T28blR5fLFcVJajCVT4UXU7gfu/YGFNhBfFTGMiTRZO0Gyv1DjmUbn0ax/Amb
	7ca/IQQpizknOjb+Z6+A==
X-Google-Smtp-Source: AGHT+IHh2+8bf+lLxGiq4ZmcFmxVSzU2krL6789my/Uv92Ard/irM18/tDYIcl2ke7iyrnqPtjylBg==
X-Received: by 2002:a05:6a20:72a7:b0:35a:80f2:fa3c with SMTP id adf61e73a8af0-376a8cbe357mr46833125637.31.1767532635996;
        Sun, 04 Jan 2026 05:17:15 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:17:15 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Sun,  4 Jan 2026 21:16:35 +0800
Message-ID: <20260104131635.27621-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104131635.27621-1-dongml2@chinatelecom.cn>
References: <20260104131635.27621-1-dongml2@chinatelecom.cn>
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
index 5829ffd70f8f..47eb78c808c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -110,6 +110,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -251,6 +252,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
+void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
new file mode 100644
index 000000000000..398a6405d00a
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
+__jited("	movq	%gs:{{.*}}, %rax")
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


