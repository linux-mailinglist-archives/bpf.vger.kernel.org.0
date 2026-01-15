Return-Path: <bpf+bounces-79100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5BD276B8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50CAC3174BBD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EB34216C;
	Thu, 15 Jan 2026 17:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DE2D780A
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498774; cv=none; b=j9HtufzSO9aFP1zbsrKtMZ51SgIFrP6srK065I/yA0pfFCK7EYd8t4bohd24XlOsPP5R1rrsOYaukKoFVD6wuiVeUFve+I3pYu7q7urh6LQNR8y2kzGmXUt8pyNKLbB1BxqZBbccs7f59bm7YdRZkrv2Ct+FWT5oQ0kXyfQel08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498774; c=relaxed/simple;
	bh=NkVgn9nSf8ogjYfDdNT0z4BfCroBi8LYF/wVVOAAHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caXTkI4wVEN5dHbjR9hghfGXp+KzQuCVaW3dkxO5qg0FlLv9ZkpY3keqbqsusQMltNasHtzegDIvi2mMNy7DgO3ylrhBe2Kjz06x5020kqA+9ehXHKsNq2WRJxyvYopYU2r4tXy89zuGDvPGeknayn7CsQMZ9hJ7mWCjsA4pFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: uM/lQ0umRfiG1K8xw6524A==
X-CSE-MsgGUID: Sp/X9yR8RHmL6AQcbY/eqg==
X-IPAS-Result: =?us-ascii?q?A2GFBACdJWlp/zYImYJagluCVYJbtmgGCQEBAQEBAQEBA?=
 =?us-ascii?q?VoEAQGFBwKMdic4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBAQEBB?=
 =?us-ascii?q?gMBAQICgR2GCVNJARABhggGMgFGEEARVhmDAoJ0sgaBAd16LVSBJgELFAGBO?=
 =?us-ascii?q?I1ScYR4QoINhH2EGnaFdwSDMJQWSIEeA1ksARNCEw0KCwcFamECGQM1EioVb?=
 =?us-ascii?q?ggRGR2BGQo+F4EKGwcFgVIGghaGZg+JMoFLAwsYDUgRLDcUG0JuB48gR4E6a?=
 =?us-ascii?q?weBDns2kAsHlwahEYQmhFEfnGhNhASUFZJSLphYpFmGZ4F/TTiDIlIZD44tF?=
 =?us-ascii?q?sQ9aTwCBwsBAQMJhn6KbIF/AQE?=
IronPort-Data: A9a23:kb9rdazcpwgm1tmyxlR6t+ebxyrEfRIJ4+MujC+fZmUNrF6WrkUOn
 2MeD2yFb/uLZ2X0c9onPYvip04O6JHcy9E2HQRvrS00HyNBpOP7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6jufQGuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWcc3l48sfrZ9ks25amq4lv0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3Q9zxF8
 +ihgLTrIesf0g0gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xSun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAC0oKRS63/+z+ry6ZbBP1tQ8cpSxYKpK7xmMzRmBZRonaZXTBqnH4d5G0S0hwN1DFrDXb
 IwbcVKDbjyZOEUJYwpMTsJ4wbvAanrXKlW0rHqUvqo28mHWxSRxyLOrMcGTZ9GBA8xe2ESAz
 o7D1z2hXE9BaoTHlFJp9FqXnqj/zDLBCLgyEZnm38dhimzUy3UcXUh+uVyT+6Dj1RHnCrqzM
 Xc8+zEurLk78UWDTsH2GRyj5mOJtVgVUJxSC4UHBBqlz7qR7wudB3YJVC8YLsErv4k/Tnooz
 jdlgu8FGxRylfqRcCqA842arBzrGngFMjFfP3MtGF5tD8bYnG0lsv7YZvRbeJNZY/XwCXT8z
 jSLsiUkluxVkMMAkaywu1Lf695NmnQrZlNojuk0djv7hu+cWGJDT9b3gbQ8xa8RRLt1tnHb4
 BA5dzG2tYjjzfilzURhutnh441FF97faWeD3gc+d3XQ3yit9ja+e4FO7StlJVt4esEKMTLtb
 UTPowQU75hWOWasbKR+f4O2Dd9C8JUN1L3NCJjpUza5SsIqLFLdoXkwPRH4MqKEuBFErJzT8
 KyzKa6EZUv2w4w9pNZqb4/xCYMW+x0=
IronPort-HdrOrdr: A9a23:rCq8UKGz1kTAYfkipLqE3ceALOsnbusQ8zAXPidKOGVom62j5q
 aTdZEgvnXJYVkqNU3I5urwQJVoLUmyyXcN2/h1AV76ZniFhILKFvAE0WKB+V3d8nbFh4pgPM
 5bGsBD4bvLY2SS5vya3ODXKbodKaG8gcOVbO7lvgxQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3A2H3mbGrfkVJe41QmS5GDEHrmUd0ANXnklGrVGUG?=
 =?us-ascii?q?5Jj9KGK2KFwLKpIoxxg=3D=3D?=
X-Talos-MUID: 9a23:yjpNzAmdM8LdktEMHhMydnpZLIBYsrWUWHotlLFYkvCPPx03Ni6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,228,1763391600"; 
   d="scan'208";a="106636006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 02:38:19 +0900
Received: from labpc.. (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id E34B3183E387;
	Fri, 16 Jan 2026 02:38:18 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
Date: Fri, 16 Jan 2026 02:37:15 +0900
Message-ID: <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
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
 kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..2b275eaa3cac 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
-static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
+static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
 	char c1, c2;
 	int i;
@@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 		return -ERANGE;
 	}
 
+	if (len == 0)
+		return 0;
+
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
 		__get_kernel_nofault(&c1, s1, char, err_out);
@@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 			return c1 < c2 ? -1 : 1;
 		if (c1 == '\0')
 			return 0;
+		if (len < XATTR_SIZE_MAX && i == len - 1)
+			return 0;
 		s1++;
 		s2++;
 	}
@@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
  */
 __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
 }
 
 /**
@@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
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
@@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
+BTF_ID_FLAGS(func, bpf_strncasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.43.0


