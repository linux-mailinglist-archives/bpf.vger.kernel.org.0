Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1151C922B
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfJBTRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 15:17:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36021 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBTRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 15:17:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so207733edn.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oGOfktdveo5ZtuoH4C6yPHNIwcTv3+DyM2wCB4zh4U=;
        b=dAo0QIHTfhTRnlYtaeL9gFzX3qDzreXEhE4rf+FJms1XQb84amNAa8vp3so/P0rIps
         KN84SQ3T51eDvLkMPS8292geBjpXywMAmzx7uOca+jx9ndkr9cbGzz/16GXRurF3Dp6o
         dsodWB+N7/WQ/Jyv3/I1NxxsGTV5AUsJZqCBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oGOfktdveo5ZtuoH4C6yPHNIwcTv3+DyM2wCB4zh4U=;
        b=C9qdW/NYeCkoL0eLTOkL+6q6t+ZOxDHrRq8wLctvARvQ3a8z5i2RQho5r7qAsw+Tk8
         2aPm5SUxOruKozBE/i8g38KyyrRlkKd7hlRTFsOkdDm2imYEM9fJYcOgcQfbzjyJuH+T
         DPT8b/L10JUGeWkAaeUJdFtJyLYeUcXeO3ZefbF/qJHlc4eZZKKHOh8SAPMJkotJZeTi
         bGMpJJed1OXtqP1ft0irjmKCa21spUbImU2QQ5Q05gfheWVEY3ia+jezMJPVUAv9MK/B
         wdxR21Z+VGuxPoGksEJbQnlmiA/ePZaNhec/emDp10Q4+GsczDMQl3j0JCD9Ij+gPk/p
         xvPw==
X-Gm-Message-State: APjAAAUoNUAzzjC2uVB14ZJE5BCSuMqOhirQ2ThphkExZ4V0TCpmYLey
        UqSIvCHezwg0mFIOISN9IJCKzw==
X-Google-Smtp-Source: APXvYqxc21q3xZdpLrf1tkXfKo6ihP3vYlwZE7tC9X2U0uFDnrfeLpnWv9df3JAOYj1FrucG4bfITw==
X-Received: by 2002:a17:906:1394:: with SMTP id f20mr4650214ejc.274.1570043829050;
        Wed, 02 Oct 2019 12:17:09 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id p19sm7996edq.31.2019.10.02.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:17:08 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2] samples/bpf: Add a workaround for asm_inline
Date:   Wed,  2 Oct 2019 21:16:52 +0200
Message-Id: <20191002191652.11432-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This was added in:

  commit eb111869301e ("compiler-types.h: add asm_inline definition")

and breaks samples/bpf as clang does not support asm __inline.

Co-developed-by: Florent Revest <revest@google.com>
Signed-off-by: Florent Revest <revest@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---

Changes since v1:

- Dropped the rename from asm_workaround.h to asm_goto_workaround.h
- Dropped the fix for task_fd_query_user.c as it is updated in
  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/

 samples/bpf/asm_goto_workaround.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
index 7409722727ca..7048bb3594d6 100644
--- a/samples/bpf/asm_goto_workaround.h
+++ b/samples/bpf/asm_goto_workaround.h
@@ -3,7 +3,8 @@
 #ifndef __ASM_GOTO_WORKAROUND_H
 #define __ASM_GOTO_WORKAROUND_H
 
-/* this will bring in asm_volatile_goto macro definition
+/*
+ * This will bring in asm_volatile_goto and asm_inline macro definitions
  * if enabled by compiler and config options.
  */
 #include <linux/types.h>
@@ -13,5 +14,15 @@
 #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
 #endif
 
+/*
+ * asm_inline is defined as asm __inline in "include/linux/compiler_types.h"
+ * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which is not
+ * supported by CLANG.
+ */
+#ifdef asm_inline
+#undef asm_inline
+#define asm_inline asm
+#endif
+
 #define volatile(x...) volatile("")
 #endif
-- 
2.20.1

