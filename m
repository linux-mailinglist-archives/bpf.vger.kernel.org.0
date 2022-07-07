Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96237569EC4
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiGGJmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGGJmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 05:42:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641A4D140
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 02:42:41 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B61E040A91
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657186959;
        bh=pZynCaPh+TnSiopib07+yX9vDI3B5AI5xmb++t4Qb9A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KN8kdXW6d09yM2V8ktdCMTrL3fIuOqYkxDV/+qOTtCC/qHoE5drmQMPD4A/oBzyDY
         OX1aXQQBC/XdM87Ty81i314dcp55F8WD5QNpXP/7Udo8DjnwQhEuP7nGF6BfI0a2/L
         WRtQssgHI4wj0/Ze7beelWqwh7KgPsyfGI0SkdkEHdwuRALJ9Sdc2cjKMeSZp1QV4+
         ZL8mWA1od2T189JnPri82xf0OsMJBNVQPPd2lSxVuegpSqqxmW6GXhwUPjqrWhqDl4
         uELMMmh4MWL1KIR1EkH77JMBf66O2wnelpAaj6AfrsXe68iZMc/rT1juWCgW46toqK
         A2zG66oedmInA==
Received: by mail-pg1-f198.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so7984480pgc.13
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZynCaPh+TnSiopib07+yX9vDI3B5AI5xmb++t4Qb9A=;
        b=s2vX7ntJlct9B9kUXNcMlz3xifzYju+clFFmdxM1fWV6YWlko+yw8lnNplPQggkC3f
         SVjLlmnUItXeYhET+nDPe8cGQy3Ag+ZN+LxT6MPv+B57mfqNi4p/KGTm3sWz3IsTTKxg
         3T0UzYjF4AOW8MR03Wj93GOxA7drjHWwGCQf6360gyxS2SXlNrufK9AnZ+xDM+14jYcn
         /tehWnL2LUuBifYi3JWZaf1dWwU2yz+vqLhwJ95cmMucIygGHBbuQKqNjR9Eh+RdDT/7
         YD7LaYIBW781qwc/Pc1cDa3gF+jW8xojn2/X4T13I2JLOmRnAA5PpquFzNShlFpPgP/g
         dZyA==
X-Gm-Message-State: AJIora9PTHqz6s2lHyyaWgdGcTJab/okU7VT2n97UHS2wHiURsK4H0F+
        +dok1TZ6wPkJnT4A5UAatgK8Cg7lBViQd/ZezyRjF9ygk4wxkRsbb1Cf6cUtq5leJf3upIdgxTe
        dEokHGWIGU86qe3+hmByYGV7KAFkB
X-Received: by 2002:a17:90b:2249:b0:1ef:2097:8448 with SMTP id hk9-20020a17090b224900b001ef20978448mr4162964pjb.97.1657186956242;
        Thu, 07 Jul 2022 02:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vx385uLz6R6MIjDaU9j35k7VtJZpvs3rQMyTvkYkckrOkY/88nPGQnMd6CZpWdAovnFVFn6g==
X-Received: by 2002:a17:90b:2249:b0:1ef:2097:8448 with SMTP id hk9-20020a17090b224900b001ef20978448mr4162941pjb.97.1657186956013;
        Thu, 07 Jul 2022 02:42:36 -0700 (PDT)
Received: from localhost.localdomain (223-137-51-72.emome-ip.hinet.net. [223.137.51.72])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b0016230703ca3sm27085064pll.231.2022.07.07.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:42:35 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     memxor@gmail.com, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
        po-hsu.lin@canonical.com
Subject: [PATCH stable 5.15 1/1] Revert "selftests/bpf: Add test for bpf_timer overwriting crash"
Date:   Thu,  7 Jul 2022 17:42:07 +0800
Message-Id: <20220707094207.229875-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707094207.229875-1-po-hsu.lin@canonical.com>
References: <20220707094207.229875-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This reverts commit b0028e1cc1faf2e5d88ad4065590aca90d650182 which is
commit a7e75016a0753c24d6c995bc02501ae35368e333 upstream.

It will break the bpf self-tests build with:
progs/timer_crash.c:8:19: error: field has incomplete type 'struct bpf_timer'
        struct bpf_timer timer;
                         ^
/home/ubuntu/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:39:8:
note: forward declaration of 'struct bpf_timer'
struct bpf_timer;
       ^
1 error generated.

This test can only be built with 5.17 and newer kernels.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../testing/selftests/bpf/prog_tests/timer_crash.c | 32 -------------
 tools/testing/selftests/bpf/progs/timer_crash.c    | 54 ----------------------
 2 files changed, 86 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 delete mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
deleted file mode 100644
index f74b823..00000000
--- a/tools/testing/selftests/bpf/prog_tests/timer_crash.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <test_progs.h>
-#include "timer_crash.skel.h"
-
-enum {
-	MODE_ARRAY,
-	MODE_HASH,
-};
-
-static void test_timer_crash_mode(int mode)
-{
-	struct timer_crash *skel;
-
-	skel = timer_crash__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
-		return;
-	skel->bss->pid = getpid();
-	skel->bss->crash_map = mode;
-	if (!ASSERT_OK(timer_crash__attach(skel), "timer_crash__attach"))
-		goto end;
-	usleep(1);
-end:
-	timer_crash__destroy(skel);
-}
-
-void test_timer_crash(void)
-{
-	if (test__start_subtest("array"))
-		test_timer_crash_mode(MODE_ARRAY);
-	if (test__start_subtest("hash"))
-		test_timer_crash_mode(MODE_HASH);
-}
diff --git a/tools/testing/selftests/bpf/progs/timer_crash.c b/tools/testing/selftests/bpf/progs/timer_crash.c
deleted file mode 100644
index f8f7944..00000000
--- a/tools/testing/selftests/bpf/progs/timer_crash.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <vmlinux.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_helpers.h>
-
-struct map_elem {
-	struct bpf_timer timer;
-	struct bpf_spin_lock lock;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, int);
-	__type(value, struct map_elem);
-} amap SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(max_entries, 1);
-	__type(key, int);
-	__type(value, struct map_elem);
-} hmap SEC(".maps");
-
-int pid = 0;
-int crash_map = 0; /* 0 for amap, 1 for hmap */
-
-SEC("fentry/do_nanosleep")
-int sys_enter(void *ctx)
-{
-	struct map_elem *e, value = {};
-	void *map = crash_map ? (void *)&hmap : (void *)&amap;
-
-	if (bpf_get_current_task_btf()->tgid != pid)
-		return 0;
-
-	*(void **)&value = (void *)0xdeadcaf3;
-
-	bpf_map_update_elem(map, &(int){0}, &value, 0);
-	/* For array map, doing bpf_map_update_elem will do a
-	 * check_and_free_timer_in_array, which will trigger the crash if timer
-	 * pointer was overwritten, for hmap we need to use bpf_timer_cancel.
-	 */
-	if (crash_map == 1) {
-		e = bpf_map_lookup_elem(map, &(int){0});
-		if (!e)
-			return 0;
-		bpf_timer_cancel(&e->timer);
-	}
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-- 
2.7.4

