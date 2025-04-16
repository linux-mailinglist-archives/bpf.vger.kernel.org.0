Return-Path: <bpf+bounces-56056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DDA90C31
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DA3ABC34
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F10E224B12;
	Wed, 16 Apr 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koKvo2OQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ACF22371A;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831267; cv=none; b=IgFOzSm3FfDNSONvlq4XiPZ++WJcDE6AFFbYJK13arL+gQV3BzwlxXsWnAn/QchBvIwzqQ8ysAZ7tplQ8MM5TjCbkvskWF2kKQZ6Z+zLEF0fMvVzz58Ssq/cTwNUTfgm9Dlc1mq/jorQgSw+XFezjrQEbk4t1ESgACC9We2IK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831267; c=relaxed/simple;
	bh=a+GP7KFkY1hXZ0JBGWWVGl4cLU0RDSxrkKRm3VSbn6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbMjxc/lx4H0EoGasa+ZmJA55qk//HOGI6IpqaPD1U41pE7W96AH9Nt4YVQsSwVie1gqOdwp8HV5P3OiyyyTYLCD+/npTmaPk+Xz3SUZOl+o2O1Bp1xWT5d28gSXJdRisTp4Sr/2N/Vwmncvv5CRuSAWUKNZuoPDQCHYRaBgk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koKvo2OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B600C4CEEC;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831267;
	bh=a+GP7KFkY1hXZ0JBGWWVGl4cLU0RDSxrkKRm3VSbn6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=koKvo2OQFCt3eYHbBWo/BCgvqdVNMT+O+DyNBoUYEZF++P+KHDsusLaxt2zqKWQGj
	 3fO0UHPH6El4tD5+tYLUJBZzcPTJQZ9dG+eqzYxWo6thlUuf/iu58AavmmUmQ6eX9N
	 jdOzAJMxX6pwS/fapnGhNoIYWJsXWqBNW2c9xJuz7CjciPWmxdHPdlj8BOeuxz8oMB
	 u1J8Sa4wR1EU9Vb4zZC3z2x3s7qd9129KjoHQt+RHFvbfq1sB68fzaAQtSkxbqSPi6
	 j8mC0xmK7RGHmjT/+8/npp/Uq60jxMDCtQx10Wi2ceoNXWj1Hx2yXs2cQ9eKM3oUMS
	 HkmfWCcuYUCPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAAC369C9;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
From: Thierry Treyer via B4 Relay <devnull+ttreyer.meta.com@kernel.org>
Date: Wed, 16 Apr 2025 19:20:37 +0000
Subject: [PATCH RFC 3/3] inline_encoder: Introduce inline encoder to emit
 BTF.inline
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-btf_inline-v1-3-e4bd2f8adae5@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: Thierry Treyer <ttreyer@meta.com>, acme@kernel.org, ast@kernel.org, 
 yhs@meta.com, andrii@kernel.org, ihor.solodrai@linux.dev, 
 songliubraving@meta.com, alan.maguire@oracle.com, mykolal@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744831265; l=21444;
 i=ttreyer@meta.com; s=20250416; h=from:subject:message-id;
 bh=bQZ1Uu9oEGYCvyBAQGNfgW4XnY070QWGPv68903WOC0=;
 b=cpOhNrdXfSA79SeduoizhqKMJAgX1V2w2hWkuPWDqn6JHnpRcNageZZZ+iOL5+f6f/fLkirHS
 8jRAT4IldgxAsRTr6tbH53+3RRL19ibGP6IQLfoXpobFpmT0lSoralS
X-Developer-Key: i=ttreyer@meta.com; a=ed25519;
 pk=2NAyAkZ6zhou7+5zqr5ikv3g5BfFbkznGzvzfKv1nbU=
X-Endpoint-Received: by B4 Relay for ttreyer@meta.com/20250416 with
 auth_id=382
X-Original-From: Thierry Treyer <ttreyer@meta.com>
Reply-To: ttreyer@meta.com

