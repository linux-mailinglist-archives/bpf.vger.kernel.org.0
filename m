Return-Path: <bpf+bounces-4523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D074C085
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514361C2090D
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDA1842;
	Sun,  9 Jul 2023 02:59:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F317C6
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:59:28 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FEE45
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 19:59:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55ae51a45deso1630296a12.3
        for <bpf@vger.kernel.org>; Sat, 08 Jul 2023 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871566; x=1691463566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb4Q5082Tgrw2hcUXrT55P3pFjx3xVG0YEjEsl93YPA=;
        b=bSDaiZzfWw5/Wu/Y9y83KnLJglne1CyblWKlXkwTyuDiov58zbN/qhRnYsScptaF/C
         b9/3mXjZ0z437jl4lDMm491+PWMUOH3oQ6GLWf92lKuryZkcXrL9bniROkafnnHh4bCv
         xGLQx7S21KAfYWd/3z3pXh0QWa8H4lOiGbWJoRqvE9XjXswg8qLMXEp60LPk5Tm14by3
         Lk2FTaKeodVBB0deufbbopUbaZr27NO0kalYJ1zhuHXt5M1cI+Clu5cv/ffCfMRbOdgu
         tYVAcwVGW5wJZ7LS5M5oT8Jcjda37rLeWhfmglnYFKWSAsxOWzUoO8bAhURIlZBTyf0F
         JIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871566; x=1691463566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb4Q5082Tgrw2hcUXrT55P3pFjx3xVG0YEjEsl93YPA=;
        b=fPxPfuqK5EZ5//pM2CINUuelf+beLSGWIpKphXY7TMKb1kjn1TxUUaLwL4gLafcw4s
         8wlZRgDOzuhbjhKJfg96TPuj7Imc8lyMOYMFOaag6QcC8QzKq3HvAn+3G21fBCdszmvF
         tRxDkm0Hvd8r4A/E4daKb5YaViUM0PSeVdokGDsRoQSBvo1j09kT7FAgZRMBMOSZqnfb
         ++qu4bCxNJ8UZdNlq4AWiel1Wr5iDoWhFlVXVF4AcFYcbvj4GEGU91ueM6OqFd/NN6cW
         bF7KWNZ7djykXSkGVwi4/VauD6wBDie44p+hztVlYjsvrIJOcsy7/hc4yko5LXUATSGV
         wvpQ==
X-Gm-Message-State: ABy/qLbUIbvm0/68T82KJ7tsF/dmP47baob65jc6IzrbcxuCzoK7vj2x
	mub/rCc0btvwn7Mr782DisE=
X-Google-Smtp-Source: APBJJlEEBp748nO2V+WBCHqEQUBReP6mcNzfSkmnQZcB4QD6NWoI9TnkS+itbiEOxnmY9oUhyOkfRg==
X-Received: by 2002:a17:90a:f407:b0:265:7719:b849 with SMTP id ch7-20020a17090af40700b002657719b849mr4659538pjb.41.1688871566121;
        Sat, 08 Jul 2023 19:59:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0024e4f169931sm3670659pjj.2.2023.07.08.19.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:59:25 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
Date: Sun,  9 Jul 2023 02:59:10 +0000
Message-Id: <20230709025912.3837-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025912.3837-1-laoar.shao@gmail.com>
References: <20230709025912.3837-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we are verifying a field in a union, we may unexpectedly verify
another field which has the same offset in this union. So in such case,
we should annotate that field as PTR_UNTRUSTED. However, in some cases
we are sure some fields in a union is safe and then we can add them into
BTF_TYPE_SAFE_TRUSTED_UNION allow list.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/btf.c      | 20 +++++++++-----------
 kernel/bpf/verifier.c | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3dd47451f097..fae6fc24a845 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	const char *tname, *mname, *tag_value;
 	u32 vlen, elem_id, mid;
 
-	*flag = 0;
 again:
 	if (btf_type_is_modifier(t))
 		t = btf_type_skip_modifiers(btf, t->type, NULL);
@@ -6144,6 +6143,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	}
 
 	vlen = btf_type_vlen(t);
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNION && vlen != 1 && !(*flag & PTR_UNTRUSTED))
+		/*
+		 * walking unions yields untrusted pointers
+		 * with exception of __bpf_md_ptr and other
+		 * unions with a single member
+		 */
+		*flag |= PTR_UNTRUSTED;
+
 	if (off + size > t->size) {
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
@@ -6304,15 +6311,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * of this field or inside of this struct
 		 */
 		if (btf_type_is_struct(mtype)) {
-			if (BTF_INFO_KIND(mtype->info) == BTF_KIND_UNION &&
-			    btf_type_vlen(mtype) != 1)
-				/*
-				 * walking unions yields untrusted pointers
-				 * with exception of __bpf_md_ptr and other
-				 * unions with a single member
-				 */
-				*flag |= PTR_UNTRUSTED;
-
 			/* our field must be inside that union or struct */
 			t = mtype;
 
@@ -6478,7 +6476,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  bool strict)
 {
 	const struct btf_type *type;
-	enum bpf_type_flag flag;
+	enum bpf_type_flag flag = 0;
 	int err;
 
 	/* Are we already done? */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..1fb0a64f5bce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5847,6 +5847,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val)
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
+#define BTF_TYPE_SAFE_TRUSTED_UNION(__type)  __PASTE(__type, __safe_trusted_union)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -5914,6 +5915,11 @@ BTF_TYPE_SAFE_TRUSTED(struct socket) {
 	struct sock *sk;
 };
 
+/* union trusted: these fields are trusted even in a uion */
+BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff) {
+	struct sock *sk;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5950,6 +5956,17 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
 
+
+static bool type_is_trusted_union(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *reg,
+			    const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_trusted_union");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -6087,6 +6104,10 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
+	/* Clear the PTR_UNTRUSTED for the fields which are in the allow list */
+	if (type_is_trusted_union(env, reg, field_name, btf_id))
+		flag &= ~PTR_UNTRUSTED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
-- 
2.30.1 (Apple Git-130)


