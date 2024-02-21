Return-Path: <bpf+bounces-22470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D19D85EC1E
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911561C228E8
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75306535DC;
	Wed, 21 Feb 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1TbxbK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9E126F0B
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556361; cv=none; b=eLeerIauakKHJsSs+BoTfu8SjiAR5JT96L5sAhgiWVa3AGdimNidLOpQKJxcoq4IpwiW8YDYqwpaRU/qGz+/hw0ur1otZ5E57TwBYDciqnlXOwyuKE4qCEPfTWRlCdI48L2BCSPy0BBAT6izrES8qCmlB95AB9pwA9WqWShC+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556361; c=relaxed/simple;
	bh=eI9M7LeZIbVf4PAKpdJzSqozqw81fFyHCfaAf8GvGos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFpwC8RFQ/TVQpdKNbTJqexLMUCFURvM3NInAN+5Lroio3QulVI3ynk96z6vU5PoAaP0/aSDr1C7Vmw6dZDafokO1x1PFKfMtHaIA737uUgT7eFQCW8Nu+OoqcpmdZwgsFIZ6SqAgm2yLngbXnJsYfjDn/msdMeQJoDVBtdrIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1TbxbK8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60869c68926so24903267b3.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556358; x=1709161158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpHAZChXrmDGEf/hZq9KDg2E3R4kWtgxbD/4zGjA7lY=;
        b=d1TbxbK8yRk18LOvLsuDd9a5dymry4A5CVN6qCCl3KqOqesDtuhBaFp7/m5L17YAgn
         cfLZ/t5GxDyuHv3I50oEOXkJhR0S7jgxEuVzJTcztR49Xrg/D1TPCJiFlK0Xv7OLsYiO
         5IlSO02JOjv5AApOdUerAKoSJUQZ1budquQTlURkoSi80fRiEb7OeHRryrbuvmr79MB8
         LF5AF2yZ5i3EMMRrQF9iQnuKwZ4n5LIes5R5fAvqrjgIFx3k3q1G//HdlBU7c3In42OX
         R17rVdjJcdUTdba+vKy9kaAWcpzm21oQZztwBhBfi9AR/NXGgPx6+v7qkDKGOU+m6NTF
         L6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556358; x=1709161158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpHAZChXrmDGEf/hZq9KDg2E3R4kWtgxbD/4zGjA7lY=;
        b=iyaG2ZhnuqaotzTGKA8QO16CXnWs0TDiyq4CiCvadmUn8pGMFkPLS+D2cJRs/R3Sy1
         6dOTohVJBRK+/W/K8+LCuXGSh4cDtiuyFvdLLAieSQz60AHjvaHMoM2Q9TrzNe19pOLj
         VOkz5oHjjjl4FlE0Mj+C5+TKdmKZOOzgtwrzfxoyJ/0GdRkbUe4WM/sdSscJHqUwfBFz
         N7rGyi6DHUbDlPZf+Y9KE2mu8YmRnaFOo/TrhtdYigVpy9F6Li0pxmNjkiws1z2Whac0
         3vcTiMT2fasf18MLQ1UwOCSsijmD2Ht68U+/lVaHfrUoMHVnGpYqXs5W7ryVF2kdmWj7
         YLsA==
X-Gm-Message-State: AOJu0YxGt0POt966A/QaU/fP/G/dLsrIRimFPno09wSWtiJvNFga7JH7
	ZrFH0JPYNc3AnZ3aIgABAJYdAeKOBkeqaAdtqRe6/BRA0qZBwBV7kO3RDno6
X-Google-Smtp-Source: AGHT+IH36POtfhaTUFVrMB4akrqnwhqFmYNRLIWDg2ktuwCWlMyq84LXV1hqq03Tc6i3aTft/0q3Vg==
X-Received: by 2002:a05:690c:d07:b0:608:2f27:5c0e with SMTP id cn7-20020a05690c0d0700b006082f275c0emr12258553ywb.8.1708556357761;
        Wed, 21 Feb 2024 14:59:17 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id s67-20020a0de946000000b006078c48a265sm2820090ywe.6.2024.02.21.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:59:17 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test struct_ops maps with a large number of program links.
Date: Wed, 21 Feb 2024 14:59:11 -0800
Message-Id: <20240221225911.757861-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221225911.757861-1-thinker.li@gmail.com>
References: <20240221225911.757861-1-thinker.li@gmail.com>
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
 .../prog_tests/test_struct_ops_multi_pages.c  |  31 ++++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 ++++++++++++++++++
 3 files changed, 177 insertions(+)
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
index 000000000000..9edb2985bc1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
@@ -0,0 +1,31 @@
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
+
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


