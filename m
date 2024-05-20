Return-Path: <bpf+bounces-30024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D58C9A31
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B61F21514
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9A2032D;
	Mon, 20 May 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dvNfyiLB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B10200C7
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196488; cv=none; b=UsxLUm6lzq+AOVFqyxO3KD9Fi9kIBJFrsl7Mm4Ot/aFZVahEojE+lq4AQgMiAzmXF5TwTut31ecrRfo7SyTBbe6gn0pdFFvaCG/Q1+x22XrKDDs0UXR/PiwQWSb23VtqkcW0v2ezq/ZMLCuD9Kma1l+ZKgUI0zuXyUeJ+sI6juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196488; c=relaxed/simple;
	bh=Lq33IU/U8NYgb+2pLTKKyd1q0H7WqKL14Tqh6+YYXfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euT2OeZCKVz1clPY3V98Vk9QnPaujR+dnr1JM6wq0J/lkLid3Rvu3B6YQt4iot+xT7wRAxtKHJebfrvMhCP1lskfQWPyTNv5phzqiwmFoigptxeDHUjhuat11T2OOcQdfXAYSoZCczj0wcOJPFzuAkrsw0zWfA35wEqEUBQ7NiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dvNfyiLB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K5A3Vx014821
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=gSVb2lKV3qSuKDzbAGTmqz4MGG4GFjviJktcAhn4hjE=;
 b=dvNfyiLBMQkG5rS6eFeCNGdyy0Z70an/mJWiOfU+2xx2yfdKeKnLhqIjphx+bETXJ3x/
 1LQVf9cE1I1Bc9tCEPNjOEKInNwLf+FkwQffHJbvXGOgtlPwAX6IsTzps9EaBZ+YRzzZ
 GUxnlaE3axkK/yZ4a7LUV+EPaVkFhIu8Q/piyTzkZTabf2x4165gefoVx21579n3aIYk
 HBp3c6M0D1polF453uLOizNA0KvbjUT7Lp7JUbwAz+82hejpTta0HoetV9qWtrMuLIMf
 A/Iocv4iRigu9CtAITNXNHQcoqVIiqeS6eJHmXHOKC18SS1sFLBajEblz30AT7n/NNfe LA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y804d8rbb-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:46 -0700
Received: from twshared0252.08.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 02:14:43 -0700
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id DAE9F1349DCB; Mon, 20 May 2024 02:14:40 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH v2 bpf-next 3/3] net: new cgrp_sysctl test suite
Date: Mon, 20 May 2024 02:14:24 -0700
Message-ID: <20240520091424.2427762-4-ramasha@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520091424.2427762-1-ramasha@meta.com>
References: <20240520091424.2427762-1-ramasha@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6ujQ7Q1xSSefMzYmaCbahY442ApDj-u_
X-Proofpoint-ORIG-GUID: 6ujQ7Q1xSSefMzYmaCbahY442ApDj-u_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02

Adding new prog_tests for sysctl BPF handlers, first version with
a single test to validate bpf_sysctl_set_new_value call

Signed-off-by: Raman Shukhau <ramasha@meta.com>
---
 .../selftests/bpf/prog_tests/cgrp_sysctl.c    | 103 ++++++++++++++++++
 .../testing/selftests/bpf/progs/cgrp_sysctl.c |  51 +++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_sysctl.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c b/tools=
