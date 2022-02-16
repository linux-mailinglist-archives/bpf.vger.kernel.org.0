Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C754C4B948B
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 00:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiBPXgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 16 Feb 2022 18:36:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiBPXgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 18:36:07 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A59C2402DB
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 15:35:54 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GMVFiN023163
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 15:35:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n3d8d32-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 15:35:53 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 15:35:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CA9601124BCDC; Wed, 16 Feb 2022 15:35:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpftool: fix C++ additions to skeleton
Date:   Wed, 16 Feb 2022 15:35:40 -0800
Message-ID: <20220216233540.216642-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OMuEf-CadFBccWJiCBuvEPUmqnCZ1BYH
X-Proofpoint-GUID: OMuEf-CadFBccWJiCBuvEPUmqnCZ1BYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_11,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=706 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160127
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark C++-specific T::open() and other methods as static inline to avoid
symbol redefinition when multiple files use the same skeleton header in
an application.

Fixes: bb8ffe61ea45 ("bpftool: Add C++-specific open/load/etc skeleton wrappers")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index e461059a72ee..f8c1413523a3 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -834,13 +834,13 @@ static int do_skeleton(int argc, char **argv)
 		\n\
 									    \n\
 		#ifdef __cplusplus					    \n\
-			static struct %1$s *open(const struct bpf_object_open_opts *opts = nullptr);\n\
-			static struct %1$s *open_and_load();		    \n\
-			static int load(struct %1$s *skel);		    \n\
-			static int attach(struct %1$s *skel);		    \n\
-			static void detach(struct %1$s *skel);		    \n\
-			static void destroy(struct %1$s *skel);		    \n\
-			static const void *elf_bytes(size_t *sz);	    \n\
+			static inline struct %1$s *open(const struct bpf_object_open_opts *opts = nullptr);\n\
+			static inline struct %1$s *open_and_load();	    \n\
+			static inline int load(struct %1$s *skel);	    \n\
+			static inline int attach(struct %1$s *skel);	    \n\
+			static inline void detach(struct %1$s *skel);	    \n\
+			static inline void destroy(struct %1$s *skel);	    \n\
+			static inline const void *elf_bytes(size_t *sz);    \n\
 		#endif /* __cplusplus */				    \n\
 		};							    \n\
 									    \n\
-- 
2.30.2

