Return-Path: <bpf+bounces-8286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5327848B4
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4228113E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A171DA54;
	Tue, 22 Aug 2023 17:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094379CF
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:51:49 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC6D10F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1bf7423ef3eso17567045ad.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692726707; x=1693331507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgyZzA4g13/NiqRVMehNHrHirG6uJMZnw8LcxOTPnkE=;
        b=pQYYm1PYHHLwx1sJ8s1tVjIR50CmnO9GmlBSotdr46dMj/VrWUVbZjuroJT16I+299
         dB9V07LReGHPlm2vKeOdFpKuariFDTCsXY/P2nGk1gG+n0lMXv8W3Z2IG39cLXExdaHR
         cLwExMle2ntTzZ/TvOvccg28D+sQ4bl5qX7oqd6FaH06heeURVGzIK+5138QkKVXpK5T
         yLZHGBCz3G8gi1xfpgN8KjbDeKJfQ6gSO8m8X7xjq1UoLIeVbeTC6OofwhjmCsMPk2s/
         0VzEkhwNfFMquZ/wKP1vcYeQ1URazKpxmHOAbrN7Kor4N0RE46LzMcHwnwyAzKtQCDdP
         WhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726707; x=1693331507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgyZzA4g13/NiqRVMehNHrHirG6uJMZnw8LcxOTPnkE=;
        b=A79hKotj3yfFV773SLyhUrx69L/5Da4XVTUDk2anwANZUMkdW7tbzMkVnsghuKEqez
         YeJ1afvMvcpYZ1TTZMXnUC209T9rY8boh8NGosWFF3zv7+sB6KtkNJIBBCa63qiAkPoX
         Snzjct7Dw1KP5R9OsefadjJ4xz31IqPhMXGSMit/jA0T8ZswL8vDUtK9TnZ7dAIy/9T3
         oX/4/8Sg/P2WpoaKzSnwk/CKkJTfK7wH+JgTm9w3XeUZ/qXBVpQQ8nKB8z4FwrOei317
         Aq0wktNZUPKb0M3RLQbkXvAXHWKY/1WAM2hBgXwLR0jY4WG57H02uqBFtbC9OPbyk2IP
         mNWw==
X-Gm-Message-State: AOJu0Yw8PIytrfiehdI2Q+aN1Mm0ip81XyS6bI0eaIMSIkjQwmH0lHIn
	VUk6Zh/a81q0Kni7alvwy8G3k2Xy254VRI0s
X-Google-Smtp-Source: AGHT+IEGafQA+un9H9OxJIrRbXuzAF1q2djqEZarqY2flZGS1O4BNwiNpTWX3tn8Drrsdu7VzJq8gw==
X-Received: by 2002:a17:903:2286:b0:1b3:b3c5:1d1f with SMTP id b6-20020a170903228600b001b3b3c51d1fmr10370595plh.8.1692726706967;
        Tue, 22 Aug 2023 10:51:46 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:46af:61ea:5ce:65e2])
        by smtp.gmail.com with ESMTPSA id jm10-20020a17090304ca00b001bdd68b3f52sm9257746plb.302.2023.08.22.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:51:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v1 1/2] bpf: Fix check_func_arg_reg_off bug for graph root/node
Date: Tue, 22 Aug 2023 23:21:39 +0530
Message-ID: <20230822175140.1317749-2-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822175140.1317749-1-memxor@gmail.com>
References: <20230822175140.1317749-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=memxor@gmail.com; h=from:subject; bh=PDj3b0mIO+vAnEI9jXQ/p0CSY9gD8SHyzMySjBF1oEw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk5PV1NOdNZpNfrwLvMVxQ4IWUtpxgmKE/Y77vu Fv2HIuO7mqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZOT1dQAKCRBM4MiGSL8R yop9EAC2bG39RzFzX2S+/p767ly8wa1yUmwBx1YYV+jLWvu+VKd+l3ZGXAIQLtaXduTM0fOjiE6 hKNEppzEWJw7KH4ewyjR26ulAdLOclHod+puY0ObzQD5QJa5EN7CUp+scyhQE84hjVR5NjbvjN7 Dyu5+q5WxzsvQ3Ikrassjtc4QxLrbGb9oJittD3Vxqfttz2ggFQMZOt8jxeYAMOaI9UAnI/ROON kH+BmhNqi5A9vyv3+bZgHI0uGc6Fexh2Qe7zVck4qFY/H1l32ffoLvYyOTaeizqqZZbmNCk/BNd bdxG8Fv8NNQps/amH/C1kc1yNd5y59EpoBeqNkCNO9cen+Ms1Sap/s83B3gAFlkW+/nzbvD+xZY PfnUUVKcaUZn0fUEOxxK7bLCEgyoQ02GZGirboN6jLxo7Vpfz2qkZsmh4KPk5sa/RR/lzgj8zkk xLghV238JWNuowAwUykgDYsQWEzsKl4BdTRListhHO/Qasc59qLfxkiA003uGY+0NW3DGeXPzdS 07f4AkzqBHdeX1g4hqWhlc7926sPPfd/mJw7gIIi1qPICgHo6EICus/iA5jDnQXypSWLU8z5WMa nuCakFETSqP8rU6jF47D27BMVy67iu/3mQvusFvNQJ2iczroi3uALTQOZdHH7yCer0WxWjOFYKZ MqdBCWMZDY6I+ug==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The commit being fixed introduced a hunk into check_func_arg_reg_off
that bypasses reg->off == 0 enforcement when offset points to a graph
node or root. This might possibly be done for treating bpf_rbtree_remove
and others as KF_RELEASE and then later check correct reg->off in helper
argument checks.

But this is not the case, those helpers are already not KF_RELEASE and
permit non-zero reg->off and verify it later to match the subobject in
BTF type.

However, this logic leads to bpf_obj_drop permitting free of register
arguments with non-zero offset when they point to a graph root or node
within them, which is not ok.

For instance:

struct foo {
	int i;
	int j;
	struct bpf_rb_node node;
};

struct foo *f = bpf_obj_new(typeof(*f));
if (!f) ...
bpf_obj_drop(f); // OK
bpf_obj_drop(&f->i); // still ok from verifier PoV
bpf_obj_drop(&f->node); // Not OK, but permitted right now

Fix this by dropping the whole part of code altogether.

Fixes: 6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref semantics")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a91bfd7b9cc..3d51c737a034 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7973,17 +7973,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
 			return 0;
 
-		if ((type_is_ptr_alloc_obj(type) || type_is_non_owning_ref(type)) && reg->off) {
-			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
-				return __check_ptr_off_reg(env, reg, regno, true);
-
-			verbose(env, "R%d must have zero offset when passed to release func\n",
-				regno);
-			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", regno,
-				btf_type_name(reg->btf, reg->btf_id), reg->off);
-			return -EINVAL;
-		}
-
 		/* Doing check_ptr_off_reg check for the offset will catch this
 		 * because fixed_off_ok is false, but checking here allows us
 		 * to give the user a better error message.
-- 
2.41.0


