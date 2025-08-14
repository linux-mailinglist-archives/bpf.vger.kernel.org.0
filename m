Return-Path: <bpf+bounces-65679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B37CB26E93
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788F0AA3276
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641329D285;
	Thu, 14 Aug 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b="vvgZeQ+0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A731987F;
	Thu, 14 Aug 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194532; cv=none; b=jQ8aaj2Hfug8gFjTxYhwQzKqthGlZtU/n1CwB3K1IWifTle2vozC2Yia0GzP4ip1snjCPucL2SazL3V/mfRdWMRxVSyH67vcm5/og2V4WyaE2UgaWF8CFCq0PzkMtZflDnEcWaDbZS/P33TCdYv45PuH8gxoXDx9B4R1oQ78Lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194532; c=relaxed/simple;
	bh=k5yaaw5MMF921u7G4+XJeBCyXv937dA+VDY2GuubhA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTG76rnLoksZSIPthtWFThXEaZT+Ifc30ZnUMXaNC4KdUtQe81SwPi4I4fRz2XqDEmPkJfnws9RCFC70kaq6BzNEBKrSGSsa1rY/rWS9oTrdsD+XHVab0YzuOY9ntGtNFC/viEgIPZRXqOoECKUO5zpnFSASOKt1VkN3xTRvKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev; spf=pass smtp.mailfrom=yuka.dev; dkim=pass (1024-bit key) header.d=yuka.dev header.i=@yuka.dev header.b=vvgZeQ+0; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yuka.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuka.dev
From: Yureka Lilian <yuka@yuka.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yuka.dev; s=mail;
	t=1755194527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=os4PiDXRnh9o8dcdOwZ4gvFWrzcLIaQPdyGWa9rpF74=;
	b=vvgZeQ+0X6Tsy0K5cY1JVzRseL6JjVs/6y8sAw5dldqPJvV8fFsPih0kKiXnnxwXpEmNL9
	HIoAP6bRLELe6apWzSHjWa53etW8pd1vET8lOsdPqrsKDGHG3p+CR9/Y/gjSky5bpQYgp1
	yPFrc9NPtGU2UN3h/cu+NU8NOYVIYEw=
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Yureka Lilian <yuka@yuka.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/bpf: add test for DEVMAP reuse
Date: Thu, 14 Aug 2025 20:01:13 +0200
Message-ID: <20250814180113.1245565-4-yuka@yuka.dev>
In-Reply-To: <20250814180113.1245565-2-yuka@yuka.dev>
References: <20250814180113.1245565-2-yuka@yuka.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test covers basic re-use of a pinned DEVMAP map,
with both matching and mismatching parameters.

Signed-off-by: Yureka Lilian <yuka@yuka.dev>
---
 .../bpf/prog_tests/pinning_devmap_reuse.c     | 50 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_devmap.c | 20 ++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_devmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
new file mode 100644
index 000000000..9ae49b587
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pinning_devmap_reuse.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <test_progs.h>
+
+
+#include "test_pinning_devmap.skel.h"
+
+void test_pinning_devmap_reuse(void)
+{
+	const char *pinpath1 = "/sys/fs/bpf/pinmap1";
+	const char *pinpath2 = "/sys/fs/bpf/pinmap2";
+	struct test_pinning_devmap *skel1 = NULL, *skel2 = NULL;
+	int err;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+
+	/* load the object a first time */
+	skel1 = test_pinning_devmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel1, "skel_load1"))
+		goto out;
+
+	/* load the object a second time, re-using the pinned map */
+	skel2 = test_pinning_devmap__open_and_load();
+	if (!ASSERT_OK_PTR(skel2, "skel_load2"))
+		goto out;
+
+	/* we can close the reference safely without
+	 * the map's refcount falling to 0
+	 */
+	test_pinning_devmap__destroy(skel1);
+	skel1 = NULL;
+
+	/* now, swap the pins */
+	err = renameat2(0, pinpath1, 0, pinpath2, RENAME_EXCHANGE);
+	if (!ASSERT_OK(err, "swap pins"))
+		goto out;
+
+	/* load the object again, this time the re-use should fail */
+	skel1 = test_pinning_devmap__open_and_load();
+	if (!ASSERT_ERR_PTR(skel1, "skel_load3"))
+		goto out;
+
+out:
+	unlink(pinpath1);
+	unlink(pinpath2);
+	test_pinning_devmap__destroy(skel1);
+	test_pinning_devmap__destroy(skel2);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_pinning_devmap.c b/tools/testing/selftests/bpf/progs/test_pinning_devmap.c
new file mode 100644
index 000000000..c855f8f87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_pinning_devmap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} pinmap1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} pinmap2 SEC(".maps");
-- 
2.50.1


