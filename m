Return-Path: <bpf+bounces-63480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1CEB07E55
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258DD3AD45D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54B28DF01;
	Wed, 16 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T85TPD10"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49D2737FF
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695146; cv=none; b=QS3vnmjLZVEg38kSVYKItdUzdo2mU2IrC5zbESODhLItYpYtJpucuKNPgnLunIF5pgutdzQbMIVaXOnRhBlYSxz/GjdLfx0NWsGz/OwLmdU8JLL4luykVQSdbV1Xa0X/tOWrdQN5Drl8oRYs1h6qbGqZ6y5bGdgJIrtnex3Cc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695146; c=relaxed/simple;
	bh=AJX0UYl3NfMaLrnmvnVEyGbY5F/sTP01VkEuxC2GPb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/EC2kdwOrfJOowJsI6bT8vEaDKKyWKQsrs9X7Ivf4OwYwTqVJovs9IAurl1YVeSqcNSKhfQeHPNEaacVSSPI/c2HHOpHSsCs+f31CzfZiIj0/TkNMVULRYq9yi/4WJBk1R09m3NfLLofR/rnmEQ+Gs2gkhGWgFwNGL5lfx9Bd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T85TPD10; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GITAkm023073;
	Wed, 16 Jul 2025 19:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xmP3JvXmFjTGH3P0K
	39gMlC3fKb13+yvhsVe2oF0uhE=; b=T85TPD10djFVXqHsYgzQq4dNITG1RSWKx
	yE9ha9Wf5OTVMGqgKChelidOWjdKVy/3FeRR+PLtpfW2gKXyZsZn7EXe2C3lmZF7
	kOxzgnP72C3d5IUG5YDVSEq6rP85BweyeECt8L3ndEik+CvDAixYbWHCQNGy6bDJ
	z2LX1bNAbvGcxyzzA3IG1MjhWKU9NO3HfylRbnrIPUifi0+4jiAeIBHXzDwUMCbe
	bhGkLWJYvXlysHTw3e/Yk/KxMbkNZH3XY+RW9MNnaRHWC7nO581NaFdN0hC4Ickr
	XQbdLdEs68Sjq0oQWg3xzpSMbsRlr4t05jsMf2xcMBf2F4adJXuJQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu2hfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GJigfD032758;
	Wed, 16 Jul 2025 19:45:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48m8res-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GJjRRY45744478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:45:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632CC2004B;
	Wed, 16 Jul 2025 19:45:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE18020040;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
Received: from heavy.lan (unknown [9.87.137.252])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] selftests/bpf: Stress test attaching a BPF prog to another BPF prog
Date: Wed, 16 Jul 2025 21:35:07 +0200
Message-ID: <20250716194524.48109-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716194524.48109-1-iii@linux.ibm.com>
References: <20250716194524.48109-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2oWHNtsB_dFhiGxCS4Sd-iIY7w-ut7HK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NCBTYWx0ZWRfXy8JtmuEf3kOO Gi9BDT7KHzSmZ9d7PbVsdFF20xyp/i0vmk0u0OzrBwqFe8G63E7ilydswCfeATSNc/Rw43hWMlj leBe7lLMYde/zFYa3BEB7k6PtGrf6eKlghXBXUUFEkMlpvmd9+JjFo5O1yPfRtt53R7FblXCcSe
 i3DxpJcmeJQ+OlTSOJQhLfS2cEql5qqtNaTXNG4nAKzc7RjOPqR0C0mbTh4EeJ5a+UOXsPbaLbm IuXSrDl7drBuCGyqnPgdZWyBBtAkpdp2g2ssxKQRz/bvvx/5GidfbVu6KkvPAUeb+hIB8ozxgEB OqZ5zVvkd3J83fBP1R+RhKZ82yw4bsQ5Tqb+BfPHnDfQ9hbM88PzvZdjh02c0sURDkEYJxwbs47
 MZ2XQX8UIkNVYKttQO8jZwg0CoRsfXbdE77k8xXK1Do69ik49HKF/1jDTTSrOI9V9HeXx0LU
X-Proofpoint-ORIG-GUID: 2oWHNtsB_dFhiGxCS4Sd-iIY7w-ut7HK
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6878015b cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=C-jh98RXXXx_s4NBbG0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=775 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160174

Add a test that invokes a BPF prog in a loop, while concurrently
attaching and detaching another BPF prog to and from it. This helps
identifying race conditions in bpf_arch_text_poke().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../bpf/prog_tests/recursive_attach.c         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 8100509e561b..0ffa01d54ce2 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -149,3 +149,70 @@ void test_fentry_attach_btf_presence(void)
 	fentry_recursive_target__destroy(target_skel);
 	fentry_recursive__destroy(tracing_skel);
 }
+
+static void *fentry_target_test_run(void *arg)
+{
+	for (;;) {
+		int prog_fd = __atomic_load_n((int *)arg, __ATOMIC_SEQ_CST);
+		LIBBPF_OPTS(bpf_test_run_opts, topts);
+		int err;
+
+		if (prog_fd == -1)
+			break;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		if (!ASSERT_OK(err, "fentry_target test_run"))
+			break;
+	}
+
+	return NULL;
+}
+
+void test_fentry_attach_stress(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_skel = NULL;
+	struct bpf_program *prog;
+	int err, i, tgt_prog_fd;
+	pthread_t thread;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel,
+			   "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+	tgt_prog_fd = bpf_program__fd(target_skel->progs.fentry_target);
+	err = pthread_create(&thread, NULL,
+			     fentry_target_test_run, &tgt_prog_fd);
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto close_prog;
+
+	for (i = 0; i < 1000; i++) {
+		tracing_skel = fentry_recursive__open();
+		if (!ASSERT_OK_PTR(tracing_skel, "fentry_recursive__open"))
+			goto stop_thread;
+
+		prog = tracing_skel->progs.recursive_attach;
+		err = bpf_program__set_attach_target(prog, tgt_prog_fd,
+						     "fentry_target");
+		if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+			goto stop_thread;
+
+		err = fentry_recursive__load(tracing_skel);
+		if (!ASSERT_OK(err, "fentry_recursive__load"))
+			goto stop_thread;
+
+		err = fentry_recursive__attach(tracing_skel);
+		if (!ASSERT_OK(err, "fentry_recursive__attach"))
+			goto stop_thread;
+
+		fentry_recursive__destroy(tracing_skel);
+		tracing_skel = NULL;
+	}
+
+stop_thread:
+	__atomic_store_n(&tgt_prog_fd, -1, __ATOMIC_SEQ_CST);
+	err = pthread_join(thread, NULL);
+	ASSERT_OK(err, "pthread_join");
+close_prog:
+	fentry_recursive__destroy(tracing_skel);
+	fentry_recursive_target__destroy(target_skel);
+}
-- 
2.50.1


