Return-Path: <bpf+bounces-10371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703B7A5F37
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434641C20EB1
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B3538C;
	Tue, 19 Sep 2023 10:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19F2E64B
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:24 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606512D
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:13:57 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA89XX008379;
	Tue, 19 Sep 2023 10:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=xQYwpDfE0vxZmfLOkMsWnlnw1wysCqGtjcrUGLeji5c=;
 b=FD0H9NZZdGKqyQsT4xf9fXekObgWqy5Nmp+7o1rAe7e/J0VkYOMScdCodDjSkmWzOB7Q
 vxE88KnkHxV4OYO2e+gM5pNirc0rFhbdI8MiRAL6Bc352npC4HGOSA8lVzkZcm2Qra8h
 MXYAmOLTY8MH0UeSD86+/QfLGWkl+ZAU8NVjRYH52uWd5/R24aqGeWvY+sMmyqaRjfYq
 8I42UQMu4btix88AXa16IuFj6P0sowUqWftcjA/kEc1RaLqk/jwC4XL/FJSPhMCb2LbB
 EAlEDGjOIbtHlu82x48CBl3RGFry2Ahy4vSvGlzgX2YUUOVoYAucmPxkEY3VsixPmJ9y xA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77fwba8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8thrZ031219;
	Tue, 19 Sep 2023 10:13:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6kk1x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADduO43123370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A67AE20069;
	Tue, 19 Sep 2023 10:13:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D9E720067;
	Tue, 19 Sep 2023 10:13:39 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:39 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 00/10] Implement cpuv4 support for s390x
Date: Tue, 19 Sep 2023 12:09:02 +0200
Message-ID: <20230919101336.2223655-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WQPgEGzz8y6aaIs8d3v-LG2cAddjQDTp
X-Proofpoint-ORIG-GUID: WQPgEGzz8y6aaIs8d3v-LG2cAddjQDTp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=827 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v1: https://lore.kernel.org/bpf/20230830011128.1415752-1-iii@linux.ibm.com/
v1 -> v2:
- Redo Disable zero-extension for BPF_MEMSX as Puranjay and Alexei
  suggested.
- Drop the bpf_ct_insert_entry() patch, it went in via the bpf tree.
- Rebase, don't apply A-bs because there were fixed conflicts.

Hi,

This series adds the cpuv4 support to the s390x eBPF JIT.
Patches 1-3 are preliminary bugfixes.
Patches 4-8 implement the new instructions.
Patches 9-10 enable the tests.

Best regards,
Ilya

Ilya Leoshkevich (10):
  bpf: Disable zero-extension for BPF_MEMSX
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
 kernel/bpf/verifier.c                         |   2 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |  25 --
 tools/testing/selftests/bpf/cgroup_helpers.c  |  33 ++-
 .../selftests/bpf/progs/test_ldsx_insn.c      |   9 +-
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       | 149 ++++++----
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 10 files changed, 331 insertions(+), 164 deletions(-)

-- 
2.41.0


