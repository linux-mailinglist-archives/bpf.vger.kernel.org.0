Return-Path: <bpf+bounces-22175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C1858532
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEF1C21579
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBE13664A;
	Fri, 16 Feb 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIc1TyUp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1231353E3
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108117; cv=none; b=ULVmyuTNrINwwc/qgzJjMMsNrPWnfjZRR3IXxlT5zpGOfAUwgTuPPkT4hUlWoplPAqgIIt3CUsXzAT+GpwHuuXKo2V/LN4fxBGlcSRSBA1gKLKW92swtwxx87DXvARyicI4QnjU4uDgHFksAC28NJsrBBYo+PGbtHczKQ/ydulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108117; c=relaxed/simple;
	bh=KTe8TTn61PHdRdm9IZntcFGZSt9AFdFfe/n5+cGbFXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmWuwarfJaawSzV+6sOD5GbI8CxaXv0JrxyE6W4HnQIcMoKCMTVMtb1gaHYKw4ypl9+gIxnh5NDEdKy1AnsazLgfNMaWJiPteKyHKlc1RrXIpavqwqnBWHZa3ZoSZw8ta72ZPbfiJva3WegDg6L9+YTisoMYCRVzCX4g0bY0v6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIc1TyUp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607f8482b88so9505257b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108114; x=1708712914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G79hzAr2MLkGD3YrTO0PpmHJL/LDW4tAIMGoSOZofWc=;
        b=kIc1TyUpiw+Aq2wXO84m9rSzZUTf1qLhaS+Z7SSSMslsDHXhuNxigMOSdlUwBFC0ol
         sJ8+YUmsURmnrLJ9+bbCks3+YtmMQA0booSzpw6h9iTOKzkooUmbkZqYOtECNWOe+qAD
         zpngfhaPcW6+inzFTOzBNkCZLn1YyRAuXFkJ11o/k7P+sokQZuZKqqkzNAmw/5AVRvYF
         IvDQYxE6c1JNJHYDKRTsEB11Ut6wkNU1DCCYZDl+fkfcZdm61f0/AALXzvqOG9aqhoFs
         DD8DHI6QZhaCup3t+z8OJkQRld4N67L38vCrVvXNNxGhw+aLAx8ns19fUwhTmPikka/d
         JPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108114; x=1708712914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G79hzAr2MLkGD3YrTO0PpmHJL/LDW4tAIMGoSOZofWc=;
        b=Z+YAmTuxRAb3QDfoqTFB+YWvi3ZZiGF0kOf1znW9emSS3DyQODUPxRe/CDzp8HaVRv
         r1NF35lxMiw0X2OyA1HKXhRRbeab1GpXqpV3ifL1vShdSunI6pOwQyAYDj3GLNxcGhiP
         G2fLoxvkK929EC1S4GLoFUenNgrsSIiDeLbglc2ef6WpNn4ReiZ9CVnr0Bdb27hVnvTa
         uebWCHGZVXp4a75evC2HW/EJ9jQF/EkrG/U50nF9Nsno27hUJOu0+g2T+aMVsdEDtyaC
         3Hi1+WU9EAS+t8GF8e5+ulGQBiN4URYc/7n5QTpgf73pS7jL5u5BtxxjfymOILL7yVM7
         /tYA==
X-Gm-Message-State: AOJu0YyixrQzehpSNIeqWrLk8vOeNGce3VQRMr1aKlbfKAIxGaqncaAZ
	vtwmfMxGLp5zgtMHD5k9E2J4LTV2e7uBUc7ICUltMTATIj+pyl4yweo2If4M
X-Google-Smtp-Source: AGHT+IHFYw72B3jaqW6rYI9uk0pCWZ75qLbVd2BxlmBaiv40u4PTxljlFROo5Ka6sBmvNo+3S/kgwA==
X-Received: by 2002:a81:6dd5:0:b0:607:cd69:b1db with SMTP id i204-20020a816dd5000000b00607cd69b1dbmr5726451ywc.46.1708108113991;
        Fri, 16 Feb 2024 10:28:33 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b00604a3e9c407sm436190ywc.41.2024.02.16.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:28:33 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test struct_ops maps with a large number of program links.
