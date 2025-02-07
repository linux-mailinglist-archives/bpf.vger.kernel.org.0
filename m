Return-Path: <bpf+bounces-50728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202BA2B8B6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8A167194
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D715B102;
	Fri,  7 Feb 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kQT7vk6e"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1F1624E5
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894508; cv=none; b=mtDR5Ot+YjCHJap4qoVJRz9N0B/2UsVyGU/KAcPzSa4hCTXiHB1myl7URjU3t4pQKBYt1Sr3+ASxpl4D/+1oH7UYl6WeS7NmbaQL1eMP52dWjHh7hGQMjapLnApSyPaU0ozHYnFH6K+z1w58yclhWgfYUl1VZp9FGzWnJNiN3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894508; c=relaxed/simple;
	bh=sPtnUM+a4Sf6PqonCFWka4MME0SiGFhUo/lQWyLP72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpOtvtOqGMrxaUvYjt/KLkq7/T1joSJWvEhAi4X8LlRuXwfq1gdf5xu+iYvTabkUJXp6EtbYb7jBUGJFvND1k7fgpBtGC2Da8uifHJGhOTcODxTHBW3R2C/rZs/CtTYmcC3+rOTAf49a5TEMiP0PRIMaCrL5dkPDOeRu119iKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kQT7vk6e; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SATihpDI6gKCPNDFWYK7idPXOGcxYr2zvSTDYPOLQQ=;
	b=kQT7vk6eTCAIKNUNONebA9oSmRP2fR1Ahr5qJVejfLTcQ4l3I41qEqkj+VQOyXjMPajMeR
	msEuxTKirl3GqQO+R/HrWzCxAK/CTatKje5QW3GpAhfyQOn2LnE5LAtErhtNWoQwArGXDG
	FEJ+DtUNEAh+E07ZX41vKdf8vS51sBs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves 3/3] pahole: introduce --btf_feature=attributes
Date: Thu,  6 Feb 2025 18:14:42 -0800
Message-ID: <20250207021442.155703-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250207021442.155703-1-ihor.solodrai@linux.dev>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a feature flag "attributes" (default: false) controlling whether
pahole is allowed to generate BTF attributes: type tags and decl tags
with kind_flag = 1.

This is necessary for backward compatibility, as BPF verifier does not
recognize tags with kind_flag = 1 prior to (at least) 6.14-rc1 [1].

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c |  6 ++++--
 dwarves.h     |  1 +
 pahole.c      | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d7837c2..0a734d4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -142,7 +142,8 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  gen_distilled_base;
+			  gen_distilled_base,
+			  encode_attributes;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
@@ -800,7 +801,7 @@ static int btf_encoder__add_bpf_arena_type_tags(struct btf_encoder *encoder, str
 	int ret_type_id;
 	int err = 0;
 
-	if (!state || !state->elf || !state->elf->kfunc)
+	if (!encoder->encode_attributes || !state || !state->elf || !state->elf->kfunc)
 		goto out;
 
 	kfunc = btf_encoder__kfunc_by_name(encoder, state->elf->name);
@@ -2553,6 +2554,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
+		encoder->encode_attributes = conf_load->btf_attributes;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 8234e1a..99ed783 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -89,6 +89,7 @@ struct conf_load {
 	bool			reproducible_build;
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
+	bool			btf_attributes;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index af3e1cf..0bda249 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1152,6 +1152,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARG_padding_ge		   347
 #define ARG_padding		   348
 #define ARGP_with_embedded_flexible_array 349
+#define ARGP_btf_attributes	   350
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1210,6 +1211,9 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
 #endif
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
+	BTF_NON_DEFAULT_FEATURE(attributes, btf_attributes, false),
+#endif
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1785,6 +1789,11 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_running_kernel_vmlinux,
 		.doc = "Search for, possibly getting from a debuginfo server, a vmlinux matching the running kernel build-id (from /sys/kernel/notes)"
 	},
+	{
+		.name = "btf_attributes",
+		.key  = ARGP_btf_attributes,
+		.doc  = "Allow generation of attributes in BTF. Attributes are the type tags and decl tags with the kind_flag set to 1.",
+	},
 	{
 		.name = NULL,
 	}
@@ -1979,6 +1988,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		show_supported_btf_features(stdout);	exit(0);
 	case ARGP_btf_features_strict:
 		parse_btf_features(arg, true);		break;
+	case ARGP_btf_attributes:
+		conf_load.btf_attributes = true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.48.1


