Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0638C60D6C8
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJYWIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiJYWII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:08:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A2928E18;
        Tue, 25 Oct 2022 15:08:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t4so8982497wmj.5;
        Tue, 25 Oct 2022 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTmRXzwW0CCkHy3orngV9NTlnfKAMCpHr0hoJjGuZSA=;
        b=d6f3CQtuPksY23YC/O+Wb0oxKOmgmOzwHYjuzQpMQmuZL70YDm2vwXbvrSTkqXR0b5
         AB+mqMwqW1NvdNX0lYc+jhSKyU7B5cL55eJOxM/I+6M8+pqwmEAqFI6KXu6XVRqn4AZ7
         UWbxKYq+Y2cEh093kl+eXIECHyj21EAgkHURlrUGgujb9kzAVljD1JX7Nc2CAmQhi1tF
         NPTzwK80ci6YBIju2GfWaAa13h6M31U3YNU4t2yTrLh18A2j8xflPhvNdfwd9TIB85Lp
         hWrI/X9OPYn7eMMYmxBZuopT26KHiQuyft8TQl/cQ0hvVN2/FVaWxXDQcX5pT6Kc9QzL
         lTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTmRXzwW0CCkHy3orngV9NTlnfKAMCpHr0hoJjGuZSA=;
        b=IAk9QMIyk365W8Wa+4wjxEXHCV5rb+gSpOoVvKxBTFA73eudhPhSdjvyphnWvytXIZ
         DMuQRIy2M7Jb5ZmXyQ9K7/Xa1q5Z2xObBm4ZgcyS559gkjbJOBceGRfmSytGQVQTDbk8
         xDpc76pDtCj/hZB1+2Rw6nB4/8o9CEJ5SO4INtFvgRo3UYJO9wjBBEz97draraDii7Is
         3DCTb+u+4PojKnTh0HuWwFZHREogG18+WxCH2zyS89hyauMuCbM55H/6AFUNkq2K9QZe
         51qm+q5uk3fbTxjifgm7uqjCyRMnvMmehiIuBS5C+6QoRosQ0lrxR/ECKLEbk7ZUegiR
         BFtA==
X-Gm-Message-State: ACrzQf3DgQ71N7Mke3JyjpexCP031U7bTAD/w6IblZq15KiFLCFwdXHP
        vZHMdo6H7evktUELBjgaWjaQBmlnicj8s0wn
X-Google-Smtp-Source: AMsMyM7zrxiG0K95N9Ep82Tf9vzI2r0smLHsA0+bu8zAbWRobiUNcE8e1ve1AST/J565LShZDXOWhQ==
X-Received: by 2002:a05:600c:a4c:b0:3b4:fc1b:81 with SMTP id c12-20020a05600c0a4c00b003b4fc1b0081mr234967wmq.125.1666735684922;
        Tue, 25 Oct 2022 15:08:04 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x2-20020adff642000000b0022a3a887ceasm3657046wrp.49.2022.10.25.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:08:04 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC dwarves 1/1] pahole: Save header guard names when --header_guards_db is passed
Date:   Wed, 26 Oct 2022 01:07:29 +0300
Message-Id: <20221025220729.2293891-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025220729.2293891-1-eddyz87@gmail.com>
References: <20221025220729.2293891-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds a parameter --header_guards_db. The parameter should point to a
file that associates header file names with names of a C pre-processor
variables used as a double include guards (dubbed as "header guard"s).

For each emitted type the DWARF attribute DW_AT_decl_file is checked,
when the file name is present in the header guards DB a fake
BTF_KIND_DECL_TAG record of the following form is emitted:
- type: the id of the emitted type;
- name_off: a string "header_guard:<guard>".

For example if DB record is present for 'tcphdr' the emitted BTF would
look as follows:

$ bpftool btf dump file vmlinux
...
[24139] STRUCT 'tcphdr' size=20 vlen=17
  ...
[24296] DECL_TAG 'header_guard:_UAPI_LINUX_TCP_H' type_id=24139 ...

