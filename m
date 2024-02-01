Return-Path: <bpf+bounces-20968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086F845E3B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCCE281C18
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27115F32C;
	Thu,  1 Feb 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KRjpJNRi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736715F311
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807606; cv=none; b=qxmZeVl9I6X5odX6+6wBpN0ug/4tHS2GFcG9Xz6hiAJ+W5J4TyafCL82AmsAqb0B0639nzGh+50bjmgiK2AQFkIPB8Q1N3DULO30smwOka0GxJuym6I6263uzRZ5tFJvBDDrC4zc7RjGumlBN3z4CSc84gsqgcHyIQ+ZzRf3Aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807606; c=relaxed/simple;
	bh=fHh2pZax1kI9nGEai2MN2jUr7i0UemQL+ODwH+DOFIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utq1+5wp6NkzHCkXId8G2e1qFB/uDf7Io6QE0w2JZ0xdpCEwK2Lzv0jXNwLH4o60VjF95myF38WsHnZujfTGhrbq5D0PqYx0YDG6Jp92vTxUgpLBFQnv1TTL00S+YxrE4BinlTjOs7wRiOHdpjbMjipzKKPZlGv//nI24NPfZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KRjpJNRi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411HCH1p023912;
	Thu, 1 Feb 2024 17:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TR6rwWW4bgJ6BxaJKJpn8+PrfZPasyAoRjWwv0KgNYs=;
 b=KRjpJNRigq3Yz0IC+wgsCnqxnuD1EQaG66UocQorD/KOOohfiWzzGAgqU8vfy3kqU7i6
 9/MWXnkl5wsAN1LL7Ex/h63j2nfhdJu1RgvgTpwWGsSFkpSQVYzCdbiycJIyRr4+x+rq
 oyfYhRaXtVMVtl1u2DQy2rdiHxgNe0unaKqgO6y4tO4n5P3yTcErAy0FBjNlmgoLV1no
 /v6RhCXBk6iYzydv94yitxxzUhLMLnSqXcLgw3yVtCt3Ow8Qcy1Rc44JpH1rg5clh9v3
 4yXF26iMD78oOhyUIkxyZ4te9k5NmwJvCX36odhKEf/VBFYz3FmckEorhQ9MyTZ6C+sc Mw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0fg580c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:13:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411GjRXJ007184;
	Thu, 1 Feb 2024 17:13:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2nbhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:13:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411HCwqK12190420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 17:12:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 721FC20063;
	Thu,  1 Feb 2024 17:12:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81172005A;
	Thu,  1 Feb 2024 17:12:54 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.104.224])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 17:12:54 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/2] powerpc/bpf: enable kfunc call
Date: Thu,  1 Feb 2024 22:42:49 +0530
Message-ID: <20240201171249.253097-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201171249.253097-1-hbathini@linux.ibm.com>
References: <20240201171249.253097-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W1t1FWbyaNQ-an_inQ4XzimoO5TrGvmQ
X-Proofpoint-ORIG-GUID: W1t1FWbyaNQ-an_inQ4XzimoO5TrGvmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010134

With module addresses supported, override bpf_jit_supports_kfunc_call()
to enable kfunc support. Module address offsets can be more than 32-bit
long, so override bpf_jit_supports_far_kfunc_call() to enable 64-bit
pointers.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* No changes since v1.


 arch/powerpc/net/bpf_jit_comp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7b4103b4c929..f896a4213696 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -359,3 +359,13 @@ void bpf_jit_free(struct bpf_prog *fp)
 
 	bpf_prog_unlock_free(fp);
 }
+
+bool bpf_jit_supports_kfunc_call(void)
+{
+	return true;
+}
+
+bool bpf_jit_supports_far_kfunc_call(void)
+{
+	return true;
+}
-- 
2.43.0


