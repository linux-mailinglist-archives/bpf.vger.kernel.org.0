Return-Path: <bpf+bounces-28571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47B8BBA83
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71161C21065
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686217C7C;
	Sat,  4 May 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K2yiv/50"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DF5258
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714818301; cv=none; b=PvTgIRpppcUb+H4xezFPVfMr2SnO6c2lcyLx6OaygoHMKvrAY0k8SdRxtEyCcBNlMNC2MkXBjV2MQqaes+/0YbbYve+yq6zVuZxEl1aDovwfyxfGksJD1HO5b3jmGErIgimhAHQrweaEfjb+T6pndpU+ewfGhq8U/z9ulKaO22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714818301; c=relaxed/simple;
	bh=sL50/OE/m6UefHfFy1SYHlLub69NN64XRx1a3QAfoXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANg45uhqAEIQeK1n9Lk67F4p7B/C7ZtJq9Hduk+FRgB99eHY80iWpCiNvtkUEI9D5Bpw8I+US7d3fEBmnyoEC6A82gy31W02iK/FL08XDFowIz+dDN5fCwosoxs2k33ymEJon90R+BbD2Zbys6+0yaL2YX5TU8/kww+zdva79fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=K2yiv/50; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4449buu6029827
	for <bpf@vger.kernel.org>; Sat, 4 May 2024 03:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B35y5x+8aC9Tn0uuriRJInld78B30U50tJ2t7bai8mU=;
 b=K2yiv/50WVkrZ5G9si0cx/f3cOnNtgBCtQSMCgVw4FIvE9rtE5avWs5XUYpvGsB38rtl
 jv5IMdS48HJdDVf6Y9aMb5JqmsUuSYTCpBHMm9wAwWGiuz4BBOGV7Hn+3qHylcix3fa0
 c3jJEjeEHasXAPyPCEBnxnd4BgoyUF4VL+A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xwjj4r2wp-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 04 May 2024 03:24:58 -0700
Received: from twshared7646.08.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 4 May 2024 10:24:42 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 39A3B302E95; Sat,  4 May 2024 03:24:41 -0700 (PDT)
From: Raman Shukhau <ramasha@fb.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@fb.com>
Subject: [PATCH bpf-next 1/1] Fix for bpf_sysctl_set_new_value
Date: Sat, 4 May 2024 03:23:12 -0700
Message-ID: <20240504102312.3137741-2-ramasha@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504102312.3137741-1-ramasha@fb.com>
References: <20240504102312.3137741-1-ramasha@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SS4dbTYsKGrWOHXxzWvaKhhemTM9N7Fr
X-Proofpoint-GUID: SS4dbTYsKGrWOHXxzWvaKhhemTM9N7Fr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_07,2024-05-03_02,2023-05-22_02

Noticed that call to bpf_sysctl_set_new_value doesn't change final value
of the parameter, when called from cgroup/syscall bpf handler. No error
thrown in this case, new value is simply ignored and original value, sent
to sysctl, is set. Example (see test added to this change for BPF handler
logic):

sysctl -w net.ipv4.ip_local_reserved_ports =3D 11111
... cgroup/syscal handler call bpf_sysctl_set_new_value	and set 22222
sysctl net.ipv4.ip_local_reserved_ports
... returns 11111

