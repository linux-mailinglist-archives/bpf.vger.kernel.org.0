Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341032F791
	for <lists+bpf@lfdr.de>; Sat,  6 Mar 2021 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCFBmP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 5 Mar 2021 20:42:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhCFBl5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 20:41:57 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1261dBVb011253
        for <bpf@vger.kernel.org>; Fri, 5 Mar 2021 17:41:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 372nyhvw6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Mar 2021 17:41:57 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 17:41:56 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id AD4862ED16FC; Fri,  5 Mar 2021 17:41:46 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Georgi Valkov <gvalkov@abv.bg>
Subject: [PATCH bpf-next] libbpf: fix INSTALL flag order
Date:   Fri, 5 Mar 2021 17:41:26 -0800
Message-ID: <20210306014127.850411-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_16:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103060009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It was reported ([0]) that having optional -m flag between source and
destination arguments in install command breaks bpftools cross-build on MacOS.
Move -m to the front to fix this issue.

  [0] https://github.com/openwrt/openwrt/pull/3959

Fixes: 7110d80d53f4 ("libbpf: Makefile set specified permission mode")
Reported-by: Georgi Valkov <gvalkov@abv.bg>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 8170f88e8ea6..87b14b74d62f 100644
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

