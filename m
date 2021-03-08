Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B233161F
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHSbE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Mar 2021 13:31:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231303AbhCHSaz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 13:30:55 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 128IDtbQ019534
        for <bpf@vger.kernel.org>; Mon, 8 Mar 2021 10:30:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 374thpx0mn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 10:30:54 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Mar 2021 10:30:51 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 851F42ED1A8F; Mon,  8 Mar 2021 10:30:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <gvalkov@abv.bg>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf] libbpf: fix INSTALL flag order
Date:   Mon, 8 Mar 2021 10:30:38 -0800
Message-ID: <20210308183038.613432-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_14:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Georgi Valkov <gvalkov@abv.bg>

It was reported ([0]) that having optional -m flag between source and
destination arguments in install command breaks bpftools cross-build on MacOS.
Move -m to the front to fix this issue.

  [0] https://github.com/openwrt/openwrt/pull/3959

Fixes: 7110d80d53f4 ("libbpf: Makefile set specified permission mode")
Signed-off-by: Georgi Valkov <gvalkov@abv.bg>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 887a494ad5fc..e9eb6a6e80d2 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -215,7 +215,7 @@ define do_install
 	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
 	fi;						\
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	$(INSTALL) $(if $3,-m $3,) $1 '$(DESTDIR_SQ)$2'
 endef
 
 install_lib: all_cmd
-- 
2.24.1