On investigation I found 2 things that needs to be changed:
* return value check
* new_len provided by bpf back to sysctl. proc_sys_call_handler	expects
  this value NOT to include \0 symbol, e.g. if user do

	```
  open("/proc/sys/net/ipv4/ip_local_reserved_ports", ...)
  write(fd, "11111", sizeof("22222"))
  ```

  or `echo -n "11111" > /proc/sys/net/ipv4/ip_local_reserved_ports`

  or `sysctl -w	net.ipv4.ip_local_reserved_ports=3D11111

  proc_sys_call_handler receives count equal to `5`. To make it consisten=
t
  with bpf_sysctl_set_new_value, this change also adjust `new_len` with
  `-1`, if `\0` passed as last character. Alternatively, using
  `sizeof("11111") - 1` in BPF handler should work, but it might not be
  obvious and spark confusion. Note: if incorrect count is used, sysctl
  returns EINVAL to the user.

Signed-off-by: Raman Shukhau <ramasha@fb.com>
---
 kernel/bpf/cgroup.c                           |  7 ++-
 .../bpf/progs/test_sysctl_overwrite.c         | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sysctl.c     | 35 +++++++++++++-
 3 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_overwri=
te.c

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..23736aed1b53 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1739,10 +1739,13 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_tab=
le_header *head,
=20
 	kfree(ctx.cur_val);
=20
-	if (ret =3D=3D 1 && ctx.new_updated) {
+	if (ret =3D=3D 0 && ctx.new_updated) {
 		kfree(*buf);
 		*buf =3D ctx.new_val;
-		*pcount =3D ctx.new_len;
+		if (!(*buf)[ctx.new_len])
+			*pcount =3D ctx.new_len - 1;
+		else
+			*pcount =3D ctx.new_len;
 	} else {
 		kfree(ctx.new_val);
 	}
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c b/=
tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c
new file mode 100644
index 000000000000..e44b429fcfc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_overwrite.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <string.h>
+
+#include <linux/bpf.h>
+
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_compiler.h"
+
+static const char sysctl_value[] =3D "31337";
+static const char sysctl_name[] =3D "net/ipv4/ip_local_reserved_ports";
+static __always_inline int is_expected_name(struct bpf_sysctl *ctx)
+{
+	unsigned char i;
+	char name[sizeof(sysctl_name)];
+	int ret;
+
+	memset(name, 0, sizeof(name));
+	ret =3D bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
+	if (ret < 0 || ret !=3D sizeof(sysctl_name) - 1)
+		return 0;
+
+	__pragma_loop_unroll_full
+	for (i =3D 0; i < sizeof(sysctl_name); ++i)
+		if (name[i] !=3D sysctl_name[i])
+			return 0;
+
+	return 1;
+}
+
+SEC("cgroup/sysctl")
+int test_value_overwrite(struct bpf_sysctl *ctx)
+{
+	if (!ctx->write)
+		return 1;
+
+	if (!is_expected_name(ctx))
+		return 0;
+
+	if (bpf_sysctl_set_new_value(ctx, sysctl_value, sizeof(sysctl_value)) =3D=
=3D 0)
+		return 1;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/se=
lftests/bpf/test_sysctl.c
index bcdbd27f22f0..dfa479861d3a 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -35,6 +35,7 @@ struct sysctl_test {
 	int seek;
 	const char *newval;
 	const char *oldval;
+	const char *updval;
 	enum {
 		LOAD_REJECT,
 		ATTACH_REJECT,
@@ -1395,6 +1396,16 @@ static struct sysctl_test tests[] =3D {
 		.open_flags =3D O_RDONLY,
 		.result =3D SUCCESS,
 	},
+	{
+		"C prog: override write to ip_local_reserved_ports",
+		.prog_file =3D "./test_sysctl_overwrite.bpf.o",
+		.attach_type =3D BPF_CGROUP_SYSCTL,
+		.sysctl =3D "net/ipv4/ip_local_reserved_ports",
+		.open_flags =3D O_RDWR,
+		.newval =3D "11111",
+		.updval =3D "31337",
+		.result =3D SUCCESS,
+	},
 };
=20
 static size_t probe_prog_length(const struct bpf_insn *fp)
@@ -1520,13 +1531,33 @@ static int access_sysctl(const char *sysctl_path,
 			log_err("Read value %s !=3D %s", buf, test->oldval);
 			goto err;
 		}
-	} else if (test->open_flags =3D=3D O_WRONLY) {
+	} else if (test->open_flags =3D=3D O_WRONLY || test->open_flags =3D=3D =
O_RDWR) {
 		if (!test->newval) {
 			log_err("New value for sysctl is not set");
 			goto err;
 		}
-		if (write(fd, test->newval, strlen(test->newval)) =3D=3D -1)
+		if (write(fd, test->newval, strlen(test->newval)) =3D=3D -1) {
+			log_err("Unable to write sysctl value");
 			goto err;
+		}
+		if (test->open_flags =3D=3D O_RDWR) {
+			char buf[128];
+
+			if (!test->updval) {
+				log_err("Expected value for sysctl is not set");
+				goto err;
+			}
+
+			lseek(fd, 0, SEEK_SET);
+			if (read(fd, buf, sizeof(buf)) =3D=3D -1) {
+				log_err("Unable to read updated value");
+				goto err;
+			}
+			if (strncmp(buf, test->updval, strlen(test->updval))) {
+				log_err("Overwritten value %s !=3D %s", buf, test->updval);
+				goto err;
+			}
+		}
 	} else {
 		log_err("Unexpected sysctl access: neither read nor write");
 		goto err;
--=20
2.43.0


