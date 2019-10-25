Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4AE42B8
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 06:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfJYEzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 00:55:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30276 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732606AbfJYEzN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Oct 2019 00:55:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P4qtHA006886
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 21:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=zcsbUGKA5Tuu/D5R+w2r5vRZEW/enRkqli2tntJvlBQ=;
 b=ksKdgdaMWJKNurnZCV3w8Z5mq6JYmFRI2f1EETqf7MhW1D5PrzCFuK6qT2cxXOUBbvRZ
 toEKvHQGg7n+xUlefYKMnJD1JQZstSqk3QnNhD3g67+3M4exrxTqkpwzdvO0XKzHFoEU
 WRoeW7NlbCuL4t0Xivn/IduI/BiCkbqPknU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vue7qb57g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 21:55:11 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 24 Oct 2019 21:55:10 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 164998630DE; Thu, 24 Oct 2019 21:55:05 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] selftests/bpf: fix .gitignore to ignore no_alu32/
Date:   Thu, 24 Oct 2019 21:55:03 -0700
Message-ID: <20191025045503.3043427-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_02:2019-10-23,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=9 adultscore=0 mlxlogscore=858 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When switching to alu32 by default, no_alu32/ subdirectory wasn't added
to .gitignore. Fix it.

Fixes: e13a2fe642bd ("tools/bpf: Turn on llvm alu32 attribute by default")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 6f46170e09c1..4865116b96c7 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -37,5 +37,5 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
-/alu32
+/no_alu32
 /bpf_gcc
-- 
2.17.1

