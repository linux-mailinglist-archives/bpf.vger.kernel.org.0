Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F253444E139
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhKLFF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLFF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD84C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n23so7033831pgh.8
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiMShk+/WnmYnGbVfQbtQQtJDNUrhhDPr+9h4QOIZdc=;
        b=GHqkG76jd6wYe0NUniKmneoqGlvFM3p9K/wN4JWhSU+33/DEG8Z8HInU/24kvzBbsX
         /sXEQZk42AHA5TvbcDjZM7atRBf5/CMORLdpPObyMj5mebllq1uNRZVaXqwyz5O5Hpuh
         NjW746WdMqCgNeZoPImFxXCUsIPaBeLpSYx14yBtVb9B2Cl+jZu2+mMtOOr1aryKHQf7
         LtLAxPZndtFlW+cFoib0GdbDumWxi9R3DdTO1yAnTac27+BaTXK8ZzlLDybpu8KTckFj
         Ph4fvYo/VFzgPvFj437b4czqS2Eia7Kx6UsZQWS2/AgexHSbud8xlhMzt4WBClhKUVVY
         03LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiMShk+/WnmYnGbVfQbtQQtJDNUrhhDPr+9h4QOIZdc=;
        b=UbxRMhe6L0QHCdxzcOk5qi9ESxoBX2PM0OI5qacj4l0ZQRfVwyrfcsOxmYYknOtujC
         CCPdRT2C+WKdhjUDNX2ZPXfqQaqGnhwk3sTPtxfXkDByqE0xs4zlcJTWffHSZV5oiFpu
         aA+LzXFvIXaRee4u1VtKeCKOi7eopoG71+H4KsMSull0FJAZ/M5LehAsMHjS8bagcZoK
         EJVqujM0MBygtHcWEgGefX7ev03WWQql8QFF5FASF/7AiJ2WwNg+bVpjzN5Iq0tvBEzq
         V0rNhqGMJDv4/dh78rWwZ3rUcYWq9CVcOapdTLcN4Xqy0dcdk4zbQkQT/W6xUTQZgXQ3
         PTjQ==
X-Gm-Message-State: AOAM532ONl23E2iGlI3W/pv5HRQK7z0MfuNpOZXv5/9QVcxKP7CqTo3j
        axbn3BCT4GjR17PIaZVvMv8=
X-Google-Smtp-Source: ABdhPJzf4RTyZ8Wb38Vccu/lfgixnSDKaIQMkr4POSrDPgYmT2rUO1yXL7I0X85oJzGoVNy/vO7Bbg==
X-Received: by 2002:a63:de41:: with SMTP id y1mr8306411pgi.93.1636693357910;
        Thu, 11 Nov 2021 21:02:37 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id w20sm3784359pga.52.2021.11.11.21.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:37 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 02/12] bpf: Rename btf_member accessors.
Date:   Thu, 11 Nov 2021 21:02:20 -0800
Message-Id: <20211112050230.85640-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Rename btf_member_bit_offset() and btf_member_bitfield_size() to
avoid conflicts with similarly named helpers in libbpf's btf.h.
Rename the kernel helpers, since libbpf helpers are part of uapi.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/btf.h         |  8 ++++----
 kernel/bpf/bpf_struct_ops.c |  6 +++---
 kernel/bpf/btf.c            | 18 +++++++++---------
 net/ipv4/bpf_tcp_ca.c       |  6 +++---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 203eef993d76..956f70388f69 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -194,15 +194,15 @@ static inline bool btf_type_kflag(const struct btf_type *t)
 	return BTF_INFO_KFLAG(t->info);
 }
 
-static inline u32 btf_member_bit_offset(const struct btf_type *struct_type,
-					const struct btf_member *member)
+static inline u32 __btf_member_bit_offset(const struct btf_type *struct_type,
+					  const struct btf_member *member)
 {
 	return btf_type_kflag(struct_type) ? BTF_MEMBER_BIT_OFFSET(member->offset)
 					   : member->offset;
 }
 
-static inline u32 btf_member_bitfield_size(const struct btf_type *struct_type,
-					   const struct btf_member *member)
+static inline u32 __btf_member_bitfield_size(const struct btf_type *struct_type,
+					     const struct btf_member *member)
 {
 	return btf_type_kflag(struct_type) ? BTF_MEMBER_BITFIELD_SIZE(member->offset)
 					   : 0;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 8ecfe4752769..21069dbe9138 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -165,7 +165,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 				break;
 			}
 
