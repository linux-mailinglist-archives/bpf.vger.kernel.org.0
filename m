Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D117597885
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiHQVFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbiHQVFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:05:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB630AB4EA
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d10so13001725plr.6
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZBI+fwy76bkYY8LVV14e2AjKMWsYkt0VzLIv3m+2oj8=;
        b=WWKi4wI8r69uN3XJ0TC1pEJIpFbczA4APGAcyEcd85IDHK1d0qgmvHQGgGWL29zF80
         h6GVEVP662vDxI0f1Ihp9BP9SNsUKr/sAaalCilStw2HtG+V91lr9Y+ThIEzl9CEgiVe
         x+xHcMTAqaqDqV2aqjtTd/xGI5qKv1LxiJ27F32wwTMARWO03anfgcCy+u55VZcY1QuN
         zJJh3bmyUuq6wgP3xmlIPUTYPYPUAdYWM0aCL76A31OJ5tFL6pl54wF0Kl9LKhXA9ckl
         BQmX+AWaxGxV2iGQawz9rTaK9CSK38EjvwR2IDHqzxs54KW9Zub5bvmqUHzoIW7nrDeq
         g+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZBI+fwy76bkYY8LVV14e2AjKMWsYkt0VzLIv3m+2oj8=;
        b=JPisQGOc4VnTKFeYA/Ly10jNfeRb+V/mTmOY8yMIem/Vjq4JWEGT9pEiOXZo7CdRXD
         r5Ow0s1JCwy3qw7FMG5cYeFVUxQOtJ7QDHxRro1/uu2F8lRSHNqwwdOESGlfytkcZWqF
         lr6y44JyWG2D27uyJz3qbDu0jZu79aqCPNryW8qox/VLLJnERYOmTeQqg3sN0J14hgRR
         6+FZFjHnDrkBz4Tyx/n20LblRCLn+3s/dAL7Di9txwNZpt4ZJoCgR2a5IDifHh+NXJB+
         A5DMeFIpZwE/VWCDYTFTgBcu8lKCNEMXLneY0Lc5qOmB5j0BQ5S3V7C9unu1qF8Bkb4+
         Bz6Q==
X-Gm-Message-State: ACgBeo05Mp8PHWm/6Ng0ACFr3d3Ix0WT6g0UVZeUhDxkYr3XgWUDB0CR
        QUn2SPStfzH2MGNAW1VVgWg=
X-Google-Smtp-Source: AA6agR7gJR7MOvq7/smgPOcBfW8hZe45QZI7aUrmByAEqpEfPv1pIsb0aEpqc9BmPebRsePmQkj86Q==
X-Received: by 2002:a17:90b:1b05:b0:1fa:c33e:9137 with SMTP id nu5-20020a17090b1b0500b001fac33e9137mr1728268pjb.59.1660770306969;
        Wed, 17 Aug 2022 14:05:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b005349f259457sm8204082pfx.160.2022.08.17.14.05.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:05:06 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 12/12] bpf: Remove tracing program restriction on map types
Date:   Wed, 17 Aug 2022 14:04:19 -0700
Message-Id: <20220817210419.95560-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

The hash map is now fully converted to bpf_mem_alloc. Its implementation is not
allocating synchronously and not calling call_rcu() directly. It's now safe to
use non-preallocated hash maps in all types of tracing programs including
BPF_PROG_TYPE_PERF_EVENT that runs out of NMI context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d785f29047d7..a1ada707c57c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12599,48 +12599,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
-	/*
-	 * Validate that trace type programs use preallocated hash maps.
-	 *
-	 * For programs attached to PERF events this is mandatory as the
-	 * perf NMI can hit any arbitrary code sequence.
-	 *
-	 * All other trace types using non-preallocated per-cpu hash maps are
-	 * unsafe as well because tracepoint or kprobes can be inside locked
-	 * regions of the per-cpu memory allocator or at a place where a
-	 * recursion into the per-cpu memory allocator would see inconsistent
-	 * state. Non per-cpu hash maps are using bpf_mem_alloc-tor which is
-	 * safe to use from kprobe/fentry and in RT.
-	 *
-	 * On RT enabled kernels run-time allocation of all trace type
-	 * programs is strictly prohibited due to lock type constraints. On
-	 * !RT kernels it is allowed for backwards compatibility reasons for
-	 * now, but warnings are emitted so developers are made aware of
-	 * the unsafety and can fix their programs before this is enforced.
-	 */
-	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
-		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
-			/* perf_event bpf progs have to use preallocated hash maps
-			 * because non-prealloc is still relying on call_rcu to free
-			 * elements.
-			 */
-			verbose(env, "perf_event programs can only use preallocated hash map\n");
-			return -EINVAL;
-		}
-		if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-		    (map->inner_map_meta &&
-		     map->inner_map_meta->map_type == BPF_MAP_TYPE_PERCPU_HASH)) {
-			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-				verbose(env,
-					"trace type programs can only use preallocated per-cpu hash map\n");
-				return -EINVAL;
-			}
-			WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
-			verbose(env,
-				"trace type programs with run-time allocated per-cpu hash maps are unsafe."
-				" Switch to preallocated hash maps.\n");
-		}
-	}
 
 	if (map_value_has_spin_lock(map)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
-- 
2.30.2

