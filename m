Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8630A1F7DFF
	for <lists+bpf@lfdr.de>; Fri, 12 Jun 2020 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLUQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 16:16:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgFLUQ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 16:16:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CKGMhx004048
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 13:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=VT2V1tYXI+VCPUccLQ+louPyoq93M53zm+nGrNNwbpM=;
 b=P66WvbWpadvb/sVYdeTzXO6BNRy8ZrW/zV6G5IdiTaUed4N2et0DDIE/Wp0kwiJKMzYD
 uLZHj8TCUpDkoMG56J3zPXc7mehvWpd38JODpq+KFCBNllYFbpvMu0NJ0omcJCDxNBQi
 MI0bx1wHkqPgu0M4Qz9TqeKbwPeVyRnsths= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31kqwwxm31-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 13:16:26 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 13:16:10 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3386A2EC166C; Fri, 12 Jun 2020 13:16:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Tobias Klauser <tklauser@distanz.ch>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf] tools/bpftool: fix skeleton codegen
Date:   Fri, 12 Jun 2020 13:16:03 -0700
Message-ID: <20200612201603.680852-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_16:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=549 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=2 cotscore=-2147483648
 adultscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120147
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove unnecessary check at the end of codegen() routine which makes code=
gen()
to always fail and exit bpftool with error code. Positive value of variab=
le
n is not an indicator of a failure.

Cc: Tobias Klauser <tklauser@distanz.ch>
Fixes: 2c4779eff837 ("tools, bpftool: Exit on error in function codegen")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/gen.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7443879e87af..10de76b296ba 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -257,8 +257,6 @@ static void codegen(const char *template, ...)
 	va_end(args);
=20
 	free(s);
-	if (n)
-		exit(-1);
 }
=20
 static int do_skeleton(int argc, char **argv)
--=20
2.24.1