-			if (btf_member_bitfield_size(t, member)) {
+			if (__btf_member_bitfield_size(t, member)) {
 				pr_warn("bit field member %s in struct %s is not supported\n",
 					mname, st_ops->name);
 				break;
@@ -296,7 +296,7 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 	const struct btf_type *mtype;
 
 	for_each_member(i, t, member) {
-		moff = btf_member_bit_offset(t, member) / 8;
+		moff = __btf_member_bit_offset(t, member) / 8;
 		if (moff > prev_mend &&
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
@@ -387,7 +387,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		struct bpf_prog *prog;
 		u32 moff;
 
-		moff = btf_member_bit_offset(t, member) / 8;
+		moff = __btf_member_bit_offset(t, member) / 8;
 		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1dd9ba82da1e..4373f9eb3106 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2969,7 +2969,7 @@ static s32 btf_struct_check_meta(struct btf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		offset = btf_member_bit_offset(t, member);
+		offset = __btf_member_bit_offset(t, member);
 		if (is_union && offset) {
 			btf_verifier_log_member(env, t, member,
 						"Invalid member bits_offset");
@@ -3094,7 +3094,7 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 		if (off != -ENOENT)
 			/* only one such field is allowed */
 			return -E2BIG;
-		off = btf_member_bit_offset(t, member);
+		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
@@ -3184,8 +3184,8 @@ static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 
 		btf_show_start_member(show, member);
 
-		member_offset = btf_member_bit_offset(t, member);
-		bitfield_size = btf_member_bitfield_size(t, member);
+		member_offset = __btf_member_bit_offset(t, member);
+		bitfield_size = __btf_member_bitfield_size(t, member);
 		bytes_offset = BITS_ROUNDDOWN_BYTES(member_offset);
 		bits8_offset = BITS_PER_BYTE_MASKED(member_offset);
 		if (bitfield_size) {
@@ -5060,7 +5060,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		if (array_elem->nelems != 0)
 			goto error;
 
-		moff = btf_member_bit_offset(t, member) / 8;
+		moff = __btf_member_bit_offset(t, member) / 8;
 		if (off < moff)
 			goto error;
 
@@ -5083,14 +5083,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 
 	for_each_member(i, t, member) {
 		/* offset of the field in bytes */
-		moff = btf_member_bit_offset(t, member) / 8;
+		moff = __btf_member_bit_offset(t, member) / 8;
 		if (off + size <= moff)
 			/* won't find anything, field is already too far */
 			break;
 
-		if (btf_member_bitfield_size(t, member)) {
-			u32 end_bit = btf_member_bit_offset(t, member) +
-				btf_member_bitfield_size(t, member);
+		if (__btf_member_bitfield_size(t, member)) {
+			u32 end_bit = __btf_member_bit_offset(t, member) +
+				__btf_member_bitfield_size(t, member);
 
 			/* off <= moff instead of off == moff because clang
 			 * does not generate a BTF member for anonymous
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 2cf02b4d77fb..67466dbff152 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -169,7 +169,7 @@ static u32 prog_ops_moff(const struct bpf_prog *prog)
 	t = bpf_tcp_congestion_ops.type;
 	m = &btf_type_member(t)[midx];
 
-	return btf_member_bit_offset(t, m) / 8;
+	return __btf_member_bit_offset(t, m) / 8;
 }
 
 static const struct bpf_func_proto *
@@ -244,7 +244,7 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
 	utcp_ca = (const struct tcp_congestion_ops *)udata;
 	tcp_ca = (struct tcp_congestion_ops *)kdata;
 
-	moff = btf_member_bit_offset(t, member) / 8;
+	moff = __btf_member_bit_offset(t, member) / 8;
 	switch (moff) {
 	case offsetof(struct tcp_congestion_ops, flags):
 		if (utcp_ca->flags & ~TCP_CONG_MASK)
@@ -274,7 +274,7 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
 static int bpf_tcp_ca_check_member(const struct btf_type *t,
 				   const struct btf_member *member)
 {
-	if (is_unsupported(btf_member_bit_offset(t, member) / 8))
+	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
 		return -ENOTSUPP;
 	return 0;
 }
-- 
2.30.2

