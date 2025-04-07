Return-Path: <bpf+bounces-55425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB1A7ECED
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9663F3ADC70
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F44253F07;
	Mon,  7 Apr 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H72Fdx+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571A253B75
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052535; cv=none; b=heb2CAtnygERZufeChz1R9X0zP7EodXihyziXi1Ps7HPzCngqqnd6/Zeqmw4d/bNz1Y3imE+PWKUZhT0Uv5ewpvhLnPE4Mcv3aofcbLw8asmp41s68vJQY1kxDO4EvNCfEw0i9wP50UzlZ2x1vAe4QQz03D9gRYc2fidMU9zM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052535; c=relaxed/simple;
	bh=HKrYMcT7tWW1dxj9z7Mms2BgR9IvVdgn0sdQ4OAfMhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctFe0tQQntYWyUlK/zYZRveT/mMfs+8u9Y2qSY23zbdbR5wLLmu1KhLYrPkaV3aA1kFnTIgOJVLEnKLAKSajg1cZ56VYj0vpKzy/MECgq/19FXQttnRbBj7JZwxSkTPSrun1gw/3fVmtuP+kpMSTVVxKiBupVcVQPGwgLrzOFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H72Fdx+G; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54993c68ba0so5298618e87.2
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052531; x=1744657331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQq8LJCLO+B+e6wja9sNZ4jPvJQWYqwgjPmlFadkx+o=;
        b=H72Fdx+G6UG6ZoyOqHXg4z9WxEt7UssBjIaHniDYgF63Sk79LGsWGqfNiY//uaWEgh
         cMZfH8EGh0SU+Py0PNiZ0kxwKw8MLa9KJwx9Gi3KEEgTg7LKrtI7JmJ/7xbCyhDV+s4S
         nidRI6Usi5GjEXWeZHff66OP4/Wbk03Ddr5DnB+OLTfIgV49oqqNfPFIhbumSE4RcSpv
         i0j22SaFElnJUSMcIcRwha2dP1HT8CoXYK/+gFFuERbpGyJ/ligNwes+18TK1+bW3Tnv
         HdyghCr4sZRybDb3LI3Rms5W/uj3xY9KDadDXlkP2FKRDQOun2lVbXawnShO/ja/ommA
         /JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052531; x=1744657331;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQq8LJCLO+B+e6wja9sNZ4jPvJQWYqwgjPmlFadkx+o=;
        b=tDz097FfkDrvrq9VDNXcJmDNmKINXQ+HCYbb8/hbbJf9q+2TSUgw5P6VzLy9frysBJ
         ALZGJtfYf7WtUDvhNjRqfIrVIssUmWtIk2Kk1qfPvYnk9qJgEOqNtWsAjBzVPE0XK82q
         HPwmic01u3PK+z84bloho3cN1F4lmwPbbeeWGZ2ix1/HMXpeWFPaA92H3bKCco+wqb6X
         QQh1SMBdQZMNBGqpWAuajw/eQryMdlCtJpfIMDKvcIhiYuVhc1vzEC6SzTS2b14/uPXG
         9U+OFAKDo7RIsNqt+RwFyMF3/sAJcWpEmT0eHX27Mx7Kc7NdFWWC+jJayiiFBVthpDGk
         7F2Q==
X-Gm-Message-State: AOJu0YxTOYd134Pz+U37ylZrYZcyFg8OC0f7XoarNLfiaIPtspkR+B8c
	Y8pxivUsj1W2ojSbq3nn0878htAA8m65iXpTQPf5AcIxV4a5x8XGn449QYGMRuo=
X-Gm-Gg: ASbGncu8FUD34jsNWYxWcyK+6AFhc1s9f3Nu6QurwWAbjBle7KxPgEbBAEnOI7k71vQ
	bvBX02yhN87Aq68Md3JGn899TVsy3JBVqiyCMQYb6Qzo8Avm+cGttU0ep99ynzAMfLlDuIn3OOu
	PIGxtVCzI1xnHyJWipln2IhEkV9uJGUbOrQUJc7Psm6FcVQzf4xzAmy2uFInix6dc8OZ09QhyWL
	EvQmeNQ4H5pZRzPK1sP/n6hl0/thyuT6SDJ0l/Df5TwAMgk5Udl0rR1tf/jQ6eejjN253lFEpTi
	I+aKK5BHKeBSqIFYFWDy3nJUmgCjNe/tmpgWmDmoDydNJknwwXdyZBk1wcslqmugh3GgstHvieQ
	DsciRkyqIvmXKi8HNQHZvfTK6awJCRnRwVTFyCw==
X-Google-Smtp-Source: AGHT+IG3RifzpKcLM8n9od1oRcCsUqn5B3Oq/d3ex/T8hUWthecTcfvytKkI29r0FnWGPTHDwffg7A==
X-Received: by 2002:a05:6512:3b8b:b0:545:9e1:e824 with SMTP id 2adb3069b0e04-54c2280c34fmr3466741e87.48.1744052531325;
        Mon, 07 Apr 2025 12:02:11 -0700 (PDT)