From: Thierry Treyer <ttreyer@meta.com>

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
---
 CMakeLists.txt   |   3 +-
 btf_encoder.c    |   5 +
 btf_encoder.h    |   2 +
 btf_inline.pk    |  55 ++++++
 inline_encoder.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 inline_encoder.h |  25 +++
 pahole.c         |  40 ++++-
 7 files changed, 623 insertions(+), 3 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7ca17a6789a9e71512ffb6fe5bf2683d643209e5..38302d5b6a6ded5094ebecd83fec9eca16230be2 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -109,7 +109,8 @@ endif()
 
 set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c
 		     ctf_loader.c libctf.c btf_encoder.c btf_loader.c
-		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
+		     inline_encoder.c dwarf_loader.c dutil.c
+		     elf_symtab.c rbtree.c)
 if (NOT LIBBPF_FOUND)
 	list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
 endif()
diff --git a/btf_encoder.c b/btf_encoder.c
index 511c1ea5ee6bee67dbaec89c3d8e415af5c8e674..ead62e9034140c257e7703f58270aba19f422582 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2682,3 +2682,8 @@ out:
 	encoder->cu = NULL;
 	return err;
 }
+
+struct btf *btf_encoder__btf(struct btf_encoder *encoder)
+{
+	return encoder->btf;
+}
diff --git a/btf_encoder.h b/btf_encoder.h
index 0f345e20c2d3065511d46d7377403a4a5fbdfdef..42d21b1cbfe71fd6ee54f41a8ae153197b3021c6 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -29,4 +29,6 @@ void btf_encoder__delete(struct btf_encoder *encoder);
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf);
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
 
