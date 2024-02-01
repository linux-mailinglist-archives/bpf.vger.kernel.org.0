Return-Path: <bpf+bounces-20893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CD845023
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF41F268D8
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501F3BB43;
	Thu,  1 Feb 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQgxMiNm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006303BB34
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761281; cv=none; b=s2ZVK+XO6L2Bx6dgY2lqvXn90A6TBR686lLUKq3OgMjY1Ljmd5byL0qEkzPWqWOw4mFcrIcHrKVHUhreU9kqLBsg3a/+Oipqpn6NPMkyS7k0yFtnX91J0FzwcG8OX4VTxadR9K+fxq6J5CQESHx5vkw3P5IGoNJM1vVgTILOTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761281; c=relaxed/simple;
	bh=WgtZY2YvuMhHbJ1b2SWiTNkGKSwbKaq2lGPQ6xAut+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtOhxFz5ikSCLfteWryMXx0xYLvxXhhYrUrbPZ0asu9dSKaqtCMYpRrQaNL2gxK8RtCqRwc/11fvyE8xZ7FWvfl8wDlqyj1c7DOIHETck4XFk9zw9+iQUYyHeIO0b/B768u+dLTjxt4OWzoZ2uHE8u8IEGFIKhtT5a1fpjd6uXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQgxMiNm; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a30e445602cso356762666b.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761277; x=1707366077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2tnvsDI26CUilziLHwen7viPO5j2bDTmFZaLGY88Jg=;
        b=aQgxMiNmAuDmHfZkfcnpyY8vEwdIzDwUyJsZv16YwUDkwNurnGhGi9AGJnHao+XStB
         uZMpQ6dlTVEww6X+plzYSylSpFfqTb92EW7lFkblZjakWl44riXVhM3kqXjjU5403Mj3
         bLoTm0BD0IEwz0/hGrw0lPsO+KxXDUbN/xkY7T17hEENCWV8Yz7IHPTaKTmGULWCvGET
         JtPepAgqy4JkaWYOawpQ/nPEQHGojhcs3dnZLcuDbWOPdctPnGRqfKIEmkM9lAUnS17J
         nBvjUiuapMa9GLDFmc/GYOJCQYs2hYkF3sIiSrSqm2GWyJe9yEb4rTmVySLztR/NfX6a
         qfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761277; x=1707366077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2tnvsDI26CUilziLHwen7viPO5j2bDTmFZaLGY88Jg=;
        b=RpmLcjj4T/qiQjTlmOKMtAfS/iTBhIBZpH5N6MrZauzjZPHz3+VktsMhAM1qhoeNLG
         n42Jc3lnzsjar4hWqJWmXwWcnCInn4fldepikKc6d8EFwN+txGMAvCjHl6IF7CwDYhBw
         on39m/Eks6FU1hBU5XEF/lRbg8xjLLFZ/Zh8wLM8ogJ3T9NbZ504pPqN9Zy5KHNyYUvc
         RvZlenJs94zbA5SQqRzoIwERM7JplmIORt7UmnUnkn9Klp/Yt18B/rAHgM36CepLZDEI
         X7LO/z2lRTtRZbYP1oUI+7CNHR9FIPfkFPiLkuU9a2XQuG8HpjVXxErBNZAsQoS56FjC
         TKXw==
X-Gm-Message-State: AOJu0YwivMBOrTyHoMlqPOtm6oRpHRlGRCkz5yMzauh+ZMdIiazEYzIV
	BjUmm7GtvQOu+N5ruC68Vl5UWY67T7W7vA2JsSN0vMVbLB25wKBFgSRCiT9Iz/s=
X-Google-Smtp-Source: AGHT+IEOECYW6RGDIqgPeE3oD09pxICLk/zHpsv2QpRvQmbCnCWQ7h0rurM48ui4FD7kZ8zWV2EpIw==
X-Received: by 2002:a17:907:a642:b0:a33:8fed:b9d5 with SMTP id vu2-20020a170907a64200b00a338fedb9d5mr5497765ejc.3.1706761277216;
        Wed, 31 Jan 2024 20:21:17 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906368a00b00a349d05c837sm6764829ejc.154.2024.01.31.20.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 04/14] bpf: Refactor check_pseudo_btf_id's BTF reference bump
