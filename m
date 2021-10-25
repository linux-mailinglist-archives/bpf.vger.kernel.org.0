Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A75439744
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJYNPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:15:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233371AbhJYNPD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:15:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCMGvR017777;
        Mon, 25 Oct 2021 13:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UMmsHuwqogpihFTHrWTJl8fiUXfbQZqrId5jnEUVJss=;
 b=a6OEZoBYPuOKKTsG850P+DqUAF08BZ7R5bovnb5iEZj0JUtcSPQPOoIe05ywVn0skklc
 63pp8VeZ0ggtKlrAUgTJSoeMVp/Njb53bvXs4pEI+wvAKuiE0u9hg96WfUhiyUm8kGo1
 QL0WsDHUw0zrgiMz8Fx84+lgZ3k06f4Y/FF4UzSRQHXWmoD0gOz0o7hmeQxq6sf4Ecfz
 hlNxPSWT93G+RVNeHJLZIzgq22es3+iG38Nyx9ka5yII0fVEVOLKg+RGykdmgam8OpP9
 rGwP89mB4R1vhqORKOUW57eO/enFgTQ1jBwswrBKoHz0Rk5T7RYFZBR2FvZO5swE0JWi 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwt1wwacx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCMJdN018009;
        Mon, 25 Oct 2021 13:12:27 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwt1wwabv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD8BcC015295;
        Mon, 25 Oct 2021 13:12:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3bva19dbuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PDCK8U58655084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:12:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 316FCA4080;
        Mon, 25 Oct 2021 13:12:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA58A406E;
        Mon, 25 Oct 2021 13:12:19 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 13:12:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Fix test_core_reloc_mods on big-endian machines
Date:   Mon, 25 Oct 2021 15:12:14 +0200
Message-Id: <20211025131214.731972-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025131214.731972-1-iii@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YKZ42RTdiCu-46kbEN4l7QZVF67A3eJ5
X-Proofpoint-GUID: RpgDtWVR-8smmibgfBZTiO62VwWZpSGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the same as commit d164dd9a5c08 ("selftests/bpf: Fix
test_core_autosize on big-endian machines"), but for
test_core_reloc_mods.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/test_core_reloc_mods.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
index 8b533db4a7a5..b2ded497572a 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
@@ -42,7 +42,16 @@ struct core_reloc_mods {
 	core_reloc_mods_substruct_t h;
 };
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define CORE_READ(dst, src) bpf_core_read(dst, sizeof(*(dst)), src)
+#else
+#define CORE_READ(dst, src) ({ \
+	int __sz = sizeof(*(dst)) < sizeof(*(src)) ? sizeof(*(dst)) : \
+						     sizeof(*(src)); \
+	bpf_core_read((char *)(dst) + sizeof(*(dst)) - __sz, __sz, \
+		      (const char *)(src) + sizeof(*(src)) - __sz); \
+})
+#endif
 
 SEC("raw_tracepoint/sys_enter")
 int test_core_mods(void *ctx)
-- 
2.31.1

