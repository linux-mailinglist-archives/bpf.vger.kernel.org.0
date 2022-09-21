Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5335C049A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiIUQty convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Sep 2022 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIUQt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 12:49:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B410FDC
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LFUc55006436
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jqm806rxw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:08 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:43:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0106F1F2B4F95; Wed, 21 Sep 2022 09:42:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/4] selftests/bpf: fix double bpf_object__close() in veristate
Date:   Wed, 21 Sep 2022 09:42:51 -0700
Message-ID: <20220921164254.3630690-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921164254.3630690-1-andrii@kernel.org>
References: <20220921164254.3630690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -hEA8ox7XWTN8YSEcSbWbfWn6OOi8Rwm
X-Proofpoint-GUID: -hEA8ox7XWTN8YSEcSbWbfWn6OOi8Rwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__close(obj) is called twice for BPF object files with single
BPF program in it. This causes crash. Fix this by not calling
bpf_object__close() unnecessarily.

Fixes: c8bc5e050976 ("selftests/bpf: Add veristat tool for mass-verifying BPF object files")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 39e6dc41e504..c0c8a65cda52 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -300,7 +300,6 @@ static int process_obj(const char *filename)
 		prog = bpf_object__next_program(obj, NULL);
 		bpf_program__set_autoload(prog, true);
 		process_prog(filename, obj, prog);
-		bpf_object__close(obj);
 		goto cleanup;
 	}
 
-- 
2.30.2

