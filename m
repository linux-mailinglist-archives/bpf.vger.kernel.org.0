Return-Path: <bpf+bounces-5113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BFD7568D9
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC7281296
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D65BA58;
	Mon, 17 Jul 2023 16:15:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38754BA49
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:15:52 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7310F8
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso27844695ad.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610544; x=1692202544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0sE7x+Pmx9ObRUicpaod1BQl7P3Nqx5J30aOVHU6jg=;
        b=EHuJUE2N7sQMUMA9Latz3X7Ut08VndOU/f5wkDzDZFyaFrsoElyuNPiIxpkjMUBQNp
         e0GcV5tdAvhqsUgUnLSKFxqCENuFcj1I26k6snuSaYjGvc7QOJCkITRg3uDMhckUT+8F
         uZpeTmhyl4q85dWTVdlxYbYQncRxdv0Gch0ioq9ztxFhrqk2Nl+GgC29+eo4M8WnmtxK
         OBK3pxDzb7q5hqzzmtUJyOY4YsWa/bLXswhdROPN3F5tz5E69WfxPZhLIieAm194F4Ou
         x36H2GlEgUYldFpuoq6I/gQcweZjwluzMy90iWieoxmP92BKrTsEwu4wLIBidLrgJK2w
         B4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610544; x=1692202544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0sE7x+Pmx9ObRUicpaod1BQl7P3Nqx5J30aOVHU6jg=;
        b=QjaWEGGr86CJpwQi8fjsGWCaSGchbubXfbRbQzIgEg1w9J8V8vz1yNLNCCkxzT16uZ
         wQUxfKS/c7zQkWFoeUu7Vju8HojuW7kd1xeFSgvjlOpACbwXCP1VpLaMgweb+LG88zLM
         taYkCg1e8fQiofS0P2Y9C5LZ3yCynK7lfpz9wPJ/1AkBuY5rHinkw2ryofIDC7reiPmo
         2J7+XgpjpxKkpJf9xaYaSkUuTPK7n1cK00upvlIb/XD8zH2RchiFnuZWdV+HsxrSAVLj
         xceV/mKSyy5nEVlD9paxjPxLNqCM4Juc/ipBTRbuxFlQWoR5sY5L9e8ugvP7sv+/Wh7p
         UUkA==
X-Gm-Message-State: ABy/qLar4SqQyKaouBm9KyLSe05YBkuFUgcOhLV107TNyvfU1P8hwsvJ
	KO8CIRMLB7RBTAE1Uj6cz4MJ3nkooWKluA==
X-Google-Smtp-Source: APBJJlFUawzLAW8T/Gl+CTO2VRsvAhITj2BhoeKuhObjgo8pwIHXtkTHXSz70PUwvfy/OE/sEes6sw==
X-Received: by 2002:a17:902:c407:b0:1b8:1be2:3938 with SMTP id k7-20020a170902c40700b001b81be23938mr14111105plk.5.1689610544109;
        Mon, 17 Jul 2023 09:15:44 -0700 (PDT)
Received: from localhost ([49.36.211.25])
        by smtp.gmail.com with ESMTPSA id jf10-20020a170903268a00b001b077301a58sm97199plb.79.2023.07.17.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:15:43 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v2 2/3] bpf: Repeat check_max_stack_depth for async callbacks
Date: Mon, 17 Jul 2023 21:45:29 +0530
Message-Id: <20230717161530.1238-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717161530.1238-1-memxor@gmail.com>
References: <20230717161530.1238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=memxor@gmail.com; h=from:subject; bh=5GvfA1qEEtUZA8ygJhQ7lHj/KVQJMWve05m54jV1mPc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBktWjgrkjx6bGKvf5ej5hGTPjgolw0R7BVFP6TP f7BqiU1eNmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZLVo4AAKCRBM4MiGSL8R yiXpD/sG2yPnpX4qmfQZTjJJM56ei9Hrxp8SWADXXH/42v9PPCMltYsV9krvIrEy3vlA5in2T1L r1vN2HDzoaRh8COOqRZZzKqrfCsOQsOTSDcRgFTGgfQH4Clhe2Fm1R7uIKk4hbeTR8h0b7lZge/ /zi9CDDKpD1FcKZv0sGoCL7xGcZOdD8qaz4XcGdqeM6TR7wG4iEK2zYIZvVAZxGPQgjgFgoD82p MYaW//7cB9dO/TIeOal9sUXPVStoGETgsCk5MVWAwuz3Sg8ANSvqGKXfetEY9502egGjo3EgCfa MbldAVSiHRxm5qzFF599Mrv48FuSFcL2DR/IhW5+NlsOegwndMX6EJGk6uZNQM5xgxpKAZfLvnu +FZjBSofqkl1JbcwotasSSS8Rf9ms4TzPTIMGFsChyAAe0g9GlUclaZY7p/PjE6wxzD8M3Sqmon oUCTNHNDGYSlL1QPLhWafVZZ7kMn5CDzueWHda19gnrKEFZ71AkWFD+P07ZkqH+5UiQ3O8Z5XYf yW1ZAq72YxIYf03waNvDv4l2utdWzscc0WSgWCeEbkH6SnJ1Nv8wNJvtNkg8JPAWmcdnTtc1K0m jUq6LSbeV2rVngmJFvYJDPknMhuTFC6wiRhRrFwheoUUAbYv0ZCnkj3/Ghp0P4bKOFXZEVx4/Wq Rcoy0M+FpKya7UQ==
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

Consider functions with following stack depths:
main: 256
async: 256
foo: 256

main:
    rX = async
    bpf_timer_set_callback(...)

async:
    foo()

Here, async is not descended as it does not contribute to stack depth of
main (since it is referenced using bpf_pseudo_func and not
bpf_pseudo_call). However, when async is invoked asynchronously, it will
end up breaching the MAX_BPF_STACK limit by calling foo.

Hence, in addition to main, we also need to explore call chains
beginning at all async callback subprogs in a program.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e682056dd144..02a021c524ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5573,16 +5573,17 @@ static int update_stack_depth(struct bpf_verifier_env *env,
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


