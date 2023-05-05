Return-Path: <bpf+bounces-61-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A166F79F1
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ABE1C21624
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7ED1108;
	Fri,  5 May 2023 00:09:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B5EA1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:09:44 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA51328B
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:09:42 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344KWgj2010503
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:09:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qc1uagcs1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:09:41 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:25 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 55AE33002F95A; Thu,  4 May 2023 17:09:20 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 02/10] bpf: mark relevant stack slots scratched for register read instructions
Date: Thu, 4 May 2023 17:09:00 -0700
Message-ID: <20230505000908.1265044-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4Ws40p0x-XhT0DjU1OXOkkfAod4jjo1x
X-Proofpoint-GUID: 4Ws40p0x-XhT0DjU1OXOkkfAod4jjo1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When handling instructions that read register slots, mark relevant stack
slots as scratched so that verifier log would contain those slots' states=
, in
addition to currently emitted registers with stack slot offsets.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff4a8ab99f08..da8a5834f2ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4109,6 +4109,7 @@ static void mark_reg_stack_read(struct bpf_verifier=
_env *env,
 	for (i =3D min_off; i < max_off; i++) {
 		slot =3D -i - 1;
 		spi =3D slot / BPF_REG_SIZE;
+		mark_stack_slot_scratched(env, spi);
 		stype =3D ptr_state->stack[spi].slot_type;
 		if (stype[slot % BPF_REG_SIZE] !=3D STACK_ZERO)
 			break;
@@ -4160,6 +4161,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
=20
+	mark_stack_slot_scratched(env, spi);
+
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size =3D 1;
=20
--=20
2.34.1


