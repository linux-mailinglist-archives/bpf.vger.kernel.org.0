Return-Path: <bpf+bounces-8091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E277810D4
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B36E282475
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAED610D;
	Fri, 18 Aug 2023 16:47:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D736107
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:47:06 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857F2701
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:47:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGN7ix025363;
	Fri, 18 Aug 2023 16:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lKRataZsmX1qJunE3LB62feYfLY7tll1p+V/SAMVNMg=;
 b=f0KSK0FqZBhU3PKqGIAfdcAA4o4619X039N4fWb4lN7AAjUdzgnE1gjzXEkC9r0glJuk
 2Lw0ID6ZoGg226Z3i1zmItVTi5IL6tVSfUE6vYgZpyCFGKliL/2bxfhlGabIjbzudI3u
 eXd1g+tZRbP8bqJp21qxrak/6R7Mxxmyse3gjHSro6R2kLth0J2ACsLdSMIh1C4XKpV8
 5Opvg1oD+BOvyLDxGRZdyDyvyrWxEKIVOB3+i/+6YK6JOMkRX10CED+XhkqHIZWAt4ew
 SpmEa5NjBLXALZJFiyrJqlObta2SnN8nexEV/PKD7CmBxDsQfEo6huAwSo/BAjTNbXTD Rg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjc4a8m5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFFNHx003439;
	Fri, 18 Aug 2023 16:46:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdt8y93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGknZx41615700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:46:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 166A72004D;
	Fri, 18 Aug 2023 16:46:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4238D20040;
	Fri, 18 Aug 2023 16:46:48 +0000 (GMT)
Received: from Jinghaos-MacBook-Pro.watson.ibm.com (unknown [9.31.97.28])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:46:48 +0000 (GMT)
From: Jinghao Jia <jinghao@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH bpf 2/3] samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
Date: Fri, 18 Aug 2023 12:46:42 -0400
Message-Id: <20230818164643.97782-3-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230818164643.97782-1-jinghao@linux.ibm.com>
References: <20230818164643.97782-1-jinghao@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6J3AFNfQpg50a64bTX2z6A2nqOZ-bQTh
X-Proofpoint-ORIG-GUID: 6J3AFNfQpg50a64bTX2z6A2nqOZ-bQTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308180152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The variable name num_progs causes confusion because that variable
really controls the number of rounds the test should be executed.

Rename num_progs into nr_tests for the sake of clarity.

Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
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
2.41.0


