Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA46BE52B
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2019 20:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfIYSwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Sep 2019 14:52:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbfIYSwM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Sep 2019 14:52:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8PIlMEh005181
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 11:52:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=fcgFkAs3AE37qTH5jpgxHmTqO5XmNb3/n2AIbTsVGL8=;
 b=kAckG6zrzG1ESLi0WW1D2DmSGIdUvlEg580fEbNkVhadb9Ad8HxxZRSTeDFvdiiKIIQS
 SS6KOuXwAd4fZKscVFO6GB8O90PxAnQO/KAjA/z99agVYvGkK4917Rgu1FDR8MiyJLMx
 ANgKz6oTZ0pCQVjhBdTrPbRFq0eb3JEbZMo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2v8bgu0rch-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 11:52:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Sep 2019 11:52:08 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id BC3758619F8; Wed, 25 Sep 2019 11:52:06 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] selftests/bpf: adjust strobemeta loop to satisfy latest clang
Date:   Wed, 25 Sep 2019 11:52:05 -0700
Message-ID: <20190925185205.2857838-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_08:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=869 clxscore=1015
 suspectscore=8 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909250159
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some recent changes in latest Clang started causing the following
warning when unrolling strobemeta test case main loop:

  progs/strobemeta.h:416:2: warning: loop not unrolled: the optimizer was
  unable to perform the requested transformation; the transformation might
  be disabled or specified as part of an unsupported transformation
  ordering [-Wpass-failed=transform-warning]

This patch simplifies loop's exit condition to depend only on constant
max iteration number (STROBE_MAX_MAP_ENTRIES), while moving early
termination logic inside the loop body. The changes are equivalent from
program logic standpoint, but fixes the warning. It also appears to
improve generated BPF code, as it fixes previously failing non-unrolled
strobemeta test cases.

Cc: Alexei Starovoitov <ast@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 8a399bdfd920..067eb625d01c 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -413,7 +413,10 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 #else
 #pragma unroll
 #endif
-	for (int i = 0; i < STROBE_MAX_MAP_ENTRIES && i < map.cnt; ++i) {
+	for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
+		if (i >= map.cnt)
+			break;
+
 		descr->key_lens[i] = 0;
 		len = bpf_probe_read_str(payload, STROBE_MAX_STR_LEN,
 					 map.entries[i].key);
-- 
2.17.1

