Return-Path: <bpf+bounces-5389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1597B75A300
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB535281AEB
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988A263C6;
	Thu, 20 Jul 2023 00:01:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E5182AD
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:01:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FCAE69
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JNZasD011283
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rsHpgur9uUKjr6xui9gTgQ+66JXUF/mLiE1PIW5ubpY=;
 b=Vb9E4h/idML7OkJBR1zoHF0hHm9ghWCQB98WqyDNZvrV6UFpPZO4Ykw/Op3fTpLHzlZO
 fqlxQyKVWx9YlHr511ur4FLgM0u6uSLTFEt7yeulv/Il5I64FwlAcPAEXw2l1fSUTbQt
 MGZKOFoAgJECNDNNeJp+VPet7vsrR7psHC4= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbxnpm0r-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:01:40 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6C9D72354E7EA; Wed, 19 Jul 2023 17:01:19 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 03/17] bpf: Handle sign-extenstin ctx member accesses
Date: Wed, 19 Jul 2023 17:01:19 -0700
Message-ID: <20230720000119.103561-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ViHCoHL4IDMVLDPm-ISfZqdOGMDE4dDP
X-Proofpoint-GUID: ViHCoHL4IDMVLDPm-ISfZqdOGMDE4dDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, if user accesses a ctx member with signed types,
the compiler will generate an unsigned load followed by
necessary left and right shifts.

With the introduction of sign-extension load, compiler may
just emit a ldsx insn instead. Let us do a final movsx sign
extension to the final unsigned ctx load result to
satisfy original sign extension requirement.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc82b5e77cbe..b9be8706bf48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17716,6 +17716,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		u8 mode;
=20
 		if (insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code =3D=3D (BPF_LDX | BPF_MEM | BPF_H) ||
@@ -17797,6 +17798,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
=20
 		ctx_field_size =3D env->insn_aux_data[i + delta].ctx_field_size;
 		size =3D BPF_LDST_BYTES(insn);
+		mode =3D BPF_MODE(insn->code);
=20
 		/* If the read access is a narrower load of the field,
 		 * convert to a 4/8-byte load, to minimum program type specific
@@ -17856,6 +17858,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
 								(1ULL << size * 8) - 1);
 			}
 		}
+		if (mode =3D=3D BPF_MEMSX)
+			insn_buf[cnt++] =3D BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
+						       insn->dst_reg, insn->dst_reg,
+						       size * 8, 0);
=20
 		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
--=20
2.34.1


