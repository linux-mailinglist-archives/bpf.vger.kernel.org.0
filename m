Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6016E55B7
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDRAWQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Apr 2023 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDRAWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:22:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B404C21
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:07 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLHqhR012311
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q1c681f6k-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 17:22:07 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 17:22:04 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 17:22:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BE7802E4F357A; Mon, 17 Apr 2023 17:21:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/6] libbpf: report vmlinux vs module name when dealing with ksyms
Date:   Mon, 17 Apr 2023 17:21:44 -0700
Message-ID: <20230418002148.3255690-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418002148.3255690-1-andrii@kernel.org>
References: <20230418002148.3255690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ECRaSeiHSYmMf4IDSpliBUJu8qkR6Fjz
X-Proofpoint-GUID: ECRaSeiHSYmMf4IDSpliBUJu8qkR6Fjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently libbpf always reports "kernel" as a source of ksym BTF type,
which is ambiguous given ksym's BTF can come from either vmlinux or
kernel module BTFs. Make this explicit and log module name, if used BTF
is from kernel module.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a382ed3586bd..0a11563067b3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7538,8 +7538,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
 					kern_btf, kfunc_proto_id);
 	if (ret <= 0) {
-		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with kernel [%d]\n",
-			ext->name, local_func_proto_id, kfunc_proto_id);
+		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
+			ext->name, local_func_proto_id,
+			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
 		return -EINVAL;
 	}
 
@@ -7573,8 +7574,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	 * {kernel_btf_id, kernel_btf_obj_fd} -> fixup ld_imm64.
 	 */
 	ext->ksym.kernel_btf_obj_fd = mod_btf ? mod_btf->fd : 0;
-	pr_debug("extern (func ksym) '%s': resolved to kernel [%d]\n",
-		 ext->name, kfunc_id);
+	pr_debug("extern (func ksym) '%s': resolved to %s [%d]\n",
+		 ext->name, mod_btf ? mod_btf->name : "vmlinux", kfunc_id);
 
 	return 0;
 }
-- 
2.34.1

