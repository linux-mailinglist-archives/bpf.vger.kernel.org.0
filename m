Return-Path: <bpf+bounces-14924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7AA7E8FC3
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CF7280C3C
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C639C3C07;
	Sun, 12 Nov 2023 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCRXbQ0e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C83648
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:25 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FC30C2
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCiX1d016531;
	Sun, 12 Nov 2023 12:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Q+gxxl7jNRWaHj64WM5NFv4eWz46znwG7jPNPO9i83I=;
 b=iCRXbQ0eHMQ8DhfBIxBxOdHp/G0coJz8+83ocWGDiW3/MdC4WI5zc7mY3xiQSuvRgW2R
 LASxiP+Zm21vRTc4hXw6io7Brq+sHvhdY9Zy0Vn32/4YXpB8xchn28LwpftVYOIqfni3
 T7PE9UAaP5dchOxtRXsszMabX/dGjgKBfTcDLvCd0bQiTKkjdzsVGNt4u73Qm/NiclCY
 nnwhKUrrN7YJ0y0ZFJMYBOEu0rcJ9UYlfLqZegdtHl3UUhuHwRvP9Pvrw4U2wytqVZU3
 fqFsRUY9aXvYHhvrun2RjhZb5VEcg33/Jdjn1qAaJPHJvBGZsM0xYEWfrSG0es6bd2zb 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m29e8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCFBje009314;
	Sun, 12 Nov 2023 12:49:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:49:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceE029718;
	Sun, 12 Nov 2023 12:49:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-7;
	Sun, 12 Nov 2023 12:49:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 06/17] btf: support kernel parsing of BTF with kind layout
Date: Sun, 12 Nov 2023 12:48:23 +0000
Message-Id: <20231112124834.388735-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: HQA0_x7U9G8167g1OYEupkK2vg3XjgNU
X-Proofpoint-ORIG-GUID: HQA0_x7U9G8167g1OYEupkK2vg3XjgNU

Validate kind layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the kind layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 98 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 63cf4128fc05..554b5b795d6f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -258,6 +258,7 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+	struct btf_kind_layout *kind_layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -4969,23 +4970,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
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
@@ -5159,7 +5173,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5180,9 +5195,41 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
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
@@ -5197,44 +5244,49 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
@@ -5297,7 +5349,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 		return -ENOTSUPP;
 	}
 
-	if (hdr->flags) {
+	if (hdr->flags & ~(BTF_FLAG_CRC_SET | BTF_FLAG_BASE_CRC_SET)) {
 		btf_verifier_log(env, "Unsupported flags");
 		return -ENOTSUPP;
 	}
@@ -5534,6 +5586,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
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
2.31.1


