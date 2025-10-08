Return-Path: <bpf+bounces-70603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7457FBC6282
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7F03A4FD6
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA232BF019;
	Wed,  8 Oct 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gFZTOgqY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBF21255E
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944954; cv=none; b=lpwNLUr8yTtV0hLruNp1NjmGJ9oOnnc1SGK0k7LLRPgUKLbE+L+/29d8WoNNwJBCs9o4GfZeEzDyeMdbYGr/TyDvKw73LqBiOdLUtZIe/Swpxe12DRKhNnpsyg7A6WD2DocUKXXHZmursYe6Ua+6F10NUKgDY4QZbq6KVfLqPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944954; c=relaxed/simple;
	bh=x4JUH6Ov5NZyv2vgzvyYxBU08WK/aB6AfsLfynJAumQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxSk71ejlWY3Q9Djx2QR2FTD9LH31qGAdS8Wkt1ipXoFWZGrTtc2JdJG6/8QtGBSXCKTUphHLtsNKHpfonGjaX2kxXhiLv8ptRbExov53oy/wfQznfbtl+Xu9+qz9XY8ljBRvOaNHXxEHgR+DSCqowYThjs3Ran8i5n6KYb6iOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gFZTOgqY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEU6m029334;
	Wed, 8 Oct 2025 17:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=prcOp
	QJGQFQocBW/q89/GlxAP1QDz/WX+nTQ8RnB96o=; b=gFZTOgqYKDY3PpIYfdLXe
	wy3sdh3rtBrDXPziccA7V524g/SMrsTo+ZJJ+9W+vX8Hsr1sLMkZsviGzFn2Q1Kn
	++w76BBVT0HPCpw2PFs9y6MPgwNad+NNnWs/xuR9rNRSCEogvGdRFfjLXV4vS2GM
	QUcoN2jvfQWU+mMahyJa1okzDrVs4wUxXn64UyjDIDZ43v5f3BfLwcTf3vfSr40j
	ltaIUonxQ6javUiWeL63uTT6aCfV02SsR03JEZ5Ny5HNnP9FSXIgklHpfKgUHn+q
	I4EOij28boN20BdT96PprceuxppUxw3q947hFTxdQRA+w0iWdilUK/8rXMSWVv3o
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6b81a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDtjg037050;
	Wed, 8 Oct 2025 17:35:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUi031138;
	Wed, 8 Oct 2025 17:35:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-2;
	Wed, 08 Oct 2025 17:35:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 01/15] bpf: Extend UAPI to support location information
Date: Wed,  8 Oct 2025 18:34:57 +0100
Message-ID: <20251008173512.731801-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: RdpHdJk4_Ioo11FP4xUlGy0CzwiDz6rM
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e6a0d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=t-MgiKc5t4LDyvx_UL4A:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: RdpHdJk4_Ioo11FP4xUlGy0CzwiDz6rM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8nMOH2i+Xgdg
 y5hjiyHhlg69Ro4kHWC5Xnun3sVS2YGaKFLpv0U5PE3piSiPoWH/yOYeq0D9CuSxhqslHX68WmF
 aIbYx4iVc+kYWt5WPuiqbYPVPfcpP/6SjcLjiww4cUyXRYykNKf5e3OE07DHgssBU89axad29Qu
 OPHZnpCgFp7XGwJTBnjYRpa2sUQrLRRVnmdRlL+hWzdPQhSWWFkK6Bo1EDVjQ45NykXJn6ozHzA
 gZWNl/PnIDO7t2Y9xjSpR0i5DgXfZmko6bE10onUz9xKP7OaXP8FNoHJ7yEv4+luK20qL00nvLH
 13zzj8J8oKQpeWNPViMPqNV1MQRWzTylQ0v4uaD/TF8A5H/j49jsVb9xh+AVMH7bXrAkr8YEHYd
 gxvd5YOSdx9qBf2o/k1+tptTyBvTZPI7lzVIxikuEfdAPjJO524=

Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
to help represent location information for functions.

BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
location; either via a register, or register+offset or a
constant value.

BTF_KIND_LOC_PROTO represents location information about a location
with multiple BTF_KIND_LOC_PARAMs.

And finally BTF_KIND_LOCSEC is a set of location sites, each
of which has

- a name (function name)
- a function prototype specifying which types are associated
  with parameters
- a location prototype specifying where to find those parameters
- an address offset

This can be used to represent

- a fully-inlined function
- a partially-inlined function where some _LOC_PROTOs represent
  inlined sites as above and others have normal _FUNC representations
