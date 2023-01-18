Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90404671306
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 06:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjARFOu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 00:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 00:14:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124453566
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:14:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id bj3so31448696pjb.0
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8/D5092a4xOxJolRW4uUp0myZM6QPOIkoBYsHrqjMA=;
        b=cqChL2W+PztnRWAZgDTJTZGe8+/oiBkQkhPtwBMjnXSQ9zpI5QfSH3cUd/6JujH9x0
         ianJhDc51IATjE/BNmWJ5/68m88YozdTE7KHrWQfmDV1feZjN8v1TF8t7509PkRnaywc
         6qgV1gbEuIrvdRwvsm4s9ZRaFHMOk2Pu7oZDLjXvMzxLHkcp7QwOR0c9B8bfqGXp+NMI
         bq0Ye2Gk7CLv+D3WY/WTZlW/lB0BcpiR1KWCIJRdBrrxTxi2hlw540oiY7KD7sgS4EfP
         ytJyMrrYueqngK3485LAdt2q4n8N04Eesjw+EyzL9o2WjgUWWP4wDk/0WEPMdMuySDn6
         /law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8/D5092a4xOxJolRW4uUp0myZM6QPOIkoBYsHrqjMA=;
        b=pTY9WsXLcBZd/s12oP5tziXR6nzgz4qU7bnwdvA0DfGDQDV6RPwDWA+6flPeJG5Y7S
         3TUTd58cxqbHCYsQeSVmHuoJ9o+6BHRUMtFUYIf5/RZXiqBq/hMARU3h/xkJwKpWMphd
         sQVaArwM1zj5GSZrbC+Ng9Sq3OLLHsMDfo/GzJRYjgxPRoYFODnmehSuOnJ/ekemTa7g
         Wgz0gxGFVqmDCjtX0X2Yih6onBepMaRZu2lbsXl0aiYZ/kb+WKsbbsytaTYuwfGzwGjo
         S28JmKGPo/02x0zXa4j604i1J8WiPeLeNWPfjUQ1qsdNJjGhEMViruaVTqYWGCKHdhEO
         cFTA==
X-Gm-Message-State: AFqh2koRxARRaYnt4aT/lic2/1+VOKcBh6nz6K+qdJsbHgG/Wc/qqTPo
        A84PAYp488JsMu89rsWLJzA=
X-Google-Smtp-Source: AMrXdXuBKPFbfvzu3ZfER8EMy8Syl9v6Atz8teUZso2YkHAXf7PZYTPYBve525fnro88MeE4vWwtgQ==
X-Received: by 2002:a05:6a21:3290:b0:af:76da:1462 with SMTP id yt16-20020a056a21329000b000af76da1462mr7748038pzb.40.1674018887372;
        Tue, 17 Jan 2023 21:14:47 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:194d])
        by smtp.gmail.com with ESMTPSA id c28-20020a056a00009c00b0058d9428e482sm5729498pfj.85.2023.01.17.21.14.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Jan 2023 21:14:46 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     torvalds@linuxfoundation.org
Cc:     x86@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, peterz@infradead.org, keescook@chromium.org,
        tglx@linutronix.de, hsinweih@uci.edu, rostedt@goodmis.org,
        vegard.nossum@oracle.com, gregkh@linuxfoundation.org,
        alan.maguire@oracle.com, dylany@meta.com, riel@surriel.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Date:   Tue, 17 Jan 2023 21:14:42 -0800
Message-Id: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

There are several issues with copy_from_user_nofault():

- access_ok() is designed for user context only and for that reason
it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
and perf on ppc are calling it from irq.

- it's missing nmi_uaccess_okay() which is a nop on all architectures
except x86 where it's required.
The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.

- __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Fix all three issues. At the end the copy_from_user_nofault() becomes
equivalent to copy_from_user_nmi() from safety point of view with
a difference in the return value.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/maccess.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index 074f6b086671..6ee9b337c501 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -113,11 +114,18 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	pagefault_disable();
+	instrument_copy_from_user_before(dst, src, size);
+	ret = raw_copy_from_user(dst, src, size);
+	instrument_copy_from_user_after(dst, src, size, ret);
+	pagefault_enable();
 
 	if (ret)
 		return -EFAULT;
-- 
2.30.2

