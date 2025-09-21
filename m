Return-Path: <bpf+bounces-69132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A852BB8DBC7
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F191189E7A8
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779452D8DA9;
	Sun, 21 Sep 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO1xd025"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1C2D838E
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461123; cv=none; b=K8+O5XsrO6ZLFvsJPTBFA2StKCF8qaWA1YL5zQ2IKiLgpTrrX5ZQOgCoiVIXCjnPP+5lBcOv8Klyox38SSGfSzDhwq2/c375efK5z3ei3t9bNN37S6d5bx/AInDt7IyVWCdnUZ5sOt/eMTDksOH6cMuCs8vP7Pk9+oF4GK/euUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461123; c=relaxed/simple;
	bh=mBdQEU3Y32dedTvletgNvJZ5xEQNvNeydWwS0ODGBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3gSQNF8RRAJQ5UCRCmhkSCb/ObVVEgd6DAgRARRXrHZhC+ixoh2HicnTZ/vyW7zmA1S+L52gYM38+MZxZEL/WFrfO2OwT8azdvITNusRc85p9g4kGT9awb/8BIp1mKJM3sOgZ3WsqoswfO5dTTSdZDQ1lavCfTYHclzuFTmMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eO1xd025; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso16414865e9.0
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461119; x=1759065919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUVeJSsDIDpQugRbBHhP39x506NnX6Q2eJcWxkJAU98=;
        b=eO1xd025quNlI083I35a51Ckn4gT8Dm9Rb2TOUcj8MZvXimOy9n/b8xj1mdZhtvkQK
         r/gyF1fO0fvn94dtQttWi+vBijWvARl7tYQENbTBEle8J3oR69JeRl73vISYovt7db5K
         jPLTwxcYd3c/yUrcmgAIG/Hp3x4QhRfrKv8lx+qWi+ON4pJEALxyMIWKT4CWQ33VOWz+
         kBsL7qDRvezr0qJ0Y6LDY5qZs5sIQvVuKAIfdwjHHwYDmylnt0ocARSaD2f8WCQRNpLd
         NuEcGDuqy4gJcUV3kUlOT1bsJuCWTyH86msIvsmZQwdiRblPgY2QxVrtq2Cx37fcTeFR
         jbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461119; x=1759065919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUVeJSsDIDpQugRbBHhP39x506NnX6Q2eJcWxkJAU98=;
        b=HoRFbQ5WQkbxdX0+5ToHvq5dbwSPh9/ngbcTB5kDBU0Pjyl6Lewegujxh2BcVjW4eD
         0dnCxFj/v8LT7SpqJAxTKeXTVE5v7vyxUI3m3AZ+mO6WTsCDG1jqcChdOABXKa+/ikyr
         UoQkXxVCGrIcHhzUHZZz7NfWlGwFUlzXsrsbjdEzRwP5FeYftuqPIY7Ls2LLPd2ig0rW
         mOEUkfFvI2uIBvVamyQfwNSSFczxSSk6QkUserH++YKyNndjPYXsDB9Wc5AnkNXyk9UP
         jMXxapOwl2aXWXcHBoqBqBIIO6ZLNd/SGEWjEBZ81oGHWEcqSu3cf2dtm81ZW5nnKvHF
         QAJQ==
X-Gm-Message-State: AOJu0Yy1gnUe3AzCQ3e2xdkK+37lnLSlLouQspPfKknrKxImVloPdXvj
	t57tRYJM4ckUd4OuPe31N//qSZUFmlIYXxkGqJW5FyyOvVMZX14r+L45gfekyEPRifU=
X-Gm-Gg: ASbGncvlfmS3pcPeIIeKFnz0r8rCXHrQYk8bstmxIYyr7ARSFTbrPtJSBRDV1Ao8LRD
	60nDCZxGT1c8/4WccqSERl0/DrT5cF8ujOcKZbaMpBITfKPOwtSjx1HLgp9cLb7Ei7/4yV3bvX4
	AOCQqZg3UA7meO5lVq6l1QrPvDnfWrk9osn1/RE2jsXFhXl22jfOM8W8mClrav+qYdcrcrQ6KHK
	InScTmR27sNDgfM2M28Lx2YzSJAy7GynuswDR3+SuHPx4tJODw3Tk/i35L8uR4FawWigcDb4omU
	KilsKxVZ1KKEVFOQgyY8g35lKRguc0/e3DpB6f250ts1v35V6HTOtLse9i81z+vWzqE2TqDqDaN
	YY7SI6N8cx6MvGBF5tfmCRXFHtUeu+TLlaIOJjHHWJg==