The DB file format:
- one record per line;
- record format: <file-name> <guard>;
- spaces are not allowed in neither <file-name> nor <guard>.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++----
 btf_encoder.h |   3 +-
 dutil.c       |  20 +++++++---
 dutil.h       |   1 +
 dwarves.h     |   1 +
 pahole.c      |  99 +++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 210 insertions(+), 17 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a5fa04a..de96a7e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -22,6 +22,7 @@
 #include <inttypes.h>
 #include <limits.h>
 
+#include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -75,6 +76,7 @@ struct btf_encoder {
 		int		    allocated;
 		int		    cnt;
 	} functions;
+	struct strlist *header_guards_db;
 };
 
 void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
@@ -1408,7 +1410,8 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose,
+				     struct strlist *header_guards_db)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
@@ -1429,6 +1432,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		encoder->header_guards_db = header_guards_db;
 
 		GElf_Ehdr ehdr;
 
@@ -1505,6 +1509,68 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	free(encoder);
 }
 
+#define DECL_FILE_HEADER_GUARD_TAG "header_guard:"
+
+/*
+ * For a given tag check if file name associated with it is present in
+ * header_guards_db. If present, emit a fake BTF_KIND_DECL_TAG record
+ * associated with this tag with a value of form "header_guard:<guard-name>".
+ */
+int btf_encoder__maybe_add_header_guard_tag(struct btf_encoder *encoder,
+					    struct tag *tag,
+					    struct cu *cu,
+					    int btf_type_id)
+{
+	const char *decl_file;
+	char *guard = NULL;
+	size_t guard_len;
+	char buf[256];
+
+	if (tag__type(tag)->declaration)
+		return 0;
+
+	decl_file = tag__decl_file(tag, cu);
+
+	if (!decl_file)
+		return 0;
+
+	if (strstarts(decl_file, "./"))
+		decl_file = &decl_file[2];
+
+	/* Ignore a possibility of an absolute path in the file name for now */
+
+	__strlist__has_entry(encoder->header_guards_db, decl_file, (void **)&guard);
+	if (!guard)
+		return 0;
+
+	guard_len = strlen(decl_file);
+	if (guard_len + strlen(DECL_FILE_HEADER_GUARD_TAG) + 1 > sizeof(buf)) {
+		fprintf(stderr, "error: uapi decl file name '%s' is too long (%lu)\n",
+			decl_file, guard_len);
+		return -1;
+	}
+	strcpy(buf, DECL_FILE_HEADER_GUARD_TAG);
+	strcpy(&buf[sizeof(DECL_FILE_HEADER_GUARD_TAG) - 1], guard);
+
+	return btf_encoder__add_decl_tag(encoder, buf, btf_type_id, -1);
+}
+
+static const char *dw_tag_printable_name(uint16_t tag)
+{
+	switch (tag) {
+	case DW_TAG_structure_type:
+		return "struct";
+	case DW_TAG_union_type:
+		return "union";
+	case DW_TAG_typedef:
+		return "typedef";
+	case DW_TAG_enumeration_type:
+		return "enum";
+	default:
+		return "<no_tag_name>";
+	}
+}
+
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
 {
 	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
@@ -1556,17 +1622,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
 	cu__for_each_type(cu, core_id, pos) {
 		struct namespace *ns;
-		const char *tag_name;
 
 		switch (pos->tag) {
 		case DW_TAG_structure_type:
-			tag_name = "struct";
-			break;
 		case DW_TAG_union_type:
-			tag_name = "union";
-			break;
 		case DW_TAG_typedef:
-			tag_name = "typedef";
 			break;
 		default:
 			continue;
@@ -1578,12 +1638,39 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with component_idx %d\n",
-					annot->value, tag_name, namespace__name(ns), annot->component_idx);
+					annot->value, dw_tag_printable_name(pos->tag),
+					namespace__name(ns), annot->component_idx);
 				goto out;
 			}
 		}
 	}
 
