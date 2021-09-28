Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633EB41B495
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhI1Q6a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:58:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241927AbhI1Q63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:58:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18SD7xwM010748
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:49 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3bc3nj1vys-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:49 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:56:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D920550F9B97; Tue, 28 Sep 2021 09:20:40 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 bpf-next 01/10] libbpf: add "tc" SEC_DEF which is a better name for "classifier"
Date:   Tue, 28 Sep 2021 09:19:37 -0700
Message-ID: <20210928161946.2512801-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
References: <20210928161946.2512801-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 959BWI7s3KWkPg2L0fF9VQVYJTxivfJG
X-Proofpoint-GUID: 959BWI7s3KWkPg2L0fF9VQVYJTxivfJG
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As argued in [0], add "tc" ELF section definition for SCHED_CLS BPF
program type. "classifier" is a misleading terminology and should be
migrated away from.

  [0] https://lore.kernel.org/bpf/270e27b1-e5be-5b1c-b343-51bd644d0747@iogearbox.net/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 453148fe8b4b..0bcd0a4c867a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7968,6 +7968,7 @@ static const struct bpf_sec_def section_defs[] = {
 		.attach_fn = attach_kprobe),
 	BPF_PROG_SEC("uretprobe/",		BPF_PROG_TYPE_KPROBE),
 	BPF_PROG_SEC("classifier",		BPF_PROG_TYPE_SCHED_CLS),
+	BPF_PROG_SEC("tc",			BPF_PROG_TYPE_SCHED_CLS),
 	BPF_PROG_SEC("action",			BPF_PROG_TYPE_SCHED_ACT),
 	SEC_DEF("tracepoint/", TRACEPOINT,
 		.attach_fn = attach_tp),
-- 
2.30.2

