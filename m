Return-Path: <bpf+bounces-6544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817D76B1D5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585D51C20D69
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181820FA6;
	Tue,  1 Aug 2023 10:30:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458922EFD
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 10:30:48 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E0116
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 03:30:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3719aMbG029614;
	Tue, 1 Aug 2023 10:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=Tkz0WhI415r6msMJMYEFSeRBabkM6AJF/2WNTtFQt1s=;
 b=1KhKCqV76dJSGLglgO6YdhEcXnv84VFy+Guq1uuCWvlhycxBTdKRd3JKivzcxYNqYLox
 rvPosW2LEJBMUs+IDDpzCK6MNDOqcd7fU72mDxzGchm46+tDyHWxCw6WlUROR333U62e
 qe8m/yvZceQHKoXpFo2/cgyZmJvz7VwFMMizg4CwDiHS29dKTCFHxzPaWzNgXXRY5ajS
 cURzT1fGxHdt4tXZwIYHEkO1Ygj5xaQLAZO5Om3Moz1NgdyUA4CgWUPIxX1YMa4VXEEJ
 V//aWI23i+xKEDIKMHfvrBzYXdpY52Z/lBuzVyuV8uJcXojMVE9VHGRf2RMfuWbzOPki 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd4njg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 10:30:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3719q8fD000923;
	Tue, 1 Aug 2023 10:30:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7c4ug0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 10:30:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371AU1Cu014842;
	Tue, 1 Aug 2023 10:30:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-219-162.vpn.oracle.com [10.175.219.162])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s4s7c4u4c-1;
	Tue, 01 Aug 2023 10:30:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Colm Harrington <colm.harrington@oracle.com>
Subject: [PATCH bpf] selftests/bpf: fix static assert compilation issue for test_cls_*.c
Date: Tue,  1 Aug 2023 11:29:42 +0100
Message-Id: <20230801102942.2629385-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010095
X-Proofpoint-GUID: qOOo0-9eDqjbdyaumbglVkH_3hyvkBXQ
X-Proofpoint-ORIG-GUID: qOOo0-9eDqjbdyaumbglVkH_3hyvkBXQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")

...was backported to stable trees such as 5.15. The problem is that with older
LLVM/clang (14/15) - which is often used for older kernels - we see compilation
failures in BPF selftests now:

In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:90:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:91:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv4.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:95:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:96:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv6.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
2 errors generated.
make: *** [Makefile:594: tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1

The problem is the new offsetof() does not play nice with static asserts.
Given that the context is a static assert (and CO-RE relocation is not
needed at compile time), offsetof() usage can be replaced by
__builtin_offsetof(), and all is well.  Define __builtin_offsetofend()
to be used in static asserts also, since offsetofend() is also defined in
bpf_util.h and is used in userspace progs, so redefining offsetofend()
in test_cls_redirect.h won't work.

Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.c | 11 ++++-------
 tools/testing/selftests/bpf/progs/test_cls_redirect.h |  3 +++
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c    | 11 ++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 66b304982245..e68e0544827c 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -28,9 +28,6 @@
 #define INLINING __always_inline
 #endif
 
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
-
 #define IP_OFFSET_MASK (0x1FFF)
 #define IP_MF (0x2000)
 
@@ -88,13 +85,13 @@ typedef struct {
 
 _Static_assert(
 	sizeof(flow_ports_t) !=
-		offsetofend(struct bpf_sock_tuple, ipv4.dport) -
-			offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
+		__builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
+		__builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
 	"flow_ports_t must match sport and dport in struct bpf_sock_tuple");
 _Static_assert(
 	sizeof(flow_ports_t) !=
-		offsetofend(struct bpf_sock_tuple, ipv6.dport) -
-			offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
+		__builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
+		__builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
 	"flow_ports_t must match sport and dport in struct bpf_sock_tuple");
 
 typedef int ret_t;
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index 76eab0aacba0..1de0b727a3f6 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -12,6 +12,9 @@
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 
+#define __builtin_offsetofend(TYPE, MEMBER) \
+	(__builtin_offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
+
 struct gre_base_hdr {
 	uint16_t flags;
 	uint16_t protocol;
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index f41c81212ee9..463b0513f871 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -23,9 +23,6 @@
 #include "test_cls_redirect.h"
 #include "bpf_kfuncs.h"
 
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
-
 #define IP_OFFSET_MASK (0x1FFF)
 #define IP_MF (0x2000)
 
@@ -83,13 +80,13 @@ typedef struct {
 
 _Static_assert(
 	sizeof(flow_ports_t) !=
-		offsetofend(struct bpf_sock_tuple, ipv4.dport) -
-			offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
+		__builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
+		__builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
 	"flow_ports_t must match sport and dport in struct bpf_sock_tuple");
 _Static_assert(
 	sizeof(flow_ports_t) !=
-		offsetofend(struct bpf_sock_tuple, ipv6.dport) -
-			offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
+		__builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
+		__builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
 	"flow_ports_t must match sport and dport in struct bpf_sock_tuple");
 
 struct iphdr_info {
-- 
2.39.3


