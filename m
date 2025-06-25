Return-Path: <bpf+bounces-61492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13019AE7646
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 07:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F138217A960
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 05:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E461D6DB6;
	Wed, 25 Jun 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GRmqgvMR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978C3074BC
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750827768; cv=none; b=C6BqQhs9RlIleH5B08YKnmE8U1FLtkSEK2fqilgWs3UWPAtcXfKtyHHzwaun9xPtlyvWTHtY6UCH8TrfciIXsz0NvGMHnPF10VpdOaDTtF/qj9yKqjbVomkN8d7oRpFOfV/qifQS4buJZ/DuKw+F3et5028TVx3CsSKh9ZqoK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750827768; c=relaxed/simple;
	bh=V1AUKTWznoThobmmHnuNVZ8WrpiIvfVVDlCCcsEIFQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/JNBXNEdumnUWcr7chz+NH/PvtyZ8ffl824t765H7ypqJ6Edxm5jK8E/SvOyWRiBC+p5LGzzeOIPVE3G8wJpf8qYIjnEvECDHKFSwJNmsNRrG4J+ttiOEYfxCZcO5/Uo/fmI8ZPJbz+NNCINEgwkfxBDurZRKu0xIt8QHu8++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GRmqgvMR; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P22Irc015988
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:02:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=cgGCGcQpACYxV/yXt2
	g+Cnc1FYeuuhMyNMcBn+ieq+E=; b=GRmqgvMRM5HH4YROQkNUIPkESd2gVAJ100
	SOBNP+QthOVEavaQku9ELjTXNaSrJ4e6udaMqfnc6zeSdzs7GWZE2m+hTp2d0rlj
	iwF+5Waz6DvNNhmjrBBOmeYbR2o/woZ8ujSPmmoO49HVryMPrdGMuSd2JMXK+J3T
	VAR6+RIZJrSS5fUnFbjLtcdzswcbasvH1EFcVOiA5zYdubybLfZfINxxhh53ewxf
	j7ZFTnMyCNZmFz+51A0A7/HKz0yJdqOJaBSKcEcw7zcu/Aq14mpHwUHpAJPaoany
	clJeUxcREIcxmg7Ba6a9JBw811PYTzohqUTdNqsNJwa/JJpiyNCA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47g00ec67s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:02:45 -0700 (PDT)
Received: from twshared32712.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 25 Jun 2025 05:02:43 +0000
Received: by devvm16984.vll0.facebook.com (Postfix, from userid 673687)
	id 63134DBC4AD2; Tue, 24 Jun 2025 22:02:31 -0700 (PDT)
From: Adin Scannell <amscanne@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, Adin Scannell <amscanne@meta.com>
Subject: [PATCH bpf v2] libbpf: fix possible use-after-free for externs
Date: Tue, 24 Jun 2025 22:02:15 -0700
Message-ID: <20250625050215.2777374-1-amscanne@meta.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aaxhnQot c=1 sm=1 tr=0 ts=685b82f5 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=InPXK2lmKs2oRydpIwoA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: PTy-Rqpjmy3PZ7YxOiwCxhI9D-63wuJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNSBTYWx0ZWRfX75dEoBTof202 rf1osl2ALZnmOhNnnZhgOU2HhU2FeOraLeaX9+KcfYVfOG4K88ing/mr66gfi0DrbeY4ui6KIaJ UrMXUaTMNn7ZToLNQl76rbvS3NuVaM2E/DduqNNZ1NOxUUDzAAc0tZl/UMYThVVZLjvhFdpgzVy
 ++B/RpjwRWXse5zqhcEDLKfUCqlZnPxIakQcexkgA+ztF5845uPJE5gGgjhzpr6gi6hPJEe+8qp 90i6oEPF3eKc8ON8N9dGAAGwcpzAiNjPXJT/8qNkhtXOFiNQv+lyVdHcc15GNoXG3yXFVnf9DQJ 2KbAlxj7NQKz2YZmYAdZ6Z9CRDASEqKuOVK38XoSEMZF/c84iVmVHvr3YtwwDF+VYSM+4znYMbK
 Q/k3fcQA/9PahMl7WlDI9uD2b+360C2+A8CH9Jje7QwTs5BxA1XKUbvImMbUlu42o3mXyICY
