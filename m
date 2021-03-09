Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEB331BF8
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 01:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCIA5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 19:57:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229791AbhCIA5J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 19:57:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1290YAQA053585;
        Mon, 8 Mar 2021 19:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9RldZoE+uWYHrL6YAx96ZnveiZcFnd9hLzZtDEIQnY0=;
 b=kGDvZzPe/+H7/55d0HDckNgMImRihyVY2ZvSiG/w4ofTr5W3vkNMaev4HOP17Rrwjmg5
 7dQFkyo+2VnCDE/Bh7kOlP8vYd2Psamhe0UYUxdJa2ZjqP8rC7PAXbKG8u4sl2LwW5zh
 wiMi8lmUdefL9qxevxZ6MYseZq7Yxdo01cYOjkT9MPwGw68YBFZJjewMFkM9qC/0Hed5
 MTtCax37jqYV0gK4o94r/5v/P9AOcAyIiJiHtbbrBqZLY4Lrb0Asz648OA1BlOkqaOB8
 mFmHiDc+jQIiGHZE4uD1Z1bU9CUi+9t87rmBA03gJHoaCmAEhbUipezug/xSgrHPn72h eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wdm1vmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:58 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1290puxZ109451;
        Mon, 8 Mar 2021 19:56:57 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wdm1vmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:57 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1290qjg2006333;
        Tue, 9 Mar 2021 00:56:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3741c8a98h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 00:56:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1290uq6M41746848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 00:56:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8F3AE053;
        Tue,  9 Mar 2021 00:56:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4D4AE04D;
        Tue,  9 Mar 2021 00:56:52 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 00:56:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add BTF_KIND_FLOAT to btf_dump_test_case_syntax
Date:   Tue,  9 Mar 2021 01:56:49 +0100
Message-Id: <20210309005649.162480-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309005649.162480-1-iii@linux.ibm.com>
References: <20210309005649.162480-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090000
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that dumping various floating-point types produces a valid C
code.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 31975c96e2c9..12b40dc81e14 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -205,6 +205,12 @@ struct struct_with_embedded_stuff {
 	int t[11];
 };
 
+struct float_struct {
+	float f;
+	const double *d;
+	volatile long double *ld;
+};
+
 struct root_struct {
 	enum e1 _1;
 	enum e2 _2;
@@ -219,6 +225,7 @@ struct root_struct {
 	union_fwd_t *_12;
 	union_fwd_ptr_t _13;
 	struct struct_with_embedded_stuff _14;
+	struct float_struct _15;
 };
 
 /* ------ END-EXPECTED-OUTPUT ------ */
-- 
2.29.2

