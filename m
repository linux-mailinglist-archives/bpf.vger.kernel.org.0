Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876C67F330
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjA1Adh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjA1Adf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B679099
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:33:34 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30S0Br7F013595;
        Sat, 28 Jan 2023 00:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Kn9WU6zvwmdsGUgA4BboKHSbABDy8pVp1PB/CauFyd4=;
 b=e1qOJYW8qykAf5i1+UpRiQ5WiqeBJh/UgFMaKDmBI4ojqrREHMzUGlL75VhXfeLfDEhM
 EekzViz/iclpfctOMGJ250RcezO+OaOrt6kxK0iGAVcCYpNqz+m9vl27eh3wZpbpYtrS
 ktk+MHHCXJiArllAGyR1irI++amlvODb1TNJJjBe3d5Uo02tpU5CRfIMMxTQs71SzaJ2
 qAFMK2kG3DQB7hUK9Vi7zgyNgoZw5QDPkDmyjcLlfiiN5/MjvEf+DWO20MGGuL22WWwn
 Hg0DwwsSUcwSBfhq0NTRn88D5a4N7JQdhLRtqGuMXWnPY9R4PS6xLTu4k8n89q9XvgxW Vw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrxv0b4h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:33:21 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R4DrR0006823;
        Sat, 28 Jan 2023 00:07:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dufw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S06wu223593248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:06:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2166920043;
        Sat, 28 Jan 2023 00:06:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FEF520040;
        Sat, 28 Jan 2023 00:06:57 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:06:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 01/31] bpf: Use ARG_CONST_SIZE_OR_ZERO for 3rd argument of bpf_tcp_raw_gen_syncookie_ipv{4,6}()
Date:   Sat, 28 Jan 2023 01:06:20 +0100
Message-Id: <20230128000650.1516334-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2qfKkCT5LxWdmsYNGvHF0SehTtMWI8tb
X-Proofpoint-ORIG-GUID: 2qfKkCT5LxWdmsYNGvHF0SehTtMWI8tb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301280003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These functions already check that th_len < sizeof(*th), and
propagating the lower bound (th_len > 0) may be challenging
in complex code, e.g. as is the case with xdp_synproxy test on
s390x [1]. Switch to ARG_CONST_SIZE_OR_ZERO in order to make the
verifier accept code where it cannot prove that th_len > 0.

[1] https://lore.kernel.org/bpf/CAEf4Bzb3uiSHtUbgVWmkWuJ5Sw1UZd4c_iuS4QXtUkXmTTtXuQ@mail.gmail.com/

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6da78b3d381e..3ba508a02364 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7532,7 +7532,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
 	.arg1_size	= sizeof(struct iphdr),
 	.arg2_type	= ARG_PTR_TO_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(bpf_tcp_raw_gen_syncookie_ipv6, struct ipv6hdr *, iph,
@@ -7564,7 +7564,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
 	.arg1_size	= sizeof(struct ipv6hdr),
 	.arg2_type	= ARG_PTR_TO_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv4, struct iphdr *, iph,
-- 
2.39.1

