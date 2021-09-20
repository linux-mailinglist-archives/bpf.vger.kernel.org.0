Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1537C41235B
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351936AbhITSXe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Sep 2021 14:23:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351879AbhITSVd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 14:21:33 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18KHwChl002000
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 11:20:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3b6ng8kt37-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 11:20:06 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 11:20:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EACDF48340DE; Mon, 20 Sep 2021 11:20:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] libbpf: fix legacy kprobe event creation FD error handling
Date:   Mon, 20 Sep 2021 11:19:59 -0700
Message-ID: <20210920181959.1565954-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920181959.1565954-1-andrii@kernel.org>
References: <20210920181959.1565954-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: _knJbdgpz9uB8OF4tHu0GsTKKpdH65aF
X-Proofpoint-ORIG-GUID: _knJbdgpz9uB8OF4tHu0GsTKKpdH65aF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

open() returns -1 on error, not zero FD. Fix the error handling logic.
Reported by Coverity statis analysis.

Fixes: ca304b40c20d ("libbpf: Introduce legacy kprobe events support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d2f12db6034..761497be6ffc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9036,7 +9036,7 @@ static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_
 	}
 
 	fd = open(file, O_WRONLY | O_APPEND, 0);
-	if (!fd)
+	if (fd < 0)
 		return -errno;
 	ret = write(fd, cmd, strlen(cmd));
 	if (ret < 0)
-- 
2.30.2

