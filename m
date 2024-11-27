Return-Path: <bpf+bounces-45759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B39DAED8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4D1664E8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09C20110E;
	Wed, 27 Nov 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfi5X6ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4E2036EF
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742435; cv=none; b=DWiHESEYYgn0LeJeW7FTXYjsZpVgww5uoSC0qyDu9ljbZv6OwxoqofBKIkTTzEHO254fp++CmhR58Es2j9yfcTiQi3h1uQftn53aFbdWUdKKNcVDJBOcm9E1+NeHlQMc3frmefCkBPg16P5Mxz6i04k9CQ28zGrIjYunzx4M1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742435; c=relaxed/simple;
	bh=tvGcCg9wXHUdXfXGLZyEpOIxvEX19bauCQBSJn54EQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgqSQN1XE8btod8Zbj9J9weidrlflnJ7aMHwJjLKgk0o7r2FH8VwhVV5+H4ZSwdMKsdd5siaQ2MczwSKWg2rDRe+O89Ta6Mq/qX/QuyGLNfDEtqFGJSY3PCLoFNCEOHv/JBKjnDECnughgcOUxY83lvJ9cpOn+URDRoI2VV8RXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfi5X6ko; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43494a20379so1071945e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742432; x=1733347232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6xUjyAmVSqUk1j9DziwbvTTczoV8UVWym2vkF6YOIk=;
        b=jfi5X6koMYUgDGfxEGDztpg5ta23zO3Xcb4b69E3zi79THBw2MYddK8UE6wJs6Gr71
         9bQ9Ujo24VZ+3orPAR68UFfpSw8/e86fQ7B04r/D58SmRRbXQ5gutbvAZm9ke2YtYcfQ
         uXoo7GT4ncKYQa2J4iEb0x4o01qhAcV81gTpXZrJJ5rKL83IdFheuGIoQg/O+Y7Tsaxx
         ax8Pgo2ouA4QMpzhFxgk8EUdJIxHEnYmHdYErQLjnKjl2MJuNu+GVZHpm+qu2coGuqTV
         eouwNfPizBtjsj72rgqNw0B/c1h56W8eQiB4OPMpHirdM9+0WnvL85FaTpBqHlSVhrbZ
         n5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742432; x=1733347232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6xUjyAmVSqUk1j9DziwbvTTczoV8UVWym2vkF6YOIk=;
        b=NFI9qr+kpQMrJKaKP6FuIoj8ASh9ipPh7uV9Y6yShgrLNRDkSARCj9j25SwMz66euC
         00T/+sbXzrG8yx0z8gBczp9IlIcYjXjAUPL2PsHdFZfEuNP3aPPFRvNXNCjhrPUvNGP+
         2tIimdret/WNWDq3CWxVB4WQxQFUUpP+1earn63Y4qzXjNxFjNRO82oUojk4gh0r1hAb
         5mf7CvuxrolAVDEIkV9b8SdtxhmRy4yKWCBp2oCHOs23AhUpTTof34ChmFc3ApuqlqqQ
         0BLFtKjX96FNdsZxFkrdhpedfGEhSuen1W13BHTdfTNU7gDonWz/4L2GEikw88xx9zH6
         kGWQ==
X-Gm-Message-State: AOJu0Yy13rjYen64YmVHX3cKmNmEwwAoGOQ6T/sLa84tbIr1zHXdHaRo
	CCtuff2c1b7KGigvS/B3nAu9t8rUovNwC6bhQHUzivif0iv9XSvETz5gHrxDVnQ=
X-Gm-Gg: ASbGncsNPvE22nUurgl2geMuR3GlLa/TNRxajRAMMTWZtSrf7ozH7PJIPCmcZAAiGK2
	uJK6MJGJN1v9THREdq/xqYNNb72Pe/BUuSiFDCOFTCz7SkODteiYFuZdlqIJ0Wry8cQXFn8Ov8Q
	5hNXRtcoH4HnVgw0dWDqsUgGQDRQsHhPkqpOwqmkRaGOJaFQKdfdWScKEfKWmrA1nDELq/JoRmX
	Szt4XPIqqbEDX08DQpe0gJg4Z7uHO939gmUcVlua1HQLzAWDfFEAVyEzlyNqmZDXJ51fMthE5J6
	EQ==
X-Google-Smtp-Source: AGHT+IFkHfcF3MNVB6zKrm8Uc/6Py+Ni2bYOAcKprPKBkWOzkFy0ELpnfkNcx/Kd+Agcii0ZCWuvVg==
X-Received: by 2002:a05:600c:4447:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-434a9dc3c8emr43531195e9.8.1732742431753;
        Wed, 27 Nov 2024 13:20:31 -0800 (PST)
Received: from localhost (fwdproxy-cln-028.fbsv.net. [2a03:2880:31ff:1c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aca7eea8sm20297305e9.34.2024.11.27.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:20:31 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for reading from STACK_INVALID slots
Date: Wed, 27 Nov 2024 13:20:25 -0800
Message-ID: <20241127212026.3580542-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127212026.3580542-1-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; h=from:subject; bh=tvGcCg9wXHUdXfXGLZyEpOIxvEX19bauCQBSJn54EQA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR40BFAsP+TR7VQRx6S91V8avBnOH+pFhvad3dIfV nQuUe1WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eNAQAKCRBM4MiGSL8Ryl4gEA C4vLtcZ6eD0BHmRNf6dAjLjZsT5QASnk4FvdFtB8JbET5rCAgZIc+3TRF/Yp/A3KJDRbSvur7YlSnT M0UNiSlKoXxTLGxPqMSlQfz0O312SKEN8/Cn6F03b9Nlk3JT7vXcDz3gGuOUXO6oRKWoTDzCjZ16hS 4LX/AtNOJabS4vCed4VYX86in555NuKjsNjhOfmRDXUR7+ONxuR00sklH4yAKQTvnPF0hongmbQMlG b81Z+SJthvxkmRboVzyor9FAJnhGf0m03rUPbDB7NPmQDhNhJ1EmXWUlQAZciiMe5cm7V9EHdJXgd3 tyCYxOiXoHVWHtomwrYYIsLPHtKLGUhQerSGvhuReKKXjDPgiKrkM3obtlIx+u5VoB6iVjUUEemZrL jDh5bthk7ZtFWzov1XaRhwdU2+gYrMKk4HyWwM6O72+zhIeFdBp13xqDxqnNCf+9SHGwUWJLJ3cAZC KEk5CWf+qTY1y0hQIhZjkQ7ieB2JokPnlEWPtpD5VhRYK51n5/ac4SlVGnv4uSbyKHIDdxOSddcEo+ I9mP/Xtn9OSp6sF1ETJnI4QW3h+LHcq6YutugyO+32ZYCUVGKuGnUWZT+3qnZePYuxHlFM+tXXubIE fgcmCtfy11jqZ/VMTFJKo+/dQxvyLF0kl+8c2lKv+1xZCUefLUlmptTuDn0g==
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