Received: from cherry-pc-nix.. (static.124.213.12.49.clients.your-server.de. [49.12.213.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c1c30sm1376997e87.75.2025.04.07.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:02:10 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	Timur Chernykh <tim.cherry.co@gmail.com>
Subject: [PATCH v2 2/2] libbpf: add kind flag sanitizing
Date: Mon,  7 Apr 2025 22:01:38 +0300
Message-ID: <20250407190158.351783-3-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407190158.351783-1-tim.cherry.co@gmail.com>
References: <20250407190158.351783-1-tim.cherry.co@gmail.com>
Reply-To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missed check whether kernel supports the kind flag or not.
The fix includes:
- The feature check whether kernel supports the kind flag or not
- Kind flag sanitizing if kernel doesn't support one
- Struct/enum bitfield members sanitizing by generation a proper
  replacement for the type of bitfield with corresponding integer
  type with same bit size

Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
---
 tools/lib/bpf/features.c        | 30 +++++++++++++
 tools/lib/bpf/libbpf.c          | 74 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 +
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c..b40a3fadb68b 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -507,6 +507,33 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_btf_type_kind_flag(int token_fd)
+{
+	static const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
+	/* struct bpf_spin_lock {
+	 *   int val;
+	 * };
+	 * struct val {
+	 *   int cnt;
+	 *   struct bpf_spin_lock l;
+	 * };
+	 */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* struct bpf_spin_lock */                      /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind bit */, 1), 4),
+		BTF_MEMBER_ENC(15, 1, 0), /* int val; */
+		/* struct val */                                /* [3] */
+		BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind bit */, 2), 8),
+		BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
+		BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs), token_fd));
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -582,6 +609,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_BTF_TYPE_KIND_FLAG] = {
+		"BTF btf_type can have the kind flags set", probe_kern_btf_type_kind_flag,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c2369b6f3260..b1d4530bd9ed 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3113,9 +3113,11 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+	bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
+		   !has_kind_bit_support;
 }
 
 static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
@@ -3128,6 +3130,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+	bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
 
 	char name_gen_buff[32] = {0};
 	int enum64_placeholder_id = 0;
@@ -3263,6 +3266,75 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				m->type = enum64_placeholder_id;
 				m->offset = 0;
 			}
+		} else if (!has_kind_bit_support &&
+			   (btf_is_composite(t) || btf_is_fwd(t) || btf_is_enum(t) || btf_is_enum64(t))) {
+			vlen = btf_vlen(t);
+
+			/* type encoded with a kind flag */
+			if (btf_kflag(t))
+				continue;
+
+		    /* unset kind flag anyway */
+		    t->info = BTF_INFO_ENC(btf_kind(t), 0, btf_vlen(t));
+
+		    /* compisite types has a different bitfield processing if kind flag is set */
+			if (btf_is_composite(t)) {
+				struct btf_member *members = btf_members(t);
+
+				struct btf_type *curr_type = NULL; /* current member type */
+				struct btf_type *new_type = NULL; /* replacement for current member type */
+				int curr_tid = 0;
+				int new_tid = 0;
+				__u32 *new_type_data = NULL;
+				int encoding = 0;
+
+				for (j = 0; j < vlen; j++) {
+					struct btf_member *member = &members[j];
+
+					 /* unwrap typedefs, volatiles, etc. */
+					curr_tid = btf__resolve_type(btf, member->type);
+
+					if (curr_tid < 0) {
+						pr_warn("Error resolving type [%d] for member %d of [%d]\n",
+								member->type, j, i);
+						return curr_tid;
+					}
+
+					curr_type = btf_type_by_id(btf, curr_tid);
+
+					/* bitfields can be only int or enum values */
+					if (!(btf_is_int(curr_type) || btf_is_enum(curr_type)))
+						continue;
+
+					encoding = btf_int_encoding(curr_type);
+
+					/* enum value encodes integer signed/unsigned info in the kind flag */
+					if (btf_is_enum(curr_type) && btf_kflag(curr_type))
+						encoding = BTF_INT_SIGNED;
+
+					/* create new integral type with the same info */
+					snprintf(name_gen_buff, sizeof(name_gen_buff), "__int_%d_%d", i, j);
+					new_tid = btf__add_int(btf, name_gen_buff, curr_type->size, encoding);
+
+					if (new_tid < 0) {
+						pr_warn("Error adding integer type for a bitfield %d of [%d]\n", j, i);
+						return new_tid;
+					}
+
+					new_type = btf_type_by_id(btf, new_tid);
+
+					/* encode int in legacy way,
+					 * keep offset 0 and specify bit size as set in the member
+					 */
+					new_type_data = (__u32 *)(new_type + 1);
+					*new_type_data = BTF_INT_ENC(encoding, 0,
+								     BTF_MEMBER_BITFIELD_SIZE(member->offset));
+
+					/* old kernels looks only on offset */
+					member->offset = BTF_MEMBER_BIT_OFFSET(member->offset);
+					member->type = new_tid;
+				}
+			}
 		}
 	}
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 76669c73dcd1..6369c5520fce 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -380,6 +380,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports kind flag */
+	FEAT_BTF_TYPE_KIND_FLAG,
 	__FEAT_CNT,
 };
 
-- 
2.49.0


