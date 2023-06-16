Return-Path: <bpf+bounces-2737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79573374D
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4436C1C20C77
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889571B8F3;
	Fri, 16 Jun 2023 17:18:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032A182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C11FEC
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCi7Qe013287;
	Fri, 16 Jun 2023 17:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ki+diWlKsrEXoVNdw2E0EQX2xGQsCkX2W+f0dDWPay4=;
 b=xs1PrtN2vWA8RhGi/zDCq7rg16ApMPFAKskkjOpn8l1bgVAi8HsDrF2i6CpS/7D8cOnx
 Nbqul3tZvx2xTxZlGMDtwZNIl2yPgSSYSKU/aLGD9ls9JrOkDTjWAmMZnWLIzYvay7tq
 eMsEfotFSktYjHxuPt39+4yOGKMJtHnEL9AqNu9Pw2hdq7gA7TUusEcsaKkQhfoZBiAm
 wSIe5eJVikmktCUjLnkuQNPNFbcAAVQ5fhiBj7+R+ogk2tSYqAZauMzd8YUwBHSINBtc
 df8uULU2w9got3Q0xqWLSvtrcfVLjDUiKAN98soKOGNTNpDuYmHBQwdnefMIQlPDIWzL 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu4k48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GFk2RM012432;
	Fri, 16 Jun 2023 17:17:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmerthf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPe007608;
	Fri, 16 Jun 2023 17:17:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-5;
	Fri, 16 Jun 2023 17:17:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 4/9] btf: support kernel parsing of BTF with kind layout
Date: Fri, 16 Jun 2023 18:17:22 +0100
Message-Id: <20230616171728.530116-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160155
X-Proofpoint-GUID: 8J4i8kZlZqUw_iaaDpI6dnKrMfd8gLFL
X-Proofpoint-ORIG-GUID: 8J4i8kZlZqUw_iaaDpI6dnKrMfd8gLFL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use kind layout to parse BTF with unknown kinds that have a
kind layout representation.

Validate kind layout if present, and use it to parse BTF with
unrecognized kinds. Reject BTF that contains a type
of a kind that is not optional.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 102 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 82 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..ffe3926ea051 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -257,6 +257,7 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+	struct btf_kind_layout *kind_layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -4965,22 +4966,41 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
-	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
-		btf_verifier_log(env, "[%u] Invalid kind:%u",
-				 env->log_type_id, BTF_INFO_KIND(t->info));
-		return -EINVAL;
-	}
-
 	if (!btf_name_offset_valid(env->btf, t->name_off)) {
 		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
 				 env->log_type_id, t->name_off);
 		return -EINVAL;
 	}
 
-	var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
-	if (var_meta_size < 0)
-		return var_meta_size;
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
+		btf_verifier_log(env, "[%u] Invalid kind:%u",
+				 env->log_type_id, BTF_INFO_KIND(t->info));
+		return -EINVAL;
+	}
+
+	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layout &&
+	    (BTF_INFO_KIND(t->info) * sizeof(struct btf_kind_layout)) <
+	     env->btf->hdr.kind_layout_len) {
+		struct btf_kind_layout *k = &env->btf->kind_layout[BTF_INFO_KIND(t->info)];
+
+		if (!(k->flags & BTF_KIND_LAYOUT_OPTIONAL)) {
+			btf_verifier_log(env, "[%u] unknown but required kind %u",
+					 env->log_type_id,
+					 BTF_INFO_KIND(t->info));
+			return -EINVAL;
+		}
+		var_meta_size = sizeof(struct btf_type);
+		var_meta_size += k->info_sz + (btf_type_vlen(t) * k->elem_sz);
+	} else {
+		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
+			btf_verifier_log(env, "[%u] Invalid kind:%u",
+					 env->log_type_id, BTF_INFO_KIND(t->info));
+			return -EINVAL;
+		}
+		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
+		if (var_meta_size < 0)
+			return var_meta_size;
+	}
 
 	meta_left -= var_meta_size;
 
@@ -5155,7 +5175,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5176,9 +5197,41 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
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
@@ -5193,32 +5246,37 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
+		gap = secs[i].off - total;
+		if (gap >= 4) {
+			/* gap larger than alignment gap */
+			btf_verifier_log(env, "Unsupported section gap found");
 			return -EINVAL;
 		}
 		if (total > secs[i].off) {
@@ -5230,7 +5288,7 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
 					 "Total section length too long");
 			return -EINVAL;
 		}
-		total += secs[i].len;
+		total += secs[i].len + gap;
 	}
 
 	/* There is data other than hdr and known sections */
@@ -5293,7 +5351,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 		return -ENOTSUPP;
 	}
 
-	if (hdr->flags) {
+	if (hdr->flags & ~(BTF_FLAG_CRC_SET | BTF_FLAG_BASE_CRC_SET)) {
 		btf_verifier_log(env, "Unsupported flags");
 		return -ENOTSUPP;
 	}
@@ -5530,6 +5588,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
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


