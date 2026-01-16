Return-Path: <bpf+bounces-79261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF058D32914
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F95B305E845
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DA3064B5;
	Fri, 16 Jan 2026 14:25:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99A336EF9
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573514; cv=none; b=rGnbWX+RqdWQVGwku9L3V/UB7rRdFsvjbsmK3+Kk9JqXw9lceQy94sI7LyR2mIpYVr7I3cyn8fN0ztx08sLWveqhk0qnCi7r7CuKek3ZJkkUn+SRgbybB/ZrS6UxctafsTRY6CoMI1OJoAXhe1WFZft5gLr2bvZxPCMNMHl4IfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573514; c=relaxed/simple;
	bh=sDGDVhmzQCxO8pSD2SQEp7Ynbj/ET9NDoNPxJ2fTehE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAJ75SyK1bDGoCzmkKPjF4gGoyeqGXf+uNu1kSd18c/5IaX53Od398ZxvQLFNrzjBX+DBlJVZBfpd3+/wTqFQl0vOljzmd5ytThI3jNgrDPcuBnA5H34XuZ+YHHK7irbbM+9nyBIwC4mqR6vEkyS45K/eO0vSCGssgoWQBzD8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: +RaOhoAXRSWRSI/tBNX6Rw==
X-CSE-MsgGUID: fdNi12TsStiO0Ki0ZlRrIg==
X-IPAS-Result: =?us-ascii?q?A2GEBAC2SWpp/zYImYJagluCVYJbtmgGCQEBAQEBAQEBA?=
 =?us-ascii?q?VoEAQGFBwKMeCc4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBAQEBB?=
 =?us-ascii?q?gMBAQICgR2GCVNJARABhggGMgFGEFFWGYMCgnS0EoEB3XotVIEmAQsUAYE4j?=
 =?us-ascii?q?VJxhHhCgg2EfYQahm0EgzCUJEiBHgNZLAETQhMNCgsHBWphAhkDNRIqFW4IE?=
 =?us-ascii?q?RkdgRkKPheBChsHBYFQBoIVhmkPiTKBXAMLGA1IESw3FBtCbgePLEeBPGsHg?=
 =?us-ascii?q?Q57NpALB4d3jw+hEYQmhFEfnGhNhASUFZJSLphYpFmGZ4F/TTiDIlIZD44tF?=
 =?us-ascii?q?sUsaTwCBwsBAQMJhn6KbIF/AQE?=
IronPort-Data: A9a23:TJQrg6PNMZGoWSvvrR0JlsFynXyQoLVcMsEvi/4bfWQNrUomhTcGm
 mpJXGqBOPrfZzakftB+Poy28hhV6MLWy4UyTAZtpSBmQlt08vbIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYgbNNwJcaDpOtfra8U035pwehRtB1rAATaET1LPhvyRNZH4vDfnZB2f1RIBSAtm7S
 47rpJml/nnU9gsaEdislLD2aCUiGtY+6iDX1xK684D76vRzjnRaPpQTbZLwWm8O49m9pO2d/
 f0W3XCGpafFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZX7I0Er7xIAahihZa07FdRwxwp5PY1B3
 b8iIRcNaTmzvdmJ+omaDfVGoPR9Fta+aevzulk4pd3YJfM2BJzOR6TU6MVJmio9jYZHFrDcf
 6L1axI2N0yGOkAUfAdRVc5WcOSA3xETdxVZs1KUtKMy6kDT1Ac30aOrLdfePNWBA8dN9qqdj
 jueoTugW09KbbRzzxKL/lSt37XzhhjnWaVKN7zgxPpQmnyckzl75Bo+DwLh/qbg2yZSQel3K
 lcU+zsnqKEa9FSgCNjmGQC1qziNtVgeQ7Jt//YS7RHIxqfQ4hiUHHldCCNMY5ovv4k0XVTGy
 2NlgfuqPzVIsLq8eUimyY2vjHSuEw4lc1UdMHpsoRQ+3zX1nG0kpjD3JuuP/Yawnpj5FDXx3
 T2QvXF4mrgYy8cAkaejlbwmv95OjsWUJuLWzlyJNo5A0u+fTNT6D2BPwQGKhcus1K7DEjG8U
 IEswqBzLIkmVPlhbhBhv9nh7Jnzvqzab2SN6bKeN4Uh+nyw/X+9cJpL4S1vbEBnessAdDT1e
 kiWsgRU4YJVPXCjca5wZZnZNvnHDMHIS7zYaxwjRoEfPccgLlLWpn8GiIz59zmFrXXAWJoXY
 f+zGftAx15AYUi75FJan9sg7II=
IronPort-HdrOrdr: A9a23:1j77B6AaRfuO+HTlHemV55DYdb4zR+YMi2TDtnoBLiC9Hfb3qy
 nDppUmPHzP+VIssRMb6LO90cC7KBu2yXcS2+ks1NyZMDUO1lHEEKhSqaPk3j3eGzbj7Idmv5
 uIC5IOauEYWmIK6PoTNmGDfOod/A==
X-Talos-CUID: 9a23:Ch1MtG+/EVV6tOjTpmOVvw0uE+cldVTt9kzvGXSZTnpDbo3Lc0DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A3VwcUw52xo+n+ePKcbaR1jCvxoxm74KvURoxiq4?=
 =?us-ascii?q?auu7cFi0oCTOnlhW4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,231,1763391600"; 
   d="scan'208";a="106711682"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 23:25:08 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 77BA2183E387;
	Fri, 16 Jan 2026 23:25:08 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	mykyta.yatsenko5@gmail.com,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_strncasecmp kfunc
Date: Fri, 16 Jan 2026 23:24:54 +0900
Message-ID: <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
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
 kernel/bpf/helpers.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..bdd76209cfcf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,18 +3406,23 @@ __bpf_kfunc void __bpf_trap(void)
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
 
+	if (len == 0)
+		return 0;
+
+	max_sz = min_t(int, len, XATTR_SIZE_MAX);
+
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+	for (i = 0; i < max_sz; i++) {
 		__get_kernel_nofault(&c1, s1, char, err_out);
 		__get_kernel_nofault(&c2, s2, char, err_out);
 		if (ignore_case) {
@@ -3431,6 +3436,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 		s1++;
 		s2++;
 	}
+	if (len < XATTR_SIZE_MAX)
+		return 0;
 	return -E2BIG;
 err_out:
 	return -EFAULT;
@@ -3451,7 +3458,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
  */
 __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
 }
 
 /**
@@ -3469,7 +3476,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
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
+ * @len: The maximum number of characters to compare (limited by XATTR_SIZE_MAX)
+
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
@@ -4521,6 +4547,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
+BTF_ID_FLAGS(func, bpf_strncasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.52.0


