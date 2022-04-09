Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467DC4FA674
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiDIJe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiDIJe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:34:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE68102C
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:32:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id bo5so10461151pfb.4
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAQfnUVNGQczmA3KgCLiX+nTiapZaTcZbJq7osVfQQY=;
        b=VmspxJ9mT43qU8gzEjcctzm8wSdYVF+avJkZB9eMshxupj86wC4dTStL9zl6fKz5w6
         Bq9EaD7lh8tee0xZ5Auf6dDFdudYZlAbS/Ce1RPBa4Fl3DL6GBn0rnnQriISYCIA3ZXh
         waVVUPT8kfbrAD/rE4mfryvQVErLeXsP4Ikv8bw4Y2rCUYuunYdZs8t0GKAzKv8ACuPQ
         5Z0X7PNlVn14ZH9SnHPkca2ec4ijd4P5uAPFeuobTrZORpDdzIvdKiMD93coss2RXIHv
         dF/dfs9Nkmt80gJcBm2e8kehb58AWP9kRqX4yEz+I90S2IlT6Owm7wbfFQWZ/huRZMcv
         8VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAQfnUVNGQczmA3KgCLiX+nTiapZaTcZbJq7osVfQQY=;
        b=YGJS0U9kbr7pD7/vOtEisvVu3+QeQyGAxwi00eoV8v3H9Qg5iwBya0mK9vrvhDuzx7
         F1r7XddPzIDb/YWEB9wN8oX8m+m0FdHCRnzIEzDVI4JxJBXvVdHuc0zSm1x2L2sP9Hv1
         XBZfcSL8NDzLc99I3+uw2Kna4EFEzHlrSPjBPJPfXWgFjCXBmjzgLuYzz+BVmpkyoWt+
         8lAy5OyblIOWi6qC6Z6oZa4w3Ub0XrFGCXzw6wTgurZOmrsWAE4ZnZRlqI3H4RZZ4/cH
         34Kq03I3vwH6hZd6F3Vde3dm2UT/cFnMG5D8/fFgLzyNB4z8u9N0F2Da/mOW8uUGkhQZ
         z1iw==
X-Gm-Message-State: AOAM533owqHTdLHZidXRLpb7RZstqbeI/qzSSTfeudyxbD0fmxFs1CSv
        GTgj4Z/F3BNd4JDoAZaNp5jTvqtLMaU=
X-Google-Smtp-Source: ABdhPJzKCNmHk02ux/VBlRHNqe7PKYW2NlXDnJzzMWwHcNDYlBNC00koROg2tasolBIrg8HrC3VWWQ==
X-Received: by 2002:a65:4b84:0:b0:382:65ea:bb10 with SMTP id t4-20020a654b84000000b0038265eabb10mr18754460pgq.50.1649496770404;
        Sat, 09 Apr 2022 02:32:50 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm32102830pfh.58.2022.04.09.02.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:32:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 01/13] bpf: Make btf_find_field more generic
Date:   Sat,  9 Apr 2022 15:02:51 +0530
Message-Id: <20220409093303.499196-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6142; h=from:subject; bh=EO5TbJ2Fr9Tp/9EFlam3CaNtWaJDdJjVjve4lXc8fVs=; b=owEBbAKT/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVFzFDVfIa5295jxOw8bLrD4d3uV3yVgGxdmAIBW KnkDI5iJAjIEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRcwAKCRBM4MiGSL8RyhVhD/ jNhynTn3zNd+dM04bX/GG3AMhyxfl1nu4Wia4IA4sjUw34kPUk/zTWtCEXtMm0MKojsoLPuU9dU9em goBmDKJmTk5UG/02hOmpIGgNkAbrmXiLcZkcF9G+zmaQVWYTOvqaPGJJe1XkltPEMP5PUoBdTLMJHm 3p1MOq83l2PAXNhGveW05fpejVw9tWY5k6xcl18YtHT5JgNc7uSItE+0/Rzw44HSa+4evCtvKnYyCb ivd57thF0vne/3pzWdBTe9fBYM+cs02dq5lsPrSSw4AqJ/K6cUEBy1bzSOUaElz/6FX0WMZ2qYecsR SXbi4qAjJ/yfVcj2kb3SWyTZ4DJ0I3x5BokfEIhmIv5pFd+Po/a8l5IKdd5FitpGlPMafCgv/LXeKL Ua0jU7pxhKwbIqWKnVJS/bpT6Emb49eMmwVvJjTDaA6d3PbzBBZVIUIU6HAu4fmqc7BiumGhP0rIG7 EQ9rlgt1wPDcRPZE12DgTS4g3FjCqi2tGiHvxqLSf9i3k0AvAg1EaV6/U60o/PdF8ringWFDC7EvCU mJwbV2ZpPxHTopuoM5i0Y/zvmHlBUzX+m3aTwqER3gJ4i1rjQdL2pwO1L+EY1C0busJlb0STmGVWkN 2u4tKDO/tknjVgo5GIRJ9bYxQ1CQjw5ZtijJ24tl3atPTyyiiX818o4Z6y
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Next commit introduces field type 'kptr' whose kind will not be struct,
but pointer, and it will not be limited to one offset, but multiple
ones. Make existing btf_find_struct_field and btf_find_datasec_var
functions amenable to use for finding kptrs in map value, by moving
spin_lock and timer specific checks into their own function.

