Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E030275A
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbhAYP5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 10:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhAYPu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 10:50:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5723C0613D6
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 07:49:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so15967098ede.0
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6S7l5/M/aqrhR1OKVK3Ws/37Xa2QWsuDw15rhL8k21s=;
        b=to4D4Irtd48CBO65BPxuP/KmE/riTHQuG70YBWDoatJ9tn1jx9mIuMAQDNywWaF8pc
         A2MzoRyF4nBoyBWKbA/UnQdgzpuo6DJy0Ye4hR9DWfzYSpmkLWolKBpJ54wQkmjn9QhR
         cIQpWgMlQJeVOGnsIjAI2iz8bs6oZyGFDF7/CT1ZFqbq4n6b3+fTw9SSJg6/LS5oIBs2
         BgDK69fi4mFQxt2N7KC1bkelk8FU6zulFpBMZrF9zj7TuSUtZ6sgOcfoUb2QvJYfOsdY
         yQK7UC6dJNodA34deZgWfmgxwcgM6y+hsNJKg30nLwDTYBe02wbvd7JmBy4jj1WaHHVH
         dIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6S7l5/M/aqrhR1OKVK3Ws/37Xa2QWsuDw15rhL8k21s=;
        b=UYE1WNsydub8CLZ9MqGgydlOQFRtGVk9aX4+MVhDL9IlqZA62Tfz57XMBaVlJVyX1H
         4doyPjlx8UOQix6gpqF2+wdOGWMY3h6122ZY+yZ1MvGlEVka6LVz1/5Y3fX9KBAreK3O
         4vQIAnsfNMZdMH5AWUQrSAa3/qAHwek99REB3l4vOm4MVa2XngJZDyZ0SjDF1bhGTU25
         hCk5u+kPYWHtxLVw8ZKHqBKwheFVD6oX4KusSEdqdACFVAjM7uH7sQHxT5EZp8+Gjmfe
         SNyVNQkKOwWBfcdK/1k+qT0U9tSzzIssD8n5N+wSAUTRej1K9nmZFa/xDsnbtwg2bLOy
         1IDQ==
X-Gm-Message-State: AOAM531bktcVHhphQsPP0X9BEvoj+xkmhThOLdFmMkHjjImSwl4n/4jQ
        IXMA7MxQS6uPNU5/PBdpHwUb2A==
X-Google-Smtp-Source: ABdhPJxdK+TuiH+8grJ813s4nVkAWJJ+XTod0fw/eE8ww21zxWan7mqojFnlWC0l2v1s3VA5hnD+QQ==
X-Received: by 2002:a05:6402:34e:: with SMTP id r14mr987625edw.269.1611589786421;
        Mon, 25 Jan 2021 07:49:46 -0800 (PST)
Received: from localhost.localdomain ([194.35.116.108])
        by smtp.gmail.com with ESMTPSA id t11sm6655816edd.1.2021.01.25.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:49:45 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH] bpf: fix build for BPF preload when $(O) points to a relative path
Date:   Mon, 25 Jan 2021 15:49:38 +0000
Message-Id: <20210125154938.40504-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building the kernel with CONFIG_BPF_PRELOAD, and by providing a relative
path for the output directory, may fail with the following error:

  $ make O=build bindeb-pkg
  ...
  /.../linux/tools/scripts/Makefile.include:5: *** O=build does not exist.  Stop.
  make[7]: *** [/.../linux/kernel/bpf/preload/Makefile:9: kernel/bpf/preload/libbpf.a] Error 2
  make[6]: *** [/.../linux/scripts/Makefile.build:500: kernel/bpf/preload] Error 2
  make[5]: *** [/.../linux/scripts/Makefile.build:500: kernel/bpf] Error 2
  make[4]: *** [/.../linux/Makefile:1799: kernel] Error 2
  make[4]: *** Waiting for unfinished jobs....

In the case above, for the "bindeb-pkg" target, the error is produced by
the "dummy" check in Makefile.include, called from libbpf's Makefile.
This check changes directory to $(PWD) before checking for the existence
of $(O). But at this step we have $(PWD) pointing to "/.../linux/build",
and $(O) pointing to "build". So the Makefile.include tries in fact to
assert the existence of a directory named "/.../linux/build/build",
which does not exist.

By contrast, other tools called from the main Linux Makefile get the
variable set to $(abspath $(objtree)), where $(objtree) is ".". We can
update the Makefile for kernel/bpf/preload to set $(O) to the same
value, to permit compiling with a relative path for output. Note that
apart from the Makefile.include, the variable $(O) is not used in
libbpf's build system.

Note that the error does not occur for all make targets and
architectures combinations.

- On x86, "make O=build vmlinux" appears to work fine.
  $(PWD) points to "/.../linux/tools", but $(O) points to the absolute
  path "/.../linux/build" and the test succeeds.
- On UML, it has been reported to fail with a message similar to the
  above (see [0]).
- On x86, "make O=build bindeb-pkg" fails, as described above.

It is unsure where the different values for $(O) and $(PWD) come from
(likely some recursive make with different arguments at some point), and
because several targets are broken, it feels safer to fix the $(O) value
passed to libbpf rather than to hunt down all changes to the variable.

David Gow previously posted a slightly different version of this patch
as a RFC [0], two months ago or so.

[0] https://lore.kernel.org/bpf/20201119085022.3606135-1-davidgow@google.com/t/#u

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>
Reported-by: David Gow <davidgow@google.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 kernel/bpf/preload/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 23ee310b6eb4..11b9896424c0 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -4,8 +4,11 @@ LIBBPF_SRCS = $(srctree)/tools/lib/bpf/
 LIBBPF_A = $(obj)/libbpf.a
 LIBBPF_OUT = $(abspath $(obj))
 
+# Set $(O) so that the "dummy" test in tools/scripts/Makefile.include, called
+# by libbpf's Makefile, succeeds when building the kernel with $(O) pointing to
+# a relative path, as in "make O=build bindeb-pkg".
 $(LIBBPF_A):
-	$(Q)$(MAKE) -C $(LIBBPF_SRCS) OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
+	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(abspath .) OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
 
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
 	-I $(srctree)/tools/lib/ -Wno-unused-result
-- 
2.25.1

