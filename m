Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99776475CE
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLHS5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Dec 2022 13:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLHS5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:57:19 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EFB7A192
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 10:57:18 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8IYtCt011080
        for <bpf@vger.kernel.org>; Thu, 8 Dec 2022 10:57:18 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mbgeyafj9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 10:57:18 -0800
Received: from twshared4568.42.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 10:57:17 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E3FE9231D99AC; Thu,  8 Dec 2022 10:57:11 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        =?UTF-8?q?Per=20Sundstr=C3=B6m=20XP?= 
        <per.xp.sundstrom@ericsson.com>
Subject: [PATCH bpf-next 2/6] libbpf: handle non-standardly sized enums better in BTF-to-C dumper
Date:   Thu, 8 Dec 2022 10:56:59 -0800
Message-ID: <20221208185703.2681797-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221208185703.2681797-1-andrii@kernel.org>
References: <20221208185703.2681797-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 13P-w87LpY6vbx_dzKS8WI4RUEhcMAo5
X-Proofpoint-GUID: 13P-w87LpY6vbx_dzKS8WI4RUEhcMAo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out C allows to force enum to be 1-byte or 8-byte explicitly using
mode(byte) or mode(word), respecticely. Linux sources are using this in
some cases. This is imporant to handle correctly, as enum size
determines corresponding fields in a struct that use that enum type. And
if enum size is incorrect, this will lead to invalid struct layout. So
add mode(byte) and mode(word) attribute support to btf_dump APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 69e80ee5f70e..234e82334d56 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -13,6 +13,7 @@
 #include <ctype.h>
 #include <endian.h>
 #include <errno.h>
+#include <limits.h>
 #include <linux/err.h>
 #include <linux/btf.h>
 #include <linux/kernel.h>
@@ -1076,6 +1077,43 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
 	else
 		btf_dump_emit_enum64_val(d, t, lvl, vlen);
 	btf_dump_printf(d, "\n%s}", pfx(lvl));
+
+	/* special case enums with special sizes */
+	if (t->size == 1) {
+		/* one-byte enums can be forced with mode(byte) attribute */
+		btf_dump_printf(d, " __attribute__((mode(byte)))");
+	} else if (t->size == 8 && d->ptr_sz == 8) {
+		/* enum can be 8-byte sized if one of the enumerator values
+		 * doesn't fit in 32-bit integer, or by adding mode(word)
+		 * attribute (but probably only on 64-bit architectures); do
+		 * our best here to try to satisfy the contract without adding
+		 * unnecessary attributes
+		 */
+		bool needs_word_mode;
+
+		if (btf_is_enum(t)) {
+			/* enum can't represent 64-bit values, so we need word mode */
+			needs_word_mode = true;
+		} else {
+			/* enum64 needs mode(word) if none of its values has
+			 * non-zero upper 32-bits (which means that all values
+			 * fit in 32-bit integers and won't cause compiler to
+			 * bump enum to be 64-bit naturally
+			 */
+			int i;
+
+			needs_word_mode = true;
+			for (i = 0; i < vlen; i++) {
+				if (btf_enum64(t)[i].val_hi32 != 0) {
+					needs_word_mode = false;
+					break;
+				}
+			}
+		}
+		if (needs_word_mode)
+			btf_dump_printf(d, " __attribute__((mode(word)))");
+	}
+
 }
 
 static void btf_dump_emit_fwd_def(struct btf_dump *d, __u32 id,
-- 
2.30.2

