Return-Path: <bpf+bounces-4898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB8751656
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DF41C21247
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10CA52;
	Thu, 13 Jul 2023 02:32:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87C7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:32:51 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD251986
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:49 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 46e09a7af769-6b74b37fbe0so171147a34.1
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215568; x=1691807568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9TLCcC/dxKK9DyiNnY8tXOVbmGLInSZ4Jmy/vT5YPk=;
        b=B/DDOSkIhZl5RosVIPZpSkfi5jnXJUpWeaVLnXxIOUtMzpO9cP6vU4EALAyUjzS1dN
         2LpAeQ1XG0/tSJpApjz9kDerTXaOaQzvq+KR1Kx9t1PtY/Y6LEY3HLdAAgcH3NMReDcM
         gMmd9uaE1sZJBGR6X4q0QuWvo7t45ECgPpuAjJglLqUhD0MJCZY2ywsyDPiqbp/ibiza
         8drMVMG4paqSkWiGlfMa1FAr6Enh4Kn8qSZ+SUn3J+g5xUx8t/eA52d2EWguwC+Y6gF6
         jrNsQm3FZgqZhy/y6aKMjFxOu7xWR26L5uP+IiiAM1UT9Ilu/FpsbuZUIR+jKSZH2uAZ
         60ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215568; x=1691807568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9TLCcC/dxKK9DyiNnY8tXOVbmGLInSZ4Jmy/vT5YPk=;
        b=ktOFwcDb61lb2njLuwRSqYhGUC1IZo/nn0wu6W7nfXnj4hue/9cUmaGdST6dtRGutc
         rrVEtGcGqpdS7qZerBrnwIVbUAOH8Vf0UzZSzvEM6OE+BH8gKbqAvynufkEJ04OjCPcN
         75NS+x/ixbS+Ezzvfoc+DpbYoteywwtyN0SCx+NUo54itN3ATgIJOiDj2UwMDjnHGnXH
         3CsAmIcrczF+On2UXxaosDxoloAHgyM4XHTaS/BrwkNMcB1IBxCwkcT2C/I4aT54DzAY
         kBfR4KuZr1dkZTADhV35KMl28LkIfTFuvjDfD1wSq6wqrRRs+/5nNxgKHqEckMccJ9cu
         YgQw==
X-Gm-Message-State: ABy/qLbTcDGUtd79maOCfiLnKvngmykMBlE6Ajd9qpN23UNixHuWa0ys
	9SvOXIe+NrfbrDUr1qD4UqnWTMGcVrFtsg==
X-Google-Smtp-Source: APBJJlEI6XhprVHUwpacURA7bfcfAsqCtY4yx+1E+065AdHxkp3dKdEo+bcEuTvd4bo3cGGn3szevg==
X-Received: by 2002:a9d:5d17:0:b0:6b9:742a:750e with SMTP id b23-20020a9d5d17000000b006b9742a750emr413787oti.2.1689215568036;
        Wed, 12 Jul 2023 19:32:48 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090a764d00b00262d6ac0140sm4333376pjl.9.2023.07.12.19.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:32:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 03/10] bpf: Repeat check_max_stack_depth for async callbacks
Date: Thu, 13 Jul 2023 08:02:25 +0530
Message-Id: <20230713023232.1411523-4-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=memxor@gmail.com; h=from:subject; bh=16Y3yKTFfp6fOZjFCd1jyAG6JmopFKuERZo/ZGzw4hU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HGTvPL2BhbEjVFP2B9mgWJHCOKpg3I5RBR/ Y4Ka92K84CJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hxgAKCRBM4MiGSL8R ypArEACa25CEyfy506etMgQUzt8aaqTjgvxbfvwYV5gixEsjMr35VI0PW2eUEDmG+66cDAQL8UE TgKZGJkV5KBktwTS3jW6IyEkZFtzxDpr+vvQogjslCuXcJupVOG7Re7zUP3xWbc99DPJu35dCJh VpKzFJ7A53Cmkn0Y0X7+QCZPe3adZqRaXo+mQtTbP9sWXOhIfTdL536+qXWjSdD0R8M4V/aVZ5/ DZfNCPX3Ia8elUwNJ4pffZVU26kuZ/0S9FC7d+kgNj/ht/BDHdb3SXXgdcOhM/Pb4aSaFoH7Kw5 BqDAg24984vFx1+kdMkiPkmXx82XciNfTSth4XISqT9fk4nh9Fv1JkykRfVJAhkfht+1VneekqM dL7nPb/+7PzQpkg739SP7IkzBocn6ruY/W/EMEnB4jOKR1owtA6GNlenCy93coeL3rvYjE9uSRI 7lYv1+Xy48fOBa8xprMoi3aYb3skNAmxyiM6Uxr1o6oBQeWo32rkqFHgfxtu2ijnf9WukDS6jSf UdxteFsRLAKNHYOY5NHefRx1pDiyX5c9w9w6oV8egZq2Jr02LY4GToa+Qd9VKTRZKpvIo1VS6ar ffgVe1HEg5ZTOquwddeMF4GT9a6D5XwLU1b8fu/o9WkAecltkfdw029BOiV4ELotKdnfHbKuN4h s1CWKqvY///PyDg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While the check_max_stack_depth function explores call chains emanating
from the main prog, which is typically enough to cover all possible call
chains, it doesn't explore those rooted at async callbacks unless the
async callback will have been directly called, since unlike non-async
callbacks it skips their instruction exploration as they don't
contribute to stack depth.

It could be the case that the async callback leads to a callchain which
exceeds the stack depth, but this is never reachable while only
exploring the entry point from main subprog. Hence, repeat the check for
the main subprog *and* all async callbacks marked by the symbolic
execution pass of the verifier, as execution of the program may begin at
any of them.

Consider a function with following stack depths:
main : 256
async : 256
foo: 256

main:
	rX = async
	bpf_timer_set_callback(...)

async:
	foo()

Here, async is never seen to contribute to the stack depth of main, so
it is not descended, but when async is invoked asynchronously when the
timer fires, it will end up breaching MAX_BPF_STACK limit imposed by the
verifier.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66fee45d313d..5d432df5df06 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5574,16 +5574,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth(struct bpf_verifier_env *env)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 {
-	int depth = 0, frame = 0, idx = 0, i = 0, subprog_end;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
+	int depth = 0, frame = 0, i, subprog_end;
 	bool tail_call_reachable = false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
 	int j;
 
+	i = subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -5683,6 +5684,22 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	goto continue_func;
 }
 
+static int check_max_stack_depth(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int ret;
+
+	for (int i = 0; i < env->subprog_cnt; i++) {
+		if (!i || si[i].is_async_cb) {
+			ret = check_max_stack_depth_subprog(env, i);
+			if (ret < 0)
+				return ret;
+		}
+		continue;
+	}
+	return 0;
+}
+
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 static int get_callee_stack_depth(struct bpf_verifier_env *env,
 				  const struct bpf_insn *insn, int idx)
-- 
2.40.1


