Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD25AB9EE
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIBVLs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3BDABBC
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c24so2942677pgg.11
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0fGyRfQR7wXSaL6USjScrGPvvIFh66CwdJrIvv58a5g=;
        b=f9ZJGOxbwYCUfS699Y4HA7lWPPB3p8DS5HVSKmOcLRQUl8OIe8Hlunu6jAN/iqOW/N
         QhCKvfG0MsvcA17ghHoZEnsfnrA6kgsmKMLwXWVJ+wzu6nGWnUs44ny1WHxEPloYRiqP
         GS+Y+HPYHsLEeFDiEauG/g38ktmMlyQizGE6PiWPYuz/DDbbMQI6UvLCL+Ctb9Ieyly0
         l1V60K6e11KsUkpS4iskN8qgaySrb4A7plkOJ8oOl15OKzlcFxMv7+mvVjaeSr7KRaJz
         KLfhEYUuFMSGr+0ZwK1/K05S7YWXkqvIwHxjJ87arj7aDQCAj32CZOoDbiDdK0RB1jdD
         HOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0fGyRfQR7wXSaL6USjScrGPvvIFh66CwdJrIvv58a5g=;
        b=6a0ugCZmEqgRz+8NILT+xwWZzdyBldKhTquueNg2H7kmYr690xEJ5DLWvHJzLGhdLh
         PEVZwEmapSyeMdhqZb9DYn1cetHTKrZCWlh+dqdTP/jxJvm+YsRB+kwIB7pE99DKiqWQ
         ZZ9onT2WN3K4EG+BSvySwydW92SvCFUwIKl5TT0s9MRXEAFdH4ZE2tgVT83hIYHYDreZ
         M7EzAnqKopm8QFmeVctH9IC8P4FX2bq/f9P7v/mOkUmU8eavHT8PttfUD0LaCs6/69oy
         F9wt/tinEFz2YrT5Ln90LV03WmxuIwW2c81c8nu7zCzGBc2ySbIEmOrxXrunbXx+aH+k
         A8PA==
X-Gm-Message-State: ACgBeo1bf3PhyRzZCqxsHQUQ6UiS7l2oPbHxXSpijb/UeTmxPMzT1cVW
        Xdhn9YLVrn8L8whe+1FxCRM=
X-Google-Smtp-Source: AA6agR7Y0ntmo6WJN5i54Frl+0Q0pJs+/U+OuU5sDJJjsDGmYEEAIe/z6DKl8Pf1q40IiYJfNKDOGQ==
X-Received: by 2002:a63:451f:0:b0:42c:5a26:d7cc with SMTP id s31-20020a63451f000000b0042c5a26d7ccmr19825722pga.199.1662153106479;
        Fri, 02 Sep 2022 14:11:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id iw5-20020a170903044500b0016d1f6d1b99sm2075753plb.49.2022.09.02.14.11.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:46 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 12/16] bpf: Remove tracing program restriction on map types
Date:   Fri,  2 Sep 2022 14:10:54 -0700
Message-Id: <20220902211058.60789-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

