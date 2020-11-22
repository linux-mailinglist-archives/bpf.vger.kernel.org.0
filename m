Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62BB2BC326
	for <lists+bpf@lfdr.de>; Sun, 22 Nov 2020 03:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKVCWp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Nov 2020 21:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKVCWp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Nov 2020 21:22:45 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD354C0613CF
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 18:22:44 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id e10so2787563qte.4
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2020 18:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sOOhQuJTCs7M9k//3ZDXBQCl6X/YpKX3+cMRPKXlIU=;
        b=gtvbwX8FROQQXxtQ55EAJGhKHnC0M3I036JykWK0ATmdusaGPm9tMsalKt57iWuj5k
         6R9jPlxE8Y+AUsqiWr3QeBeSwWZkwk2894fbzL4UnWMmIBs8+MHZbYqMplhQgFG9+tse
         wiUm5iCoUr/XDKu8VvWE20qLY+zcQNjFfRF9XVaObLCaqu11nha4rH0MgNyEhYFaUTet
         iQ9jY1ngi3OUVxhz22wlj8KumIXDXAs/a7o3A50g4G46J8IeRi08qoE3JoK/FTztXilU
         1960OsMEg76O/0YE/UTm61fY5IueNEMWuouvXWwEsMlePbIYZAWC2qbqIi6yBS7eunGr
         boyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sOOhQuJTCs7M9k//3ZDXBQCl6X/YpKX3+cMRPKXlIU=;
        b=TniMA/+lUblv43mwavVqpTHbayR3muRomSfEIU1CXtD9g3qTSA8jE9btDdKtTuZTQJ
         O0Z5QG4DKGC7nMG9EoX3YcfvwE9PKlKWlHxrFUyUCKAy5qkbCFyOD92TgWr+s/Ty5YWe
         WymWrSgSwIXqyQ42ikM8wO4n+wdLCW57m/0wSwaZV3BJ5rCIRcADicOouIhBBh3nj6+l
         JZub85uqAgrFhmDEZmlhfLY39fx56gQJfk3FJeucztCQ6qcJ45oGJs03WjQdIZeeP4w4
         vv5rF1xPGT4Ufp5K4hCApQzDp9b7ctZhUazbyB9uJ3f+5wH9wDU8i0kWB75KLSC9R2ry
         Fj+A==
X-Gm-Message-State: AOAM530BzGSpBvbO5eArzxKl1+e3ykDY8kIgL7tmBucg0fnU1018zNOr
        VWlYG32Rb5TPW8UVVIN7OOfspeij9S+bEA==
X-Google-Smtp-Source: ABdhPJzqrjAV5C9p8s80JdZfWO2g45QosFvIoI5WPQ65I1IpxkiU6cYA9Vufvz5AtsCVJF3rKmb82Q==
X-Received: by 2002:a05:622a:1:: with SMTP id x1mr22479761qtw.229.1606011763696;
        Sat, 21 Nov 2020 18:22:43 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id r89sm5443234qtd.16.2020.11.21.18.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 18:22:43 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next 2/2] selftest/bpf: fix rst formatting in readme
Date:   Sat, 21 Nov 2020 21:22:05 -0500
Message-Id: <20201122022205.57229-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201122022205.57229-1-andreimatei1@gmail.com>
References: <20201122022205.57229-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A couple of places in the readme had invalid rst formatting causing the
rendering to be off. This patch fixes them with minimal edits.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/README.rst | 28 ++++++++++++++------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 3b8d8885892d..ca064180d4d0 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -33,11 +33,12 @@ The verifier will reject such code with above error.
 At insn 18 the r7 is indeed unbounded. The later insn 19 checks the bounds and
 the insn 20 undoes map_value addition. It is currently impossible for the
 verifier to understand such speculative pointer arithmetic.
-Hence
-    https://reviews.llvm.org/D85570
-addresses it on the compiler side. It was committed on llvm 12.
+Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
+
+__ https://reviews.llvm.org/D85570
 
 The corresponding C code
+
 .. code-block:: c
 
   for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
@@ -80,10 +81,11 @@ The symptom for ``bpf_iter/netlink`` looks like
   17: (7b) *(u64 *)(r7 +0) = r2
   only read is supported
 
-This is due to a llvm BPF backend bug. The fix 
-  https://reviews.llvm.org/D78466
+This is due to a llvm BPF backend bug. `The fix`__
 has been pushed to llvm 10.x release branch and will be
-available in 10.0.1. The fix is available in llvm 11.0.0 trunk.
+available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
+
+__  https://reviews.llvm.org/D78466
 
 BPF CO-RE-based tests and Clang version
 =======================================
@@ -97,11 +99,11 @@ them to Clang/LLVM. These sub-tests are going to be skipped if Clang is too
 old to support them, they shouldn't cause build failures or runtime test
 failures:
 
-  - __builtin_btf_type_id() ([0], [1], [2]);
-  - __builtin_preserve_type_info(), __builtin_preserve_enum_value() ([3], [4]).
+- __builtin_btf_type_id() [0_, 1_, 2_];
+- __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
 
-  [0] https://reviews.llvm.org/D74572
-  [1] https://reviews.llvm.org/D74668
-  [2] https://reviews.llvm.org/D85174
-  [3] https://reviews.llvm.org/D83878
-  [4] https://reviews.llvm.org/D83242
+.. _0: https://reviews.llvm.org/D74572
+.. _1: https://reviews.llvm.org/D74668
+.. _2: https://reviews.llvm.org/D85174
+.. _3: https://reviews.llvm.org/D83878
+.. _4: https://reviews.llvm.org/D83242
-- 
2.27.0

