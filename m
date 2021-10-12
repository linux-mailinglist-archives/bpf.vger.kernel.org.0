Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477E9429B86
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJLCel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:34:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47246 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230362AbhJLCek (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:34:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C2Bn2F003854;
        Mon, 11 Oct 2021 22:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nsY0Xq+rxFEiF00RuE84NF6M/ZTAF7lGUFj030HOzXM=;
 b=l/5r2EeW4TsfFDA6RJ8CYFBXI6iD2iA4u8wKaUo6DMysoWnsZGLStroCTQ2yX6I41Ymv
 aVlb+l1wvqPXe5r1f3y8XDr0xKCCAB9NR/J4XP2YS8bXJj7n1RlsWiVFE1cQ/J/CcpXU
 x3GSxdW+VzbaMjpa3Qjx/z30IbAWANQiUQ81R/H+2rZZw5jsswHglIAUiEYCnSgKkysa
 PxgHFx1vDu0b0LhaL6MyHtvYIJyZyDUJXyyDBII2Rqafi5J5XWmJkqoGb6ytacVjR0Ib
 rhccvBxBmxRbJfAlsNKXd8dt/pDxTahJTMA+MqMqSL0JBvsMnuQLWxCcyQdmcz/JlEX2 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn1c188ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:27 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C2Uda2011783;
        Mon, 11 Oct 2021 22:32:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn1c188e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BPKZ030567;
        Tue, 12 Oct 2021 02:32:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9ue4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:32:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2WMUu48234920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:32:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4193F11C069;
        Tue, 12 Oct 2021 02:32:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE9411C050;
        Tue, 12 Oct 2021 02:32:21 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 02:32:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] libbpf: Fix dumping __int128
Date:   Tue, 12 Oct 2021 04:32:18 +0200
Message-Id: <20211012023218.399568-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012023218.399568-1-iii@linux.ibm.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gN-ibB6v_x4r22lxkTJBaZ4yTR3vA8pf
X-Proofpoint-GUID: vY_DfBdUcBFXgdeCaCShrl1K8Vk8g868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On s390 __int128 can be 8-byte aligned, therefore in libbpf will
occasionally consider variables of this type non-aligned and try to
dump them as a bitfield, which is supported for at most 64-bit
integers.

Fix by using the same trick as btf_dump_float_data(): copy non-aligned
values to the local buffer.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ab45771d0cb4..d8264c1762e8 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1672,9 +1672,10 @@ static int btf_dump_int_data(struct btf_dump *d,
 {
 	__u8 encoding = btf_int_encoding(t);
 	bool sign = encoding & BTF_INT_SIGNED;
+	char buf[16] __aligned(16);
 	int sz = t->size;
 
-	if (sz == 0) {
+	if (sz == 0 || sz > sizeof(buf)) {
 		pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
 		return -EINVAL;
 	}
@@ -1682,8 +1683,10 @@ static int btf_dump_int_data(struct btf_dump *d,
 	/* handle packed int data - accesses of integers not aligned on
 	 * int boundaries can cause problems on some platforms.
 	 */
-	if (!ptr_is_aligned(data, sz))
-		return btf_dump_bitfield_data(d, t, data, 0, 0);
+	if (!ptr_is_aligned(data, sz)) {
+		memcpy(buf, data, sz);
+		data = buf;
+	}
 
 	switch (sz) {
 	case 16: {
-- 
2.31.1

