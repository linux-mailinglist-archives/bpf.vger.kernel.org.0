Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637946EEDB5
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 07:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbjDZFwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 01:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbjDZFwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 01:52:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194F35A5
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 22:51:22 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33PLEBiC029814
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 22:50:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=tJnajU+Jz86XuoMF0oxH1SvcFv814dqn6gmj/gVMaGc=;
 b=nncXmkGjR2361DgturLu+ILuT/xWgiIXNH2c6mjXkCy31sKR1lie9xImWvD4C34W1jlE
 qM9mXHsu+uO/DeK+hCWYToxO1bYrB7sYopzuMcN0yFMrs1P1mOh5fwaJFcK/Xr4P5kE8
 0cfl1hHncVD6+Gx+uJ8x4qQuivy8hModfEw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3q6mgtkceq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 22:50:43 -0700
Received: from twshared21760.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 22:50:42 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BFA441E3161DB; Tue, 25 Apr 2023 22:50:30 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH dwarves] btf_encoder: Fix a dwarf type DW_ATE_unsigned_1024 to btf encoding issue
Date:   Tue, 25 Apr 2023 22:50:30 -0700
Message-ID: <20230426055030.3743074-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ijh5VhQOlzkWlqX4bpIb1i8FfMx4JBfY
X-Proofpoint-ORIG-GUID: Ijh5VhQOlzkWlqX4bpIb1i8FfMx4JBfY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_02,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Nick Desaulniers reported an issue ([1]) where an 128-byte sized type
(DW_ATE_unsigned_1024) cannot be encoded into BTF with failure message
likes below:
  $ pahole -J reduced.o
  [2] INT DW_ATE_unsigned_1024 Error emitting BTF type
  Encountered error while encoding BTF.
See [1] for how to reproduce the issue.

The failure is due to currently BTF int type only supports upto 16
bytes (__int128) and in this case the dwarf int type is 128-byte.

The DW_ATE_unsigned_1024 is not a normal type for variable/func
declaration etc. It is used in DW_AT_location. There are two
ways to resolve this issue.
  (1). If btf encoding is expected, remove all dwarf int types
       where btf encoding will failure, e.g., non-power-of-2
       bytes, or greater than 16 bytes.
  (2). do a sanitization in btf_encoder ([2]).

This patch uses method (2) since it is a simple fix in btf_encoder.
I checked my local built vmlinux with latest
bpf-next. There is only one instance of DW_ATE_unsigned_24 (used in
DW_AT_location) so I expect irregular int types should be very rare.

  [1] https://github.com/libbpf/libbpf/pull/680
  [2] commit 7d8e829f636f ("btf_encoder: Sanitize non-regular int base type=
")

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..1aa0ad0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -394,7 +394,7 @@ static int32_t btf_encoder__add_base_type(struct btf_en=
coder *encoder, const str
 	 * these non-regular int types to avoid libbpf/kernel complaints.
 	 */
 	byte_sz =3D BITS_ROUNDUP_BYTES(bt->bit_size);
-	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
+	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
 		name =3D "__SANITIZED_FAKE_INT__";
 		byte_sz =3D 4;
 	}
--=20
2.34.1

