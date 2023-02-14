Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6ED69719C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjBNXNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjBNXM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07761BEF
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:55 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EMC3Q7019684;
        Tue, 14 Feb 2023 23:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qPOkdEXxLRscKOLlsdPRxjwxikRWyYsxJqvYw4KIrM8=;
 b=WEwuKP93+aCmt7KYdNpH/hdnHLRj6J1NY0Yki9D7SvXK4W7e7xqpH9rZh12aDElHIEvs
 dayqxW2Bm8NEbjJtwfkS6eEGwrnhQlRCMHWqSyfrRVMJr+ozkZSFMcPgAruRPB+gy5au
 wdCFg51Vyqx+6sdqsSpP8095KFZhk3yQ3zWl1F6+4131QIffKxiCHxPyX1w6a4/IxGdP
 nTdqhyDiLhlI3WZalLTK/Zg5uC/s0jl1/mEm0Y9mp1fFQYqwPK3r6r+WXsV3XrfFEd6j
 eGsyaxxDENJJCAUoN8tGevkJsWmYE7gRyGEcWT+g2i7D8ckxytkp2fKh55PpnKKqh2LB 3w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrjvj9n2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E6HCX4007478;
        Tue, 14 Feb 2023 23:12:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29fbeft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCUI547710682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0617220043;
        Tue, 14 Feb 2023 23:12:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE4320040;
        Tue, 14 Feb 2023 23:12:29 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 5/8] selftests/bpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Wed, 15 Feb 2023 00:12:18 +0100
Message-Id: <20230214231221.249277-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kUHYnv0uzwfIwZGe2VfBhZ0d5Iu-dRBz
X-Proofpoint-ORIG-GUID: kUHYnv0uzwfIwZGe2VfBhZ0d5Iu-dRBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new type-safe wrappers around bpf_obj_get_info_by_fd().
Fix a prog/map mixup in prog_holds_map().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../bpf/map_tests/map_in_map_batch_ops.c      |  2 +-
 .../selftests/bpf/prog_tests/bpf_iter.c       |  8 +++----
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 20 ++++++++--------
 tools/testing/selftests/bpf/prog_tests/btf.c  | 24 +++++++++----------
 .../selftests/bpf/prog_tests/btf_map_in_map.c |  2 +-
 .../selftests/bpf/prog_tests/check_mtu.c      |  2 +-
 .../selftests/bpf/prog_tests/enable_stats.c   |  2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 14 +++++------
 .../bpf/prog_tests/flow_dissector_reattach.c  | 10 ++++----
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  4 ++--
 .../selftests/bpf/prog_tests/lsm_cgroup.c     |  3 ++-
 .../selftests/bpf/prog_tests/metadata.c       |  8 +++----
 tools/testing/selftests/bpf/prog_tests/mmap.c |  2 +-
 .../selftests/bpf/prog_tests/perf_link.c      |  2 +-
 .../selftests/bpf/prog_tests/pinning.c        |  2 +-
 .../selftests/bpf/prog_tests/prog_run_opts.c  |  2 +-
 .../selftests/bpf/prog_tests/recursion.c      |  4 ++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  6 ++---
 .../bpf/prog_tests/task_local_storage.c       |  8 +++----
 .../testing/selftests/bpf/prog_tests/tc_bpf.c |  4 ++--
 .../bpf/prog_tests/tp_attach_query.c          |  5 ++--
 .../bpf/prog_tests/unpriv_bpf_disabled.c      |  8 +++----
 .../selftests/bpf/prog_tests/verif_stats.c    |  5 ++--
 .../selftests/bpf/prog_tests/xdp_attach.c     |  4 ++--
 .../bpf/prog_tests/xdp_cpumap_attach.c        |  8 +++----
 .../bpf/prog_tests/xdp_devmap_attach.c        |  8 +++----
 .../selftests/bpf/prog_tests/xdp_info.c       |  2 +-
 .../selftests/bpf/prog_tests/xdp_link.c       | 10 ++++----
 tools/testing/selftests/bpf/test_maps.c       |  2 +-
 .../selftests/bpf/test_skb_cgroup_id_user.c   |  2 +-
 .../bpf/test_tcp_check_syncookie_user.c       |  2 +-
 tools/testing/selftests/bpf/test_verifier.c   |  8 +++----
 tools/testing/selftests/bpf/testing_helpers.c |  2 +-
 tools/testing/selftests/bpf/xdp_synproxy.c    | 15 +++++++-----
 34 files changed, 109 insertions(+), 101 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
index f472d28ad11a..16f1671e4bde 100644
--- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
@@ -18,7 +18,7 @@ static __u32 get_map_id_from_fd(int map_fd)
 	uint32_t info_len = sizeof(map_info);
 	int ret;
 
