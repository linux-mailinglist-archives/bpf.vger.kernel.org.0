Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0EB40B581
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhINRBd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Sep 2021 13:01:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61623 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhINRBd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:01:33 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG21sM002101
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 10:00:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2jmm4e7g-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 10:00:15 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:00:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2F3B540712A4; Tue, 14 Sep 2021 10:00:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <linux-perf-users@vger.kernel.org>, <acme@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH perf] perf: ignore deprecation warning when using libbpf's btf__get_from_id()
Date:   Tue, 14 Sep 2021 10:00:04 -0700
Message-ID: <20210914170004.4185659-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: rYwrLtcGAslNOOaqjF9U9ScWgUz0p76s
X-Proofpoint-ORIG-GUID: rYwrLtcGAslNOOaqjF9U9ScWgUz0p76s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=929
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Perf code re-implements libbpf's btf__load_from_kernel_by_id() API as
a weak function, presumably to dynamically link against old version of
libbpf shared library. Unfortunately this causes compilation warning
when perf is compiled against libbpf v0.6+.

For now, just ignore deprecation warning, but there might be a better
solution, depending on perf's needs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf-event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 683f6d63560e..1a7112a87736 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -24,7 +24,10 @@
 struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
 {
        struct btf *btf;
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        int err = btf__get_from_id(id, &btf);
+#pragma GCC diagnostic pop
 
        return err ? ERR_PTR(err) : btf;
 }
-- 
2.30.2

