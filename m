Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C323DDED
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgHFRTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Aug 2020 13:19:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41510 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgHFRTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 13:19:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076EXLVq075903;
        Thu, 6 Aug 2020 14:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=tsf/fpkergVASLp3jsddyAvupAJYo1KD9OJcSOMZOgg=;
 b=FQwEyxiaNZGepUXs06j4aRH1m0CiVXAn4mpEuXyaW+sFFGxGeR/7ROoK73wzZWor9Alc
 Ir5lENUqUXJes9f/0qFSOWQkhhiUfL3lF6g6NLm9vUaUs6wFtHXunVHHrVwfbcfNoI/g
 dJtVAntuND6rzqQyn7/h8bdCTa/9wjHABW0FTSPexWl46tNX/pITzunzz7CCh3bmJNZ8
 RJbfbrZdctSMm64PpsRE0tc1bkiF1R/JxuGDti9wicLSRUiLSU8f8c9ExL+tN16thV2j
 alaHp3Qz4/20R7+nHH3YO0Uy0gGLMmiLM7+rx5FTU4OlI4AkzcF74rWZq9t8MiCIwJt6 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32r6gwucfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 06 Aug 2020 14:42:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076Ed9cR156468;
        Thu, 6 Aug 2020 14:42:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32qy8ngckm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Aug 2020 14:42:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 076Egr31006029;
        Thu, 6 Aug 2020 14:42:53 GMT
Received: from localhost.uk.oracle.com (/10.175.182.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Aug 2020 07:42:52 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com, yhs@fb.com
Cc:     linux@rasmusvillemoes.dk, andriy.shevchenko@linux.intel.com,
        pmladek@suse.com, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, shuah@kernel.org,
        rdna@fb.com, scott.branden@broadcom.com, quentin@isovalent.com,
        cneirabustos@gmail.com, jakub@cloudflare.com, mingo@redhat.com,
        rostedt@goodmis.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC PATCH bpf-next 2/4] bpf: make BTF show support generic, apply to seq files/bpf_trace_printk
Date:   Thu,  6 Aug 2020 15:42:23 +0100
Message-Id: <1596724945-22859-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596724945-22859-1-git-send-email-alan.maguire@oracle.com>
References: <1596724945-22859-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060104
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

generalize the "seq_show" seq file support in btf.c to support
a generic show callback of which we support three instances;

- the current seq file show
- a show which triggers the bpf_trace/bpf_trace_printk tracepoint
  for each portion of the data displayed

Both classes of show function call btf_type_show() with different
targets:

- for seq_show, the seq file is the target
- for bpf_trace_printk(), no target is needed.

In the tracing case we need to also track additional data -
length of data written specifically for the return value.

By default show will display type information, field members and
their types and values etc, and the information is indented
based upon structure depth. Zeroed fields are omitted.

Show however supports flags which modify its behaviour:

BTF_SHOW_COMPACT - suppress newline/indent.
BTF_SHOW_NONEWLINE - suppress newline only.
BTF_SHOW_NONAME - suppress show of type and member names.
BTF_SHOW_PTR_RAW - do not obfuscate pointer values.
BTF_SHOW_UNSAFE - do not copy data to safe buffer before display.
BTF_SHOW_ZERO - show zeroed values (by default they are not shown).

The bpf_trace_printk tracepoint is augmented with a "trace_id"
field; it is used to allow tracepoint filtering as typed display
information can easily be interspersed with other tracing data,
making it hard to read.  Specifying a trace_id will allow users
to selectively trace data, eliminating noise.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/bpf.h      |   2 +
 include/linux/btf.h      |  37 ++
 kernel/bpf/btf.c         | 962 ++++++++++++++++++++++++++++++++++++++++++-----
 kernel/trace/bpf_trace.c |  19 +-
 kernel/trace/bpf_trace.h |   6 +-
 5 files changed, 916 insertions(+), 110 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 55eb67d..6143b6e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -946,6 +946,8 @@ typedef u32 (*bpf_convert_ctx_access_t)(enum bpf_access_type type,
 u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		     void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy);
 
+int bpf_trace_vprintk(__u32 trace_id, const char *fmt, va_list ap);
+
 /* an array of programs to be executed under rcu_lock.
  *
  * Typical usage:
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8b81fbb..46bf9f4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -13,6 +13,7 @@
 struct btf_member;
 struct btf_type;
 union bpf_attr;
+struct btf_show;
 
 extern const struct file_operations btf_fops;
 
@@ -46,8 +47,44 @@ int btf_get_info_by_fd(const struct btf *btf,
 const struct btf_type *btf_type_id_size(const struct btf *btf,
 					u32 *type_id,
 					u32 *ret_size);
+
+/*
+ * Options to control show behaviour.
+ *	- BTF_SHOW_COMPACT: no formatting around type information
+ *	- BTF_SHOW_NONAME: no struct/union member names/types
+ *	- BTF_SHOW_PTR_RAW: show raw (unobfuscated) pointer values;
+ *	  equivalent to %px.
+ *	- BTF_SHOW_ZERO: show zero-valued struct/union members; they
+ *	  are not displayed by default
+ *	- BTF_SHOW_NONEWLINE: include indent, but suppress newline;
+ *	  to be used when a show function implicitly includes a newline.
+ *	- BTF_SHOW_UNSAFE: skip use of bpf_probe_read() to safely read
+ *	  data before displaying it.
+ */
+#define BTF_SHOW_COMPACT	(1ULL << 0)
+#define BTF_SHOW_NONAME		(1ULL << 1)
+#define BTF_SHOW_PTR_RAW	(1ULL << 2)
+#define BTF_SHOW_ZERO		(1ULL << 3)
+#define BTF_SHOW_NONEWLINE	(1ULL << 32)
+#define BTF_SHOW_UNSAFE		(1ULL << 33)
+
 void btf_type_seq_show(const struct btf *btf, u32 type_id, void *obj,
 		       struct seq_file *m);
+
+/*
+ * Trace string representation of obj of BTF type_id.
+ *
+ * @btf: struct btf object
+ * @type_id: type id of type obj points to
+ * @obj: pointer to typed data
+ * @flags: show options (see above)
+ *
+ * Return: length that would have been/was copied as per snprintf, or
+ *	   negative error.
+ */
+int btf_type_trace_show(const struct btf *btf, u32 type_id, void *obj,
+			u32 trace_id, u64 flags);
+
 int btf_get_fd_by_id(u32 id);
 u32 btf_id(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 91afdd4..be47304 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -282,6 +282,88 @@ static const char *btf_type_str(const struct btf_type *t)
 	return btf_kind_str[BTF_INFO_KIND(t->info)];
 }
 
