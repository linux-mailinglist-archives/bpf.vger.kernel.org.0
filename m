Return-Path: <bpf+bounces-71997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0602C04BEA
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B69A50247F
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348612E6CA8;
	Fri, 24 Oct 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mogzTyP/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE72E4247;
	Fri, 24 Oct 2025 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291247; cv=none; b=rIS33yi/qO0LLOVxColXK9wuFAO03j3KZJuCFnNVt1dlhT3Xr3L0k+e0S29ojllZSRP5eZ6qHpz3ZuJ4aZVEWnByYOt30YEtS+4cGQfcF7PdEUWpMUPaQUNichCkv4J4KkLrID3XHMjCgTPtitQHsh9tg0RpIjWPhrFlbbpTEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291247; c=relaxed/simple;
	bh=DS1DeLxuCwz4/1DhiQwvyK0UEVKnhVA9suPP+PvoJwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJeWBWPIg7M0M07myWKk1wmUaVDGIU/PndWL0mtoph2E9A5dogSHLkkjG536nf+lpSIQNl+gxr8kxs9clsqWxsXOqAyVqGrVjyoW3/+FWN2JRy6F0ST2w3YPblzmwXi/rmi3/dyc3WYgmJQmPJCpYr6IwRqD/0xY3aH2NKqCURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mogzTyP/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NOXV019049;
	Fri, 24 Oct 2025 07:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ggM1U
	s1LlfT3GxpER/eiDLgmWXZARQWSSVG9m3jl4gI=; b=mogzTyP/PSrGwjUkjxeiF
	G5DvsWImqcpjuuNWHOZjXFbiVGsNGgVpTBVPRQVv/4IurNluiha7l4IgJOdhCEhQ
	jNNAB5sOIHZyYTQ0uam2myQIYBYADWCFffP63yl/LdQkqy+1CSx6i5Zp4ihJvlIm
	PG8ioD3hcsS2mh0hhuDzPii+HnR1AB6Y8exIsfGPwuiSuLcZOjT0HxuctWKiAdUo
	M9DrIoqdnRLaOg5NbjnZqHgzs6YuCJN3zYWqe5ddq5QmPLRU41OH0jMvX03ixvH7
	K5YNnQliSBgYytBQPIcV9PDMKWxSkro7FoNVmtywGYh7kSpL5VygoSLh2/V7f8A8
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw3bq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7Evrd022182;
	Fri, 24 Oct 2025 07:33:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwj019356;
	Fri, 24 Oct 2025 07:33:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-4;
	Fri, 24 Oct 2025 07:33:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 3/5] dwarf_loader: Collect inline expansion location information
Date: Fri, 24 Oct 2025 08:33:26 +0100
Message-ID: <20251024073328.370457-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251024073328.370457-1-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6Gb77CiKaBt+
 9rCIA1+mOKS+MsZSfKHqZF8VHOgwnzZmNF4TnwTaXlaLDbTnhrYAuo/PC8wrawYtXTwxpP47pY8
 PITv8u+QeqW61icda4522p/XiGV7AVfSoe+j59cVWW5QITadfoyvkj9ZoZUGomk52TXAOGaU+gZ
 avDE4kewk6yT9a/5cXhqLFGK1UYyrQgyLAGnZUF4rR4NKM82x3OruMAU9FjZRkt1pVm7pALTUSM
 2XtKs6LTYfiZzdak7nETC03dtoSCAum3FUuAa7mh3HzFw/TLdtN/YoCH5hJn9f19HyCt0alm1w/
 EfZ8bdF6DJvoNtTFQpSYXn51WvAe1B1LjDS9uxq7/5oDE4D1yp6AZgEWjRdGwoFxy8OY17a+74B
 zpBnwNpgVwEG6wDp0I5ku7S1DqktpNU6i95Oj5g8WyC254TDEFg=
X-Proofpoint-ORIG-GUID: 1ELAYiZMwjgz3xpCdwabM_1pIahle6k5
X-Proofpoint-GUID: 1ELAYiZMwjgz3xpCdwabM_1pIahle6k5
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fb2bd9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yJwZ7lJ45cyLskzZi_IA:9 cc=ntf
 awl=host:13624

