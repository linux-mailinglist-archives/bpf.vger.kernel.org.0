Return-Path: <bpf+bounces-59159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A19AC6677
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE287189AE01
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016E279917;
	Wed, 28 May 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVPJsUEW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3539279333;
	Wed, 28 May 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426309; cv=none; b=myvLvH8mP4wE7IzVs8wkDVAux34joCd4tUo+759tAkDi4db4y/qsKzovREDn8fAR5wBrEUZDSayCab2Pozo4Y3dUupWSfZ78PzAEMOQ6N/dBvRmWVpnsjLTTHfSvI6xzFt1KtG+KqO1alxgXhuSYbM+zaS5z4lgUkZBi9Yc5avY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426309; c=relaxed/simple;
	bh=e631HXGUW7G5SHkH0MzEnEWHqPlVtXkCbvdH/TDndOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erPUdIP2ozXIcUr44maI1qWQat78n9TRbcz6tpuatdUayccBll9sdc14bzARWVpBV5kZ2t0lKvWes90LMK1uutN4NMi8xABXWcS6HB7g1eJkvnvgPak0kp74DNq1kqT6fcwqDyob32gFdt7Mo77OYto7Gg5I9E5i41q892rA6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVPJsUEW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1fwZR010082;
	Wed, 28 May 2025 09:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9FQRM
	HD6FRxfxEv8vf/49tSHCdfUfxG1CwilaGYd7R4=; b=eVPJsUEWUryxVgKSASeLn
	xjO7LLKanniEMZJHeFxYHfHVAeQeNAyjK5L6sy1hDtVt4FAbuZ6ivLFUmHRc1Lbe
	kD3/iE90laQs403g0l2xBYUWlVEYFwE+VrhTPF4t24cm2EuuabctHLQpdAdrp94g
	BmwMcvdisoNdt8Gmb8S4Xzi1kn2+/3NngPSqqGORJYpwZDE4mGrPWg5dxm0YvV2N
	wCluBnCFlCyYKNp1EQC4sNA6Y5LzjC6cqb085udXIegw5IIo9tbU2A5ixxth+JYo
	8fUYTuuEFI3D/o8lzaJvE3qpmiUTxquCwvSqgLU9XxZ5JphYKhtH1rZ5oXn/MggZ
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd5988-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9nkUC024403;
	Wed, 28 May 2025 09:58:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVw007194;
	Wed, 28 May 2025 09:58:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-7;
	Wed, 28 May 2025 09:58:02 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 6/9] btf: support kernel parsing of BTF with kind layout
Date: Wed, 28 May 2025 10:57:40 +0100
Message-ID: <20250528095743.791722-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095743.791722-1-alan.maguire@oracle.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-ORIG-GUID: 4sEaCGkF38ce1i_g9q3hCA-C4rPKO47g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfX7iatPqdLXDLp 253ERyLHztv6MI9v7IvULPtOsu3Szh/jchnwOAUOuK7H7s30tWndsP3N0QvF7oODpCaic4B/cjE CDJD3D3VCpRqiM//iHeFx62e1QlAf4tNvJ5yfHWnxExa2I591Ol5mnLVlvNhfDYgZeRlqXGHngZ
 camVuTEu9XMmy0NJhw5HGomLil1JeIMw+OIOxcUO5hhN2n36kaO35TNN8k++YsVuy3BNGW8ggqp 7zJ1Vlfhk/X/YFci2VKax+h7YlGw0UwOGcpRVEvY0PUxRGo+bkErg6l+Jox05dQZNCR8Sxm/11W 2zDB7Hsr0hT/2aK7IcO9Jo59aNlxUM8SD1YGt2nJThPRG8glzDoBjIeN/5Ij2eRyv7hYA6cZJ4P
 +LwQnBCncz411/YxImBoAm2tyYK6L/dQGx3bHKsuVkWQLtleIA6eiabKJI6xrNaehBftbZN6
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6836de2f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Nk0STND0-C7HVw_Qa7oA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: 4sEaCGkF38ce1i_g9q3hCA-C4rPKO47g

Validate kind layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the kind layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 96 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0f7828380895..a18d7b8ba14c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -268,6 +268,7 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+	struct btf_kind_layout *kind_layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -5208,23 +5209,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
-	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
+	if (!btf_name_offset_valid(env->btf, t->name_off)) {
+		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
+				 env->log_type_id, t->name_off);
+		return -EINVAL;
+	}
+
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
 		btf_verifier_log(env, "[%u] Invalid kind:%u",
 				 env->log_type_id, BTF_INFO_KIND(t->info));
 		return -EINVAL;
 	}
 
