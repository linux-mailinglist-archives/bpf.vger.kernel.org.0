Return-Path: <bpf+bounces-55011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD49A76FAC
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593221657BF
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8C21ADBC;
	Mon, 31 Mar 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chcX8JH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327C2153E7
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454202; cv=none; b=aywIRHwf0I2du16YkdtnnWb8TatzJuiWQpCnZfuZXeBxdqSUKaDDterHyEAG5TA57yq0QiNCTVBDZ0jcf5fYKo0VfRzJVcXP553uvPq+B6aIB5bdXtlFlhpNPbv7FUpD7ygNDNr8FrB1qel9IDZWJUHgvOwAZR0btsqrkeI97Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454202; c=relaxed/simple;
	bh=M/xJbG/Be9uWpIuqs3fx64bF6mO5iZQBAqoBu8CEsbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb3eOkQbnFUboAzOACuMqzWcpU88CoRLNASSxXYS7Wu8Y8rwrTOhngwI7g+LSS+KVxGV0Mbtm4hCcoW4lssa/HLtww2cE89emsDoHmnVNdDMx/O9qugvs/jQpTdBT2D8ueWQSciW1H/JYOwjifSPoTkX8GrBRhzTK4M9q/cOLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chcX8JH5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf8632052so42547041fa.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743454198; x=1744058998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPrOxMLOc0k3rrFyViJh/kH7K0o2fNeqEKVTe7tBNaI=;
        b=chcX8JH5LiiS7HcXm89pSvwKoJXrLblPHRXWWewc8MTFi0h5nXu6V3ni/V+5adwB/3
         3Krg2G9UVJhOljWesdXkeRM/rqNfmyA0vQweS+NSfezARbBiqYRerYyGEcXdq0vwOEOq
         /pbKXFf8K06MAcTt/mPNho7j63DSq0c59vN9cVkr0fPSgNoU9DLA/OUEbigH5k0s23Fo
         GGvmBEZBiSy51T2O/9ngX/BTawZF7Ac1UM2f6od0MVwjZ53+8fIsDcqXWkIzK0f1Nqwl
         c8ppY9eMzTawHvchP/TWAlM8OPDv5+M2Fi8oWbqPSXqTPSzzdl4MHtXd8iIz0Y1xsRZj
         h+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454198; x=1744058998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPrOxMLOc0k3rrFyViJh/kH7K0o2fNeqEKVTe7tBNaI=;
        b=gN6H1FYg/GtT0djX34l4GN8kVhHS7Y8jIJuS/GF0494lRP6PrjginzEet0ppzFjFtp
         x1J1XbIJhxNTYc6rocCOdr9OaCFpXVSI6VqneiAsESlQjDAoPcS1oBOhNm8SsjdiaWzU
         aHo+1Ys7FpVfRT1bceCseqmtSru5hE+lwCge0bWPFWAeHfGhpAtHEXEqEaaddaDPY7Yr
         VF87FgULS7r9IwBSiixr7DHKTUwcAf2auClvCOkUtOsCQmeNJ+Ubmp8YOsJfM5IUFn+O
         BFetaL3kgwGa5KnhiaYjrBzmsVS6mqZo3xqgWunsQOl8+ydt8bv6jwxAIrjfrjWhgfcc
         SDMQ==
X-Gm-Message-State: AOJu0Yx7i/TScOei2+7i+z3CL75wYWBCbi+A/tcQXZc2/paGDkPyTH5u
	R6CjY+fhQ3vX0h2MrNEYwnwAw8weqVZTASmB0kIMlhZMIJCZL7yh4R1qp9XK
X-Gm-Gg: ASbGncuv2+HYXhq4k1poKlJESzOzHPknDAdoikJLOeZb+sZqu2qkpHvzLmPSp0ZHxge
	lpm1NSFpu817GTJZA5hW8aA35KrwuUWZ4IM3JOQ6TrtZSQgjRNdSmbgktqDCUEXY/iZTC723JWN
	sSStYUNudEwFGG3k94Qq9GLYwBMhVuEhqf6nnJvoPIOKTmilGfhGOale89pXXHtzGX1PyvDavl5
	vSLgQiTnl+HN/XEW7WleI/wkTzdcskF1CKtB995m8BqiaYZ4nKcq4BG8Y5zDC1+Mz5IjkBH7X6I
	pFyHiSeL2ikVGFU5Nx2kBauB3hlwh5ThGAz1UOTua9VtX4oJtPztfQj9lG0PNhUJBqLEyYmhRB1
	7kk8EJXY0T5Zf+Fd82bG1yVJo90s=
X-Google-Smtp-Source: AGHT+IFn01J94a9su+bZz3Cuk3GVOQy3aDDKV7hDXT7DSZ2HGmHSPCkwERZBgzkcY3XpUFXs5VitvA==
X-Received: by 2002:a2e:a99e:0:b0:30d:e104:b67b with SMTP id 38308e7fff4ca-30de104b8admr29643981fa.38.1743454198110;
        Mon, 31 Mar 2025 13:49:58 -0700 (PDT)
Received: from cherry-pc-nix.. (static.124.213.12.49.clients.your-server.de. [49.12.213.124])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2aa931dsm15134651fa.15.2025.03.31.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:49:56 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: Timur Chernykh <tim.cherry.co@gmail.com>
Subject: [PATCH 2/2] libbpf: add check if kernel supports kind flag and fix the bitfield members in union and structs if not
Date: Mon, 31 Mar 2025 23:45:07 +0300
Message-ID: <20250331204945.357823-2-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331204945.357823-1-tim.cherry.co@gmail.com>
References: <20250331204945.357823-1-tim.cherry.co@gmail.com>
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
index 8e1edba443dd..13ed8f03cc65 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3113,9 +3113,10 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_type_tag = kernel_supports(obj, FEAT_BTF_TYPE_TAG);
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
+    bool has_kind_bit_support = kernel_supports(obj, FEAT_BTF_TYPE_KIND_FLAG);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
-	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec;
+	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec || !has_kind_bit_support;
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