-	ret = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+	ret = bpf_map_get_info_by_fd(map_fd, &map_info, &info_len);
 	CHECK(ret < 0, "Finding map info failed", "error:%s\n",
 	      strerror(errno));
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 3af6450763e9..1f02168103dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -195,8 +195,8 @@ static void check_bpf_link_info(const struct bpf_program *prog)
 		return;
 
 	info_len = sizeof(info);
-	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &info, &info_len);
-	ASSERT_OK(err, "bpf_obj_get_info_by_fd");
+	err = bpf_link_get_info_by_fd(bpf_link__fd(link), &info, &info_len);
+	ASSERT_OK(err, "bpf_link_get_info_by_fd");
 	ASSERT_EQ(info.iter.task.tid, getpid(), "check_task_tid");
 
 	bpf_link__destroy(link);
@@ -684,13 +684,13 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 
 	/* setup filtering map_id in bpf program */
 	map_info_len = sizeof(map_info);
-	err = bpf_obj_get_info_by_fd(map1_fd, &map_info, &map_info_len);
+	err = bpf_map_get_info_by_fd(map1_fd, &map_info, &map_info_len);
 	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
 		  strerror(errno)))
 		goto free_map2;
 	skel->bss->map1_id = map_info.id;
 
-	err = bpf_obj_get_info_by_fd(map2_fd, &map_info, &map_info_len);
+	err = bpf_map_get_info_by_fd(map2_fd, &map_info, &map_info_len);
 	if (CHECK(err, "get_map_info", "get map info failed: %s\n",
 		  strerror(errno)))
 		goto free_map2;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
index e1c1e521cca2..675b90b15280 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -44,7 +44,7 @@ void serial_test_bpf_obj_id(void)
 	CHECK(err >= 0 || errno != ENOENT,
 	      "get-fd-by-notexist-link-id", "err %d errno %d\n", err, errno);
 
