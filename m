Return-Path: <bpf+bounces-59157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2212BAC6678
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C90D7A220F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A712797BE;
	Wed, 28 May 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXdsBHXP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF5279334;
	Wed, 28 May 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426308; cv=none; b=Xw1JdQ2CiiMw0Y0cdfrFByGYYmtcRvNgvbSLBvFWBUH30RqVGtwOOUyAO8mpamKUk8i40GzcHWFGB2Tpf53CA24zjBREcXUhKXay6j29s9WiN0o8eEyEPyXtP9Y80b1j3lf2rhPixg6N3WqlViLmt6xlBl7at8NtD9AVR2JGn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426308; c=relaxed/simple;
	bh=bZMfLsgsGv2WGkHcfuNQETnDmREfXZVqPSdDsm6k/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmLsZZdwinx7rw3j2K+kc6NobL0oX7Ydsj6bpsZMavP5T7ibWYELWnOUPd2mCMYWnrX166V2654Xon8XI+x9X7a10nkMTnzariLIJAgRPDf8aDSmMQ4MLsdFE8kfj/WlBZmbQS0P2E1XfvHe2NhnC5qXcd9UR5BaCAS/VzDtgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JXdsBHXP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1hWkA013251;
	Wed, 28 May 2025 09:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MvSyW
	vN0iYZd/ttnUES0YSnw9DXL2EVgLe4AHZypOfA=; b=JXdsBHXPsI04ng5XFh2w5
	4vzcOPGIhYTInw8Cg7X3nl8a2kRmqVQyH2ofRnBkf2Kuxmri1iU7CkKnI69CfMvg
	iU+levABvlxLWViVuUhwiE1zfGPQY4Vf0o250Pqzuvpr0wKJEaX5YUX56u9TcFRB
	7kHPoIiqcq3BcKs8JzqSlT0/IydZI8QnLfIauO8dfHp5fSZTG0TkD/LZ3yufYxBk
	B304cIIdwEQZl31fB6xRxnyGHPFLHRQr9kxedgCJVhJ7OMNXQ12gl59bmZNJ6D/4
	JuU45OS3poLJpnv0vj8OWvvSCJ4g3TzMXaWSY3a7nWI96b7vvtppFXwq5vuoqiwA
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd597r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:58:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9nkU7024403;
	Wed, 28 May 2025 09:57:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jaev28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 09:57:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54S9qwVs007194;
	Wed, 28 May 2025 09:57:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-51-118.vpn.oracle.com [10.154.51.118])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46u4jaeuw6-5;
	Wed, 28 May 2025 09:57:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 4/9] libbpf: Add kind layout encoding support
Date: Wed, 28 May 2025 10:57:38 +0100
Message-ID: <20250528095743.791722-5-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: gzjlyENYrUDiVR375ekYVOnYDgt4Lh2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4NyBTYWx0ZWRfXxa39rufckbuc RXWC8Rtfr3ULtzTNAx9VX9E/XFxu+FtfuCWhDWPjPBsju74kTbECiaTBgi3EFi+75FlKVpLXIb8 XuJ6j0iiqx/08feW2qI7I7K5Uzg827YcFG4jwDiEEl1T27zfGiblem1ysF6cGl0I+SrrvEjo36v
 2uENJRczjfy09QcE+6rZtKdphnLw8U21KSPkKpu/95rIKXU+Wt098f6eN5olV6XwgqxSb72Vbq7 JLo1umwsDwRvqAddfri7vZxYKlxirEhWHjMUF4sW9Eh9woWFRwogHFftxrmasftQzlsDyesSKGC oeA9Y5y64Q4j15Twrj+mCk1Cd4L6YYYqQc/GnOSJsFArxOrgtKz4i8UjB+UT01UQIgdnMdjajLB
 8d7EaNZjCw3rxN6XVMchhvokOJuhyxyxTq3EVIjEI/crUhGbiIJ5HoJwFgtc5TiqB1mnw8LC
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6836de2f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=cKRRRYibTiSyJAuzRoMA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: gzjlyENYrUDiVR375ekYVOnYDgt4Lh2F

Support encoding of BTF kind layout data via btf__new_empty_opts().

Current supported opts are base_btf and add_kind_layout.

