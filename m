Return-Path: <bpf+bounces-76422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA111CB3F59
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC79F3012752
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6D32BF47;
	Wed, 10 Dec 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzIMFIuS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241D42050;
	Wed, 10 Dec 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398554; cv=none; b=JNEsC18vl7ZwWI9EOVCu6KCWN843kw6Mw1HqCTcSZKDJiGwqmqCTGCxsnFP9ldXH4lVeoDe3eozm2jrWXUgZfIMgRblh6lEWK9wwqPPpC5YHdqnNy5+vO0WByYZc7aERVmwVvYC5D0L7PSZTw1waG+JyrbxRvDEzv8ClfI+dedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398554; c=relaxed/simple;
	bh=57owOu0YnyW1akvK5U3aZ51U3GyROEDCXNqDlbs82Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib1W53nlZ1l6gih1NYAur/YfniYqvkHNvkumcPFxbTuRrWyTDpaRq8iMZCeSH0a5TGUcTXwi1JhNGAq+xVtg60m2bMjERBhxSsx/jiyRt9a9dyLt/SUX+8pZmWOrNtkVOxap/WBqPpRh2PyxJN/l+mT/akyn7X7DCjHuwvdAEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzIMFIuS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIZ7bs3768693;
	Wed, 10 Dec 2025 20:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oWpsD
	J4lfkea01r+RIQh8oaQdtPNTTBkjISOp5LtPbA=; b=PzIMFIuS968+xZsKQf6GM
	i4S87b6YKdRC6FZfcbUTgdYlbTO6IAY4dGQh6I64x74O9JapXVEGy0Nsrmp5MCEf
	dZy8z5Cl7cX9eldcFUZuSi6yPlppzPDgjTNKjFhl0WNilXoehq13T0EtZ3aXg3Zi
	Uo+ivncsAXCtl/YPWf6ewHvocXnPktFyfIf3THo0su2qUciwpXkj+Cj3k9bqWcpf
	4mkZy2V7xNKEQkEK+Umr/qWYAh1l5GQF7Z6rqhSqyvQGHV9zPHZBvnvzT1Eriwdj
	f55PKMgrAnpjgVHI86k4VHQx6Mj18/uNvMHyaqfgQeH2TPtfvykY6eWIyNrpPYmK
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aycne0cnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJfYPQ021086;
	Wed, 10 Dec 2025 20:28:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxb08e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:28:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BAKSNws003322;
	Wed, 10 Dec 2025 20:28:27 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-41.vpn.oracle.com [10.154.60.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4avaxb080n-2;
	Wed, 10 Dec 2025 20:28:27 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, ttreyer@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 1/2] pahole: Add "kind_layout" BTF encoding feature
Date: Wed, 10 Dec 2025 20:27:51 +0000
Message-ID: <20251210202752.813919-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210202752.813919-1-alan.maguire@oracle.com>
References: <20251210202752.813919-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100168
X-Authority-Analysis: v=2.4 cv=F65at6hN c=1 sm=1 tr=0 ts=6939d7ed cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5EpxQJHCGlTQSDxuAMwA:9
X-Proofpoint-GUID: kOEHlL7saMDSRXdDGsZwPIFZUXCwuCjJ
X-Proofpoint-ORIG-GUID: kOEHlL7saMDSRXdDGsZwPIFZUXCwuCjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE2NyBTYWx0ZWRfX8iKkoTZWMWPI
 Y6OiGjE2iPRS7hjcMSpXCeik1nH1fMZj3AunTJuZykgSgtLuWX5VhhbJtEcXibPwrf1joPyEBIG
 HX/MlxQ5pX04zh3yFhAr9eQHqyTJtic+6MCnvoE823Rhg1UWJIqep5dxcqSj5g5BY0KpBvbSIGK
 p6jdrk9z54lOnwq8yt0O2yp2455+pYvsrq+T8gZfBKRhQzBOWw570oiLq4bawRV0yO3bvwBhkOD
 Hi2tRA0nvT9c5AJTGly0m3mJBJq8EtigApUd81/wWOLbzKjlfIHat0f3JIpQ4sFqsW5HXpIdK0M
 ex0Yp6ZsV+87AQHojsu0UlaUoY/vPjw8dhfB4DpP7khCC/LwCpc1jPDi0QX0WXU63eW3w6ybg+S
 TtjAVAAYMBW5gPMXDRohjiThj12DNA==

Add support to pahole to add BTF kind layout info which describes the
BTF kinds supported at encoding time.  Since an older libbpf can be used
to build pahole add declaration for btf_new_opts and add a feature test
to check for the btf__new_empty_opts() function.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 20 +++++++++++++++++++-
 dwarves.h     |  4 ++++
 pahole.c      |  7 +++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b37ee7f..074ec72 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2549,6 +2549,16 @@ out:
 	return err;
 }
 
+/* Needed for older libbpf to support weak declaration of btf__new_empty_opts() */
+#ifndef btf_new_opts__last_field
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;
+	bool add_kind_layout;
+	size_t:0;
+};
+#endif
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
@@ -2562,7 +2572,15 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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
index 21d4166..49ade3e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -46,6 +46,8 @@ enum load_steal_kind {
 	LSK__ABORT,
 };
 
+struct btf_new_opts;
+
 /*
  * Weak declarations of libbpf APIs that are version-dependent
  */
@@ -55,6 +57,7 @@ __weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_
 __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
 __weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
+__weak extern struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
 
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
@@ -95,6 +98,7 @@ struct conf_load {
 	bool			skip_encoding_btf_inconsistent_proto;
 	bool			skip_encoding_btf_vars;
 	bool			encode_btf_global_vars;
+	bool			encode_btf_kind_layout;
 	bool			btf_gen_floats;
 	bool			btf_encode_force;
 	bool			reproducible_build;
diff --git a/pahole.c b/pahole.c
index ef01e58..66b6bdb 100644
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
@@ -1234,6 +1239,8 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
+	BTF_NON_DEFAULT_FEATURE_CHECK(kind_layout, encode_btf_kind_layout, false,
+				      kind_layout_check),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.43.5


