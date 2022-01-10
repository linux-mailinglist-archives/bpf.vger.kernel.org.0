Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416E48A309
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiAJWgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:36:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242335AbiAJWgJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 17:36:09 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AJYwd0009425
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:36:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4Okq4/fiNMdHy/XJtrFpTMVXl/DlOMjqG/5lc7OA0ic=;
 b=QzpCMMD5DXMhgfPhPkk/EWsmryJK1Z9Gij+LLAuc0JEtomvexd/E+5Y5DmdZipv2Ci2S
 hIHd9aOwtLNU/1GHJacoJ5N7nEyDnpO4Uwg4T855K7BxF3rcuR5fLnTAC+J08eWqsONP
 Jp8h+QWon78JG5GKFgQES+eQBsUPo4FNNTI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgt8m1qpp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:36:09 -0800
Received: from twshared3205.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 14:36:07 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 86B6D212475A; Mon, 10 Jan 2022 14:36:04 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v4 bpf-next 2/4] samples/bpf: Stop using bpf_object__find_program_by_title API.
Date:   Mon, 10 Jan 2022 14:34:44 -0800
Message-ID: <20220110223446.345531-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110223446.345531-1-kuifeng@fb.com>
References: <20220110223446.345531-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WIz-wb6Z9IpyYhBkdhOznjAIvj2kYfIm
X-Proofpoint-ORIG-GUID: WIz-wb6Z9IpyYhBkdhOznjAIvj2kYfIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100146
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

