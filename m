Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5923C4B1CB6
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 03:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347498AbiBKCtt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 10 Feb 2022 21:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbiBKCts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 21:49:48 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AB2115D
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 18:49:48 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrO3X013953
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 18:49:47 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58e1jw8r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 18:49:47 -0800
Received: from twshared7500.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 18:49:45 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BAD4E29EE530B; Thu, 10 Feb 2022 18:49:41 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <sfr@canb.auug.org.au>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next] bpf: fix bpf_prog_pack build for ppc64_defconfig
Date:   Thu, 10 Feb 2022 18:49:39 -0800
Message-ID: <20220211024939.2962537-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FmbKSJLmphuyTPgx7qBb3j4L-oI7lQAx
X-Proofpoint-ORIG-GUID: FmbKSJLmphuyTPgx7qBb3j4L-oI7lQAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110011
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

bpf_prog_pack causes build error with powerpc ppc64_defconfig:

kernel/bpf/core.c:830:23: error: variably modified 'bitmap' at file scope
  830 |         unsigned long bitmap[BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)];
      |                       ^~~~~~

This is because the marco expands as:

unsigned long bitmap[((((((1UL) << (16 + __pte_index_size)) / (1 << 6))) \
     + ((sizeof(long) * 8)) - 1) / ((sizeof(long) * 8)))];

where __pte_index_size is a global variable.

Fix it by turning bitmap into a 0-length array.

Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Song Liu <song@kernel.org>

---
v2: add information about the build failure.
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 42d96549a804..44623c9b5bb1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -827,7 +827,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
-	unsigned long bitmap[BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)];
+	unsigned long bitmap[];
 };
 
 #define BPF_PROG_MAX_PACK_PROG_SIZE	BPF_PROG_PACK_SIZE
@@ -840,7 +840,7 @@ static struct bpf_prog_pack *alloc_new_pack(void)
 {
 	struct bpf_prog_pack *pack;
 
-	pack = kzalloc(sizeof(*pack), GFP_KERNEL);
+	pack = kzalloc(sizeof(*pack) + BITS_TO_BYTES(BPF_PROG_CHUNK_COUNT), GFP_KERNEL);
 	if (!pack)
 		return NULL;
 	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
-- 
2.30.2

