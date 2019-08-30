Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA5A3565
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3LIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:08:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbfH3LIS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Aug 2019 07:08:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UB8DiV024685
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:08:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upyk6ygjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 07:08:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 30 Aug 2019 12:07:48 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 12:07:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UB7KVD36766180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:07:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 330F311C04A;
        Fri, 30 Aug 2019 11:07:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD68611C05E;
        Fri, 30 Aug 2019 11:07:42 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 11:07:42 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>,
        Yonghong Song <yhs@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v4 1/4] selftests/bpf: introduce bpf_cpu_to_be64 and bpf_be64_to_cpu
Date:   Fri, 30 Aug 2019 13:07:29 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830110732.8966-1-iii@linux.ibm.com>
References: <20190830110732.8966-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083011-0008-0000-0000-0000030EFB70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083011-0009-0000-0000-00004A2D42B8
Message-Id: <20190830110732.8966-2-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300121
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_lwt_seg6local and test_seg6_loop use custom 64-bit endianness
conversion macros. Centralize their definitions in bpf_endian.h in order
to reduce code duplication. This will also be useful when bpf_endian.h
is promoted to an offical libbpf header.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/bpf_endian.h         | 14 ++++++++++++++
 .../selftests/bpf/progs/test_lwt_seg6local.c     | 16 ++++++----------
 .../testing/selftests/bpf/progs/test_seg6_loop.c |  8 ++------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index 05f036df8a4c..f92f29c00d50 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -29,6 +29,10 @@
 # define __bpf_htonl(x)			__builtin_bswap32(x)
 # define __bpf_constant_ntohl(x)	___constant_swab32(x)
 # define __bpf_constant_htonl(x)	___constant_swab32(x)
+# define __bpf_be64_to_cpu(x)		__builtin_bswap64(x)
+# define __bpf_cpu_to_be64(x)		__builtin_bswap64(x)
+# define __bpf_constant_be64_to_cpu(x)	___constant_swab64(x)
+# define __bpf_constant_cpu_to_be64(x)	___constant_swab64(x)
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define __bpf_ntohs(x)			(x)
 # define __bpf_htons(x)			(x)
@@ -38,6 +42,10 @@
 # define __bpf_htonl(x)			(x)
 # define __bpf_constant_ntohl(x)	(x)
 # define __bpf_constant_htonl(x)	(x)
+# define __bpf_be64_to_cpu(x)		(x)
+# define __bpf_cpu_to_be64(x)		(x)
+# define __bpf_constant_be64_to_cpu(x)  (x)
+# define __bpf_constant_cpu_to_be64(x)  (x)
 #else
 # error "Fix your compiler's __BYTE_ORDER__?!"
 #endif
@@ -54,5 +62,11 @@
 #define bpf_ntohl(x)				\
 	(__builtin_constant_p(x) ?		\
 	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
+#define bpf_cpu_to_be64(x)			\
+	(__builtin_constant_p(x) ?		\
+	 __bpf_constant_cpu_to_be64(x) : __bpf_cpu_to_be64(x))
+#define bpf_be64_to_cpu(x)			\
+	(__builtin_constant_p(x) ?		\
+	 __bpf_constant_be64_to_cpu(x) : __bpf_be64_to_cpu(x))
 
 #endif /* __BPF_ENDIAN__ */
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
index a334a0e882e4..41a3ebcd593d 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_seg6local.c
@@ -12,10 +12,6 @@
 
 #define SR6_FLAG_ALERT (1 << 4)
 
-#define htonll(x) ((bpf_htonl(1)) == 1 ? (x) : ((uint64_t)bpf_htonl((x) & \
-				0xFFFFFFFF) << 32) | bpf_htonl((x) >> 32))
-#define ntohll(x) ((bpf_ntohl(1)) == 1 ? (x) : ((uint64_t)bpf_ntohl((x) & \
-				0xFFFFFFFF) << 32) | bpf_ntohl((x) >> 32))
 #define BPF_PACKET_HEADER __attribute__((packed))
 
 struct ip6_t {
@@ -276,8 +272,8 @@ int has_egr_tlv(struct __sk_buff *skb, struct ip6_srh_t *srh)
 			return 0;
 
 		// check if egress TLV value is correct
-		if (ntohll(egr_addr.hi) == 0xfd00000000000000 &&
-				ntohll(egr_addr.lo) == 0x4)
+		if (bpf_be64_to_cpu(egr_addr.hi) == 0xfd00000000000000 &&
+		    bpf_be64_to_cpu(egr_addr.lo) == 0x4)
 			return 1;
 	}
 
@@ -308,8 +304,8 @@ int __encap_srh(struct __sk_buff *skb)
 
 	#pragma clang loop unroll(full)
 	for (unsigned long long lo = 0; lo < 4; lo++) {
-		seg->lo = htonll(4 - lo);
-		seg->hi = htonll(hi);
+		seg->lo = bpf_cpu_to_be64(4 - lo);
+		seg->hi = bpf_cpu_to_be64(hi);
 		seg = (struct ip6_addr_t *)((char *)seg + sizeof(*seg));
 	}
 
@@ -349,8 +345,8 @@ int __add_egr_x(struct __sk_buff *skb)
 	if (err)
 		return BPF_DROP;
 
-	addr.lo = htonll(lo);
-	addr.hi = htonll(hi);
+	addr.lo = bpf_cpu_to_be64(lo);
+	addr.hi = bpf_cpu_to_be64(hi);
 	err = bpf_lwt_seg6_action(skb, SEG6_LOCAL_ACTION_END_X,
 				  (void *)&addr, sizeof(addr));
 	if (err)
diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
index 1dbe1d4d467e..c4d104428643 100644
--- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
@@ -12,10 +12,6 @@
 
 #define SR6_FLAG_ALERT (1 << 4)
 
-#define htonll(x) ((bpf_htonl(1)) == 1 ? (x) : ((uint64_t)bpf_htonl((x) & \
-				0xFFFFFFFF) << 32) | bpf_htonl((x) >> 32))
-#define ntohll(x) ((bpf_ntohl(1)) == 1 ? (x) : ((uint64_t)bpf_ntohl((x) & \
-				0xFFFFFFFF) << 32) | bpf_ntohl((x) >> 32))
 #define BPF_PACKET_HEADER __attribute__((packed))
 
 struct ip6_t {
@@ -251,8 +247,8 @@ int __add_egr_x(struct __sk_buff *skb)
 	if (err)
 		return BPF_DROP;
 
-	addr.lo = htonll(lo);
-	addr.hi = htonll(hi);
+	addr.lo = bpf_cpu_to_be64(lo);
+	addr.hi = bpf_cpu_to_be64(hi);
 	err = bpf_lwt_seg6_action(skb, SEG6_LOCAL_ACTION_END_X,
 				  (void *)&addr, sizeof(addr));
 	if (err)
-- 
2.21.0

