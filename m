Return-Path: <bpf+bounces-66704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0178B38A78
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE3C1C21103
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AA2F067F;
	Wed, 27 Aug 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wvn678MI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03082EAB6D
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324192; cv=none; b=apJPAzevdTtk8F1YV/NgqM8ph78zPZ+1Q73UUn8cDvC+oNcrQ/FyjxM2O0P0vrHRLnW+uqdnLeQKTHO/KNG5ij2PkMmArvIQzAiMdGJdFfMcmfLJth26t+GOGPbGQkTlV4+0M6UZJxaiTS/uGCEq2tOmVp+uJxnDGngoGlnHCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324192; c=relaxed/simple;
	bh=WPEL4OP8XcHUQlE93clnENMckc+EBh2C38q8QJe3aNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ+AUuYc3Iajg6xmkVRgq8YleaMr3E8sIPXAQWyR5pq/EM8zjCabF++7QBXoo45GPl7RdtqF6+cSYygQFY1R/0hff5ANEfv7IQJBFpfApOj6euut2N2AcBv+6KpZ8Z1orXXi0t5ziCceBs1TersZyYOKtaUzPFgQCQjzAb4oAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wvn678MI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RFU2JU003730;
	Wed, 27 Aug 2025 19:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QvgB0OgM7vCLCVai/
	K4zfZIpTlhN8KslnF4gc9SMr10=; b=Wvn678MIGpR9TeO3/m/r3UXryIhPzP2R7
	id4B2Ddtcbh7U8UqtHfZbZ766h3PW2xV1uRTGDeZtZZ+kBjiMWBP5CRBR/X/Ohmm
	8VqJKfTw9N8vZPIaKMboFrM9O7tD4aPMrea9nUF9SVc+kKG4ovNlr97VwDZU5NJc
	tXBiCnHaP1M8shecX31KQ5suTBTS5GB6Nygpt23/KFSksmKvZIdcp8U32IKYJo+2
	7zLa5GzmQ9UhLP1AsMBVdhcpRMUq/8RGnjb/zjXqEfsAW89oCGdmnxW86zko5geL
	fCXrIGdIXoBpe8zqgqyR9nsj34mUJYr7XZPUt8C8e/zwEV+SBqUkA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q55863pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJ0Nvx007554;
	Wed, 27 Aug 2025 19:49:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuhsgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RJnV3U42992122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:49:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F4E20043;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460A020040;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Annotate bpf_obj_new_impl() with __must_check
Date: Wed, 27 Aug 2025 21:46:45 +0200
Message-ID: <20250827194929.416969-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827194929.416969-1-iii@linux.ibm.com>
References: <20250827194929.416969-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _uIcEN2wmKGqfGOaGY-HT80OqlLZt9Xu
X-Proofpoint-ORIG-GUID: _uIcEN2wmKGqfGOaGY-HT80OqlLZt9Xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX5+TOvKCKCKYd
 sINMlM3NeMCitQdirX96zQUPlmzgXLWwJBf+X8epi6RvOIuuDHMZQq5h/hzwdx+n8bA7/Yp9oEi
 TsCAVpQdL6/6EL2bC406l3Y9kdOH2h4/QxIQA5PDt2/lzbPV4h7tb6zD8GN1sd/Gjh6Uv0HPHGI
 fuJYyZtAVN75mZ9r2A27ps8TUQ+rGe56AnJwSWz2Sg5qY3tPmv+g14jNFra3LmRZleKeP775Ww8
 Hk5okHAEsxGBXQiv1JEI4cuO5mpqVYMTb4ZxipqboK7h+zgIvdtjsbpfRj5NLqwB9AKfgIANyda
 IRkpMHV97+J3PIH3uYRXK/j8bxHQfTOklHNrwnZ/zim7s3q93c9RYAxpsMpqUls22s8KWRKE+0l
 R9PI7/6q
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af6150 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=y4fOKvO5TH5DvNK41ToA:9 a=dKuBx9SDB9gA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

The verifier requires that pointers returned by bpf_obj_new_impl() are
either dropped or stored in a map. Therefore programs that do not use
its return values will fail to load. Make the compiler point out these
issues. Adjust selftests that check that the verifier does indeed spot
these bugs.

Note that now there two different bpf_obj_new_impl() declarations: one
with __must_check from bpf_experimental.h, and one without from
vmlinux.h. According to the GCC doc [1] this is fine and has the
desired effect:

    Compatible attribute specifications on distinct declarations of the
    same function are merged.

[1] https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html

Link: https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++-
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index da7e230f2781..a8f206f4fdb9 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -8,6 +8,10 @@
 
 #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
 
+#ifndef __must_check
+#define __must_check __attribute__((__warn_unused_result__))
+#endif
+
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
@@ -20,7 +24,7 @@
  *	A pointer to an object of the type corresponding to the passed in
  *	'local_type_id', or NULL on failure.
  */
-extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+extern __must_check void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
 
 /* Convenience macro to wrap over bpf_obj_new_impl */
 #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 6438982b928b..1e30d103e1c7 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -212,22 +212,33 @@ int map_compat_raw_tp_w(void *ctx)
 SEC("?tc")
 int obj_type_id_oor(void *ctx)
 {
-	bpf_obj_new_impl(~0UL, NULL);
+	void *f;
+
+	f = bpf_obj_new_impl(~0UL, NULL);
+	(void)f;
+
 	return 0;
 }
 
 SEC("?tc")
 int obj_new_no_composite(void *ctx)
 {
-	bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
+	void *f;
+
+	f = bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
+	(void)f;
+
 	return 0;
 }
 
 SEC("?tc")
 int obj_new_no_struct(void *ctx)
 {
+	void *f;
+
+	f = bpf_obj_new(union { int data; unsigned udata; });
+	(void)f;
 
-	bpf_obj_new(union { int data; unsigned udata; });
 	return 0;
 }
 
@@ -252,7 +263,11 @@ int new_null_ret(void *ctx)
 SEC("?tc")
 int obj_new_acq(void *ctx)
 {
-	bpf_obj_new(struct foo);
+	void *f;
+
+	f = bpf_obj_new(struct foo);
+	(void)f;
+
 	return 0;
 }
 
-- 
2.50.1


