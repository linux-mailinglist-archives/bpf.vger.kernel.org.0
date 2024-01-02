Return-Path: <bpf+bounces-18802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA33822232
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E655284728
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9215E9D;
	Tue,  2 Jan 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ag2HN+g2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310D15E95
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402JRjMi031408;
	Tue, 2 Jan 2024 19:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qNpAa5tXIedRxpIxeae/8plgt077QvDAx59+RQB+cSc=;
 b=ag2HN+g2qFkpYYSj47582U5IMFr4HEyyEfDqGTJHwA/2Dx+tyu4PtkJXtXJgy6WWTXfb
 +7pIr4au1LCEiGLJhfKuwBH7d3HiV2c9D4mxWBs8xWleIyEcumfeinw4F+AsNuxhuntV
 +s0fs+HlA/9uX5v+9LXBCYahMyWvOycxbVzPLMkL/5WgjtV6O4pNv0rV01zzEAZdpsHX
 jc09U2wQnETZN8c8HXFrlcXjfyXGpkNH9KEJNoT9S8mGR01kEDE6e2GxwGOIY+2QCQiJ
 qlVSSZJENcFc6nzBkEVWXOSrzEN7IqF3m2Hqgb6XN1wfWSbnIFbl/uX0xAZXBT7nhcj3 oQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcrnf84ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 19:39:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402GkH1X007548;
	Tue, 2 Jan 2024 19:35:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhnxurv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 19:35:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402JZksZ16188088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 19:35:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD60E2004B;
	Tue,  2 Jan 2024 19:35:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E4CD20040;
	Tue,  2 Jan 2024 19:35:46 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 19:35:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Test gotol with large offsets
Date: Tue,  2 Jan 2024 20:30:37 +0100
Message-ID: <20240102193531.3169422-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102193531.3169422-1-iii@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: osIjxHo5q1sBGgniOZVWUHN8aJ3bOli4
X-Proofpoint-GUID: osIjxHo5q1sBGgniOZVWUHN8aJ3bOli4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_07,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020148

Test gotol with offsets that don't fit into a short (i.e., larger than
32k or smaller than -32k).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/verifier_gotol.c      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index d1edbcff9a18..05a329ee45ee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -33,6 +33,25 @@ l3_%=:							\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("gotol, large_imm")
+__success __failure_unpriv __retval(40000)
+__naked void gotol_large_imm(void)
+{
+	asm volatile ("					\
+	gotol 1f;					\
+0:							\
+	r0 = 0;						\
+	.rept 40000;					\
+	r0 += 1;					\
+	.endr;						\
+	exit;						\
+1:	gotol 0b;					\
+"	:
+	:
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.43.0