-	/* Check bpf_obj_get_info_by_fd() */
+	/* Check bpf_map_get_info_by_fd() */
 	bzero(zeros, sizeof(zeros));
 	for (i = 0; i < nr_iters; i++) {
 		now = time(NULL);
@@ -79,7 +79,7 @@ void serial_test_bpf_obj_id(void)
 		/* Check getting map info */
 		info_len = sizeof(struct bpf_map_info) * 2;
 		bzero(&map_infos[i], info_len);
-		err = bpf_obj_get_info_by_fd(map_fds[i], &map_infos[i],
+		err = bpf_map_get_info_by_fd(map_fds[i], &map_infos[i],
 					     &info_len);
 		if (CHECK(err ||
 			  map_infos[i].type != BPF_MAP_TYPE_ARRAY ||
@@ -118,8 +118,8 @@ void serial_test_bpf_obj_id(void)
 		err = clock_gettime(CLOCK_BOOTTIME, &boot_time_ts);
 		if (CHECK_FAIL(err))
 			goto done;
-		err = bpf_obj_get_info_by_fd(prog_fds[i], &prog_infos[i],
-					     &info_len);
+		err = bpf_prog_get_info_by_fd(prog_fds[i], &prog_infos[i],
+					      &info_len);
 		load_time = (real_time_ts.tv_sec - boot_time_ts.tv_sec)
 			+ (prog_infos[i].load_time / nsec_per_sec);
 		if (CHECK(err ||
@@ -161,8 +161,8 @@ void serial_test_bpf_obj_id(void)
 		bzero(&link_infos[i], info_len);
 		link_infos[i].raw_tracepoint.tp_name = ptr_to_u64(&tp_name);
 		link_infos[i].raw_tracepoint.tp_name_len = sizeof(tp_name);
-		err = bpf_obj_get_info_by_fd(bpf_link__fd(links[i]),
-					     &link_infos[i], &info_len);
+		err = bpf_link_get_info_by_fd(bpf_link__fd(links[i]),
+					      &link_infos[i], &info_len);
 		if (CHECK(err ||
 			  link_infos[i].type != BPF_LINK_TYPE_RAW_TRACEPOINT ||
 			  link_infos[i].prog_id != prog_infos[i].id ||
@@ -217,7 +217,7 @@ void serial_test_bpf_obj_id(void)
 		 * prog_info.map_ids = NULL
 		 */
 		prog_info.nr_map_ids = 1;
-		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+		err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
 		if (CHECK(!err || errno != EFAULT,
 			  "get-prog-fd-bad-nr-map-ids", "err %d errno %d(%d)",
 			  err, errno, EFAULT))
@@ -228,7 +228,7 @@ void serial_test_bpf_obj_id(void)
 		saved_map_id = *(int *)((long)prog_infos[i].map_ids);
 		prog_info.map_ids = prog_infos[i].map_ids;
 		prog_info.nr_map_ids = 2;
-		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+		err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
 		prog_infos[i].jited_prog_insns = 0;
 		prog_infos[i].xlated_prog_insns = 0;
 		CHECK(err || info_len != sizeof(struct bpf_prog_info) ||
@@ -277,7 +277,7 @@ void serial_test_bpf_obj_id(void)
 		if (CHECK_FAIL(err))
 			goto done;
 
-		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+		err = bpf_map_get_info_by_fd(map_fd, &map_info, &info_len);
 		CHECK(err || info_len != sizeof(struct bpf_map_info) ||
 		      memcmp(&map_info, &map_infos[i], info_len) ||
 		      array_value != array_magic_value,
@@ -322,7 +322,7 @@ void serial_test_bpf_obj_id(void)
 
 		nr_id_found++;
 
-		err = bpf_obj_get_info_by_fd(link_fd, &link_info, &info_len);
+		err = bpf_link_get_info_by_fd(link_fd, &link_info, &info_len);
 		cmp_res = memcmp(&link_info, &link_infos[i],
 				offsetof(struct bpf_link_info, raw_tracepoint));
 		CHECK(err || info_len != sizeof(link_info) || cmp_res,
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index de1b5b9eb93a..cbb600be943d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4422,7 +4422,7 @@ static int test_big_btf_info(unsigned int test_num)
 	info->btf = ptr_to_u64(user_btf);
 	info->btf_size = raw_btf_size;
 
-	err = bpf_obj_get_info_by_fd(btf_fd, info, &info_len);
+	err = bpf_btf_get_info_by_fd(btf_fd, info, &info_len);
 	if (CHECK(!err, "!err")) {
 		err = -1;
 		goto done;
@@ -4435,7 +4435,7 @@ static int test_big_btf_info(unsigned int test_num)
 	 * to userspace.
 	 */
 	info_garbage.garbage = 0;
-	err = bpf_obj_get_info_by_fd(btf_fd, info, &info_len);
+	err = bpf_btf_get_info_by_fd(btf_fd, info, &info_len);
 	if (CHECK(err || info_len != sizeof(*info),
 		  "err:%d errno:%d info_len:%u sizeof(*info):%zu",
 		  err, errno, info_len, sizeof(*info))) {
@@ -4499,7 +4499,7 @@ static int test_btf_id(unsigned int test_num)
 
 	/* Test BPF_OBJ_GET_INFO_BY_ID on btf_id */
 	info_len = sizeof(info[0]);
-	err = bpf_obj_get_info_by_fd(btf_fd[0], &info[0], &info_len);
+	err = bpf_btf_get_info_by_fd(btf_fd[0], &info[0], &info_len);
 	if (CHECK(err, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -4512,7 +4512,7 @@ static int test_btf_id(unsigned int test_num)
 	}
 
 	ret = 0;
-	err = bpf_obj_get_info_by_fd(btf_fd[1], &info[1], &info_len);
+	err = bpf_btf_get_info_by_fd(btf_fd[1], &info[1], &info_len);
 	if (CHECK(err || info[0].id != info[1].id ||
 		  info[0].btf_size != info[1].btf_size ||
 		  (ret = memcmp(user_btf[0], user_btf[1], info[0].btf_size)),
@@ -4535,7 +4535,7 @@ static int test_btf_id(unsigned int test_num)
 	}
 
 	info_len = sizeof(map_info);
-	err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+	err = bpf_map_get_info_by_fd(map_fd, &map_info, &info_len);
 	if (CHECK(err || map_info.btf_id != info[0].id ||
 		  map_info.btf_key_type_id != 1 || map_info.btf_value_type_id != 2,
 		  "err:%d errno:%d info.id:%u btf_id:%u btf_key_type_id:%u btf_value_type_id:%u",
@@ -4638,7 +4638,7 @@ static void do_test_get_info(unsigned int test_num)
 	info.btf_size = user_btf_size;
 
 	ret = 0;
-	err = bpf_obj_get_info_by_fd(btf_fd, &info, &info_len);
+	err = bpf_btf_get_info_by_fd(btf_fd, &info, &info_len);
 	if (CHECK(err || !info.id || info_len != sizeof(info) ||
 		  info.btf_size != raw_btf_size ||
 		  (ret = memcmp(raw_btf, user_btf, expected_nbytes)),
@@ -4755,7 +4755,7 @@ static void do_test_file(unsigned int test_num)
 
 	/* get necessary program info */
 	info_len = sizeof(struct bpf_prog_info);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 
 	if (CHECK(err < 0, "invalid get info (1st) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
@@ -4787,7 +4787,7 @@ static void do_test_file(unsigned int test_num)
 	info.func_info_rec_size = rec_size;
 	info.func_info = ptr_to_u64(func_info);
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 
 	if (CHECK(err < 0, "invalid get info (2nd) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
@@ -6405,7 +6405,7 @@ static int test_get_finfo(const struct prog_info_raw_test *test,
 
 	/* get necessary lens */
 	info_len = sizeof(struct bpf_prog_info);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err < 0, "invalid get info (1st) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
 		return -1;
@@ -6435,7 +6435,7 @@ static int test_get_finfo(const struct prog_info_raw_test *test,
 	info.nr_func_info = nr_func_info;
 	info.func_info_rec_size = rec_size;
 	info.func_info = ptr_to_u64(func_info);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err < 0, "invalid get info (2nd) errno:%d", errno)) {
 		fprintf(stderr, "%s\n", btf_log_buf);
 		err = -1;
@@ -6499,7 +6499,7 @@ static int test_get_linfo(const struct prog_info_raw_test *test,
 	nr_jited_func_lens = nr_jited_ksyms;
 
 	info_len = sizeof(struct bpf_prog_info);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err < 0, "err:%d errno:%d", err, errno)) {
 		err = -1;
 		goto done;
@@ -6573,7 +6573,7 @@ static int test_get_linfo(const struct prog_info_raw_test *test,
 		info.jited_func_lens = ptr_to_u64(jited_func_lens);
 	}
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 
 	/*
 	 * Only recheck the info.*line_info* fields.
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index eb90a6b8850d..a8b53b8736f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -14,7 +14,7 @@ static __u32 bpf_map_id(struct bpf_map *map)
 	int err;
 
 	memset(&info, 0, info_len);
-	err = bpf_obj_get_info_by_fd(bpf_map__fd(map), &info, &info_len);
+	err = bpf_map_get_info_by_fd(bpf_map__fd(map), &info, &info_len);
 	if (err)
 		return 0;
 	return info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
index 12f4395f18b3..5338d2ea0460 100644
--- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
+++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
@@ -59,7 +59,7 @@ static void test_check_mtu_xdp_attach(void)
 
 	memset(&link_info, 0, sizeof(link_info));
 	fd = bpf_link__fd(link);
-	err = bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	err = bpf_link_get_info_by_fd(fd, &link_info, &link_info_len);
 	if (CHECK(err, "link_info", "failed: %d\n", err))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/enable_stats.c b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
index 2cb2085917e7..75f85d0fe74a 100644
--- a/tools/testing/selftests/bpf/prog_tests/enable_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/enable_stats.c
@@ -28,7 +28,7 @@ void test_enable_stats(void)
 
 	prog_fd = bpf_program__fd(skel->progs.test_enable_stats);
 	memset(&info, 0, info_len);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err, "get_prog_info",
 		  "failed to get bpf_prog_info for fd %d\n", prog_fd))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 20f5fa0fcec9..8ec73fdfcdab 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -79,7 +79,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		return;
 
 	info_len = sizeof(prog_info);
-	err = bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
+	err = bpf_prog_get_info_by_fd(tgt_fd, &prog_info, &info_len);
 	if (!ASSERT_OK(err, "tgt_fd_get_info"))
 		goto close_prog;
 
@@ -136,8 +136,8 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 
 		info_len = sizeof(link_info);
 		memset(&link_info, 0, sizeof(link_info));
-		err = bpf_obj_get_info_by_fd(bpf_link__fd(link[i]),
-					     &link_info, &info_len);
+		err = bpf_link_get_info_by_fd(bpf_link__fd(link[i]),
+					      &link_info, &info_len);
 		ASSERT_OK(err, "link_fd_get_info");
 		ASSERT_EQ(link_info.tracing.attach_type,
 			  bpf_program__expected_attach_type(prog[i]),
@@ -417,7 +417,7 @@ static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	struct btf *btf;
 	int ret;
 
-	ret = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
+	ret = bpf_prog_get_info_by_fd(attach_prog_fd, &info, &info_len);
 	if (ret)
 		return ret;
 
@@ -483,12 +483,12 @@ static void test_fentry_to_cgroup_bpf(void)
 	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
 		goto cleanup;
 
-	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
+	/* Make sure bpf_prog_get_info_by_fd works correctly when attaching
 	 * to another BPF program.
 	 */
 
-	ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
-		  "bpf_obj_get_info_by_fd");
+	ASSERT_OK(bpf_prog_get_info_by_fd(fentry_fd, &info, &info_len),
+		  "bpf_prog_get_info_by_fd");
 
 	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
 	ASSERT_EQ(info.attach_btf_id, btf_id, "info.attach_btf_id");
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index 7c79462d2702..9333f7346d15 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -60,9 +60,9 @@ static __u32 query_prog_id(int prog)
 	__u32 info_len = sizeof(info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(prog, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog, &info, &info_len);
 	if (CHECK_FAIL(err || info_len != sizeof(info))) {
-		perror("bpf_obj_get_info_by_fd");
+		perror("bpf_prog_get_info_by_fd");
 		return 0;
 	}
 
@@ -497,7 +497,7 @@ static void test_link_get_info(int netns, int prog1, int prog2)
 	}
 
 	info_len = sizeof(info);
-	err = bpf_obj_get_info_by_fd(link, &info, &info_len);
+	err = bpf_link_get_info_by_fd(link, &info, &info_len);
 	if (CHECK_FAIL(err)) {
 		perror("bpf_obj_get_info");
 		goto out_unlink;
@@ -521,7 +521,7 @@ static void test_link_get_info(int netns, int prog1, int prog2)
 
 	link_id = info.id;
 	info_len = sizeof(info);
-	err = bpf_obj_get_info_by_fd(link, &info, &info_len);
+	err = bpf_link_get_info_by_fd(link, &info, &info_len);
 	if (CHECK_FAIL(err)) {
 		perror("bpf_obj_get_info");
 		goto out_unlink;
@@ -546,7 +546,7 @@ static void test_link_get_info(int netns, int prog1, int prog2)
 	netns = -1;
 
 	info_len = sizeof(info);
-	err = bpf_obj_get_info_by_fd(link, &info, &info_len);
+	err = bpf_link_get_info_by_fd(link, &info, &info_len);
 	if (CHECK_FAIL(err)) {
 		perror("bpf_obj_get_info");
 		goto out_unlink;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
index 25e5dfa9c315..a3f238f51d05 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
@@ -29,9 +29,9 @@ void test_libbpf_get_fd_by_id_opts(void)
 	if (!ASSERT_OK(ret, "test_libbpf_get_fd_by_id_opts__attach"))
 		goto close_prog;
 
-	ret = bpf_obj_get_info_by_fd(bpf_map__fd(skel->maps.data_input),
+	ret = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.data_input),
 				     &info_m, &len);
-	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
+	if (!ASSERT_OK(ret, "bpf_map_get_info_by_fd"))
 		goto close_prog;
 
 	fd = bpf_map_get_fd_by_id(info_m.id);
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index f117bfef68a1..130a3b21e467 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -47,7 +47,8 @@ static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
 
 		fd = bpf_prog_get_fd_by_id(p.prog_ids[i]);
 		ASSERT_GE(fd, 0, "prog_get_fd_by_id");
-		ASSERT_OK(bpf_obj_get_info_by_fd(fd, &info, &info_len), "prog_info_by_fd");
+		ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &info_len),
+			  "prog_info_by_fd");
 		close(fd);
 
 		if (info.attach_btf_id ==
diff --git a/tools/testing/selftests/bpf/prog_tests/metadata.c b/tools/testing/selftests/bpf/prog_tests/metadata.c
index 2c53eade88e3..8b67dfc10f5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/metadata.c
@@ -16,7 +16,7 @@ static int duration;
 static int prog_holds_map(int prog_fd, int map_fd)
 {
 	struct bpf_prog_info prog_info = {};
-	struct bpf_prog_info map_info = {};
+	struct bpf_map_info map_info = {};
 	__u32 prog_info_len;
 	__u32 map_info_len;
 	__u32 *map_ids;
@@ -25,12 +25,12 @@ static int prog_holds_map(int prog_fd, int map_fd)
 	int i;
 
 	map_info_len = sizeof(map_info);
-	ret = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+	ret = bpf_map_get_info_by_fd(map_fd, &map_info, &map_info_len);
 	if (ret)
 		return -errno;
 
 	prog_info_len = sizeof(prog_info);
-	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	ret = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
 	if (ret)
 		return -errno;
 
@@ -44,7 +44,7 @@ static int prog_holds_map(int prog_fd, int map_fd)
 	prog_info.map_ids = ptr_to_u64(map_ids);
 	prog_info_len = sizeof(prog_info);
 
-	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	ret = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
 	if (ret) {
 		ret = -errno;
 		goto free_map_ids;
diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
index 37b002ca1167..a271d5a0f7ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
@@ -64,7 +64,7 @@ void test_mmap(void)
 
 	/* get map's ID */
 	memset(&map_info, 0, map_info_sz);
-	err = bpf_obj_get_info_by_fd(data_map_fd, &map_info, &map_info_sz);
+	err = bpf_map_get_info_by_fd(data_map_fd, &map_info, &map_info_sz);
 	if (CHECK(err, "map_get_info", "failed %d\n", errno))
 		goto cleanup;
 	data_map_id = map_info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index 224eba6fef2e..3a25f1c743a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -54,7 +54,7 @@ void serial_test_perf_link(void)
 		goto cleanup;
 
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(link_fd, &info, &info_len);
+	err = bpf_link_get_info_by_fd(link_fd, &info, &info_len);
 	if (!ASSERT_OK(err, "link_get_info"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testing/selftests/bpf/prog_tests/pinning.c
index d95cee5867b7..c799a3c5ad1f 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -18,7 +18,7 @@ __u32 get_map_id(struct bpf_object *obj, const char *name)
 	if (CHECK(!map, "find map", "NULL map"))
 		return 0;
 
-	err = bpf_obj_get_info_by_fd(bpf_map__fd(map),
+	err = bpf_map_get_info_by_fd(bpf_map__fd(map),
 				     &map_info, &map_info_len);
 	CHECK(err, "get map info", "err %d errno %d", err, errno);
 	return map_info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 1ccd2bdf8fa8..01f1d1b6715a 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -12,7 +12,7 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	__u32 info_len = sizeof(info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (CHECK(err, "get_prog_info", "failed to get bpf_prog_info for fd %d\n", prog_fd))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
index f3af2627b599..23552d3e3365 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursion.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -31,8 +31,8 @@ void test_recursion(void)
 	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash2), &key);
 	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
 
-	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.on_delete),
-				     &prog_info, &prog_info_len);
+	err = bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.on_delete),
+				      &prog_info, &prog_info_len);
 	if (!ASSERT_OK(err, "get_prog_info"))
 		goto out;
 	ASSERT_EQ(prog_info.recursion_misses, 2, "recursion_misses");
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 0aa088900699..0ce25a967481 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -299,9 +299,9 @@ static __u32 query_prog_id(int prog_fd)
 	__u32 info_len = sizeof(info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
-	    !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd") ||
+	    !ASSERT_EQ(info_len, sizeof(info), "bpf_prog_get_info_by_fd"))
 		return 0;
 
 	return info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index a176bd75a748..ea8537c54413 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -119,19 +119,19 @@ static void test_recursion(void)
 
 	prog_fd = bpf_program__fd(skel->progs.on_lookup);
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
 	ASSERT_GT(info.recursion_misses, 0, "on_lookup prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
 	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_enter);
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
 	ASSERT_EQ(info.recursion_misses, 0, "on_enter prog recursion");
 
@@ -221,7 +221,7 @@ static void test_nodeadlock(void)
 
 	info_len = sizeof(info);
 	prog_fd = bpf_program__fd(skel->progs.socket_post_create);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
 	ASSERT_EQ(info.recursion_misses, 0, "prog recursion");
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
index 4a505a5adf4d..e873766276d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
@@ -29,8 +29,8 @@ static int test_tc_bpf_basic(const struct bpf_tc_hook *hook, int fd)
 	__u32 info_len = sizeof(info);
 	int ret;
 
-	ret = bpf_obj_get_info_by_fd(fd, &info, &info_len);
-	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
+	ret = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(ret, "bpf_prog_get_info_by_fd"))
 		return ret;
 
 	ret = bpf_tc_attach(hook, &opts);
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index a479080533db..770fcc3bb1ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -45,8 +45,9 @@ void serial_test_tp_attach_query(void)
 		prog_info.xlated_prog_len = 0;
 		prog_info.nr_map_ids = 0;
 		info_len = sizeof(prog_info);
-		err = bpf_obj_get_info_by_fd(prog_fd[i], &prog_info, &info_len);
-		if (CHECK(err, "bpf_obj_get_info_by_fd", "err %d errno %d\n",
+		err = bpf_prog_get_info_by_fd(prog_fd[i], &prog_info,
+					      &info_len);
+		if (CHECK(err, "bpf_prog_get_info_by_fd", "err %d errno %d\n",
 			  err, errno))
 			goto cleanup1;
 		saved_prog_ids[i] = prog_info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 1ed3cc2092db..8383a99f610f 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -179,7 +179,7 @@ static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *s
 	ASSERT_EQ(bpf_prog_get_next_id(prog_id, &next), -EPERM, "prog_get_next_id_fails");
 	ASSERT_EQ(bpf_prog_get_next_id(0, &next), -EPERM, "prog_get_next_id_fails");
 
-	if (ASSERT_OK(bpf_obj_get_info_by_fd(map_fds[0], &map_info, &map_info_len),
+	if (ASSERT_OK(bpf_map_get_info_by_fd(map_fds[0], &map_info, &map_info_len),
 		      "obj_get_info_by_fd")) {
 		ASSERT_EQ(bpf_map_get_fd_by_id(map_info.id), -EPERM, "map_get_fd_by_id_fails");
 		ASSERT_EQ(bpf_map_get_next_id(map_info.id, &next), -EPERM,
@@ -187,8 +187,8 @@ static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *s
 	}
 	ASSERT_EQ(bpf_map_get_next_id(0, &next), -EPERM, "map_get_next_id_fails");
 
-	if (ASSERT_OK(bpf_obj_get_info_by_fd(bpf_link__fd(skel->links.sys_nanosleep_enter),
-					     &link_info, &link_info_len),
+	if (ASSERT_OK(bpf_link_get_info_by_fd(bpf_link__fd(skel->links.sys_nanosleep_enter),
+					      &link_info, &link_info_len),
 		      "obj_get_info_by_fd")) {
 		ASSERT_EQ(bpf_link_get_fd_by_id(link_info.id), -EPERM, "link_get_fd_by_id_fails");
 		ASSERT_EQ(bpf_link_get_next_id(link_info.id, &next), -EPERM,
@@ -269,7 +269,7 @@ void test_unpriv_bpf_disabled(void)
 	}
 
 	prog_fd = bpf_program__fd(skel->progs.sys_nanosleep_enter);
-	ASSERT_OK(bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len),
+	ASSERT_OK(bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len),
 		  "obj_get_info_by_fd");
 	prog_id = prog_info.id;
 	ASSERT_GT(prog_id, 0, "valid_prog_id");
diff --git a/tools/testing/selftests/bpf/prog_tests/verif_stats.c b/tools/testing/selftests/bpf/prog_tests/verif_stats.c
index a47e7c0e1ffd..af4b95f57ac1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verif_stats.c
+++ b/tools/testing/selftests/bpf/prog_tests/verif_stats.c
@@ -16,8 +16,9 @@ void test_verif_stats(void)
 	if (!ASSERT_OK_PTR(skel, "trace_vprintk__open_and_load"))
 		goto cleanup;
 
-	err = bpf_obj_get_info_by_fd(skel->progs.sys_enter.prog_fd, &info, &len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(skel->progs.sys_enter.prog_fd,
+				      &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
 		goto cleanup;
 
 	if (!ASSERT_GT(info.verified_insns, 0, "verified_insns"))
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index 062fbc8c8e5e..d4cd9f873c14 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -18,7 +18,7 @@ void serial_test_xdp_attach(void)
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj1, &fd1);
 	if (CHECK_FAIL(err))
 		return;
-	err = bpf_obj_get_info_by_fd(fd1, &info, &len);
+	err = bpf_prog_get_info_by_fd(fd1, &info, &len);
 	if (CHECK_FAIL(err))
 		goto out_1;
 	id1 = info.id;
@@ -28,7 +28,7 @@ void serial_test_xdp_attach(void)
 		goto out_1;
 
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(fd2, &info, &len);
+	err = bpf_prog_get_info_by_fd(fd2, &info, &len);
 	if (CHECK_FAIL(err))
 		goto out_2;
 	id2 = info.id;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index f775a1613833..481626a875d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -33,8 +33,8 @@ static void test_xdp_with_cpumap_helpers(void)
 
 	prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm);
 	map_fd = bpf_map__fd(skel->maps.cpu_map);
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
 		goto out_close;
 
 	val.bpf_prog.fd = prog_fd;
@@ -85,8 +85,8 @@ static void test_xdp_with_cpumap_frags_helpers(void)
 
 	frags_prog_fd = bpf_program__fd(skel->progs.xdp_dummy_cm_frags);
 	map_fd = bpf_map__fd(skel->maps.cpu_map);
-	err = bpf_obj_get_info_by_fd(frags_prog_fd, &info, &len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(frags_prog_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
 		goto out_close;
 
 	val.bpf_prog.fd = frags_prog_fd;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index ead40016c324..ce6812558287 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -35,8 +35,8 @@ static void test_xdp_with_devmap_helpers(void)
 
 	dm_fd = bpf_program__fd(skel->progs.xdp_dummy_dm);
 	map_fd = bpf_map__fd(skel->maps.dm_ports);
-	err = bpf_obj_get_info_by_fd(dm_fd, &info, &len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(dm_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
 		goto out_close;
 
 	val.bpf_prog.fd = dm_fd;
@@ -98,8 +98,8 @@ static void test_xdp_with_devmap_frags_helpers(void)
 
 	dm_fd_frags = bpf_program__fd(skel->progs.xdp_dummy_dm_frags);
 	map_fd = bpf_map__fd(skel->maps.dm_ports);
-	err = bpf_obj_get_info_by_fd(dm_fd_frags, &info, &len);
-	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd"))
+	err = bpf_prog_get_info_by_fd(dm_fd_frags, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
 		goto out_close;
 
 	val.bpf_prog.fd = dm_fd_frags;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_info.c b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
index 286c21ecdc65..1dbddcab87a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_info.c
@@ -34,7 +34,7 @@ void serial_test_xdp_info(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
 	if (CHECK(err, "get_prog_info", "errno=%d\n", errno))
 		goto out_close;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
index 3e9d5c5521f0..e7e9f3c22edf 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
@@ -29,13 +29,13 @@ void serial_test_xdp_link(void)
 	prog_fd2 = bpf_program__fd(skel2->progs.xdp_handler);
 
 	memset(&prog_info, 0, sizeof(prog_info));
-	err = bpf_obj_get_info_by_fd(prog_fd1, &prog_info, &prog_info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd1, &prog_info, &prog_info_len);
 	if (!ASSERT_OK(err, "fd_info1"))
 		goto cleanup;
 	id1 = prog_info.id;
 
 	memset(&prog_info, 0, sizeof(prog_info));
-	err = bpf_obj_get_info_by_fd(prog_fd2, &prog_info, &prog_info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd2, &prog_info, &prog_info_len);
 	if (!ASSERT_OK(err, "fd_info2"))
 		goto cleanup;
 	id2 = prog_info.id;
@@ -119,7 +119,8 @@ void serial_test_xdp_link(void)
 		goto cleanup;
 
 	memset(&link_info, 0, sizeof(link_info));
-	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &link_info, &link_info_len);
+	err = bpf_link_get_info_by_fd(bpf_link__fd(link),
+				      &link_info, &link_info_len);
 	if (!ASSERT_OK(err, "link_info"))
 		goto cleanup;
 
@@ -137,7 +138,8 @@ void serial_test_xdp_link(void)
 		goto cleanup;
 
 	memset(&link_info, 0, sizeof(link_info));
-	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), &link_info, &link_info_len);
+	err = bpf_link_get_info_by_fd(bpf_link__fd(link),
+				      &link_info, &link_info_len);
 
 	ASSERT_OK(err, "link_info");
 	ASSERT_EQ(link_info.prog_id, id1, "link_prog_id");
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index b73152822aa2..7fc00e423e4d 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1275,7 +1275,7 @@ static void test_map_in_map(void)
 			goto out_map_in_map;
 		}
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_map_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			printf("Failed to get map info by fd %d: %d", fd,
 			       errno);
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
index 3256de30f563..ed518d075d1d 100644
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
@@ -93,7 +93,7 @@ int get_map_fd_by_prog_id(int prog_id)
 	info.nr_map_ids = 1;
 	info.map_ids = (__u64) (unsigned long) map_ids;
 
-	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len)) {
+	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
 		log_err("Failed to get info by prog fd %d", prog_fd);
 		goto err;
 	}
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index 5c8ef062f760..32df93747095 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -96,7 +96,7 @@ static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
 	info.nr_map_ids = 1;
 	info.map_ids = (__u64)(unsigned long)map_ids;
 
-	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len)) {
+	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
 		log_err("Failed to get info by prog fd %d", prog_fd);
 		goto err;
 	}
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 887c49dc5abd..8b9949bb833d 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1239,8 +1239,8 @@ static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
 	__u32 xlated_prog_len;
 	__u32 buf_element_size = sizeof(struct bpf_insn);
 
-	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("bpf_obj_get_info_by_fd failed");
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("bpf_prog_get_info_by_fd failed");
 		return -1;
 	}
 
@@ -1261,8 +1261,8 @@ static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
 	bzero(&info, sizeof(info));
 	info.xlated_prog_len = xlated_prog_len;
 	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
-	if (bpf_obj_get_info_by_fd(fd_prog, &info, &info_len)) {
-		perror("second bpf_obj_get_info_by_fd failed");
+	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
+		perror("second bpf_prog_get_info_by_fd failed");
 		goto out_free_buf;
 	}
 
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 9695318e8132..6c44153755e6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -164,7 +164,7 @@ __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
 	int err;
 
 	memset(info, 0, sizeof(*info));
-	err = bpf_obj_get_info_by_fd(bpf_link__fd(link), info, &info_len);
+	err = bpf_link_get_info_by_fd(bpf_link__fd(link), info, &info_len);
 	if (err) {
 		printf("failed to get link info: %d\n", -errno);
 		return 0;
diff --git a/tools/testing/selftests/bpf/xdp_synproxy.c b/tools/testing/selftests/bpf/xdp_synproxy.c
index 6dbe0b745198..ce68c342b56f 100644
--- a/tools/testing/selftests/bpf/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/xdp_synproxy.c
@@ -217,9 +217,10 @@ static int syncookie_attach(const char *argv0, unsigned int ifindex, bool tc)
 
 	prog_fd = bpf_program__fd(prog);
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err < 0) {
-		fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+		fprintf(stderr, "Error: bpf_prog_get_info_by_fd: %s\n",
+			strerror(-err));
 		goto out;
 	}
 	attached_tc = tc;
@@ -292,9 +293,10 @@ static int syncookie_open_bpf_maps(__u32 prog_id, int *values_map_fd, int *ports
 	};
 	info_len = sizeof(prog_info);
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &info_len);
 	if (err != 0) {
-		fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+		fprintf(stderr, "Error: bpf_prog_get_info_by_fd: %s\n",
+			strerror(-err));
 		goto out;
 	}
 
@@ -317,9 +319,10 @@ static int syncookie_open_bpf_maps(__u32 prog_id, int *values_map_fd, int *ports
 		map_fd = err;
 
 		info_len = sizeof(map_info);
-		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+		err = bpf_map_get_info_by_fd(map_fd, &map_info, &info_len);
 		if (err != 0) {
-			fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+			fprintf(stderr, "Error: bpf_map_get_info_by_fd: %s\n",
+				strerror(-err));
 			close(map_fd);
 			goto err_close_map_fds;
 		}
-- 
2.39.1

