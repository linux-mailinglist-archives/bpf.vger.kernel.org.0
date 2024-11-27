Return-Path: <bpf+bounces-45741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E979C9DAD65
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52227B2204B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4820124E;
	Wed, 27 Nov 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwr/KJ/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF72010FF
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733505; cv=none; b=pAeXLs50A/yAgcRhAFlocH9+NiAxjxZMSsteRETRB8g2zsdhJICXvQJHAXwzSueQnAicibLJccF4XkXunzgf1Js0KzrOqpHXo9vdFKMdxSVdL3Do1mmzXDPZXMROBhi5twSYPjmGwdTlgsONtL4a+QSeJzxbH9ASIMyqCPYQgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733505; c=relaxed/simple;
	bh=tvGcCg9wXHUdXfXGLZyEpOIxvEX19bauCQBSJn54EQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP09u/EzBKUwY+djNUTfEU9KsbXCu3/hn92SkNpRP/4jQC79qd3qIU5AQ0o/YO85ZDDTDT4hTqrG37gRqo+PplAq0PhG4T9TcXN8NMUz0wK52A3mmbxxZ7xP4rmQYy3j/rDAxdCeFB6QL9Cz0FPeiv+0MpfCQmvV+dX8P4uCvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwr/KJ/X; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-382411ea5eeso70027f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732733502; x=1733338302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6xUjyAmVSqUk1j9DziwbvTTczoV8UVWym2vkF6YOIk=;
        b=Wwr/KJ/XZcemXwpBjReBNQiQihD6pSu9U4XW0v2l4zbJnCsc9U4E6LHDvdCgddJirJ
         8uPd7050iKg4rj96NrhpCFpNjozbxClLPIj8WzYwOinVoATNiTy+FfSR7/qI2EwVESur
         wuDwJPMhgRBsFSHSDBkcJOABEECQM3MsJoXOwYMKNNHWGh00kxrvGlAUehaz4Xct7/wE
         shdZgx44zVyORpTXbxfz38kjbn3221C/My5EKymCWibHrIlFzmhCySplos371DN8judt
         7QFRcEbpL34aU3eh9RCA4Twclf0QPSellSCtSB1XX//5sbPj0AJEM7l1K1QhIcV4mzkd
         VRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733502; x=1733338302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6xUjyAmVSqUk1j9DziwbvTTczoV8UVWym2vkF6YOIk=;
        b=ZYGvmWZMrJSt9SLc5hNunMpR/Lo7d5PvWbTyobUpd4szC1Vf4mnJhJSzlDajOwq5ZC
         27jodkbjSyhj/nj0zXrY/wJdgWdxfaFogmQab1y0kREgXhI3Ky9xUvrizu8yQ8AoT7wX
         BpDAlG6o3pu11zVqzIi6Ru291NL1uz26S9n8JddlqQfHsbFnjbUzdHaNOm9+3ByAz8qD
         dwrGbbH/ZXAYQt1ddFmoTsaJCDJOPX/7UXL6SypDLTFuCRL2M1Oxvggvrv/6BB0jqMVE
         c6AK3xSEUTXrzNx1ja4aRLB9hV+uBzrNG9/oAiwZVK7zMJjupUgu9G5xnKHmLaXmtm7O
         qHMQ==
X-Gm-Message-State: AOJu0YwPEApyoPT17V+9+TxnO2b2IgsZUo/HzZ+QzT95cNh6fHpF8+ja
	76B2QJIdre11pSFUqvOwLEhrAlqUUi75uqEz7Hg73Yk2vCivfx3NuYPGpxTBzSY=
X-Gm-Gg: ASbGncuveQaiQux8MVQVwYRQkBpUJtL9sfVC2YwbHcjdt3T7em7APfy4Ucc/9pXEzMH
	pjUI2XRoog2Sh3juR8PSu17oNqe/0O8CFGaHluBtQLLe5eB3K805lGYnR0cJtLYy1Tl8PLWp+jp
	UVMveXoWktQ74oAtT7nU7MfE/DgrSYfztl54QSmuWHwT7lwO5CTBoI5aT45K9CpiWxVU3kFtFm9
	NhEUY6DsEzp4y10k/D5twXB9OgReBjzhGwzfzu79AzFTK9KTIQyiFjtirIXnAlXdlRZT4Vm2zIm
	hQ==
X-Google-Smtp-Source: AGHT+IFcgFntEO+srj0g4wVSF5V8cpXEatTV6SFWIdY6BK2GjpaPdTqLdPqlu5hojqK5m7n4zS/T7w==
X-Received: by 2002:a05:6000:2a2:b0:37c:fdc8:77ab with SMTP id ffacd0b85a97d-385cbd7367emr470073f8f.7.1732733501594;
        Wed, 27 Nov 2024 10:51:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-037.fbsv.net. [2a03:2880:31ff:25::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm29775865e9.9.2024.11.27.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:51:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 3/4] selftests/bpf: Add test for reading from STACK_INVALID slots
