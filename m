Return-Path: <bpf+bounces-16767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDD805DC6
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CEE1F21701
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9402CA4;
	Tue,  5 Dec 2023 18:43:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5E10DB
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:43:13 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5IfMc9015699
	for <bpf@vger.kernel.org>; Tue, 5 Dec 2023 10:43:12 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3usxjtn4eg-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:43:11 -0800
Received: from twshared15232.14.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 5 Dec 2023 10:43:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DEBCA3CA16FCF; Tue,  5 Dec 2023 10:42:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 03/10] bpf: fix check for attempt to corrupt spilled pointer
Date: Tue, 5 Dec 2023 10:42:41 -0800
Message-ID: <20231205184248.1502704-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205184248.1502704-1-andrii@kernel.org>
References: <20231205184248.1502704-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nvbxwQefeVeLSrkzr-rZMYtroTNubTly
X-Proofpoint-ORIG-GUID: nvbxwQefeVeLSrkzr-rZMYtroTNubTly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_14,2023-12-05_01,2023-05-22_02

When register is spilled onto a stack as a 1/2/4-byte register, we set
slot_type[BPF_REG_SIZE - 1] (plus potentially few more below it,
depending on actual spill size). So to check if some stack slot has
spilled register we need to consult slot_type[7], not slot_type[0].

To avoid the need to remember and double-check this in the future, just
use is_spilled_reg() helper.

Fixes: 27113c59b6d0 ("bpf: Check the other end of slot_type for STACK_SPI=
LL")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9bc16dc66465..3edca06de9fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4431,7 +4431,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
 	if (!env->allow_ptr_leaks &&
-	    state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
+	    is_spilled_reg(&state->stack[spi]) &&
 	    size !=3D BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
--=20
2.34.1


