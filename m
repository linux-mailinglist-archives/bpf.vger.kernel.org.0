Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BB60D718
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiJYW2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJYW2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6713D2F
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so10977258ejc.7
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOHxE87HEjX67Sgs/cOkPKwgGjyuyfVIaFsiIyCh2h0=;
        b=b0NE/+6MxKyMVSh6/jiNOubuLsDn3nGv3kHo6vUvBI9NJJXgc4HVWrbuCP61HZHyxM
         nM7rQ34mKof9PbwAjuU4osElYdqlYF22SpGYkaNlu5k8T1kVVcVrZ5u70URRg1ZXC4aE
         G3xi7M9bztBIR0kUivgCIXfY0iohDROGlMVz26nIUFJ/i/QBpziZjZ8zmlOgisz38Eo4
         wnw6otHQqLi8YR347gNKb+XB5RcBf4X+MxZYfnpuTOlWeRAbiutrnINikj+w/0Nw965t
         W/w6k3JptGgeDaAa+JZhDKY3ER+C39bR8l/m+zZy6qbo7e+jDfmGc1eL02OKqB5kXcsh
         LpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOHxE87HEjX67Sgs/cOkPKwgGjyuyfVIaFsiIyCh2h0=;
        b=HA8PghOOJWMY7gYqBspfPGoTrjifeF68gYYGknRW33mkbqxepFmWMQ9ObEmKUXDzU2
         DuSWt3P9Or/I5EKyqDdOMG6vXLEUaJ36XutsTGcGEQmB3IkPZ9J7UhAeQ2Xc/en0IrWY
         e5lI9QpV2xtVtUyD6GBRWx1Qf7Vdh08FccjM/tT1RAb5KuuLNrRBfc2wFMGZ5JlVja9P
         nuR4M2MVJHQ7Ns6lE6oMiUP2ucYqIdAEHhcuJb1Gq1WMO7+U6wLotwm9XmquZ3rGD6UU
         b4Lj87Bz4FQJgQtEdq65zqn3RQwQRsTEJevGXG6yRLXqt2tIcsp9YnzgLUJCar5YuiZ/
         pbOw==
X-Gm-Message-State: ACrzQf2Cfxs+K33i15Nxtpb/JJHr1RNhXBtZgNUUqg3p7oc6fue95CTP
        hPQFdnOjdO7do5p5wSVIT3u3g07NQJ2qq4W6
X-Google-Smtp-Source: AMsMyM5YtWWLU2YkePMwk5HISJEfy9Uj1Q8ncQ+79H7q8kAwdUcjW1JWv3X7foDkrqFo3UW85qb/dQ==
X-Received: by 2002:a17:906:ef8c:b0:78d:96b9:a0ad with SMTP id ze12-20020a170906ef8c00b0078d96b9a0admr35010946ejb.529.1666736923551;
        Tue, 25 Oct 2022 15:28:43 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:43 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 05/12] libbpf: Header guards for selected data structures in vmlinux.h
Date:   Wed, 26 Oct 2022 01:27:54 +0300
Message-Id: <20221025222802.2295103-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
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

The goal of the patch is to allow usage of header files from
`include/uapi` alongside with `vmlinux.h`. E.g. as follows:

  #include <uapi/linux/tcp.h>
  #include "vmlinux.h"

This goal is achieved by adding #ifndef / #endif guards in vmlinux.h
around definitions that originate from the `include/uapi` headers. The
guards emitted match the guards used in the original headers.
E.g. as follows:

include/uapi/linux/tcp.h:

  #ifndef _UAPI_LINUX_TCP_H
  #define _UAPI_LINUX_TCP_H
  ...
  union tcp_word_hdr {
	struct tcphdr hdr;
	__be32        words[5];
  };
  ...
  #endif /* _UAPI_LINUX_TCP_H */

vmlinux.h:

  ...
  #ifndef _UAPI_LINUX_TCP_H

  union tcp_word_hdr {
	struct tcphdr hdr;
	__be32 words[5];
  };

  #endif /* _UAPI_LINUX_TCP_H */
  ...

The problem of identifying data structures from uapi and selecting
proper guard names is delegated to pahole. When configured pahole
generates fake `BTF_DECL_TAG` records with header guards information.
The fake tag is distinguished from a real tag by a prefix
"header_guard:" in its value. These tags could be present for unions,
structures, enums and typedefs, e.g.:

