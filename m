Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74800636774
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiKWRmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKWRmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBAFC6
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHQCm3026690;
        Wed, 23 Nov 2022 17:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Tat7TXc76ejD15NJSRFk75FXUDE/KqLs+Lc9jbkd9xc=;
 b=LchBXtpd+Ui6Xy5fi9Dtx+DCoGF8mGLOONhP4nCr+b1tWOxajTZlFRAvPocMvo0miYM0
 5NoiOkWsTVU9HEz+wmqlX59T3vtq8jxRDeE/9HwuxRzdicZM/s6LSp9ruwnd+GO6w4V2
 PO77Lj32L1z69UNH+9Wk8tdLhLOHj0TYryf5alYA10h7XfHYvYdvkyW+o/124mXBMQkL
 8vTkad64CXYJ47QnZHCdBhDF9EPcCPPOqp51xlX1yEeQQucw0qnoTYtpP0kHqYn4HcHN
 FmwDdrUPoR4/CfEkPongzROwomyrPfK3nw5JxPUradV9xsiWJ6BTSsOZNd0QjGTrl5ED Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1qwt01h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHBHQa015572;
        Wed, 23 Nov 2022 17:42:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74aca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqE028233;
        Wed, 23 Nov 2022 17:42:05 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-3;
        Wed, 23 Nov 2022 17:42:04 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/5] libbpf: provide libbpf API to encode BTF kind information
Date:   Wed, 23 Nov 2022 17:41:49 +0000
Message-Id: <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: CN34q6Il8makO0sbkyT7j1j766SrvMpe
X-Proofpoint-GUID: CN34q6Il8makO0sbkyT7j1j766SrvMpe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This can be used by BTF parsers to handle kinds they do not know about;
this is useful when the encoding libbpf is more recent than the parsing
BTF; the parser can then skip over the encoded types it does not know
about.

We use BTF to encode the BTF kinds that are known at the time of
BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
to describe each kind and any associated metadata allows BTF parsing
to handle new kinds that the parser (in libbpf or the kernel) does
not know about.  These kinds will not be used, but since we know
their format they can be skipped over and the rest of the BTF can
be parsed.  This means we can encode BTF without worrying about the
kinds a BTF parser knows about, and means we can avoid using
--skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
everything it can, something as simple as a libbpf package update
then unlocks that encoded information, whereas if we encode
pessimistically and drop representations of new kinds, this is not
possible.

So, in short, by carrying a representation of all the kinds encoded,
parsers can parse all of the encoded kinds, even if they cannot use
them all.

We use BTF itself to carry this representation because this approach
does not require BTF parsing to understand a new BTF header format;
BTF parsing simply sees some additional types it does not do anything
with.  However, a BTF parser that knows about the encoding of kind
information can use this information to guide parsing.

The process works by explicitly adding btf structs for each kind.
Each struct consists of a "struct __btf_type" followed by an array of
metadata structs representing the following metadata (for those kinds
that have it).  For kinds where a single metadata structure is used,
the metadata array has one element.  For kinds where the number
of metadata elements varies as per the info.vlen field, a zero-element
array is encoded.

For a given kind, we add a struct __BTF_KIND_<kind>.  For example,

struct __BTF_KIND_INT {
	struct __btf_type type;
};

For a type with one metadata element, the representation looks like
this:

struct __BTF_KIND_META_ARRAY {
	__u32 type;
	__u32 index_type;
	__u32 nelems;
};

struct __BTF_KIND_ARRAY {
	struct __btf_type type;
	struct __BTF_KIND_META_ARRAY meta[1];
};

For a type with an info.vlen-determined number of following metadata
objects, a zero-length array is used:

struct __BTF_KIND_STRUCT {
	struct __btf_type type;
	struct __BTF_KIND_META_STRUCT meta[0];
};

In order to link kind numeric kind values to the appropriate struct,
a typedef is added; for example:

typedef struct __BTF_KIND_INT __BTF_KIND_1;

When BTF parsing encounters a kind that is not known, the
typedef __BTF_KIND_<kind number> is looked up, and we find which
struct type id it points to.  So

	1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT

This approach is preferred, since it ensures the structs representing
BTF kinds have names which match their associated kind rather than
an opaque number.

From there, BTF parsing can look up that struct and determine
	- its basic size;
	- if it has metadata; and if so
	- how many array instances are present;
		- if 0, we know it is a vlen-determined number;
		  i.e. vlen * meta_size
		- if > 0, simply use the overall struct size;

