Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54F5A1F0A
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbiHZCpB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244872AbiHZCo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:44:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDA41CFE3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jm11so419481plb.13
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3mqXakE7twO5rpPKR4kaQK7GjmKBp7UOh97wf3rlLLs=;
        b=Ts1ypdy+1bsDA841Ckzl1jFQs5Ddjh9LsLbOtpSMZAikE1vFQWCk6y8dDrk+WRnEJs
         ulUmiCSq/5l8XtlF24ltS4sju6xZs/vPhDxsc0yJS5UmlqJ/lMdHXjoExMcqj3LZbb8g
         01MiFGQD/UEGxc22NjIWUnGH3HLTyiJOKl97ggTWdENDYGd+PRXQbNuHMlWbHvWxHLFW
         sz9eq4usJdVrS/bslLT4UeZ1IcUmFFYxVvhsEMwqr5ZKnqaY08m+06DnAKod2sah0h4v
         p8QlC7yg244hKgk8rUFgNDubkZCk8i4rWVMVHGD4tkJtWagfbZUa1zicg5C7m2MAJLhU
         iNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3mqXakE7twO5rpPKR4kaQK7GjmKBp7UOh97wf3rlLLs=;
        b=Eba5SS/+jJZU5egIBnCVxSK4aKkkWA9jFEtEOLU8hQYKVSX9aGuVF5lDDhILYqfLl8
         omQrXkQkPn+KOTO0nW6Xk9+5+lvZ10zsRZ3NzSElMw4w7rcjkpXErLqtC+8pmwt01tCs
         zPRigk2PIybgaI4eaL4kJQXviSh3CfpwLUPclCevOua9Lzomp0A1jOoCBxPpuv9VH2A4
         y15/2smy3gD5Sksk+aLHgbv5u737DThiBNcompwYaptl2wbq/37B8sjHfHgrvWyWg87T
         zFnYRgjr0Qtn5hZ61yVuprvSWy+M4SKFWz5iJK/ITusylM517zyvvjHidyIYoS+AKjbC
         27/A==
X-Gm-Message-State: ACgBeo2SVPMI/s4WxDuC3VBU2eItq80INQjMEQ4a46Wwt29FwKa4s/QW
        173QtpKhI92n/KQ5PCVuJz4=
X-Google-Smtp-Source: AA6agR4vvT5Bvx0/kBrb3s1GNaOacjAGPqdnwmEadcnCadwXfyraXlXYt6utigpRN4EkUigFdsAhyQ==
X-Received: by 2002:a17:902:a411:b0:172:766e:7f3d with SMTP id p17-20020a170902a41100b00172766e7f3dmr1714520plq.24.1661481893768;
        Thu, 25 Aug 2022 19:44:53 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b001f3e643ebbfsm463922pjd.0.2022.08.25.19.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 05/15] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Thu, 25 Aug 2022 19:44:20 -0700
Message-Id: <20220826024430.84565-6-alexei.starovoitov@gmail.com>
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

Since bpf hash map was converted to use bpf_mem_alloc it is safe to use
from tracing programs and in RT kernels.
But per-cpu hash map is still using dynamic allocation for per-cpu map
values, hence keep the warning for this map type.
In the future alloc_percpu_gfp can be front-end-ed with bpf_mem_cache
and this restriction will be completely lifted.
perf_event (NMI) bpf programs have to use preallocated hash maps,
because free_htab_elem() is using call_rcu which might crash if re-entered.

Sleepable bpf programs have to use preallocated hash maps, because
life time of the map elements is not protected by rcu_read_lock/unlock.
This restriction can be lifted in the future as well.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..3dce3166855f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12629,10 +12629,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	 * For programs attached to PERF events this is mandatory as the
 	 * perf NMI can hit any arbitrary code sequence.
 	 *
-	 * All other trace types using preallocated hash maps are unsafe as
-	 * well because tracepoint or kprobes can be inside locked regions
-	 * of the memory allocator or at a place where a recursion into the
-	 * memory allocator would see inconsistent state.
+	 * All other trace types using non-preallocated per-cpu hash maps are
+	 * unsafe as well because tracepoint or kprobes can be inside locked
+	 * regions of the per-cpu memory allocator or at a place where a
+	 * recursion into the per-cpu memory allocator would see inconsistent
+	 * state. Non per-cpu hash maps are using bpf_mem_alloc-tor which is
+	 * safe to use from kprobe/fentry and in RT.
 	 *
 	 * On RT enabled kernels run-time allocation of all trace type
 	 * programs is strictly prohibited due to lock type constraints. On
@@ -12642,15 +12644,26 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	 */
 	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
 		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
+			/* perf_event bpf progs have to use preallocated hash maps
+			 * because non-prealloc is still relying on call_rcu to free
+			 * elements.
+			 */
 			verbose(env, "perf_event programs can only use preallocated hash map\n");
 			return -EINVAL;
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			verbose(env, "trace type programs can only use preallocated hash map\n");
-			return -EINVAL;
+		if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		    (map->inner_map_meta &&
+		     map->inner_map_meta->map_type == BPF_MAP_TYPE_PERCPU_HASH)) {
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				verbose(env,
+					"trace type programs can only use preallocated per-cpu hash map\n");
+				return -EINVAL;
+			}
+			WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
+			verbose(env,
+				"trace type programs with run-time allocated per-cpu hash maps are unsafe."
+				" Switch to preallocated hash maps.\n");
 		}
-		WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
-		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
 	}
 
 	if (map_value_has_spin_lock(map)) {
-- 
2.30.2

