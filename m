Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44994473BA6
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhLNDmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 22:42:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230072AbhLNDmw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 22:42:52 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BDMeL1U001554
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:42:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4Okq4/fiNMdHy/XJtrFpTMVXl/DlOMjqG/5lc7OA0ic=;
 b=fI4cgt5UBO+/TemlZ2vFPD7/lRv+G6gwFMzySG+JvTRV4lD5CSqL586foJJN+czfR3Aq
 5ygHIAfd2O+GnadUpxscGRbtAvmKrDwUcx935Du4kyiTwNs55GyzRu9gSUs7JMaKvVfB
 /Pm3BF0hZk0WotHZ0b2AEypkdNlSLI1AeEs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3cx9rn4bd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:42:51 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 19:42:50 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 326E4112FDAC; Mon, 13 Dec 2021 19:42:49 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v3 bpf-next 2/4] samples/bpf: Stop using bpf_object__find_program_by_title API.
Date:   Mon, 13 Dec 2021 19:41:45 -0800
Message-ID: <20211214034147.1071682-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214034147.1071682-1-kuifeng@fb.com>
References: <20211214034147.1071682-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: YzBVyN4KTlPiyIuWzKc5DkQVnq3Xo1de
X-Proofpoint-GUID: YzBVyN4KTlPiyIuWzKc5DkQVnq3Xo1de
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_01,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__find_program_by_title is going to be deprecated.
Replace use cases of bpf_object__find_program_by_title in samples/bpf/
with bpf_object__for_each_program.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 samples/bpf/hbm.c          | 11 ++++++++++-
 samples/bpf/xdp_fwd_user.c | 12 ++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index b0c18efe7928..1fe5bcafb3bc 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -120,6 +120,9 @@ static void do_error(char *msg, bool errno_flag)
=20
 static int prog_load(char *prog)
 {
+	struct bpf_program *pos;
+	const char *sec_name;
+
 	obj =3D bpf_object__open_file(prog, NULL);
 	if (libbpf_get_error(obj)) {
 		printf("ERROR: opening BPF object file failed\n");
@@ -132,7 +135,13 @@ static int prog_load(char *prog)
 		goto err;
 	}
=20
-	bpf_prog =3D bpf_object__find_program_by_title(obj, "cgroup_skb/egress"=
);
+	bpf_object__for_each_program(pos, obj) {
+		sec_name =3D bpf_program__section_name(pos);
+		if (sec_name && !strcmp(sec_name, "cgroup_skb/egress")) {
+			bpf_prog =3D pos;
+			break;
+		}
+	}
 	if (!bpf_prog) {
 		printf("ERROR: finding a prog in obj file failed\n");
 		goto err;
diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 00061261a8da..4ad896782f77 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -79,7 +79,9 @@ int main(int argc, char **argv)
 		.prog_type	=3D BPF_PROG_TYPE_XDP,
 	};
 	const char *prog_name =3D "xdp_fwd";
-	struct bpf_program *prog;
+	struct bpf_program *prog =3D NULL;
+	struct bpf_program *pos;
+	const char *sec_name;
 	int prog_fd, map_fd =3D -1;
 	char filename[PATH_MAX];
 	struct bpf_object *obj;
@@ -134,7 +136,13 @@ int main(int argc, char **argv)
 			return 1;
 		}
=20
-		prog =3D bpf_object__find_program_by_title(obj, prog_name);
+		bpf_object__for_each_program(pos, obj) {
+			sec_name =3D bpf_program__section_name(pos);
+			if (sec_name && !strcmp(sec_name, prog_name)) {
+				prog =3D pos;
+				break;
+			}
+		}
 		prog_fd =3D bpf_program__fd(prog);
 		if (prog_fd < 0) {
 			printf("program not found: %s\n", strerror(prog_fd));
--=20
2.30.2