-	if (!btf_name_offset_valid(env->btf, t->name_off)) {
-		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
-				 env->log_type_id, t->name_off);
+	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layout &&
+	    (BTF_INFO_KIND(t->info) * sizeof(struct btf_kind_layout)) <
+	     env->btf->hdr.kind_layout_len) {
+		btf_verifier_log(env, "[%u] unknown but required kind %u",
+				 env->log_type_id,
+				 BTF_INFO_KIND(t->info));
 		return -EINVAL;
+	} else {
+		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
+			btf_verifier_log(env, "[%u] Invalid kind:%u",
+					 env->log_type_id, BTF_INFO_KIND(t->info));
+			return -EINVAL;
+		}
+		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
+		if (var_meta_size < 0)
+			return var_meta_size;
 	}
 
-	var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
-	if (var_meta_size < 0)
-		return var_meta_size;
-
 	meta_left -= var_meta_size;
 
 	return saved_meta_left - meta_left;
@@ -5398,7 +5412,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5419,9 +5434,41 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_parse_kind_layout_sec(struct btf_verifier_env *env)
+{
+	const struct btf_header *hdr = &env->btf->hdr;
+	struct btf *btf = env->btf;
+	void *start, *end;
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    hdr->kind_layout_len == 0)
+		return 0;
+
+	/* Kind layout section must align to 4 bytes */
+	if (hdr->kind_layout_off & (sizeof(u32) - 1)) {
+		btf_verifier_log(env, "Unaligned kind_layout_off");
+		return -EINVAL;
+	}
+	start = btf->nohdr_data + hdr->kind_layout_off;
+	end = start + hdr->kind_layout_len;
+
+	if (hdr->kind_layout_len < sizeof(struct btf_kind_layout)) {
+		btf_verifier_log(env, "Kind layout section is too small");
+		return -EINVAL;
+	}
+	if (end != btf->data + btf->data_size) {
+		btf_verifier_log(env, "Kind layout section is not at the end");
+		return -EINVAL;
+	}
+	btf->kind_layout = start;
+
+	return 0;
+}
+
 static const size_t btf_sec_info_offset[] = {
 	offsetof(struct btf_header, type_off),
 	offsetof(struct btf_header, str_off),
+	offsetof(struct btf_header, kind_layout_off),
 };
 
 static int btf_sec_info_cmp(const void *a, const void *b)
@@ -5436,44 +5483,49 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
 			      u32 btf_data_size)
 {
 	struct btf_sec_info secs[ARRAY_SIZE(btf_sec_info_offset)];
-	u32 total, expected_total, i;
+	u32 nr_secs = ARRAY_SIZE(btf_sec_info_offset);
+	u32 total, expected_total, gap, i;
 	const struct btf_header *hdr;
 	const struct btf *btf;
 
 	btf = env->btf;
 	hdr = &btf->hdr;
 
+	if (hdr->hdr_len < sizeof(struct btf_header))
+		nr_secs--;
+
 	/* Populate the secs from hdr */
-	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++)
+	for (i = 0; i < nr_secs; i++)
 		secs[i] = *(struct btf_sec_info *)((void *)hdr +
 						   btf_sec_info_offset[i]);
 
-	sort(secs, ARRAY_SIZE(btf_sec_info_offset),
+	sort(secs, nr_secs,
 	     sizeof(struct btf_sec_info), btf_sec_info_cmp, NULL);
 
 	/* Check for gaps and overlap among sections */
 	total = 0;
 	expected_total = btf_data_size - hdr->hdr_len;
-	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++) {
+	for (i = 0; i < nr_secs; i++) {
 		if (expected_total < secs[i].off) {
 			btf_verifier_log(env, "Invalid section offset");
 			return -EINVAL;
 		}
-		if (total < secs[i].off) {
-			/* gap */
-			btf_verifier_log(env, "Unsupported section found");
-			return -EINVAL;
-		}
 		if (total > secs[i].off) {
 			btf_verifier_log(env, "Section overlap found");
 			return -EINVAL;
 		}
+		gap = secs[i].off - total;
+		if (gap >= 4) {
+			/* gap larger than alignment gap */
+			btf_verifier_log(env, "Unsupported section found");
+			return -EINVAL;
+		}
 		if (expected_total - total < secs[i].len) {
 			btf_verifier_log(env,
 					 "Total section length too long");
 			return -EINVAL;
 		}
-		total += secs[i].len;
+		total += secs[i].len + gap;
 	}
 
 	/* There is data other than hdr and known sections */
@@ -5809,6 +5861,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	err = btf_parse_kind_layout_sec(env);
+	if (err)
+		goto errout;
+
 	err = btf_parse_type_sec(env);
 	if (err)
 		goto errout;
-- 
2.39.3


