Return-Path: <bpf+bounces-29983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E58C8EE5
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86256282270
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECD33EC;
	Sat, 18 May 2024 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gL/8WY3C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1B383
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992221; cv=none; b=ODzSr0r5gQaskJPLa6Va0uSLChpYmQpU9B5eydzvrnShWInlFogqlik3qU3sGk1NUDBGKS98hUjA9l7lyDrs4hxuYFqrCfdaIC5qcy6IucST7uI6FV2VAzs6ob0Kin8YNFK0v7Qwy+CWuUuKwrQbcngXYVyKucjOeTSEqkEMO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992221; c=relaxed/simple;
	bh=smC1p8fzlsmTgyXPDCcK1hQYLtBHwpwePuaylosJAOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2aaYQn75JqXNYNlqWcWyD5QREfSJbH8kF83xzDqcnPlIkYBIBuVfkITeNoJi4Xl8oP+q99fHiiChrmsZrTOYR1NrI1UhiQQ50wD1i0585xG2qraTC5AjTSSogSrBlsqRmdE6e7ITTRF4BFyWKRM0HE+mZM/ukv8qpxwFYeKyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gL/8WY3C; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HLdOBe011148
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=ndWub6cpNtSqS991Wd+QeiH5qywP1AWGZaHSZVPrdRI=;
 b=gL/8WY3C3Ag+p0o2OWEL1elaq9TFPGkKi7qABFk/9xB5hzLBWGhpPbk1bTGWCU9cyK8V
 gXZ6+Br+V5nNxTntiYSCt14a5EKTuSv3uDeBtGJmzdVbGmj6teJ99IQI+vlYHglTAOFd
 FXN19PaX8M4Ru06pnpeA+wj2ILETmta11MMPXZ8EBgPfTTYCMi85387yDvnhF58/ppNd
 sF5vgAKzAuhPQC6pTnH/g5dVSENMF4qN8wY4sIwVUDdQIDzHKf/39eBNBovguR8q2Tzk
 aKlAnvZnYUbkbBjHuixDn6vBmo7k+OEJuDovmi1ntAkB0cJdYty80SidVEDOqiyBgj+g ZA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y5yrewxh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:19 -0700
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 18 May 2024 00:30:18 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 05B1F1196EA6; Fri, 17 May 2024 17:30:07 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH bpf-next 3/3] net: new cgrp_sysctl test suite
Date: Fri, 17 May 2024 17:29:42 -0700
Message-ID: <20240518002942.3692677-4-ramasha@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518002942.3692677-1-ramasha@meta.com>
References: <20240518002942.3692677-1-ramasha@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -QD-213lbYwxbd6lszb2u1Id5-r34qfC
X-Proofpoint-ORIG-GUID: -QD-213lbYwxbd6lszb2u1Id5-r34qfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_11,2024-05-17_03,2023-05-22_02

Adding new prog_tests for sysctl BPF handlers, first version with
a single test to validate bpf_sysctl_set_new_value call

Signed-off-by: Raman Shukhau <ramasha@meta.com>
---
 .../selftests/bpf/prog_tests/cgrp_sysctl.c    | 106 ++++++++++++++++++
 .../testing/selftests/bpf/progs/cgrp_sysctl.c |  51 +++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_sysctl.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c b/tools=
/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
new file mode 100644
index 000000000000..dad847d397de
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright 2022 Google LLC.
+ */
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
index 000000000000..99b202835f85
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgrp_sysctl.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
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
+	int size;
+
+	memset(name, 0, sizeof(name));
+	size =3D bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
+	if (size <=3D 0 || size !=3D name_len - 1)
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


