Return-Path: <bpf+bounces-52901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EEA4A2ED
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB23A941A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95323230BD8;
	Fri, 28 Feb 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wj8UZ4Gg"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BBF1C5D6F
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772030; cv=none; b=O3IGlBewK+dQ/iHJUQerkOmOfK6f2siPI7UO6FKQfaqcp/fOPYcoXS9rd2h3ehLUKVnVjUNoklq0M8BEf1yfSoyDfkiWFRdw/ZzDha8xp1rvHjs4flxf3a3qyrWOyG8NfeuMF32Ek0P93V7SCmaej9eDRC3dARLobJa+p9M9b9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772030; c=relaxed/simple;
	bh=yg4TS8CTbNo80yad+WoWpwmsPOTfOkmeeVz0XWQX4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm2MQLgJ/t71wDFIO7Wr3bLZpSWVN+tX4H4UICMQlM0/blZqUnfDQ9dRAOfz0ZFhgOIk9V+fHBjnV9sONRNUQcn3XOdfoYplPeA9rb9dmxKogjG/9Ztac9UTtHUgdDJznTqAjA0keIb9MOyd0X+vBeUVymD+j3Ou60cQ2c6XI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wj8UZ4Gg; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfiz40Gklwc36IRc6D5RB8RYTiwqicDOMzbsToXd8BQ=;
	b=wj8UZ4GgvJN30mfG8peXCS8yU+3GlX8QYgk+MtSYB5CVvadUrne3AGISnXf77W/aP/EJC/
	zhYvTRro0dgmqWZC24hwub0mVHFMLnmJFIH1QqozJAhT9eB0vDylfRIQASq4fc7oEW2ZKp
	EeOnQKnVQaDn72k2S3sOscCqYnJvqEc=
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
Subject: [PATCH dwarves v4 2/6] btf_encoder: use __weak declarations of version-dependent libbpf API
Date: Fri, 28 Feb 2025 11:46:50 -0800
Message-ID: <20250228194654.1022535-3-ihor.solodrai@linux.dev>
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

Instead of compile-time checks for libbpf version, use __weak
declarations of the required API functions and do runtime checks at
the call sites. This will help with compatibility when libbpf is
dynamically linked to pahole [1].

[1] https://lore.kernel.org/dwarves/deff78f8-1f99-4c79-a302-cff8dce4d803@oracle.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 48 +++++++++++++++++++-----------------------------
 dwarves.h     | 11 ++++++++++-
 pahole.c      |  2 --
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2bea5ee..12a040f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -34,6 +34,7 @@
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
+#define BTF_BASE_ELF_SEC	".BTF.base"
 #define BTF_IDS_SECTION		".BTF_ids"
 #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
 #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
@@ -625,29 +626,6 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
 	return id;
 }
 
-#if LIBBPF_MAJOR_VERSION < 1
-static inline int libbpf_err(int ret)
-{
-        if (ret < 0)
-                errno = -ret;
-        return ret;
-}
-
-static
-int btf__add_enum64(struct btf *btf __maybe_unused, const char *name __maybe_unused,
-		    __u32 byte_sz __maybe_unused, bool is_signed __maybe_unused)
-{
-	return  libbpf_err(-ENOTSUP);
-}
-
-static
-int btf__add_enum64_value(struct btf *btf __maybe_unused, const char *name __maybe_unused,
-			  __u64 value __maybe_unused)
-{
-	return  libbpf_err(-ENOTSUP);
-}
-#endif
-
 static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *name, struct type *etype,
 				     struct conf_load *conf_load)
 {
@@ -660,8 +638,13 @@ static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *na
 	is_enum32 = size <= 4 || conf_load->skip_encoding_btf_enum64;
 	if (is_enum32)
 		id = btf__add_enum(btf, name, size);
-	else
+	else if (btf__add_enum64)
 		id = btf__add_enum64(btf, name, size, etype->is_signed_enum);
+	else {
+		fprintf(stderr, "btf__add_enum64 is not available, is libbpf < 1.0?\n");
+		return -ENOTSUP;
+	}
+
 	if (id > 0) {
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
@@ -684,10 +667,14 @@ static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *na
 	 */
 	if (conf_load->skip_encoding_btf_enum64)
 		err = btf__add_enum_value(encoder->btf, name, (uint32_t)value);
-	else if (etype->size > 32)
-		err = btf__add_enum64_value(encoder->btf, name, value);
-	else
+	else if (etype->size <= 32)
 		err = btf__add_enum_value(encoder->btf, name, value);
+	else if (btf__add_enum64_value)
+		err = btf__add_enum64_value(encoder->btf, name, value);
+	else {
+		fprintf(stderr, "btf__add_enum64_value is not available, is libbpf < 1.0?\n");
+		return -ENOTSUP;
+	}
 
 	if (!err) {
 		if (encoder->verbose) {
@@ -2035,10 +2022,14 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 		 * silently ignore the feature request if libbpf does not
 		 * support it.
 		 */
-#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 5
 		if (encoder->gen_distilled_base) {
 			struct btf *btf = NULL, *distilled_base = NULL;
 
+			if (!btf__distill_base) {
+				fprintf(stderr, "btf__distill_base is not available, is libbpf < 1.5?\n");
+				return -ENOTSUP;
+			}
+
 			if (btf__distill_base(encoder->btf, &distilled_base, &btf) < 0) {
 				fprintf(stderr, "could not generate distilled base BTF: %s\n",
 					strerror(errno));
@@ -2051,7 +2042,6 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 			btf__free(distilled_base);
 			return err;
 		}
-#endif
 		err = btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 	}
 
diff --git a/dwarves.h b/dwarves.h
index 8234e1a..ab32204 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -14,6 +14,7 @@
 #include <obstack.h>
 #include <dwarf.h>
 #include <elfutils/libdwfl.h>
+#include <linux/types.h>
 #include <sys/types.h>
 
 #include "dutil.h"
@@ -44,13 +45,21 @@ enum load_steal_kind {
 	LSK__STOP_LOADING,
 };
 
+/*
+ * Weak declarations of libbpf APIs that are version-dependent
+ */
+#define __weak __attribute__((weak))
+struct btf;
+__weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_sz, bool is_signed);
+__weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
+__weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
+
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
  * like a allyesconfig vmlinux kernel we can get over 65535 types.
  */
 typedef uint32_t type_id_t;
 
-struct btf;
 struct conf_fprintf;
 
 /** struct conf_load - load configuration
diff --git a/pahole.c b/pahole.c
index af3e1cf..09aed1c 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1206,9 +1206,7 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
-#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 5
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
-#endif
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 };
 
-- 
2.48.1


