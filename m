Return-Path: <bpf+bounces-54991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3257A76DFC
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8916B367
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D118BBBB;
	Mon, 31 Mar 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kimDF8yF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C70216E24
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451837; cv=none; b=AegsmKPAe9dN9PxuU6BrGIODu19q3eKxvBiAhIwUYDgKbp/K3tmfuahRx94SCAMguZIvZIxkZ0QveHCbFtXq+fvY9Y9h/VU3ZthJoHi/Jd9ReTZw4T9B71ArSaBoHbz9Q6Q17Y8yESvpzLA46LJXY49EfQnv0kYRv+eUgjzrbV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451837; c=relaxed/simple;
	bh=/DTbuuhLVNpbHtTt8fqm87LAVH3okI1UJz34ysO4E2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mf5bIpOTZ3RvirBgGEwCTzu2bKByNs0t+1PD9iXYsAlwHzI1invjfDils7vueDmPPAAlH7fzOcnwYdiqeEfyNGoEt00wN+V1YbHWI7qYEC47plY1MQHvgFarthOP4Qo04ruSLIwgvEAcG/7RVQ3xXfThu/3baDNU0nHFpZFIX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kimDF8yF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b116321aso5631678e87.3
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451833; x=1744056633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHty7clYNwCXavi66+rfgLX8CCmTXVsVBT8+fNIbevo=;
        b=kimDF8yF2zICfaD5D7xa9VD4iQ4FIXSu8+O51C0Fl11Zr24iuQ72B52jLgUsyrsD1f
         9238zTNraGxXn4KkCOYNriHtnh0sulmvBBtgzzI0N8kvfAH58MXFoYswE8bpDKSVLOrx
         dGvDLDLh2mbRijRq/5M83NuDY0wdl0FrcuQBM2QhHMu/SRTxGoLI6lB22Srax972/vhi
         2lcX0UQpMkjz/DYtiEtHW2Ka8+bMLVhXp+s8m3HPG+hY5skuYmF97tQW+/02aOlRcxIg
         1qSCtiGRAOsZQ8ij5OizJGbilnxzvmbOeDA9fIVDQZ5xLrETJASFiERKkmDZBrpFm0g7
         i9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451833; x=1744056633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHty7clYNwCXavi66+rfgLX8CCmTXVsVBT8+fNIbevo=;
        b=m/pMY+rmC2zGwtnDhx5+Lz23s1mHz1PBgQ9M0nOYt2TrFfsdAJutMPMoZVosdWNgeG
         2GbMAf4voyiyciKP+9Kmz2J40gva0Eq5J5bs0gZvVoNJ/wnVAycCrBPcaU9C34JdZvJ6
         3LOA1/8gnqL4Y5vABeJk90EO2Q5JW7hbjBC6Q/oLf9j4+ZlMXIJFhUtKz2DIh45mXTF/
         XB/cq/kmP4dXi02T+5QQzg5U4JSfFjgaLeiyFMF1zI+wL1Lx1agC/3kpSTUVetLvJy3H
         8prtIWVPyYLBTJFKdfXlremgyra9vv3UZCkXpL74CIb4VVXjXaAUJonHZQsKcB9Bf3EN
         U1oA==
X-Gm-Message-State: AOJu0YyBXRdSBAhkhY6xvVKftMuXTuM5GGNGuYc5zHS3r7xrbPBaMe0R
	LVcYIwOLNVY1ocjinGPY3y5Kne3hBCRpwQaLS3xvEE1ZGKNPGIXX8RO7IZZV
X-Gm-Gg: ASbGnctK+DjEFTwCklYwVjSi+Ea7KX9FyUC52in/yifFOjpQ65CcnBo2MQSDFPQ/1kF
	EoYMGt9u8rPlJxN4rjvjJhD8VpaNMC7pLpwSXp7O1nKy6Sa4Hmswsvv0zbEfy9S3BG99VnJIOSl
	3FgmRJN9/T5TlOBgKPjwt3Ws0v+qDbgndP4P/cfd+EeO31Pe47GjdYiFtjjTPzaWTfUDjuFXnRk
	cTUPpceTzcvRTcQdZtV6qLCCUIO0adyyiVizm8Ye+hZvnYJ287NGrLBqvrwwn/qNMN973Lht6YO
	OOI9o1ssVoImflGPldScOXYrcH3jvAQXudYDw6fZXjKh3WYMiSHt0A==
