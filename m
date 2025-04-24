Return-Path: <bpf+bounces-56629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A3A9B4B8
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E85E3A7931
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9528B506;
	Thu, 24 Apr 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N0SH08Bb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC746281529
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513749; cv=none; b=i+RxafBO/a0PYXscdmGN41kFWQo2nKVIarKM1fWhIhRDTIemryV+UEpT7g4IQL4S7wQvh29yySsEIMHIpk72GJbnvuEUwTWhu4IimFESAWtHuGW5xOlrXJuewuWvAENvJZFPIrI8lKOGzHWctm2joVfnK1mbYNzE4XiwftoR1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513749; c=relaxed/simple;
	bh=he4HDM2qHsb24tk2UjasV/ghhDyKvqVfg7K4Rlab0j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7Xo+44Vmnsh5QXbmZBMVWGAnZHyZe8zaxhoNHiq1/uB16kis/cnJuvQSSjXe7QYFaJ0ir7UojyHaw5HIR9/1RERYUwYUUwO6d5PybUwTsD7v24viwDHcd07OEQY+R6nFJtC+QsVmObnpvN2QhNMAmAIL05ruvYrBYaue1MQRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N0SH08Bb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA40ox000956;
	Thu, 24 Apr 2025 16:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WcBlL0/siVDkNky/w
	LYLwWUwdAVqFW0VVDBgTyTwzi4=; b=N0SH08BbSRINHivrn++PvySnN86KrRIVv
	xuAjAaeO3I/2nCU4JMmAB+IQ5rl6thSZN/7GYGy03sBRSPKCjK+g1NIiA9NLPske
	RQSvQU73B5liANUBLQjk55SC2b6C22vYZGnHbFv2LfKV+FCq2UBF1zc6CU/lUfxq
	CXcO8lbvGbadT9NHbGtkYE/M5APYKT/5CBdIjPio6kx6B18CSbrPQmQ/su37SWAf
	bd7xXg5zeRyb9PZDo0zYEC6FXkiE5/GKIYjvK+fTHm5QoetQvJ6s3C3hLQUkTwBr
	s8ELegBr4GOkJdKKLbyjs69n9Ul2V1jqIkHDODnvEJSPDDd1+UWKA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k22s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFd1kw000925;
	Thu, 24 Apr 2025 16:55:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy14xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OGtSAC36372872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:55:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E6020040;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE9A020043;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.201.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
Date: Thu, 24 Apr 2025 18:41:26 +0200
Message-ID: <20250424165525.154403-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
References: <20250424165525.154403-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XKEoVV-dNTFnIsWNfI41sRfflw0PzhYI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNCBTYWx0ZWRfXz1T7qEX284V8 p1OVKg6Aq9LjHEQO6ZYNlpK0cke6QAg16aZ2gQNDE0lpORal8WsfIFvrFKV7Wc0FYTO4HpxQwA6 3MUOanqj3LeOTD7f+jiftCaDQ3i8796Auf6ViER2tWLvupoCyjCiharG20+9iT+o3Z1tpJK+JI8
 HdCw4LwIbPnb4qJ6enaQVdz2IWOjdpFUpX9SSPzUC755n/xlTbCBT919U/8e7Mi2krL2V5O00ZL 7FyhuqVpjSIAr9e+s0WUsSg+XzIubjI4BV/n25y+G50PCA2uKxZ7TMVJ6HzUU3H5N1WTW1WnHhi 9yKdENIeaGtyn0UFbbB8qgHnZuou5gQ+A9yeB8UDl0NWQqWR5osdOORx9bZv1rSmgQwuQXRJQw2
 nSZ8nyzLD2q/e48+wX+bjlXzhApN6sPt4OoQSnArp/zLpBj2traKPX/tGX+nwhYXiFceGLbY
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680a6d05 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=hqbfqR9qN0-b6A0_XnYA:9
X-Proofpoint-GUID: XKEoVV-dNTFnIsWNfI41sRfflw0PzhYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240114

test_arena_spin_lock_size() explicitly requires having at least 2 CPUs,
but if the machine has less than 16, then pthread_setaffinity_np() call
in spin_lock_thread() fails.

Cap threads to the number of CPUs.

Alternative solutions are raising the number of required CPUs to 16, or
pinning multiple threads to the same CPU, but they are not that useful.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/arena_spin_lock.c     | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 7565fc7690c2..0223fce4db2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -51,9 +51,11 @@ static void test_arena_spin_lock_size(int size)
 	struct arena_spin_lock *skel;
 	pthread_t thread_id[16];
 	int prog_fd, i, err;
+	int nthreads;
 	void *ret;
 
-	if (get_nprocs() < 2) {
+	nthreads = MIN(get_nprocs(), ARRAY_SIZE(thread_id));
+	if (nthreads < 2) {
 		test__skip();
 		return;
 	}
@@ -66,25 +68,25 @@ static void test_arena_spin_lock_size(int size)
 		goto end;
 	}
 	skel->bss->cs_count = size;
-	skel->bss->limit = repeat * 16;
+	skel->bss->limit = repeat * nthreads;
 
-	ASSERT_OK(pthread_barrier_init(&barrier, NULL, 16), "barrier init");
+	ASSERT_OK(pthread_barrier_init(&barrier, NULL, nthreads), "barrier init");
 
 	prog_fd = bpf_program__fd(skel->progs.prog);
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < nthreads; i++) {
 		err = pthread_create(&thread_id[i], NULL, &spin_lock_thread, &prog_fd);
 		if (!ASSERT_OK(err, "pthread_create"))
 			goto end_barrier;
 	}
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < nthreads; i++) {
 		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
 			goto end_barrier;
 		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
 			goto end_barrier;
 	}
 
-	ASSERT_EQ(skel->bss->counter, repeat * 16, "check counter value");
+	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
 
 end_barrier:
 	pthread_barrier_destroy(&barrier);
-- 
2.49.0


