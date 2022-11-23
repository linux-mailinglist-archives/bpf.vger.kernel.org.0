Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA81D636775
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiKWRmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiKWRme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2792C55BE
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:32 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANGTV5S015410;
        Wed, 23 Nov 2022 17:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=kRQdqPZJLvnUf9AmGNLTWIW5o2boEbDaFN6o71qDERk=;
 b=ENmj9FRYFQ/F09s1ybDj7FFyK6kDHi0WYGZoVdi+q76udV0Fvyk2hhkh8mtFDBo+ln1S
 /2m1tXSAu2CLOlcrNNot+CmlbZ0q/rPms50D381PD7Md3u1U2JXEZtlSesu2pZMhg4vB
 GfYv2UqA996sP5SS6+FPLayG/VqAID1Tf8nRLog8cd2vnsef4waD4MCGjWdhXfXb9hwc
 c05gUqYGSFItBvPVTQ+m1+vmmcwTrS77IgBNhg5mX1tQWZADLBeAafEImC6mZfwNJrsj
 l191T4wZgj5j2hhbRX4CkC1qj7uPBD5lTeZImKhfTjGJWc3aAdafJMIOlz4QtxQSz+wz eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fgd4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHFO8A015584;
        Wed, 23 Nov 2022 17:42:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74agn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqI028233;
        Wed, 23 Nov 2022 17:42:12 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-5;
        Wed, 23 Nov 2022 17:42:12 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 4/5] bpf: parse unrecognized kind info using encoded kind information (if present)
Date:   Wed, 23 Nov 2022 17:41:51 +0000
Message-Id: <1669225312-28949-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230130
X-Proofpoint-ORIG-GUID: H6UFZBBfIIcxajFft0sncl0tqkQsPHCe
X-Proofpoint-GUID: H6UFZBBfIIcxajFft0sncl0tqkQsPHCe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When BTF parsing encounters an unrecognized kind (> BTF_KIND_MAX), look
for __BTF_KIND_<num> typedef which points at the associated kind struct;
it tells us if there is metadata and how much.  This all allows us to
proceed with BTF parsing rather than bailing when hitting a kind we
do not support.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1a59cc7..ce00a4c5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -222,6 +222,14 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_kind_desc {
+	u16 kind;
+	u16 nr_meta;
+	u32 meta_size;
+};
+
+#define NR_BTF_KINDS_POSSIBLE	0x20
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -246,6 +254,7 @@ struct btf {
 	u32 start_str_off; /* first string offset (0 for base BTF) */
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
+	struct btf_kind_desc unrecognized_kinds[NR_BTF_KINDS_POSSIBLE - NR_BTF_KINDS];
 };
 
 enum verifier_phase {
@@ -4873,7 +4882,7 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 			  u32 meta_left)
 {
 	u32 saved_meta_left = meta_left;
-	s32 var_meta_size;
+	s32 var_meta_size = 0;
 
 	if (meta_left < sizeof(*t)) {
 		btf_verifier_log(env, "[%u] meta_left:%u meta_needed:%zu",
@@ -4888,12 +4897,80 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
-	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN ||
+	    BTF_INFO_KIND(t->info) >= NR_BTF_KINDS_POSSIBLE) {
 		btf_verifier_log(env, "[%u] Invalid kind:%u",
 				 env->log_type_id, BTF_INFO_KIND(t->info));
 		return -EINVAL;
 	}
+	if (BTF_INFO_KIND(t->info) <= BTF_KIND_MAX) {
+		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
+		if (var_meta_size < 0)
+			return var_meta_size;
+	} else {
+		struct btf_kind_desc *unrec_kind;
+		u8 kind = BTF_INFO_KIND(t->info);
+		struct btf *btf = env->btf;
+
+		unrec_kind = &btf->unrecognized_kinds[kind - NR_BTF_KINDS];
+
+		if (unrec_kind->kind != kind) {
+			const struct btf_member *m;
+			const struct btf_type *kt;
+			const struct btf_array *a;
+			char name[64];
+			s32 id;
+
+			/* BTF may encode info about unrecognized kinds; check for this here. */
+			snprintf(name, sizeof(name), BTF_KIND_PFX "%u", kind);
+			id = btf_find_by_name_kind(btf, name, BTF_KIND_TYPEDEF);
+			if (id > 0) {
+				kt = btf_type_by_id(btf, id);
+				if (kt)
+					kt = btf_type_by_id(btf, kt->type);
+			}
+			if (id < 0 || !kt) {
+				btf_verifier_log_type(env, t, "[%u] invalid kind:%u",
+						      env->log_type_id, kind);
+				return -EINVAL;
+			}
+			switch (btf_type_vlen(kt)) {
+			case 1:
+				/* no metadata */
+				unrec_kind->kind = kind;
+				unrec_kind->nr_meta = 0;
+				unrec_kind->meta_size = 0;
+				break;
+			case 2:
+				m = btf_members(kt);
+				kt = btf_type_by_id(btf, (++m)->type);
+				if (btf_kind(kt) != BTF_KIND_ARRAY) {
+					btf_verifier_log_type(env, t, "[%u] invalid metadata:%u",
+							      env->log_type_id, kind);
+					return -EINVAL;
+				}
+				a = btf_array(kt);
+				kt = btf_type_by_id(btf, a->type);
+				if (!kt) {
+					btf_verifier_log_type(env, t, "[%u] invalid metadata:%u",
+							      env->log_type_id, kind);
+					return -EINVAL;
+				}
+				unrec_kind->kind = kind;
+				unrec_kind->nr_meta = a->nelems;
+				unrec_kind->meta_size = kt->size;
+				break;
+			default:
+				btf_verifier_log_type(env, t, "[%u] invalid metadata:%u",
+						      env->log_type_id, kind);
+				return -EINVAL;
+			}
+		}
+		if (!unrec_kind->nr_meta)
+			var_meta_size = btf_type_vlen(t) * unrec_kind->meta_size;
+		else
+			var_meta_size = unrec_kind->nr_meta * unrec_kind->meta_size;
+	}
 
 	if (!btf_name_offset_valid(env->btf, t->name_off)) {
 		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
@@ -4901,10 +4978,6 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
-	if (var_meta_size < 0)
-		return var_meta_size;
-
 	meta_left -= var_meta_size;
 
 	return saved_meta_left - meta_left;
-- 
1.8.3.1

