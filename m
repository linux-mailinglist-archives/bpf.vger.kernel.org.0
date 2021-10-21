Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835F1436E7E
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 01:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhJUXtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 19:49:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhJUXta (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 19:49:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LKfrT3004551;
        Thu, 21 Oct 2021 19:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q4BGp6LDkMZ4Uq7rc/5MaOnMdNHtsvf660xUQ56vnS0=;
 b=KAJQNo0ARCmRrbZ0qucia2W6Ea09JtgYOmQNLYYvwEcqDK+DhvJSAuYVMlNjml16OYMl
 KwJZXu6NC3ej8L8EoBvpx8eH+FcFrsigtIa9nVo5efJEU7PSYdkuHBCabd4xFuiaKzYz
 yG+fnA+zMqf73QrCxkL7g+ny3FVw0S6wsvDVmczUyVeHqRaWfX0LYCoZrBE1h6WWQRSa
 d/KqgGfiBYiIAYVryYNfh7DBZN7qlc/Zp5mZPlsNqHn4AKWixNvXHxuU934bOykNBpRz
 CgkK52SgTeUnZa8oMNpF4TcyRqkMH60yd7HOQLSOI0F8HGzV4RPDresvxGASQK/GQW0e Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bucfy73m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:02 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LNaBb6021924;
        Thu, 21 Oct 2021 19:47:01 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bucfy73km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 19:47:01 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LNgLQo011101;
        Thu, 21 Oct 2021 23:46:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3bqpcarcrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 23:46:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LNkuIH65798504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:46:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0134952051;
        Thu, 21 Oct 2021 23:46:56 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 95CB952052;
        Thu, 21 Oct 2021 23:46:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] libbpf: Fix relocating big-endian bitfields
Date:   Fri, 22 Oct 2021 01:46:52 +0200
Message-Id: <20211021234653.643302-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021234653.643302-1-iii@linux.ibm.com>
References: <20211021234653.643302-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BranUAeaDXqPG6_DkNmIMR4XwUChe8BX
X-Proofpoint-GUID: 1bQwjxtf9_YjeBRV6PAC4_daoEPxhtEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_07,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the same as commit c9e982b87946 ("libbpf: Fix dumping
big-endian bitfields"), but for CO-RE. Make the code structure as
similar as possible to that of btf_dump_get_bitfield_value().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/relo_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index b5b8956a1be8..fd814b985e1e 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -661,13 +661,18 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		if (validate)
 			*validate = true; /* signedness is never ambiguous */
 		break;
-	case BPF_FIELD_LSHIFT_U64:
+	case BPF_FIELD_LSHIFT_U64: {
+		__u32 bits_offset = bit_off - byte_off * 8;
+		__u8 nr_copy_bits;
+
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-		*val = 64 - (bit_off + bit_sz - byte_off  * 8);
+		nr_copy_bits = bit_sz + bits_offset;
 #else
-		*val = (8 - byte_sz) * 8 + (bit_off - byte_off * 8);
+		nr_copy_bits = byte_sz * 8 - bits_offset;
 #endif
+		*val = 64 - nr_copy_bits;
 		break;
+	}
 	case BPF_FIELD_RSHIFT_U64:
 		*val = 64 - bit_sz;
 		if (validate)
-- 
2.31.1