X-Google-Smtp-Source: AGHT+IHVXYMkKgIPenpy+9NDLHm9QJ5bXjJBCcxAWPsfc9jfjfO7lIvBvu2uOU3tyxrErpA0r35peQ==
X-Received: by 2002:a05:600c:1991:b0:45d:e135:6bb2 with SMTP id 5b1f17b1804b1-467ea00464dmr77936765e9.21.1758461119185;
        Sun, 21 Sep 2025 06:25:19 -0700 (PDT)
Received: from localhost.localdomain ([209.38.224.166])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46d1f3e1b03sm5898375e9.23.2025.09.21.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:25:18 -0700 (PDT)
From: Nick Zavaritsky <mejedi@gmail.com>
To: bpf@vger.kernel.org
Cc: Nick Zavaritsky <mejedi@gmail.com>
Subject: [PATCH 1/1] bpftool: Formatting defined by user:fmt: decl tag
Date: Sun, 21 Sep 2025 13:24:50 +0000
Message-ID: <20250921132503.9384-2-mejedi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921132503.9384-1-mejedi@gmail.com>
References: <20250921132503.9384-1-mejedi@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain data types get exceptionally unwieldy when formatted by bpftool,
e.g. IP6 addresses.

Introduce custom formatting in bpftool driven by user:fmt: decl tag.
When a type is tagged user:fmt:ip, the value is formatted as IP4 or IP6
address depending on the value size.

When a type is tagged user:fmt:be, the value is interpreted as a
big-endian integer (2, 4 or 8 bytes).

Example:

typedef struct in6_addr bpf_in6_addr
    __attribute__((__btf_decl_tag__("user:fmt:ip")));
bpf_in6_addr in6;

$ bpftool map dump name .data
[{
        "value": {
            ".data": [{
                    "in6": "2001:db8:130f::9c0:876a:130b"
                }
            ]
        }
    }
]

versus

$ bpftool map dump name .data
[{
        "value": {
            ".data": [{
                    "in6": {
                        "in6_u": {
                            "u6_addr8": [32,1,13,184,19,15,0,0,0,0,9,192,135,106,19,11
                            ],
                            "u6_addr16": [288,47117,3859,0,0,49161,27271,2835
                            ],
                            "u6_addr32": [3087860000,3859,3221815296,185821831
                            ]
                        }
                    }
                }
            ]
        }
    }
]

Signed-off-by: Nick Zavaritsky <mejedi@gmail.com>
---
 tools/bpf/bpftool/btf_dumper.c | 119 +++++++++++++++++++++++++++++----
 tools/bpf/bpftool/main.h       |  12 ++++
 tools/bpf/bpftool/map.c        |   7 +-
 3 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index ff12628593ae..8f21c9e39abc 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -11,6 +11,8 @@
 #include <linux/err.h>
 #include <bpf/btf.h>
 #include <bpf/bpf.h>
+#include <errno.h>
+#include <arpa/inet.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -132,18 +134,6 @@ static void btf_dumper_ptr(const struct btf_dumper *d,
 		jsonw_printf(d->jw, "%lu", value);
 }
 
-static int btf_dumper_modifier(const struct btf_dumper *d, __u32 type_id,
-			       __u8 bit_offset, const void *data)
-{
-	int actual_type_id;
-
-	actual_type_id = btf__resolve_type(d->btf, type_id);
-	if (actual_type_id < 0)
-		return actual_type_id;
-
-	return btf_dumper_do_type(d, actual_type_id, bit_offset, data);
-}
-
 static int btf_dumper_enum(const struct btf_dumper *d,
 			    const struct btf_type *t,
 			    const void *data)
@@ -556,6 +546,36 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 			      __u8 bit_offset, const void *data)
 {
 	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
+	char addr[INET6_ADDRSTRLEN];
+
+	if (!t)
+		return -errno;
+
+	switch ((bit_offset == 0 && d->fmt_tags) ? d->fmt_tags[type_id] :
+						   BTF_FMT_DEFAULT) {
+	case BTF_FMT_BE16:
+		jsonw_printf(d->jw, "\"%d\"",
+			     be16_to_cpu(*(const __be16 *)data));
+		return 0;
+	case BTF_FMT_BE32:
+		jsonw_printf(d->jw, "\"%u\"",
+			     be32_to_cpu(*(const __be32 *)data));
+		return 0;
+	case BTF_FMT_BE64:
+		jsonw_printf(d->jw, "\"%lu\"",
+			     be64_to_cpu(*(const __be64 *)data));
+		return 0;
+	case BTF_FMT_IP4:
+		jsonw_string(d->jw,
+			     inet_ntop(AF_INET, data, addr, sizeof(addr)));
+		return 0;
+	case BTF_FMT_IP6:
+		jsonw_string(d->jw,
+			     inet_ntop(AF_INET6, data, addr, sizeof(addr)));
+		return 0;
+	default:
+		break;
+	}
 
 	switch (BTF_INFO_KIND(t->info)) {
 	case BTF_KIND_INT:
@@ -584,7 +604,7 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
-		return btf_dumper_modifier(d, type_id, bit_offset, data);
+		return btf_dumper_do_type(d, t->type, bit_offset, data);
 	case BTF_KIND_VAR:
 		return btf_dumper_var(d, type_id, bit_offset, data);
 	case BTF_KIND_DATASEC:
@@ -595,6 +615,79 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 	}
 }
 
