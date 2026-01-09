Return-Path: <bpf+bounces-78283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F66D07D33
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4C530B3D70
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908F340295;
	Fri,  9 Jan 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr03BBhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9733EAF8
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947230; cv=none; b=jAvaumg6oHTV1rGOfgrq/3vSjBt7XaBm9QHjLc1Crsa/tv8wd8ElAV9mwxvl97aOlyV6kxZW2AyJqGrvrtZc1arkvU5w7iM+42tpyrotrpl1njPiPpqCgrWzZCrmZImrfZWYcgQUkU4HgRfb27raJgcvzC7wi4nVUXJW7A2GVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947230; c=relaxed/simple;
	bh=H6RlTHdTsIxmL/QrZ3PtuCimaAKVXgnmMJvN4Lq8+34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ2+v3hhG5KggfhUyYkZm3iddv7jffdPYERF0gdahgWriOzkYqGQqhMkf4U/tavXYOEiTbjGSwy6BASDeI17DleC+l2b/jGk8wYEY/COr+Bsi2Ph/zQhqU5K8wswPR0fA/tU9KZ8cnaaQ8TrvVBjwmvNQQy9kMNiM3jBn9tC3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr03BBhe; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f1bc40b35so46919355ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947224; x=1768552024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+3rjUy5W7J8feKLouwr/zYB53Or9ZVm7jy6zKC25BQ=;
        b=Rr03BBheHGKIJZZ3oIYLwUdB1hB9GIEP7MVmO0+MzkgN0e/Q4aAuDFIjZjQMXLhIIX
         3YwXUBuyDNWFi9U0fc7WuBZhdURwhWPGsQBgtPjQgk5VcJoVma2Tj7rpfvxXmLyQQj+9
         83LwTQHxThyShALgjzmeq5eWZCEwdh3R0TYxuqHVTSyFMCZkUh3VdEPOb9VNSildsEOD
         AOesoj7GGnGQVcRY/iGzzWXDOAUdXugcHBnKaWLrVHzw0B6De0Vz5CrV+/47iivBZQ2z
         wTYd+J77u5MOJQ1tnZLU+qizrsT6wa3vp51WMJShvvFJtQ9nuoRDDMc/VZINKMdDbMVx
         m/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947224; x=1768552024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+3rjUy5W7J8feKLouwr/zYB53Or9ZVm7jy6zKC25BQ=;
        b=gY7VMq0YnaZvOBB3riUGKne25urfgimX0SEc/xsvBsrRKNEjhZRpB/vDKthBGFhruI
         aySxOYrzR00XoENil5t3NyfRCqDmQbydVbcOOTW5BylpCRiXdoFdRTxB6eQRudPC922a
         mEpFBdJpLShyOP0lze/+VDBVOK2blbr+nxrUiM0BZPAb1nKP+dPNOZiKQAV+36N6e2Ls
         e8YNF3bibTKDtAywRMrp/5WcgjKBhY4fAKWnt3nF9Eos5GnqIqfaWMu/vSv4qfxoH4SM
         oMOOSUlgWAlK1MW98XLIEObFyl8bX9E/FcBLnfkEbKOHN1dZcghFdKoNyQx1r4FJwHb2
         /oWA==
X-Forwarded-Encrypted: i=1; AJvYcCUInP6RJHVEGMixM+T4AVxpSjEmtiHM+/twofAATCO+wSlmEhg/aHnw4L5OBSxBQFAccKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8d1s4g0AGCCNHf52mSLaDILADOe7oQkgN6h8X6BEoAKCACOn3
	jtQqNhH/OAN3VA1wmQ9GbuiM7LzTQP5TKzCZfBvAM3yDTK4EjXgmlUXR
X-Gm-Gg: AY/fxX7aINFhEFTa47E2QGL754S1ZAky8lJior4Xqc6ZAVnqMH8rMGK110zV06/5ZEd
	sW9aKSQxIVqtyivdUR5lxQiHXIUhWWLEZ3D5DqUWi0FMKfm6E7lH+s12UUN9gXWbXdvtxSLgTQS
	2zVghik0PecSxIVeXxZnUfEoD7ucssKDG/AmdV+BXpfDHdlkm2JLWRBvjjTq1WkAYI1v1VdmevP
	GZf9m88Tn5R7XFyg7qDNXlo0khPjxg01tUacA9Geu7HXp61qJcjPj+hOcxlQw9zY9axYEHoS2km
	pTP69T/ZiggNDGw8EnmpkPuQJByXGSnkciZa2/ftdQ+B4NNsv7g8EX/PLuHPrud3jkwXEIDG8mb
	t6n9JhTwQy25dc5IbqjsT95DbN6GuhfACVDKdgUZ9+4ZP23YdnOX7/yhOBoLOMumwpQvvDhcFL8
	urPzm4nm4=
X-Google-Smtp-Source: AGHT+IEltGLhe2yg4ioG7LN6ksVdU9p/m/3uoHSucm+2yRtJkmtDuPTTmjCVI27o/gGn1BTAX+PVZA==
X-Received: by 2002:a17:902:f541:b0:2a0:c933:beed with SMTP id d9443c01a7336-2a3ee413581mr91024725ad.4.1767947224475;
        Fri, 09 Jan 2026 00:27:04 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm100104695ad.67.2026.01.09.00.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:27:04 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Fri,  9 Jan 2026 16:26:31 +0800
Message-ID: <20260109082631.246647-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109082631.246647-1-dongml2@chinatelecom.cn>
References: <20260109082631.246647-1-dongml2@chinatelecom.cn>
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
 .../selftests/bpf/progs/verifier_jit_inline.c | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+)
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
index 000000000000..ba37c0841f1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -0,0 +1,36 @@
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
+__kconfig_check("CONFIG_SMP=y")
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


