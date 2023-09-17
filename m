Return-Path: <bpf+bounces-10240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B865A7A3E03
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 23:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF22812E1
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A94F517;
	Sun, 17 Sep 2023 21:43:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7572EAFB
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 21:43:07 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA310A
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:43:06 -0700 (PDT)
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38H8TiKO014159;
	Sun, 17 Sep 2023 21:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=4lkbXD0WDHBs/FO5VuW2SGXsjRsm0uVWor8ySlCY7vg=;
 b=HkwwOK7vpqhc/KyBQSpW5/UNjuL4XmzijmVy1l2ZBd5/564Puxbo3nIK2a8RNdMxFKPd
 Kc5xqVqWP4kR4Kp5H/0UXz1ev0lW9iDWD3/NCFMOvLnfzlpJGgO+3S3B/loYsPs+L1UP
 S7MaFMijJpPYHxU8aJQZqDsDJsV78G2RjoaeliCQiyDU4L/JWKwU9X6Ld8BlICgkYwQY
 vwDwMyJUazYslsfHtTXCJ9EsF9beLFlZTqEoxGs2rVIxrgbsQoNJ3Unh8oN32ivDBZA2
 0PW9Arzzij14orTV1J9kvwsnCzoHWFRQgzx4HYexDTKx8HXjDbeNnBx3i5FdSyv6+ESf oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3t52qqrd2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Sep 2023 21:42:45 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38HLgcsw002067;
	Sun, 17 Sep 2023 21:42:45 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3t52qqrd22-3;
	Sun, 17 Sep 2023 21:42:45 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao@linux.ibm.com, Ruowen Qin <ruowenq2@illinois.edu>,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH bpf v2 2/3] samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
Date: Sun, 17 Sep 2023 16:42:19 -0500
Message-ID: <20230917214220.637721-3-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917214220.637721-1-jinghao7@illinois.edu>
References: <20230917214220.637721-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h95SPvi11eWCg5JmsyLp6tyutZClB78i
X-Proofpoint-GUID: 7WA_zGNqeo_shlegpylNgXNWGMMKEj4U
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170201
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinghao Jia <jinghao@linux.ibm.com>

The variable name num_progs causes confusion because that variable
really controls the number of rounds the test should be executed.

Rename num_progs into nr_tests for the sake of clarity.

Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/syscall_tp_user.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
index 7a788bb837fc..18c94c7e8a40 100644
--- a/samples/bpf/syscall_tp_user.c
+++ b/samples/bpf/syscall_tp_user.c
@@ -17,9 +17,9 @@
 
 static void usage(const char *cmd)
 {
-	printf("USAGE: %s [-i num_progs] [-h]\n", cmd);
-	printf("       -i num_progs      # number of progs of the test\n");
-	printf("       -h                # help\n");
+	printf("USAGE: %s [-i nr_tests] [-h]\n", cmd);
+	printf("       -i nr_tests      # rounds of test to run\n");
+	printf("       -h               # help\n");
 }
 
 static void verify_map(int map_id)
@@ -45,14 +45,14 @@ static void verify_map(int map_id)
 	}
 }
 
-static int test(char *filename, int num_progs)
+static int test(char *filename, int nr_tests)
 {
-	int map0_fds[num_progs], map1_fds[num_progs], fd, i, j = 0;
-	struct bpf_link *links[num_progs * 4];
-	struct bpf_object *objs[num_progs];
+	int map0_fds[nr_tests], map1_fds[nr_tests], fd, i, j = 0;
+	struct bpf_link *links[nr_tests * 4];
+	struct bpf_object *objs[nr_tests];
 	struct bpf_program *prog;
 
-	for (i = 0; i < num_progs; i++) {
+	for (i = 0; i < nr_tests; i++) {
 		objs[i] = bpf_object__open_file(filename, NULL);
 		if (libbpf_get_error(objs[i])) {
 			fprintf(stderr, "opening BPF object file failed\n");
@@ -101,7 +101,7 @@ static int test(char *filename, int num_progs)
 	close(fd);
 
 	/* verify the map */
-	for (i = 0; i < num_progs; i++) {
+	for (i = 0; i < nr_tests; i++) {
 		verify_map(map0_fds[i]);
 		verify_map(map1_fds[i]);
 	}
@@ -117,13 +117,13 @@ static int test(char *filename, int num_progs)
 
 int main(int argc, char **argv)
 {
-	int opt, num_progs = 1;
+	int opt, nr_tests = 1;
 	char filename[256];
 
 	while ((opt = getopt(argc, argv, "i:h")) != -1) {
 		switch (opt) {
 		case 'i':
-			num_progs = atoi(optarg);
+			nr_tests = atoi(optarg);
 			break;
 		case 'h':
 		default:
@@ -134,5 +134,5 @@ int main(int argc, char **argv)
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 
-	return test(filename, num_progs);
+	return test(filename, nr_tests);
 }
-- 
2.42.0


