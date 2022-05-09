Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E951F25E
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiEIBbD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiEIAp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304F6430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NpBZq023563
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpgw5pm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:06 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 71CA019A4AD12; Sun,  8 May 2022 17:41:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/9] libbpf: complete field-based CO-RE helpers with field offset helper
Date:   Sun, 8 May 2022 17:41:44 -0700
Message-ID: <20220509004148.1801791-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xVSkajYUkcPtJ0iRG4G-7bggQykcWkXX
X-Proofpoint-GUID: xVSkajYUkcPtJ0iRG4G-7bggQykcWkXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_core_field_offset() helper to complete field-based CO-RE
helpers. This helper can be useful for feature-detection and for some
more advanced cases of field reading (e.g., reading flexible array members).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 5ad415f9051f..fd48b1ff59ca 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -143,6 +143,18 @@ enum bpf_enum_value_kind {
 #define bpf_core_field_size(field...)					    \
 	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_BYTE_SIZE)
 
+/*
+ * Convenience macro to get field's byte offset.
+ *
+ * Supports two forms:
+ *   - field reference through variable access:
+ *     bpf_core_field_offset(p->my_field);
+ *   - field reference through type and field names:
+ *     bpf_core_field_offset(struct my_type, my_field).
+ */
+#define bpf_core_field_offset(field...)					    \
+	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_BYTE_OFFSET)
+
 /*
  * Convenience macro to get BTF type ID of a specified type, using a local BTF
  * information. Return 32-bit unsigned integer with type ID from program's own
-- 
2.30.2