Collect location information for parameters, inline expansions and ensure it
does not rely on aspects of the CU that go away when it is freed.

(This is a slightly differerent approach from Thierry's but it was helped
greatly by his series; would happily add a Co-developed by here or
whatever suits)

Signed-off-by: Alan Maguire <alan.maguire>
---
 dwarf_loader.c | 277 +++++++++++++++++++++++++++++++++++++++----------
 dwarves.h      |  48 ++++++++-
 2 files changed, 266 insertions(+), 59 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4656575..a7ae497 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1185,29 +1185,54 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
 	return ret;
 }
 
-/* For DW_AT_location 'attr':
- * - if first location is DW_OP_regXX with expected number, return the register;
- *   otherwise save the register for later return
- * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is in the
- *   list, return the register; otherwise save register for later return
- * - otherwise if no register was found for locations, return -1.
+/* Retrieve location information for parameter; focus on simple locations
+ * like constants and register values.  Support multiple registers as
+ * it is possible for a value (struct) to be passed via multiple registers.
+ * Handle edge cases like multiple instances of same location value, but
+ * avoid cases with large (>1 size) expressions to keep things simple.
+ * This covers the vast majority of cases.  The only unhandled atom is
+ * DW_OP_GNU_parameter_ref; future work could add that and improve
+ * location handling.  In practice the below supports the majority
+ * of parameter locations.
  */