- a function with optimized parameters; again the FUNC_PROTO
  represents the original function, with LOC info telling us
  where to obtain each parameter (or 0 if the parameter is
  unobtainable)

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h            |  29 +++++-
 include/uapi/linux/btf.h       |  85 ++++++++++++++++-
 kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
 4 files changed, 359 insertions(+), 8 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..65091c6aff4b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -487,6 +487,33 @@ static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
 	return (struct btf_enum64 *)(t + 1);
 }
 
+static inline struct btf_loc_param *btf_loc_param(const struct btf_type *t)
+{
+	return (struct btf_loc_param *)(t + 1);
+}
+
+static inline __s32 btf_loc_param_size(const struct btf_type *t)
+{
+	return (__s32)t->size;
+}
+
+static inline __u64 btf_loc_param_value(const struct btf_type *t)
+{
+	__u32 *v = (__u32 *)(t + 1);
+
+	return *v + ((__u64)(*(v + 1)) << 32);
+}
+
+static inline __u32 *btf_loc_params(const struct btf_type *t)
+{
+	return (__u32 *)(t + 1);
+}
+
+static inline struct btf_loc *btf_type_loc_secinfo(const struct btf_type *t)
+{
+	return (struct btf_loc *)(t + 1);
+}
+
 static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 		const struct btf_type *t)
 {
@@ -552,7 +579,7 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[2];
 };
 
 struct btf_field_iter {
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 266d4ffa6c07..a74b9d202847 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -37,14 +37,16 @@ struct btf_type {
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
 	 *             struct, union, enum, fwd, enum64,
-	 *             decl_tag and type_tag
+	 *             decl_tag, type_tag and loc
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC, ENUM64
+	 * and LOC.
+	 *
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
+	 * FUNC, FUNC_PROTO, VAR, DECL_TAG, TYPE_TAG and LOC_PROTO.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -78,6 +80,9 @@ enum {
 	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
 	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
+	BTF_KIND_LOC_PARAM	= 20,	/* Location parameter information */
+	BTF_KIND_LOC_PROTO	= 21,	/* Location prototype for site */
+	BTF_KIND_LOCSEC		= 22,	/* Location section */
 
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
@@ -198,4 +203,78 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_off is 0
+ * and is followed by a singular "struct btf_loc_param". type/size specifies
+ * the size of the associated location value.  The size value should be
+ * cast to a __s32 as negative sizes can be specified; -8 to indicate a signed
+ * 8 byte value for example.
+ *
+ * If kind_flag is 1 the btf_loc is a constant value, otherwise it represents
+ * a register, possibly dereferencing it with the specified offset.
+ *
+ * "struct btf_type" is followed by a "struct btf_loc_param" which consists
+ * of either the 64-bit value or the register number, offset etc.
+ * Interpretation depends on whether the kind_flag is set as described above.
+ */
+
+/* BTF_KIND_LOC_PARAM specifies a signed size; negative values represent signed
+ * values of the specific size, for example -8 is an 8-byte signed value.
+ */
+#define BTF_TYPE_LOC_PARAM_SIZE(t)	((__s32)((t)->size))
+
+/* location param specified by reg + offset is a dereference */
+#define BTF_LOC_FLAG_REG_DEREF		0x1
+/* next location param is needed to specify parameter location also; for example
+ * when two registers are used to store a 16-byte struct by value.
+ */
+#define BTF_LOC_FLAG_CONTINUE		0x2
+
+struct btf_loc_param {
+	union {
+		struct {
+			__u16	reg;		/* register number */
+			__u16	flags;		/* register dereference */
+			__s32	offset;		/* offset from register-stored address */
+		};
+		struct {
+			__u32 val_lo32;		/* lo 32 bits of 64-bit value */
+			__u32 val_hi32;		/* hi 32 bits of 64-bit value */
+		};
+	};
+};
+
+/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
+ * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
+ * a vlen-specified number of __u32 which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
+ * represent a single function parameter; in such a case each should specify
+ * BTF_LOC_FLAG_CONTINUE.
+ *
+ * The type field in the associated "struct btf_type" should point at an
+ * associated BTF_KIND_FUNC_PROTO.
+ */
+
+/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information;
+ *
+ * - name associated with the location (name_off)
+ * - function prototype type id (func_proto)
+ * - location prototype type id (loc_proto)
+ * - address offset (offset)
+ */
+
+struct btf_loc {
+	__u32 name_off;
+	__u32 func_proto;
+	__u32 loc_proto;
+	__u32 offset;
+};
+
+/* helps libbpf know that location declarations are present; libbpf
+ * can then work around absence if this value is not set.
+ */
+#define BTF_KIND_LOC_UAPI_DEFINED 1
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..29cec549f119 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -342,6 +342,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC"
 };
 
 const char *btf_type_str(const struct btf_type *t)
@@ -509,11 +512,27 @@ static bool btf_type_is_decl_tag(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
 }
 
+static bool btf_type_is_loc_param(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOC_PARAM;
+}
+
+static bool btf_type_is_loc_proto(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOC_PROTO;
+}
+
+static bool btf_type_is_locsec(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOCSEC;
+}
+
 static bool btf_type_nosize(const struct btf_type *t)
 {
 	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
 	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
-	       btf_type_is_decl_tag(t);
+	       btf_type_is_decl_tag(t) || btf_type_is_loc_param(t) ||
+	       btf_type_is_loc_proto(t) || btf_type_is_locsec(t);
 }
 
 static bool btf_type_nosize_or_null(const struct btf_type *t)
@@ -4524,6 +4543,150 @@ static const struct btf_kind_operations enum64_ops = {
 	.show = btf_enum64_show,
 };
 
+static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
+				    const struct btf_type *t,
+				    u32 meta_left)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+	u32 meta_needed;
+	s32 size;
+
+	meta_needed = sizeof(*p);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				      meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (t->name_off) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+	if (btf_type_vlen(t)) {
+		btf_verifier_log_type(env, t, "Invalid vlen");
+		return -EINVAL;
+	}
+	size = btf_loc_param_size(t);
+	if (size < 0)
+		size = -size;
+	if (size > 8 || !is_power_of_2(size)) {
+		btf_verifier_log_type(env, t, "Unexpected size");
+		return -EINVAL;
+	}
+
+	return meta_needed;
+}
+
+static void btf_loc_param_log(struct btf_verifier_env *env,
+			 const struct btf_type *t)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+
+	if (btf_type_kflag(t))
+		btf_verifier_log(env, "type=%u const=%lld", t->type, btf_loc_param_value(t));
+	else
+		btf_verifier_log(env, "type=%u reg=%u flags=%d offset %u",
+				 t->type, p->reg, p->flags, p->offset);
+}
+
+static const struct btf_kind_operations loc_param_ops = {
+	.check_meta = btf_loc_param_check_meta,
+	.resolve = btf_df_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_loc_param_log,
+	.show = btf_df_show,
+};
+
+static s32 btf_loc_proto_check_meta(struct btf_verifier_env *env,
+				    const struct btf_type *t,
+				    u32 meta_left)
+{
+	u32 meta_needed;
+
+	meta_needed = sizeof(__u32) * btf_type_vlen(t);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				      meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (t->name_off) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+	return meta_needed;
+}
+
+static void btf_loc_proto_log(struct btf_verifier_env *env,
+			      const struct btf_type *t)
+{
+	const __u32 *params = btf_loc_params(t);
+	u16 nr_params = btf_type_vlen(t), i;
+
+	btf_verifier_log(env, "loc_proto locs=(");
+	for (i = 0; i < nr_params; i++, params++) {
+		btf_verifier_log(env, "type=%u%s", *params,
+				 i + 1 == nr_params ? ")" : ", ");
+	}
+}
+
+static const struct btf_kind_operations loc_proto_ops = {
+	.check_meta = btf_loc_proto_check_meta,
+	.resolve = btf_df_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_loc_proto_log,
+	.show = btf_df_show,
+};
+
+static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
+				 const struct btf_type *t,
+				 u32 meta_left)
+{
+	u32 meta_needed;
+
+	meta_needed = sizeof(struct btf_loc) * btf_type_vlen(t);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+	return meta_needed;
+}
+
+static void btf_locsec_log(struct btf_verifier_env *env,
+			   const struct btf_type *t)
+{
+	const struct btf_loc *loc = btf_type_loc_secinfo(t);
+	u16 nr_locs = btf_type_vlen(t), i;
+	const struct btf *btf = env->btf;
+
+	btf_verifier_log(env, "locsec %s locs=(",
+			 __btf_name_by_offset(btf, t->name_off));
+	for (i = 0; i < nr_locs; i++, loc++) {
+		btf_verifier_log(env, "\n\tname=%s func_proto %u loc_proto %u offset 0x%x%s",
+				 __btf_name_by_offset(btf, loc->name_off),
+				 loc->func_proto, loc->loc_proto, loc->offset,
+				 i + 1 == nr_locs ? ")" : ", ");
+	}
+}
+
+static const struct btf_kind_operations locsec_ops = {
+	.check_meta = btf_locsec_check_meta,
+	.resolve = btf_df_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_locsec_log,
+	.show = btf_df_show,
+};
+
 static s32 btf_func_proto_check_meta(struct btf_verifier_env *env,
 				     const struct btf_type *t,
 				     u32 meta_left)
