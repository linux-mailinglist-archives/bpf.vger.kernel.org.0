Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5B594F2E
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 05:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiHPDwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 15 Aug 2022 23:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHPDvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 23:51:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC4338F9B
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:20:19 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27FIbuXb008750
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:43 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hysv2jscu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:43 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 17:19:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4148F1DAC7D9D; Mon, 15 Aug 2022 17:19:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: fix potential NULL dereference when parsing ELF
Date:   Mon, 15 Aug 2022 17:19:26 -0700
Message-ID: <20220816001929.369487-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816001929.369487-1-andrii@kernel.org>
References: <20220816001929.369487-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y2wRqr2tIhPKWei3Slg5GTGPzzXashIj
X-Proofpoint-ORIG-GUID: y2wRqr2tIhPKWei3Slg5GTGPzzXashIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix if condition filtering empty ELF sections to prevent NULL
dereference.

Fixes: 47ea7417b074 ("libbpf: Skip empty sections in bpf_object__init_global_data_maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa05a99b913d..5f0281e61437 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1646,7 +1646,7 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 		sec_desc = &obj->efile.secs[sec_idx];
 
 		/* Skip recognized sections with size 0. */
-		if (sec_desc->data && sec_desc->data->d_size == 0)
+		if (!sec_desc->data || sec_desc->data->d_size == 0)
 			continue;
 
 		switch (sec_desc->sec_type) {
-- 
2.30.2

