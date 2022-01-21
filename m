Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110A6495774
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378442AbiAUAlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 19:41:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23884 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378441AbiAUAlb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 19:41:31 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L04HnM017872
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqhyg055x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:31 -0800
Received: from twshared14302.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 20 Jan 2022 16:41:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 003C2FCAD2B4; Thu, 20 Jan 2022 16:41:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/7] selftests/bpf: use preferred setter/getter APIs instead of deprecated ones
Date:   Thu, 20 Jan 2022 16:41:13 -0800
Message-ID: <20220121004115.3845888-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121004115.3845888-1-andrii@kernel.org>
References: <20220121004115.3845888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xCshcX3DbEQvFHewmQryABYxL4hor6o8
X-Proofpoint-GUID: xCshcX3DbEQvFHewmQryABYxL4hor6o8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to using preferred setters and getters instead of deprecated ones.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/benchs/bench_ringbufs.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c          | 2 +-
 .../selftests/bpf/prog_tests/get_stackid_cannot_attach.c        | 2 +-
 .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index da8593b3494a..c2554f9695ff 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -151,7 +151,7 @@ static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 		/* record data + header take 16 bytes */
 		skel->rodata->wakeup_data_size = args.sample_rate * 16;
 
-	bpf_map__resize(skel->maps.ringbuf, args.ringbuf_sz);
+	bpf_map__set_max_entries(skel->maps.ringbuf, args.ringbuf_sz);
 
 	if (ringbuf_bench__load(skel)) {
 		fprintf(stderr, "failed to load skeleton\n");
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index c52f99f6a909..e83575e5480f 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -132,7 +132,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 					     &link_info, &info_len);
 		ASSERT_OK(err, "link_fd_get_info");
 		ASSERT_EQ(link_info.tracing.attach_type,
-			  bpf_program__get_expected_attach_type(prog[i]),
+			  bpf_program__expected_attach_type(prog[i]),
 			  "link_attach_type");
 		ASSERT_EQ(link_info.tracing.target_obj_id, tgt_prog_id, "link_tgt_obj_id");
 		ASSERT_EQ(link_info.tracing.target_btf_id, btf_id, "link_tgt_btf_id");
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
index 8d5a6023a1bb..5308de1ed478 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
@@ -27,7 +27,7 @@ void test_get_stackid_cannot_attach(void)
 		return;
 
 	/* override program type */
-	bpf_program__set_perf_event(skel->progs.oncpu);
+	bpf_program__set_type(skel->progs.oncpu, BPF_PROG_TYPE_PERF_EVENT);
 
 	err = test_stacktrace_build_id__load(skel);
 	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index 0a91d8d9954b..f45a1d7b0a28 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -42,7 +42,7 @@ void test_stacktrace_build_id_nmi(void)
 		return;
 
 	/* override program type */
-	bpf_program__set_perf_event(skel->progs.oncpu);
+	bpf_program__set_type(skel->progs.oncpu, BPF_PROG_TYPE_PERF_EVENT);
 
 	err = test_stacktrace_build_id__load(skel);
 	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
-- 
2.30.2

