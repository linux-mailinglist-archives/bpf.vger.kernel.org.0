Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE056CA64
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGIPpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGIPpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 11:45:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917551A820
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 08:45:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p22so1033950qkj.4
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sK84UVH2wquFXSzUUNoreC4W5iW3VQxZVW1oXFAj7M=;
        b=K+EBOXFVQx22mAysawqPPGd6YF6te2G3ocmODstIFyaoRmScuzwpcC9duEm7VoF1Pp
         P92mJu5GOvGrrgBsgTSJ7RU5dHhaM9gzAdcHKhQ2PZZAgH/lUwBBPydcnx0LqgVp5XEq
         iJXxuSYQEObaYzV7IKJITVT5yUophFPIE1WaQBhaZH9VZKOcYat3AT0FAtHh6866m415
         v/8FKRd1nfulbf0rvPp89YwQDdQP5a8UZdogIEyBSovqnRpayLAx8K5z021nHSBYxjhY
         I05RV4vRNwvGoww0DQkCTd2LGAdYGOoR1rKcXQ2tS95sjaVWDHGgQW3Vg8Qz6FFSJlQw
         MEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sK84UVH2wquFXSzUUNoreC4W5iW3VQxZVW1oXFAj7M=;
        b=zgLtxD28LtcOslkQHU7nkIN41iOKRjej1N58o67rKruLFNa/J0pn1r7J9pfOPz9y/5
         BO6EvDF9zsAZzpw/V25tehIVFjNv1jRZcI+S+HSS2fsaCPkAB2gs/9qtwDvKiLerrt45
         VVmieLfii5P4HT7Fn7c2sRUP5OFIz5Al9E1ou4CuK3cvO4kbZm/6uiWE06QilOSKHleu
         enE702hR86hyGa3ISubKo8nIsu8rMC0so348RAp7NeeUUuB4DhVAd6s9KG5H3ZNfJLSv
         rFsnlfYhxbhwbyCLijvB8i+TfJhnPeUcGTwk+h0esElBXz1z25BnkVFnLcQ2SkkYxz3F
         xVZQ==
X-Gm-Message-State: AJIora8YquFp8uZX465y129ThkJiKiEDYiTvuWUsPFNlJo5ZazRMhozo
        R2tm3iYVdUBC3fsQbdoYbis=
X-Google-Smtp-Source: AGRyM1thPlTdIi4KTSZfgwOR+dB868cIZmv/k3fKNJ8+KGIYpj7VcJN/cbdNBWTmaqgEV08IwHvvnA==
X-Received: by 2002:a05:620a:27c6:b0:6af:3c1d:7fac with SMTP id i6-20020a05620a27c600b006af3c1d7facmr6132331qkp.516.1657381503710;
        Sat, 09 Jul 2022 08:45:03 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:6e4b:5400:4ff:fe10:17bb])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a430e00b006a6a6f148e6sm1682411qko.17.2022.07.09.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:45:02 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com,
        shakeelb@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 2/2] bpf: Warn on non-preallocated case for missed trace types
Date:   Sat,  9 Jul 2022 15:44:57 +0000
Message-Id: <20220709154457.57379-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220709154457.57379-1-laoar.shao@gmail.com>
References: <20220709154457.57379-1-laoar.shao@gmail.com>
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

The raw tracepoint may cause unexpected memory allocation if we set
BPF_F_NO_PREALLOC. So let's warn on it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3cf6194c24f..3cd8260827e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12574,14 +12574,20 @@ static int check_map_prealloc(struct bpf_map *map)
 		!(map->map_flags & BPF_F_NO_PREALLOC);
 }
 
-static bool is_tracing_prog_type(enum bpf_prog_type type)
+static bool is_tracing_prog_type(enum bpf_prog_type prog_type,
+				 enum bpf_attach_type attach_type)
 {
-	switch (type) {
+	switch (prog_type) {
 	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		return true;
+	case BPF_PROG_TYPE_TRACING:
+		if (attach_type == BPF_TRACE_RAW_TP)
+			return true;
+		return false;
 	default:
 		return false;
 	}
@@ -12601,7 +12607,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_prog *prog)
 
 {
+	enum bpf_attach_type attach_type = prog->expected_attach_type;
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+
 	/*
 	 * Validate that trace type programs use preallocated hash maps.
 	 *
@@ -12619,7 +12627,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	 * now, but warnings are emitted so developers are made aware of
 	 * the unsafety and can fix their programs before this is enforced.
 	 */
-	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
+	if (is_tracing_prog_type(prog_type, attach_type) && !is_preallocated_map(map)) {
 		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
 			verbose(env, "perf_event programs can only use preallocated hash map\n");
 			return -EINVAL;
@@ -12638,7 +12646,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 
-		if (is_tracing_prog_type(prog_type)) {
+		if (is_tracing_prog_type(prog_type, attach_type)) {
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
@@ -12650,7 +12658,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	}
 
 	if (map_value_has_timer(map)) {
-		if (is_tracing_prog_type(prog_type)) {
+		if (is_tracing_prog_type(prog_type, attach_type)) {
 			verbose(env, "tracing progs cannot use bpf_timer yet\n");
 			return -EINVAL;
 		}
-- 
2.17.1