+struct btf *btf_encoder__btf(struct btf_encoder *encoder);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/btf_inline.pk b/btf_inline.pk
new file mode 100755
index 0000000000000000000000000000000000000000..b7b984f189c9d0e6f82dc993005164e0d3609333
--- /dev/null
+++ b/btf_inline.pk
@@ -0,0 +1,55 @@
+#!/usr/bin/poke -L
+!#
+
+type II_location_op = struct {
+  uint<8> ty;
+  offset<uint<8>, B> size;
+  union {
+    byte[0] nil: ty == 0;
+    int<8> signed_const_1: ty == 1;
+    int<16> signed_const_2: ty == 2;
+    int<32> signed_const_4: ty == 3;
+    int<64> signed_const_8: ty == 4;
+    uint<8> unsigned_const_1: ty == 5;
+    uint<16> unsigned_const_2: ty == 6;
+    uint<32> unsigned_const_4: ty == 7;
+    uint<64> unsigned_const_8: ty == 8;
+    struct {
+      uint<8> register;
+      uint<64> offset;
+    } register: ty == 9;
+  } value;
+};
+
+type II_inline_instance = struct {
+  uint<64> insn_offset;
+  uint<32> type_id;
+  uint<16> param_count;
+  offset<uint<32>, B>[param_count] param_offsets;
+};
+
+type II_Header = struct {
+  uint<16> magic == 0xeb9f;
+  uint<8> version;
+  uint<8> flags;
+  uint<32> header_size;
+  offset<uint<32>, B> inline_info_offset;
+  offset<uint<32>, B> inline_info_size;
+  offset<uint<32>, B> location_offset;
+  offset<uint<32>, B> location_size;
+};
+
+type II = struct {
+  II_Header hdr;
+  II_inline_instance[hdr.inline_info_size] inline_instances @ hdr.inline_info_offset;
+  II_location_op[hdr.location_size] locations @ hdr.location_offset;
+};
+
+if (!poke_interactive_p) {
+  var inline_file = open("/tmp/inline_expansions.btf", IOS_M_RDONLY);
+  var inline_info = II @ inline_file : 0#B;
+
+  for (exp in inline_info.inline_instances) {
+    printf ("{low_pc => '0x%u64x',type_id => %u32d}\n", exp.insn_offset, exp.type_id);
+  }
+}
diff --git a/inline_encoder.c b/inline_encoder.c
new file mode 100644
index 0000000000000000000000000000000000000000..b4a681bd996088109ddf0a8167690ce83026324b
--- /dev/null
+++ b/inline_encoder.c
@@ -0,0 +1,496 @@
+/*
+  SPDX-License-Identifier: GPL-2.0-only
+
+  Copyright (C) 2025 Facebook
+
+  Derived from ctf_encoder.c, which is:
+
+  Copyright (C) Arnaldo Carvalho de Melo <acme@redhat.com>
+  Copyright (C) Red Hat Inc
+ */
+#include <bpf/btf.h>
+
+#include "dutil.h"
+#include "dwarves.h"
+#include "inline_encoder.h"
+#include "list.h"
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <pthread.h>
+
+enum loc_type {
+	LOC_END_OF_EXPR,
+	LOC_SIGNED_CONST_1,
+	LOC_SIGNED_CONST_2,
+	LOC_SIGNED_CONST_4,
+	LOC_SIGNED_CONST_8,
+	LOC_UNSIGNED_CONST_1,
+	LOC_UNSIGNED_CONST_2,
+	LOC_UNSIGNED_CONST_4,
+	LOC_UNSIGNED_CONST_8,
+	LOC_REGISTER,
+} __attribute__((packed));
+
+struct loc {
+	enum loc_type type;
+	uint8_t size;
+};
+
+struct inline_parameter {
+	struct loc *location[16];
+};
+
+struct inline_instance {
+	struct list_head node;
+	uint64_t die_offset;
+	const char *name;
+	uint64_t insn_offset;
+	type_id_t type_id;
+	uint16_t param_count;
+	struct inline_parameter parameters[];
+};
+
+struct inline_encoder {
+	struct btf *btf;
+	struct cu *cu;
+	const char *source_filename;
+	const char *filename;
+	size_t inline_instance_cnt;
+
+	struct list_head inline_instances;
+};
+
+struct loc_node {
+	struct rb_node rb_node;
+	struct list_head node;
+	struct loc loc;
+};
+
+struct inline_encoder__header {
+	uint16_t magic;
+	uint8_t version;
+	uint8_t flags;
+	uint32_t header_size;
+	uint32_t inline_info_offset;
+	uint32_t inline_info_size;
+	uint32_t location_offset;
+	uint32_t location_size;
+};
+
+struct inline_encoder *inline_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
+{
+	struct inline_encoder *encoder = zalloc(sizeof(*encoder));
+
+	if (encoder) {
+		encoder->cu = cu;
+		encoder->source_filename = strdup(cu->filename);
+		encoder->filename = strdup(detached_filename ?: cu->filename);
+		encoder->btf = base_btf;
+		encoder->inline_instance_cnt = 0;
+
+		INIT_LIST_HEAD(&encoder->inline_instances);
+	}
+
+	return encoder;
+}
+
+void inline_encoder__delete(struct inline_encoder *encoder)
+{
+	if (encoder == NULL)
+		return;
+
+	zfree(&encoder->source_filename);
+	zfree(&encoder->filename);
+	encoder->btf = NULL; // Non-owning pointer to base BTF
+
+	struct inline_instance *exp, *n;
+	list_for_each_entry_safe_reverse(exp, n, &encoder->inline_instances, node) {
+		list_del_init(&exp->node);
+		for (size_t i = 0; i < exp->param_count; ++i)
+			for (size_t j = 0; j < 16; ++j)
+				free(exp->parameters[i].location[j]);
+		free(exp);
+	}
+
+	free(encoder);
+}
+
+static size_t inline_instance__sizeof(uint16_t param_count)
+{
+	return offsetof(struct inline_instance, parameters) + param_count * sizeof(struct inline_parameter);
+}
+
+static struct loc *loc__make_const(bool is_signed, size_t size, uint64_t value)
+{
+	struct loc *new_loc = zalloc(sizeof(*new_loc) + size);
+	if (new_loc == NULL)
+		return NULL;
+	new_loc->size = sizeof(struct loc) + size;
+	switch (size) {
+		case 1:
+			new_loc->type = is_signed ? LOC_SIGNED_CONST_1 : LOC_UNSIGNED_CONST_1;
+			break;
+		case 2:
+			new_loc->type = is_signed ? LOC_SIGNED_CONST_2 : LOC_UNSIGNED_CONST_2;
+			break;
+		case 4:
+			new_loc->type = is_signed ? LOC_SIGNED_CONST_4 : LOC_UNSIGNED_CONST_4;
+			break;
+		case 8:
+			new_loc->type = is_signed ? LOC_SIGNED_CONST_8 : LOC_UNSIGNED_CONST_8;
+			break;
+		default:
+			free(new_loc);
+			return NULL;
+	}
+	uint8_t *data = (uint8_t *)new_loc + sizeof(struct loc);
+	memcpy(data, &value, size);
+	return new_loc;
+}
+
+static struct loc *loc__make_register(uint8_t reg, int64_t offset)
+{
+	struct loc *new_loc = zalloc(sizeof(*new_loc) + sizeof(reg) + sizeof(offset));
+	if (new_loc == NULL)
+		return NULL;
+	new_loc->size = sizeof(struct loc) + sizeof(uint8_t) + sizeof(int64_t);
+	new_loc->type = LOC_REGISTER;
+	uint8_t *data = (uint8_t *)new_loc + sizeof(struct loc);
+	*data = reg;
+	data += sizeof(uint8_t);
+	memcpy(data, &offset, sizeof(int64_t));
+	return new_loc;
+}
+
+static struct loc *loc__make_eoe(void)
+{
+	struct loc *new_loc = zalloc(sizeof(*new_loc));
+	if (new_loc == NULL)
+		return NULL;
+	new_loc->type = LOC_END_OF_EXPR;
+	new_loc->size = sizeof(*new_loc);
+	return new_loc;
+}
+
+static uint32_t expr__size(struct loc *expr[16])
+{
+	uint32_t size = 0;
+	for (size_t i = 0; i < 16; ++i) {
+		if (expr[i] == NULL)
+			break;
+		size += expr[i]->size;
+	}
+	return size;
+}
+
+static int inline_encoder__encode_location(struct inline_encoder *encoder, struct location *loc, struct loc *expr[16])
+{
+	if (loc->expr == NULL && loc->exprlen == 0)
+		return 0;
+
+	if (loc->expr == NULL) {
+		expr[0] = loc__make_const(false, 8, loc->exprlen);
+		return 0;
+	}
+
+	size_t expr_i = 0;
+	for (size_t i = 0; i < loc->exprlen; ++i) {
+		Dwarf_Op op = loc->expr[i];
+		switch (op.atom) {
+			case DW_OP_const1u:
+			case DW_OP_const1s:
+				expr[expr_i++] = loc__make_const(op.atom == DW_OP_const1s, 1, op.number);
+				break;
+			case DW_OP_const2u:
+			case DW_OP_const2s:
+				expr[expr_i++] = loc__make_const(op.atom == DW_OP_const1s, 2, op.number);
+				break;
+			case DW_OP_const4u:
+			case DW_OP_const4s:
+				expr[expr_i++] = loc__make_const(op.atom == DW_OP_const1s, 4, op.number);
+				break;
+			case DW_OP_const8u:
+			case DW_OP_const8s:
+				expr[expr_i++] = loc__make_const(op.atom == DW_OP_const1s, 8, op.number);
+				break;
+			case DW_OP_constu:
+			case DW_OP_consts:
+				expr[expr_i++] = loc__make_const(op.atom == DW_OP_consts, 8, op.number);
+				break;
+			case DW_OP_lit0 ... DW_OP_lit31:
+				expr[expr_i++] = loc__make_const(false, 1, op.atom - DW_OP_lit0);
+				break;
+			case DW_OP_reg0 ... DW_OP_reg31:
+				expr[expr_i++] = loc__make_register(op.atom - DW_OP_reg0, 0);
+				break;
+			case DW_OP_breg0 ... DW_OP_breg31: {
+				expr[expr_i++] = loc__make_register(op.atom - DW_OP_breg0, op.number);
+				break;
+			}
+			case DW_OP_stack_value: {
+				// no-op
+				break;
+			}
+			default:
+				goto out_err;
+		}
+		if (expr_i >= 16)
+			goto out_err;
+	}
+
+	expr[expr_i++] = loc__make_eoe();
+	return 0;
+
+out_err:
+	for (size_t i = 0; i < expr_i; ++i) {
+		free(expr[i]);
+		expr[i] = NULL;
+	}
+
+	return -1;
+}
+
+static inline struct dwarf_tag *tag__dwarf(const struct tag *tag)
+{
+	uint8_t *data = (uint8_t *)tag;
+	return (struct dwarf_tag *)data;
+}
+
+static inline uint64_t die_offset(const struct tag *tag)
+{
+	uint8_t *data = (uint8_t *)tag;
+	data -= 64;
+	data += 24;
+	return *(uint64_t *)data;
+}
+
+static int inline_encoder__save_inline_expansion(struct inline_encoder *encoder, struct inline_expansion *exp)
+{
+	if (exp->name == NULL)
+		return 0;
+
+	struct inline_instance *instance = zalloc(inline_instance__sizeof(exp->nr_parms));
+	if (instance == NULL)
+		return -ENOMEM;
+
+	instance->die_offset = die_offset((struct tag *)exp);
+	instance->name = exp->name;
+	instance->insn_offset = exp->ip.addr;
+	instance->type_id = -1;
+	instance->param_count = exp->nr_parms;
+	// printf("inline instance for %u (%s): %lx %lx\n", instance->type_id, exp->name, instance->die_offset, instance->insn_offset);
+
+	uint32_t param_index = 0;
+	struct parameter *param = NULL;
+	list_for_each_entry(param, &exp->parms, tag.node) {
+		inline_encoder__encode_location(encoder, &param->location, instance->parameters[param_index++].location);
+	}
+
+	INIT_LIST_HEAD(&instance->node);
+	list_add_tail(&instance->node, &encoder->inline_instances);
+	encoder->inline_instance_cnt++;
+
+	return 0;
+}
+
+static int inline_encoder__encode_lexblock(struct inline_encoder *encoder, struct lexblock *lexblock, struct conf_load *conf_load)
+{
+	int err = 0;
+
+	struct tag *tag = NULL;
+	list_for_each_entry(tag, &lexblock->tags, node) {
+		if (tag->tag == DW_TAG_lexical_block) {
+			err = inline_encoder__encode_lexblock(encoder, tag__lexblock(tag), conf_load);
+			if (err)
+				goto out;
+			continue;
+		} else if (tag->tag != DW_TAG_inlined_subroutine) {
+			continue;
+		}
+
+		struct inline_expansion *exp = tag__inline_expansion(tag);
+		err = inline_encoder__save_inline_expansion(encoder, exp);
+		if (err)
+			goto out;
+	}
+
+	return err;
+
+out:
+	return err;
+}
+
+int inline_encoder__encode_cu(struct inline_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
+{
+	int err = 0;
+
+	uint32_t fn_id;
+	struct function *fn;
+	cu__for_each_function(cu, fn_id, fn) {
+		if (fn->declaration)
+			continue;
+		if (function__addr(fn) == 0)
+			continue;
+
+		err = inline_encoder__encode_lexblock(encoder, &fn->lexblock, conf_load);
+		if (err)
+			goto out;
+	}
+	return err;
+out:
+	return err;
+}
+
+struct node_type_id {
+	const char *name;
+	type_id_t type_id;
+};
+
+static int cmpstrp(const void *left, const void *right)
+{
+	struct node_type_id *left_node = (struct node_type_id*)left;
+	struct node_type_id *right_node = (struct node_type_id*)right;
+	return strcmp(left_node->name, right_node->name);
+}
+
+static struct node_type_id *inline_encoder__build_type_id_cache(struct inline_encoder *encoder)
+{
+	struct node_type_id *exps = (struct node_type_id*)malloc(encoder->inline_instance_cnt * sizeof(struct node_type_id));
+
+	size_t exp_id = 0;
+	struct inline_instance *exp;
+	list_for_each_entry(exp, &encoder->inline_instances, node) {
+		exps[exp_id++] = (struct node_type_id){exp->name, 0};
+	}
+
+	qsort(exps, encoder->inline_instance_cnt, sizeof(struct node_type_id), cmpstrp);
+
+	return exps;
+}
+
+static int inline_encoder__write_raw_file(struct inline_encoder *encoder, const char *filename)
+{
+	int err = -1;
+
+	int fd = creat(filename, S_IRUSR | S_IWUSR);
+	if (fd == -1) {
+		fprintf(stderr, "%s open(%s) failed!\n", __func__, filename);
+		goto out;
+	}
+
+	struct inline_encoder__header header = {
+		.magic = 0xeb9f,
+		.version = 1,
+		.flags = 0,
+		.header_size = sizeof(header),
+		.inline_info_offset = sizeof(struct inline_encoder__header),
+		.inline_info_size = 0,
+		.location_offset = 0,
+		.location_size = 2,
+	};
+	write(fd, &header, header.header_size);
+
+	struct node_type_id *type_id_cache = inline_encoder__build_type_id_cache(encoder);
+
+	struct inline_instance *exp;
+	list_for_each_entry(exp, &encoder->inline_instances, node) {
+		struct node_type_id lookup_key = { exp->name, 0 };
+		struct node_type_id *found = bsearch(&lookup_key, type_id_cache, encoder->inline_instance_cnt, sizeof(lookup_key), cmpstrp);
+		assert(found != NULL);
+		if (found->type_id == 0) {
+			int type_id = btf__find_by_name_kind(encoder->btf, exp->name, BTF_KIND_FUNC);
+			found->type_id = (type_id < 0) ? -1 : type_id;
+		}
+		exp->type_id = found->type_id;
+		if (exp->type_id == -1) continue;
+
+		const void *data = exp;
+		header.inline_info_size += write(
+			fd,
+			data + offsetof(struct inline_instance, insn_offset),
+			inline_instance__sizeof(0)
+				- offsetof(struct inline_instance, insn_offset)
+				- 2); // Skip padding at the end of the struct
+		for (uint16_t i = 0; i < exp->param_count; ++i) {
+			struct inline_parameter *param = &exp->parameters[i];
+			if (param->location[0] == NULL) {
+				uint32_t zero = 0;
+				header.inline_info_size += write(fd, &zero, sizeof(zero));
+			} else {
+				header.inline_info_size += write(fd, &header.location_size, sizeof(header.location_size));
+				header.location_size += expr__size(param->location);
+			}
+		}
+	}
+
+	free(type_id_cache);
+
+	struct loc end_of_expr = {
+		.type = LOC_END_OF_EXPR,
+		.size = sizeof(end_of_expr),
+	};
+	write(fd, &end_of_expr, sizeof(end_of_expr));
+	list_for_each_entry(exp, &encoder->inline_instances, node) {
+		if (exp->type_id == -1)
+			continue;
+		for (uint16_t i = 0; i < exp->param_count; ++i) {
+			struct inline_parameter *param = &exp->parameters[i];
+			for (size_t j = 0; j < 16; ++j) {
+				struct loc *op = param->location[j];
+				if (op == NULL)
+					break;
+				write(fd, op, op->size);
+			}
+		}
+	}
+	header.location_offset = header.inline_info_offset + header.inline_info_size;
+	lseek(fd, 0, SEEK_SET);
+	write(fd, &header, header.header_size);
+
+	close(fd);
+	return 0;
+
+out:
+	if (fd != - 1)
+		close(fd);
+	unlink(filename);
+	return err;
+}
+
+int inline_encoder__encode(struct inline_encoder *encoder, struct conf_load *conf_load)
+{
+	char tmp_fn[PATH_MAX];
+	snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf_inline", encoder->filename);
+
+	int err = inline_encoder__write_raw_file(encoder, tmp_fn);
+	if (err) return err;
+
+	const char *llvm_objcopy = getenv("LLVM_OBJCOPY");
+	if (!llvm_objcopy)
+		llvm_objcopy = "llvm-objcopy";
+
+	char cmd[PATH_MAX * 2];
+	snprintf(cmd, sizeof(cmd), "%s --add-section .BTF_inline=%s %s",
+		 llvm_objcopy, tmp_fn, encoder->filename);
+	if (system(cmd)) {
+		fprintf(stderr, "%s: failed to add .BTF_inline section '%s': %d!\n",
+				__func__, tmp_fn, errno);
+		err = -1;
+		goto unlink;
+	}
+
+	err = 0;
+unlink:
+	unlink(tmp_fn);
+	return err;
+}
+
+void inline_encoder__set_btf(struct inline_encoder *encoder, struct btf *btf)
+{
+	encoder->btf = btf;
+}
diff --git a/inline_encoder.h b/inline_encoder.h
new file mode 100644
index 0000000000000000000000000000000000000000..c3472d011a56e84efc77d85fcee1a6aa88204c86
--- /dev/null
+++ b/inline_encoder.h
@@ -0,0 +1,25 @@
+#ifndef _INLINE_ENCODER_H_
+#define _INLINE_ENCODER_H_ 1
+/*
+  SPDX-License-Identifier: GPL-2.0-only
+
+  Copyright (C) 2025 Facebook
+
+  Derived from btf_encoder.h, which is:
+  Copyright (C) Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+#include <stdbool.h>
+
+struct inline_encoder;
+struct conf_load;
+struct btf;
+struct cu;
+
+struct inline_encoder *inline_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
+void inline_encoder__delete(struct inline_encoder *encoder);
+int inline_encoder__encode_cu(struct inline_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
+int inline_encoder__encode(struct inline_encoder *encoder, struct conf_load *conf_load);
+
+void inline_encoder__set_btf(struct inline_encoder *encoder, struct btf *btf);
+
+#endif /* _INLINE_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index af3e1cfe224dd14a5be2c072461505cf3cc387c5..093d76478dbd5a687c44b0f19fce73cfe6aae161 100644
--- a/pahole.c
+++ b/pahole.c
@@ -28,12 +28,15 @@
 #include "dutil.h"
 //#include "ctf_encoder.h" FIXME: disabled, probably its better to move to Oracle's libctf
 #include "btf_encoder.h"
+#include "inline_encoder.h"
 
 static struct btf_encoder *btf_encoder;
+static struct inline_encoder *inline_encoder;
 static char *detached_btf_filename;
 struct cus *cus;
 static bool btf_encode;
 static bool ctf_encode;
+static bool inline_encode;
 static bool sort_output;
 static bool need_resort;
 static bool first_obj_only;
@@ -1638,6 +1641,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'J',
 		.doc  = "Encode as BTF",
 	},
+	{
+		.name = "inline_encode",
+		.key  = 'L',
+		.doc  = "Encode inline expansions into .BTF.inline section",
+	},
 	{
 		.name = "btf_encode_detached",
 		.key  = ARGP_btf_encode_detached,
@@ -1832,6 +1840,7 @@ static error_t pahole__options_parser(int key, char *arg,
 							break;
 	case ARGP_btf_encode_detached:
 		  detached_btf_filename = arg; // fallthru
+	case 'L': inline_encode = inline_encode || key == 'L'; // fallthru
 	case 'J': btf_encode = 1;
 		  conf_load.get_addr_info = true;
 		  conf_load.ignore_alignment_attr = true;
@@ -3140,6 +3149,22 @@ static enum load_steal_kind pahole_stealer__btf_encode(struct cu *cu, struct con
 		return LSK__STOP_LOADING;
 	}
 
+	if (inline_encode) {
+		if (!inline_encoder)
+			inline_encoder = inline_encoder__new(cu, detached_btf_filename, conf_load->base_btf, global_verbose, conf_load);
+
+		if (!inline_encoder) {
+			fprintf(stderr, "Error creating inline encoder.\n");
+			return LSK__STOP_LOADING;
+		}
+
+		err = inline_encoder__encode_cu(inline_encoder, cu, conf_load);
+		if (err < 0) {
+			fprintf(stderr, "Error while encoding BTF.inline.\n");
+			return LSK__STOP_LOADING;
+		}
+	}
+
 	return LSK__DELETE;
 }
 
@@ -3672,10 +3697,19 @@ try_sole_arg_as_class_names:
 
 	if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and thus we don't have an encoder?
 		err = btf_encoder__encode(btf_encoder, &conf_load);
-		btf_encoder__delete(btf_encoder);
 		if (err) {
 			fputs("Failed to encode BTF\n", stderr);
-			goto out_cus_delete;
+			goto out_btf_encoder_delete;
+		}
+
+		if (inline_encode && inline_encoder) {
+			inline_encoder__set_btf(inline_encoder, btf_encoder__btf(btf_encoder));
+			err = inline_encoder__encode(inline_encoder, &conf_load);
+			inline_encoder__delete(inline_encoder);
+			if (err) {
+				fputs("Failed to encode BTF.inline\n", stderr);
+				goto out_btf_encoder_delete;
+			}
 		}
 	}
 out_ok:
@@ -3683,6 +3717,8 @@ out_ok:
 		print_stats();
 
 	rc = EXIT_SUCCESS;
+out_btf_encoder_delete:
+	btf_encoder__delete(btf_encoder);
 out_cus_delete:
 #ifdef DEBUG_CHECK_LEAKS
 	cus__delete(cus);

-- 
2.47.1



