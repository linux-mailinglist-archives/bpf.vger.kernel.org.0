Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFB429B85
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJLCel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:34:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhJLCek (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:34:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C0VQ8G024569;
        Mon, 11 Oct 2021 22:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TDkItwA/7DTCNuq3Zua+Gnm4cCHUDv4Iq5gdeASIEeI=;
 b=ljKvr7iTBk3UoAZhWRPRw13lpHVqbc+gh3qFTKz16XpUVdZxvRAvEbfYUIpHAgJMRnbc
 Sy7v6aNu+DwPaOXvP8GdSj1+s//B+l7jJAHdXl/D2teBLIavfI1kwN/VN8hA+riSmwtS
 Z01iZ8MSZ96BON4pJa8mLFQoNHpZmNDZrHdd1Xd1K7n4xrHCJg68aktZly/rXGIwQkR5
 8xe8mynuO+LWwOx2pkzAIGyQ0yhUIqX/f2jdplrhS9iVjK2/8YfNrAkG4T/rU90hEMtC
 lBeXm1vPghzqu6c4R81vVi63hCYs3ilqFl2zZcfvo6M2qr9zRrwyRtGzPI3OEEso4JI2 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmyw5hmyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:28 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C2Vh7s023318;
        Mon, 11 Oct 2021 22:32:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmyw5hmyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BPqc020151;
        Tue, 12 Oct 2021 02:32:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3bk2qa21dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:32:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2WLpX2294378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:32:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE2E11C05E;
        Tue, 12 Oct 2021 02:32:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC7B11C04C;
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
Subject: [PATCH bpf-next 2/3] libbpf: Fix dumping big-endian bitfields
Date:   Tue, 12 Oct 2021 04:32:17 +0200
Message-Id: <20211012023218.399568-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012023218.399568-1-iii@linux.ibm.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K7zYQE4B_cQpvJ2wH0NB9CAC9xcykF3Q
X-Proofpoint-ORIG-GUID: Pz-C3VrKqwiGeJmRKN2TeE3nyLHZbtiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On big-endian arches not only bytes, but also bits are numbered in
reverse order (see e.g. S/390 ELF ABI Supplement, but this is also true
for other big-endian arches as well).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ad6df97295ae..ab45771d0cb4 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1577,14 +1577,15 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	/* Bitfield value retrieval is done in two steps; first relevant bytes are
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
-	nr_copy_bits = bit_sz + bits_offset;
 	nr_copy_bytes = t->size;
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 	for (i = nr_copy_bytes - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
+	nr_copy_bits = bit_sz + bits_offset;
 #elif __BYTE_ORDER == __BIG_ENDIAN
 	for (i = 0; i < nr_copy_bytes; i++)
 		num = num * 256 + bytes[i];
+	nr_copy_bits = nr_copy_bytes * 8 - bits_offset;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
-- 
2.31.1

