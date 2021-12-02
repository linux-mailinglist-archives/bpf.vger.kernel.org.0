Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEC466BF4
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 23:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhLBWNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 17:13:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231210AbhLBWNF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Dec 2021 17:13:05 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B2JSbXQ003161
        for <bpf@vger.kernel.org>; Thu, 2 Dec 2021 14:09:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JEG5/LZrcNSfAVEq1CIN3YKEAVqhLh6Kijt2pEYwK8I=;
 b=WEqPKKnBn+9QCiZviBBRO608Rt5gtv3NdhzBjbAG6cNOamkFFp8iD649z9qTUEDirDXx
 DFTVBSQQZ51tcxGSnGmqCbkNfD+UoP2/Z7VMTuv1OdCNGJ9byKRWL48MYDELgLNUlhF6
 sULUsqi8z8/SXW8zF4Acgk10AvOqOwaBfZI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3cptf1dvvy-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 14:09:41 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 14:09:40 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id C8ACC835BBF1; Thu,  2 Dec 2021 14:09:34 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next] libbpf: Fix null pointer when using old pref_buffer__new()
Date:   Thu, 2 Dec 2021 14:09:29 -0800
Message-ID: <20211202220933.1155174-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: oItbkjYPKGbKZ0cOYQ5mPCuT1nfdo-rz
X-Proofpoint-GUID: oItbkjYPKGbKZ0cOYQ5mPCuT1nfdo-rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_15,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 mlxlogscore=487 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Passing opts point to new function so program using old interface won't
segfault.

Fixes: 417889346577 ("libbpf: Make perf_buffer__new() use OPTS-based inte=
rface")

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1341ce539662..dac4929e5810 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10812,7 +10812,7 @@ struct perf_buffer *perf_buffer__new_deprecated(i=
nt map_fd, size_t page_cnt,
 				       opts ? opts->sample_cb : NULL,
 				       opts ? opts->lost_cb : NULL,
 				       opts ? opts->ctx : NULL,
-				       NULL);
+				       opts);
 }
=20
 DEFAULT_VERSION(perf_buffer__new_raw_v0_6_0, perf_buffer__new_raw, LIBBP=
F_0.6.0)
--=20
2.30.2

