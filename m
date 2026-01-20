Return-Path: <bpf+bounces-79563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B167D3C023
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5710540B2A
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867E38B993;
	Tue, 20 Jan 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjTn3U7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C436CDF8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892798; cv=none; b=fWFFniYzts+9rIpl0cVKaU9t72VJGM9PMnpoIEypBwr9jlqiBHcQ2PUK2DweyLZPZiBbtWMdbP0wyun7IUa4jtriZk9Da6rp8uRnaylEPYi3awZTy4JFCVd4DN2MMTmDK9gvYwBxdHgPqKPLnY4gj9UmZ587Pr/k/rFGE6LELoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892798; c=relaxed/simple;
	bh=N2XC72YuwbVooj49gSUC23yr6OLWGEsBRVB0n5dcYww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjdir6xXg6mUTvTGaLLsabWOcpCmgVp4fWPu0Tyq9Yfdctm4K+Qv71WHdT/nDewWO7HT3D3541ctkSbvibNGmJYSCKcp4IAQoceAD2KNEQwObRMnodAspNXmrf7RH4cnM5pYUetSWI3SXVNr1u6nf28SUglslaVwJHjNx3PBXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjTn3U7R; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a1022dda33so30900635ad.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892787; x=1769497587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8e96Wx1n0qpGbVjK3mBfOV2yV5DDoKmdYehuYIVGJg=;
        b=mjTn3U7R+YpbF4E4Uwyr2sfKTXoqfgg5d5jg4DI9l2NI245ny0GbuiRF7Cjo6IbKjo
         tES1nUVdTFWq4JMrC5q6EoL4B47I1S4FZ2Iu9oJDXTVL3k+juLmQ9V2Pu0B/3h4XUtMz
         idsKnU2a3Tb4Z2nb6eKlWwA4Z1sEWHCv3z6VfjBYJWdmJfHTr1Zi/xEpB+6dtsHgXy3n
         SBnXGJyhDDqISt4Co3atOsA4tnnEsJFQ1TcPA5Xkgaw7wgDSApXOBz/BtIiJCOU0oB0y
         hjllQf6aSG9DFXX8+gsxS9yQzQzVGq5FhS5x5nsMUfrCOGAa4TMf68f5VdjlREkS2x8x
         kF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892787; x=1769497587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8e96Wx1n0qpGbVjK3mBfOV2yV5DDoKmdYehuYIVGJg=;
        b=jTE12Sy3N69mwRPPruFDEqsC8Lls4bN/bV1h7zHDfRQfmwE71VdZz6nrF57EYV+02w
         UeY/D5CSdDVS1HG2SCLlURGIxrL/iRsZ2nAm0cckbsrQLSonmxVVWUobAvyhYX72AxZZ
         lNac1j+YEAYEplB8AqKNx91j2RhAh07xwM/Gf21bgUiL5tLyZY8CbpECV0x3qKHt90BL
         Sqs7yJ5uH+rFL0K6TvmxG+nW8EQvVnp7Wo9mswXgk5lw9sajzQ+vjXVS2CMIKc5GHPTt
         GiVzPaXiQezZ6XhmHqiwO+rKMdKMW08awr/KRgIrQzn+erEGicEXwgBwo8P9leS1dF0r
         +2kg==
X-Forwarded-Encrypted: i=1; AJvYcCVl9ey0IJ+fEG11iMXJCDuAXx0BYEYyPIi0bR9FKdH6NYeTGyesf+Audr+S0uICWWE9gI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ShPdwPEOSlWR1zq0H9rzzifdh5p3Qz+z3hj2R87yZ0ntJqnx
	KI66Gl2KOuB36+X4frG0/pgyl9iiGXLUOR5yeTyliEShXgIfHiC0wBUX
X-Gm-Gg: AZuq6aI3TjF7YYK//odmZL99+TnL194mRYNKZgyRQptzfUWpR++av3UPnnS45ayeqQy
	alg4Aas7w83y4Pb4jZHUsM3+f1BIqdn4hOZP6obJQMQmLaX667jaVf56fiOrKUALTzFanPNCKbk
	m8QPPeP0rVRv0Ndxza72V5fm0dg1HoAMjgHUMz6JtzF65TpXjxVno9qtIYUuZKLr6VV2MojDPJq
	STVfgkujD7NDHjVHgp0L5EjnEIVHFSC8KPcs7a3i0MCNriXGva4F6KBoF4HTVexs+RrC2b8+YtD
	nZHSm82Zrzkq/1sp8xhSaILs/xgdAP6CoGmdEN+JcsJB07gN024W/rjXdm7ahm81Ahc/BMZfO5J
	g/4kjrmhn26DQxZytxJzd2bWoh6JuV1+2EZMddTmaJNWy/V9qlhQHN/ctwHJG8UUFayM5WTi8dw
	ujqwlIBVSd
X-Received: by 2002:a17:902:da88:b0:2a0:d364:983b with SMTP id d9443c01a7336-2a76b39df9dmr7779905ad.60.1768892786963;
        Mon, 19 Jan 2026 23:06:26 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:26 -0800 (PST)
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
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Tue, 20 Jan 2026 15:05:55 +0800
Message-ID: <20260120070555.233486-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070555.233486-1-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
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
v6:
* remove unnecessary 'ifdef' and __description
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)
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
index 000000000000..4ea254063646
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_fentry_test1")
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
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


