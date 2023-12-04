Return-Path: <bpf+bounces-16659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994408042A6
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5545128141B
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3835F17;
	Mon,  4 Dec 2023 23:40:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF1C3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:39:57 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGrmH007860
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:57 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3us6mcg0kq-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:57 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id ED0A23C9725F0; Mon,  4 Dec 2023 15:39:42 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 04/13] bpf: use bitfields for simple per-subprog bool flags
Date: Mon, 4 Dec 2023 15:39:22 -0800
Message-ID: <20231204233931.49758-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3ot_hw_DCAVimG0HiN8I5viRvkym_Ac4
X-Proofpoint-ORIG-GUID: 3ot_hw_DCAVimG0HiN8I5viRvkym_Ac4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

We have a bunch of bool flags for each subprog. Instead of wasting bytes
for them, use bitfields instead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3378cc753061..78d3f93b3802 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -579,12 +579,12 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
-	bool has_tail_call;
-	bool tail_call_reachable;
-	bool has_ld_abs;
-	bool is_cb;
-	bool is_async_cb;
-	bool is_exception_cb;
+	bool has_tail_call: 1;
+	bool tail_call_reachable: 1;
+	bool has_ld_abs: 1;
+	bool is_cb: 1;
+	bool is_async_cb: 1;
+	bool is_exception_cb: 1;
 };
=20
 struct bpf_verifier_env;
--=20
2.34.1


