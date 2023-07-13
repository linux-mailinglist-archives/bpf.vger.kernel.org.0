Return-Path: <bpf+bounces-4907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E008E751688
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A79281A8C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11FDECE;
	Thu, 13 Jul 2023 02:56:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061B7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:56:53 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56547B4
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403a85eb723so2630081cf.1
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217011; x=1691809011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdrhte9TgcchUS46wyHJ1J2Ig8Us27x5H/Mr6RX25kk=;
        b=YZXTKrvRJ4o3fv6ShC/H2wAjoKbm8DqxzCc7RHyUpHNKsDSzX+wH3WzRq0CKh8BIvt
         J3rym1pl6+OZsgI94cU3rlb8K6Q32oWChtqmWMcpvtQowgjPfo0iPm8vucCNruQOw6XL
         za9UR55lq+Gt28mHxsy08W9kT8T4nR9J0onqKxq5sXlnp8WT9BFrLHZ9+FWdohd0H8yv
         zfF1wnk1Ovg7Rf6o0oJl+I0DQYe6oOjANKA7iKjS/+1AosEypGNIfrMo8MOYyNaf10ui
         oCBoEyV/9oRnbVMpeZuRfs/IbFuWpLqLNhskQgiZCjcjoaT8UYKSskm0/wxtR3LLmHyI
         XM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217011; x=1691809011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdrhte9TgcchUS46wyHJ1J2Ig8Us27x5H/Mr6RX25kk=;
        b=fKhWavQA3eqy5RyyNMYZZ56lg0yOqvJXKuqwscENIIanoIYRANu63EBXM7i9kUsmL2
         Rorh10vldfc2AtD7GA80OzyZubmCsMftGyPZbbmeYsqefj1hbbGWS/2xJ+OZhwM6MvHR
         ExK8cqPFv98iq8rAnj1i/wKbzu/nYKfXESGCe6BG+kPh4KHSoDjwBx8Bm3MUErNgQWox
         4lUOpki+I5Xyn04BiO+1xwsn36geywREL9sdvVm9ARWivaI2tdpetUg9ALHKUmmzEgbY
         tnI/KM33dUTi00B9tGese6dij7jcdUoCESsVxjcYkBiL22cA1B5/DOK7oD9t+/plbPWz
         7a6g==
X-Gm-Message-State: ABy/qLaglCNEePr4hEXKlIyQwZGotaXDUABSM539Gw69beZt56TNurKL
	blJ1JH/rIp0HmFh6r2ADaEk=
X-Google-Smtp-Source: APBJJlER370i1jYnooNBZoJUq7JlCBZvrs4NeYrjrCxB/iwIc6IzVsBzf9hAZNSJ/Q6rNllXpAEzrg==
X-Received: by 2002:a05:622a:3cb:b0:403:996c:9fa7 with SMTP id k11-20020a05622a03cb00b00403996c9fa7mr519200qtx.60.1689217011340;
        Wed, 12 Jul 2023 19:56:51 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:a97:5400:4ff:fe81:66ad])
        by smtp.gmail.com with ESMTPSA id lr3-20020a17090b4b8300b00260a5ecd273sm4416681pjb.1.2023.07.12.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:56:50 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] bpf: Fix an error around PTR_UNTRUSTED
Date: Thu, 13 Jul 2023 02:56:39 +0000
Message-Id: <20230713025642.27477-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230713025642.27477-1-laoar.shao@gmail.com>
References: <20230713025642.27477-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Per discussion with Alexei, the PTR_UNTRUSTED flag should not been
cleared when we start to walk a new struct, because the struct in
question may be a struct nested in a union. We should also check and set
this flag before we walk its each member, in case itself is a union.
We will clear this flag if the field is BTF_TYPE_SAFE_RCU_OR_NULL.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/btf.c      | 20 +++++++++-----------
 kernel/bpf/verifier.c |  5 +++++
 2 files changed, 14 insertions(+), 11 deletions(-)

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
index 81a93eeac7a0..584eb34dce8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6067,6 +6067,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   type_is_rcu_or_null(env, reg, field_name, btf_id)) {
 				/* __rcu tagged pointers can be NULL */
 				flag |= MEM_RCU | PTR_MAYBE_NULL;
+
+				/* We always trust them */
+				if (type_is_rcu_or_null(env, reg, field_name, btf_id) &&
+				    flag & PTR_UNTRUSTED)
+					flag &= ~PTR_UNTRUSTED;
 			} else if (flag & (MEM_PERCPU | MEM_USER)) {
 				/* keep as-is */
 			} else {
-- 
2.39.3


