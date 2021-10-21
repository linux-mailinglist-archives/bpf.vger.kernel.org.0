Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C1435FA5
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJUKtf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 06:49:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33484 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhJUKte (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 06:49:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LA4WBg032518;
        Thu, 21 Oct 2021 06:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lB3ISM13wYswQvXfMd1RnDWIu/Uxjqjlw/0IFk1DnSg=;
 b=EhoBLtk8cNyoeeFot9xLaCsF3sUpzjl1JrnTgQfrDYdjNu4qw08w14crQKCDjhvmiyAS
 bpJSmSG5K/7p8Gv4/LnNLiZG069UHqa2/5pKR/zO85IFT6XEA5KpgeTqCSWWxFxQY7pV
 dHyIw83meCRlrKZjKYfHQFxjmuF/xNuT9bfSPjqIr2MFYztbOaZ/f+wTBTq3kaqCGSro
 LYaKuutme6cl15vV1DEvO+fphNRje8gwS8c8z4hU5wYP/i+DnVpCfTQdaYvkTQSKNAsL
 Pq7xsDt6c9hY4i3wMv0NDVQUBfr6Hz7xuXHiN3YF4xSky7cnvsw0sf7Sb4x7z7E/FiX+ 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu20p6buk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:47:07 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LAExRu010945;
        Thu, 21 Oct 2021 06:47:06 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu20p6btx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:47:06 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LAcIUB020304;
        Thu, 21 Oct 2021 10:47:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3bqpcajud5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:47:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LAl1Yb52232560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:47:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 884C242095;
        Thu, 21 Oct 2021 10:47:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BD1342099;
        Thu, 21 Oct 2021 10:47:01 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 10:47:01 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/1] libbpf: Fix ptr_is_aligned() usages
Date:   Thu, 21 Oct 2021 12:46:58 +0200
Message-Id: <20211021104658.624944-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021104658.624944-1-iii@linux.ibm.com>
References: <20211021104658.624944-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O-7XjzVHtvlntdpp5P3zsdg3vAJ2z-wb
X-Proofpoint-GUID: ml7ls4UYUJHJxR_T5hiJO7h5fU_wyYXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210054
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently ptr_is_aligned() takes size, and not alignment, as a
parameter, which may be overly pessimistic e.g. for __i128 on s390,
which must be only 8-byte aligned. Fix by using btf__align_of().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e98c201f29b5..e9e5801ece4c 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1657,9 +1657,15 @@ static int btf_dump_base_type_check_zero(struct btf_dump *d,
 	return 0;
 }
 
-static bool ptr_is_aligned(const void *data, int data_sz)
+static bool ptr_is_aligned(const struct btf *btf, __u32 type_id,
+			   const void *data)
 {
-	return ((uintptr_t)data) % data_sz == 0;
+	int alignment = btf__align_of(btf, type_id);
+
+	if (alignment == 0)
+		return false;
+
+	return ((uintptr_t)data) % alignment == 0;
 }
 
 static int btf_dump_int_data(struct btf_dump *d,
@@ -1681,7 +1687,7 @@ static int btf_dump_int_data(struct btf_dump *d,
 	/* handle packed int data - accesses of integers not aligned on
 	 * int boundaries can cause problems on some platforms.
 	 */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(d->btf, type_id, data)) {
 		memcpy(buf, data, sz);
 		data = buf;
 	}
@@ -1770,7 +1776,7 @@ static int btf_dump_float_data(struct btf_dump *d,
 	int sz = t->size;
 
 	/* handle unaligned data; copy to local union */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(d->btf, type_id, data)) {
 		memcpy(&fl, data, sz);
 		flp = &fl;
 	}
@@ -1933,7 +1939,7 @@ static int btf_dump_ptr_data(struct btf_dump *d,
 			      __u32 id,
 			      const void *data)
 {
-	if (ptr_is_aligned(data, d->ptr_sz) && d->ptr_sz == sizeof(void *)) {
+	if (ptr_is_aligned(d->btf, id, data) && d->ptr_sz == sizeof(void *)) {
 		btf_dump_type_values(d, "%p", *(void **)data);
 	} else {
 		union ptr_data pt;
@@ -1953,10 +1959,8 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
 				   __u32 id,
 				   __s64 *value)
 {
-	int sz = t->size;
-
 	/* handle unaligned enum value */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(d->btf, id, data)) {
 		__u64 val;
 		int err;
 
-- 
2.31.1

