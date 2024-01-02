Return-Path: <bpf+bounces-18799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C0822218
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F261C22832
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206715EAE;
	Tue,  2 Jan 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OX5u5+Ie"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A315AFF
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402JPvrN031824;
	Tue, 2 Jan 2024 19:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=s8tkWAzZ1LoSyJUBfNDKyGBY3YKzVrDmnvJKTTiVfug=;
 b=OX5u5+IeIbB+Ac90lgiHSYk+2fN0lCmVsyMRHD7uRZ1QiU5BY5j9zIZvY9tpz2T3esYf
 Tx4WGLvPhInHJVeLgXiuRPLHDP6ItqRU/m235l3Q7ns7B6Dz2r+fwdUetnOJCFJgGOu4
 /b+/xe8v0WfyT87oknF/MgRSSbuBa1LQXpr/gRWM1GUzgHtAs1u3uyqzpLVrD9AhhmKn
 CWSrOAfRF9Kgfc1AsQVoJDtkXZkuCE4W9v7u2SRUOic/zjXH9jb2qq11vuYKdCqAsH+o
 wrjVSBiBuk0tc8MFFRj0IXhMrPvekmGadbtnGItCdsEFOG6tcaPqry+jmOz2NqHIlLpD kQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcm4kf351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 19:35:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402Gvu2X019309;
	Tue, 2 Jan 2024 19:35:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30se0tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 19:35:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402JZgOM17564366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 19:35:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072252004B;
	Tue,  2 Jan 2024 19:35:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB2920040;
	Tue,  2 Jan 2024 19:35:41 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 19:35:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 0/3] s390/bpf: Fix gotol with large offsets
Date: Tue,  2 Jan 2024 20:30:34 +0100
Message-ID: <20240102193531.3169422-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CQp9DqWCwwlxiOH7b2PznLFp_iK0vasu
X-Proofpoint-ORIG-GUID: CQp9DqWCwwlxiOH7b2PznLFp_iK0vasu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_07,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020147

Hi,

While looking at a pyperf180 failure on s390x (must be related to [1],
I'm not done with the investigation yet) I noticed that I have
unfortunately messed up the gotol implementation. Patch 1 is the fix,
patch 2 is a small test infrastructure tweak, and patch 3 adds a
test.

[1] https://github.com/llvm/llvm-project/issues/55669

Best regards,
Ilya

Ilya Leoshkevich (3):
  s390/bpf: Fix gotol with large offsets
  selftests/bpf: Double the size of test_loader log
  selftests/bpf: Test gotol with large offsets

 arch/s390/net/bpf_jit_comp.c                  |  2 +-
 .../selftests/bpf/progs/verifier_gotol.c      | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.43.0