/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
new file mode 100644
index 000000000000..12a160428a1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#define SYSCTL_ROOT_PATH "/proc/sys/"
+#define SYSCTL_NAME_LEN 128
+#define RESERVED_PORTS_SYSCTL_NAME "net/ipv4/ip_local_reserved_ports"
+#define RESERVED_PORTS_OVERRIDE_VALUE "31337"
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include <sys/mount.h>
+
+#include "test_progs.h"
+#include "cgrp_sysctl.skel.h"
+
+struct sysctl_test {
+	const char *sysctl;
+	int open_flags;
+	const char *newval;
+	const char *updval;
+};
+
+static void subtest(int cgroup_fd, struct cgrp_sysctl *skel, struct sysc=
tl_test *test_data)
+{
+	int fd;
+
+	fd =3D open(SYSCTL_ROOT_PATH RESERVED_PORTS_SYSCTL_NAME, test_data->ope=
n_flags | O_CLOEXEC);
+	if (!ASSERT_GT(fd, 0, "sysctl-open"))
+		return;
+
+	if (test_data->open_flags =3D=3D O_RDWR) {
+		int wr_ret;
+
+		wr_ret =3D write(fd, test_data->newval, strlen(test_data->newval));
+		if (!ASSERT_GT(wr_ret, 0, "sysctl-write"))
+			goto out;
+
+		char buf[SYSCTL_NAME_LEN];
+		char updval[SYSCTL_NAME_LEN];
+
+		sprintf(updval, "%s\n", test_data->updval);
+		if (!ASSERT_OK(lseek(fd, 0, SEEK_SET), "sysctl-seek"))
+			goto out;
+		if (!ASSERT_GT(read(fd, buf, sizeof(buf)), 0, "sysctl-read"))
+			goto out;
+		if (!ASSERT_OK(strncmp(buf, updval, strlen(updval)), "sysctl-updval"))
+			goto out;
+	}
+
+out:
+	close(fd);
+}
+
+void test_cgrp_sysctl(void)
+{
+	struct cgrp_sysctl *skel;
+	int cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/cgrp_sysctl");
+	if (!ASSERT_GE(cgroup_fd, 0, "cg-create"))
+		return;
+
+	skel =3D cgrp_sysctl__open();
+	if (!ASSERT_OK_PTR(skel, "skel-open"))
+		goto close_cgroup;
+
+	struct sysctl_test test_data;
+
+	if (test__start_subtest("overwrite_success")) {
+		test_data =3D (struct sysctl_test){
+			.sysctl =3D RESERVED_PORTS_SYSCTL_NAME,
+			.open_flags =3D O_RDWR,
+			.newval =3D "22222",
+			.updval =3D RESERVED_PORTS_OVERRIDE_VALUE,
+		};
+		memcpy(skel->rodata->sysctl_name, RESERVED_PORTS_SYSCTL_NAME,
+		       sizeof(RESERVED_PORTS_SYSCTL_NAME));
+		skel->rodata->name_len =3D sizeof(RESERVED_PORTS_SYSCTL_NAME);
+		memcpy(skel->rodata->sysctl_updval, RESERVED_PORTS_OVERRIDE_VALUE,
+		       sizeof(RESERVED_PORTS_OVERRIDE_VALUE));
+		skel->rodata->updval_len =3D sizeof(RESERVED_PORTS_OVERRIDE_VALUE);
+	}
+
+	if (!ASSERT_OK(cgrp_sysctl__load(skel), "skel-load"))
+		goto close_cgroup;
+
+	skel->links.cgrp_sysctl_overwrite =3D
+		bpf_program__attach_cgroup(skel->progs.cgrp_sysctl_overwrite, cgroup_f=
d);
+	if (!ASSERT_OK_PTR(skel->links.cgrp_sysctl_overwrite, "cg-attach-sysctl=
"))
+		goto skel_destroy;
+
+	subtest(cgroup_fd, skel, &test_data);
+	goto skel_destroy;
+
+skel_destroy:
+	cgrp_sysctl__destroy(skel);
+
+close_cgroup:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_sysctl.c b/tools/test=
ing/selftests/bpf/progs/cgrp_sysctl.c
new file mode 100644
index 000000000000..1038e917c760
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_sysctl.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <string.h>
+#include <stdbool.h>
+
+#include <linux/bpf.h>
+
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_compiler.h"
+
+#define SYSCTL_VALUE_LEN 16
+#define SYSCTL_NAME_LEN 128
+
+#define SUCCESS 1
+#define FAILURE 0
+
+const char sysctl_updval[SYSCTL_VALUE_LEN];
+volatile const unsigned int updval_len;
+const char sysctl_name[SYSCTL_NAME_LEN];
+volatile const unsigned int name_len;
+
+static __always_inline bool is_expected_name(struct bpf_sysctl *ctx)
+{
+	char name[SYSCTL_NAME_LEN];
+	unsigned int size;
+
+	memset(name, 0, sizeof(name));
+	size =3D bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
+	if (size =3D=3D 0 || size !=3D name_len - 1)
+		return 1;
+
+	return bpf_strncmp(name, size, (const char *)sysctl_name) =3D=3D 0;
+}
+
+SEC("cgroup/sysctl")
+int cgrp_sysctl_overwrite(struct bpf_sysctl *ctx)
+{
+	if (!ctx->write)
+		return SUCCESS;
+
+	if (!is_expected_name(ctx))
+		return SUCCESS;
+
+	if (bpf_sysctl_set_new_value(ctx, (char *)sysctl_updval, updval_len) =3D=
=3D 0)
+		return SUCCESS;
+	return FAILURE;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.43.0


