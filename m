Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6957862E541
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 20:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiKQT2s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Nov 2022 14:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbiKQT2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 14:28:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C356D49
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 11:28:41 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AHGgmgn014544
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 11:28:40 -0800
Received: from maileast.thefacebook.com ([163.114.130.8])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kwnf4b794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 11:28:40 -0800
Received: from twshared18648.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 11:28:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9989921F092FD; Thu, 17 Nov 2022 11:28:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: ignore hashmap__find() result explicitly in btf_dump
Date:   Thu, 17 Nov 2022 11:28:24 -0800
Message-ID: <20221117192824.4093553-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EVCWU_JzKR04Cjv3yYqL1Q8EBXrf9yXR
X-Proofpoint-ORIG-GUID: EVCWU_JzKR04Cjv3yYqL1Q8EBXrf9yXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Coverity is reporting that btf_dump_name_dups() doesn't check return
result of hashmap__find() call. This is intentional, so make it explicit
with (void) cast.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e9f849d82124..deb2bc9a0a7b 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1543,7 +1543,7 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 	if (!new_name)
 		return 1;
 
-	hashmap__find(name_map, orig_name, &dup_cnt);
+	(void)hashmap__find(name_map, orig_name, &dup_cnt);
 	dup_cnt++;
 
 	err = hashmap__set(name_map, new_name, dup_cnt, &old_name, NULL);
-- 
2.30.2

