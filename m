Return-Path: <bpf+bounces-51986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FDA3CAEB
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3016AD7B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0F255E48;
	Wed, 19 Feb 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAgGhA+p"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D164255E40
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999137; cv=none; b=ASi6+FHSy69SaqauLrD7mTDHjz8otxKF7lVTY6IayQP+2tvdFc9yVaPzKqStFK+gyaWpa0tQk0xAtcK84kBGWWMKjrKF1GyNsK9SenwlN9t7dflN6ZQRUPRsdKF0jLmVIh6qPWaiU3cj43W4Q0A5JB+AnFrze3S3L7kt/zkIohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999137; c=relaxed/simple;
	bh=C5nMcBEtsAOtyBGLK3LGY9LDMLC4xZxDA6KKQ80L8cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U15ZL5r/Iqu2iPvO1n8kv2nCKA9Wk3bcD6SSfuvsQjvUTLeVp1tB6+/XER2PEs2zBc4QqTL5yS+7RoDe1tlf6Zbmx9leXnWbkLfv/L7dTrtpPZQIdI9nbG2Bh6Da9bjipxOw01ztb788fp2r7WKmuxve+ajOepspgx5kwlO/qD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAgGhA+p; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37pF3WcstHHNMOUpw/bl3UJm9H3zhz8mtI4k1lYorXc=;
	b=uAgGhA+p2+Mu3UgWa5U7rCBCiAaTLoPqmA7AIu984mnQuD1QMbfnes+IwHAx9ykbGJRHv4
	Z9vsRE+4oFrCN8yO5W3xhv9jBf6H2Sku1Kgp4otsr2PQY/9tBLkdCcuRBQspowa9degqJL
	DWvH5dJRH02hZT3cK5O+//d2LEwiVkY=
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
Subject: [PATCH bpf-next v3 3/4] pahole: introduce --btf_feature=attributes
Date: Wed, 19 Feb 2025 13:05:19 -0800
Message-ID: <20250219210520.2245369-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
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
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c |  6 ++++--
 dwarves.h     |  1 +
 pahole.c      | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 844938f..2f56f5d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -136,7 +136,8 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  gen_distilled_base;
+			  gen_distilled_base,
+			  encode_attributes;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
@@ -823,7 +824,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 	assert(ftype != NULL || state != NULL);
 
 #if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 6
-	if (is_kfunc_state(state) && encoder->tag_kfuncs)
+	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
 		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
 			return -1;
 #endif
@@ -2414,6 +2415,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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


