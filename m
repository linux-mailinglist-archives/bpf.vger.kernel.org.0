Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BE6D5795
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDDEhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDDEhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:37:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB52105
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:32 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLVwC030199
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:31 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pr0m74kq6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:31 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4100E2D051964; Mon,  3 Apr 2023 21:37:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 09/19] bpf: avoid incorrect -EFAULT error in BPF_LOG_KERNEL mode
Date:   Mon, 3 Apr 2023 21:36:49 -0700
Message-ID: <20230404043659.2282536-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8A60Heo5KVsmTDdRvCoDqNG-DDLiVrg7
X-Proofpoint-ORIG-GUID: 8A60Heo5KVsmTDdRvCoDqNG-DDLiVrg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If verifier log is in BPF_LOG_KERNEL mode, no log->ubuf is expected and
it stays NULL throughout entire verification process. Don't erroneously
return -EFAULT in such case.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae93d40d0d3b..2d0fe2ccfb1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18794,7 +18794,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	bpf_vlog_finalize(log);
 	if (log->level && bpf_vlog_truncated(log))
 		ret = -ENOSPC;
-	if (log->level && !log->ubuf) {
+	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf) {
 		ret = -EFAULT;
 		goto err_release_maps;
 	}
-- 
2.34.1

