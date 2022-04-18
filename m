Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572E8505FE5
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiDRWuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiDRWuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:50:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D52C12A
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c12so13510632plr.6
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vA+LCraShVqkqdDzqLLHKbJ+4bpGJT1ey+8zHk4MZ0g=;
        b=XWNOggQ8STmJu2zVZGJhAh0SjFDPDvzWJrErlpChdV0g8t4dTB/JNZkagr0wG6ApMn
         B3NPYV8d/zPGY13zT19gKFCACd/zUFowgXiULOS8mlhzQWM+NAiI5KBzVBUjOA4rfSV6
         hqgQaJ+gptcHVqbQv9qb32UGVNpMbM03CBZ6qqNHd4OHB4Q+/VnpQJShSDAgBbbuk8hA
         O8gLRJrJ5+d/Lagn6uTMR4PauYHwWtN6/X4GIUw5F5+oTaiIYlJ0u6ZrP0yNPNiqEpGr
         E5rCtc2OoN1USC8AZGaqaW2EkamJMhVjwpxowipm6m/Qo3E1Hs1mHc7uIgqScHrwJjf7
         kD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vA+LCraShVqkqdDzqLLHKbJ+4bpGJT1ey+8zHk4MZ0g=;
        b=o7iY6+FHKHbtqEYz0IvzZAnJlUZhgrBWlfCuPFoLgGPh7kz/1SGibniFKiKTveQf82
         suCPC1aJf+ibI7N7j7iXl4tczLUR47ynUBphjPMKCSydNoEDT9xuXYJJ6hqP6NcF9TFq
         Rzbq2FvceUDmC8+MddMdYDj98gJtR+SyU34RFGFVJ+1NyK7e9SLnnW+FSTuAY18BbcgA
         fVvBLchCg+HV7URMNpzQg/qwufUmOl5TrkyGtTHvJCEESR+OBEBpim1qQgx49lQh7/zn
         Ub7mzUhNWORi7hupjlGEOWDC3IfkczPJDZglXNfhAyy9ykqYezPyfJ5zZyahD4YpNO08
         fdJw==
X-Gm-Message-State: AOAM532FevOhvXY7k8TTcFw6D8WWYjazZICGiTdD+Vda/RKyXP10/2pX
        xzYgomtAQcBSNI3vh90PngHpXGo/xzeeJw==
X-Google-Smtp-Source: ABdhPJygrzhewGGIDW5r5742Ohci9BwxA12lHJtcMBega1mdXwGobQrbwKEvbtFWkGmI1+UpPAxl/Q==
X-Received: by 2002:a17:902:eb82:b0:158:8feb:86d6 with SMTP id q2-20020a170902eb8200b001588feb86d6mr13065401plg.26.1650322038470;
        Mon, 18 Apr 2022 15:47:18 -0700 (PDT)
Received: from localhost ([112.79.142.143])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm13725470pgn.79.2022.04.18.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:47:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Ensure type tags precede modifiers in BTF
Date:   Tue, 19 Apr 2022 04:17:18 +0530
Message-Id: <20220418224719.1604889-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418224719.1604889-1-memxor@gmail.com>
References: <20220418224719.1604889-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352; h=from:subject; bh=4AmYCEdL8QGFqiCjkF119FStgMjZsezb2p5nSOJUT5g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXenSyBUqj+TEVEvEObFNf1bg65/6YA/wAuSLv0Fz v/WKvbGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl3p0gAKCRBM4MiGSL8RykHsD/ 9ojZXRUxUMZmKv2nop7aEpn8GPiCDdkXSBQYuVRX5J49uv24ghyOmkqX81R+DBL0PX3mDKto5z04nx fnP4vkMhQnjX10p7K2DXGnAzQWi/chGvlSE2LC0H/M3rpir1PWrhCgSwdlcCT5emMr1uASRU2aJq+p 73w3o7Oy7ShxJiBFgm+mcl85fLUuSwXDIak6lmFtuIWTds8J9RT0nRnBRzbMM5QNrLaxe8KUIDZ8i9 8s6CQHc51oiMrU5x78WSAb6elE8Nc0mmkQdPrY+nzr5WIs/yzakeBH5qq+WcfoJOjN+TFlbksiD0hJ jnohu068uzEjEmaeAHv3EO+PTHwos+BeumpYAEl4kKy7hEMU6q6QeV8ze0OplEKV/Nc8Clg8iR+I63 itobnmoanVtTcQIO2IqFx7pQfhBVzZn4dqujgAmPo3d8dNleuw7WnYPlbbZ+fFgZ1bT3PCkZpH6Mcd ngZYFbw6KvcjFQCn9fcol+yd7Dlb5z5nqLR3f9DRhvAWe/9WJCnkNkMB4V46Je+oDoX+2CEHpBcFu6 PBoKaDZ5Ae1HLQlMLA8kMscCPSoElFZ/VN+RxIr40x2nI5v3Ngn/y9LcsJaRIiWj8igWvtOGwmB/Rs Z+hK6nGwYifIwWlf7wnHEOh2R3b+C0DigrR+D7d3+EqJYOIhw02/YBzB7kFQ==
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

It is guaranteed that for modifiers, clang always places type tags
before other modifiers, and then the base type. We would like to rely on
this guarantee inside the kernel to make it simple to parse type tags
from BTF.

However, a user would be allowed to construct a BTF without such
guarantees. Hence, add a pass to check that in modifier chains, type
tags only occur at the head of the chain, and then don't occur later in
the chain.

If we see a type tag, we can have one or more type tags preceding other
modifiers that then never have another type tag. If we see other
modifiers, all modifiers following them should never be a type tag.

Instead of having to walk chains we verified previously, we can remember
the last good modifier type ID which headed a good chain. At that point,
we must have verified all other chains headed by type IDs less than it.
This makes the verification process less costly, and it becomes a simple
O(n) pass.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..c015ccd1c741 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4541,6 +4541,48 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_check_type_tags(struct btf_verifier_env *env,
+			       struct btf *btf, int start_id)
+{
+	int i, n, good_id = start_id - 1;
+	bool in_tags;
+
+	n = btf_nr_types(btf);
+	for (i = start_id; i < n; i++) {
+		const struct btf_type *t;
+		u32 cur_id = i;
+
+		t = btf_type_by_id(btf, i);
+		if (!t)
+			return -EINVAL;
+		if (!btf_type_is_modifier(t))
+			continue;
+
+		cond_resched();
+
+		in_tags = btf_type_is_type_tag(t);
+		while (btf_type_is_modifier(t)) {
+			if (btf_type_is_type_tag(t)) {
+				if (!in_tags) {
+					btf_verifier_log(env, "Type tags don't precede modifiers");
+					return -EINVAL;
+				}
+			} else if (in_tags) {
+				in_tags = false;
+			}
+			if (cur_id <= good_id)
+				break;
+			/* Move to next type */
+			cur_id = t->type;
+			t = btf_type_by_id(btf, t->type);
+			if (!t)
+				return -EINVAL;
+		}
+		good_id = i;
+	}
+	return 0;
+}
+
 static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 			     u32 log_level, char __user *log_ubuf, u32 log_size)
 {
@@ -4608,6 +4650,10 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout;
@@ -4809,6 +4855,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, 1);
+	if (err)
+		goto errout;
+
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
@@ -4894,6 +4944,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
+	if (err)
+		goto errout;
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
-- 
2.35.1