-static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
+static int parameter__locs(Dwarf_Die *die, Dwarf_Attribute *attr, struct parameter *parm)
 {
-	Dwarf_Addr base, start, end;
-	Dwarf_Op *expr, *entry_ops;
-	Dwarf_Attribute entry_attr;
-	size_t exprlen, entry_len;
+	Dwarf_Addr base, start, end, first = -1;
+	Dwarf_Attribute next_attr;
 	ptrdiff_t offset = 0;
-	int loc_num = -1;
+	Dwarf_Op *expr;
+	size_t exprlen;
 	int ret = -1;
 
+	/* parameter__locs() can be called recursively, but at toplevel
+	 * die is non-NULL signalling we need to look up loc/const attrs.
+	 */
+	if (die) {
+		if (dwarf_attr(die, DW_AT_const_value, attr) != NULL) {
+			parm->has_loc = 1;
+			parm->optimized = 1;
+			parm->locs[0].is_const = 1;
+			parm->nlocs = 1;
+			parm->locs[0].size = 8;
+			parm->locs[0].value = attr_numeric(die, DW_AT_const_value);
+			return 0;
+		}
+		if (dwarf_attr(die, DW_AT_location, attr) == NULL)
+			return 0;
+	}
+
 	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
 	 * when libdw is not compiled with experimental --enable-thread-safety
 	 */
 	pthread_mutex_lock(&libdw__lock);
 	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
-		loc_num++;
+		/* We only want location info referring to start of function;
+		 * assumes we get location info in address order; empirically
+		 * this is the case.  Only exception is DW_OP_*entry_value
+		 * location info which always refers to the value on entry.
+		 */
+		if (first == -1)
+			first = start;
 
 		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
 		 * DW_OP_stack_value instructs interpreter to pop current value from
@@ -1216,33 +1241,154 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
 			exprlen--;
 
-		if (exprlen != 1)
-			continue;
+		if (exprlen > 1) {
+			/* ignore complex exprs not at start of function,
+			 * but bail if we hit a complex loc expr at the start.
+			 */
+			if (start != first)
+				continue;
+			ret = -1;
+			goto out;
+		}
 
 		switch (expr->atom) {
-		/* match DW_OP_regXX at first location */
+		case DW_OP_deref:
+			if (parm->nlocs > 0)
+				parm->locs[parm->nlocs - 1].is_deref = 1;
+			else
+				ret = -1;
+			break;
 		case DW_OP_reg0 ... DW_OP_reg31:
-			if (loc_num != 0)
+			if (start != first || parm->nlocs > 1)
+				break;
+			/* avoid duplicate location value */
+			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
+					       (expr->atom - DW_OP_reg0))
+				break;
+			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_reg0;
+			parm->locs[parm->nlocs].is_deref = 0;
+			parm->locs[parm->nlocs].size = 8;
+			parm->locs[parm->nlocs++].offset = 0;
+			ret = 0;
+			break;
+		case DW_OP_fbreg:
+		case DW_OP_breg0 ... DW_OP_breg31:
+			if (start != first || parm->nlocs > 1)
 				break;
-			ret = expr->atom;
-			if (ret == expected_reg)
-				goto out;
+			/* avoid duplicate location value */
+			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
+					       (expr->atom - DW_OP_breg0)) {
+				if (parm->locs[parm->nlocs - 1].offset != expr->offset)
+					ret = -1;
+				break;
+			}
+			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_breg0;
+			parm->locs[parm->nlocs].is_deref = 1;
+			parm->locs[parm->nlocs].size = 8;
+			parm->locs[parm->nlocs++].offset = expr->offset;
+			ret = 0;
+			break;
+		case DW_OP_lit0 ... DW_OP_lit31:
+			if (start != first)
+				break;
+
+			if (parm->nlocs > 0 && (expr->atom - DW_OP_lit0) ==
+					       parm->locs[parm->nlocs - 1].value)
+				break;
+			parm->locs[parm->nlocs].is_const = 1;
+			parm->locs[parm->nlocs].size = 1;
+			parm->locs[parm->nlocs++].value = expr->atom - DW_OP_lit0;
+			ret = 0;
+			break;
+		case DW_OP_const1u ... DW_OP_consts:
+			if (start != first)
+				break;
+			if (parm->nlocs > 0 && (parm->locs[parm->nlocs - 1].is_const &&
+			    expr->number == parm->locs[parm->nlocs - 1].value))
+				break;
+			parm->locs[parm->nlocs].is_const = 1;
+			parm->locs[parm->nlocs].value = expr->number;
+			switch (expr->atom) {
+			case DW_OP_const1u:
+				parm->locs[parm->nlocs].size = 1;
+				break;
+			case DW_OP_const1s:
+				parm->locs[parm->nlocs].size = -1;
+				break;
+			case DW_OP_const2u:
+				parm->locs[parm->nlocs].size = 2;
+				break;
+			case DW_OP_const2s:
+				parm->locs[parm->nlocs].size = -2;
+				break;
+			case DW_OP_const4u:
+				parm->locs[parm->nlocs].size = 4;
+				break;
+			case DW_OP_const4s:
+				parm->locs[parm->nlocs].size = -4;
+				break;
+			case DW_OP_const8u:
+			case DW_OP_constu:
+				parm->locs[parm->nlocs].size = 8;
+				break;
+			case DW_OP_const8s:
+			case DW_OP_consts:
+				parm->locs[parm->nlocs].size = -8;
+				break;
+			}
+			parm->nlocs++;
+			ret = 0;
+			break;
+		case DW_OP_addr:
+			if (start != first || parm->nlocs > 0)
+				break;
+			parm->locs[parm->nlocs].is_const = 1;
+			parm->locs[parm->nlocs].is_addr = 1;
+			parm->locs[parm->nlocs].size = 8;
+			parm->locs[parm->nlocs++].value = expr->number;
+			ret = 0;
 			break;
-		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
-			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
-			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
-			    entry_len == 1) {
-				ret = entry_ops->atom;
-				if (ret == expected_reg)
-					goto out;
+			/* Match DW_OP_entry_value(DW_OP_regXX) at any offset
+			 * in function since it always describes value on entry.
+			 */
+			if (dwarf_getlocation_attr(attr, expr, &next_attr) == 0) {
+				pthread_mutex_unlock(&libdw__lock);
+				return parameter__locs(NULL, &next_attr, parm);
 			}
+			ret = -1;
+			break;
+		case DW_OP_implicit_pointer:
+			if (start != first)
+				break;
+			if (dwarf_getlocation_implicit_pointer(attr, expr, &next_attr) == 0) {
+				pthread_mutex_unlock(&libdw__lock);
+				return parameter__locs(NULL, &next_attr, parm);
+			}
+			ret = -1;
+			break;
+		case DW_OP_implicit_value:
+			if (start != first)
+				break;
+			if (dwarf_getlocation_attr(attr, expr, &next_attr) == 0) {
+				pthread_mutex_unlock(&libdw__lock);
+				return parameter__locs(NULL, &next_attr, parm);
+			}
+			ret = -1;
+			break;
+		default:
+			/* unhandled op */
+			ret = -1;
 			break;
 		}
