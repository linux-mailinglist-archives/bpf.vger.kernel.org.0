Return-Path: <bpf+bounces-22636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103EF86226F
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 04:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4ABB22645
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B4134DB;
	Sat, 24 Feb 2024 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Ju8TTx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FDE134B5
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743792; cv=none; b=u0P7SzTnufjXHIgV4oFknoB6y4vFoIfN+kG7GyUi7ak2vzfgaJP8zBrT7YQKyVlxHt1x7UBGH5Zv6+XOjgZJSJTRUbYFCuRLAo+n7zZa0J60gxPzidSTvbzMdQTgvpJpULf6e9+ANnfuF2hnERIThPLsJ4VgDpmXVHhmIZt3Z7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743792; c=relaxed/simple;
	bh=6GRO6kPSGXqiAH/EjT5VLBpg0zjQANhjxF4UC3PUHJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZwChSmqxH290CZE9fED5KCFR8ODnAzH7B+yljgm1ioSQIkNl+ZusSMjUI/lJ5ttV1saQeG2LzF41iCRe9Ix40BLlgEmslsNVuwkRrm4Yk+ux/9SSpq3YuTDfZDUniRL4ICqmoMxjT3j1gIfadZmw7r1O+Hgz5oFqxx7FhJAuJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Ju8TTx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607bfa4c913so15762527b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708743789; x=1709348589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0fCdm6t3+/GrYi+it9WNMMgcg+iH1aau2sIAxX+fSU=;
        b=V7Ju8TTxnFx67Ky23ckoElf4y3WcpnbY0KNnncdf79WmoL99BMy99usWXrOSLDPOXz
         WMBATISjJYUzEbatU4zMn2+1dy2zmLPCyqzOM7Q9DWLoLHvbytkeHzVE9Y/Nqseeh3tZ
         Abh8rl1NsLtr4CcTOSOLN0CA9rqHU1rCtJyOtsCVPL3L1xrpHcl/eqqbwjDJngsPO2nX
         PNUXcM2nPcfH5SYcmUg7KX7Shc3dFVwUapQo94pGEsNlr9knPDajrzHjNX2oz8In62H+
         fmeJ9zoKEEz/McKNamLsfwA/QjKL6A9gKKHel2s4+0KQ/DoGZrHxh/1n2TuCfmTfN17Z
         HQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708743789; x=1709348589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0fCdm6t3+/GrYi+it9WNMMgcg+iH1aau2sIAxX+fSU=;
        b=UiiQKq69DlyJe05ig8bSsROgt3TAJ+v6ybCL8bSWn4bboij/fJERnm0xJj0+S0xrwq
         vch9yWDrkGvgSV6SuGm2xh3M0xYhd6h4x/CoFX/9JCM/RdLLBQS2XlsZy7D+ae/8vC05
         HBua5WqdBgsVsLl4YCUg8PcLFhwS/4OHep11DqJKGlSE/0j+4sPZe7xeyuX502QoUzS/
         FqVWZMbfMrsB+ziVKh7qsrRD5zBx1NPuzhnfCMk2JOZs/EdSDFQvB8dujTduz6fzZTvJ
         FARbZnAkq4B2H/T4FtQku4a1Nhs9IM/pd4tHjPHxfPQ2dHD1uq85ofn3BRXi27BpFYp2
         3TwQ==
X-Gm-Message-State: AOJu0YwOVVAP0csF9BptRgH4gHXrNlJG12P/JRg/mKJY0d7Je8EN0uQC
	ji1IOScJxZ09CrOAj28BeQ9ZHH2dCDcHwnQJLnuuJj28mcXA03eRd25nwtGm
X-Google-Smtp-Source: AGHT+IHvtMQbef5hW+wfkdtDzZaQkFZ8qfOS7iYe/vvptV3HzyfHdpR/sXLss6mZZeJevrOWofI3uQ==
X-Received: by 2002:a81:d203:0:b0:607:838f:8991 with SMTP id x3-20020a81d203000000b00607838f8991mr1571420ywi.38.1708743788890;
        Fri, 23 Feb 2024 19:03:08 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id w66-20020a817b45000000b006087a2fc6b9sm84515ywc.101.2024.02.23.19.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 19:03:08 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test struct_ops maps with a large number of program links.
Date: Fri, 23 Feb 2024 19:03:02 -0800
Message-Id: <20240224030302.1500343-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224030302.1500343-1-thinker.li@gmail.com>
References: <20240224030302.1500343-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create and load a struct_ops map with a large number of programs to
generate trampolines taking a size over multiple pages. The map includes 40
programs. Their trampolines takes 6.6k+, more than 1.5 pages, on x86.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 ++++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  30 ++++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 ++++++++++++++++++
 3 files changed, 176 insertions(+)
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
index 000000000000..645d32b5160c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_multi_pages.skel.h"
+
+static void do_struct_ops_multi_pages(void)
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
+
+void test_struct_ops_multi_pages(void)
+{
+	if (test__start_subtest("multi_pages"))
+		do_struct_ops_multi_pages();
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


