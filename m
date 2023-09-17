Return-Path: <bpf+bounces-10238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5027A3E01
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 23:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC831C2084A
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BCF4F9;
	Sun, 17 Sep 2023 21:43:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F283EAFB
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 21:43:04 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C135310A
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:43:02 -0700 (PDT)
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HESr36000814;
	Sun, 17 Sep 2023 21:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=PXCVGyP0Ztb8oS79oITcF91c83+UAIYW+yz9e3eTv00=;
 b=Jzl+ezZa4/lmB8pMn3aDN7whGpUAgIdMtoXKp4WCVgzFvDCjbfY8UVD9wWI1116PRuRa
 pU/ERgv3rlCN8s1um++a211hDHzy+TqsWpo74OOXOUx+Tqh+lxHWtROQ+aNnOhbFwPsH
 97B0JEV76vzQdCcHzeLhECDrH5sEGig3/GUDsVgue42DtIJ/Q/l/3iQOUMU4WoaX2Yje
 JP8xRxtYGwcl/+4PsjtvsY3dhQqBai6Aq0sQI7l5NQBXg+bM3wix/Yfu5iCpMLCtKL+q
 V4sBjy1TapzEJZIPaURoZ30X7ROhTDzSnCCr7rO5ocAtoO8pja6SeMJJ1brPtgBT5qQB Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3t52qqrd2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Sep 2023 21:42:47 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38HLgct0002067;
	Sun, 17 Sep 2023 21:42:47 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3t52qqrd22-4;
	Sun, 17 Sep 2023 21:42:47 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao@linux.ibm.com, Ruowen Qin <ruowenq2@illinois.edu>,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH bpf v2 3/3] samples/bpf: syscall_tp_user: Fix array out-of-bound access
Date: Sun, 17 Sep 2023 16:42:20 -0500
Message-ID: <20230917214220.637721-4-jinghao7@illinois.edu>
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
X-Proofpoint-ORIG-GUID: gVKuNAXqD_0umpPgPqQo0VOgaIJndmF2
X-Proofpoint-GUID: ACdqV-wfCkZuxylyxzDN8VyU53BBLYLQ
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxlogscore=672 malwarescore=0 lowpriorityscore=0 priorityscore=1501
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

Commit 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint
to syscall_tp sample") added two more eBPF programs to support the
openat2() syscall. However, it did not increase the size of the array
that holds the corresponding bpf_links. This leads to an out-of-bound
access on that array in the bpf_object__for_each_program loop and could
corrupt other variables on the stack. On our testing QEMU, it corrupts
the map1_fds array and causes the sample to fail:

  # ./syscall_tp
  prog #0: map ids 4 5
  verify map:4 val: 5
  map_lookup failed: Bad file descriptor

Dynamically allocate the array based on the number of programs reported
by libbpf to prevent similar inconsistencies in the future

Fixes: 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint to syscall_tp sample")
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/syscall_tp_user.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
index 18c94c7e8a40..7a09ac74fac0 100644
--- a/samples/bpf/syscall_tp_user.c
+++ b/samples/bpf/syscall_tp_user.c
@@ -48,7 +48,7 @@ static void verify_map(int map_id)
 static int test(char *filename, int nr_tests)
 {
 	int map0_fds[nr_tests], map1_fds[nr_tests], fd, i, j = 0;
-	struct bpf_link *links[nr_tests * 4];
+	struct bpf_link **links = NULL;
 	struct bpf_object *objs[nr_tests];
 	struct bpf_program *prog;
 
@@ -60,6 +60,19 @@ static int test(char *filename, int nr_tests)
 			goto cleanup;
 		}
 
+		/* One-time initialization */
+		if (!links) {
+			int nr_progs = 0;
+
+			bpf_object__for_each_program(prog, objs[i])
+				nr_progs += 1;
+
+			links = calloc(nr_progs * nr_tests, sizeof(struct bpf_link *));
+
+			if (!links)
+				goto cleanup;
+		}
+
 		/* load BPF program */
 		if (bpf_object__load(objs[i])) {
 			fprintf(stderr, "loading BPF object file failed\n");
@@ -107,8 +120,12 @@ static int test(char *filename, int nr_tests)
 	}
 
 cleanup:
-	for (j--; j >= 0; j--)
-		bpf_link__destroy(links[j]);
+	if (links) {
+		for (j--; j >= 0; j--)
+			bpf_link__destroy(links[j]);
+
+		free(links);
+	}
 
 	for (i--; i >= 0; i--)
 		bpf_object__close(objs[i]);
-- 
2.42.0


