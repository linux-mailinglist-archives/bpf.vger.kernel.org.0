Return-Path: <bpf+bounces-8954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704D78D19B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B2D1C20A83
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562D1852;
	Wed, 30 Aug 2023 01:12:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365731849
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:12:15 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450283
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:12:14 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0mi2f025132;
	Wed, 30 Aug 2023 01:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dj/HzMSdaRb8yKMODPF/ljIIR4mgWN44lgwrOiif5ok=;
 b=ipVr/PxeL44ssMC63goZBKsJZ51eyS9qX829CxN24GNVZlzLCqiTGvnKB7JysqRcOAFp
 wfw8x38NAayYcecyvJ+TbXHyq6O1/q0bwipHDRThsvoThoxEuZxUhpAo6ugy5ycxAYQ8
 smgdIHdnKKFcWTuqPK369LR77rMc15NRjBhh5AhJRhE6R1n+YkWO1CpLnlKFuoQWyKT5
 p6oWdlWXWYy9TcHxygzR/auYWwTzUhzyYWjSMuOix4fHvQmUi02WhyWXm/T3BDroi9Sp
 Bxw8yBnkZOUb23lJOPFcubX9IgVP8Hpjg7M37n6CmC5o55F5qmQfrIzkDGFiQGvJhVMB pA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssuja8ptp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:12:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNdFh2020514;
	Wed, 30 Aug 2023 01:12:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3yg6nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:12:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1BvIw60490082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A592004B;
	Wed, 30 Aug 2023 01:11:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0CA320040;
	Wed, 30 Aug 2023 01:11:56 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 10/11] selftests/bpf: Enable the cpuv4 tests for s390x
Date: Wed, 30 Aug 2023 03:07:51 +0200
Message-ID: <20230830011128.1415752-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _iWlnfjDC6o6N0hmKckTZf5O72P5DRfz
X-Proofpoint-GUID: _iWlnfjDC6o6N0hmKckTZf5O72P5DRfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that all the cpuv4 support is in place, enable the tests.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
index 3709e5eb7dd0..3ddcb3777912 100644
--- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -6,7 +6,8 @@
 #include <bpf/bpf_tracing.h>
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 const volatile int skip = 0;
 #else
 const volatile int skip = 1;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 8893094725f0..148b25868c34 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("BSWAP, 16")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 2dae5322a18e..46fe64121e50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("gotol, small_imm")
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 803dc1d492a7..c261f34876d6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("LDSX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 3c8ac2c57b1b..4086147abdd7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("MOV32SX, S8")
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 0990f8825675..d52dcdbf6e7e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -5,7 +5,8 @@
 #include "bpf_misc.h"
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
+     defined(__TARGET_ARCH_s390)) && __clang_major__ >= 18
 
 SEC("socket")
 __description("SDIV32, non-zero imm divisor, check 1")
-- 
2.41.0


