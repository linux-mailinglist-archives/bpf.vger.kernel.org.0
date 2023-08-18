Return-Path: <bpf+bounces-8092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF77810D5
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BAE1C2167A
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7D612E;
	Fri, 18 Aug 2023 16:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D26107
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:47:07 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786062D64
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:47:05 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGemub018060;
	Fri, 18 Aug 2023 16:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=axhPL33UVuci7B4QmxSt47GwBiIn71Wl3GkPnCWW5cU=;
 b=ZKlXW0gRjrrEZB6iGGWSooRxsOR1l5Tud4zwL9WTvPElTmcE8O5lyV8yjEv/mBV9fpLV
 atPP0/BvIxXs1EOJtq/GqcwAUZChc2EBmk21TCZE2ZVIRngeCvzHDrDUNbaKSjAb6sLI
 TCScev9nSSJk2Xqotf4urBnQEOs3aOClTH50uhsmMV/bc1fnfbtRtq6IVLlEqcml/+V6
 2WeV+Z8dOVFtOFyhFelSoduS189Z1+NflWOOiZzRe5gKEPp3IZ3iIOBavMMisdfIui0s
 zYQbiIAE4r7aKkuZdledQ0Sw9lZb/vdcKuQjkTqBJhPFx3TijBUo1Cb73E4qCGU9PwEm OQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjc6mgc5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEe6dv003446;
	Fri, 18 Aug 2023 16:46:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdt8y9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:46:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGkoH563766902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:46:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E3B320043;
	Fri, 18 Aug 2023 16:46:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ABF220040;
	Fri, 18 Aug 2023 16:46:49 +0000 (GMT)
Received: from Jinghaos-MacBook-Pro.watson.ibm.com (unknown [9.31.97.28])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:46:49 +0000 (GMT)
From: Jinghao Jia <jinghao@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH bpf 3/3] samples/bpf: syscall_tp_user: Fix array out-of-bound access
Date: Fri, 18 Aug 2023 12:46:43 -0400
Message-Id: <20230818164643.97782-4-jinghao@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tsNs9s247XL2nwavG4CMHIBiRk6XFYbY
X-Proofpoint-GUID: tsNs9s247XL2nwavG4CMHIBiRk6XFYbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=583 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
---
 samples/bpf/syscall_tp_user.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
index 18c94c7e8a40..8855d2c1290d 100644
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
 
@@ -60,6 +60,17 @@ static int test(char *filename, int nr_tests)
 			goto cleanup;
 		}
 
+		/* One-time initialization */
+		if (!links) {
+			int nr_progs = 0;
+
+			bpf_object__for_each_program(prog, objs[i])
+				nr_progs += 1;
+
+			links = calloc(nr_progs * nr_tests,
+				       sizeof(struct bpf_link *));
+		}
+
 		/* load BPF program */
 		if (bpf_object__load(objs[i])) {
 			fprintf(stderr, "loading BPF object file failed\n");
@@ -107,8 +118,13 @@ static int test(char *filename, int nr_tests)
 	}
 
 cleanup:
-	for (j--; j >= 0; j--)
-		bpf_link__destroy(links[j]);
+	if (links) {
+		for (j--; j >= 0; j--)
+			bpf_link__destroy(links[j]);
+
+		free(links);
+		links = NULL;
+	}
 
 	for (i--; i >= 0; i--)
 		bpf_object__close(objs[i]);
-- 
2.41.0


