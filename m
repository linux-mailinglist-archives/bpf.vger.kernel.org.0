Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A649EF18
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 00:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbiA0X6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 18:58:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59970 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240891AbiA0X6j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 18:58:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RNafcr005594
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 15:58:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CmHLlBUtP+5T+Zc9veGrSamajqHy5dxhw2lVZKB7H7M=;
 b=mrlCONCTA6sAuLDdBZjKFbn5EdXbXOJg9o7JJUufcyjxrFwEwN+4FxcOuXip8AwKAUys
 rPuhP+s2dfRtlqIh6UeGYBB20kra4gYiA/liC6ZYKDrsUVU2Wg+Vm9GZ26m08PLnPfUC
 LlNCiT1y5UmThI9yLC9eiUcv9ReOy0BCzcw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujv3xfxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 15:58:38 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 15:58:37 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id A2F681C1148A8; Thu, 27 Jan 2022 15:58:25 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next 3/3] libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run
Date:   Thu, 27 Jan 2022 15:58:05 -0800
Message-ID: <20220127235805.1608540-4-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127235805.1608540-1-delyank@fb.com>
References: <20220127235805.1608540-1-delyank@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ccu4Y52AooXMKcTpIZQIK0DgmfWTVOFc
X-Proofpoint-GUID: ccu4Y52AooXMKcTpIZQIK0DgmfWTVOFc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=741 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Closes: https://github.com/libbpf/libbpf/issues/286
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/bpf.h |  8 +++++---
 tools/lib/bpf/xsk.c | 11 +++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c2e8327010f9..e3d87b35435d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -453,13 +453,15 @@ struct bpf_prog_test_run_attr {
 			     * out: length of cxt_out */
 };
=20
-LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test=
_attr);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
+int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr);
=20
 /*
  * bpf_prog_test_run does not check that data_out is large enough. Consider
- * using bpf_prog_test_run_xattr instead.
+ * using bpf_prog_test_run_opts instead.
  */
-LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
+int bpf_prog_test_run(int prog_fd, int repeat, void *data,
 				 __u32 size, void *data_out, __u32 *size_out,
 				 __u32 *retval, __u32 *duration);
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index edafe56664f3..843d03b8f58c 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -369,8 +369,7 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr,=
 void *umem_area,
 static enum xsk_prog get_xsk_prog(void)
 {
 	enum xsk_prog detected =3D XSK_PROG_FALLBACK;
-	__u32 size_out, retval, duration;
-	char data_in =3D 0, data_out;
+	char data_in =3D 0;
 	struct bpf_insn insns[] =3D {
 		BPF_LD_MAP_FD(BPF_REG_1, 0),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
@@ -378,6 +377,10 @@ static enum xsk_prog get_xsk_prog(void)
 		BPF_EMIT_CALL(BPF_FUNC_redirect_map),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_test_run_opts, test_opts,
+		.data_in =3D &data_in,
+		.data_size_in =3D 1,
+	);
 	int prog_fd, map_fd, ret, insn_cnt =3D ARRAY_SIZE(insns);
=20
 	map_fd =3D bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL, sizeof(int), sizeof(=
int), 1, NULL);
@@ -392,8 +395,8 @@ static enum xsk_prog get_xsk_prog(void)
 		return detected;
 	}
=20
-	ret =3D bpf_prog_test_run(prog_fd, 0, &data_in, 1, &data_out, &size_out, =
&retval, &duration);
-	if (!ret && retval =3D=3D XDP_PASS)
+	ret =3D bpf_prog_test_run_opts(prog_fd, &test_opts);
+	if (!ret && test_opts.retval =3D=3D XDP_PASS)
 		detected =3D XSK_PROG_REDIRECT_FLAGS;
 	close(prog_fd);
 	close(map_fd);
--=20
2.30.2