The alignment, and name are checked before the function is called, so it
is the last point where we can skip field or return an error before the
next loop iteration happens. The name parameter is now optional, and
only checked if it is not NULL. Size of the field and type is meant to
be checked inside the function, and base type will need to be obtained
by skipping modifiers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 96 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..db7bf05adfc5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3163,71 +3163,126 @@ static void btf_struct_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
+enum {
+	BTF_FIELD_SPIN_LOCK,
+	BTF_FIELD_TIMER,
+};
+
+struct btf_field_info {
+	u32 off;
+};
+
+static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
+				 u32 off, int sz, struct btf_field_info *info)
+{
+	if (!__btf_type_is_struct(t))
+		return 0;
+	if (t->size != sz)
+		return 0;
+	if (info->off != -ENOENT)
+		/* only one such field is allowed */
+		return -E2BIG;
+	info->off = off;
+	return 0;
+}
+
 static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
-				 const char *name, int sz, int align)
+				 const char *name, int sz, int align, int field_type,
+				 struct btf_field_info *info)
 {
 	const struct btf_member *member;
-	u32 i, off = -ENOENT;
+	u32 i, off;
+	int ret;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
-		if (!__btf_type_is_struct(member_type))
-			continue;
-		if (member_type->size != sz)
-			continue;
-		if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
-			continue;
-		if (off != -ENOENT)
-			/* only one such field is allowed */
-			return -E2BIG;
+
 		off = __btf_member_bit_offset(t, member);
+
+		if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
+			continue;
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
 		off /= 8;
 		if (off % align)
 			return -EINVAL;
+
+		switch (field_type) {
+		case BTF_FIELD_SPIN_LOCK:
+		case BTF_FIELD_TIMER:
+			ret = btf_find_field_struct(btf, member_type, off, sz, info);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -EFAULT;
+		}
 	}
-	return off;
+	return 0;
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
-				const char *name, int sz, int align)
+				const char *name, int sz, int align, int field_type,
+				struct btf_field_info *info)
 {
 	const struct btf_var_secinfo *vsi;
-	u32 i, off = -ENOENT;
+	u32 i, off;
+	int ret;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
 
-		if (!__btf_type_is_struct(var_type))
-			continue;
-		if (var_type->size != sz)
+		off = vsi->offset;
+
+		if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
 			continue;
 		if (vsi->size != sz)
 			continue;
-		if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
-			continue;
-		if (off != -ENOENT)
-			/* only one such field is allowed */
-			return -E2BIG;
-		off = vsi->offset;
 		if (off % align)
 			return -EINVAL;
+
+		switch (field_type) {
+		case BTF_FIELD_SPIN_LOCK:
+		case BTF_FIELD_TIMER:
+			ret = btf_find_field_struct(btf, var_type, off, sz, info);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -EFAULT;
+		}
 	}
-	return off;
+	return 0;
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  const char *name, int sz, int align)
+			  int field_type, struct btf_field_info *info)
 {
+	const char *name;
+	int sz, align;
+
+	switch (field_type) {
+	case BTF_FIELD_SPIN_LOCK:
+		name = "bpf_spin_lock";
+		sz = sizeof(struct bpf_spin_lock);
+		align = __alignof__(struct bpf_spin_lock);
+		break;
+	case BTF_FIELD_TIMER:
+		name = "bpf_timer";
+		sz = sizeof(struct bpf_timer);
+		align = __alignof__(struct bpf_timer);
+		break;
+	default:
+		return -EFAULT;
+	}
 
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, name, sz, align);
+		return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, name, sz, align);
+		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
 	return -EINVAL;
 }
 
@@ -3237,16 +3292,24 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
  */
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
 {
-	return btf_find_field(btf, t, "bpf_spin_lock",
-			      sizeof(struct bpf_spin_lock),
-			      __alignof__(struct bpf_spin_lock));
+	struct btf_field_info info = { .off = -ENOENT };
+	int ret;
+
+	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
+	if (ret < 0)
+		return ret;
+	return info.off;
 }
 
 int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 {
-	return btf_find_field(btf, t, "bpf_timer",
-			      sizeof(struct bpf_timer),
-			      __alignof__(struct bpf_timer));
+	struct btf_field_info info = { .off = -ENOENT };
+	int ret;
+
+	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
+	if (ret < 0)
+		return ret;
+	return info.off;
 }
 
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
-- 
2.35.1

