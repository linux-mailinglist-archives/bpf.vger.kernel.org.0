Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB70502D71
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355233AbiDOQG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiDOQG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A49D0F1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:03:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v12so7440463plv.4
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Em99X2sR3WuoFWPVlIxX0aYlADFUUQy9z9ktGO8PaxU=;
        b=XAqRTpbmzhPS/PaoNbAvUa4APK27MQxvO6mlzA6DFIWwIKWfnaY1vNka2q35l7VCoU
         cqMLEBBbI6E3qRLfb2ZwIVzl8BldQnrJ5qp+0NfhfZXuSA2iyE02X5j+bFU19RuB28EZ
         VSiqZ2U8MjBFE5pByf8RipvAHqSKT4ven3xO43f3X3YXjQavQMvVoaSC5HlmBkCU+uHu
         c0To9quGXefDIJqqP5UgophBkzdf12tSljJUiUDghxV30Pn/rt2j1VoSzffnBD1t+Tve
         nCsvnQGAkMXMcqA7G6DqjlAKYvVKArKKI093NixG3cQlkBXL3wn0k9gobHLi5910pu4E
         BoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Em99X2sR3WuoFWPVlIxX0aYlADFUUQy9z9ktGO8PaxU=;
        b=paIiVlw+3oEFDI/wwhVZL7eZxzDcwK1ZetBdSe1ax0cqBdc+XOv9TUxc5atTnOJR/M
         X3sB9ampQKRq9hXDjDeOn+QJypEUpSe17381DP1xwy1YH8Kgbz28j1vT+7YrQ3Po71+N
         axP16f8Cz+3mP3YlO1hiyWNNXLUeTtyW6Y4fvuJb1IjEkq9WKfOc2dfD2hJe4F3Y3fGi
         06h4I18D1+YuD75Zlx1EqO5Pu+HAYFPD9GKhM0N8dMfnPFqKGgz7D+6CIfa3lP0zgLoa
         YuUOzxMIxY50DNT68k7DA+swddmeLr13TfkFu58wWGtcyxDkWv0uf3w3ezDpDDx+Qbmn
         2duQ==
X-Gm-Message-State: AOAM532XVXSuOYgywOljnYzIjDCI2n7wavzc8ge4sDjhvHvThM1Yny83
        K+trbyPF6zlKn4J+Z9WQyBb1IA6VkE4=
X-Google-Smtp-Source: ABdhPJyuLoGOoy16I8IAlXv/L4JPNsCfy0q7jw0ejHdRqRcvATIJIKUjCy647AcWjVvZopyRbwVGXA==
X-Received: by 2002:a17:90a:a78d:b0:1bc:d11c:ad40 with SMTP id f13-20020a17090aa78d00b001bcd11cad40mr4845467pjq.246.1650038637445;
        Fri, 15 Apr 2022 09:03:57 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm3306169pfw.144.2022.04.15.09.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:03:57 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 01/13] bpf: Make btf_find_field more generic
Date:   Fri, 15 Apr 2022 21:33:42 +0530
Message-Id: <20220415160354.1050687-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5935; h=from:subject; bh=oaO7R3Z2HYd3cf6gvdBLv7huguH+Mq52fQaN1HUAjUA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdBKHlfTFOkyjDoNDAcWh5W1AomV+BiWzk20jty iZCzO8uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQQAKCRBM4MiGSL8RyrS6D/ 91U7i5TxedWEpGUNnvUmatT70MeeBUrV8/rV8kl/7vu4RTn3zyBfzT6x6SGa5phwfSkDx7908tECIU V8Qg87pNBSlzGGQvBmi1cnIpKM8Wygv5nVbgL+4Yuyqui+8DsXIXZQR5UhlkrHVeoOST2x2CjYyFju wJJNqKBG9MgzpamQwUDp449i+nACAG7R5NHGoFLDkVB6yTXdHzJZ9dsfGF/AbiiMjA7DFGRIpFossR Zoy9JRJa8TYNRdXy8T68jX4qdjMf+mSRJSqtszQ/7xPgHNlLcIfFtf2Q60aTNYDaIwJLQMvOUytg0X PKSJbJevU5T6Yxqf/7Y4460fPqjiO5t7njoyPXpZmvoxBTohZLmRxBp7hSsUIoNljk0641z1ZihBPz 6x5bf6xlw0weEAM5+wc3ocPjE+Zn9GzrtBuQkwfcRhziDt+byTb5Ih1s4Xm+9+ygx+b9DWY2ObFGo1 73cSvCMrf4mFvZXga+K7FmZlCXuIEPMmTXVTh2GAyyamLU3kmSkOBwefzLniJYzmKgtEAhsgFzO6bL f3UZzudYzkG1481vd3JwVrx+/pOs1KBG5IEaakRmqhVG0H71UWWjcRZECg4zunM3WKO6kRWccF40zW 9EOTI/vGyE1qRAd/dWmmDnpznW/1e5itWHFpCejim4ACFEqGX8llMwZswRKA==
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
next loop iteration happens. Size of the field and type is meant to be
checked inside the function.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 120 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..e2efc81a5ec3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3163,24 +3163,44 @@ static void btf_struct_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
+enum btf_field_type {
+	BTF_FIELD_SPIN_LOCK,
+	BTF_FIELD_TIMER,
+};
+
+struct btf_field_info {
+	u32 off;
+};
+
+static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
+			   u32 off, int sz, struct btf_field_info *info)
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
+				 const char *name, int sz, int align,
+				 enum btf_field_type field_type,
+				 struct btf_field_info *info)
 {
 	const struct btf_member *member;
-	u32 i, off = -ENOENT;
+	u32 i, off;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
-		if (!__btf_type_is_struct(member_type))
-			continue;
-		if (member_type->size != sz)
-			continue;
+
 		if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
 			continue;
-		if (off != -ENOENT)
-			/* only one such field is allowed */
-			return -E2BIG;
+
 		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
@@ -3188,46 +3208,76 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 		off /= 8;
 		if (off % align)
 			return -EINVAL;
+
+		switch (field_type) {
+		case BTF_FIELD_SPIN_LOCK:
+		case BTF_FIELD_TIMER:
+			return btf_find_struct(btf, member_type, off, sz, info);
+		default:
+			return -EFAULT;
+		}
 	}
-	return off;
+	return 0;
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
-				const char *name, int sz, int align)
+				const char *name, int sz, int align,
+				enum btf_field_type field_type,
+				struct btf_field_info *info)
 {
 	const struct btf_var_secinfo *vsi;
-	u32 i, off = -ENOENT;
+	u32 i, off;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
 
-		if (!__btf_type_is_struct(var_type))
-			continue;
-		if (var_type->size != sz)
+		off = vsi->offset;
+
+		if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
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
+			return btf_find_struct(btf, var_type, off, sz, info);
+		default:
+			return -EFAULT;
+		}
 	}
-	return off;
+	return 0;
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  const char *name, int sz, int align)
+			  enum btf_field_type field_type,
+			  struct btf_field_info *info)
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
 
@@ -3237,16 +3287,24 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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

