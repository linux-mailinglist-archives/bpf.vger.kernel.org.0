Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81C4DC552
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiCQMBe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiCQMBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73ED1728BB
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id bc27so2489390pgb.4
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xnofddMkNTcDFZInC+2fEJ7GbWtFI3i+E0bEfzZz5w=;
        b=dy0Uc5rJB3hxOJXRXmJvJukDo2O8nwQWlGFtWc6U8u5KYdJbmBNGBZlVWnzP1+N/Aw
         P08lf1TF+7m/HPJQa0h+GTnaX17vaoBFMHvTCdtmXk4kKLeG7SoIFOfpRxEU6XuO1UIP
         p2vmHNM6LfthNDksd2CQwyvYbCrPVujvBWVtjdvcKrxZlPX/jDP/gPUZx4vU06iQpMDL
         VYbGjNcbPrznq6ZxaVi+Ra5YjRTHhfOJMKP5ojoLq9GXq5101yRTcozgrRqvRL5yoczX
         J9BC8eA13fDXeL0kk5T7AidHhWRzfWBwr+BDn64AgkW+1rT6L6VAeKlMNaz4gldWtdrB
         6Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xnofddMkNTcDFZInC+2fEJ7GbWtFI3i+E0bEfzZz5w=;
        b=I4+dO5HyEo/5jnATGjvnFTqY1/jXE0bF3seiIBt7a3etww9RN2mMiXqnh+sdPBA87O
         HrTWBkYCI+KTvEbLfgSvNKBnVQytBxcRBAhRdSiWqIoopWwZzj05/tiPdbGhAyXUG3vY
         UTvb3UxMApP2+J0U2zkLyv5UA0EgCI02qX332RnpllC90PwdTwDYPM6gmkeQHrnEeNjL
         0mIFPwrwOSpAsGTnGClcLxS/kMNXpmDJ7WKZISuZG/W/K56OmCecJpSLsRJwcSCtKtCH
         pn7pV+38ZbilnncdwkchkbL7f3AMqtLDuHvYfJdM+v9L6/B0YiCR7Nrfkf0l2B8XKWaO
         m0Jg==
X-Gm-Message-State: AOAM533f0IWGNerAQ+wl0Hyg/kyblPKFi9ecObua35RvxuSsrWhuw02Q
        zKfk4usRVgnN5xI9N70o9qbPO2GUrEI=
X-Google-Smtp-Source: ABdhPJxjZS/AzKE6amXlCNFzyRr4weAui1P0s3niQnYbKZEwK/ao9XJipTOGJlAckY84l3w+ZFXk+A==
X-Received: by 2002:a05:6a00:848:b0:4f7:ba8b:4429 with SMTP id q8-20020a056a00084800b004f7ba8b4429mr4535509pfk.4.1647518408952;
        Thu, 17 Mar 2022 05:00:08 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm1807466pjj.20.2022.03.17.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 02/15] bpf: Make btf_find_field more generic
Date:   Thu, 17 Mar 2022 17:29:44 +0530
Message-Id: <20220317115957.3193097-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6325; h=from:subject; bh=XSc+SV+o0eQj7pghct5rJv85GETTRhmgvbDxI5yFDTs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjRHQvtlku1j33GwW5V9KFJFYYbAhPTBmuzFnq pTavhQ6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RyoeyD/ 9BpKvmpMQC4Vo9NgakZsLucmqrDy7qRMuojBy9aYktl0NclNkMx34aVlLnMfIObT0djFLYpCDboTL6 lVPrtflJvDmAGvsfcRqN64asHhZMpOXZPzuFFVjWQkezy36IcVbmjJSi6SJUP3/abZAdZ9PChWqRNM zrBlyEKCz4koFQiONuFojs4MkgnPxNAuFDV8fgYwnMlEbbJ08CxOdFijoEUkvYCEPW9SehBtYMq9MO 8pNxA5xsWDIJwGnw6S4VvwjVkQq+7ODoJevGokV47jynXlSz0F86kegWpOY6WjFRY/PQY+V0/AJVzQ tdkxmREv2RnaawHb+cuA60aobqbyD7DyhQw3dmd6BgjBNPQ7y79wQdJI+JZBm9/PRmWszYJQxUxncq e0WRLk9H5RubTvxkRNICr8PefKLcBxr6aVI4fj5v+eUvK/9Vv1/xuBDpIYkatm311arpo9KBNQZAbm XAZYOWvYl9vi7Q5H+J1U46V7l6yNZMpPcI2k6BE76SJdaaif/wLs6dVuji4zfa7B+wOMeZFwuUb0P/ MkYUvC1IacpLAsAsQ52GoHSL1MTM++N8Y0TTU3Bngxz1gzKp8+mBsVXSGlsbJ01TL7T+P9zaNnIbq0 e+pFLuw1JGXDni3MJ9xTlnLaToFX4PMTYtZCKA3Ud/5SVYL67wrLunBIacHA==
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
next loop iteration happens. This is important, because we'll be
potentially reallocating memory inside this function in next commit, so
being able to do that when everything else is in order is going to be
more convenient.

The name parameter is now optional, and only checked if it is not NULL.

The size must be checked in the function, because in case of PTR it will
instead point to the underlying BTF ID it is pointing to (or modifiers),
so the check becomes wrong to do outside of function, and the base type
has to be obtained by removing modifiers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 120 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17b9adcd88d3..5b2824332880 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3161,71 +3161,109 @@ static void btf_struct_log(struct btf_verifier_env *env,
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
+			  const char *name, int sz, int align, int field_type,
+			  struct btf_field_info *info)
 {
-
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, name, sz, align);
+		return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, name, sz, align);
+		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
 	return -EINVAL;
 }
 
@@ -3235,16 +3273,30 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
  */
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
 {
-	return btf_find_field(btf, t, "bpf_spin_lock",
-			      sizeof(struct bpf_spin_lock),
-			      __alignof__(struct bpf_spin_lock));
+	struct btf_field_info info = { .off = -ENOENT };
+	int ret;
+
+	ret = btf_find_field(btf, t, "bpf_spin_lock",
+			     sizeof(struct bpf_spin_lock),
+			     __alignof__(struct bpf_spin_lock),
+			     BTF_FIELD_SPIN_LOCK, &info);
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
+	ret = btf_find_field(btf, t, "bpf_timer",
+			     sizeof(struct bpf_timer),
+			     __alignof__(struct bpf_timer),
+			     BTF_FIELD_TIMER, &info);
+	if (ret < 0)
+		return ret;
+	return info.off;
 }
 
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
-- 
2.35.1

