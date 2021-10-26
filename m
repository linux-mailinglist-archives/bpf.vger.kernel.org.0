Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949243A996
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhJZBLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:11:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236024AbhJZBLS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:11:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PLVuDh007320;
        Tue, 26 Oct 2021 01:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UMmsHuwqogpihFTHrWTJl8fiUXfbQZqrId5jnEUVJss=;
 b=dTwOkeILtq4Z27BO1ATZqau9o79lJ071EoFhMRc97/Z2yFww/QN/1y49OteBqIEvzWTb
 RczTeZqewP4U+nZgHvN/QyFI1QKOG8kpNPP4UdOOyjHgxUgRCnnQAbRRRlkLmJ+DovO+
 I5zLC5nsFKJOj7LQzxlOkz8N0NNuSMcup4eLyN815QVL5RINowMBzP0x83QynjBBTAcQ
 SJ6S1nou+cIKzOZxE2g0rcjJCwFv2749J2JPf7nTILxe3hovgSD/bcjQ6b7I3LjfB9s7
 gwi9TU7Ms1n8dA7EAGY4Ly+IZvONUVcQFlr2OmyHTPxAYjtEiHGQkP+MmwCfHgiEGxFa cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k23ww2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:43 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q18hbk005818;
        Tue, 26 Oct 2021 01:08:43 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k23wvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q12uNv031108;
        Tue, 26 Oct 2021 01:08:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3bx4f20pyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q18bpa63504640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 01:08:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 035BB42042;
        Tue, 26 Oct 2021 01:08:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91BFD4203F;
        Tue, 26 Oct 2021 01:08:36 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 01:08:36 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Fix test_core_reloc_mods on big-endian machines
Date:   Tue, 26 Oct 2021 03:08:31 +0200
Message-Id: <20211026010831.748682-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026010831.748682-1-iii@linux.ibm.com>
References: <20211026010831.748682-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BH2kfkCaBzBjo9lepcJEw_rOHbR7yOlo
X-Proofpoint-ORIG-GUID: YQKIHeiOwrcz_b65AWZDtIV9EiEnCNUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260004
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

