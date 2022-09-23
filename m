Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9485E862E
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiIWXGQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Sep 2022 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIWXGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:06:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CA1138FA
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:06:13 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM8x3l013545
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:06:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsb1nn0n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:06:13 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 16:06:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8264C1F46384C; Fri, 23 Sep 2022 16:06:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Grant Seltzer Richman <grantseltzer@gmail.com>
Subject: [PATCH bpf-next] libbpf: restore memory layout of bpf_object_open_opts
Date:   Fri, 23 Sep 2022 16:05:59 -0700
Message-ID: <20220923230559.666608-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KsMVC_w8y9GJxtpbouavGkilbk3gSddt
X-Proofpoint-GUID: KsMVC_w8y9GJxtpbouavGkilbk3gSddt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When attach_prog_fd field was removed in libbpf 1.0 and replaced with
`long: 0` placeholder, it actually shifted all the subsequent fields by
8 byte. This is due to `long: 0` promising to adjust next field's offset
to long-aligned offset. But in this case we were already long-aligned
as pin_root_path is a pointer. So `long: 0` had no effect, and thus
didn't feel the gap created by removed attach_prog_fd.

Non-zero bitfield should have been used instead. I validated using
pahole. Originally kconfig field was at offset 40. With `long: 0` it's
at offset 32, which is wrong. With this change it's back at offset 40.

While technically libbpf 1.0 is allowed to break backwards
compatibility and applications should have been recompiled against
libbpf 1.0 headers, but given how trivial it is to preserve memory
layout, let's fix this.

Reported-by: Grant Seltzer Richman <grantseltzer@gmail.com>
Fixes: 146bf811f5ac ("libbpf: remove most other deprecated high-level APIs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e2d8c17f2e85..eee883f007f9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -118,7 +118,9 @@ struct bpf_object_open_opts {
 	 * auto-pinned to that path on load; defaults to "/sys/fs/bpf".
 	 */
 	const char *pin_root_path;
-	long :0;
+
+	__u32 :32; /* stub out now removed attach_prog_fd */
+
 	/* Additional kernel config content that augments and overrides
 	 * system Kconfig for CONFIG_xxx externs.
 	 */
-- 
2.30.2

