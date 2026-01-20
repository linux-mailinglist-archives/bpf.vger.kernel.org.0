Return-Path: <bpf+bounces-79559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFEED3C00C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31B383A487E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79962E62B4;
	Tue, 20 Jan 2026 07:04:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AB36CDF8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892675; cv=none; b=izdlFzZQIurPe0OXHUnzNNZv9arCo1/CyUkLZndBWYu3kS0xNYGCeVwFr1o2hF58Rcu0nQ2s5piPJiupYycNzswn86XOeTUkPMrOPLM0OCk+Nl1P5hWDvi/JypCUqV7fl2GRAiArR2OMr+qks68qlftB8jm4ktUVN7d3x1mvu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892675; c=relaxed/simple;
	bh=o/Ftsq/tVVe52Ju+nUyJ7BjHwVftE6o/D58vksncfyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZfllPvTuUef6b3Yd4x7nIOJ1tXRaKl4f66oUJPE8cz3x+11mB/dPnT6cel1vP9oIGymvEeeC38Nyz+CA6fz4jp9sOF4Kb5Y79MUbA7grE2S1E2UJUSX5+4h1Eh7ao6g4SgP1onDhILdegQTFZb075rwqwpnZ4L2I9TsxxoD2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: Nf8rTLfYSVqmlmaUfVM/Ow==
X-CSE-MsgGUID: RNpU4IooToCg1b3lJKuW3Q==
X-IPAS-Result: =?us-ascii?q?A2GEBADJJ29p/zcImYJagluCVYJbtmgGCQEBAQEBAQEBA?=
 =?us-ascii?q?VoEAQGFBwKMeic4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBAQEBB?=
 =?us-ascii?q?gMBAQICgR2GCVNJARABhggGMgFGEFFWGYMCgnSxLIEB3XotVIEmAQsUAYE4j?=
 =?us-ascii?q?VJxhHhCgg2EfYQadoV3BIMwlA5IgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuC?=
 =?us-ascii?q?BEZHYEZCj4XgQobBwWBIgaCFYZpD4kygV8DCxgNSBEsNxQbQm4HjxFHgTxrB?=
 =?us-ascii?q?4EOezaQCweHd48PoRGEJoRRH5xoTYQElBWSUi6YWKRZhmeBf004gyJSGQ+OL?=
 =?us-ascii?q?RbMAWk8AgcLAQEDCYZ+imyBfwEB?=
IronPort-Data: A9a23:WoHUyKDeAkfwUxVW/4/iw5YqxClBgxIJ4kV8jS/XYbTApD4i1DVSz
 GVOUT/QOqrbMGeneox2Ot++oBsPv5HSy943TANkpHpgZkwRlceUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuFYTdJ5xYuajhKs/vZ8Es21BjPkGpwUmIWNKgjUGD2yiF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQR4/ZwGyojxE4
 I4lWapc6eseFvakdOw1C3G0GszlVEFM0OevzXOX6KR/w6BaGpdFLjoH4EweZOUlFuhL7W5m0
 /JIMgwpYCG4ufuzxLeyd+dSo4MEM5y+VG8fkikIITDxCOZjTZ3HQrvH/84ewTo7wMlFW/TGD
 yYbQWM0NFKZPkYJahFKVfrSn8/x7pX7WzxDqFOErK8+y2jLx0pwy/7wPdGTc9fMR909ckOw/
 zqYrjyiXE5BXDCZ4QCj6k/wp+jIoSTQV9sYT7ma1eNV22TGkwT/DzVMDAHk/qDo4qKkYPpeM
 EwV6yMrpIAy7EftT8K7QhCz5neP+BwEM+e8CMU/+ESBx67V/QuDFzJCUzNKLtUt8s0uLdA36
 rOXt/XnVSZTlLOkckyE87ORpA68Bw1SCnBXMEfoUjA5D8/fTJYbrCqnczqOOKuly9H4HTDuz
 iqb9m4jir5VhMVN1b3TEbH7b9CE+8ehou0dv1q/soeZAuRRPtbNWmBQwQKHhcus1a7AJrRB1
 VBd8yRk0AzxMX19vHbUGrpSReDBCwetLD3RyUNpHocs7S+s52/reo4Y7TVzL1tzNYMPfjrsf
 UnSsgpN5ZhVJxOXUEK2CqrvY/kXIV/ITIi+DKqFMYsQM/CctmavpUlTWKJZ5Ei1+GBErE31E
 c3znRqEZZrCNZla8Q==
IronPort-HdrOrdr: A9a23:Qy3pD66dHJRWKGDabgPXwO7XdLJyesId70hD6qkXc20wTiX4rb
 HKoB1/73TJYVkqN03I9errBEDiewK/yXcK2+ks1N6ZNWHbUQCTQL2Kg7GO/xTQXwDj7e5U0u
 NBfsFFeb7NJGk/oNrg4AG+V/IpwNyp66at7N2x815dCSx3cKFp6ENDAB+HL0sefmh7OaY=
X-Talos-CUID: 9a23:ZxpKQWMYYtZHOu5Dfic37nIwFPEeTGTYyHLZHkGGLCFOV+jA
X-Talos-MUID: 9a23:59QXwwRhwKzoAsGBRXTWoilfaOZv5JipI09Um84CmeqZCndJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106903674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 16:04:24 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 1376F1839FBB;
	Tue, 20 Jan 2026 16:04:24 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
Date: Tue, 20 Jan 2026 16:03:35 +0900
Message-ID: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_strncasecmp() function performs same like bpf_strcasecmp() except
limiting the comparison to a specific length.

Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
---
 kernel/bpf/helpers.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..753753f039ff 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,18 +3406,20 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
-static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
+static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
 	char c1, c2;
-	int i;
+	int i, max_sz;
 
 	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
 	    !copy_from_kernel_nofault_allowed(s2, 1)) {
 		return -ERANGE;
 	}
 
+	max_sz = min_t(int, len, XATTR_SIZE_MAX);
+
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+	for (i = 0; i < max_sz; i++) {
 		__get_kernel_nofault(&c1, s1, char, err_out);
 		__get_kernel_nofault(&c2, s2, char, err_out);
 		if (ignore_case) {
@@ -3431,7 +3433,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 		s1++;
 		s2++;
 	}
-	return -E2BIG;
+	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
 err_out:
 	return -EFAULT;
 }
@@ -3451,7 +3453,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
  */
 __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
 }
 
 /**
@@ -3469,7 +3471,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
  */
 __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, true);
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
+}
+
+/*
+ * bpf_strncasecmp - Compare two length-limited strings, ignoring case
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ * @len: The maximum number of characters to compare
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
+{
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
 }
 
 /**
@@ -4521,6 +4542,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
+BTF_ID_FLAGS(func, bpf_strncasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.52.0