+	cu__for_each_type(cu, core_id, pos) {
+		struct namespace *ns;
+
+		switch (pos->tag) {
+		case DW_TAG_structure_type:
+		case DW_TAG_union_type:
+		case DW_TAG_typedef:
+		case DW_TAG_enumeration_type:
+			break;
+		default:
+			continue;
+		}
+
+		btf_type_id = type_id_off + core_id;
+		tag_type_id = btf_encoder__maybe_add_header_guard_tag(encoder, pos,
+								      cu, btf_type_id);
+		if (tag_type_id < 0) {
+			ns = tag__namespace(pos);
+			fprintf(stderr,
+				"error: failed to encode uapi header info for %s tag '%s'\n",
+				dw_tag_printable_name(pos->tag),
+				namespace__name(ns));
+			goto out;
+		}
+	}
+
 	cu__for_each_function(cu, core_id, fn) {
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
diff --git a/btf_encoder.h b/btf_encoder.h
index a65120c..06b0c6b 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,8 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose,
+				     struct strlist *header_guards_db);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/dutil.c b/dutil.c
index 97c4474..28ff6ab 100644
--- a/dutil.c
+++ b/dutil.c
@@ -156,7 +156,7 @@ void strlist__remove(struct strlist *slist, struct str_node *sn)
 	str_node__delete(sn, slist->dupstr);
 }
 
-bool strlist__has_entry(struct strlist *slist, const char *entry)
+bool __strlist__has_entry(struct strlist *slist, const char *entry, void **priv)
 {
         struct rb_node **p = &slist->entries.rb_node;
         struct rb_node *parent = NULL;
@@ -169,17 +169,25 @@ bool strlist__has_entry(struct strlist *slist, const char *entry)
                 sn = rb_entry(parent, struct str_node, rb_node);
 		rc = strcmp(sn->s, entry);
 
-		if (rc > 0)
-                        p = &(*p)->rb_left;
-                else if (rc < 0)
-                        p = &(*p)->rb_right;
-		else
+		if (rc > 0) {
+			p = &(*p)->rb_left;
+		} else if (rc < 0) {
+			p = &(*p)->rb_right;
+		} else {
+			if (priv)
+				*priv = sn->priv;
 			return true;
+		}
         }
 
 	return false;
 }
 
+bool strlist__has_entry(struct strlist *slist, const char *entry)
+{
+	return __strlist__has_entry(slist, entry, NULL);
+}
+
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index)
 {
 	Elf_Scn *sec = NULL;
diff --git a/dutil.h b/dutil.h
index 335a17c..e784284 100644
--- a/dutil.h
+++ b/dutil.h
@@ -299,6 +299,7 @@ int strlist__add(struct strlist *slist, const char *str);
 int __strlist__add(struct strlist *slist, const char *str, void *priv);
 
 bool strlist__has_entry(struct strlist *slist, const char *entry);
+bool __strlist__has_entry(struct strlist *slist, const char *entry, void **priv);
 
 static inline bool strlist__empty(const struct strlist *slist)
 {
diff --git a/dwarves.h b/dwarves.h
index 589588e..2a24e09 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -70,6 +70,7 @@ struct conf_load {
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
 	const char		*kabi_prefix;
+	const char		*header_guards_db_file;
 	struct btf		*base_btf;
 	struct conf_fprintf	*conf_fprintf;
 	int			(*threads_prepare)(struct conf_load *conf, int nr_threads, void **thr_data);
diff --git a/pahole.c b/pahole.c
index 4ddf21f..fbd78d2 100644
--- a/pahole.c
+++ b/pahole.c
@@ -80,6 +80,7 @@ static int show_reorg_steps;
 static const char *class_name;
 static LIST_HEAD(class_names);
 static char separator = '\t';
+static struct strlist *header_guards_db;
 
 static bool compilable;
 static struct type_emissions emissions;
@@ -1222,6 +1223,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_languages_exclude	   336
 #define ARGP_skip_encoding_btf_enum64 337
 #define ARGP_skip_emitting_atomic_typedefs 338
+#define ARGP_header_guards_db	   339
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1634,6 +1636,12 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_skip_emitting_atomic_typedefs,
 		.doc  = "Do not emit 'typedef _Atomic int atomic_int' & friends."
 	},
+	{
+		.name = "header_guards_db",
+		.key  = ARGP_header_guards_db,
+		.arg  = "FILE",
+		.doc  = "Mapping between header file names and header guard strings."
+	},
 	{
 		.name = NULL,
 	}
@@ -1803,6 +1811,9 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_enum64 = true;	break;
 	case ARGP_skip_emitting_atomic_typedefs:
 		conf.skip_emitting_atomic_typedefs = true;	break;
+	case ARGP_header_guards_db:
+		conf_load.extra_dbg_info = true;
+		conf_load.header_guards_db_file = arg;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3038,7 +3049,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * create it.
 			 */
 			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
+						       btf_encode_force, btf_gen_floats, global_verbose,
+						       header_guards_db);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
 
@@ -3070,7 +3082,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 							 skip_encoding_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
-							 global_verbose);
+							 global_verbose,
+							 header_guards_db);
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
 			encoder = thread->encoder;