Date: Fri, 16 Feb 2024 10:28:28 -0800
Message-Id: <20240216182828.201727-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216182828.201727-1-thinker.li@gmail.com>
References: <20240216182828.201727-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Create and load a struct_ops map with a large number of programs to
generate trampolines taking a size over multiple pages. The map includes 40
programs. Their trampolines takes 6.6k+, more than 1.5 pages, on x86.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 ++++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  24 +++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..3e6481b2a50a 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,50 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+
+	/* The following pointers are used to test the maps having multiple
+	 * pages of trampolines.
+	 */
+	int (*tramp_1)(int value);
+	int (*tramp_2)(int value);
+	int (*tramp_3)(int value);
+	int (*tramp_4)(int value);
+	int (*tramp_5)(int value);
+	int (*tramp_6)(int value);
+	int (*tramp_7)(int value);
+	int (*tramp_8)(int value);
+	int (*tramp_9)(int value);
+	int (*tramp_10)(int value);
+	int (*tramp_11)(int value);
+	int (*tramp_12)(int value);
+	int (*tramp_13)(int value);
+	int (*tramp_14)(int value);
+	int (*tramp_15)(int value);
+	int (*tramp_16)(int value);
+	int (*tramp_17)(int value);
+	int (*tramp_18)(int value);
+	int (*tramp_19)(int value);
+	int (*tramp_20)(int value);
+	int (*tramp_21)(int value);
+	int (*tramp_22)(int value);
+	int (*tramp_23)(int value);
+	int (*tramp_24)(int value);
+	int (*tramp_25)(int value);
+	int (*tramp_26)(int value);
+	int (*tramp_27)(int value);
+	int (*tramp_28)(int value);
+	int (*tramp_29)(int value);
+	int (*tramp_30)(int value);
+	int (*tramp_31)(int value);
+	int (*tramp_32)(int value);
+	int (*tramp_33)(int value);
+	int (*tramp_34)(int value);
+	int (*tramp_35)(int value);
+	int (*tramp_36)(int value);
+	int (*tramp_37)(int value);
+	int (*tramp_38)(int value);
+	int (*tramp_39)(int value);
+	int (*tramp_40)(int value);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
new file mode 100644
index 000000000000..9495b21e1021
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_multi_pages.skel.h"
+
+void test_struct_ops_multi_pages(void)
+{
+	struct struct_ops_multi_pages *skel;
+	struct bpf_link *link;
+
+	/* The size of all trampolines of skel->maps.multi_pages should be
+	 * over 1 page (at least for x86).
+	 */
+	skel = struct_ops_multi_pages__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_multi_pages_open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.multi_pages);
+	ASSERT_OK_PTR(link, "attach_multi_pages");
+
+	bpf_link__destroy(link);
+	struct_ops_multi_pages__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
new file mode 100644
index 000000000000..9efcc6e4d356
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TRAMP(x) \
+	SEC("struct_ops/tramp_" #x)		\
+	int BPF_PROG(tramp_ ## x, int a)	\
+	{					\
+		return a;			\
+	}
+
+TRAMP(1)
+TRAMP(2)
+TRAMP(3)
+TRAMP(4)
+TRAMP(5)
+TRAMP(6)
+TRAMP(7)
+TRAMP(8)
+TRAMP(9)
+TRAMP(10)
+TRAMP(11)
+TRAMP(12)
+TRAMP(13)
+TRAMP(14)
+TRAMP(15)
+TRAMP(16)
+TRAMP(17)
+TRAMP(18)
+TRAMP(19)
+TRAMP(20)
+TRAMP(21)
+TRAMP(22)
+TRAMP(23)
+TRAMP(24)
+TRAMP(25)
+TRAMP(26)
+TRAMP(27)
+TRAMP(28)
+TRAMP(29)
+TRAMP(30)
+TRAMP(31)
+TRAMP(32)
+TRAMP(33)
+TRAMP(34)
+TRAMP(35)
+TRAMP(36)
+TRAMP(37)
+TRAMP(38)
+TRAMP(39)
+TRAMP(40)
+
+#define F_TRAMP(x) .tramp_ ## x = (void *)tramp_ ## x
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops multi_pages = {
+	F_TRAMP(1),
+	F_TRAMP(2),
+	F_TRAMP(3),
+	F_TRAMP(4),
+	F_TRAMP(5),
+	F_TRAMP(6),
+	F_TRAMP(7),
+	F_TRAMP(8),
+	F_TRAMP(9),
+	F_TRAMP(10),
+	F_TRAMP(11),
+	F_TRAMP(12),
+	F_TRAMP(13),
+	F_TRAMP(14),
+	F_TRAMP(15),
+	F_TRAMP(16),
+	F_TRAMP(17),
+	F_TRAMP(18),
+	F_TRAMP(19),
+	F_TRAMP(20),
+	F_TRAMP(21),
+	F_TRAMP(22),
+	F_TRAMP(23),
+	F_TRAMP(24),
+	F_TRAMP(25),
+	F_TRAMP(26),
+	F_TRAMP(27),
+	F_TRAMP(28),
+	F_TRAMP(29),
+	F_TRAMP(30),
+	F_TRAMP(31),
+	F_TRAMP(32),
+	F_TRAMP(33),
+	F_TRAMP(34),
+	F_TRAMP(35),
+	F_TRAMP(36),
+	F_TRAMP(37),
+	F_TRAMP(38),
+	F_TRAMP(39),
+	F_TRAMP(40),
+};
-- 
2.34.1


