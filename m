Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3D42C5E3
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhJMQLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:11:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235372AbhJMQLf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 12:11:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DFXME8031642;
        Wed, 13 Oct 2021 12:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JSY4htBYwywh63CPb5A+RvOPH4DsrBo7T5QZqle7uVg=;
 b=hCJpOhwqKHE9EtiSnInoSt5TY0Vrshm277POdQYoGmTfYj0G1+dW1/MCl9QmqmeO1yxH
 jm0odihiNYtxVuMR0lA+kuL3yZJ6geHEtIAxv81JeaVe+eK9D579POvWXeFSbQE0ogTG
 uH0x/4M7r8qCvYcjQgSVKJ5JglAWedcrViq3ChCfP6seXz0tHqrnGXGtzSBCSm2YQonn
 DtFc98jxrqdspdmWLT2Z7e8gXO6RciMva6GhtNisctA0yvYnPmYevo2aXg+KtmMceuKt
 qY4EobqV2/lS8aEs9KCo7fUB014eajceN9pWvsr+7VjDf30ScqcJSiIFwwJJtoR+NTwq iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79q4q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:20 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DFm5J4020094;
        Wed, 13 Oct 2021 12:09:19 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79q4p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:19 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DG7VH7005541;
        Wed, 13 Oct 2021 16:09:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2qa2213-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:09:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DG3Snh57409804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:03:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4F4AE056;
        Wed, 13 Oct 2021 16:09:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C77AE065;
        Wed, 13 Oct 2021 16:09:06 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 16:09:05 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/4] libbpf: Fix dumping big-endian bitfields
Date:   Wed, 13 Oct 2021 18:09:00 +0200
Message-Id: <20211013160902.428340-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013160902.428340-1-iii@linux.ibm.com>
References: <20211013160902.428340-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ghJrdLxdIC-nCykr7RSdveievsDHQKXI
X-Proofpoint-ORIG-GUID: ZDjvCV2I65XyveHHuxn0lh43KUqM-MSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On big-endian arches not only bytes, but also bits are numbered in
reverse order (see e.g. S/390 ELF ABI Supplement, but this is also true
for other big-endian arches as well).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ad6df97295ae..614719c73bd7 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1562,29 +1562,28 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 				       __u64 *value)
 {
 	__u16 left_shift_bits, right_shift_bits;
-	__u8 nr_copy_bits, nr_copy_bytes;
 	const __u8 *bytes = data;
-	int sz = t->size;
+	__u8 nr_copy_bits;
 	__u64 num = 0;
 	int i;
 
 	/* Maximum supported bitfield size is 64 bits */
-	if (sz > 8) {
-		pr_warn("unexpected bitfield size %d\n", sz);
+	if (t->size > 8) {
+		pr_warn("unexpected bitfield size %d\n", t->size);
 		return -EINVAL;
 	}
 
 	/* Bitfield value retrieval is done in two steps; first relevant bytes are
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
-	nr_copy_bits = bit_sz + bits_offset;
-	nr_copy_bytes = t->size;
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-	for (i = nr_copy_bytes - 1; i >= 0; i--)
+	for (i = t->size - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
+	nr_copy_bits = bit_sz + bits_offset;
 #elif __BYTE_ORDER == __BIG_ENDIAN
-	for (i = 0; i < nr_copy_bytes; i++)
+	for (i = 0; i < t->size; i++)
 		num = num * 256 + bytes[i];
+	nr_copy_bits = t->size * 8 - bits_offset;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-- 
2.31.1

