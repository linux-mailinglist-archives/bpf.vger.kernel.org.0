Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342884E1C62
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiCTP4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiCTP4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:56:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C854194
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s8so13525901pfk.12
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwoPr6n9CiEpsCjhfdSpjJzEgcYF2gF9N1XiTmOWdWg=;
        b=Z6TgBcldp1PS5CkUEOkJI/uRjoDI4JIZpWUU6ZUH778cNIJyJ7aW2Kh5ZF71qf5K9o
         Yi76M8VnPr5zFwJxZWxjtbep+UZlgmuTjCV9DaX88FSH3vOBjYboc+og/lau60OEyGvo
         aDohrB8Hr3h4HhD9487KjSNAj5ATCZEGmktBzB+FMj52NxY+1Nz7WUKhzcwoc4q60xoT
         s4fWaUqN9PnjwQpP2Npnfb7XmwhOgFhApna9UiPIzJVRoI7ajWI5PdDeYt/8BlAoz5HU
         lEqcvapNhnyi/1iiBaxV0ZUj88+UnK9y9QC8bX0cNluAS+1ptazF0covrM8VzMrDosKz
         4NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwoPr6n9CiEpsCjhfdSpjJzEgcYF2gF9N1XiTmOWdWg=;
        b=HfDyMxmmKBB/SIa4C8OGRdt+HbL4Xv+QaLrO8aLLW39EIhuPRmVLQ9tDROJAcxc0WW
         jpYY91a+iOiOTNsareGKytEfccSEdaiCwIGrKZGy/SMw5ClvwoihoXi4bRsnltl+mOZu
         meVGidFYzK8UbPYw8j7pSvOXBdok8nE848/L4s4UxznWaJQR9wa00Ibzl5ANlwDqWTMn
         yB5yUm5aUSuNiQEp9Y5uqgnUBQvz0XfsfFLmYyG1uqHKrG0kfczGDJIl11QCNoPM22mk
         MrdkZYjSKB4n4WYXxaDGpGA0oxDsIga4CDTJZfdj8zbB/Ts1Lrnbfh+CghV6pzc6Zqoi
         IsWg==
X-Gm-Message-State: AOAM532E1hj4pSdpfJORqAEUDtk1+hLXUzddRY5iIl/l7I40Rzd2jMkj
        uQyivM8CaCm9lG0HKW3RL/Yzb/KWKKQ=
X-Google-Smtp-Source: ABdhPJwO7BokpbA0aITbTTybvrF8wg1MBO5z34cm6RtQMt7i1e8IeqhCFDsWKa0djIcaezECoBfbAA==
X-Received: by 2002:a05:6a02:282:b0:381:6565:e080 with SMTP id bk2-20020a056a02028200b003816565e080mr15182208pgb.272.1647791717776;
        Sun, 20 Mar 2022 08:55:17 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm16444880pfv.199.2022.03.20.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 01/13] bpf: Make btf_find_field more generic
Date:   Sun, 20 Mar 2022 21:24:58 +0530
Message-Id: <20220320155510.671497-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6265; h=from:subject; bh=5CZILHsi0H8bmXTq6JsyQsOEXM6zpEO+nsoKlQ4MfiY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00xKPRcbXeBKVx9ex+7ev9ty9+fuOscRkVxjpXl 0bau3X+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMQAKCRBM4MiGSL8RykcvD/ 0bxqmrZtE/einKi4GKUsfA4O13qPIr2R9dZO6BdG5JemXW9rhfhkEvltEG1u2ZFHtJzMT92qVBrCYj nyoyQny2ZH3lk+OyAHWADmpFBdTxOfESJ01iHa4AoCFjp/svhjykTGaOqSaBPmZV3krpz+JdzjXs4l RznhSw+jB0CYazyIfzYg9ITsuKnS1HeYXnkjdbz019NcJM3mnNPcLr7yTkcgyyolNf4WQfDtm1+rUI Do+lntJW/wgZC3xiTGpgqNEsiXmoE9e6CvVFC5wYo1lF1N7vaPUZZPaku4N8N5+NR2vZqZiOtOirbO waJ5ohbCnLAhV33r9490k3yoS4RHWmvgXVvpD8GpXWebRa4OwY3TKloEOGq5Psv07a8kUbqDenTpSK XLNEPXpN5OpKsbPxUJgRMtlZRxVjn6CG6ZY+uOsWDIuzFcaI6MyhP7j9pUxcJ65ia1G0Q4kxV523ST dFZgeSgWnZlYqRBD2j2IFhIq19jNPM7c6yaOnGBwlySQ4pnYKlDVf1hvM/6JBQ5b3ImVrWZEFzhrGI f+UG3vddj8VLvwpawhKoUDbYpcLtoOqnepDV1Z8vkNDZ2XaIwGI3GEaxa1kcX/bVBst4Yg7JO49r2v FpflkbCzihKzvQuvHhmTzaW8tf8r2ESXzcVrhFdYWd3U7+kpqxPXoDYD+P9Q==
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

Next commit's field type will not be struct, but pointer, and it will
not be limited to one offset, but multiple ones. Make existing
btf_find_struct_field and btf_find_datasec_var functions amenable to use
for finding BTF ID pointers in map value, by taking a moving spin_lock
and timer specific checks into their own function.

The alignment, and name are checked before the function is called, so it
is the last point where we can skip field or return an error before the
next loop iteration happens. The name parameter is now optional, and
only checked if it is not NULL.

The size must be checked in the function, because in case of PTR it will
instead point to the underlying BTF ID it is pointing to (or modifiers),
so the check becomes wrong to do outside of function, and the base type
has to be obtained by removing modifiers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 129 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 96 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6d9e711cb5d4..9e17af936a7a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3161,71 +3161,126 @@ static void btf_struct_log(struct btf_verifier_env *env,
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
 
@@ -3235,16 +3290,24 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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

