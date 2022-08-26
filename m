Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC85A1F12
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiHZCpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbiHZCpW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0073641A
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 199so269547pfz.2
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=npiETgRwDYegJeQPkgRCmw8CYHFlORx1B2gGnaepqcQ=;
        b=e+bSbZkl7envlVYZAFYCewLjpcre0KiJcKaFhi7xoVHKhCWc0njTaLRrXpeVFZSH+R
         vsaeoPXH0MEWU5tzVg3/VfJTcqZ1MGqmuMRfSlihRYhiz2lvscCrABVy3CVUVyfwUs74
         Uezxt8PpEomaEhfEyZD0h7ZhXuS3FzQwPWOGzcmhfHHdeisZH55JPNPcQeMChpC5wfZJ
         z9OWknA1te3hX8a6YuCheJ3sYjkIkzCwn6QyNzb2JEWhBB2RxieeBZEa7mUbrSH6TlXo
         wapvrbiOPg5Juf9JqnN7d+2n7Ax2yEl3enbdNQfCSBSBFUmOrHD0sbcywSKOaqffYx0e
         z/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=npiETgRwDYegJeQPkgRCmw8CYHFlORx1B2gGnaepqcQ=;
        b=dtkduf2BXwyErrONqtj7Js1m1OChfY/2L9ujXBZpKb7T1/u6+tEiDDZhn8kh8czLhZ
         80wxhk5G/vpCsVNpOONyl+XemXvUsoK+Rls2gXrdSwYLq0ON+K672TbLgRy2mCSKCCYg
         EzmoD4nHZ5E+WVPAU/iL+YMiXS902vTmcvolFDFYQB0wpX12BKD1T87z3n12DT0Fwr1u
         oGgzaDedkAkf5+048Rg08Eu1yZarMAMEuqPEsLR+jY8pBw8iEb6s00oy4p4gy977cwFy
         YtDNUpb4FVAXg7sjU+z8N/wpgcZ1OLNPCSg79dF6V2gfBjVypyG48GQrW757xtNTAcie
         /tlg==
X-Gm-Message-State: ACgBeo1lgWL5s2Q3K535ZmlgJGO/r/fWMcgU966NjaQkPa3asvzPCHVj
        1HkFgXJTpRcOiPygV08Ock8=
X-Google-Smtp-Source: AA6agR5mEmWR70rsohsYXBBkwh25jznbtxJMxn5NHJGfQXVbDlt9394v2MZchWx42S0yKImnG+fpug==
X-Received: by 2002:a65:6c07:0:b0:41d:9ddd:4266 with SMTP id y7-20020a656c07000000b0041d9ddd4266mr1595015pgu.326.1661481921144;
        Thu, 25 Aug 2022 19:45:21 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id w188-20020a6262c5000000b0052c456eafe1sm365074pfb.176.2022.08.25.19.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 12/15] bpf: Remove tracing program restriction on map types
Date:   Thu, 25 Aug 2022 19:44:27 -0700
Message-Id: <20220826024430.84565-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dce3166855f..57ec06b1d09d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12623,48 +12623,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 
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