Kind layout information is maintained in btf.c in the
kind_layouts[] array; when BTF is created with the
add_kind_layout option it represents the current view
of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 61 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 20 +++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7a197dbfc689..f3c4dc0c9007 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -30,6 +30,35 @@
 
 static struct btf_type btf_void;
 
+/* Describe how kinds are laid out; some have a singular element following the "struct btf_type",
+ * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  Flags are currently unused.
+ * Kind layout can be optionally added to the BTF representation in a dedicated section to
+ * facilitate parsing.  New kinds must be added here.
+ */
+struct btf_kind_layout kind_layouts[NR_BTF_KINDS] = {
+/*	flags	singular element size		vlen element(s) size */
+{	0,	0,				0				}, /* _UNKN */
+{	0,	sizeof(__u32),			0				}, /* _INT */
+{	0,	0,				0				}, /* _PTR */
+{	0,	sizeof(struct btf_array),	0				}, /* _ARRAY */
+{	0,	0,				sizeof(struct btf_member)	}, /* _STRUCT */
+{	0,	0,				sizeof(struct btf_member)	}, /* _UNION */
+{	0,	0,				sizeof(struct btf_enum)		}, /* _ENUM */
+{	0,	0,				0				}, /* _FWD */
+{	0,	0,				0				}, /* _TYPEDEF */
+{	0,	0,				0				}, /* _VOLATILE */
+{	0,	0,				0				}, /* _CONST */
+{	0,	0,				0				}, /* _RESTRICT */
+{	0,	0,				0				}, /* _FUNC */
+{	0,	0,				sizeof(struct btf_param)	}, /* _FUNC_PROTO */
+{	0,	sizeof(struct btf_var),		0				}, /* _VAR */
+{	0,	0,				sizeof(struct btf_var_secinfo)	}, /* _DATASEC */
+{	0,	0,				0				}, /* _FLOAT */
+{	0,	sizeof(struct btf_decl_tag),	0				}, /* _DECL_TAG */
+{	0,	0,				0				}, /* _TYPE_TAG */
+{	0,	0,				sizeof(struct btf_enum64)	}, /* _ENUM64 */
+};
+
 struct btf {
 	/* raw BTF data in native endianness */
 	void *raw_data;
@@ -1078,8 +1107,9 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1122,6 +1152,17 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		free(btf);
 		return ERR_PTR(-ENOMEM);
 	}
+
+	if (opts->add_kind_layout) {
+		hdr->kind_layout_len = sizeof(kind_layouts);
+		btf->kind_layout = malloc(hdr->kind_layout_len);
+		if (!btf->kind_layout) {
+			free(btf->hdr);
+			free(btf);
+			return ERR_PTR(-ENOMEM);
+		}
+		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
+	}
 	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1129,12 +1170,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 struct btf *btf__new_empty(void)
 {
-	return libbpf_ptr(btf_new_empty(NULL));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	return libbpf_ptr(btf_new_empty(&opts));
 }
 
 struct btf *btf__new_empty_split(struct btf *base_btf)
 {
-	return libbpf_ptr(btf_new_empty(base_btf));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	opts.base_btf = base_btf;
+
+	return libbpf_ptr(btf_new_empty(&opts));
+}
+
+struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
+{
+	if (!OPTS_VALID(opts, btf_new_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	return libbpf_ptr(btf_new_empty(opts));
 }
 
 static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, bool is_mmap)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..829c9c47a97f 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -108,6 +108,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;	/* optional base BTF */
+	bool add_kind_layout;	/* add BTF kind layout information */
+	size_t:0;
+};
+#define btf_new_opts__last_field add_kind_layout
+
+/**
+ * @brief **btf__new_empty_opts()** creates an unpopulated BTF object with
+ * optional *base_btf* and BTF kind layout description if *add_kind_layout*
+ * is set
+ * @return new BTF object instance which has to be eventually freed with
+ * **btf__free()**
+ *
+ * On error, NULL is returned and the thread-local `errno` variable is
+ * set to the error code.
+ */
+LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
+
 /**
  * @brief **btf__distill_base()** creates new versions of the split BTF
  * *src_btf* and its base BTF. The new base BTF will only contain the types
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..2a854517baeb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -443,4 +443,5 @@ LIBBPF_1.6.0 {
 		bpf_program__line_info_cnt;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		btf__new_empty_opts;
 } LIBBPF_1.5.0;
-- 
2.39.3


