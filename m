Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F16381ABE
	for <lists+bpf@lfdr.de>; Sat, 15 May 2021 21:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhEOTQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 May 2021 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhEOTQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 May 2021 15:16:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724FC061573;
        Sat, 15 May 2021 12:14:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so1348491wmq.0;
        Sat, 15 May 2021 12:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJn8OLt3IO4fEY1K9QKVHH3DD9itvCeE3GbuXkd/JuU=;
        b=DKUVZAnQBsWs8Wc+t00iL+3/rzly0Y6QL4rKT8imRwcSEDVglNOFs86pWZ/IGr+dDN
         qEhqiQdJa1s24ZDm9/UvdS8uLXUBpkoV98AFR2E2I7NdGGgQfNyRXYT8YPDtcoNA6t+s
         H8nRLCd+qbICn3fZYEW9XbiilOTctmmQnTgMhmsxElMeixZTgNTDITGBIn3vMbbbebFE
         G+spQBlPlDcP14tPCBGkXUkjTrHVMTeQMriZKkz71/1yoWZQXv15tHqG5YekuEVOWQ9P
         /c+P+hmkGBVBq/tnGn2J5QshLGy+EZNHsPlAfA5HIhEozqv8lBS8S/rQi8Ys8/rC8E74
         5JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJn8OLt3IO4fEY1K9QKVHH3DD9itvCeE3GbuXkd/JuU=;
        b=j/eDEs1GRiUblMnrfPA36CZhwCdJGj8K+OGM978HK9hermbM+e6GivTVEMFpCLLHv4
         o0Dp5Sx6oLiKLCVwQthWKdzdTJxTExuSqqnd0s7jp7YYXAqpFWsdfOa4aM+gk9bJ5tn6
         IdqAIW43iMksZUQ74Er4bwVB9gcOMQ+7LWPDSVIMhV1RZ3pKXRRdTkLqIKAD83ig9o6C
         xafS+i6v200qK5Cot5SzWzlnKdYhTwPpT1SE+pmQgBrxMNHX3qT16f/X+QtPU0erS31p
         qaEKfznX/Ijm9yZjwj50IUjopuGsE9ilxc0REaj6+Z8RR1vlBJJ7dAPY01EMjADlxilD
         cTUA==
X-Gm-Message-State: AOAM532HZx0jIYuOqy6bAFOPEk3xLsNRaz8V6bRaSZ3jFAy+cRiEAUAl
        GClTRC6HsRywpPf/vgozMkiE+xOFMVbuuw==
X-Google-Smtp-Source: ABdhPJy+Xc6eEjjEFreY9VQ/eiIV1iuOBVIfxT2/z7JQwxcvifYf/rDyMdxd3s4HgQTJdKHlFwScYw==
X-Received: by 2002:a1c:1f90:: with SMTP id f138mr3349239wmf.123.1621106095093;
        Sat, 15 May 2021 12:14:55 -0700 (PDT)
Received: from localhost.localdomain ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id y20sm3274761wmi.0.2021.05.15.12.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 12:14:54 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3] bpf.2: Use standard types and attributes
Date:   Sat, 15 May 2021 21:01:18 +0200
Message-Id: <20210515190116.188362-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
References: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some manual pages are already using C99 syntax for integral
types 'uint32_t', but some aren't.  There are some using kernel
syntax '__u32'.  Fix those.

Both the kernel and the standard types are 100% binary compatible,
and the source code differences between them are very small, and
not important in a manual page:

- Some of them are implemented with different underlying types
  (e.g., s64 is always long long, while int64_t may be long long
  or long, depending on the arch).  This causes the following
  differences.

- length modifiers required by printf are different, resulting in
  a warning ('-Wformat=').

- pointer assignment causes a warning:
  ('-Wincompatible-pointer-types'), but there aren't any pointers
  in this page.

But, AFAIK, all of those warnings can be safely ignored, due to
the binary compatibility between the types.

...

Some pages also document attributes, using GNU syntax
'__attribute__((xxx))'.  Update those to use the shorter and more
portable C11 keywords such as 'alignas()' when possible, and C2x
syntax '[[gnu::xxx]]' elsewhere, which hasn't been standardized
yet, but is already implemented in GCC, and available through
either --std=c2x or any of the --std=gnu... options.

The standard isn't very clear on how to use alignas() or
[[]]-style attributes, and the GNU documentation isn't better, so
the following link is a useful experiment about the different
alignment syntaxes:
__attribute__((aligned())), alignas(), and [[gnu::aligned()]]:
<https://stackoverflow.com/q/67271825/6872717>

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Nacked-by: Alexei Starovoitov <ast@kernel.org>
Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Zack Weinberg <zackw@panix.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: glibc <libc-alpha@sourceware.org>
Cc: GCC <gcc-patches@gcc.gnu.org>
Cc: bpf <bpf@vger.kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Joseph Myers <joseph@codesourcery.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
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