Date: Thu,  1 Feb 2024 04:20:59 +0000
Message-Id: <20240201042109.1150490-5-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053; i=memxor@gmail.com; h=from:subject; bh=WgtZY2YvuMhHbJ1b2SWiTNkGKSwbKaq2lGPQ6xAut+8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwN6qUqhyswMHWLYfdcQeWRDf3ejt/w7tEv3 N01PoKDNdmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDQAKCRBM4MiGSL8R ynMJD/9IlIsxjBKmbPsqZNQAbZC0TX1pqXMo5ZlrS6eOhowrE+YNyMgw31NfdsbzIq8hEWYeHjH K9PowXBMkzKNZp3TCTkqEusxQHkY2ZPPX7eKay+qdwSa1eQWY/k3AV6dGZ4iVbNRQWxQt+m91Id 8HXRglnVegByaokyQmZoe7dH2sVol5zICdfJsDwwPq/hFFBPLLCxa3v+ihIIU+Au8VNaHhAqXd/ WrKn2wBNwl3M7yMb1xuEgNgyoMC9c2G5RqN7BzI8HqeWOAH3wVSWWNZnBoWOdYRG4n5mg7ed21K 1f/0rAW6hMLiFYhWnlqQMMGE2clHztEeqN6vz8a+DQ+UsdTYPe1Qyz6p0bgE4ZiSklxqKPm0Wyo E8IcWT71SBJEwKO+TNH9NkOLMurfvCCxhs3JBuE78wa2Qp7IliLJtemdh6lHvxopEnm4BCjX/aT P2dQ2EGUCaFQZYvuaeTvzlUe9qENnLttTf1zdz9YNRJnZ5Seg41MMU+jTrANn0usoXhzBVEMUVB cf2R7Nhx5RLf+QTquwG3eaFauoAkFe3xxbtVKbxKzl7HC+SSuXMw3Yn0RbSDQaZmIJjptWE7ePl vV/1+Wk7a+WKxed03aTDuQaEA9ROZRlKDySFht1MfX+crHNwjkK3mSEjh681blJQJtzFzGyWSg9 PGlwieycs9N0dTA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Refactor check_pseudo_btf_id's code which adds a new BTF reference to
the used_btfs into a separate helper function called add_used_btfs. This
will be later useful in exception frame generation to take BTF
references with their modules, so that we can keep the modules alive
whose functions may be required to unwind a given BPF program when it
eventually throws an exception.

While typically module references should already be held in such a case,
since the program will have used a kfunc to acquire a reference that it
did not clean up before throwing an exception, there are corner cases
where this may not be true (e.g. one program producing the object, and
another simply using bpf_kptr_xchg, and not having a kfunc call into the
module). Therefore, it is more prudent to simply bump the reference
whenever we encounter such cases for exception frame generation.

The behaviour of add_used_btfs is to take an input BTF object with its
reference count already raised, and the consume the reference count in
case of successful insertion. In case of an error, the caller is
responsible for releasing the reference.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 622c638b123b..03ad9a9d47c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17861,6 +17861,42 @@ static int find_btf_percpu_datasec(struct btf *btf)
 	return -ENOENT;
 }
 
+static int add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
+{
+	struct btf_mod_pair *btf_mod;
+	int i, err;
+
+	/* check whether we recorded this BTF (and maybe module) already */
+	for (i = 0; i < env->used_btf_cnt; i++) {
+		if (env->used_btfs[i].btf == btf) {
+			btf_put(btf);
+			return 0;
+		}
+	}
+
+	if (env->used_btf_cnt >= MAX_USED_BTFS) {
+		err = -E2BIG;
+		goto err;
+	}
+
+	btf_mod = &env->used_btfs[env->used_btf_cnt];
+	btf_mod->btf = btf;
+	btf_mod->module = NULL;
+
+	/* if we reference variables from kernel module, bump its refcount */
+	if (btf_is_module(btf)) {
+		btf_mod->module = btf_try_get_module(btf);
+		if (!btf_mod->module) {
+			err = -ENXIO;
+			goto err;
+		}
+	}
+	env->used_btf_cnt++;
+	return 0;
+err:
+	return err;
+}
+
 /* replace pseudo btf_id with kernel symbol address */
 static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			       struct bpf_insn *insn,
@@ -17868,7 +17904,6 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 {
 	const struct btf_var_secinfo *vsi;
 	const struct btf_type *datasec;
-	struct btf_mod_pair *btf_mod;
 	const struct btf_type *t;
 	const char *sym_name;
 	bool percpu = false;
@@ -17921,7 +17956,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	if (btf_type_is_func(t)) {
 		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = 0;
-		goto check_btf;
+		goto add_btf;
 	}
 
 	datasec_id = find_btf_percpu_datasec(btf);
@@ -17962,35 +17997,10 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 		aux->btf_var.btf = btf;
 		aux->btf_var.btf_id = type;
 	}
-check_btf:
-	/* check whether we recorded this BTF (and maybe module) already */
-	for (i = 0; i < env->used_btf_cnt; i++) {
-		if (env->used_btfs[i].btf == btf) {
-			btf_put(btf);
-			return 0;
-		}
-	}
-
-	if (env->used_btf_cnt >= MAX_USED_BTFS) {
-		err = -E2BIG;
+add_btf:
+	err = add_used_btf(env, btf);
+	if (err < 0)
 		goto err_put;
-	}
-
-	btf_mod = &env->used_btfs[env->used_btf_cnt];
-	btf_mod->btf = btf;
-	btf_mod->module = NULL;
-
-	/* if we reference variables from kernel module, bump its refcount */
-	if (btf_is_module(btf)) {
-		btf_mod->module = btf_try_get_module(btf);
-		if (!btf_mod->module) {
-			err = -ENXIO;
-			goto err_put;
-		}
-	}
-
-	env->used_btf_cnt++;
-
 	return 0;
 err_put:
 	btf_put(btf);
-- 
2.40.1


