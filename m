Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906704E1920
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 01:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiCTAUy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 19 Mar 2022 20:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244441AbiCTAUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 20:20:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290121E39
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 17:19:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22K01UUW006778
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 17:19:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ewap6jwrf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 17:19:24 -0700
Received: from twshared4295.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 17:19:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 582D714943293; Sat, 19 Mar 2022 17:19:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: avoid NULL deref when initializing map BTF info
Date:   Sat, 19 Mar 2022 17:19:11 -0700
Message-ID: <20220320001911.3640917-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yLxOKxip2miB0zy9vSs8lS5S9EcWbDDy
X-Proofpoint-ORIG-GUID: yLxOKxip2miB0zy9vSs8lS5S9EcWbDDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-19_14,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BPF object doesn't have an BTF info, don't attempt to search for BTF
types describing BPF map key or value layout.

Fixes: 262cfb74ffda ("libbpf: Init btf_{key,value}_type_id on internal map open")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7526419e59e0..2efe9431c1ba 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4197,6 +4197,9 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 	__u32 key_type_id = 0, value_type_id = 0;
 	int ret;
 
+	if (!obj->btf)
+		return -ENOENT;
+
 	/* if it's BTF-defined map, we don't need to search for type IDs.
 	 * For struct_ops map, it does not need btf_key_type_id and
 	 * btf_value_type_id.
-- 
2.30.2