+/* Chunk size we use in safe copy of data to be shown. */
+#define BTF_SHOW_OBJ_SAFE_SIZE		256
+
+/*
+ * This is the maximum size of a base type value (equivalent to a
+ * 128-bit int); if we are at the end of our safe buffer and have
+ * less than 16 bytes space we can't be assured of being able
+ * to copy the next type safely, so in such cases we will initiate
+ * a new copy.
+ */
+#define BTF_SHOW_OBJ_BASE_TYPE_SIZE	16
+
+/*
+ * Common data to all BTF show operations. Private show functions can add
+ * their own data to a structure containing a struct btf_show and consult it
+ * in the show callback.  See btf_type_show() below.
+ *
+ * One challenge with showing nested data is we want to skip 0-valued
+ * data, but in order to figure out whether a nested object is all zeros
+ * we need to walk through it.  As a result, we need to make two passes
+ * when handling structs, unions and arrays; the first path simply looks
+ * for nonzero data, while the second actually does the display.  The first
+ * pass is signalled by show->state.depth_check being set, and if we
+ * encounter a non-zero value we set show->state.depth_to_show to
+ * the depth at which we encountered it.  When we have completed the
+ * first pass, we will know if anything needs to be displayed if
+ * depth_to_show > depth.  See btf_[struct,array]_show() for the
+ * implementation of this.
+ *
+ * Another problem is we want to ensure the data for display is safe to
+ * access.  To support this, the "struct obj" is used to track the data
+ * object and our safe copy of it.  We copy portions of the data needed
+ * to the object "copy" buffer, but because its size is limited to
+ * BTF_SHOW_OBJ_COPY_LEN bytes, multiple copies may be required as we
+ * traverse larger objects for display.
+ *
+ * The various data type show functions all start with a call to
+ * btf_show_start_type() which returns a pointer to the safe copy
+ * of the data needed (or if BTF_SHOW_UNSAFE is specified, to the
+ * raw data itself).  btf_show_obj_safe() is responsible for
+ * using copy_from_kernel_nofault() to update the safe data if necessary
+ * as we traverse the object's data.  skbuff-like semantics are
+ * used:
+ *
+ * - obj.head points to the start of the toplevel object for display
+ * - obj.size is the size of the toplevel object
+ * - obj.data points to the current point in the original data at
+ *   which our safe data starts.  obj.data will advance as we copy
+ *   portions of the data.
+ *
+ * In most cases a single copy will suffice, but larger data structures
+ * such as "struct task_struct" will require many copies.  The logic in
+ * btf_show_obj_safe() handles the logic that determines if a new
+ * copy_from_kernel_nofault() is needed.
+ */
+struct btf_show {
+	u64 flags;
+	void *target;	/* target of show operation (seq file, buffer) */
+	void (*showfn)(struct btf_show *show, const char *fmt, ...);
+	const struct btf *btf;
+	/* below are used during iteration */
+	struct {
+		u8 depth;
+		u8 depth_to_show;
+		u8 depth_check;
+		u8 array_member:1,
+		   array_terminated:1;
+		u16 array_encoding;
+		u32 type_id;
+		int status;			/* non-zero for error */
+		const struct btf_type *type;
+		const struct btf_member *member;
+		char name[KSYM_NAME_LEN];	/* space for member name/type */
+	} state;
+	struct {
+		u32 size;
+		void *head;
+		void *data;
+		u8 safe[BTF_SHOW_OBJ_SAFE_SIZE];
+	} obj;
+};
+
 struct btf_kind_operations {
 	s32 (*check_meta)(struct btf_verifier_env *env,
 			  const struct btf_type *t,
@@ -298,9 +380,9 @@ struct btf_kind_operations {
 				  const struct btf_type *member_type);
 	void (*log_details)(struct btf_verifier_env *env,
 			    const struct btf_type *t);
-	void (*seq_show)(const struct btf *btf, const struct btf_type *t,
+	void (*show)(const struct btf *btf, const struct btf_type *t,
 			 u32 type_id, void *data, u8 bits_offsets,
-			 struct seq_file *m);
+			 struct btf_show *show);
 };
 
 static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS];
@@ -677,6 +759,458 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 	return true;
 }
 
