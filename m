Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6834B4A7BFB
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbiBBX4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 18:56:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240027AbiBBX4q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 18:56:46 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LqP2D026005
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 15:56:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=i5ol7Mr61DgAFtNPPbpjske+Vg94OU51iNOxmTSoZtk=;
 b=lsQZOQSecHlv+KfBjJu6PKt170EmR6lLEFBDFqM85KJaYH5Oxaon1Y6kolnutRt8PvLK
 Ls2hZQxhUbbJfVgHvfblgSLjx7noz+0ExVNNd9wy8eqWDzuo7PivxcCtVrwMrLC4WFvY
 ctu1QMyUMo8e4eMpJCvNNg/8xm77DoRee+8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyjxu6bjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 15:56:46 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:56:45 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 984CD1C61C20C; Wed,  2 Feb 2022 15:56:34 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v3 3/4] bpftool: migrate from bpf_prog_test_run_xattr
Date:   Wed, 2 Feb 2022 15:54:22 -0800
Message-ID: <20220202235423.1097270-4-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202235423.1097270-1-delyank@fb.com>
References: <20220202235423.1097270-1-delyank@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: l7oCDn4xXtu08R0pqokP3EyyD4QcjG2v
X-Proofpoint-ORIG-GUID: l7oCDn4xXtu08R0pqokP3EyyD4QcjG2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=685 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_test_run is being deprecated in favor of the OPTS-based
bpf_prog_test_run_opts.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/prog.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 87593f98d2d1..92a6f679ef7d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1272,12 +1272,12 @@ static int do_run(int argc, char **argv)
 {
 	char *data_fname_in =3D NULL, *data_fname_out =3D NULL;
 	char *ctx_fname_in =3D NULL, *ctx_fname_out =3D NULL;
-	struct bpf_prog_test_run_attr test_attr =3D {0};
 	const unsigned int default_size =3D SZ_32K;
 	void *data_in =3D NULL, *data_out =3D NULL;
 	void *ctx_in =3D NULL, *ctx_out =3D NULL;
 	unsigned int repeat =3D 1;
 	int fd, err;
+	LIBBPF_OPTS(bpf_test_run_opts, test_attr);
=20
 	if (!REQ_ARGS(4))
 		return -1;
@@ -1395,14 +1395,13 @@ static int do_run(int argc, char **argv)
 			goto free_ctx_in;
 	}
=20
-	test_attr.prog_fd	=3D fd;
 	test_attr.repeat	=3D repeat;
 	test_attr.data_in	=3D data_in;
 	test_attr.data_out	=3D data_out;
 	test_attr.ctx_in	=3D ctx_in;
 	test_attr.ctx_out	=3D ctx_out;
=20
-	err =3D bpf_prog_test_run_xattr(&test_attr);
+	err =3D bpf_prog_test_run_opts(fd, &test_attr);
 	if (err) {
 		p_err("failed to run program: %s", strerror(errno));
 		goto free_ctx_out;
--=20
2.30.2

