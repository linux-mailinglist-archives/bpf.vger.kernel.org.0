Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD326F1BEA
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjD1PvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbjD1PvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 11:51:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF81984
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 08:50:57 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SFlOLt012840;
        Fri, 28 Apr 2023 15:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pailouBQOWjGQ9ocP+IpgsgVn3Wuh5kODzUeIiV3A4g=;
 b=JjJ5nIfKZaNMlpgxflClXH8Mv18LDr2phojbeGQPgpsX7WHv2rV6usEcpmmiRMOxJYZU
 ZLoCqQmS4N9uPbDpi057fqhhHttW+bJqmx1Wc2ULLjmsP178qDxIhwo1C/ZNrMQTW3YA
 0ou6aIZ5uUw4A5ZRySLz0LC9o7ZIMip15GPOFJUO2+Vv3RiaPMX+JKlJnQE3WNAOJ5S8
 DeoriKIXL2x+WS8Og6I6tZ+HaxAbVwMJ8Wz5vmJZroyGhDfUsOwrktMH5O5FJBHSld6s
 cmeXt4yjeZbfoWgUPoiRy2jIqXXTnutME5Fp3wN9adTMz1Qwp7s+rSHQGwRVNGwHlljG Mg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8d9mqhns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:50:43 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33SEaO4O016851;
        Fri, 28 Apr 2023 15:50:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q477730e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:50:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SFobCU49283412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 15:50:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B91D52004D;
        Fri, 28 Apr 2023 15:50:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C73D20043;
        Fri, 28 Apr 2023 15:50:37 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.49.95])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 15:50:37 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] libbpf: Fix overflow detection when dumping bitfields
Date:   Fri, 28 Apr 2023 17:50:34 +0200
Message-Id: <20230428155035.530862-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AeaHIN0vECkE0Cbze2VSZfBorVxbnf7m
X-Proofpoint-GUID: AeaHIN0vECkE0Cbze2VSZfBorVxbnf7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_dump test fails on s390x with the following error:

    unexpected return value dumping fs_context: actual -7 != expected 280

This happens when processing the fs_context.phase member: its type size
is 4, but there are less bytes left until the end of the struct. The
problem is that btf_dump_type_data_check_overflow() does not handle
bitfields.

Add bitfield support; make sure that byte boundaries, which are
computed from bit boundaries, are rounded up.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 580985ee5545..f8b538e8d753 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2250,9 +2250,11 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
 					     const struct btf_type *t,
 					     __u32 id,
 					     const void *data,
-					     __u8 bits_offset)
+					     __u8 bits_offset,
+					     __u8 bit_sz)
 {
 	__s64 size = btf__resolve_size(d->btf, id);
+	const void *end;
 
 	if (size < 0 || size >= INT_MAX) {
 		pr_warn("unexpected size [%zu] for id [%u]\n",
@@ -2280,7 +2282,11 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
 	case BTF_KIND_PTR:
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
-		if (data + bits_offset / 8 + size > d->typed_dump->data_end)
+		if (bit_sz)
+			end = data + (bits_offset + bit_sz + 7) / 8;
+		else
+			end = data + (bits_offset + 7) / 8 + size;
+		if (end > d->typed_dump->data_end)
 			return -E2BIG;
 		break;
 	default:
@@ -2407,7 +2413,7 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 {
 	int size, err = 0;
 
-	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset);
+	size = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
 	if (size < 0)
 		return size;
 	err = btf_dump_type_data_check_zero(d, t, id, data, bits_offset, bit_sz);
-- 
2.40.0