Based upon that information, BTF parsing can proceed for such
unknown kinds, since sufficient information was provided
at encoding time to skip over them.

Note that this assumes that the above kind-related data
structures are represented in BTF _prior_ to any kinds that
are new to the parser.  It also assumes the basic kinds
required to represent kinds + metadata; base types, structs,
arrays, etc.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 281 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  10 ++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 292 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 71e165b..e3cea44 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -28,6 +28,16 @@
 
 static struct btf_type btf_void;
 
+/* info used to encode/decode an unrecognized kind */
+struct btf_kind_desc {
+	int kind;
+	const char *struct_name;	/* __BTF_KIND_ARRAY */
+	const char *typedef_name;	/* __BTF_KIND_2 */
+	const char *meta_name;		/* __BTF_KIND_META_ARRAY */
+	int nr_meta;
+	int meta_size;
+};
+
 struct btf {
 	/* raw BTF data in native endianness */
 	void *raw_data;
@@ -5011,3 +5021,274 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+/* Here we use BTF to encode the BTF kinds that are known at the time of
+ * BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
+ * to describe each kind and any associated metadata allows BTF parsing
+ * to handle new kinds that the parser (in libbpf or the kernel) does
+ * not know about.  These kinds will not be used, but since we know
+ * their format they can be skipped over and the rest of the BTF can
+ * be parsed.  This means we can encode BTF without worrying about the
+ * kinds a BTF parser knows about, and means we can avoid using
+ * --skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
+ * everything it can, something as simple as a libbpf package update
+ * then unlocks that encodeded information, whereas if we encode
+ * pessimistically and drop representations of new kinds, this is not
+ * possible.
+ *
+ * So, in short, by carrying a representation of all the kinds encoded,
+ * parsers can parse all of the encoded kinds, even if they cannot use
+ * them all.
+ *
+ * We use BTF itself to carry this representation because this approach
+ * does not require BTF parsing to understand a new BTF header format;
+ * BTF parsing simply sees some additional types it does not do anything
+ * with.  A BTF parser that knows about the encoding of kind information
+ * however can use this information in parsing.
+ *
+ * The process works by explicitly adding btf structs for each kind.
+ * Each struct consists of a struct __btf_type followed by an array of
+ * metadata structs representing the following metadata (for those kinds
+ * that have it).  For kinds where a single metadata structure is used,
+ * the metadata array has one element.  For kinds where the number
+ * of metadata elements varies as per the info.vlen field, a zero-element
+ * array is encoded.
+ *
+ * For a given kind, we add a struct __BTF_KIND_<kind>.  For example,
+ *
+ * struct __BTF_KIND_INT {
+ *	struct __btf_type type;
+ * };
+ *
+ * For a type with one metadata element, the representation looks like
+ * this:
+ *
+ * struct __BTF_KIND_META_ARRAY {
+ *	__u32 type;
+ *	__u32 index_type;
+ *	__u32  nelems;
+ * };
+ *
+ * struct __BTF_KIND_ARRAY {
+ *	struct __btf_type type;
+ *	struct __BTF_KIND_META_ARRAY meta[1];
+ * };
+ *
+ *
+ * For a type with an info.vlen-determined number of following metadata
+ * objects, a zero-length array is used:
+ *
+ * struct __BTF_KIND_STRUCT {
+ *	struct __btf_type type;
+ *	struct __BTF_KIND_META_STRUCT meta[0];
+ * };
+ *
+ * In order to link kind numeric kind values to the appropriate struct,
+ * a typedef is added; for example:
+ *
+ * typedef struct __BTF_KIND_INT __BTF_KIND_1;
+ *
+ * When BTF parsing encounters a kind that is not known, the
+ * typedef __BTF_KIND_<kind number> is looked up, and we find which
+ * struct type id it points to.  So
+ *
+ *	1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT
+ *
+ * This approach is preferred, since it ensures the structs representing
+ * BTF kinds have names which match their associated kind rather than
+ * an opaque number.
+ *
+ * From there, BTF parsing can look up that struct and determine
+ *	- its basic size;
+ *	- if it has metadata; and if so
+ *	- how many array instances are present;
+ *		- if 0, we know it is a vlen-determined number;
+ *		- if > 0, simply use the overall struct size;
+ *
+ * Based upon that information, BTF parsing can proceed for such
+ * unknown kinds, since sufficient information was provided
+ * at encoding time.
+ *
+ * Note that this assumes that the above kind-related data
+ * structures are represented in BTF _prior_ to any kinds that
+ * are new to the parser.  It also assumes the basic kinds
+ * required to represent kinds + metadata; base types, structs,
+ * arrays, etc.
+ */
+
+/* info used to encode a kind metadata field */
+struct btf_meta_field {
+	const char *type;
+	const char *name;
+	int size;
+	int type_id;
+};
+
+#define BTF_MAX_META_FIELDS             10
+
+#define BTF_META_FIELD(__type, __name)					\
+	{ .type = #__type, .name = #__name, .size = sizeof(__type) }
+
+#define BTF_KIND_STR(__kind)	#__kind
+
+struct btf_kind_encoding {
+	struct btf_kind_desc kind;
+	struct btf_meta_field meta[BTF_MAX_META_FIELDS];
+};
+
+#define BTF_KIND(__name, __nr_meta, __meta_size, ...)			\
+	{ .kind = {							\
+	  .kind = BTF_KIND_##__name,					\
+	  .struct_name = BTF_KIND_PFX#__name,				\
+	  .meta_name = BTF_KIND_META_PFX #__name,			\
+	  .nr_meta = __nr_meta,						\
+	  .meta_size = __meta_size,					\
+	}, .meta = { __VA_ARGS__ } }
+
+struct btf_kind_encoding kinds[] = {
+	BTF_KIND(UNKN,		0,	0),
+
+	BTF_KIND(INT,		0,	0),
+
+	BTF_KIND(PTR,		0,	0),
+
+	BTF_KIND(ARRAY,		1,	sizeof(struct btf_array),
+					BTF_META_FIELD(__u32, type),
+					BTF_META_FIELD(__u32, index_type),
+					BTF_META_FIELD(__u32, nelems)),
+
+	BTF_KIND(STRUCT,	0,	sizeof(struct btf_member),
+					BTF_META_FIELD(__u32, name_off),
+					BTF_META_FIELD(__u32, type),
+					BTF_META_FIELD(__u32, offset)),
+
+	BTF_KIND(UNION,		0,	sizeof(struct btf_member),
+					BTF_META_FIELD(__u32, name_off),
+					BTF_META_FIELD(__u32, type),
+					BTF_META_FIELD(__u32, offset)),
+
+	BTF_KIND(ENUM,		0,	sizeof(struct btf_enum),
+					BTF_META_FIELD(__u32, name_off),
+					BTF_META_FIELD(__s32, val)),
+
+	BTF_KIND(FWD,		0,	0),
+
+	BTF_KIND(TYPEDEF,	0,	0),
+
+	BTF_KIND(VOLATILE,	0,	0),
+
+	BTF_KIND(CONST,		0,	0),
+
+	BTF_KIND(RESTRICT,	0,	0),
+
+	BTF_KIND(FUNC,		0,	0),
+
+	BTF_KIND(FUNC_PROTO,	0,	sizeof(struct btf_param),
+					BTF_META_FIELD(__u32, name_off),
+					BTF_META_FIELD(__u32, type)),
+
+	BTF_KIND(VAR,		1,	sizeof(struct btf_var),
+					BTF_META_FIELD(__u32, linkage)),
+
+	BTF_KIND(DATASEC,	0,	sizeof(struct btf_var_secinfo),
+					BTF_META_FIELD(__u32, type),
+					BTF_META_FIELD(__u32, offset),
+					BTF_META_FIELD(__u32, size)),
+
+
+	BTF_KIND(FLOAT,		0,	0),
+
+	BTF_KIND(DECL_TAG,	1,	sizeof(struct btf_decl_tag),
+					BTF_META_FIELD(__s32, component_idx)),
+
+	BTF_KIND(TYPE_TAG,	0,	0),
+
+	BTF_KIND(ENUM64,	0,	sizeof(struct btf_enum64),
+					BTF_META_FIELD(__u32, name_off),
+					BTF_META_FIELD(__u32, val_lo32),
+					BTF_META_FIELD(__u32, val_hi32)),
+};
+
+/* Try to add representations of the kinds supported to BTF provided.  This will allow parsers
+ * to decode kinds they do not support and skip over them.
+ */
+int btf__add_kinds(struct btf *btf)
+{
+	int btf_type_id, __u32_id, __s32_id, struct_type_id;
+	char name[64];
+	int i;
+
+	/* should have base types; if not bootstrap them. */
+	__u32_id = btf__find_by_name(btf, "__u32");
+	if (__u32_id < 0) {
+		__s32 unsigned_int_id = btf__find_by_name(btf, "unsigned int");
+
+		if (unsigned_int_id < 0)
+			unsigned_int_id = btf__add_int(btf, "unsigned int", 4, 0);
+		__u32_id = btf__add_typedef(btf, "__u32", unsigned_int_id);
+	}
+	__s32_id = btf__find_by_name(btf, "__s32");
+	if (__s32_id < 0) {
+		__s32 int_id = btf__find_by_name_kind(btf, "int", BTF_KIND_INT);
+
+		if (int_id < 0)
+			int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+		__s32_id = btf__add_typedef(btf, "__s32", int_id);
+	}
+
+	/* add "struct __btf_type" if not already present. */
+	btf_type_id = btf__find_by_name(btf, "__btf_type");
+	if (btf_type_id < 0) {
+		__s32 union_id = btf__add_union(btf, NULL, sizeof(__u32));
+
+		btf__add_field(btf, "size", __u32_id, 0, 0);
+		btf__add_field(btf, "type", __u32_id, 0, 0);
+
+		btf_type_id = btf__add_struct(btf, "__btf_type", sizeof(struct btf_type));
+		btf__add_field(btf, "name_off", __u32_id, 0, 0);
+		btf__add_field(btf, "info", __u32_id, sizeof(__u32) * 8, 0);
+		btf__add_field(btf, NULL, union_id, sizeof(__u32) * 16, 0);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(kinds); i++) {
+		struct btf_kind_encoding *kind = &kinds[i];
+		int meta_id, array_id = 0;
+
+		if (btf__find_by_name(btf, kind->kind.struct_name) > 0)
+			continue;
+
+		if (kind->kind.meta_size != 0) {
+			struct btf_meta_field *field;
+			__u32 bit_offset = 0;
+			int j;
+
+			meta_id = btf__add_struct(btf, kind->kind.meta_name, kind->kind.meta_size);
+
+			for (j = 0; bit_offset < kind->kind.meta_size * 8; j++) {
+				field = &kind->meta[j];
+
+				field->type_id = btf__find_by_name(btf, field->type);
+				if (field->type_id < 0) {
+					pr_debug("cannot find type '%s' for kind '%s' field '%s'\n",
+						 kind->meta[j].type, kind->kind.struct_name,
+						 kind->meta[j].name);
+				} else {
+					btf__add_field(btf, field->name, field->type_id, bit_offset, 0);
+				}
+				bit_offset += field->size * 8;
+			}
+			array_id = btf__add_array(btf, __u32_id, meta_id,
+						  kind->kind.nr_meta);
+
+		}
+		struct_type_id = btf__add_struct(btf, kind->kind.struct_name,
+						 sizeof(struct btf_type) +
+						 (kind->kind.nr_meta * kind->kind.meta_size));
+		btf__add_field(btf, "type", btf_type_id, 0, 0);
+		if (kind->kind.meta_size != 0)
+			btf__add_field(btf, "meta", array_id, sizeof(struct btf_type) * 8, 0);
+		snprintf(name, sizeof(name), BTF_KIND_PFX "%u", i);
+		btf__add_typedef(btf, name, struct_type_id);
+	}
+	return 0;
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d..a054082 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -219,6 +219,16 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
 LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 			    int component_idx);
 
+/**
+ * @brief **btf__add_kinds()** adds BTF representations of the kind encoding for
+ * all of the kinds known to libbpf.  This ensures that when BTF is encoded, it
+ * will include enough information for parsers to decode (and skip over) kinds
+ * that the parser does not know about yet.  This ensures that an older BTF
+ * parser can read newer BTF, and avoids the need for the BTF encoder to limit
+ * which kinds it emits to make decoding easier.
+ */
+LIBBPF_API int btf__add_kinds(struct btf *btf);
+
 struct btf_dedup_opts {
 	size_t sz;
 	/* optional .BTF.ext info to dedup along the main BTF info */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 71bf569..6121ff1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -375,6 +375,7 @@ LIBBPF_1.1.0 {
 		bpf_link_get_fd_by_id_opts;
 		bpf_map_get_fd_by_id_opts;
 		bpf_prog_get_fd_by_id_opts;
+		btf__add_kinds;
 		user_ring_buffer__discard;
 		user_ring_buffer__free;
 		user_ring_buffer__new;
-- 
1.8.3.1

