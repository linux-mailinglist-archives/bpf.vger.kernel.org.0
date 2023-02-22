Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAFE69ED1C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 03:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBVCyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 21:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVCyb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 21:54:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAE9E
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 18:54:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78401614C5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 02:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56648C433A4;
        Wed, 22 Feb 2023 02:50:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] BPF: Include missing nospec.h to avoid build error
Date:   Wed, 22 Feb 2023 10:50:48 +0800
Message-Id: <20230222025048.3677315-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 74e19ef0ff8061ef55957c3a ("uaccess: Add speculation barrier to
copy_from_user()") defines a default barrier_nospec() and removes the
#ifdefs in kernel/bpf/core.c, but doesn't include nospec.h, which causes
such a build error:

  CC      kernel/bpf/core.o
kernel/bpf/core.c: In function ‘___bpf_prog_run’:
kernel/bpf/core.c:1913:3: error: implicit declaration of function ‘barrier_nospec’; did you mean ‘barrier_data’? [-Werror=implicit-function-declaration]
   barrier_nospec();
   ^~~~~~~~~~~~~~
   barrier_data
cc1: some warnings being treated as errors

So include nospec.h to avoid the build error.

Fixes: 74e19ef0ff8061ef55957c3a ("uaccess: Add speculation barrier to copy_from_user()")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/bpf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 430c66d59ec7..f9c3b1033ec3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -34,6 +34,7 @@
 #include <linux/log2.h>
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
+#include <linux/nospec.h>
 #include <linux/bpf_mem_alloc.h>
 
 #include <asm/barrier.h>
-- 
2.39.1

