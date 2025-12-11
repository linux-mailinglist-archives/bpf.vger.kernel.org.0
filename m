Return-Path: <bpf+bounces-76483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5ECB690F
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 17:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D74303E675
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3C314D3F;
	Thu, 11 Dec 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aKNiHkAt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0F25A334;
	Thu, 11 Dec 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471711; cv=none; b=R7g36tQx61+prDkfDRy2zFbIsD7JxEBQTo7eGd5xdp4zMQP5HXpnyaO5HzFvFNi9EuL+Yy2LWpzqzkZsvZaBDuqyRmrLDiFMuvL+Tc+mxHc+nPczDyVdMvcY/Dd60gdTXAtzDbs91GoUJm7ZprDAyeCwCLSuy9PrgyOY8dNp6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471711; c=relaxed/simple;
	bh=lKcxJVG9S0malWpKq3lLdZYejvWOmhYXqudaGx+OXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0nbIzGcX3/MT7F2ImNddGX6v3FkGUnK+2SnQWs3JPUoyhuS0CuPYYmqPjwy8eggHrCZnzMI38x4fFHha2xMbyvgRc7+CCM0FKWG+Cav5ob5DcdW1T5G8bUTDZ3PQ2taCGCyfpeJmyY8xYk47ADbnjTZB8zK/YAU+ehhOkRW2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aKNiHkAt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBG572g1564127;
	Thu, 11 Dec 2025 16:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=m1CQW
	9BjcC/sO1DIqHFSit5VMqCtSdpICyaAnqbxiGo=; b=aKNiHkAtBX3Rehw1Lu8f5
	dsOKwP1b8JjhojEcZPOG/gXE34HyWE4eSCykeJDgCDEahyBHk34Fe/DRIOjnCxUP
	h+mX4BLOXGS4b+jjqOJaVNKBJDnViKmRfZBpPIoAgPuv6/YeajJYX8asHBbdqCmB
	E43IOuqqOilbWiXeikRT6IIXNba7N9JRGv4sjkm4/30mkfMmXIQVePC3vzsuauIK
	HuUuWd7X6r7Kr7eyOvbQrUBB1hiKWy1CCN5raejGUIDPuiwPvJw6n9XNbWgMhjaI
	k0ditJXOwQFiKnYU52ttdMp+YYF+amslE8r3J3/9HeK7gG13yYSN3Zkjibq3ReQH
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ayb2s255w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBFAU9M039896;
	Thu, 11 Dec 2025 16:47:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxnsx15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Dec 2025 16:47:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BBGknmJ030704;
	Thu, 11 Dec 2025 16:47:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-126.vpn.oracle.com [10.154.50.126])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4avaxnswqy-7;
	Thu, 11 Dec 2025 16:47:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v7 bpf-next 06/10] btf: support kernel parsing of BTF with kind layout
Date: Thu, 11 Dec 2025 16:46:42 +0000
Message-ID: <20251211164646.1219122-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251211164646.1219122-1-alan.maguire@oracle.com>
References: <20251211164646.1219122-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110133
X-Authority-Analysis: v=2.4 cv=Raudyltv c=1 sm=1 tr=0 ts=693af58c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gT5K8rRyMkbMDDVUVwEA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: gsVLsC5ZmQ0MqkBR_uPdCsZRR-Nde_Wx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNCBTYWx0ZWRfX6hCTlC8bQAjz
 gx0i4AQWKSR29QTCuevA5bOKHWciLoaDt5NVPIbgY107JQ29/Q8iG8aec9RQUxair1nzLZa/osx
 f3byCSapk2c7zjpVEH4OQUbpr4zsfQDR/YIhuVdzWOmMj8muiBJF/vWZPM1rmmnfy5RM78TxbiZ
 ikYYHQX3+eNOfQSXl6xN5VOUI/N1yoghz0Rbr5In9PCTscDiWudpWLArFmsYyEKPK+KAp9pFR7W
 DeUnQ74f87zYxSz3LEs9gICZkfwn0CpSg4RLC4SZjKn87OUb0u0awK/0pZGhhQRVVMnTId99gB/
 oqP8BXzdtSisbr/A+H27qTdp5vkZk6GMSTWIJpkOIqaFYjjUE5k16RpMwit3MJ1WnpbOxXOsjou
 xTkFR4/wBMdr+INHO0RoQXqtAjjlgugYcgeZ1a1SI7lT0YKLPmg=
X-Proofpoint-ORIG-GUID: gsVLsC5ZmQ0MqkBR_uPdCsZRR-Nde_Wx

Validate kind layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the kind layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 96 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..d6221d3e7893 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -268,6 +268,7 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+	struct btf_kind_layout *kind_layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
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
@@ -5405,7 +5419,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5426,9 +5441,41 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
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
+	if (end > btf->data + btf->data_size) {
+		btf_verifier_log(env, "Kind layout section is too big");
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
@@ -5443,44 +5490,49 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
@@ -5816,6 +5868,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
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


