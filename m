Return-Path: <bpf+bounces-57754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3814AAFB3B
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F3A3B1B95
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A722B8B0;
	Thu,  8 May 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SEwOnIwg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EC2288F7;
	Thu,  8 May 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710593; cv=none; b=nFEBuIcItDnGymYh8sNlQ/vf6cCEZ8xU2SJEQYicMBKDG/gKBGB+3KrnaqeMpOjzqvk6TerDnwr2golDV7sT7+EYbUPakyMt0XkstEb6W51qe/hImQqBd7n5IfPNuv6gKxJVfdvvhlfHVxHqSU88woESEMgEe5O4Kr9k6pnY+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710593; c=relaxed/simple;
	bh=XerUMkJOgwNL9oSEjwDzsF1Qx5aA4a9exB3qmIpqamY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3GmG8WcAvl2yK1fdtk/qxFlLX5DmisqzBfxrQUg8HnnCn9nC0a+e8HdRHJ/pCtSwIXbscoZHKis+OcmPafXcEObbWDOkCvhrd38Ke/KAWDq0cNHo9U0x/jcqaMJoUPgRc+xgy1CTqLwrW6UJPojxhCkFRuwC6atKCDhBnadw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SEwOnIwg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D28Ph029623;
	Thu, 8 May 2025 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2oe7U
	Yad14K2MObyVGUS+0rn9Z2t5ZQt7eNrPFuMuX4=; b=SEwOnIwgoGssJrko7+OgG
	spb5v55LJVs3DwrLacXRwtIbMaxNiK4Zh4CDcmvDU51phaWox6QTtkQNZ8Eg70NF
	CJCQz2QtCBRTgBe1hxJrkLKJR4+cLqTw7oAXRBbU5hIW2JbwQiggs80uNq5KtuJJ
	B5K2HJpd4dwtirxBNmd3zID3GaHVSgbuMxutEwvRq7oSNt3iN8vJr9C47ZrQinOQ
	4gjDCcbQiq4dJcYg3J5Kkm0UZ5FHevAeTDSzBjmxj76EllH9ZwTGCSdjDT4rDrNY
	/k1tMf/ZGf7eL5qkWJ+AuPHG3Pt2vOpH7CvImibVx9DycGAKrq+7ISlEntem6HQW
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gw4x01n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548CNPun036083;
	Thu, 8 May 2025 13:22:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kcedpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:22:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548DMgb9024112;
	Thu, 8 May 2025 13:22:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-250.vpn.oracle.com [10.154.49.250])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kcedkj-2;
	Thu, 08 May 2025 13:22:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com
Cc: eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/3] libbpf: update BPF_PROG2() to handle empty structs
Date: Thu,  8 May 2025 14:22:35 +0100
Message-ID: <20250508132237.1817317-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508132237.1817317-1-alan.maguire@oracle.com>
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=855
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExMiBTYWx0ZWRfX+TGdeeXxuZ42 /+6C+bGmVsUiMx3Ui+WocULHyV0QH35D61vKc3ud0B7F9/j7F5ox+VCc6Ab/Wr2sNOwg0M7kpey 88WA6CyE5F91TFht0y0onn4zZoxNWnc8c5GatengPLMSE6Ft4k1N48nRL4wb4HYXrpmDk6gbOup
 nMzvcr3U5Darm+OSL6oqgDtdF0CtbEf/NY16lvkvAvokUOqWp2skhnKPV9Nab5dPcD+f6ozrcLz sHltMw/qQFUBBxnzGwZMEqsduVrnbJ0r+bKjfWfMe/FZWM9PMTtKwQyOKg97RHB1U9RY80BVW9A 9ybbb4DKTlWw1KUgkLSh8xQiCvaicCRYt1bTbVLBJJ0Douk/QPEeQ3jPvILtwDUUoXaZ0Tp2gf4
 eN+Umw5GnMQ3Ydq9F/Sx0jewrJg7R8QmbMiI234g2i8vZL6SGVINF8LmrmQ3Ydkw67kfRQ5m
X-Proofpoint-GUID: FZGsnApxs5a0qlx7cK824sCoDnbsBgNG
X-Proofpoint-ORIG-GUID: FZGsnApxs5a0qlx7cK824sCoDnbsBgNG
X-Authority-Analysis: v=2.4 cv=Aqru3P9P c=1 sm=1 tr=0 ts=681cb027 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=P2jNTN0YeSzzXNtSfPcA:9

In the kernel we occasionally find empty structs as parameters to
functions, usually because some arch-specific field(s) are not present.
Ensure that when such structs are used as parameters to functions we
handle the fact that no registers are used in their representation.

Deliberately not using a Fixes: tag here because for this to be useful
we need a more recent pahole with [1].

[1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/bpf_tracing.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a8f6cd4841b0..7629650251dc 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -694,12 +694,13 @@ ____##name(unsigned long long *ctx, ##args)
 #endif
 
 #define ___bpf_treg_cnt(t) \
+	__builtin_choose_expr(sizeof(t) == 0, 0,	\
 	__builtin_choose_expr(sizeof(t) == 1, 1,	\
 	__builtin_choose_expr(sizeof(t) == 2, 1,	\
 	__builtin_choose_expr(sizeof(t) == 4, 1,	\
 	__builtin_choose_expr(sizeof(t) == 8, 1,	\
 	__builtin_choose_expr(sizeof(t) == 16, 2,	\
-			      (void)0)))))
+			      (void)0))))))
 
 #define ___bpf_reg_cnt0()		(0)
 #define ___bpf_reg_cnt1(t, x)		(___bpf_reg_cnt0() + ___bpf_treg_cnt(t))
@@ -717,12 +718,13 @@ ____##name(unsigned long long *ctx, ##args)
 #define ___bpf_reg_cnt(args...)	 ___bpf_apply(___bpf_reg_cnt, ___bpf_narg2(args))(args)
 
 #define ___bpf_union_arg(t, x, n) \
+	__builtin_choose_expr(sizeof(t) == 0, ({ t ___t; ___t; }), \
 	__builtin_choose_expr(sizeof(t) == 1, ({ union { __u8 z[1]; t x; } ___t = { .z = {ctx[n]}}; ___t.x; }), \
 	__builtin_choose_expr(sizeof(t) == 2, ({ union { __u16 z[1]; t x; } ___t = { .z = {ctx[n]} }; ___t.x; }), \
 	__builtin_choose_expr(sizeof(t) == 4, ({ union { __u32 z[1]; t x; } ___t = { .z = {ctx[n]} }; ___t.x; }), \
 	__builtin_choose_expr(sizeof(t) == 8, ({ union { __u64 z[1]; t x; } ___t = {.z = {ctx[n]} }; ___t.x; }), \
 	__builtin_choose_expr(sizeof(t) == 16, ({ union { __u64 z[2]; t x; } ___t = {.z = {ctx[n], ctx[n + 1]} }; ___t.x; }), \
-			      (void)0)))))
+			      (void)0))))))
 
 #define ___bpf_ctx_arg0(n, args...)
 #define ___bpf_ctx_arg1(n, t, x)		, ___bpf_union_arg(t, x, n - ___bpf_reg_cnt1(t, x))
-- 
2.39.3


