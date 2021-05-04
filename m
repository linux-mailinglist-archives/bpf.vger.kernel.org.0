Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF79C372967
	for <lists+bpf@lfdr.de>; Tue,  4 May 2021 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhEDLGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 May 2021 07:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEDLGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 May 2021 07:06:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01BC061574;
        Tue,  4 May 2021 04:05:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x5so8889332wrv.13;
        Tue, 04 May 2021 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBexOv/slXZrUqoBk/6dME5LyTQkC5h8UHzK8vFSGV0=;
        b=bGw0TUolt0fr1Mj/tO4Z5l3OL2UgcNPGr5SjtE9TQZdOFF6P1HHwvvcuDxmHzR7TWH
         25W1zF8pIkB+Tkn8NFWnS2mumdQfeYiE83ef8+GV09LsjFxmkE2Ypc8k4c+PhM6xSDea
         ffdmjvsvJeyiPxeZb9Zg9sGhG/JnI2i+vsv8mFYq5UiDBfSSBqccXMb7ItNFnzrb3BOB
         CES3h4j4wznLfngqRZpc0k5hOcRV0bOLLgaqhE347rqF/49d06QkPgD559LR1boDmBSz
         V5Z5KTrUAtDbV99yQXkpEBJyT7Gjc/EwVTm3iwwIKtDJtAocjgFSXqsEfZwT11+TDXgq
         bBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBexOv/slXZrUqoBk/6dME5LyTQkC5h8UHzK8vFSGV0=;
        b=TAbQojzZrSrbHGTKYjv/6YgN9gW60wHp38iERkT3YBuJ04AfTkBwO/HfZ9piQMaVs7
         cnn697ZiiF6HMhZHSVGbd9dN15UOncjpyLrJQj+9QYisM0n8+hXWsDKbAFEsuWd8sq3V
         G/8p+elDyDkmrbvgLYEJ44yb3iTDahXgG1yrl+HVMRzrFqy3djWJDhlLxQqxBlYMLjhY
         c7MVaNaBv1SWBAXRR+QTzk7PNRTpWRjl/WHEG2Qc6fR945QHfAyk0wo6cHU49JJBpKnK
         ZlaiXsgjbXlBP3UIX3g6vx+uzs+oSb6v3tN97PqukYVIhIjOUadCzuJmLy5eCalQ967b
         mAEQ==
X-Gm-Message-State: AOAM530rrNWNMn+vOxL1aG1g8ceG0xFsrKJ2UvB4en6mvaCJGmP00ngR
        ah5M1/WzP6r5UUyJA1sXBfM=
X-Google-Smtp-Source: ABdhPJw47QkoJpJSP1YPM0MC+fPhs/05hHrWzAdxeUw5qEExJJXq+uqU1z5Qjad2cZ6BA+EyTVcMTw==
X-Received: by 2002:adf:e811:: with SMTP id o17mr14669020wrm.71.1620126344302;
        Tue, 04 May 2021 04:05:44 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id o17sm16769939wrs.48.2021.05.04.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:05:43 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Zack Weinberg <zackw@panix.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: [RFC v2] bpf.2: Use standard types and attributes
Date:   Tue,  4 May 2021 13:05:20 +0200
Message-Id: <20210504110519.16097-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423230609.13519-1-alx.manpages@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some manual pages are already using C99 syntax for integral
types 'uint32_t', but some aren't.  There are some using kernel
syntax '__u32'.  Fix those.

Some pages also document attributes, using GNU syntax
'__attribute__((xxx))'.  Update those to use the shorter and more
portable C11 keywords such as 'alignas()' when possible, and C2x
syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
yet, but is already implemented in GCC, and available through
either --std=c2x or any of the --std=gnu... options.

The standard isn't very clear on how to use alignas() or
[[]]-style attributes, so the following link is useful in the case
of 'alignas()' and '[[gnu::aligned()]]':
<https://stackoverflow.com/q/67271825/6872717>

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: glibc <libc-alpha@sourceware.org>
Cc: GCC <gcc-patches@gcc.gnu.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Zack Weinberg <zackw@panix.com>
Cc: Joseph Myers <joseph@codesourcery.com>
---
 man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/man2/bpf.2 b/man2/bpf.2
index 6e1ffa198..04b8fbcef 100644
--- a/man2/bpf.2
+++ b/man2/bpf.2
@@ -186,41 +186,40 @@ commands:
 .PP
 .in +4n
 .EX
-union bpf_attr {
+union [[gnu::aligned(8)]] bpf_attr {
     struct {    /* Used by BPF_MAP_CREATE */
-        __u32         map_type;
-        __u32         key_size;    /* size of key in bytes */
-        __u32         value_size;  /* size of value in bytes */
-        __u32         max_entries; /* maximum number of entries
-                                      in a map */
+        uint32_t    map_type;
+        uint32_t    key_size;    /* size of key in bytes */
+        uint32_t    value_size;  /* size of value in bytes */
+        uint32_t    max_entries; /* maximum number of entries
+                                    in a map */
     };
 
-    struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY
-                   commands */
-        __u32         map_fd;
-        __aligned_u64 key;
+    struct {    /* Used by BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY commands */
+        uint32_t            map_fd;
+        uint64_t alignas(8) key;
         union {
-            __aligned_u64 value;
-            __aligned_u64 next_key;
+            uint64_t alignas(8) value;
+            uint64_t alignas(8) next_key;
         };
-        __u64         flags;
+        uint64_t            flags;
     };
 
     struct {    /* Used by BPF_PROG_LOAD */
-        __u32         prog_type;
-        __u32         insn_cnt;
-        __aligned_u64 insns;      /* \(aqconst struct bpf_insn *\(aq */
-        __aligned_u64 license;    /* \(aqconst char *\(aq */
-        __u32         log_level;  /* verbosity level of verifier */
-        __u32         log_size;   /* size of user buffer */
-        __aligned_u64 log_buf;    /* user supplied \(aqchar *\(aq
-                                     buffer */
-        __u32         kern_version;
-                                  /* checked when prog_type=kprobe
-                                     (since Linux 4.1) */
+        uint32_t            prog_type;
+        uint32_t            insn_cnt;
+        uint64_t alignas(8) insns;     /* \(aqconst struct bpf_insn *\(aq */
+        uint64_t alignas(8) license;   /* \(aqconst char *\(aq */
+        uint32_t            log_level; /* verbosity level of verifier */
+        uint32_t            log_size;  /* size of user buffer */
+        uint64_t alignas(8) log_buf;   /* user supplied \(aqchar *\(aq
+                                          buffer */
+        uint32_t            kern_version;
+                                       /* checked when prog_type=kprobe
+                                          (since Linux 4.1) */
 .\"                 commit 2541517c32be2531e0da59dfd7efc1ce844644f5
     };
-} __attribute__((aligned(8)));
+};
 .EE
 .in
 .\"
-- 
2.31.1