@@ -5193,6 +5356,9 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG] = &decl_tag_ops,
 	[BTF_KIND_TYPE_TAG] = &modifier_ops,
 	[BTF_KIND_ENUM64] = &enum64_ops,
+	[BTF_KIND_LOC_PARAM] = &loc_param_ops,
+	[BTF_KIND_LOC_PROTO] = &loc_proto_ops,
+	[BTF_KIND_LOCSEC] = &locsec_ops
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 266d4ffa6c07..a74b9d202847 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -37,14 +37,16 @@ struct btf_type {
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
 	 *             struct, union, enum, fwd, enum64,
-	 *             decl_tag and type_tag
+	 *             decl_tag, type_tag and loc
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC, ENUM64
+	 * and LOC.
+	 *
 	 * "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
+	 * FUNC, FUNC_PROTO, VAR, DECL_TAG, TYPE_TAG and LOC_PROTO.
 	 * "type" is a type_id referring to another type.
 	 */
 	union {
@@ -78,6 +80,9 @@ enum {
 	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
 	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
+	BTF_KIND_LOC_PARAM	= 20,	/* Location parameter information */
+	BTF_KIND_LOC_PROTO	= 21,	/* Location prototype for site */
+	BTF_KIND_LOCSEC		= 22,	/* Location section */
 
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
@@ -198,4 +203,78 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_off is 0
+ * and is followed by a singular "struct btf_loc_param". type/size specifies
+ * the size of the associated location value.  The size value should be
+ * cast to a __s32 as negative sizes can be specified; -8 to indicate a signed
+ * 8 byte value for example.
+ *
+ * If kind_flag is 1 the btf_loc is a constant value, otherwise it represents
+ * a register, possibly dereferencing it with the specified offset.
+ *
+ * "struct btf_type" is followed by a "struct btf_loc_param" which consists
+ * of either the 64-bit value or the register number, offset etc.
+ * Interpretation depends on whether the kind_flag is set as described above.
+ */
+
+/* BTF_KIND_LOC_PARAM specifies a signed size; negative values represent signed
+ * values of the specific size, for example -8 is an 8-byte signed value.
+ */
+#define BTF_TYPE_LOC_PARAM_SIZE(t)	((__s32)((t)->size))
+
+/* location param specified by reg + offset is a dereference */
+#define BTF_LOC_FLAG_REG_DEREF		0x1
+/* next location param is needed to specify parameter location also; for example
+ * when two registers are used to store a 16-byte struct by value.
+ */
+#define BTF_LOC_FLAG_CONTINUE		0x2
+
+struct btf_loc_param {
+	union {
+		struct {
+			__u16	reg;		/* register number */
+			__u16	flags;		/* register dereference */
+			__s32	offset;		/* offset from register-stored address */
+		};
+		struct {
+			__u32 val_lo32;		/* lo 32 bits of 64-bit value */
+			__u32 val_hi32;		/* hi 32 bits of 64-bit value */
+		};
+	};
+};
+
+/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
+ * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
+ * a vlen-specified number of __u32 which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
+ * represent a single function parameter; in such a case each should specify
+ * BTF_LOC_FLAG_CONTINUE.
+ *
+ * The type field in the associated "struct btf_type" should point at an
+ * associated BTF_KIND_FUNC_PROTO.
+ */
+
+/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information;
+ *
+ * - name associated with the location (name_off)
+ * - function prototype type id (func_proto)
+ * - location prototype type id (loc_proto)
+ * - address offset (offset)
+ */
+
+struct btf_loc {
+	__u32 name_off;
+	__u32 func_proto;
+	__u32 loc_proto;
+	__u32 offset;
+};
+
+/* helps libbpf know that location declarations are present; libbpf
+ * can then work around absence if this value is not set.
+ */
+#define BTF_KIND_LOC_UAPI_DEFINED 1
+
 #endif /* _UAPI__LINUX_BTF_H__ */
-- 
2.39.3


