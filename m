Return-Path: <bpf+bounces-79227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B4D2EA76
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 10:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58009302C4D5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5C33A03A;
	Fri, 16 Jan 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aehA+jqF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446722578D;
	Fri, 16 Jan 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555099; cv=none; b=YvkDYTSLDpbc1UaoSQsKhhYqVqQRNvNPVAt9LkkwSYl2DC/kKsInBBFs6Qu4jG/YvjPK+kHUWAj1PjDttdDBB8QUxHu0QmLTaTByPluYmViSRhnMLthO1SJE3kXrq7A8PyiyOo0XhlxuIPMEa796hHF+ryhKrqawrOPei7Bmsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555099; c=relaxed/simple;
	bh=4WqsnuCcafscwMGsV2WgfkgJOEkzXzYMsqTyijZb89A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBH9bjO/LCW1GXwQEcTrvckW0hiPn0Ni+axgi8A3vDERZINdqafBOkotdlqwPpIw3Sw64NSq9rE9IWuojSC0BqNauMnBLBeeLqgOBjLE8kKVGQoyoZnrBVv2q2383imx0+NCF/pgsgMnhA6TKJn1+rHdj15ue7AcBUr8GCxe4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aehA+jqF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNSiT1910591;
	Fri, 16 Jan 2026 09:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1eHA4FpwMc5JARNRGDgekY+LoPmgk
	hG28tbPrd8vUQg=; b=aehA+jqFaeULzrRUYofy5CzDJjAAnp4P0Uj1E1gDAoDUO
	NjHwxMpW5tqQz+trteljQ6+OpY1zgx5aFnCZf6jWwvMt15QsiUGB4X62GJc2IFdI
	3X4dhWwBUI0VTaKB82fo6EcflIzZ2P7zG/Yygy4MK2ykih3m5ft8vkjWqJc3WuZj
	JuTz1l6REZp/OulESSHjlM8q7aFoW78mB/2rymTKcKZBrf4BANezh7YSgwEB9J/3
	ZCg1/yJoxVJOaMZx8n4a4HZQ3DvuRYCzHeVYQbMe3jpW3jIoKfycunZUu5SxHgHU
	lMP464D9RM66T0SsVgQQNR3EagPT16zrJ/3VuhcxA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkh7nstjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 09:17:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G81fBf003946;
	Fri, 16 Jan 2026 09:17:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7pfg98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 09:17:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60G9HbnS037280;
	Fri, 16 Jan 2026 09:17:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-30.vpn.oracle.com [10.154.52.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7pfg5w-1;
	Fri, 16 Jan 2026 09:17:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: kees@kernel.org, nathan@kernel.org, peterz@infradead.org, elver@google.com
Cc: ojeda@kernel.org, akpm@linux-foundation.org, ubizjak@gmail.com,
        Jason@zx2c4.com, Marc.Herbert@linux.intel.com, hca@linux.ibm.com,
        hpa@zytor.com, namjain@linux.microsoft.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com,
        yonghong.song@linux.dev, ast@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org,
        nilay@linux.ibm.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH] kcsan, compiler_types: avoid duplicate type issues in BPF Type Format
Date: Fri, 16 Jan 2026 09:17:30 +0000
Message-ID: <20260116091730.324322-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160067
X-Proofpoint-GUID: _VrFuegKXDT1k-hu-eAy-zdHomh7zhO9
X-Authority-Analysis: v=2.4 cv=X7Bf6WTe c=1 sm=1 tr=0 ts=696a0233 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=n6UkxPfBHvz30Sq8m4YA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA2OCBTYWx0ZWRfX6UHHMaO0HgqR
 3XxOcdQqnKQzKZTlYcwP0rSoB7DB8vpAJKYNC+SrZgpLtXiQdxxmRDqn2iWN9hVHlZVF/qCCVP/
 belJaf4EF86nmMNTqcuxr4mbKwZOxszupAqH18xsiSXDV5w28wJi+EC3WK3x5bbnwwznRzp6jcE
 ZxIh0hJSyD5SjuG8cE1+nJ7uFH/r3Gq0lYHY+RUXWtf93oq4Cf2AYwRiW/edPoIDt2japfxmFhc
 7o9UTaqys+PShZE1RKzu3LQolw0DNC/I9MQQGh+X3HgSRHKoMAuaWaLM6KBanOft7nP5BTA6t7O
 UaJK8t7SdZnjyN6iI331TXcZC9wVJ44k5mF3YLk8n/DYv8KmpQhO/HRPmn70Pvp0wgFlSciXgAA
 ksn5U9H6JD4WnRcQsnihp+I0D9UjL4ldFvcV3qgQRrBapDWII65bBdEARREXJlXne5OAgN+gHQL
 ZRnhklWSLSRomTGC2P8DwkZX6Yaf5fgEUNopU1hM=
X-Proofpoint-ORIG-GUID: _VrFuegKXDT1k-hu-eAy-zdHomh7zhO9

Enabling KCSAN is causing a large number of duplicate types
in BTF for core kernel structs like task_struct [1].
This is due to the definition in include/linux/compiler_types.h

`#ifdef __SANITIZE_THREAD__
...
`#define __data_racy volatile
..
`#else
...
`#define __data_racy
...
`#endif

Because some objects in the kernel are compiled without
KCSAN flags (KCSAN_SANITIZE) we sometimes get the empty
__data_racy annotation for objects; as a result we get multiple
conflicting representations of the associated structs in DWARF,
and these lead to multiple instances of core kernel types in
BTF since they cannot be deduplicated due to the additional
modifier in some instances.

Moving the __data_racy definition under CONFIG_KCSAN
avoids this problem, since the volatile modifier will
be present for both KCSAN and KCSAN_SANITIZE objects
in a CONFIG_KCSAN=y kernel.

Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/compiler_types.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3c2577..86111a189a87 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -303,6 +303,22 @@ struct ftrace_likely_data {
 # define __no_kasan_or_inline __always_inline
 #endif
 
+#ifdef CONFIG_KCSAN
+/*
+ * Type qualifier to mark variables where all data-racy accesses should be
+ * ignored by KCSAN. Note, the implementation simply marks these variables as
+ * volatile, since KCSAN will treat such accesses as "marked".
+ *
+ * Defined here because defining __data_racy as volatile for KCSAN objects only
+ * causes problems in BPF Type Format (BTF) generation since struct members
+ * of core kernel data structs will be volatile in some objects and not in
+ * others.  Instead define it globally for KCSAN kernels.
+ */
+# define __data_racy volatile
+#else
+# define __data_racy
+#endif
+
 #ifdef __SANITIZE_THREAD__
 /*
  * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
@@ -314,16 +330,9 @@ struct ftrace_likely_data {
  * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
  */
 # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
-/*
- * Type qualifier to mark variables where all data-racy accesses should be
- * ignored by KCSAN. Note, the implementation simply marks these variables as
- * volatile, since KCSAN will treat such accesses as "marked".
- */
-# define __data_racy volatile
 # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #else
 # define __no_kcsan
-# define __data_racy
 #endif
 
 #ifdef __SANITIZE_MEMORY__
-- 
2.39.3


