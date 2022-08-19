Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B059A7DD
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbiHSVnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiHSVnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BDBE3C
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f4so2807928pgc.12
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZBI+fwy76bkYY8LVV14e2AjKMWsYkt0VzLIv3m+2oj8=;
        b=ZrGKkLUP6ZJKXIZPS65dM/dVlcFh5D42Kebha2HBWqrRjunPYa8phJu/LZ6s2Eykhe
         zMVvKesptbxuK4TjFFxmkfk39Q2PAMttuQLmkIVyZVwXdOsttmDcjpWQ/W51LhcXGeQw
         eWs5kWF1ymCJ0Pm7jev0AjfgeRp6CncHmEKS6M36J9/jO6HKHg3xJJGwd1ncmyQLvLn4
         fWLQPjDGvrHHErxTsPTpIcX5Jbq9U+zBwl0Ebr4ekzakyu8KQKfXOe6Y2KKbZBhp+WD7
         XpW6c339wN77gce7pVAqWQ6pOHHYwl15UbBmJpsFeHJxQPYe6SuRGBoJhs8Wv7uQfgzv
         3JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZBI+fwy76bkYY8LVV14e2AjKMWsYkt0VzLIv3m+2oj8=;
        b=IZMOO0TPryJ+nftxhrRyUveMd5vT92Cqlg5s5C7BJfKp5Ev4q7MwNwasd7qBRq0Wyx
         kZrFR7JgM6A1MsCXcBWRjaZXg/+j5tp1vEBR49AcgWec+9dKuUAAy4EX2HTEqAaRh8tY
         PdmZtllC31l7OyHGpf0f/g1wilixOkchidxmQNMY3uEBSxtWRhDKC9ubdBzSakhDXztB
         T5gZDcSCiT9DQzQ6JZurqh1fpQr6qeNsgqapFXFp64IhTpLPqzDzD4KMkxusYKL/q3vt
         AWOnlPJcCPiJo9w2dWYuKbl2pdIjQRxPVORCLws0KeLDoUn1pUiJ20ZklPAZgJaWASZC
         V26Q==
X-Gm-Message-State: ACgBeo3dI/nRip8UZSaCriaTn+/DPsSojN7ev9TKO6f6e1hTsAikL+JI
        OfDlKMG2YsUqZPR3axtJ75Q=
X-Google-Smtp-Source: AA6agR7oDkmuQzOgW9F0m5UMAkfxkclSWKTAKhyoF1nqkS99BcY1GM7gcN1QX1nxGpw4wZpR9y4iiA==
X-Received: by 2002:a05:6a00:1588:b0:52f:a5bb:b992 with SMTP id u8-20020a056a00158800b0052fa5bbb992mr9616631pfk.38.1660945399062;
        Fri, 19 Aug 2022 14:43:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b0016d6963cb12sm3562742plh.304.2022.08.19.14.43.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:18 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 12/15] bpf: Remove tracing program restriction on map types
Date:   Fri, 19 Aug 2022 14:42:29 -0700
Message-Id: <20220819214232.18784-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

