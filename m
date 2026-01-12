Return-Path: <bpf+bounces-78534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8DD11FD5
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9975D30533DE
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118333DED4;
	Mon, 12 Jan 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm7rC8+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB325B31D
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214752; cv=none; b=pVaF8WwfV3KLgleV6IL4lK9cYZwdlwn935XKu26BYrv3/sJ5rDU+nzxj7JmWAxoW9nZ4/DB+c2ksGSjNkUmXE1BZEQ9dTY7G/ExQh0PIdlA73Cipm8tRvJEqNNL4dBpkyKl8nQBbonMkzV4BurgdbBS+4r4L/380q2EEq791Lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214752; c=relaxed/simple;
	bh=FctuMLOWdPB2KETKqv0GYttuTULzaHfty9crA5vDYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAmp0b1CZSEhiTdoTSdaUaYThMwNhTq9wpEW/eY0rW+VbdgliOHZc234oMgxfy3qxSacgUF+Z5V0OVOkKWG5NqEaQSR/kPPYUdw0L3T5v0us4/fo2kKfgHIC/ID7wDXKhWeytS6RR7ulYb9lwHHyde4BwjNOo66kx/tDSMC/d5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm7rC8+2; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0d6f647e2so62932625ad.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214751; x=1768819551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl/AXVati0RhQqhH4MEINBt0YenTEWtEVHqv/M8mNDk=;
        b=mm7rC8+23Wa2oeMEWx0GAwY7PX7VXsujPOC+GLvxi9tV8s5WK3tgElNI1zKWKc8+kN
         BHT7MRgurd+lNIbkfjtYH6OOvnNEH8ofOLZ7vs1yMKh4OdRFgWozzZD/06KAQXYzax1Y
         ePU0DAVxqjG4j2TOW3n9YtCwi0vyPFH71DUQGglx7NSKKGPaKBQ3BMUicxXoPfsNMiVa
         XRQ6z6c17GnO/N7+iXA4eTU8uURiRRgOr2EkUBkTMYaK7kR5gIX7zcQNp7qcsT1gvBCk
         hXfSqzG2WQr9hgSxpSzb8yHoLKH3I5tzlxXOPgI0azOqNMb5lz2h4XO0ukIqVPzr30tR
         D9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214751; x=1768819551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pl/AXVati0RhQqhH4MEINBt0YenTEWtEVHqv/M8mNDk=;
        b=MFv0+54NlPKMRLTcH+J1ikI9U7gCiF2KXPauJcZwKGEeTdgC7FJm4UCUjlFO42yf4j
         fV62npYQp5HlXke50fz5uRINZMSuFHh6AT3+91z5I74OTND5igB9NSEXD6e3D6JjB8/s
         QxTsoaGG8peP94zcoFzE+J8q6JWX3uapdmLLYMhWn4RgIvnkHfj3g5tnc6oRbxUaslgr
         mMc+j7xWOLPXxtsngRA6zslz9/D3HixWfy90lGxhK14HT4Vf/pD7aKyGo13mMhNom+Hd
         oE5/LxcSil3XbddjHNbGVsMMEP/odr5adqWmZ31GqC+a/jLQFk802RbpvIls+cu1glI5
         yUOw==
X-Forwarded-Encrypted: i=1; AJvYcCU3+5UlVx7DbN+dXiqF65VK0AFzRcwpekKfg5Xarr5Hj5Q8uwZErmSCBRinoJkQmu+B7ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPruwJ1R0nMJtbeBOUJiHq5afH1B7bIH45338YV4JcdkebhRG
	M2saGPhUFOMdPu2EDKdjRp51LEg9Ujnq1sOPyLTvaFhCKV0p9eyrYJIL
X-Gm-Gg: AY/fxX7ocCLhIUFIpxDED/8ZAiTbjkML0//aINOYk/CkY8ZjarJ3kR8JufjAmtLs/oR
	sQRMJVKxR5Ame2kAYGzpuB9Pj5FR3SS98jOr1oaXiPB5Ul5SXR7Wt0VPNv9ZgBJlPAXtY2URkky
	74fLIElJlv3RcYk1xWhVrXm2wEX58g/19CMsqyVO8NgbqGDw+GLe/KpGbgvn31ufK6xQDSX7l7c
	yoskVhQrKOX1bnp3iN45//hBDgX3Otfpy5hje5YTipoDfRNb4lWMuIjQB7d+e3C3euXEuA4K2O5
	2CI3y68do1sUV7mbptRv6zLQ3bK5mahm3ulEag23AvZiEIysREsi2HtnGItInofTlVdjP56Ybz/
	MKWDAiZdjyY4QNLqmz2x+vifiFqYYVaISS/uOFWL34tz8n82TEXauEGCUmmFyzxT4i2e+0FIGZs
	j5bCnZZSg=
X-Google-Smtp-Source: AGHT+IGBW2CRWrtwyacUZsl5YgLmbet1+VCuEiQHvwANEzzhJC/Pwk5wY/VYTlUedfeKRQw8hYzTbQ==
X-Received: by 2002:a17:903:1a6b:b0:295:8da5:c634 with SMTP id d9443c01a7336-2a3ee41354amr153710185ad.9.1768214750682;
        Mon, 12 Jan 2026 02:45:50 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2df6sm173551775ad.61.2026.01.12.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:45:50 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Mon, 12 Jan 2026 18:45:29 +0800
Message-ID: <20260112104529.224645-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112104529.224645-1-dongml2@chinatelecom.cn>
References: <20260112104529.224645-1-dongml2@chinatelecom.cn>
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