X-Proofpoint-GUID: PTy-Rqpjmy3PZ7YxOiwCxhI9D-63wuJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01

The `name` field in `obj->externs` points into the BTF data at initial
open time. However, some functions may invalidate this after opening and
before loading (e.g. `bpf_map__set_value_size`), which results in
pointers into freed memory and undefined behavior.

The simplest solution is to simply `strdup` these strings, similar to
the `essent_name`, and free them at the same time.

In order to test this path, the `global_map_resize` BPF selftest is
modified slightly to ensure the presence of an extern, which causes this
test to fail prior to the fix. Given there isn't an obvious API or error
to test against, I opted to add this to the existing test as an aspect
of the resizing feature rather than duplicate the test.

Fixes: 9d0a23313b1a ("libbpf: Add capability for resizing datasec maps")
Signed-off-by: Adin Scannell <amscanne@meta.com>
---
 tools/lib/bpf/libbpf.c                           | 10 +++++++---
 .../selftests/bpf/progs/test_global_map_resize.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e9c641a2fb20..52e353368f58 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -597,7 +597,7 @@ struct extern_desc {
 	int sym_idx;
 	int btf_id;
 	int sec_btf_id;
-	const char *name;
+	char *name;
 	char *essent_name;
 	bool is_set;
 	bool is_weak;
@@ -4259,7 +4259,9 @@ static int bpf_object__collect_externs(struct bpf_o=
bject *obj)
 			return ext->btf_id;
 		}
 		t =3D btf__type_by_id(obj->btf, ext->btf_id);
-		ext->name =3D btf__name_by_offset(obj->btf, t->name_off);
+		ext->name =3D strdup(btf__name_by_offset(obj->btf, t->name_off));
+		if (!ext->name)
+			return -ENOMEM;
 		ext->sym_idx =3D i;
 		ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_WEAK;
=20
@@ -9138,8 +9140,10 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
=20
-	for (i =3D 0; i < obj->nr_extern; i++)
+	for (i =3D 0; i < obj->nr_extern; i++) {
+		zfree(&obj->externs[i].name);
 		zfree(&obj->externs[i].essent_name);
+	}
=20
 	zfree(&obj->externs);
 	obj->nr_extern =3D 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b=
/tools/testing/selftests/bpf/progs/test_global_map_resize.c
index a3f220ba7025..ee65bad0436d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -32,6 +32,16 @@ int my_int_last SEC(".data.array_not_last");
=20
 int percpu_arr[1] SEC(".data.percpu_arr");
=20
+/* at least one extern is included, to ensure that a specific
+ * regression is tested whereby resizing resulted in a free-after-use
+ * bug after type information is invalidated by the resize operation.
+ *
+ * There isn't a particularly good API to test for this specific conditi=
on,
+ * but by having externs for the resizing tests it will cover this path.
+ */
+extern int LINUX_KERNEL_VERSION __kconfig;
+long version_sink;
+
 SEC("tp/syscalls/sys_enter_getpid")
 int bss_array_sum(void *ctx)
 {
@@ -44,6 +54,9 @@ int bss_array_sum(void *ctx)
 	for (size_t i =3D 0; i < bss_array_len; ++i)
 		sum +=3D array[i];
=20
+	/* see above; ensure this is not optimized out */
+	version_sink =3D LINUX_KERNEL_VERSION;
+
 	return 0;
 }
=20
@@ -59,6 +72,9 @@ int data_array_sum(void *ctx)
 	for (size_t i =3D 0; i < data_array_len; ++i)
 		sum +=3D my_array[i];
=20
+	/* see above; ensure this is not optimized out */
+	version_sink =3D LINUX_KERNEL_VERSION;
+
 	return 0;
 }
=20
--=20
2.48.1