Date: Wed, 27 Nov 2024 10:51:34 -0800
Message-ID: <20241127185135.2753982-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127185135.2753982-1-memxor@gmail.com>
References: <20241127185135.2753982-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; h=from:subject; bh=tvGcCg9wXHUdXfXGLZyEpOIxvEX19bauCQBSJn54EQA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR2oyFAsP+TR7VQRx6S91V8avBnOH+pFhvad3dIfV nQuUe1WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dqMgAKCRBM4MiGSL8Rys/rD/ 9IVcf1uKJKt/yXZEA4XPAkWGguuuXg5uDM/vuMTIoqkpr0ecMNr17VRad0XJXVuybbVz12JRNhzTmz t+u6ef6M+BibT45/pdbZ0cibtGeJgH6VcbAgtYK2tRxTbO960yDiS8FhBObWJaujrYSihtdNbElK2M hK8l0fI5/QxPvvMdczZzjk1lAZjdlV8Pq7Hm+8KXxvhcZM2pqGmxlBy6FO+/DLnDHHZW8S/j5hZnx3 Qhj3E2elnYo+KRFzTtO7WlyMBO3QAHaM1sFV5wyUlsFDmQ+ncAf33K+QHaWpKz7YIYwUcfjDpGAkOV n4bxzSHG05cJfgvFXKxg0IlrPuFBMhvTValnYpldFEN9Y8m4jClsPdUA9kEuq1X5rCaz+8mILLH/2r G+zB9dOIOva2uSXfSfALWFxNKz+Tv30ABfDpwj1x/vebTOE8GesCdPF3MlEfLCJjuYESMYKbxGqFdQ 0Bl5+kNGrWbiy2ne15BaqnVneyaqPSsTn/biQmkFfZFKTxkCnsjEfYdpbqD4BzDzYHbVroe3bEKLtX 17JswUDr/8kJ6Fw/7kElZ/rKn7Kxjt9QdVudXRAfpUPP4QWZf/ZgFQ7bjGbGihcQLRttiuNcSD+ShX K55dawjSWxKchXxEP7UYoBsWDb/3EjOEgm6xLiRILVsoTPcha4o+8UjqULgw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that when CAP_PERFMON is dropped, and the verifier sees
allow_ptr_leaks as false, we are not permitted to read from a
STACK_INVALID slot. Without the fix, the test will report unexpected
success in loading.

Since we need to control the capabilities when loading this test to only
retain CAP_BPF, refactor support added to do the same for
test_verifier_mtu and reuse it for this selftest to avoid copy-paste.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
 .../bpf/progs/verifier_stack_noperfmon.c      | 21 ++++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9f65adb456b..aaf4324e8ef0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -63,6 +63,7 @@
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_private_stack.skel.h"
 #include "verifier_raw_stack.skel.h"
+#include "verifier_stack_noperfmon.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_reg_equal.skel.h"
 #include "verifier_ref_tracking.skel.h"
@@ -226,22 +227,50 @@ void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_pack
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 
-void test_verifier_mtu(void)
+static int test_verifier_disable_caps(__u64 *caps)
 {
-	__u64 caps = 0;
 	int ret;
 
 	/* In case CAP_BPF and CAP_PERFMON is not set */
-	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
+	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, caps);
 	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
-		return;
+		return -EINVAL;
 	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
 	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
+		return -EINVAL;
+	return 0;
+}
+
+static void test_verifier_enable_caps(__u64 caps)
+{
+	if (caps)
+		cap_enable_effective(caps, NULL);
+}
+
+void test_verifier_mtu(void)
+{
+	__u64 caps = 0;
+	int ret;
+
+	ret = test_verifier_disable_caps(&caps);
+	if (ret)
 		goto restore_cap;
 	RUN(verifier_mtu);
 restore_cap:
-	if (caps)
-		cap_enable_effective(caps, NULL);
+	test_verifier_enable_caps(caps);
+}
+
+void test_verifier_stack_noperfmon(void)
+{
+	__u64 caps = 0;
+	int ret;
+
+	ret = test_verifier_disable_caps(&caps);
+	if (ret)
+		goto restore_cap;
+	RUN(verifier_stack_noperfmon);
+restore_cap:
+	test_verifier_enable_caps(caps);
 }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
new file mode 100644
index 000000000000..52da836d47a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__description("stack_noperfmon: reject read of invalid slots")
+__failure __msg("invalid read from stack off -8+1 size 8")
+__naked void stack_noperfmon_rejecte_invalid_read(void)
+{
+	asm volatile ("					\
+	r2 = 1;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u8 *)(r6 + 0) = r2;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
-- 
2.43.5


