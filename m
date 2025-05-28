Return-Path: <bpf+bounces-59152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFAEAC6654
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893723AA651
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49561278E6A;
	Wed, 28 May 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JfA2ytst"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE47278741;
	Wed, 28 May 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426068; cv=none; b=NqCuuN5kJCuLDnCXQbAP40g33Oln+Hde/maixF9Kr0S5f3dC8zw8f2+e+Nuadh3WsjtXT2w/LV5wrp8I/VGqxDmRL8jpzJ8ohRz/LsqzOiwk4lPh6ROkRSftSHgtGyIDnB3CXWuTVhLnHFj99ctXcuOGS6PbLrN4UqTgHqGlFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426068; c=relaxed/simple;
	bh=4e1vHi/8xLgNC3GL8SLPQdkOmywQRYXPYgGFsYydxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgPG+tiNOFqi0R8oIFrc6lr7JTClcza9iT+gRZ3Qt8toMiZLru/d3mULjWNEUOuWiSdUgG2IWhyroXM/ghUFQHv2OuoKAg0auHRlTShhGy6dCRNmpgt9wCAcuJnQsxebPsUhG/AxbT4z/qUM8K/E08C0TMEQ1Lpn+lVNB75j6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JfA2ytst; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1hGi1002745;
	Wed, 28 May 2025 09:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=K20RY
	m+pJ+ild9Zt87mRJyGYc/ohyiJ/Pn+P+q1x9jo=; b=JfA2ytstzNq4nokNV5Jgt
	fw5y4+7lq63DWQ5sOycaX2AA0cv9XfsDFZWR8BQvtY7R7sqOWMOXMcLJSPPcJO1M
	M5i0EIL7eLPVu4CqGfhAnkw330gf+2QwRXcX9eOAf55Ybs8Pkzitwt0wHsXmUKqz
	BZyudFaXVFAGwRXdN0dJy8c81J8oPZB9kdIxbJYha4so83+Zra1sBTbNgHFRCYz1
	k671JU+83kKPhocZr6e0637kZWD0HblKt2Z1tbsIEyGxLUC/Hm5h26QdVPQv+Jeq
	wjhat/NoHHF7tNfgOiUpcO6I5g/hC3OiQnpxW1sZCrpm+C4cwRaWEqeCSZXZuViJ
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46twf65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:54:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S958SK028487;
	Wed, 28 May 2025 09:53:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4ja79e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:53:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9rs36013320;
	Wed, 28 May 2025 09:53:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46u4ja797j-2;
	Wed, 28 May 2025 09:53:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] pahole: Add "kind_layout" BTF encoding feature
Date: Wed, 28 May 2025 10:53:48 +0100
Message-ID: <20250528095349.788793-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528095349.788793-1-alan.maguire@oracle.com>
References: <20250528095349.788793-1-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280086
X-Proofpoint-GUID: M3nZXLQRAMorqcIN26iJh8rm0fiDmaA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NiBTYWx0ZWRfX855rmObCKFaB jllU9Vz66H3V6Dc/ot4x+DQuKil22CnTm+pennAXjgZJYINBDPwVDcwm+Dx2TT0N6QGE0w0s2nd 7OJt1JOYypNF9A2JHZnQqBgvBffHoq2IFp5gW0fAGn9lYbLVluS5Hjmv6GQj9LcXzUYK9QNb2XL
 NOqzPf+XTULux/TUD6tVGAPyBaD7rICfT8KzecU5LHXjonCxDn1VO3VAwp4hIcImsyyPQDqF+o4 whwPJp7lrJTQcOABP98jVASJHLwgDsjcmVyXNs54z9IZgwL40PfObUfYQXT62Z82D9mejfg7XvX FrMniBmO89evE0Wb0IXHB6CqbjPjiGvWUOgz64nJLjYa4NXvX40a91CTHwhkduTOg9rnrmEZyqK
 /O4vPqH/VDqdCeZOG2nqjlbRUy/Egscls5UirGbKbovwNVq8axv4S+DJLXi2dUDo3Nko0mbe
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6836dd38 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=vbwgR8zXsHc4qK2DmXoA:9
X-Proofpoint-ORIG-GUID: M3nZXLQRAMorqcIN26iJh8rm0fiDmaA0

Add support to pahole to add BTF kind layout info which describes the
BTF kinds supported at encoding time.  Since an older libbpf can be used
to build pahole add declaration for btf_new_opts and add a feature test
to check for the btf__new_empty_opts() function.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 10 +++++++++-
 dwarves.h     | 13 ++++++++++++-
 pahole.c      |  7 +++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..2f166d5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2425,7 +2425,15 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (encoder->source_filename == NULL || encoder->filename == NULL)
 			goto out_delete;
 
-		encoder->btf = btf__new_empty_split(base_btf);
+		if (btf__new_empty_opts) {
+			LIBBPF_OPTS(btf_new_opts, opts);
+
+			opts.add_kind_layout = conf_load->encode_btf_kind_layout;
+			opts.base_btf = base_btf;
+			encoder->btf = btf__new_empty_opts(&opts);
+		} else {
+			encoder->btf = btf__new_empty_split(base_btf);
+		}
 		if (encoder->btf == NULL)
 			goto out_delete;
 
diff --git a/dwarves.h b/dwarves.h
index 36c6898..72b5099 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -45,6 +45,16 @@ enum load_steal_kind {
 	LSK__STOP_LOADING,
 };
 
+/* needed for older libbpf to support weak declaration of btf__new_empty_opts() */
+#ifndef btf_new_opts__last_field
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;
+	bool add_kind_layout;
+	size_t:0;
+};
+#endif
+
 /*
  * Weak declarations of libbpf APIs that are version-dependent
  */
@@ -54,7 +64,7 @@ __weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_
 __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
 __weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
-
+__weak extern struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
  * like a allyesconfig vmlinux kernel we can get over 65535 types.
@@ -94,6 +104,7 @@ struct conf_load {
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
 	bool			encode_btf_global_vars;
+	bool			encode_btf_kind_layout;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/pahole.c b/pahole.c
index 333e71a..797305e 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1209,6 +1209,11 @@ static bool attributes_check(void)
 	return btf__add_type_attr != NULL;
 }
 
+static bool kind_layout_check(void)
+{
+	return btf__new_empty_opts != NULL;
+}
+
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
@@ -1232,6 +1237,8 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE_CHECK(distilled_base, btf_gen_distilled_base, false,
 				      distilled_base_check),
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
+	BTF_NON_DEFAULT_FEATURE_CHECK(kind_layout, encode_btf_kind_layout, false,
+				      kind_layout_check),
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
 };
-- 
2.39.3


