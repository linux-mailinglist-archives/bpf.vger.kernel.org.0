Return-Path: <bpf+bounces-78717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC7D19101
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80AC43012CE3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08A38E120;
	Tue, 13 Jan 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WY+8iWrK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295693904E9;
	Tue, 13 Jan 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310129; cv=none; b=hFFfkKCtgZUkFA1e2PbaIrhIlGGsDvTABwvki8Ym06ZRr2QNnQHvmLKcBIukKWIdooJBY6sQrqekBhyrZhKolU1y1eZvzK7kgi53dNwEicHRPRoavGhGbMEHzaDf60PKV3c5kV+nywW0Q1StAd/YQSeXY1MQ+eHJ2mgLpEmRv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310129; c=relaxed/simple;
	bh=gSgr9AsK4TLB1GD6GHIOgrxa4Us48el8QYI73mNZIlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdh3n5R3DVM03ZcuTAMsELKtw0NWTMexxIOHWzVCf8+3sldd1f59ODfQgq2+ToXWNqkezmNPrQroQxtNpQ/v6OZYCqM87hyhKUTpR1i2UtRES+Z94TAlqdtBt7YrPtipe3XH6v0s0fPx7+dLzLKqt1w/RSgmvQgHaDSwCwLEFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WY+8iWrK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gb8A2419350;
	Tue, 13 Jan 2026 13:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YigUe
	dpHj4HipUvS1qhzwsSWiemK1EFEHowxNZ/ri0c=; b=WY+8iWrKAtS7L9Snc+ucq
	g0kWVCqr5w6LapT56qSrMOCcGfrVKwrFselUXpT61/NLbM0n09gyshNr2kEkLZ2P
	FcepfOSspsErh/8MX45+I55THNhiCBisWb27YNDC3mBmZdmoXmODn6Bcn6wEvMVy
	Mmm6Fkn4L+DeIykzQtMKTVpOYTfiq9IXKUXNVVaM+KxKTnIawe7+WOkU7EcO7ouJ
	sVvCUysmK9xZuvnS/9ts4MG1zobtmoZN2sDd0j9DdSwIPY+CyTAcKQ5SImvCY9od
	4Xf9w0V5Lj0m6imBWROd/zFv722iSCtAaHVPJ/1ix8NXhfSbRAkacOO1XzV6xqrD
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3ucmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:14:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DCdwdj004128;
	Tue, 13 Jan 2026 13:14:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-89.vpn.oracle.com [10.154.50.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7jg7a6-5;
	Tue, 13 Jan 2026 13:14:19 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH dwarves 4/4] btf_encoder: Prefer strong function definitions for BTF generation
Date: Tue, 13 Jan 2026 13:13:52 +0000
Message-ID: <20260113131352.2395024-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260113131352.2395024-1-alan.maguire@oracle.com>
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130111
X-Proofpoint-ORIG-GUID: bB72-oMBDaf8vJLG0yZlKBYVW--fm2Ee
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6966452c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=Rn5cwJFN9IqfuWfXOtwA:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExMSBTYWx0ZWRfX92ENU3MT+Fd+
 ZWp+yYyrrlswl9XkljGW6CPTLritrP1EFQADFMcImAdIl9bSkRz6V7D+au6pQz2o33cHP6/0C7g
 twhdBnh8lomBiiyADX9+JqpyBumx/PKk6vF3/PZ2Z9xTdoThDdZFqWk5it4300+YikB9CA3VFt8
 5Ap8Aa2AD0eI8RYT8hVCFchy7HHSD8cfMQtIJ8pyhvpq6Lts2VTMDkQefOB1rG952YZBokcxD90
 CEqRwvOQVS9+RgVW9Inh+jZu3FkjV8FRROL4gpZ6rJN4tSPJC6daIeU4TrBcrlBoT8Nh/RXsigB
 BxIxRx5Qwde8ixH3I2SfiJpd+G+pYsBqe5DuV8+irFC1y2OOG1bjJEhWWVvv2HbxJfxKOpBKK/9
 pXcUXdlM3kMrVzYLCj09xrnUppBHsfX8QZMEc1qq0oxaXnm0yvWCLw3BylcSryzfmhJ4WSgRZtO
 7jUjBkWKeR5ZerZ8pCjlcVAWaGgGWY/Atp60ZIlc=
X-Proofpoint-GUID: bB72-oMBDaf8vJLG0yZlKBYVW--fm2Ee

From: Matt Bobrowski <mattbobrowski@google.com>

Currently, when a function has both a weak and a strong definition
across different compilation units (CUs), the BTF encoder arbitrarily
selects one to generate the BTF entry. This selection fundamentally is
dependent on the order in which pahole processes the CUs.

This indifference often leads to a mismatch where the generated BTF
reflects the weak definition's prototype, even though the linker
selected the strong definition for the final vmlinux binary.

A notable example described in [0] involving function
bpf_lsm_mmap_file(). Both weak and strong definitions exist,
distinguished only by parameter names (e.g., file vs
file__nullable). While the strong definition is linked into the
vmlinux object, the generated BTF contained the prototype for the weak
definition. This causes issues for BPF verifier (e.g., __nullable
annotation semantics), or tools relying on accurate type information.

To fix this, ensure the BTF encoder selects the function definition
corresponding to the actual code linked into the binary. This is
achieved by comparing the DWARF function address (DW_AT_low_pc) with
the ELF symbol address (st_value). Only the DWARF entry for the strong
definition will match the final resolved ELF symbol address.

[0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/

Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 btf_encoder.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 01fd469..26ccbbe 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1264,6 +1264,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (!state)
 		return -ENOMEM;
 
+	state->addr = function__addr(fn);
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
@@ -1509,6 +1510,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
 	encoder->func_states.cap = 0;
 }
 
+static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
+									  int combined_cnt)
+{
+	int i, j;
+
+	/*
+	 * The same elf_function is shared amongst combined functions,
+	 * as per saved_functions_combine().
+	 */
+	struct elf_function *elf = combined_states[0].elf;
+
+	for (i = 0; i < combined_cnt; i++) {
+		struct btf_encoder_func_state *state = &combined_states[i];
+
+		for (j = 0; j < elf->sym_cnt; j++) {
+			if (state->addr == elf->syms[j].addr)
+				return state;
+		}
+	}
+
+	return &combined_states[0];
+}
+
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
 {
 	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
@@ -1588,6 +1612,16 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
 						   skip_reason, 0, 0);
 		} else {
+			/*
+			 * We're to add the current function within
+			 * BTF. Although, from all functions that have
+			 * possibly been combined via
+			 * saved_functions_combine(), ensure to only
+			 * select and emit BTF for the most canonical
+			 * function definition.
+			 */
+			if (j - i > 1)
+				state = btf_encoder__select_canonical_state(state, j - i);
 			if (is_kfunc_state(state))
 				err = btf_encoder__add_bpf_kfunc(encoder, state);
 			else
-- 
2.43.5