X-Google-Smtp-Source: AGHT+IFD7k3woM3hskaiiXK96WTyAqoDvML920N1OhMylJRhSnyACZkHwrQqnHYEaAOlkm8eLrmRMA==
X-Received: by 2002:ac2:51d1:0:b0:54b:117c:8ef5 with SMTP id 2adb3069b0e04-54b117c8f37mr3366958e87.56.1743451833034;
        Mon, 31 Mar 2025 13:10:33 -0700 (PDT)
Received: from cherry-pc-nix.. ([77.91.199.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580604sm1196328e87.122.2025.03.31.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:10:31 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: Timur Chernykh <tim.cherry.co@gmail.com>
Subject: [PATCH 2/2] libbpf: add check if kernel supports kind flag and fix the bitfield members in union and structs if not
Date: Mon, 31 Mar 2025 23:09:54 +0300
Message-ID: <20250331201016.345704-3-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201016.345704-1-tim.cherry.co@gmail.com>
References: <20250331201016.345704-1-tim.cherry.co@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
---
 tools/lib/bpf/features.c        | 30 ++++++++++++++++
 tools/lib/bpf/libbpf.c          | 62 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c..dfab65f30f0c 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -507,6 +507,33 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_btf_type_kind_flag(int token_fd)
+{
+	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
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
+	    };
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+			     strs, sizeof(strs), token_fd));
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
index 8e1edba443dd..392779c10a73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3113,9 +3113,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+    bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec || has_kind_bit_support;
 }
 
 static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
@@ -3128,6 +3129,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+	bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
 
 	char name_gen_buff[32] = {0};
 	int enum64_placeholder_id = 0;
@@ -3263,6 +3265,64 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				m->type = enum64_placeholder_id;
 				m->offset = 0;
 			}
+		} else if (!has_kind_bit_support && (btf_is_struct(t) || btf_is_union(t) || btf_is_fwd(t) || btf_is_enum(t) || btf_is_enum64(t))) {
+			const uint16_t members_cnt = btf_vlen(t);
+
+			/* type encoded with a kind flag */
+		    if (t->info != BTF_INFO_ENC(btf_kind(t), 1, members_cnt)) {
+		        continue;
+		    }
+
+		    /* unset kind flag anyway */
+		    t->info = BTF_INFO_ENC(btf_kind(t), 0, btf_vlen(t));
+
+		    /* structs an unions has a different bitfield processing behaviour is kind flag is set */
+		    if (btf_is_struct(t) || btf_is_union(t)) {
+		        struct btf_member* members = btf_members(t);
+				struct btf_type* new_int_type = NULL;
+				int new_int_type_id;
+				__u32* new_int_type_data;
+				int encoding = 0;
+		        int nmember;
+
+		        for (nmember = 0; nmember < members_cnt; nmember++) {
+		            struct btf_member* member = &members[nmember];
+		            const struct btf_type* member_type = btf_type_by_id(btf, member->type);
+
+		            while (btf_is_typedef(member_type)) { /* unwrap typedefs */
+		                member_type = btf_type_by_id(btf, member_type->type);
+		            }
+
+		            /* bitfields can be only int or enum values */
+		            if (!(btf_is_int(member_type) || btf_is_enum(member_type))) {
+		                continue;
+		            }
+
+		            encoding = btf_int_encoding(member_type);
+		            if (btf_is_enum(member_type) && member_type->info & 0x80000000 /* kind flag */) {
+		                /* enum value encodes integer signed/unsigned info in the kind flag */
+		                encoding = BTF_INT_SIGNED;
+		            }
+
+		            /* create new integral type with the same info */
+		            snprintf(name_gen_buff, sizeof(name_gen_buff), "__int_%d_%d", i, nmember);
+		            new_int_type_id = btf__add_int(btf, name_gen_buff, member_type->size, encoding);
+
+		            if (new_int_type_id < 0) {
+		                pr_warn("Error adding integer type for a bitfield %d of [%d]", nmember, i);
+		                return new_int_type_id;
+		            }
+
+		            new_int_type = btf_type_by_id(btf, new_int_type_id);
+
+		            /* encode int in legacy way, keep offset 0 and specify bit size as set in the member */
+		            new_int_type_data = (__u32*)(new_int_type + 1);
+		            *new_int_type_data = BTF_INT_ENC(encoding, 0, BTF_MEMBER_BITFIELD_SIZE(member->offset));
+
+		            member->type = new_int_type_id;
+		            member->offset = BTF_MEMBER_BIT_OFFSET(member->offset) /* old kernels looks only on offset */;
+		        }
+		    }
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


