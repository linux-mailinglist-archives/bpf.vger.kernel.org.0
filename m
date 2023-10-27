Return-Path: <bpf+bounces-13438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D97D9F9B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970D61C210E0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426213C067;
	Fri, 27 Oct 2023 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD38827
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:14:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F9C0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE6Fel032331
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tyws60df6-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:14:02 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:13:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 43A0B3A79651F; Fri, 27 Oct 2023 11:13:49 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 01/23] selftests/bpf: fix RELEASE=1 build for tc_opts
Date: Fri, 27 Oct 2023 11:13:24 -0700
Message-ID: <20231027181346.4019398-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B-iv3WJkXF3tdnq_LNo17liWqYNKI84F
X-Proofpoint-ORIG-GUID: B-iv3WJkXF3tdnq_LNo17liWqYNKI84F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

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