+enum btf_fmt_tag *btf_fmt_tags_get(const struct btf *btf)
+{
+	int n = btf__type_cnt(btf);
+	enum btf_fmt_tag *tags = calloc(n, sizeof(tags[0]));
+
+	if (!tags)
+		return NULL;
+
+	for (int i = 1; i < n; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const struct btf_decl_tag *tag;
+		const char *name;
+		__s64 size;
+
+		if (!t)
+			goto err_free;
+		if (btf_kind(t) != BTF_KIND_DECL_TAG)
+			continue;
+
+		tag = (const void *)(t + 1);
+		if (tag->component_idx != -1)
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			goto err_free;
+
+#define BTF_FMT_TAG_PREFIX "user:fmt:"
+		if (strncmp(name, BTF_FMT_TAG_PREFIX,
+			    sizeof(BTF_FMT_TAG_PREFIX) - 1))
+			continue;
+
+		size = btf__resolve_size(btf, t->type);
+		if (size < 0)
+			continue; // could be a forward decl
+
+		if (btf_kind(btf__type_by_id(btf, t->type)) == BTF_KIND_VAR)
+			continue;
+
+		name += sizeof(BTF_FMT_TAG_PREFIX) - 1;
+		if (!strcmp(name, "be")) {
+			switch (size) {
+			case 2:
+				tags[t->type] = BTF_FMT_BE16;
+				break;
+			case 4:
+				tags[t->type] = BTF_FMT_BE32;
+				break;
+			case 8:
+				tags[t->type] = BTF_FMT_BE64;
+				break;
+			default:
+				break;
+			}
+		} else if (!strcmp(name, "ip")) {
+			switch (size) {
+			case 4:
+				tags[t->type] = BTF_FMT_IP4;
+				break;
+			case 16:
+				tags[t->type] = BTF_FMT_IP6;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+	return tags;
+err_free:
+	free(tags);
+	return NULL;
+}
+
 int btf_dumper_type(const struct btf_dumper *d, __u32 type_id,
 		    const void *data)
 {
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 374cac2a8c66..6ff186300dc2 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -210,8 +210,20 @@ unsigned int get_possible_cpus(void);
 const char *
 ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt);
 
+enum btf_fmt_tag {
+	BTF_FMT_DEFAULT = 0,
+	BTF_FMT_BE16,
+	BTF_FMT_BE32,
+	BTF_FMT_BE64,
+	BTF_FMT_IP4,
+	BTF_FMT_IP6,
+};
+
+enum btf_fmt_tag *btf_fmt_tags_get(const struct btf *btf);
+
 struct btf_dumper {
 	const struct btf *btf;
+	const enum btf_fmt_tag *fmt_tags;
 	json_writer_t *jw;
 	bool is_plain_text;
 	bool prog_id_as_func_ptr;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..e91ae50710fc 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -744,6 +744,7 @@ static int do_show(int argc, char **argv)
 
 static int dump_map_elem(int fd, void *key, void *value,
 			 struct bpf_map_info *map_info, struct btf *btf,
+			 const enum btf_fmt_tag *fmt_tags,
 			 json_writer_t *btf_wtr)
 {
 	if (bpf_map_lookup_elem(fd, key, value)) {
@@ -756,6 +757,7 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else if (btf) {
 		struct btf_dumper d = {
 			.btf = btf,
+			.fmt_tags = fmt_tags,
 			.jw = btf_wtr,
 			.is_plain_text = true,
 		};
@@ -829,6 +831,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	void *key, *value, *prev_key;
 	unsigned int num_elems = 0;
 	struct btf *btf = NULL;
+	enum btf_fmt_tag *fmt_tags = NULL;
 	int err;
 
 	key = malloc(info->key_size);
@@ -846,6 +849,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		if (err) {
 			goto exit_free;
 		}
+		fmt_tags = btf_fmt_tags_get(btf);
 
 		if (show_header) {
 			jsonw_start_object(wtr);	/* map object */
@@ -872,7 +876,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 				err = 0;
 			break;
 		}
-		if (!dump_map_elem(fd, key, value, info, btf, wtr))
+		if (!dump_map_elem(fd, key, value, info, btf, fmt_tags, wtr))
 			num_elems++;
 		prev_key = key;
 	}
@@ -891,6 +895,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	free(value);
 	close(fd);
 	free_map_kv_btf(btf);
+	free(fmt_tags);
 
 	return err;
 }
-- 
2.43.0


