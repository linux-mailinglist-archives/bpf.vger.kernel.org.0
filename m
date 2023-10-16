Return-Path: <bpf+bounces-12334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F337CB285
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C591C20AFF
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AD339AD;
	Mon, 16 Oct 2023 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262C31A70
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 18:28:54 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD0BAC
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:28:53 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GIAZuP010281
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:28:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts86x9aes-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:28:52 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:28:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 11F7539DA1C80; Mon, 16 Oct 2023 11:28:42 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Hengqi Chen
	<hengqi.chen@gmail.com>,
        Liam Wisehart <liamwisehart@meta.com>
Subject: [PATCH bpf-next] libbpf: don't assume SHT_GNU_verdef presence for SHT_GNU_versym section
Date: Mon, 16 Oct 2023 11:28:40 -0700
Message-ID: <20231016182840.4033346-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qrO2uuSqP7MiJJJwlhnv5r7qMxo8JEbD
X-Proofpoint-ORIG-GUID: qrO2uuSqP7MiJJJwlhnv5r7qMxo8JEbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix too eager assumption that SHT_GNU_verdef ELF section is going to be
present whenever binary has SHT_GNU_versym section. It seems like either
SHT_GNU_verdef or SHT_GNU_verneed can be used, so failing on missing
SHT_GNU_verdef actually breaks use cases in production.

One specific reported issue, which was used to manually test this fix,
was trying to attach to `readline` function in BASH binary.

Cc: Hengqi Chen <hengqi.chen@gmail.com>
Reported-by: Liam Wisehart <liamwisehart@meta.com>
Fixes: bb7fa09399b9 ("libbpf: Support symbol versioning for uprobe")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/elf.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 2a158e8a8b7c..2a62bf411bb3 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -141,14 +141,15 @@ static int elf_sym_iter_new(struct elf_sym_iter *it=
er,
 	iter->versyms =3D elf_getdata(scn, 0);
=20
 	scn =3D elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
-	if (!scn) {
-		pr_debug("elf: failed to find verdef ELF sections in '%s'\n", binary_p=
ath);
-		return -ENOENT;
-	}
-	if (!gelf_getshdr(scn, &sh))
+	if (!scn)
+		return 0;
+
+	iter->verdefs =3D elf_getdata(scn, 0);
+	if (!iter->verdefs || !gelf_getshdr(scn, &sh)) {
+		pr_warn("elf: failed to get verdef ELF section in '%s'\n", binary_path=
);
 		return -EINVAL;
+	}
 	iter->verdef_strtabidx =3D sh.sh_link;
-	iter->verdefs =3D elf_getdata(scn, 0);
=20
 	return 0;
 }
@@ -199,6 +200,9 @@ static const char *elf_get_vername(struct elf_sym_ite=
r *iter, int ver)
 	GElf_Verdef verdef;
 	int offset;
=20
+	if (!iter->verdefs)
+		return NULL;
+
 	offset =3D 0;
 	while (gelf_getverdef(iter->verdefs, offset, &verdef)) {
 		if (verdef.vd_ndx !=3D ver) {
--=20
2.34.1


