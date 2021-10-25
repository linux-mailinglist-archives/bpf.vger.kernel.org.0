Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E648A43A6CD
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhJYWsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Oct 2021 18:48:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234275AbhJYWsG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:48:06 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiXkc028915
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4fm0g6v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:44 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:45:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 59F4874E664E; Mon, 25 Oct 2021 15:45:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] libbpf: deprecate ambiguously-named bpf_program__size() API
Date:   Mon, 25 Oct 2021 15:45:31 -0700
Message-ID: <20211025224531.1088894-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025224531.1088894-1-andrii@kernel.org>
References: <20211025224531.1088894-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: AC3fdgfdzLVkZ-i7d5eqinF2fKxr-2XX
X-Proofpoint-ORIG-GUID: AC3fdgfdzLVkZ-i7d5eqinF2fKxr-2XX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The name of the API doesn't convey clearly that this size is in number
of bytes (there needed to be a separate comment to make this clear in
libbpf.h). Further, measuring the size of BPF program in bytes is not
exactly the best fit, because BPF programs always consist of 8-byte
instructions. As such, bpf_program__insn_cnt() is a better alternative
in pretty much any imaginable case.

So schedule bpf_program__size() deprecation starting from v0.7 and it
will be removed in libbpf 1.0.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 449eeed80be6..e1900819bfab 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -224,6 +224,7 @@ LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 
 /* returns program size in bytes */
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_program__insn_cnt() instead")
 LIBBPF_API size_t bpf_program__size(const struct bpf_program *prog);
 
 struct bpf_insn;
-- 
2.30.2

