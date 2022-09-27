Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7C5EB937
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 06:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiI0EaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 27 Sep 2022 00:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0E37 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 00:29:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1557EDFAC
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:29:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QLVicd019416
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:29:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jum2s9vdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:29:55 -0700
Received: from twshared46966.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:29:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 74CF41F65CC82; Mon, 26 Sep 2022 21:29:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH bpf-next 1/2] libbpf: don't require full struct enum64 in UAPI headers
Date:   Mon, 26 Sep 2022 21:29:39 -0700
Message-ID: <20220927042940.147185-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: HipMKHEsHz2GBGrK-XSoX6iRIAt1c1fU
X-Proofpoint-ORIG-GUID: HipMKHEsHz2GBGrK-XSoX6iRIAt1c1fU
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop the requirement for system-wide kernel UAPI headers to provide full
struct btf_enum64 definition. This is an unexpected requirement that
slipped in libbpf 1.0 and put unnecessary pressure ([0]) on users to have
a bleeding-edge kernel UAPI header from unreleased Linux 6.0.

To achieve this, we forward declare struct btf_enum64. But that's not
enough as there is btf_enum64_value() helper that expects to know the
layout of struct btf_enum64. So we get a bit creative with
reinterpreting memory layout as array of __u32 and accesing lo32/hi32
fields as array elements. Alternative way would be to have a local
pointer variable for anonymous struct with exactly the same layout as
struct btf_enum64, but that gets us into C++ compiler errors complaining
about invalid type casts. So play it safe, if ugly.

  [0] Closes: https://github.com/libbpf/libbpf/issues/562

Reported-by: Toke Høiland-Jørgensen <toke@toke.dk>
Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ae543144ee30..8e6880d91c84 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -486,6 +486,8 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
 
+struct btf_enum64;
+
 static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
 {
 	return (struct btf_enum64 *)(t + 1);
@@ -493,7 +495,28 @@ static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
 
 static inline __u64 btf_enum64_value(const struct btf_enum64 *e)
 {
-	return ((__u64)e->val_hi32 << 32) | e->val_lo32;
+	/* struct btf_enum64 is introduced in Linux 6.0, which is very
+	 * bleeding-edge. Here we are avoiding relying on struct btf_enum64
+	 * definition coming from kernel UAPI headers to support wider range
+	 * of system-wide kernel headers.
+	 *
+	 * Given this header can be also included from C++ applications, that
+	 * further restricts C tricks we can use (like using compatible
+	 * anonymous struct). So just treat struct btf_enum64 as
+	 * a three-element array of u32 and access second (lo32) and third
+	 * (hi32) elements directly.
+	 *
+	 * For reference, here is a struct btf_enum64 definition:
+	 *
+	 * const struct btf_enum64 {
+	 *	__u32	name_off;
+	 *	__u32	val_lo32;
+	 *	__u32	val_hi32;
+	 * };
+	 */
+	const __u32 *e64 = (const __u32 *)e;
+
+	return ((__u64)e64[2] << 32) | e64[1];
 }
 
 static inline struct btf_member *btf_members(const struct btf_type *t)
-- 
2.30.2

