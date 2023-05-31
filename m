Return-Path: <bpf+bounces-1541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F71718B04
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DF21C20F46
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8F13D381;
	Wed, 31 May 2023 20:21:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478034CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FFA3
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VK2Omf027743;
	Wed, 31 May 2023 20:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=btrRVJb/IgDmWROlAX1sswZVqFVvDVNxCF0mqehH0X0=;
 b=3gUGWncVu4b8QEvSsYvAKLadnm99zjJbOUOgUdWfRG6b2PE26CULcAo8OTq++o1bj+L0
 eWJXg40nyGndmSMprt/JGali7GN1EjqVTJsHqAoiSxhihUedPqfIMafHJP2YJEs0gi/i
 qge0PkY3qVeBgMpSQoCFoNaNkw9sSFQU9j6p9f1x37xg40DBGdEWIHkYUlY56sNYldVx
 8Shd+auGf+FXgQtg34uCNuYvrzdWRv3pqRhJ8nhL7RXkhZkO8z3nuwF0HWxfNJtNRqL3
 sjTBREe3YlYcm2HkzRuzSQejKqtQLKZ/UUwfKZUe+rl58B1bSpMujm8oK0grYKPB6tyf hQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwweuc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VIXc7j019823;
	Wed, 31 May 2023 20:20:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaET000653;
	Wed, 31 May 2023 20:20:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-5;
	Wed, 31 May 2023 20:20:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 4/8] btf: support kernel parsing of BTF with metadata, use it to parse BTF with unknown kinds
Date: Wed, 31 May 2023 21:19:31 +0100
Message-Id: <20230531201936.1992188-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: rSvjfsm8XQSn011aIdS-GubazLEhGNma
X-Proofpoint-GUID: rSvjfsm8XQSn011aIdS-GubazLEhGNma
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Validate metadata if present, and use it to parse BTF with
unrecognized kinds. Reject BTF that contains a type
of a kind that is not optional.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 102 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..67f42d9ce099 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -257,6 +257,7 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+	struct btf_metadata *meta_data;
 
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
+	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->meta_data &&
+	    BTF_INFO_KIND(t->info) < env->btf->meta_data->kind_meta_cnt) {
+		struct btf_kind_meta *m = &env->btf->meta_data->kind_meta[BTF_INFO_KIND(t->info)];
+
+		if (!(m->flags & BTF_KIND_META_OPTIONAL)) {
+			btf_verifier_log(env, "[%u] unknown but required kind '%s'(%u)",
+					 env->log_type_id,
+					 btf_name_by_offset(env->btf, m->name_off),
+					 BTF_INFO_KIND(t->info));
+			return -EINVAL;
+		}
+		var_meta_size = sizeof(struct btf_type);
+		var_meta_size += m->info_sz + (btf_type_vlen(t) * m->elem_sz);
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
@@ -5176,9 +5197,47 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_parse_meta_sec(struct btf_verifier_env *env)
+{
+	const struct btf_header *hdr = &env->btf->hdr;
+	struct btf *btf = env->btf;
+	void *start, *end;
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    hdr->meta_header.meta_len == 0)
+		return 0;
+
+	/* Meta section must align to 8 bytes */
+	if (hdr->meta_header.meta_off & (sizeof(u64) - 1)) {
+		btf_verifier_log(env, "Unaligned meta_off");
+		return -EINVAL;
+	}
+	start = btf->nohdr_data + hdr->meta_header.meta_off;
+	end = start + hdr->meta_header.meta_len;
+
+	if (hdr->meta_header.meta_len < sizeof(struct btf_meta_header)) {
+		btf_verifier_log(env, "Metadata section is too small");
+		return -EINVAL;
+	}
+	if (end != btf->data + btf->data_size) {
+		btf_verifier_log(env, "Metadata section is not at the end");
+		return -EINVAL;
+	}
+	btf->meta_data = start;
+
+	if (hdr->meta_header.meta_len != sizeof(struct btf_metadata) +
+					(btf->meta_data->kind_meta_cnt *
+					 sizeof(struct btf_kind_meta))) {
+		btf_verifier_log(env, "Metadata section size mismatch");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static const size_t btf_sec_info_offset[] = {
 	offsetof(struct btf_header, type_off),
 	offsetof(struct btf_header, str_off),
+	offsetof(struct btf_header, meta_header.meta_off),
 };
 
 static int btf_sec_info_cmp(const void *a, const void *b)
@@ -5193,15 +5252,19 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
 
@@ -5216,9 +5279,10 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
 			btf_verifier_log(env, "Invalid section offset");
 			return -EINVAL;
 		}
-		if (total < secs[i].off) {
-			/* gap */
-			btf_verifier_log(env, "Unsupported section found");
+		gap = secs[i].off - total;
+		if (gap >= 8) {
+			/* gap larger than alignment gap */
+			btf_verifier_log(env, "Unsupported section gap found");
 			return -EINVAL;
 		}
 		if (total > secs[i].off) {
@@ -5230,7 +5294,7 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
 					 "Total section length too long");
 			return -EINVAL;
 		}
-		total += secs[i].len;
+		total += secs[i].len + gap;
 	}
 
 	/* There is data other than hdr and known sections */
@@ -5530,6 +5594,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	err = btf_parse_meta_sec(env);
+	if (err)
+		goto errout;
+
 	err = btf_parse_type_sec(env);
 	if (err)
 		goto errout;
-- 
2.31.1


