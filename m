Return-Path: <bpf+bounces-52904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D70A4A2F1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE7A7A7FC7
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8A230BED;
	Fri, 28 Feb 2025 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fubt9Xgq"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4D1C5D6F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772036; cv=none; b=g4lpsnCsZIQ2+BlMltnnlrHNTDTgr6w4TsxamBciC+kKLMepHuhT638/vd3cqj/4ywVZi3xup2oaUMmxoZaJJJaGWZ3zZmwO0oneBRS05/FIHh4ssY/R59/j5GCp7WJcs371AlKtbvIxQTVlzsqLFy3KOjLJd/Zh66nz9nd/LSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772036; c=relaxed/simple;
	bh=r6r4dSlFapZUVjswghkEX+7sIhVJtAX38qeiU9NIrcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6VsKwVhHdUEjnzsD2wju4uSVDg2WkmmkJjujZJQn4qxjT8tIjwYq6rtdEll9O1R5pDBTbdRIepJhL6Agn3of/UBEfkbmFLhhEOO6OvV5cjNGPG1VQlnTSmaJm/yhrVl2flQ8IXOPFWVxtAK+k2BVJkMinkq3xPBXU8ZSmCfbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fubt9Xgq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ebJ0unhVkfowMF5mvxUvLPwb4cKdQqQNwraw6G5iG8=;
	b=Fubt9XgqPSf3LINrUruKdNLSHVNmkLD1Ck+EcogtNYsrtkY6gpsDzfc5ZV+wfPh4mhEJEc
	9ibMQ70HW05cVovxxoMK9FoYSlFgQfVoeB16OSqKE/Jg6vckYxV9gxkTUWhHFANXwiRtSl
	36oKOlIkcRVh/p1Hz2cEAmK+juPYauw=
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
Subject: [PATCH dwarves v4 5/6] pahole: introduce --btf_feature=attributes
Date: Fri, 28 Feb 2025 11:46:53 -0800
Message-ID: <20250228194654.1022535-6-ihor.solodrai@linux.dev>
In-Reply-To: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
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
 btf_encoder.c | 6 ++++--
 dwarves.h     | 1 +
 pahole.c      | 9 +++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 991aba6..b380764 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -137,7 +137,8 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  gen_distilled_base;
+			  gen_distilled_base,
+			  encode_attributes;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
@@ -812,7 +813,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	assert(ftype != NULL || state != NULL);
 
-	if (is_kfunc_state(state) && encoder->tag_kfuncs)
+	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
 		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
 			return -1;
 
@@ -2405,6 +2406,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
+		encoder->encode_attributes = conf_load->btf_attributes;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 4202dfb..36c6898 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -99,6 +99,7 @@ struct conf_load {
 	bool			reproducible_build;
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
+	bool			btf_attributes;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 09aed1c..848827e 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1152,6 +1152,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARG_padding_ge		   347
 #define ARG_padding		   348
 #define ARGP_with_embedded_flexible_array 349
+#define ARGP_btf_attributes	   350
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1208,6 +1209,7 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
+	BTF_NON_DEFAULT_FEATURE(attributes, btf_attributes, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1783,6 +1785,11 @@ static const struct argp_option pahole__options[] = {
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
@@ -1977,6 +1984,8 @@ static error_t pahole__options_parser(int key, char *arg,
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