+		if (ret == -1)
+			break;
 	}
 out:
 	pthread_mutex_unlock(&libdw__lock);
+	if (ret == 0)
+		parm->has_loc = 1;
 	return ret;
 }
 
@@ -1250,10 +1396,11 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
+	int ret;
 
 	if (parm != NULL) {
-		bool has_const_value;
 		Dwarf_Attribute attr;
+		int expected_reg;
 
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
@@ -1293,28 +1440,31 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		 * between these parameter representations.  See
 		 * ftype__recode_dwarf_types() below for how this is handled.
 		 */
-		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
-		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
-
-		if (parm->has_loc) {
-			struct location location;
-			attr_location(die, &location.expr, &location.exprlen);
-
-			int expected_reg = cu->register_params[param_idx];
-			int actual_reg = parameter__reg(&attr, expected_reg);
-
-			if (actual_reg < 0)
-				parm->optimized = 1;
-			else if (expected_reg >= 0 && expected_reg != actual_reg)
-				/* mark parameters that use an unexpected
-				 * register to hold a parameter; these will
-				 * be problematic for users of BTF as they
-				 * violate expectations about register
-				 * contents.
-				 */
-				parm->unexpected_reg = 1;
-		} else if (has_const_value) {
+		expected_reg = cu->register_params[param_idx];
+		if (expected_reg >= DW_OP_reg0)
+			expected_reg -= DW_OP_reg0;
+
+		ret = parameter__locs(die, &attr, parm);
+
+		if (!parm->has_loc)
+			return parm;
+
+		if (ret < 0) {
+			/* undecipherable location */
 			parm->optimized = 1;
+			return parm;
+		}
+		if (parm->locs[0].is_const) {
+			parm->optimized = 1;
+		} else if (expected_reg >= 0 &&
+			   expected_reg != parm->locs[0].reg) {
+			/* mark parameters that use an unexpected
+			 * register to hold a parameter; these will
+			 * be problematic for users of BTF as they
+			 * violate expectations about register
+			 * contents.
+			 */
+			parm->unexpected_reg = 1;
 		}
 	}
 
@@ -1377,10 +1527,14 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
 
 		Dwarf_Attribute attr_orig;
+		exp->name = 0;
 		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
 			Dwarf_Die die_orig;
-			if (dwarf_formref_die(&attr_orig, &die_orig)) {
-				exp->name = attr_string(&die_orig, DW_AT_name, conf);
+
+			if (dwarf_formref_die(&attr_orig, &die_orig) &&
+			    dwarf_tag(&die_orig) == DW_TAG_subprogram) {
+				if (dwarf_hasattr(&die_orig, DW_AT_name))
+					exp->name = attr_string(&die_orig, DW_AT_name, conf);
 			}
 		}
 
@@ -2686,12 +2840,12 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 	 * in fact an abtract origin, i.e. must be looked up in the tags_table,
 	 * not in the types_table.
 	 */
-	struct dwarf_tag *ftype = NULL;
+	struct dwarf_tag *function = NULL;
 	if (dtag->type != 0)
-		ftype = dwarf_cu__find_tag_by_ref(dcu, dtag, type);
+		function = dwarf_cu__find_tag_by_ref(dcu, dtag, type);
 	else
-		ftype = dwarf_cu__find_tag_by_ref(dcu, dtag, abstract_origin);
-	if (ftype == NULL) {
+		function = dwarf_cu__find_tag_by_ref(dcu, dtag, abstract_origin);
+	if (function == NULL) {
 		if (dtag->type != 0)
 			tag__print_type_not_found(tag);
 		else
@@ -2699,13 +2853,14 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 		return;
 	}
 
-	ftype__recode_dwarf_types(dtag__tag(ftype), cu);
+	ftype__recode_dwarf_types(dtag__tag(function), cu);
 
 	struct tag *pos;
 	struct inline_expansion *exp = tag__inline_expansion(tag);
 	list_for_each_entry(pos, &exp->parms, node)
 		parameter__recode_dwarf_type(tag__parameter(pos), cu);
-	exp->ip.tag.type = ftype->small_id;
+	exp->ip.tag.type = function->small_id;
+	exp->function = tag__function(dtag__tag(function));
 }
 
 static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
@@ -2983,6 +3138,14 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		struct function *fn = tag__function(tag);
 		bool has_unexpected_reg = false, has_struct_param = false;
 
+		/* Inlined function representations likely have parameters
+		 * in wrong locations; ensure they do not contribute to
+		 * classification of unexpected regs for a function that
+		 * is partially inlined.
+		 */
+		if (fn->inlined)
+			continue;
+
 		/* mark function as optimized if parameter is, or
 		 * if parameter does not have a location; at this
 		 * point location presence has been marked in
diff --git a/dwarves.h b/dwarves.h
index 284bc02..d6efdd0 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -481,6 +481,19 @@ bool languages__cu_filtered(struct languages *languages, struct cu *cu, bool ver
 			continue;			\
 		else
 
+/**
+ * cu__for_each_inline_expansion - iterate thru all inline expansions
+ * @cu: struct cu instance to iterate
+ * @pos: struct tag iterator
+ * @id: uint32_t tag id
+ */
+#define cu__for_each_inline_expansion(cu, id, pos)	\
+	for (id = 0; id < cu->tags_table.nr_entries; ++id) \
+		if (!tag__is_inline_expansion(cu->tags_table.entries[id]) || \
+		    !(pos = tag__inline_expansion(cu->tags_table.entries[id])))\
+			continue;			\
+		else
+
 int cu__add_tag(struct cu *cu, struct tag *tag, uint32_t *id);
 int cu__add_tag_with_id(struct cu *cu, struct tag *tag, uint32_t id);
 int cu__table_add_tag(struct cu *cu, struct tag *tag, uint32_t *id);
@@ -615,6 +628,11 @@ static inline bool tag__is_restrict(const struct tag *tag)
 	return tag->tag == DW_TAG_restrict_type;
 }
 
