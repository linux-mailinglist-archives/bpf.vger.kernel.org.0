Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5F230981
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgG1MCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 08:02:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12844 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728179AbgG1MCi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 08:02:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SC1t1C083181;
        Tue, 28 Jul 2020 08:02:24 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32j7sxb7j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 08:02:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SC0Mvf030114;
        Tue, 28 Jul 2020 12:02:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0t5kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 12:02:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SC2DiW31261162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 12:02:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2631311C058;
        Tue, 28 Jul 2020 12:02:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E90E11C04C;
        Tue, 28 Jul 2020 12:02:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.173.62])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 12:02:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
Date:   Tue, 28 Jul 2020 14:00:59 +0200
Message-Id: <20200728120059.132256-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728120059.132256-1-iii@linux.ibm.com>
References: <20200728120059.132256-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_07:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280088
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
bpf_probe_read{, str}() only to archs where they work") that makes more
samples compile on s390.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
 tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index eae5cccff761..b108381fbec4 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -23,28 +23,29 @@ enum bpf_field_info_kind {
 	__builtin_preserve_field_info((src)->field, BPF_FIELD_##info)
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-#define __CORE_BITFIELD_PROBE_READ(dst, src, fld)			      \
-	bpf_probe_read((void *)dst,					      \
-		       __CORE_RELO(src, fld, BYTE_SIZE),		      \
-		       (const void *)src + __CORE_RELO(src, fld, BYTE_OFFSET))
+#define __CORE_BITFIELD_PROBE_READ(dst, src, fld)                              \
+	bpf_probe_read_kernel((void *)dst, __CORE_RELO(src, fld, BYTE_SIZE),   \
+			      (const void *)src +                              \
+				      __CORE_RELO(src, fld, BYTE_OFFSET))
 #else
 /* semantics of LSHIFT_64 assumes loading values into low-ordered bytes, so
  * for big-endian we need to adjust destination pointer accordingly, based on
  * field byte size
  */
-#define __CORE_BITFIELD_PROBE_READ(dst, src, fld)			      \
-	bpf_probe_read((void *)dst + (8 - __CORE_RELO(src, fld, BYTE_SIZE)),  \
-		       __CORE_RELO(src, fld, BYTE_SIZE),		      \
-		       (const void *)src + __CORE_RELO(src, fld, BYTE_OFFSET))
+#define __CORE_BITFIELD_PROBE_READ(dst, src, fld)                              \
+	bpf_probe_read_kernel(                                                 \
+		(void *)dst + (8 - __CORE_RELO(src, fld, BYTE_SIZE)),          \
+		__CORE_RELO(src, fld, BYTE_SIZE),                              \
+		(const void *)src + __CORE_RELO(src, fld, BYTE_OFFSET))
 #endif
 
 /*
  * Extract bitfield, identified by s->field, and return its value as u64.
  * All this is done in relocatable manner, so bitfield changes such as
  * signedness, bit size, offset changes, this will be handled automatically.
- * This version of macro is using bpf_probe_read() to read underlying integer
- * storage. Macro functions as an expression and its return type is
- * bpf_probe_read()'s return value: 0, on success, <0 on error.
+ * This version of macro is using bpf_probe_read_kernel() to read underlying
+ * integer storage. Macro functions as an expression and its return type is
+ * bpf_probe_read_kernel()'s return value: 0, on success, <0 on error.
  */
 #define BPF_CORE_READ_BITFIELD_PROBED(s, field) ({			      \
 	unsigned long long val = 0;					      \
@@ -99,9 +100,9 @@ enum bpf_field_info_kind {
 	__builtin_preserve_field_info(field, BPF_FIELD_BYTE_SIZE)
 
 /*
- * bpf_core_read() abstracts away bpf_probe_read() call and captures offset
- * relocation for source address using __builtin_preserve_access_index()
- * built-in, provided by Clang.
+ * bpf_core_read() abstracts away bpf_probe_read_kernel() call and captures
+ * offset relocation for source address using
+ * __builtin_preserve_access_index() built-in, provided by Clang.
  *
  * __builtin_preserve_access_index() takes as an argument an expression of
  * taking an address of a field within struct/union. It makes compiler emit
@@ -114,18 +115,18 @@ enum bpf_field_info_kind {
  * actual field offset, based on target kernel BTF type that matches original
  * (local) BTF, used to record relocation.
  */
-#define bpf_core_read(dst, sz, src)					    \
-	bpf_probe_read(dst, sz,						    \
-		       (const void *)__builtin_preserve_access_index(src))
+#define bpf_core_read(dst, sz, src)                                            \
+	bpf_probe_read_kernel(                                                 \
+		dst, sz, (const void *)__builtin_preserve_access_index(src))
 
 /*
- * bpf_core_read_str() is a thin wrapper around bpf_probe_read_str()
+ * bpf_core_read_str() is a thin wrapper around bpf_probe_read_kernel_str()
  * additionally emitting BPF CO-RE field relocation for specified source
  * argument.
  */
-#define bpf_core_read_str(dst, sz, src)					    \
-	bpf_probe_read_str(dst, sz,					    \
-			   (const void *)__builtin_preserve_access_index(src))
+#define bpf_core_read_str(dst, sz, src)                                        \
+	bpf_probe_read_kernel_str(                                             \
+		dst, sz, (const void *)__builtin_preserve_access_index(src))
 
 #define ___concat(a, b) a ## b
 #define ___apply(fn, n) ___concat(fn, n)
@@ -239,15 +240,17 @@ enum bpf_field_info_kind {
  *	int x = BPF_CORE_READ(s, a.b.c, d.e, f, g);
  *
  * BPF_CORE_READ will decompose above statement into 4 bpf_core_read (BPF
- * CO-RE relocatable bpf_probe_read() wrapper) calls, logically equivalent to:
+ * CO-RE relocatable bpf_probe_read_kernel() wrapper) calls, logically
+ * equivalent to:
  * 1. const void *__t = s->a.b.c;
  * 2. __t = __t->d.e;
  * 3. __t = __t->f;
  * 4. return __t->g;
  *
  * Equivalence is logical, because there is a heavy type casting/preservation
- * involved, as well as all the reads are happening through bpf_probe_read()
- * calls using __builtin_preserve_access_index() to emit CO-RE relocations.
+ * involved, as well as all the reads are happening through
+ * bpf_probe_read_kernel() calls using __builtin_preserve_access_index() to
+ * emit CO-RE relocations.
  *
  * N.B. Only up to 9 "field accessors" are supported, which should be more
  * than enough for any practical purpose.
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 58eceb884df3..4eb3be4130f0 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -288,11 +288,16 @@ struct pt_regs;
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = PT_REGS_RET(ctx); })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
 #else
-#define BPF_KPROBE_READ_RET_IP(ip, ctx)					    \
-	({ bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
-#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)				    \
-	({ bpf_probe_read(&(ip), sizeof(ip),				    \
-			  (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)                                        \
+	({                                                                     \
+		bpf_probe_read_kernel(&(ip), sizeof(ip),                       \
+				      (void *)PT_REGS_RET(ctx));               \
+	})
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                                     \
+	({                                                                     \
+		bpf_probe_read_kernel(&(ip), sizeof(ip),                       \
+				      (void *)(PT_REGS_FP(ctx) + sizeof(ip))); \
+	})
 #endif
 
 #define ___bpf_concat(a, b) a ## b
-- 
2.25.4

