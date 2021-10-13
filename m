Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736E42C5E5
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhJMQLm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:11:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236109AbhJMQLl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 12:11:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DEdxxG020930;
        Wed, 13 Oct 2021 12:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cbMQowerJkQHVebd1TzVs3gF4jH6P3Av2n0kP2o9cxU=;
 b=jTbU1kulyCBwPasucDjww9M4kGdgqgU4Uvwl5vvV1EtepgymYoLBURUkQnOO6SS7368q
 kq24k+tNEPX8+BrnpmOyokI/qFlzSn24yVIQQmvT1ztpnEb/fIsj1xshf6sUtR3sJRnf
 pXhZYC33EUyBQwoMoK/zqloRC4nKTsjrXVVNoJltd0KmSavqUIDX1W2nfUXcgeYKVOy4
 p9jrwjEvuUh8ONqsVkbg99KJYfLDSW99XGDMNjehHuCGkdRicoOsMrZ33GhWgslfClEY
 ZtxF6Gts7BnZM+hMEUnsbQLtd1mjBti3YR2BYLwpfS9wBm4iTpA3+c+6KAr+ql+iSPK8 Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpx4738-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:22 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DFrs7p028601;
        Wed, 13 Oct 2021 12:09:22 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpx472s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:22 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DG7XqO014605;
        Wed, 13 Oct 2021 16:09:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3bk2q9t3q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:09:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DG3V8B57999778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:03:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 346C6AE059;
        Wed, 13 Oct 2021 16:09:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5634AE055;
        Wed, 13 Oct 2021 16:09:06 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 16:09:06 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 3/4] libbpf: Fix dumping non-aligned __int128
Date:   Wed, 13 Oct 2021 18:09:01 +0200
Message-Id: <20211013160902.428340-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013160902.428340-1-iii@linux.ibm.com>
References: <20211013160902.428340-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nGoFZ-8TLvCS02DECtSVz-DM1QT021CQ
X-Proofpoint-ORIG-GUID: qXzdA_ZX8ZVLfpKJ3R6lr50WJTWjtOeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Non-aligned integers are dumped as bields, which is supported for at
most 64-bit integers. Fix by using the same trick as
btf_dump_float_data(): copy non-aligned values to the local buffer.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 614719c73bd7..25ce60828e8d 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1670,9 +1670,10 @@ static int btf_dump_int_data(struct btf_dump *d,
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
@@ -1680,8 +1681,10 @@ static int btf_dump_int_data(struct btf_dump *d,
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

