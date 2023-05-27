Return-Path: <bpf+bounces-1355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB4713705
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 00:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009E21C20972
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB21950F;
	Sat, 27 May 2023 22:31:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829E9461
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 22:31:53 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC966AD
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:50 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34RLpfIw021540
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=1qrbeJ2GL7XL/nULCOKYhA2QYagKiO03oh+rYV9guk4=;
 b=m5VKI08FB7j0DEoqpD2gh0dsRZIDJWHamXglEXPQvAhOm+jYzbpPKwLeThxKptP8vO7o
 m3ADDncJ6u7mCISr1Lg1XlchjAKneuGYiSGPnJAT1XyrlBslIVcH2MMevSDhrAtjIWWU
 MA6Z4N0PYmjMqnoSvPygLjEUuZlSUrSWbjU= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qudca35y4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 15:31:49 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 15:31:47 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AEDD4205845FC; Sat, 27 May 2023 15:31:32 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>,
        <syzbot+958967f249155967d42a@syzkaller.appspotmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Silence a warning in btf_type_id_size()
Date: Sat, 27 May 2023 15:31:32 -0700
Message-ID: <20230527223132.1580338-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eDkDGaMBqjnex4fjpineTjgLb43Vc-WK
X-Proofpoint-ORIG-GUID: eDkDGaMBqjnex4fjpineTjgLb43Vc-WK
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_16,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a warning in [1] with the following stacktrace:
  WARNING: CPU: 0 PID: 5005 at kernel/bpf/btf.c:1988 btf_type_id_size+0x2d9=
/0x9d0 kernel/bpf/btf.c:1988
  ...
  RIP: 0010:btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
  ...
  Call Trace:
   <TASK>
   map_check_btf kernel/bpf/syscall.c:1024 [inline]
   map_create+0x1157/0x1860 kernel/bpf/syscall.c:1198
   __sys_bpf+0x127f/0x5420 kernel/bpf/syscall.c:5040
   __do_sys_bpf kernel/bpf/syscall.c:5162 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5160 [inline]
   __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5160
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

With the following btf
  [1] DECL_TAG 'a' type_id=3D4 component_idx=3D-1
  [2] PTR '(anon)' type_id=3D0
  [3] TYPE_TAG 'a' type_id=3D2
  [4] VAR 'a' type_id=3D3, linkage=3Dstatic
and when the bpf_attr.btf_key_type_id =3D 1 (DECL_TAG),
the following WARN_ON_ONCE in btf_type_id_size() is triggered:
  if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
                   !btf_type_is_var(size_type)))
          return NULL;

Note that 'return NULL' is the correct behavior as we don't want
a DECL_TAG type to be used as a btf_{key,value}_type_id even
for the case like 'DECL_TAG -> STRUCT'. So there
is no correctness issue here, we just want to silence warning.

To silence the warning, I added DECL_TAG as one of kinds in
btf_type_nosize() which will cause btf_type_id_size() returning
NULL earlier without the warning.

  [1] https://lore.kernel.org/bpf/000000000000e0df8d05fc75ba86@google.com/

Reported-by: syzbot+958967f249155967d42a@syzkaller.appspotmail.com
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 947f0b83bfad..bd2cac057928 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -492,25 +492,26 @@ static bool btf_type_is_fwd(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_FWD;
 }
=20
-static bool btf_type_nosize(const struct btf_type *t)
+static bool btf_type_is_datasec(const struct btf_type *t)
 {
-	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
-	       btf_type_is_func(t) || btf_type_is_func_proto(t);
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
 }
=20
-static bool btf_type_nosize_or_null(const struct btf_type *t)
+static bool btf_type_is_decl_tag(const struct btf_type *t)
 {
-	return !t || btf_type_nosize(t);
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DECL_TAG;
 }
=20
-static bool btf_type_is_datasec(const struct btf_type *t)
+static bool btf_type_nosize(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DATASEC;
+	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
+	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
+	       btf_type_is_decl_tag(t);
 }
=20
-static bool btf_type_is_decl_tag(const struct btf_type *t)
+static bool btf_type_nosize_or_null(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_DECL_TAG;
+	return !t || btf_type_nosize(t);
 }
=20
 static bool btf_type_is_decl_tag_target(const struct btf_type *t)
--=20
2.34.1


