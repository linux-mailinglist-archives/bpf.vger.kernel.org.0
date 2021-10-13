Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06942C5E4
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhJMQLi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:11:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235372AbhJMQLh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 12:11:37 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DE4lcs024011;
        Wed, 13 Oct 2021 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=saXfZJxZ36C8Qw1D8o+PJX14ggC3HES8P0TjSdwes5k=;
 b=N+i+mTQnWj0stPnG3cDwqeohy+qD6tdbb4K4XUaYxjQjf1h0XfCZNOzAVur9v5NVQbgJ
 KzOd9lzz58jhf8suwfTiyqN6bct5NF4D25r7fT8BjjV4NIRQfp1jQJWDUCPAz7Tn++Kc
 DGewdJ6I7HyhLzKyUbkvvtK5BADJ6AOJbZekTzKUUyhnDJLTgern3Zhwv+9cQ7fflg6p
 yP28u1j1XX3HCrV+aooKHd2LGHCyqcNJnDjAnyJEv3y2I+MNoTMweG30hkyY5U5LsDp+
 cbW3qd9azGrh4Wfe+UHtcj14YbT7BaMl6bDCI/q4RsW5HTIreRhipjt7JonZR6z4Q1ML /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpw78pw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:22 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DF35Jk031824;
        Wed, 13 Oct 2021 12:09:21 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpw78pv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:21 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DG7WQ4014591;
        Wed, 13 Oct 2021 16:09:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3bk2q9t3q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:09:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DG98Ma42205634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:09:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F294AE067;
        Wed, 13 Oct 2021 16:09:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7029AE058;
        Wed, 13 Oct 2021 16:09:07 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 16:09:07 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 4/4] libbpf: Fix ptr_is_aligned() usages
Date:   Wed, 13 Oct 2021 18:09:02 +0200
Message-Id: <20211013160902.428340-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013160902.428340-1-iii@linux.ibm.com>
References: <20211013160902.428340-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2TXBFIjB8DOqS1jpYC2xtnJBU5qGhHvl
X-Proofpoint-GUID: TYqqN6vl2-PHUWuF0J5VxQOOUvHX5AKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently ptr_is_aligned() takes size, and not alignment, as a
parameter, which may be overly pessimistic e.g. for __i128 on s390,
which must be only 8-byte aligned. Fix by using btf__align_of() where
possible - one notable exception is ptr_sz, for which there is no
corresponding type.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 25ce60828e8d..da345520892f 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1657,9 +1657,9 @@ static int btf_dump_base_type_check_zero(struct btf_dump *d,
 	return 0;
 }
 
-static bool ptr_is_aligned(const void *data, int data_sz)
+static bool ptr_is_aligned(const void *data, int alignment)
 {
-	return ((uintptr_t)data) % data_sz == 0;
+	return ((uintptr_t)data) % alignment == 0;
 }
 
 static int btf_dump_int_data(struct btf_dump *d,
@@ -1681,7 +1681,7 @@ static int btf_dump_int_data(struct btf_dump *d,
 	/* handle packed int data - accesses of integers not aligned on
 	 * int boundaries can cause problems on some platforms.
 	 */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(data, btf__align_of(d->btf, type_id))) {
 		memcpy(buf, data, sz);
 		data = buf;
 	}
@@ -1770,7 +1770,7 @@ static int btf_dump_float_data(struct btf_dump *d,
 	int sz = t->size;
 
 	/* handle unaligned data; copy to local union */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(data, btf__align_of(d->btf, type_id))) {
 		memcpy(&fl, data, sz);
 		flp = &fl;
 	}
@@ -1953,10 +1953,8 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
 				   __u32 id,
 				   __s64 *value)
 {
-	int sz = t->size;
-
 	/* handle unaligned enum value */
-	if (!ptr_is_aligned(data, sz)) {
+	if (!ptr_is_aligned(data, btf__align_of(d->btf, id))) {
 		__u64 val;
 		int err;
 
-- 
2.31.1

