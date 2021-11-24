Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7545B41A
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhKXGF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhKXGF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E4C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r5so1177780pgi.6
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3Ulcj0uimrO7JRI7qOTOlQr5FsHdUG1dBlMocUWbmc=;
        b=SH3ym9gXNCFNNo9eOU1htaydTT2qH5hbl1XNbq5JjfsY1qbPSiXVcOaSIze4CI6s7E
         HBWl64voOIWa1jVnC3mHMG8OqPfBKsm9GJQYztBqaRdgxX33ACAoa0Aq1SCPrQRFKxrG
         eNmn6KGI9kDFN8gweMawJXyc2i4mx8ix9wx5QR4ftsOjAyAohvw/eIIRAny1H3vzI7yK
         UuhNegtIHDABm9M+5+ZGd/xWaJsFqi89Soy0YFPr0w43mepUWbi0EaW/jcD1SSL2UA8U
         1/YE2uLOnn/UtJcEW5vWClDLmEwo9kEaQuS1hgtnjNfyAEhieh8oqKllHPcuqYbBvS2r
         XQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3Ulcj0uimrO7JRI7qOTOlQr5FsHdUG1dBlMocUWbmc=;
        b=nevYyyAK7NYMqtCcLhfeMjItcik0hU65I5j6hinh5B1O8zxLoxGeSVZERQ+qWXmblr
         BN2VgEwp/TJ6AGc289vPV9NxG/HdAFA8kXtPrk/KiUjm/fgQXv6Z0vCSlL/WoQgWctXF
         rwBwD7o3unMrOycjCbE97qvecanIZTwqcIJk3cVR9vz3pvRdUdR8+4IghR6C5nNY4QKn
         GhSRicrtphO72xChUFiHslqjQTuRyApsLpjRxk4xgODXN+A9KmicnFmIYYvQgzI1QfXS
         UtCF22Xk7g+XkKDBi71I3wZr0wBLgzi2ZyiLsrYTzCVQOyweL8PSejIpBvQs5kdCr0ui
         h0nw==
X-Gm-Message-State: AOAM533AtCiSVeDUJi2n4UPxXuT75UsmdG6SiurNQMTqXmI1oQWEvYQr
        iqpco+ll23poocS9h81eTSc=
X-Google-Smtp-Source: ABdhPJztXC+hNyteX0d16A1A/SRFz6XDSf3hFI6aMKnzzIfD1uI73v0a01wu3Z/YuxxrzdC3LiMB2w==
X-Received: by 2002:a63:8b4a:: with SMTP id j71mr8226010pge.447.1637733738074;
        Tue, 23 Nov 2021 22:02:18 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id n7sm4335937pgf.86.2021.11.23.22.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:17 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 02/16] bpf: Rename btf_member accessors.
Date:   Tue, 23 Nov 2021 22:01:55 -0800
Message-Id: <20211124060209.493-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
index 6b9d23be1e99..f4119a99da7b 100644
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

