Return-Path: <bpf+bounces-35542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86193B5A5
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C70284876
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F31662FB;
	Wed, 24 Jul 2024 17:15:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60515F406;
	Wed, 24 Jul 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841311; cv=none; b=pvEragfvh75+Nkn4A75CvcnZ/m0uPylaiNjkOMDNotyLkyyvoDp5FVaEFS3Td2hRbC+UlM7VGg69i3a58UOumLIVTV4Q6v+ncJJ9IvZqgd8LgMSQQYTeM/guJ287ejUu+SOC8bw+vbwsKcn8971QC7fxHpHmqM0vsjnKRLbZwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841311; c=relaxed/simple;
	bh=OTqyI8JQNFOlp0I8dEiUnDC97aqWnA94i48Z2vOTB2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE/C07xxKhDHDcpILeVSSJAOsT8ub1p1ajfuAfMZQzTQhv8cd5VXPLfle3w6H5GtxoqGqH3BKj5fbTtqmMe1AFMSEPpjKU5LHZhhMC9qUCfSi3tCxVl6vtztxHIYcmmuOmQ1JP+Kd9P9g12KnTazPW3lI8vlnNwl/pxl+ARuFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447f25e65f9so34846611cf.3;
        Wed, 24 Jul 2024 10:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841308; x=1722446108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50nGbBm+L7BDwVznnsSgCfha7GK5N1MIcEiLTWFxiAw=;
        b=akFSVYhBJia3Pr61zEjbXWC4lK8y/nPVDpCXvRJJNPnP3kiM09ASD8lZKeHd5ArJEM
         T+K/Ej3DXyVKqVS+Yv8MUMKot7kI7ewGIMrsE9DUAiFd8rOenGr6IZA6nBm6e5kJ8ENa
         J+iaSjkXsuFajlLIPfVjX7rixXZnitLySP32QSuZefEse4ijVxCvlyNuyuhyx3rEMLRF
         FMP6k/4raQkYTo44oG1d2r5P/v+i2gjZAmapsW1Yfc/uGgEM5//gmciE1FlCUoh9iVzs
         AY7ZNdGS2X/NDc4bdaMuL2NB5802WF6VFiwwvloz3g8WoVG0Jxz+OVYpvk6XzZ3NgYUi
         Yyvw==
X-Forwarded-Encrypted: i=1; AJvYcCXXWzRfsXZqb1QMeHUHuM7a7HliBn/bxG7kgY/Dehti0x3z1XiZGvK6p3ib+ndpYykqnWgfVt5hP63wEcESMcoSn3w5rYrZnPKxVwQl
X-Gm-Message-State: AOJu0YzpBpxQGy+WfpyzQtlHJZaRrBjg5T9pVtqDQNjZA7XK2CrZWeL+
	khmr0MC4KP1XaRG+VBw50byYgSdYOtkwngloQaq/+VYpZqN6c3YJXkiEn3u+
X-Google-Smtp-Source: AGHT+IEI18Cz4dT+rs1PKL5yO1+G9srycYGOGWJsU+h8EW1M3MGYLrcbl3b+0pIq37jXDK/YbZdTpA==
X-Received: by 2002:a05:622a:64e:b0:446:45b9:6161 with SMTP id d75a77b69052e-44fe4944311mr2905611cf.61.1721841308009;
        Wed, 24 Jul 2024 10:15:08 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd34d9dsm56281681cf.52.2024.07.24.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:15:07 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for resizing data map with struct_ops
Date: Wed, 24 Jul 2024 12:14:59 -0500
Message-ID: <20240724171459.281234-2-void@manifault.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724171459.281234-1-void@manifault.com>
References: <20240724171459.281234-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that if you resize a map after opening a skel, that it doesn't
cause a UAF which causes a struct_ops map to fail to be able to load.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../bpf/prog_tests/struct_ops_resize.c        | 30 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_resize.c   | 24 +++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_resize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
new file mode 100644
index 000000000000..7584f91c2bd1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_resize.skel.h"
+
+static void resize_datasec(void)
+{
+	struct struct_ops_resize *skel;
+	int err;
+
+	skel = struct_ops_resize__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_resize__open"))
+		return;
+
+	err  = bpf_map__set_value_size(skel->maps.data_resizable, 1 << 15);
+	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+		goto cleanup;
+
+	err = struct_ops_resize__load(skel);
+	ASSERT_OK(err, "struct_ops_resize__load");
+
+cleanup:
+	struct_ops_resize__destroy(skel);
+}
+
+void test_struct_ops_resize(void)
+{
+	if (test__start_subtest("resize_datasec"))
+		resize_datasec();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_resize.c b/tools/testing/selftests/bpf/progs/struct_ops_resize.c
new file mode 100644
index 000000000000..d0b235f4bbaa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_resize.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+char resizable[1] SEC(".data.resizable");
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	return 0;
+}
+
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod = {
+	.test_1 = (void *)test_1
+};
-- 
2.45.2


