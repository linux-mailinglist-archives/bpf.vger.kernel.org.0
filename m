Return-Path: <bpf+bounces-13887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010C7DEB73
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874541C20E4C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A81865;
	Thu,  2 Nov 2023 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FF1860
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 03:38:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA965110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:38:09 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A21WRUi030215
	for <bpf@vger.kernel.org>; Wed, 1 Nov 2023 20:38:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u3vb43rfn-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 20:38:09 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 20:38:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 01ACE3AC97EA6; Wed,  1 Nov 2023 20:38:02 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v6 bpf-next 01/17] selftests/bpf: fix RELEASE=1 build for tc_opts
Date: Wed, 1 Nov 2023 20:37:43 -0700
Message-ID: <20231102033759.2541186-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102033759.2541186-1-andrii@kernel.org>
References: <20231102033759.2541186-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OMjzDvpuhbgnrZmJ5gw3Vbn1diG0YKMQ
X-Proofpoint-GUID: OMjzDvpuhbgnrZmJ5gw3Vbn1diG0YKMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

Compiler complains about malloc(). We also don't need to dynamically
allocate anything, so make the life easier by using statically sized
buffer.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_opts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/tes=
ting/selftests/bpf/prog_tests/tc_opts.c
index 51883ccb8020..196abf223465 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2387,12 +2387,9 @@ static int generate_dummy_prog(void)
 	const size_t prog_insn_cnt =3D sizeof(prog_insns) / sizeof(struct bpf_i=
nsn);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	const size_t log_buf_sz =3D 256;
-	char *log_buf;
+	char log_buf[log_buf_sz];
 	int fd =3D -1;
=20
-	log_buf =3D malloc(log_buf_sz);
-	if (!ASSERT_OK_PTR(log_buf, "log_buf_alloc"))
-		return fd;
 	opts.log_buf =3D log_buf;
 	opts.log_size =3D log_buf_sz;
=20
@@ -2402,7 +2399,6 @@ static int generate_dummy_prog(void)
 			   prog_insns, prog_insn_cnt, &opts);
 	ASSERT_STREQ(log_buf, "", "log_0");
 	ASSERT_GE(fd, 0, "prog_fd");
-	free(log_buf);
 	return fd;
 }
=20
--=20
2.34.1


