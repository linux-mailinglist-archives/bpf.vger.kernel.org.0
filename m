Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050AE4659D5
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353769AbhLAXcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46200 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353750AbhLAXcG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LcmpK011350
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:45 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp74ndqxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:44 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2C2BCB7A0AD1; Wed,  1 Dec 2021 15:28:35 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH bpf-next 5/9] selftests/bpf: mute xdpxceiver.c's deprecation warnings
Date:   Wed, 1 Dec 2021 15:28:20 -0800
Message-ID: <20211201232824.3166325-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: xzXIU0BuiI_9iBYwknuIxBdl2u7Ip-Kk
X-Proofpoint-ORIG-GUID: xzXIU0BuiI_9iBYwknuIxBdl2u7Ip-Kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

xdpxceiver.c is using AF_XDP APIs that are deprecated starting from
libbpf 0.7. Until we migrate the test to libxdp or solve this issue in
some other way, mute deprecation warnings within xdpxceiver.c.

Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 040164c7efc1..0a5d23da486d 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -100,6 +100,12 @@
 #include "xdpxceiver.h"
 #include "../kselftest.h"
 
+/* AF_XDP APIs were moved into libxdp and marked as deprecated in libbpf.
+ * Until xdpxceiver is either moved or re-writed into libxdp, suppress
+ * deprecation warnings in this file
+ */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
 static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
 static const char *IP1 = "192.168.100.162";
-- 
2.30.2