+static inline bool tag__is_inline_expansion(const struct tag *tag)
+{
+	return tag->tag == DW_TAG_inlined_subroutine;
+}
+
 static inline int tag__is_modifier(const struct tag *tag)
 {
 	return tag__is_const(tag) ||
@@ -821,13 +839,22 @@ struct ip_tag {
 
 struct inline_expansion {
 	struct ip_tag	 ip;
-	const char	 *name;
+	const char	*name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;
 	uint16_t   nr_parms;
+	struct function	*function;
 };
 
+/**
+ * inline_expansion__for_each_parameter - iterate thru all the parameters
+ * @ie: struct inline_expansion instance to iterate
+ * @pos: struct parameter iterator
+ */
+#define inline_expansion__for_each_parameter(ie, pos) \
+	list_for_each_entry(pos, &(ie)->parms, tag.node)
+
 static inline struct inline_expansion *
 				tag__inline_expansion(const struct tag *tag)
 {
@@ -944,13 +971,30 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
 			 struct function *function, uint16_t indent,
 			 const struct conf_fprintf *conf, FILE *fp);
 
+
+struct parameter_loc {
+	uint8_t is_const:1;
+	uint8_t is_deref:1;
+	uint8_t is_addr:1;
+	int8_t size;
+	union {
+		struct {
+			uint16_t reg;
+			uint16_t flags;
+			uint32_t offset;
+		};
+		uint64_t value;
+	};
+};
+
 struct parameter {
 	struct tag tag;
 	const char *name;
-	struct location location;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
+	struct parameter_loc locs[2];	/* multiple locs may be used */
+	uint8_t nlocs;
 };
 
 static inline struct parameter *tag__parameter(const struct tag *tag)
-- 
2.39.3


