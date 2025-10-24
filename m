Return-Path: <bpf+bounces-72000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4DC04C15
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC8F402209
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF62E6CCE;
	Fri, 24 Oct 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fpw2ZWoT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D332E3715;
	Fri, 24 Oct 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291253; cv=none; b=AmCEEJBADfGyHiVGYxyhc7ckJNo5uBOYy6ZsUcruahZypHk5KwpJZ5J1RuCT7oma1GB2xvNjcM579OFHaQznDWMyyURjlRmuEapZr6rkX8MxnR8l6fyiONrZ8tNZt5U5xz+gkyG3DEdmLViY6XK1k0SN/ycReLl4VrC6ZlWmMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291253; c=relaxed/simple;
	bh=zL6g28KNlEuvJke7yTxNRm2kaW//WFC1tlA+7Rk0c8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGsonKSyPMNdap0U8NhGZ9wJJ6Rlnn940oxZrq73AP/By9vyhI3R4nwyW9BJOcT/mhdg4+eYSeDsUFHLTt1dJA42lalTWD0RdLadwp4Kz6VV8uTg1z5FUKD2WyGovo49vUy/8TV9BGctfXJrVsVW/3d1XvzSXZA2m2gQBH3Y164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fpw2ZWoT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NQ6L013749;
	Fri, 24 Oct 2025 07:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=VPw33
	NsXlBu5e4X1H5F3dbeLcPcdTLhj/jhunwEyGTA=; b=Fpw2ZWoT6BhhzNUHluUvS
	b9aVh1tVCRiyCBpKwGNVS/OvXCOQP7nj075lIoCDSTDSCmCTeg7VOk5AsAr1/MQh
	GsUga5VqNPQg/tut61p2/98FCGitoIsz18GIpVlbRozRLZnUnQexpWlWlOS7pjZi
	b02xntzMEhsP2F/7vE9l4d1bMbvOyjPqyhmevgs9mqZl8hVsbKIkqpFp5taVV9qg
	82wK1EQhgcb4/i2T1TG52sWSstTnCzIL8eXqXZVc16CsuLeYOvlRu0zBm/o2dK2a
	jvgdJNlwCgkhHD0nS0F/lyArHNaNUYWthIviv5+v3UkMZZ63ddWR2b0fPN4XeN6z
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah1v39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7QrZ3022357;
	Fri, 24 Oct 2025 07:33:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwn019356;
	Fri, 24 Oct 2025 07:33:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-6;
	Fri, 24 Oct 2025 07:33:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 5/5] pahole: Support inline encoding with inline[.extra] BTF feature
Date: Fri, 24 Oct 2025 08:33:28 +0100
Message-ID: <20251024073328.370457-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251024073328.370457-1-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-ORIG-GUID: 4BIRTZbA1N8_dfszrXyBt4ExBqiz6Saj
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb2be0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=d7M4oGHEK9GV39ktvKAA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX0Ze3g2FPjnDi
 VM6PhGsC2Kmr6wAccnN4Fq1XIwdmFnUHCvTlpD0v2kWrlsOL5ctLqTftT0OCdDNmpS8s3yrP7Hi
 78Ad+UK8YiQmVhfbsjVzI89H1CO9oRCKYMYO2odWdOyNJXemK0b9eFVDj79KZT8P1GgAh6QGWtl
 Uys7GRaNI7GSou88RqrDYcPkSH0mZOZiybMdzaG/UymxD4eJz4K0EjO518qhMQm0GFHynyml/4c
 17hkhwAsoLBO3yKyuCXJvz0NifPPOU3jRGjQlVN4RYyEjqqcy75L54ZcdIk6N1eywW8yd2ETUIS
 6E5qGGpTMdqtMS5O6+45DcEVsT2/DCu3MqlJ5LvybHqtCiSImoe2Y4LWPiSU6xahgapS6WMIqUx
 Ivp/y/aZlQr8NxKvLi4xZF+F1PRx1yANRC0AE8BOC9MbAu/2Grw=
X-Proofpoint-GUID: 4BIRTZbA1N8_dfszrXyBt4ExBqiz6Saj

The inline feature enables encoding of inlines in BTF.  Adding the
.extra suffix ensures the encoding ends up in split BTF in a
.BTF.extra section.

Add support for extra features that optionally target the .BTF.extra
section and have the inline feature be the first consumer

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pahole.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/pahole.c b/pahole.c
index ef01e58..7cf3fbf 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1183,16 +1183,24 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
  * floats, etc.  This ensures backwards compatibility.
  */
 #define BTF_DEFAULT_FEATURE(name, alias, initial_value)		\
-	{ #name, #alias, &conf_load.alias, initial_value, true, NULL }
+	{ #name, #alias, &conf_load.alias, initial_value, true, NULL, NULL }
 
 #define BTF_DEFAULT_FEATURE_CHECK(name, alias, initial_value, feature_check)	\
-	{ #name, #alias, &conf_load.alias, initial_value, true, feature_check }
+	{ #name, #alias, &conf_load.alias, initial_value, true, NULL, feature_check }
 
 #define BTF_NON_DEFAULT_FEATURE(name, alias, initial_value)	\
-	{ #name, #alias, &conf_load.alias, initial_value, false, NULL }
+	{ #name, #alias, &conf_load.alias, initial_value, false, NULL, NULL }
 
 #define BTF_NON_DEFAULT_FEATURE_CHECK(name, alias, initial_value, feature_check) \
-	{ #name, #alias, &conf_load.alias, initial_value, false, feature_check }
+	{ #name, #alias, &conf_load.alias, initial_value, false, NULL, feature_check }
+
+#define BTF_NON_DEFAULT_EXTRA_FEATURE_CHECK(name, alias, initial_value, feature_check)	\
+	{ #name, #alias, &conf_load.alias, initial_value, false, &conf_load.alias##_extra, feature_check }
+
+/* If a feature supports it, using ".extra" as a suffix for the feature name
+ * targets .BTF.extra section with the resultant BTF data.
+ */
+#define BTF_EXTRA_FEATURE_SUFFIX	".extra"
 
 static bool enum64_check(void)
 {
@@ -1209,6 +1217,11 @@ static bool attributes_check(void)
 	return btf__add_type_attr != NULL;
 }
 
+static bool locations_check(void)
+{
+	return btf__add_loc_proto != NULL;
+}
+
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
@@ -1217,6 +1230,7 @@ struct btf_feature {
 	bool		default_enabled;	/* some nonstandard features may not
 						 * be enabled for --btf_features=default
 						 */
+	bool		*extra;			/* can store in .BTF.extra? */
 	bool		(*feature_check)(void);
 } btf_features[] = {
 	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
@@ -1234,6 +1248,8 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
+	BTF_NON_DEFAULT_EXTRA_FEATURE_CHECK(inline, btf_gen_inlines, false,
+					    locations_check),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1261,8 +1277,15 @@ static struct btf_feature *find_btf_feature(char *name)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
-		if (strcmp(name, btf_features[i].name) == 0)
+		if (strncmp(name, btf_features[i].name, strlen(btf_features[i].name)) == 0) {
+			/* Feature can optionally target .BTF.extra if it
+			 * is supported and has the .extra suffix.
+			 */
+			if (btf_features[i].extra)
+				*(btf_features[i].extra) = strstr(name, BTF_EXTRA_FEATURE_SUFFIX)
+							   != NULL;
 			return &btf_features[i];
+		}
 	}
 	return NULL;
 }
-- 
2.39.3


