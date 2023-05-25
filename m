Return-Path: <bpf+bounces-1253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E7711A0D
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 00:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2A2281585
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB064261C3;
	Thu, 25 May 2023 22:13:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1299FC16
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 22:13:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA481134
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKnuFm003992
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qt9b0kds9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 15:13:29 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 15:13:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4F471315735CF; Thu, 25 May 2023 15:13:24 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <lennart@poettering.net>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] libbpf: ensure libbpf always opens files with O_CLOEXEC
Date: Thu, 25 May 2023 15:13:10 -0700
Message-ID: <20230525221311.2136408-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EIfUxi11HdxYZKk4BZC4YG6iDEllitUW
X-Proofpoint-GUID: EIfUxi11HdxYZKk4BZC4YG6iDEllitUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that libbpf code always gets FD with O_CLOEXEC flag set,
regardless if file is open through open() or fopen(). For the latter
this means to add "e" to mode string, which is supported since pretty
ancient glibc v2.7.

I also dropped outdated TODO comment in usdt.c, which was already complet=
ed.

Suggested-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c           | 2 +-
 tools/lib/bpf/libbpf.c        | 6 +++---
 tools/lib/bpf/libbpf_probes.c | 2 +-
 tools/lib/bpf/usdt.c          | 5 ++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0a2c079244b6..8484b563b53d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1064,7 +1064,7 @@ static struct btf *btf_parse_raw(const char *path, =
struct btf *base_btf)
 	int err =3D 0;
 	long sz;
=20
-	f =3D fopen(path, "rb");
+	f =3D fopen(path, "rbe");
 	if (!f) {
 		err =3D -errno;
 		goto err_out;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1ceb3a97dadc..60ef4c5e3bee 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4351,7 +4351,7 @@ static int bpf_get_map_info_from_fdinfo(int fd, str=
uct bpf_map_info *info)
 	snprintf(file, sizeof(file), "/proc/%d/fdinfo/%d", getpid(), fd);
 	memset(info, 0, sizeof(*info));
=20
-	fp =3D fopen(file, "r");
+	fp =3D fopen(file, "re");
 	if (!fp) {
 		err =3D -errno;
 		pr_warn("failed to open %s: %d. No procfs support?\n", file,
@@ -7455,7 +7455,7 @@ int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *c=
tx)
 	int ret, err =3D 0;
 	FILE *f;
=20
-	f =3D fopen("/proc/kallsyms", "r");
+	f =3D fopen("/proc/kallsyms", "re");
 	if (!f) {
 		err =3D -errno;
 		pr_warn("failed to open /proc/kallsyms: %d\n", err);
@@ -10075,7 +10075,7 @@ static int parse_uint_from_file(const char *file,=
 const char *fmt)
 	int err, ret;
 	FILE *f;
=20
-	f =3D fopen(file, "r");
+	f =3D fopen(file, "re");
 	if (!f) {
 		err =3D -errno;
 		pr_debug("failed to open '%s': %s\n", file,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
index 6065f408a59c..5f78a023b474 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -38,7 +38,7 @@ static __u32 get_ubuntu_kernel_version(void)
 	if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) !=3D 0)
 		return 0;
=20
-	f =3D fopen(ubuntu_kver_file, "r");
+	f =3D fopen(ubuntu_kver_file, "re");
 	if (!f)
 		return 0;
=20
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 086eef355ab3..f1a141555f08 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -466,7 +466,7 @@ static int parse_vma_segs(int pid, const char *lib_pa=
th, struct elf_seg **segs,
=20
 proceed:
 	sprintf(line, "/proc/%d/maps", pid);
-	f =3D fopen(line, "r");
+	f =3D fopen(line, "re");
 	if (!f) {
 		err =3D -errno;
 		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %d\n",
@@ -954,8 +954,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt=
_manager *man, const struct
 	spec_map_fd =3D bpf_map__fd(man->specs_map);
 	ip_map_fd =3D bpf_map__fd(man->ip_to_spec_id_map);
=20
-	/* TODO: perform path resolution similar to uprobe's */
-	fd =3D open(path, O_RDONLY);
+	fd =3D open(path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		err =3D -errno;
 		pr_warn("usdt: failed to open ELF binary '%s': %d\n", path, err);
--=20
2.34.1