@@ -3382,6 +3395,74 @@ out_free:
 	return ret;
 }
 
+struct strlist *header_guards_db__new(void)
+{
+	return strlist__new(true);
+}
+
+/*
+ * Header guards db is a text file with one entry per line, each entry
+ * has the following form:
+ *   <header-file-name> <guard-name>
+ * It is assumed that neither <header-file-name> nor <guard-name> contain spaces.
+ * It is assumed that <header-file-name> is relative to kernel compilation tree.
+ */
+static int header_guards_db__load(struct strlist *header_guards_db, const char *filename)
+{
+	char entry[1024];
+	char header[1024];
+	char guard[1024];
+	char *true_header;
+	char *heap_guard;
+	int num_fields;
+	int err = -1;
+	int lineno = 1;
+	FILE *fp = fopen(filename, "r");
+
+	if (!fp)
+		return -1;
+
+	while (fgets(entry, sizeof(entry), fp)) {
+		size_t len = strlen(entry);
+
+		if (len == 0)
+			continue;
+		entry[len - 1] = '\0';
+		num_fields = sscanf(entry, "%s %s", header, guard);
+		if (num_fields != 2) {
+			fprintf(stderr, "Error while reading header guards db:\n");
+			fprintf(stderr, "  can't match fields at line %d: %s\n", lineno, entry);
+			goto out;
+		}
+
+		heap_guard = strdup(guard);
+		if (!heap_guard)
+			goto out;
+
+		true_header = strstarts(header, "./") ? &header[2] : header;
+		if (__strlist__add(header_guards_db, true_header, heap_guard))
+			goto out;
+
+		++lineno;
+	}
+
+	err = 0;
+out:
+	fclose(fp);
+	return err;
+}
+
+#ifdef DEBUG_CHECK_LEAKS
+static void header_guards_db__free(struct strlist *header_guards_db)
+{
+	struct str_node *pos, *tmp;
+
+	strlist__for_each_entry_safe(header_guards_db, pos, tmp)
+		__zfree(&pos->priv);
+	strlist__delete(header_guards_db);
+}
+#endif
+
 int main(int argc, char *argv[])
 {
 	int err, remaining, rc = EXIT_FAILURE;
@@ -3409,6 +3490,18 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (conf_load.header_guards_db_file) {
+		header_guards_db = header_guards_db__new();
+		if (!header_guards_db) {
+			fprintf(stderr, "pahole: insufficient memory\n");
+			goto out;
+		}
+		if (header_guards_db__load(header_guards_db, conf_load.header_guards_db_file)) {
+			fprintf(stderr, "Error while reading header guards db\n");
+			goto out;
+		}
+	}
+
 	if (dwarves__init()) {
 		fputs("pahole: insufficient memory\n", stderr);
 		goto out;
@@ -3570,6 +3663,8 @@ out_dwarves_exit:
 out:
 #ifdef DEBUG_CHECK_LEAKS
 	prototypes__delete(&class_names);
+	if (header_guards_db)
+		header_guards_db__free(header_guards_db);
 #endif
 	return rc;
 }
-- 
2.34.1