[24139] STRUCT 'tcphdr' size=20 vlen=17
  ...
[24296] DECL_TAG 'header_guard:_UAPI_LINUX_TCP_H' type_id=24139 ...

This patch adds An option `emit_header_guards` to `struct btf_dump_opts`.
When this option is present the function `btf_dump__dump_type` emits
header guards for top-level declarations. The header guards are
identified by inspecting fake `BTF_DECL_TAG` records described above.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.h      |  7 +++-
 tools/lib/bpf/btf_dump.c | 89 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..dcfb3f168750 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -235,8 +235,13 @@ struct btf_dump;
 
 struct btf_dump_opts {
 	size_t sz;
+	/*
+	 * if set to true #ifndef X ... #endif brackets would be printed
+	 * for types marked by BTF_DECL_TAG with "header_guard:" prefix
+	 */
+	bool emit_header_guards;
 };
-#define btf_dump_opts__last_field sz
+#define btf_dump_opts__last_field emit_header_guards
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 9bfe2a4ae277..30b995d209c0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -113,6 +113,8 @@ struct btf_dump {
 	int decl_stack_cap;
 	int decl_stack_cnt;
 
+	bool emit_header_guards;
+
 	/* maps struct/union/enum name to a number of name occurrences */
 	struct hashmap *type_names;
 	/*
@@ -202,6 +204,8 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->cb_ctx = ctx;
 	d->ptr_sz = btf__pointer_size(btf) ? : sizeof(void *);
 
+	d->emit_header_guards = OPTS_GET(opts, emit_header_guards, false);
+
 	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
 		err = PTR_ERR(d->type_names);
@@ -347,6 +351,8 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 	return 0;
 }
 
+static const char *btf_dump_is_header_guard_tag(struct btf_dump *d, const struct btf_type *t);
+
 /*
  * Mark all types that are referenced from any other type. This is used to
  * determine top-level anonymous enums that need to be emitted as an
@@ -384,11 +390,15 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_FUNC:
 		case BTF_KIND_VAR:
-		case BTF_KIND_DECL_TAG:
 		case BTF_KIND_TYPE_TAG:
 			d->type_states[t->type].referenced = 1;
 			break;
 
+		case BTF_KIND_DECL_TAG:
+			if (!btf_dump_is_header_guard_tag(d, t))
+				d->type_states[t->type].referenced = 1;
+			break;
+
 		case BTF_KIND_ARRAY: {
 			const struct btf_array *a = btf_array(t);
 
@@ -449,6 +459,40 @@ static struct decl_tag_array *realloc_decl_tags(struct decl_tag_array *tags, __u
 	return new_tags;
 }
 
+#define HEADER_GUARD_TAG "header_guard:"
+
+static const char *btf_dump_is_header_guard_tag(struct btf_dump *d, const struct btf_type *t)
+{
+	const char *tag_value;
+	int tag_len = strlen(HEADER_GUARD_TAG);
+
+	tag_value = btf__str_by_offset(d->btf, t->name_off);
+	if (strncmp(tag_value, HEADER_GUARD_TAG, tag_len))
+		return NULL;
+
+	return &tag_value[tag_len];
+}
+
+static const char *btf_dump_find_header_guard(struct btf_dump *d, __u32 id)
+{
+	struct decl_tag_array *decl_tags = btf_dump_find_decl_tags(d, id);
+	const struct btf_type *t;
+	const char *guard;
+	int i;
+
+	if (!decl_tags)
+		return NULL;
+
+	for (i = 0; i < decl_tags->cnt; ++i) {
+		t = btf__type_by_id(d->btf, decl_tags->tag_ids[i]);
+		guard = btf_dump_is_header_guard_tag(d, t);
+		if (guard)
+			return guard;
+	}
+
+	return NULL;
+}
+
 /*
  * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
  * The id's of the entries are stored in the `btf_dump.decl_tags` table,
@@ -770,6 +814,8 @@ static const char *btf_dump_type_name(struct btf_dump *d, __u32 id);
 static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id);
 static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 				 const char *orig_name);
+static void btf_dump_emit_guard_start(struct btf_dump *d, __u32 id);
+static void btf_dump_emit_guard_end(struct btf_dump *d, __u32 id);
 
 static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
 {
@@ -835,8 +881,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 					id);
 				return;
 			}
+			btf_dump_emit_guard_start(d, id);
 			btf_dump_emit_struct_fwd(d, id, t);
 			btf_dump_printf(d, ";\n\n");
+			btf_dump_emit_guard_end(d, id);
 			tstate->fwd_emitted = 1;
 			break;
 		case BTF_KIND_TYPEDEF:
@@ -846,8 +894,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 			 * references through pointer only, not for embedding
 			 */
 			if (!btf_dump_is_blacklisted(d, id)) {
+				btf_dump_emit_guard_start(d, id);
 				btf_dump_emit_typedef_def(d, id, t, 0);
 				btf_dump_printf(d, ";\n\n");
+				btf_dump_emit_guard_end(d, id);
 			}
 			tstate->fwd_emitted = 1;
 			break;
@@ -868,8 +918,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
 		if (top_level_def) {
+			btf_dump_emit_guard_start(d, id);
 			btf_dump_emit_enum_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
+			btf_dump_emit_guard_end(d, id);
 		}
 		tstate->emit_state = EMITTED;
 		break;
@@ -884,8 +936,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		btf_dump_emit_type(d, btf_array(t)->type, cont_id);
 		break;
 	case BTF_KIND_FWD:
+		btf_dump_emit_guard_start(d, id);
 		btf_dump_emit_fwd_def(d, id, t);
 		btf_dump_printf(d, ";\n\n");
+		btf_dump_emit_guard_end(d, id);
 		tstate->emit_state = EMITTED;
 		break;
 	case BTF_KIND_TYPEDEF:
@@ -899,8 +953,10 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		 * emit typedef as a forward declaration
 		 */
 		if (!tstate->fwd_emitted && !btf_dump_is_blacklisted(d, id)) {
+			btf_dump_emit_guard_start(d, id);
 			btf_dump_emit_typedef_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
+			btf_dump_emit_guard_end(d, id);
 		}
 		tstate->emit_state = EMITTED;
 		break;
@@ -923,14 +979,18 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 			for (i = 0; i < vlen; i++, m++)
 				btf_dump_emit_type(d, m->type, new_cont_id);
 		} else if (!tstate->fwd_emitted && id != cont_id) {
+			btf_dump_emit_guard_start(d, id);
 			btf_dump_emit_struct_fwd(d, id, t);
 			btf_dump_printf(d, ";\n\n");
+			btf_dump_emit_guard_end(d, id);
 			tstate->fwd_emitted = 1;
 		}
 
 		if (top_level_def) {
+			btf_dump_emit_guard_start(d, id);
 			btf_dump_emit_struct_def(d, id, t, 0);
 			btf_dump_printf(d, ";\n\n");
+			btf_dump_emit_guard_end(d, id);
 			tstate->emit_state = EMITTED;
 		} else {
 			tstate->emit_state = NOT_EMITTED;
@@ -1034,6 +1094,8 @@ static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id)
 
 	for (i = 0; i < decl_tags->cnt; ++i) {
 		decl_tag_t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
+		if (btf_dump_is_header_guard_tag(d, decl_tag_t))
+			continue;
 		decl_tag_text = btf__name_by_offset(d->btf, decl_tag_t->name_off);
 		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", decl_tag_text);
 	}
@@ -1672,6 +1734,31 @@ static void btf_dump_emit_type_cast(struct btf_dump *d, __u32 id,
 		btf_dump_printf(d, ")");
 }
 
+static void btf_dump_emit_guard_start(struct btf_dump *d, __u32 id)
+{
+	const char *header_guard;
+
+	if (!d->emit_header_guards)
+		return;
+
+	header_guard = btf_dump_find_header_guard(d, id);
+	if (!header_guard)
+		return;
+
+	btf_dump_printf(d, "#ifndef %s\n\n", header_guard);
+}
+
+static void btf_dump_emit_guard_end(struct btf_dump *d, __u32 id)
+{
+	if (!d->emit_header_guards)
+		return;
+
+	if (!btf_dump_find_header_guard(d, id))
+		return;
+
+	btf_dump_printf(d, "#endif\n\n");
+}
+
 /* return number of duplicates (occurrences) of a given name */
 static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 				 const char *orig_name)
-- 
2.34.1