+/* Similar to btf_type_skip_modifiers() but does not skip typedefs. */
+static inline
+const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf, u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(btf, id);
+
+	while (btf_type_is_modifier(t) &&
+	       BTF_INFO_KIND(t->info) != BTF_KIND_TYPEDEF) {
+		id = t->type;
+		t = btf_type_by_id(btf, t->type);
+	}
+
+	return t;
+}
+
+#define BTF_SHOW_MAX_ITER	10
+
+#define BTF_KIND_BIT(kind)	(1ULL << kind)
+
+/*
+ * Populate show->state.name with type name information.
+ * Format of type name is
+ *
+ * [.member_name = ] (type_name)
+ */
+static inline const char *btf_show_name(struct btf_show *show)
+{
+	/* BTF_MAX_ITER array suffixes "[]" */
+	const char *array_suffixes = "[][][][][][][][][][]";
+	const char *array_suffix = &array_suffixes[strlen(array_suffixes)];
+	/* BTF_MAX_ITER pointer suffixes "*" */
+	const char *ptr_suffixes = "**********";
+	const char *ptr_suffix = &ptr_suffixes[strlen(ptr_suffixes)];
+	const char *name = NULL, *prefix = "", *parens = "";
+	const struct btf_member *m = show->state.member;
+	const struct btf_type *t = show->state.type;
+	const struct btf_array *array;
+	u32 id = show->state.type_id;
+	const char *member = NULL;
+	bool show_member = false;
+	u64 kinds = 0;
+	int i;
+
+	show->state.name[0] = '\0';
+
+	/*
+	 * Don't show type name if we're showing an array member;
+	 * in that case we show the array type so don't need to repeat
+	 * ourselves for each member.
+	 */
+	if (show->state.array_member)
+		return "";
+
+	/* Retrieve member name, if any. */
+	if (m) {
+		member = btf_name_by_offset(show->btf, m->name_off);
+		show_member = strlen(member) > 0;
+		id = m->type;
+	}
+
+	/*
+	 * Start with type_id, as we have have resolved the struct btf_type *
+	 * via btf_modifier_show() past the parent typedef to the child
+	 * struct, int etc it is defined as.  In such cases, the type_id
+	 * still represents the starting type while the the struct btf_type *
+	 * in our show->state points at the resolved type of the typedef.
+	 */
+	t = btf_type_by_id(show->btf, id);
+	if (!t)
+		return "";
+
+	/*
+	 * The goal here is to build up the right number of pointer and
+	 * array suffixes while ensuring the type name for a typedef
+	 * is represented.  Along the way we accumulate a list of
+	 * BTF kinds we have encountered, since these will inform later
+	 * display; for example, pointer types will not require an
+	 * opening "{" for struct, we will just display the pointer value.
+	 *
+	 * We also want to accumulate the right number of pointer or array
+	 * indices in the format string while iterating until we get to
+	 * the typedef/pointee/array member target type.
+	 *
+	 * We start by pointing at the end of pointer and array suffix
+	 * strings; as we accumulate pointers and arrays we move the pointer
+	 * or array string backwards so it will show the expected number of
+	 * '*' or '[]' for the type.  BTF_SHOW_MAX_ITER of nesting of pointers
+	 * and/or arrays and typedefs are supported as a precaution.
+	 *
+	 * We also want to get typedef name while proceeding to resolve
+	 * type it points to so that we can add parentheses if it is a
+	 * "typedef struct" etc.
+	 */
+	for (i = 0; i < BTF_SHOW_MAX_ITER; i++) {
+
+		switch (BTF_INFO_KIND(t->info)) {
+		case BTF_KIND_TYPEDEF:
+			if (!name)
+				name = btf_name_by_offset(show->btf,
+							       t->name_off);
+			kinds |= BTF_KIND_BIT(BTF_KIND_TYPEDEF);
+			id = t->type;
+			break;
+		case BTF_KIND_ARRAY:
+			kinds |= BTF_KIND_BIT(BTF_KIND_ARRAY);
+			parens = "[";
+			if (!t)
+				return "";
+			array = btf_type_array(t);
+			if (array_suffix > array_suffixes)
+				array_suffix -= 2;
+			id = array->type;
+			break;
+		case BTF_KIND_PTR:
+			kinds |= BTF_KIND_BIT(BTF_KIND_PTR);
+			if (ptr_suffix > ptr_suffixes)
+				ptr_suffix -= 1;
+			id = t->type;
+			break;
+		default:
+			id = 0;
+			break;
+		}
+		if (!id)
+			break;
+		t = btf_type_skip_qualifiers(show->btf, id);
+	}
+	/* We may not be able to represent this type; bail to be safe */
+	if (i == BTF_SHOW_MAX_ITER)
+		return "";
+
+	if (!name)
+		name = btf_name_by_offset(show->btf, t->name_off);
+
+	switch (BTF_INFO_KIND(t->info)) {
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		prefix = BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT ?
+			 "struct" : "union";
+		/* if it's an array of struct/union, parens is already set */
+		if (!(kinds & (BTF_KIND_BIT(BTF_KIND_ARRAY))))
+			parens = "{";
+		break;
+	case BTF_KIND_ENUM:
+		prefix = "enum";
+		break;
+	default:
+		break;
+	}
+
+	/* pointer does not require parens */
+	if (kinds & BTF_KIND_BIT(BTF_KIND_PTR))
+		parens = "";
+	/* typedef does not require struct/union/enum prefix */
+	if (kinds & BTF_KIND_BIT(BTF_KIND_TYPEDEF))
+		prefix = "";
+
+	if (!name)
+		name = "";
+
+	/* Even if we don't want type name info, we want parentheses etc */
+	if (show->flags & BTF_SHOW_NONAME)
+		snprintf(show->state.name, sizeof(show->state.name), "%s",
+			 parens);
+	else
+		snprintf(show->state.name, sizeof(show->state.name),
+			 "%s%s%s(%s%s%s%s%s%s)%s",
+			 /* first 3 strings comprise ".member = " */
+			 show_member ? "." : "",
+			 show_member ? member : "",
+			 show_member ? " = " : "",
+			 /* ...next is our prefix (struct, enum, etc) */
+			 prefix,
+			 strlen(prefix) > 0 && strlen(name) > 0 ? " " : "",
+			 /* ...this is the type name itself */
+			 name,
+			 /* ...suffixed by the appropriate '*', '[]' suffixes */
+			 strlen(ptr_suffix) > 0 ? " " : "", ptr_suffix,
+			 array_suffix, parens);
+
+	return show->state.name;
+}
+
+#define btf_show(show, ...)						      \
+	do {								      \
+		if (!show->state.depth_check)				      \
+			show->showfn(show, __VA_ARGS__);		      \
+	} while (0)
+
+static inline const char *__btf_show_indent(struct btf_show *show)
+{
+	const char *indents = "                                ";
+	const char *indent = &indents[strlen(indents)];
+
+	if ((indent - show->state.depth) >= indents)
+		return indent - show->state.depth;
+	return indents;
+}
+
+#define btf_show_indent(show)						       \
+	((show->flags & BTF_SHOW_COMPACT) ? "" : __btf_show_indent(show))
+
+#define btf_show_newline(show)						       \
+	((show->flags & (BTF_SHOW_COMPACT | BTF_SHOW_NONEWLINE)) ? "" : "\n")
+
+#define btf_show_delim(show)						       \
+	(show->state.depth == 0 ? "" :					       \
+	 ((show->flags & BTF_SHOW_COMPACT) && show->state.type &&	       \
+	  BTF_INFO_KIND(show->state.type->info) == BTF_KIND_UNION) ? "|" : ",")
+
+#define btf_show_type_value(show, fmt, value)				       \
+	do {								       \
+		if ((value) != 0 || (show->flags & BTF_SHOW_ZERO) ||	       \
+		    show->state.depth == 0) {				       \
+			btf_show(show, "%s%s" fmt "%s%s",		       \
+				 btf_show_indent(show),			       \
+				 btf_show_name(show),			       \
+				 value, btf_show_delim(show),		       \
+				 btf_show_newline(show));		       \
+			if (show->state.depth > show->state.depth_to_show)     \
+				show->state.depth_to_show = show->state.depth; \
+		}							       \
+	} while (0)
+
+#define btf_show_type_values(show, fmt, ...)				       \
+	do {								       \
+		btf_show(show, "%s%s" fmt "%s%s", btf_show_indent(show),       \
+			 btf_show_name(show),				       \
+			 __VA_ARGS__, btf_show_delim(show),		       \
+			 btf_show_newline(show));			       \
+		if (show->state.depth > show->state.depth_to_show)	       \
+			show->state.depth_to_show = show->state.depth;	       \
+	} while (0)
+
+/* How much is left to copy to safe buffer after @data? */
+#define btf_show_obj_size_left(show, data)				       \
+	(show->obj.head + show->obj.size - data)
+
+/* Is object pointed to by @data of @size already copied to our safe buffer? */
+#define btf_show_obj_is_safe(show, data, size)				       \
+	(data >= show->obj.data &&					       \
+	 (data + size) < (show->obj.data + BTF_SHOW_OBJ_SAFE_SIZE))
+
+/*
+ * If object pointed to by @data of @size falls within our safe buffer, return
+ * the equivalent pointer to the same safe data.  Assumes
+ * copy_from_kernel_nofault() has already happened and our safe buffer is
+ * populated.
+ */
+#define __btf_show_obj_safe(show, data, size)				       \
+	(btf_show_obj_is_safe(show, data, size) ?			       \
+	 show->obj.safe + (data - show->obj.data) : NULL)
+
+/*
+ * Return a safe-to-access version of data pointed to by @data.
+ * We do this by copying the relevant amount of information
+ * to the struct btf_show obj.safe buffer using copy_from_kernel_nofault().
+ *
+ * If BTF_SHOW_UNSAFE is specified, just return data as-is; no
+ * safe copy is needed.
+ *
+ * Otherwise we need to determine if we have the required amount
+ * of data (determined by the @data pointer and the size of the
+ * largest base type we can encounter (represented by
+ * BTF_SHOW_OBJ_BASE_TYPE_SIZE). Having that much data ensures
+ * that we will be able to print some of the current object,
+ * and if more is needed a copy will be triggered.
+ * Some objects such as structs will not fit into the buffer;
+ * in such cases additional copies when we iterate over their
+ * members may be needed.
+ *
+ * btf_show_obj_safe() is used to return a safe buffer for
+ * btf_show_start_type(); this ensures that as we recurse into
+ * nested types we always have safe data for the given type.
+ * This approach is somewhat wasteful; it's possible for example
+ * that when iterating over a large union we'll end up copying the
+ * same data repeatedly, but the goal is safety not performance.
+ * We use stack data as opposed to per-CPU buffers because the
+ * iteration over a type can take some time, and preemption handling
+ * would greatly complicate use of the safe buffer.
+ */
+static inline void *btf_show_obj_safe(struct btf_show *show,
+				      const struct btf_type *t,
+				      void *data)
+{
+	int size_left, size;
+	void *safe = NULL;
+
+	if (show->flags & BTF_SHOW_UNSAFE)
+		return data;
+
+	(void) btf_resolve_size(show->btf, t, &size, NULL, NULL);
+
+	/*
+	 * Is this toplevel object? If so, set total object size and
+	 * initialize pointers.  Otherwise check if we still fall within
+	 * our safe object data.
+	 */
+	if (show->state.depth == 0) {
+		show->obj.size = size;
+		show->obj.head = data;
+	} else {
+		/*
+		 * If the size of the current object is > our remaining
+		 * safe buffer we _may_ need to do a new copy.  However
+		 * consider the case of a nested struct; it's size pushes
+		 * us over the safe buffer limit, but showing any individual
+		 * struct members does not.  In such cases, we don't need
+		 * to initiate a fresh copy yet; however we definitely need
+		 * at least BTF_SHOW_OBJ_BASE_TYPE_SIZE bytes left
+		 * in our buffer, regardless of the current object size.
+		 * The logic here is that as we resolve types we will
+		 * hit a base type at some point, and we need to be sure
+		 * the next chunk of data is safely available to display
+		 * that type info safely.  We cannot rely on the size of
+		 * the current object here because it may be much larger
+		 * than our current buffer (e.g. task_struct is 8k).
+		 * All we want to do here is ensure that we can print the
+		 * next basic type, which we can if either
+		 * - the current type size is within the safe buffer; or
+		 * - at least BTF_SHOW_OBJ_BASE_TYPE_SIZE bytes are left in
+		 *   the safe buffer.
+		 */
+		safe = __btf_show_obj_safe(show, data,
+					   min(size,
+					       BTF_SHOW_OBJ_BASE_TYPE_SIZE));
+	}
+
+	/*
+	 * We need a new copy to our safe object, either because we haven't
+	 * yet copied and are intializing safe data, or because the data
+	 * we want falls outside the boundaries of the safe object.
+	 */
+	if (!safe) {
+		size_left = btf_show_obj_size_left(show, data);
+		if (size_left > BTF_SHOW_OBJ_SAFE_SIZE)
+			size_left = BTF_SHOW_OBJ_SAFE_SIZE;
+		show->state.status = copy_from_kernel_nofault(show->obj.safe,
+							      data,
+							      size_left);
+		if (!show->state.status) {
+			show->obj.data = data;
+			safe = show->obj.safe;
+		}
+	}
+
+	return safe;
+}
+
+/*
+ * Set the type we are starting to show and return a safe data pointer
+ * to be used for showing the associated data.
+ */
+static inline void *btf_show_start_type(struct btf_show *show,
+					const struct btf_type *t,
+					u32 type_id,
+					void *data)
+{
+	show->state.type = t;
+	show->state.type_id = type_id;
+	show->state.name[0] = '\0';
+
+	return btf_show_obj_safe(show, t, data);
+}
+
+static inline void btf_show_end_type(struct btf_show *show)
+{
+	show->state.type = NULL;
+	show->state.type_id = 0;
+	show->state.name[0] = '\0';
+}
+
+static inline void *btf_show_start_aggr_type(struct btf_show *show,
+					     const struct btf_type *t,
+					     u32 type_id,
+					     void *data)
+{
+	void *safe_data = btf_show_start_type(show, t, type_id, data);
+
+	if (!safe_data)
+		return safe_data;
+
+	btf_show(show, "%s%s%s", btf_show_indent(show),
+		 btf_show_name(show),
+		 btf_show_newline(show));
+	show->state.depth++;
+	return safe_data;
+}
+
+static inline void btf_show_end_aggr_type(struct btf_show *show,
+					  const char *suffix)
+{
+	show->state.depth--;
+	btf_show(show, "%s%s%s%s", btf_show_indent(show), suffix,
+		 btf_show_delim(show), btf_show_newline(show));
+	btf_show_end_type(show);
+}
+
+static inline void btf_show_start_member(struct btf_show *show,
+					 const struct btf_member *m)
+{
+	show->state.member = m;
+}
+
+static inline void btf_show_start_array_member(struct btf_show *show)
+{
+	show->state.array_member = 1;
+	btf_show_start_member(show, NULL);
+}
+
+static inline void btf_show_end_member(struct btf_show *show)
+{
+	show->state.member = NULL;
+}
+
+static inline void btf_show_end_array_member(struct btf_show *show)
+{
+	show->state.array_member = 0;
+	btf_show_end_member(show);
+}
+
+static inline void *btf_show_start_array_type(struct btf_show *show,
+					      const struct btf_type *t,
+					      u32 type_id,
+					      u16 array_encoding,
+					      void *data)
+{
+	show->state.array_encoding = array_encoding;
+	show->state.array_terminated = 0;
+	return btf_show_start_aggr_type(show, t, type_id, data);
+}
+
+static inline void btf_show_end_array_type(struct btf_show *show)
+{
+	show->state.array_encoding = 0;
+	show->state.array_terminated = 0;
+	btf_show_end_aggr_type(show, "]");
+}
+
+static inline void *btf_show_start_struct_type(struct btf_show *show,
+					       const struct btf_type *t,
+					       u32 type_id,
+					       void *data)
+{
+	return btf_show_start_aggr_type(show, t, type_id, data);
+}
+
+static inline void btf_show_end_struct_type(struct btf_show *show)
+{
+	btf_show_end_aggr_type(show, "}");
+}
+
 __printf(2, 3) static void __btf_verifier_log(struct bpf_verifier_log *log,
 					      const char *fmt, ...)
 {
@@ -1250,11 +1784,11 @@ static int btf_df_resolve(struct btf_verifier_env *env,
 	return -EINVAL;
 }
 
-static void btf_df_seq_show(const struct btf *btf, const struct btf_type *t,
-			    u32 type_id, void *data, u8 bits_offsets,
-			    struct seq_file *m)
+static void btf_df_show(const struct btf *btf, const struct btf_type *t,
+			u32 type_id, void *data, u8 bits_offsets,
+			struct btf_show *show)
 {
-	seq_printf(m, "<unsupported kind:%u>", BTF_INFO_KIND(t->info));
+	btf_show(show, "<unsupported kind:%u>", BTF_INFO_KIND(t->info));
 }
 
 static int btf_int_check_member(struct btf_verifier_env *env,
@@ -1427,7 +1961,7 @@ static void btf_int_log(struct btf_verifier_env *env,
 			 btf_int_encoding_str(BTF_INT_ENCODING(int_data)));
 }
 
-static void btf_int128_print(struct seq_file *m, void *data)
+static void btf_int128_print(struct btf_show *show, void *data)
 {
 	/* data points to a __int128 number.
 	 * Suppose
@@ -1446,9 +1980,10 @@ static void btf_int128_print(struct seq_file *m, void *data)
 	lower_num = *(u64 *)data;
 #endif
 	if (upper_num == 0)
-		seq_printf(m, "0x%llx", lower_num);
+		btf_show_type_value(show, "0x%llx", lower_num);
 	else
-		seq_printf(m, "0x%llx%016llx", upper_num, lower_num);
+		btf_show_type_values(show, "0x%llx%016llx", upper_num,
+				     lower_num);
 }
 
 static void btf_int128_shift(u64 *print_num, u16 left_shift_bits,
@@ -1492,8 +2027,8 @@ static void btf_int128_shift(u64 *print_num, u16 left_shift_bits,
 #endif
 }
 
-static void btf_bitfield_seq_show(void *data, u8 bits_offset,
-				  u8 nr_bits, struct seq_file *m)
+static void btf_bitfield_show(void *data, u8 bits_offset,
+			      u8 nr_bits, struct btf_show *show)
 {
 	u16 left_shift_bits, right_shift_bits;
 	u8 nr_copy_bytes;
@@ -1513,14 +2048,14 @@ static void btf_bitfield_seq_show(void *data, u8 bits_offset,
 	right_shift_bits = BITS_PER_U128 - nr_bits;
 
 	btf_int128_shift(print_num, left_shift_bits, right_shift_bits);
-	btf_int128_print(m, print_num);
+	btf_int128_print(show, print_num);
 }
 
 
-static void btf_int_bits_seq_show(const struct btf *btf,
-				  const struct btf_type *t,
-				  void *data, u8 bits_offset,
-				  struct seq_file *m)
+static void btf_int_bits_show(const struct btf *btf,
+			      const struct btf_type *t,
+			      void *data, u8 bits_offset,
+			      struct btf_show *show)
 {
 	u32 int_data = btf_type_int(t);
 	u8 nr_bits = BTF_INT_BITS(int_data);
@@ -1533,55 +2068,77 @@ static void btf_int_bits_seq_show(const struct btf *btf,
 	total_bits_offset = bits_offset + BTF_INT_OFFSET(int_data);
 	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
 	bits_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
-	btf_bitfield_seq_show(data, bits_offset, nr_bits, m);
+	btf_bitfield_show(data, bits_offset, nr_bits, show);
 }
 
-static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,
-			     u32 type_id, void *data, u8 bits_offset,
-			     struct seq_file *m)
+static void btf_int_show(const struct btf *btf, const struct btf_type *t,
+			 u32 type_id, void *data, u8 bits_offset,
+			 struct btf_show *show)
 {
 	u32 int_data = btf_type_int(t);
 	u8 encoding = BTF_INT_ENCODING(int_data);
 	bool sign = encoding & BTF_INT_SIGNED;
 	u8 nr_bits = BTF_INT_BITS(int_data);
+	void *safe_data;
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
+	if (!safe_data)
+		return;
 
 	if (bits_offset || BTF_INT_OFFSET(int_data) ||
 	    BITS_PER_BYTE_MASKED(nr_bits)) {
-		btf_int_bits_seq_show(btf, t, data, bits_offset, m);
-		return;
+		btf_int_bits_show(btf, t, safe_data, bits_offset, show);
+		goto out;
 	}
 
 	switch (nr_bits) {
 	case 128:
-		btf_int128_print(m, data);
+		btf_int128_print(show, safe_data);
 		break;
 	case 64:
 		if (sign)
-			seq_printf(m, "%lld", *(s64 *)data);
+			btf_show_type_value(show, "%lld", *(s64 *)safe_data);
 		else
-			seq_printf(m, "%llu", *(u64 *)data);
+			btf_show_type_value(show, "%llu", *(u64 *)safe_data);
 		break;
 	case 32:
 		if (sign)
-			seq_printf(m, "%d", *(s32 *)data);
+			btf_show_type_value(show, "%d", *(s32 *)safe_data);
 		else
-			seq_printf(m, "%u", *(u32 *)data);
+			btf_show_type_value(show, "%u", *(u32 *)safe_data);
 		break;
 	case 16:
 		if (sign)
-			seq_printf(m, "%d", *(s16 *)data);
+			btf_show_type_value(show, "%d", *(s16 *)safe_data);
 		else
-			seq_printf(m, "%u", *(u16 *)data);
+			btf_show_type_value(show, "%u", *(u16 *)safe_data);
 		break;
 	case 8:
+		if (show->state.array_encoding == BTF_INT_CHAR) {
+			/* check for null terminator */
+			if (show->state.array_terminated)
+				break;
+			if (*(char *)data == '\0') {
+				show->state.array_terminated = 1;
+				break;
+			}
+			if (isprint(*(char *)data)) {
+				btf_show_type_value(show, "'%c'",
+						    *(char *)safe_data);
+				break;
+			}
+		}
 		if (sign)
-			seq_printf(m, "%d", *(s8 *)data);
+			btf_show_type_value(show, "%d", *(s8 *)safe_data);
 		else
-			seq_printf(m, "%u", *(u8 *)data);
+			btf_show_type_value(show, "%u", *(u8 *)safe_data);
 		break;
 	default:
-		btf_int_bits_seq_show(btf, t, data, bits_offset, m);
+		btf_int_bits_show(btf, t, safe_data, bits_offset, show);
+		break;
 	}
