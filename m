Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA844078D
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhJ3FCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231596AbhJ3FCl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:41 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U500Yh018717
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0qu529wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:12 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CD843783058F; Fri, 29 Oct 2021 22:00:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 09/14] libbpf: remove deprecation attribute from struct bpf_prog_prep_result
Date:   Fri, 29 Oct 2021 21:59:36 -0700
Message-ID: <20211030045941.3514948-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: bcsfkEm56orQZFK_Q527Q-kt8u-OU9fE
X-Proofpoint-ORIG-GUID: bcsfkEm56orQZFK_Q527Q-kt8u-OU9fE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=970 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This deprecation annotation has no effect because for struct deprecation
attribute has to be declared after struct definition. But instead of
moving it to the end of struct definition, remove it. When deprecation
will go in effect at libbpf v0.7, this deprecation attribute will cause
libbpf's own source code compilation to trigger deprecation warnings,
which is unavoidable because libbpf still has to support that API.

So keep deprecation of APIs, but don't mark structs used in API as
deprecated.

Fixes: e21d585cb3db ("libbpf: Deprecate multi-instance bpf_program APIs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e4f0dcd8da6..dc13c34ea9ad 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -431,7 +431,6 @@ bpf_program__attach_iter(const struct bpf_program *prog,
  * one instance. In this case bpf_program__fd(prog) is equal to
  * bpf_program__nth_fd(prog, 0).
  */
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insns() for getting bpf_program instructions")
 struct bpf_prog_prep_result {
 	/*
 	 * If not NULL, load new instruction array.
-- 
2.30.2

