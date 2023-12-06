Return-Path: <bpf+bounces-16919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCE807865
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E101C20F44
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7E675D7;
	Wed,  6 Dec 2023 19:09:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C686D193
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 11:09:31 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IgiUm031662
	for <bpf@vger.kernel.org>; Wed, 6 Dec 2023 11:09:30 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3utd1ceyug-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 11:09:30 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 6 Dec 2023 11:09:28 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id EE1F63CB26C09; Wed,  6 Dec 2023 11:09:21 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] bpf: rename MAX_BPF_LINK_TYPE into __MAX_BPF_LINK_TYPE for consistency
Date: Wed, 6 Dec 2023 11:09:20 -0800
Message-ID: <20231206190920.1651226-1-andrii@kernel.org>
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
X-Proofpoint-GUID: dkvfZzgITx9fwnkVRPrNOpVNCMijSRsr
X-Proofpoint-ORIG-GUID: dkvfZzgITx9fwnkVRPrNOpVNCMijSRsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02

To stay consistent with the naming pattern used for similar cases in BPF
UAPI (__MAX_BPF_ATTACH_TYPE, etc), rename MAX_BPF_LINK_TYPE into
__MAX_BPF_LINK_TYPE.

Also similar to MAX_BPF_ATTACH_TYPE and MAX_BPF_REG, add:

  #define MAX_BPF_LINK_TYPE __MAX_BPF_LINK_TYPE

Not all __MAX_xxx enums have such #define, so I'm not sure if we should
add it or not, but I figured I'll start with a completely backwards
compatible way, and we can drop that, if necessary.

Also adjust a selftest that used MAX_BPF_LINK_TYPE enum.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h                            | 4 +++-
 tools/include/uapi/linux/bpf.h                      | 4 +++-
 tools/testing/selftests/bpf/prog_tests/libbpf_str.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4df2d025c784..e0545201b55f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1108,9 +1108,11 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
-	MAX_BPF_LINK_TYPE,
+	__MAX_BPF_LINK_TYPE,
 };
=20
+#define MAX_BPF_LINK_TYPE __MAX_BPF_LINK_TYPE
+
 enum bpf_perf_event_type {
 	BPF_PERF_EVENT_UNSPEC =3D 0,
 	BPF_PERF_EVENT_UPROBE =3D 1,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 4df2d025c784..e0545201b55f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1108,9 +1108,11 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_TCX =3D 11,
 	BPF_LINK_TYPE_UPROBE_MULTI =3D 12,
 	BPF_LINK_TYPE_NETKIT =3D 13,
-	MAX_BPF_LINK_TYPE,
+	__MAX_BPF_LINK_TYPE,
 };
=20
+#define MAX_BPF_LINK_TYPE __MAX_BPF_LINK_TYPE
+
 enum bpf_perf_event_type {
 	BPF_PERF_EVENT_UNSPEC =3D 0,
 	BPF_PERF_EVENT_UPROBE =3D 1,
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/=
testing/selftests/bpf/prog_tests/libbpf_str.c
index 384bc1f7a65e..62ea855ec4d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -87,7 +87,7 @@ static void test_libbpf_bpf_link_type_str(void)
 		const char *link_type_str;
 		char buf[256];
=20
-		if (link_type =3D=3D MAX_BPF_LINK_TYPE)
+		if (link_type =3D=3D __MAX_BPF_LINK_TYPE)
 			continue;
=20
 		link_type_name =3D btf__str_by_offset(btf, e->name_off);
--=20
2.34.1