+out:
+	btf_show_end_type(show);
 }
 
 static const struct btf_kind_operations int_ops = {
@@ -1590,7 +2147,7 @@ static void btf_int_seq_show(const struct btf *btf, const struct btf_type *t,
 	.check_member = btf_int_check_member,
 	.check_kflag_member = btf_int_check_kflag_member,
 	.log_details = btf_int_log,
-	.seq_show = btf_int_seq_show,
+	.show = btf_int_show,
 };
 
 static int btf_modifier_check_member(struct btf_verifier_env *env,
@@ -1854,34 +2411,44 @@ static int btf_ptr_resolve(struct btf_verifier_env *env,
 	return 0;
 }
 
-static void btf_modifier_seq_show(const struct btf *btf,
-				  const struct btf_type *t,
-				  u32 type_id, void *data,
-				  u8 bits_offset, struct seq_file *m)
+static void btf_modifier_show(const struct btf *btf,
+			      const struct btf_type *t,
+			      u32 type_id, void *data,
+			      u8 bits_offset, struct btf_show *show)
 {
 	if (btf->resolved_ids)
 		t = btf_type_id_resolve(btf, &type_id);
 	else
 		t = btf_type_skip_modifiers(btf, type_id, NULL);
 
-	btf_type_ops(t)->seq_show(btf, t, type_id, data, bits_offset, m);
+	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
 
-static void btf_var_seq_show(const struct btf *btf, const struct btf_type *t,
-			     u32 type_id, void *data, u8 bits_offset,
-			     struct seq_file *m)
+static void btf_var_show(const struct btf *btf, const struct btf_type *t,
+			 u32 type_id, void *data, u8 bits_offset,
+			 struct btf_show *show)
 {
 	t = btf_type_id_resolve(btf, &type_id);
 
-	btf_type_ops(t)->seq_show(btf, t, type_id, data, bits_offset, m);
+	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
 
-static void btf_ptr_seq_show(const struct btf *btf, const struct btf_type *t,
-			     u32 type_id, void *data, u8 bits_offset,
-			     struct seq_file *m)
+static void btf_ptr_show(const struct btf *btf, const struct btf_type *t,
+			 u32 type_id, void *data, u8 bits_offset,
+			 struct btf_show *show)
 {
-	/* It is a hashed value */
-	seq_printf(m, "%p", *(void **)data);
+	void *safe_data;
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
+	if (!safe_data)
+		return;
+
+	/* It is a hashed value unless BTF_SHOW_PTR_RAW is specified */
+	if (show->flags & BTF_SHOW_PTR_RAW)
+		btf_show_type_value(show, "0x%px", *(void **)safe_data);
+	else
+		btf_show_type_value(show, "0x%p", *(void **)safe_data);
+	btf_show_end_type(show);
 }
 
 static void btf_ref_type_log(struct btf_verifier_env *env,
@@ -1896,7 +2463,7 @@ static void btf_ref_type_log(struct btf_verifier_env *env,
 	.check_member = btf_modifier_check_member,
 	.check_kflag_member = btf_modifier_check_kflag_member,
 	.log_details = btf_ref_type_log,
-	.seq_show = btf_modifier_seq_show,
+	.show = btf_modifier_show,
 };
 
 static struct btf_kind_operations ptr_ops = {
@@ -1905,7 +2472,7 @@ static void btf_ref_type_log(struct btf_verifier_env *env,
 	.check_member = btf_ptr_check_member,
 	.check_kflag_member = btf_generic_check_kflag_member,
 	.log_details = btf_ref_type_log,
-	.seq_show = btf_ptr_seq_show,
+	.show = btf_ptr_show,
 };
 
 static s32 btf_fwd_check_meta(struct btf_verifier_env *env,
@@ -1946,7 +2513,7 @@ static void btf_fwd_type_log(struct btf_verifier_env *env,
 	.check_member = btf_df_check_member,
 	.check_kflag_member = btf_df_check_kflag_member,
 	.log_details = btf_fwd_type_log,
-	.seq_show = btf_df_seq_show,
+	.show = btf_df_show,
 };
 
 static int btf_array_check_member(struct btf_verifier_env *env,
@@ -2105,28 +2672,90 @@ static void btf_array_log(struct btf_verifier_env *env,
 			 array->type, array->index_type, array->nelems);
 }
 
-static void btf_array_seq_show(const struct btf *btf, const struct btf_type *t,
-			       u32 type_id, void *data, u8 bits_offset,
-			       struct seq_file *m)
+static void __btf_array_show(const struct btf *btf, const struct btf_type *t,
+			     u32 type_id, void *data, u8 bits_offset,
+			     struct btf_show *show)
 {
 	const struct btf_array *array = btf_type_array(t);
 	const struct btf_kind_operations *elem_ops;
 	const struct btf_type *elem_type;
-	u32 i, elem_size, elem_type_id;
+	u32 i, elem_size = 0, elem_type_id;
+	u16 encoding = 0;
 
 	elem_type_id = array->type;
-	elem_type = btf_type_id_size(btf, &elem_type_id, &elem_size);
+	elem_type = btf_type_skip_modifiers(btf, elem_type_id, NULL);
+	if (elem_type && btf_type_has_size(elem_type))
+		elem_size = elem_type->size;
+
+	if (elem_type && btf_type_is_int(elem_type)) {
+		u32 int_type = btf_type_int(elem_type);
+
+		encoding = BTF_INT_ENCODING(int_type);
+
+		/*
+		 * BTF_INT_CHAR encoding never seems to be set for
+		 * char arrays, so if size is 1 and element is
+		 * printable as a char, we'll do that.
+		 */
+		if (elem_size == 1)
+			encoding = BTF_INT_CHAR;
+	}
+
+	if (!btf_show_start_array_type(show, t, type_id, encoding, data))
+		return;
+
+	if (!elem_type)
+		goto out;
 	elem_ops = btf_type_ops(elem_type);
-	seq_puts(m, "[");
+
 	for (i = 0; i < array->nelems; i++) {
-		if (i)
-			seq_puts(m, ",");
 
-		elem_ops->seq_show(btf, elem_type, elem_type_id, data,
-				   bits_offset, m);
+		btf_show_start_array_member(show);
+
+		elem_ops->show(btf, elem_type, elem_type_id, data,
+			       bits_offset, show);
 		data += elem_size;
+
+		btf_show_end_array_member(show);
+
+		if (show->state.array_terminated)
+			break;
+	}
+out:
+	btf_show_end_array_type(show);
+}
+
+static void btf_array_show(const struct btf *btf, const struct btf_type *t,
+			   u32 type_id, void *data, u8 bits_offset,
+			   struct btf_show *show)
+{
+	const struct btf_member *m = show->state.member;
+
+	/*
+	 * First check if any members would be shown (are non-zero).
+	 * See comments above "struct btf_show" definition for more
+	 * details on how this works at a high-level.
+	 */
+	if (show->state.depth > 0 && !(show->flags & BTF_SHOW_ZERO)) {
+		if (!show->state.depth_check) {
+			show->state.depth_check = show->state.depth + 1;
+			show->state.depth_to_show = 0;
+		}
+		__btf_array_show(btf, t, type_id, data, bits_offset, show);
+		show->state.member = m;
+
+		if (show->state.depth_check != show->state.depth + 1)
+			return;
+		show->state.depth_check = 0;
+
+		if (show->state.depth_to_show <= show->state.depth)
+			return;
+		/*
+		 * Reaching here indicates we have recursed and found
+		 * non-zero array member(s).
+		 */
 	}
-	seq_puts(m, "]");
+	__btf_array_show(btf, t, type_id, data, bits_offset, show);
 }
 
 static struct btf_kind_operations array_ops = {
@@ -2135,7 +2764,7 @@ static void btf_array_seq_show(const struct btf *btf, const struct btf_type *t,
 	.check_member = btf_array_check_member,
 	.check_kflag_member = btf_generic_check_kflag_member,
 	.log_details = btf_array_log,
-	.seq_show = btf_array_seq_show,
+	.show = btf_array_show,
 };
 
 static int btf_struct_check_member(struct btf_verifier_env *env,
@@ -2358,15 +2987,18 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
 	return off;
 }
 
-static void btf_struct_seq_show(const struct btf *btf, const struct btf_type *t,
-				u32 type_id, void *data, u8 bits_offset,
-				struct seq_file *m)
+static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
+			      u32 type_id, void *data, u8 bits_offset,
+			      struct btf_show *show)
 {
-	const char *seq = BTF_INFO_KIND(t->info) == BTF_KIND_UNION ? "|" : ",";
 	const struct btf_member *member;
+	void *safe_data;
 	u32 i;
 
-	seq_puts(m, "{");
+	safe_data = btf_show_start_struct_type(show, t, type_id, data);
+	if (!safe_data)
+		return;
+
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								member->type);
@@ -2375,23 +3007,60 @@ static void btf_struct_seq_show(const struct btf *btf, const struct btf_type *t,
 		u32 bytes_offset;
 		u8 bits8_offset;
 
-		if (i)
-			seq_puts(m, seq);
+		btf_show_start_member(show, member);
 
 		member_offset = btf_member_bit_offset(t, member);
 		bitfield_size = btf_member_bitfield_size(t, member);
 		bytes_offset = BITS_ROUNDDOWN_BYTES(member_offset);
 		bits8_offset = BITS_PER_BYTE_MASKED(member_offset);
 		if (bitfield_size) {
-			btf_bitfield_seq_show(data + bytes_offset, bits8_offset,
-					      bitfield_size, m);
+			btf_bitfield_show(safe_data + bytes_offset,
+					  bits8_offset,
+					  bitfield_size, show);
 		} else {
 			ops = btf_type_ops(member_type);
-			ops->seq_show(btf, member_type, member->type,
-				      data + bytes_offset, bits8_offset, m);
+			ops->show(btf, member_type, member->type,
+				  data + bytes_offset, bits8_offset, show);
 		}
+
+		btf_show_end_member(show);
 	}
-	seq_puts(m, "}");
+
+	btf_show_end_struct_type(show);
+}
+
+static void btf_struct_show(const struct btf *btf, const struct btf_type *t,
+			    u32 type_id, void *data, u8 bits_offset,
+			    struct btf_show *show)
+{
+	const struct btf_member *m = show->state.member;
+
+	/*
+	 * First check if any members would be shown (are non-zero).
+	 * See comments above "struct btf_show" definition for more
+	 * details on how this works at a high-level.
+	 */
+	if (show->state.depth > 0 && !(show->flags & BTF_SHOW_ZERO)) {
+		if (!show->state.depth_check) {
+			show->state.depth_check = show->state.depth + 1;
+			show->state.depth_to_show = 0;
+		}
+		__btf_struct_show(btf, t, type_id, data, bits_offset, show);
+		/* Restore saved member data here */
+		show->state.member = m;
+		if (show->state.depth_check != show->state.depth + 1)
+			return;
+		show->state.depth_check = 0;
+
+		if (show->state.depth_to_show <= show->state.depth)
+			return;
+		/*
+		 * Reaching here indicates we have recursed and found
+		 * non-zero child values.
+		 */
+	}
+
+	__btf_struct_show(btf, t, type_id, data, bits_offset, show);
 }
 
 static struct btf_kind_operations struct_ops = {
@@ -2400,7 +3069,7 @@ static void btf_struct_seq_show(const struct btf *btf, const struct btf_type *t,
 	.check_member = btf_struct_check_member,
 	.check_kflag_member = btf_generic_check_kflag_member,
 	.log_details = btf_struct_log,
-	.seq_show = btf_struct_seq_show,
+	.show = btf_struct_show,
 };
 
 static int btf_enum_check_member(struct btf_verifier_env *env,
@@ -2531,24 +3200,35 @@ static void btf_enum_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
-static void btf_enum_seq_show(const struct btf *btf, const struct btf_type *t,
-			      u32 type_id, void *data, u8 bits_offset,
-			      struct seq_file *m)
+static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
+			  u32 type_id, void *data, u8 bits_offset,
+			  struct btf_show *show)
 {
 	const struct btf_enum *enums = btf_type_enum(t);
 	u32 i, nr_enums = btf_type_vlen(t);
-	int v = *(int *)data;
+	void *safe_data;
+	int v;
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
+	if (!safe_data)
+		return;
+
+	v = *(int *)safe_data;
 
 	for (i = 0; i < nr_enums; i++) {
-		if (v == enums[i].val) {
-			seq_printf(m, "%s",
-				   __btf_name_by_offset(btf,
-							enums[i].name_off));
-			return;
-		}
+		if (v != enums[i].val)
+			continue;
+
+		btf_show_type_value(show, "%s",
+				    __btf_name_by_offset(btf,
+							 enums[i].name_off));
+
+		btf_show_end_type(show);
+		return;
 	}
 
-	seq_printf(m, "%d", v);
+	btf_show_type_value(show, "%d", v);
+	btf_show_end_type(show);
 }
 
 static struct btf_kind_operations enum_ops = {
@@ -2557,7 +3237,7 @@ static void btf_enum_seq_show(const struct btf *btf, const struct btf_type *t,
 	.check_member = btf_enum_check_member,
 	.check_kflag_member = btf_enum_check_kflag_member,
 	.log_details = btf_enum_log,
-	.seq_show = btf_enum_seq_show,
+	.show = btf_enum_show,
 };
 
 static s32 btf_func_proto_check_meta(struct btf_verifier_env *env,
@@ -2644,7 +3324,7 @@ static void btf_func_proto_log(struct btf_verifier_env *env,
 	.check_member = btf_df_check_member,
 	.check_kflag_member = btf_df_check_kflag_member,
 	.log_details = btf_func_proto_log,
-	.seq_show = btf_df_seq_show,
+	.show = btf_df_show,
 };
 
 static s32 btf_func_check_meta(struct btf_verifier_env *env,
@@ -2678,7 +3358,7 @@ static s32 btf_func_check_meta(struct btf_verifier_env *env,
 	.check_member = btf_df_check_member,
 	.check_kflag_member = btf_df_check_kflag_member,
 	.log_details = btf_ref_type_log,
-	.seq_show = btf_df_seq_show,
+	.show = btf_df_show,
 };
 
 static s32 btf_var_check_meta(struct btf_verifier_env *env,
@@ -2742,7 +3422,7 @@ static void btf_var_log(struct btf_verifier_env *env, const struct btf_type *t)
 	.check_member		= btf_df_check_member,
 	.check_kflag_member	= btf_df_check_kflag_member,
 	.log_details		= btf_var_log,
-	.seq_show		= btf_var_seq_show,
+	.show			= btf_var_show,
 };
 
 static s32 btf_datasec_check_meta(struct btf_verifier_env *env,
@@ -2868,24 +3548,28 @@ static void btf_datasec_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
-static void btf_datasec_seq_show(const struct btf *btf,
-				 const struct btf_type *t, u32 type_id,
-				 void *data, u8 bits_offset,
-				 struct seq_file *m)
+static void btf_datasec_show(const struct btf *btf,
+			     const struct btf_type *t, u32 type_id,
+			     void *data, u8 bits_offset,
+			     struct btf_show *show)
 {
 	const struct btf_var_secinfo *vsi;
 	const struct btf_type *var;
 	u32 i;
 
-	seq_printf(m, "section (\"%s\") = {", __btf_name_by_offset(btf, t->name_off));
+	if (!btf_show_start_type(show, t, type_id, data))
+		return;
+
+	btf_show_type_value(show, "section (\"%s\") = {",
+			    __btf_name_by_offset(btf, t->name_off));
 	for_each_vsi(i, t, vsi) {
 		var = btf_type_by_id(btf, vsi->type);
 		if (i)
-			seq_puts(m, ",");
-		btf_type_ops(var)->seq_show(btf, var, vsi->type,
-					    data + vsi->offset, bits_offset, m);
+			btf_show(show, ",");
+		btf_type_ops(var)->show(btf, var, vsi->type,
+					data + vsi->offset, bits_offset, show);
 	}
-	seq_puts(m, "}");
+	btf_show_end_type(show);
 }
 
 static const struct btf_kind_operations datasec_ops = {
@@ -2894,7 +3578,7 @@ static void btf_datasec_seq_show(const struct btf *btf,
 	.check_member		= btf_df_check_member,
 	.check_kflag_member	= btf_df_check_kflag_member,
 	.log_details		= btf_datasec_log,
-	.seq_show		= btf_datasec_seq_show,
+	.show			= btf_datasec_show,
 };
 
 static int btf_func_proto_check(struct btf_verifier_env *env,
@@ -4516,12 +5200,84 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 	return 0;
 }
 
-void btf_type_seq_show(const struct btf *btf, u32 type_id, void *obj,
-		       struct seq_file *m)
+void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
+		   struct btf_show *show)
 {
 	const struct btf_type *t = btf_type_by_id(btf, type_id);
 
-	btf_type_ops(t)->seq_show(btf, t, type_id, obj, 0, m);
+	show->btf = btf;
+	memset(&show->state, 0, sizeof(show->state));
+	memset(&show->obj, 0, sizeof(show->obj));
+
+	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
+}
+
+static void btf_seq_show(struct btf_show *show, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	seq_vprintf((struct seq_file *)show->target, fmt, args);
+	va_end(args);
+}
+
+void btf_type_seq_show(const struct btf *btf, u32 type_id, void *obj,
+			struct seq_file *m)
+{
+	struct btf_show sseq;
+
+	sseq.target = m;
+	sseq.showfn = btf_seq_show;
+	sseq.flags = BTF_SHOW_NONAME | BTF_SHOW_COMPACT | BTF_SHOW_ZERO |
+		     BTF_SHOW_UNSAFE;
+
+	btf_type_show(btf, type_id, obj, &sseq);
+}
+
+/* pass in trace id and record number of bytes written. */
+struct btf_show_trace {
+	struct btf_show show;
+	__u32 trace_id;
+	int len;		/* length written */
+};
+
+static void btf_trace_show(struct btf_show *show, const char *fmt, ...)
+{
+	struct btf_show_trace *strace = (struct btf_show_trace *)show;
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = bpf_trace_vprintk(strace->trace_id, fmt, args);
+	va_end(args);
+
+	if (len > 0)
+		strace->len += len;
+}
+
+int btf_type_trace_show(const struct btf *btf, u32 type_id, void *obj,
+			u32 trace_id, u64 flags)
+{
+	struct btf_show_trace strace;
+
+	strace.show.showfn = btf_trace_show;
+	strace.show.target = NULL;
+	/* Each trace event in object display is already emitted on a different
+	 * line; suppress show newline output to avoid a double newline after
+	 * each event.
+	 */
+	strace.show.flags = flags | BTF_SHOW_NONEWLINE;
+	strace.trace_id = trace_id;
+	strace.len = 0;
+
+	btf_type_show(btf, type_id, obj, (struct btf_show *)&strace);
+
+	/* If we encontered an error, return it. */
+	if (strace.show.state.status)
+		return strace.show.state.status;
+
+	/* Otherwise return length we would have written */
+	return strace.len;
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cb91ef9..6453a75 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -383,26 +383,35 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 
 #define BPF_TRACE_PRINTK_SIZE   1024
 
-static inline __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
+int bpf_trace_vprintk(__u32 trace_id, const char *fmt, va_list ap)
 {
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
-	va_list ap;
 	int ret;
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	va_start(ap, fmt);
 	ret = vsnprintf(buf, sizeof(buf), fmt, ap);
-	va_end(ap);
 	/* vsnprintf() will not append null for zero-length strings */
 	if (ret == 0)
 		buf[0] = '\0';
-	trace_bpf_trace_printk(buf);
+	trace_bpf_trace_printk(buf, trace_id);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
 	return ret;
 }
 
+static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = bpf_trace_vprintk(0, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+
 /*
  * Only limited trace_printk() conversion specifiers allowed:
  * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
index 9acbc11..5c401b3 100644
--- a/kernel/trace/bpf_trace.h
+++ b/kernel/trace/bpf_trace.h
@@ -10,16 +10,18 @@
 
 TRACE_EVENT(bpf_trace_printk,
 
-	TP_PROTO(const char *bpf_string),
+	TP_PROTO(const char *bpf_string, __u32 trace_id),
 
-	TP_ARGS(bpf_string),
+	TP_ARGS(bpf_string, trace_id),
 
 	TP_STRUCT__entry(
 		__string(bpf_string, bpf_string)
+		__field(__u32, trace_id)
 	),
 
 	TP_fast_assign(
 		__assign_str(bpf_string, bpf_string);
+		__entry->trace_id = trace_id;
 	),
 
 	TP_printk("%s", __get_str(bpf_string))
-- 
1.8.3.1

