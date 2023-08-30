Return-Path: <bpf+bounces-8944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3678D18D
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA231C20A94
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79646EA2;
	Wed, 30 Aug 2023 01:11:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DEA3D
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:11:56 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692983
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:11:55 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0a1DV028967;
	Wed, 30 Aug 2023 01:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=EW3nQluOrhClHbiqlEyo6zxMwSzvK4EV/JVjc40gyvc=;
 b=iD8ShJa7EJPo25/YuXoGLJxoTZuS1Be/RpXjKVJ/HwGWbDUI/P/eeFuReGF/cB9uZuEr
 boaA4fTBYp6cOeUOYfnOV/JHWOnYC1iSsWewJmrtuaT88KEbTNGl2bE6CeGR4gw/Yjwg
 OOFnXe3bHXVfMrlFHXDKGXQIarPfxugaCAF8Wx49CpAO2zJ6bXyr20bEIbHNnBadd22+
 16rsVEd1pyCZAWLbM2kW0D4DG9mvIwV+Gjz8rz0+SgjZ2rjAuw74umgpw/9RhMkK2lKO
 GmIs/CMMLoeYjJyX3PFs6nVfY5LlwRR+DZaik9C9RxInjPPDG5US0zbhgGTrVf+GzvJB xg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu57rw55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNdFgw020514;
	Wed, 30 Aug 2023 01:11:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3yg6mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1BceI2818734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D9152004B;
	Wed, 30 Aug 2023 01:11:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0584D20043;
	Wed, 30 Aug 2023 01:11:38 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 00/11] Implement cpuv4 support for s390x
Date: Wed, 30 Aug 2023 03:07:41 +0200
Message-ID: <20230830011128.1415752-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uvgcVpP3NO67YVu2R583szMz3s6kjsHi
X-Proofpoint-ORIG-GUID: uvgcVpP3NO67YVu2R583szMz3s6kjsHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=736 bulkscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This series adds the cpuv4 support to the s390x eBPF JIT.
Patches 1-4 are preliminary bugfixes.
Patches 5-9 implement the new instructions.
Patches 10-11 enable the tests.

Best regards,
Ilya

Ilya Leoshkevich (11):
  bpf: Disable zero-extension for BPF_MEMSX
  net: netfilter: Adjust timeouts of non-confirmed CTs in
    bpf_ct_insert_entry()
  selftests/bpf: Unmount the cgroup2 work directory
  selftests/bpf: Add big-endian support to the ldsx test
  s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
  s390/bpf: Implement BPF_MEMSX
  s390/bpf: Implement unconditional byte swap
  s390/bpf: Implement unconditional jump with 32-bit offset
  s390/bpf: Implement signed division
  selftests/bpf: Enable the cpuv4 tests for s390x
  selftests/bpf: Trim DENYLIST.s390x

 arch/s390/net/bpf_jit_comp.c                  | 265 +++++++++++++-----
 kernel/bpf/verifier.c                         |   4 +-
 net/netfilter/nf_conntrack_bpf.c              |   2 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  25 --
 tools/testing/selftests/bpf/cgroup_helpers.c  |  33 ++-
 .../selftests/bpf/progs/test_ldsx_insn.c      |   9 +-
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       | 149 ++++++----
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 11 files changed, 335 insertions(+), 164 deletions(-)

-- 
2.41.0


