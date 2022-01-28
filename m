Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E349F07C
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 02:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbiA1BXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 20:23:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51006 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344622AbiA1BXj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 20:23:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RNacw2005408
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:23:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xHh8N/PPB/iULui+5aVxLZ40s/lOuk/q/vP+616KAEE=;
 b=qQvqlySuaJtf6kLQhTeJ5GTKKeV17i8VgFNcg/SS3rjw6QmR17ns+Gqk3fHzwFcIR77l
 DpnxxJkPyDfmuAXdEl9Wy3JrF6cEUKgWJdMiBfNPPjWSCIvVo6EdHEz15FC0YGAbAhWX
 5JQFgBy+tlqfB76S1L9KiBwJINX2v6g3pMI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujv3xxta-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 17:23:38 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:23:36 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 72A721C1215E9; Thu, 27 Jan 2022 17:23:28 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v2 3/4] bpftool: migrate from bpf_prog_test_run_xattr
Date:   Thu, 27 Jan 2022 17:23:18 -0800
Message-ID: <20220128012319.2494472-4-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128012319.2494472-1-delyank@fb.com>
References: <20220128012319.2494472-1-delyank@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: inSJNNovLlRDnVt4fB0uPA8P5wj7uOB9
X-Proofpoint-GUID: inSJNNovLlRDnVt4fB0uPA8P5wj7uOB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=832 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201280004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_prog_test_run_xattr is being deprecated in favor of bpf_prog_test_run=
_opts.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/bpf/bpftool/prog.c | 55 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 87593f98d2d1..4f96c229ba77 100644
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
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
=20
 	if (!REQ_ARGS(4))
 		return -1;
@@ -1315,7 +1315,7 @@ static int do_run(int argc, char **argv)
 			if (!REQ_ARGS(1))
 				return -1;
=20
-			test_attr.data_size_out =3D strtoul(*argv, &endptr, 0);
+			topts.data_size_out =3D strtoul(*argv, &endptr, 0);
 			if (*endptr) {
 				p_err("can't parse %s as output data size",
 				      *argv);
@@ -1343,7 +1343,7 @@ static int do_run(int argc, char **argv)
 			if (!REQ_ARGS(1))
 				return -1;
=20
-			test_attr.ctx_size_out =3D strtoul(*argv, &endptr, 0);
+			topts.ctx_size_out =3D strtoul(*argv, &endptr, 0);
 			if (*endptr) {
 				p_err("can't parse %s as output context size",
 				      *argv);
@@ -1371,38 +1371,37 @@ static int do_run(int argc, char **argv)
 		}
 	}
=20
-	err =3D get_run_data(data_fname_in, &data_in, &test_attr.data_size_in);
+	err =3D get_run_data(data_fname_in, &data_in, &topts.data_size_in);
 	if (err)
 		return -1;
=20
 	if (data_in) {
-		if (!test_attr.data_size_out)
-			test_attr.data_size_out =3D default_size;
-		err =3D alloc_run_data(&data_out, test_attr.data_size_out);
+		if (!topts.data_size_out)
+			topts.data_size_out =3D default_size;
+		err =3D alloc_run_data(&data_out, topts.data_size_out);
 		if (err)
 			goto free_data_in;
 	}
=20
-	err =3D get_run_data(ctx_fname_in, &ctx_in, &test_attr.ctx_size_in);
+	err =3D get_run_data(ctx_fname_in, &ctx_in, &topts.ctx_size_in);
 	if (err)
 		goto free_data_out;
=20
 	if (ctx_in) {
-		if (!test_attr.ctx_size_out)
-			test_attr.ctx_size_out =3D default_size;
-		err =3D alloc_run_data(&ctx_out, test_attr.ctx_size_out);
+		if (!topts.ctx_size_out)
+			topts.ctx_size_out =3D default_size;
+		err =3D alloc_run_data(&ctx_out, topts.ctx_size_out);
 		if (err)
 			goto free_ctx_in;
 	}
=20
-	test_attr.prog_fd	=3D fd;
-	test_attr.repeat	=3D repeat;
-	test_attr.data_in	=3D data_in;
-	test_attr.data_out	=3D data_out;
-	test_attr.ctx_in	=3D ctx_in;
-	test_attr.ctx_out	=3D ctx_out;
+	topts.repeat	=3D repeat;
+	topts.data_in	=3D data_in;
+	topts.data_out	=3D data_out;
+	topts.ctx_in	=3D ctx_in;
+	topts.ctx_out	=3D ctx_out;
=20
-	err =3D bpf_prog_test_run_xattr(&test_attr);
+	err =3D bpf_prog_test_run_opts(fd, &topts);
 	if (err) {
 		p_err("failed to run program: %s", strerror(errno));
 		goto free_ctx_out;
@@ -1416,23 +1415,23 @@ static int do_run(int argc, char **argv)
 	/* Do not exit on errors occurring when printing output data/context,
 	 * we still want to print return value and duration for program run.
 	 */
-	if (test_attr.data_size_out)
-		err +=3D print_run_output(test_attr.data_out,
-					test_attr.data_size_out,
+	if (topts.data_size_out)
+		err +=3D print_run_output(topts.data_out,
+					topts.data_size_out,
 					data_fname_out, "data_out");
-	if (test_attr.ctx_size_out)
-		err +=3D print_run_output(test_attr.ctx_out,
-					test_attr.ctx_size_out,
+	if (topts.ctx_size_out)
+		err +=3D print_run_output(topts.ctx_out,
+					topts.ctx_size_out,
 					ctx_fname_out, "ctx_out");
=20
 	if (json_output) {
-		jsonw_uint_field(json_wtr, "retval", test_attr.retval);
-		jsonw_uint_field(json_wtr, "duration", test_attr.duration);
+		jsonw_uint_field(json_wtr, "retval", topts.retval);
+		jsonw_uint_field(json_wtr, "duration", topts.duration);
 		jsonw_end_object(json_wtr);	/* root */
 	} else {
 		fprintf(stdout, "Return value: %u, duration%s: %uns\n",
-			test_attr.retval,
-			repeat > 1 ? " (average)" : "", test_attr.duration);
+			topts.retval,
+			repeat > 1 ? " (average)" : "", topts.duration);
 	}
=20
 free_ctx_out:
--=20
2.30.2

