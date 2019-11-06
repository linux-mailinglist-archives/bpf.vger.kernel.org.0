Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1F2F1ADE
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 17:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfKFQMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 11:12:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbfKFQMN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Nov 2019 11:12:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6G55fE046114
        for <bpf@vger.kernel.org>; Wed, 6 Nov 2019 11:12:12 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w3yv34wxu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 11:12:12 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 6 Nov 2019 16:12:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 16:12:07 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6GC6Jo32899304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 16:12:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22AEA4C04A;
        Wed,  6 Nov 2019 16:12:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE0B74C058;
        Wed,  6 Nov 2019 16:12:05 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 16:12:05 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [RFC PATCH bpf-next] bpf: allow JIT debugging if CONFIG_BPF_JIT_ALWAYS_ON is set
Date:   Wed,  6 Nov 2019 17:12:04 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110616-0012-0000-0000-00000361467B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110616-0013-0000-0000-0000219CA441
Message-Id: <20191106161204.87261-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently it's not possible to set bpf_jit_enable = 2 when
CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
harder.

It looks as if it's safe to allow this, because setting this knob
requires root anyway, but I'm not sure about all the security
implications, so sending this as an RFC.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 net/core/sysctl_net_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb29e5adc84d..09f1218b5656 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -389,7 +389,7 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
 		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &two,
 # else
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
-- 
2.23.0

