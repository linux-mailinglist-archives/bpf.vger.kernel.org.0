Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4566AE85D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406052AbfIJKiu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 06:38:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38057 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436519AbfIJKit (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so13028234lfh.5
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxZ/+fqqCuVj1pULMKRHJJXa1zIHgEU0C4IiN6cmJWE=;
        b=KB7YHJmYJoMM4nqzRtlQbzNwWev5PHKeBldEwrvgPRLnEWN5lqWj+oIUQhxh9maD/y
         JvU/MvDwKEpJCLZYjXvI2kN9KxUUDOZvl4ITYgSokrM1Xe2KiAY4Fp56VGVQgdB1jpjI
         oTuNyZykUQmT05ei/x4WOmPeDa6Yq6trQKbJS9CjANuwL7G5912LFVrbFAy+ILt6Z6gZ
         u2C8OUf/QxFGYRKl4dQW5wY+OYGHR2f7ZD+vcbt6Y/eBVh7Z7suN1lsDeTYZvQWeDacM
         VsgQJ5yqaAUV8gRmywLm96Nm3lZ9/tCqgOM7A0nX/WkA43ZkIJA9qnPcK8b4y0UuhnXa
         YynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxZ/+fqqCuVj1pULMKRHJJXa1zIHgEU0C4IiN6cmJWE=;
        b=N/PD1i/p0Yu+5gHR4d378auQgqCECl6BRWCdiFAbPD7Vyrw/xZvYH5SPTBnLtZ5xbU
         r4zWKlLPVUq3ORt/JX6rZIKRMDW3Cw0XqMLRL7ekp2+1G+wIMqlFOnYsJbKGTbf3MAP7
         2PlZmoiXeMS5Nx9vv75bN9YlB3EC5fndZmUx6u0TPzs9bOys69VH32t+M3nDDgd6kd6C
         v4CIstkubGzJypVoBGf5s3rgJ6VgQM3DY1n41oDZc8Pyn3AiuApQdZ4DH/NJUhsYa9YF
         qgffEIBGNNQhwtUDZyz2MvF8p6uNI6cSB8DcEQfxI2+oKKUWWTXrHifiB2geMdSFp5vG
         kS4Q==
X-Gm-Message-State: APjAAAWg8qlIm5MZ3iTDnQOq6lOjcO0WvNgc0ZdSO7eMHcBz//dT0FEl
        d85f6nR8GPA/n30gB7nhmk1I2g==
X-Google-Smtp-Source: APXvYqw4GEkAqqrTyy9g3EIQL64fDIgPubYQnwrN9dOBxHx51FX5t+bz9Vl1qAudasJqCUcMuTka8g==
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr1193865lfm.105.1568111926190;
        Tue, 10 Sep 2019 03:38:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:45 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 07/11] samples: bpf: add makefile.prog for separate CC build
Date:   Tue, 10 Sep 2019 13:38:26 +0300
Message-Id: <20190910103830.20794-8-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The makefile.prog is added only, will be used in sample/bpf/Makefile
later in order to switch cross-compiling on CC from HOSTCC.

The HOSTCC is supposed to build binaries and tools running on the host
afterwards, in order to simplify build or so, like "fixdep" or else.
In case of cross compiling "fixdep" is executed on host when the rest
samples should run on target arch. In order to build binaries for
target arch with CC and tools running on host with HOSTCC, lets add
Makefile.prog for simplicity, having definition and routines similar
to ones, used in script/Makefile.host. This allows later add
cross-compilation to samples/bpf with minimum changes.

Makefile.prog contains only stuff needed for samples/bpf, potentially
can be reused and extended for other prog sets later and now needed
only for unblocking tricky samples/bpf cross compilation.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile.prog | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 samples/bpf/Makefile.prog

diff --git a/samples/bpf/Makefile.prog b/samples/bpf/Makefile.prog
new file mode 100644
index 000000000000..3781999b9193
--- /dev/null
+++ b/samples/bpf/Makefile.prog
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are not used during the compilation of the kernel, and intendent
+# to be build for target board, target board can be host ofc. Added to build
+# binaries to run not on host system.
+#
+# Only C is supported, but can be extended for C++.
+#
+# Sample syntax (see Documentation/kbuild/makefiles.rst for reference)
+# progs-y := xsk_example
+# Will compile xdpsock_example.c and create an executable named xsk_example
+#
+# progs-y    := xdpsock
+# xdpsock-objs := xdpsock_1.o xdpsock_2.o
+# Will compile xdpsock_1.c and xdpsock_2.c, and then link the executable
+# xdpsock, based on xdpsock_1.o and xdpsock_2.o
+#
+# Inherited from scripts/Makefile.host
+#
+__progs := $(sort $(progs-y))
+
+# C code
+# Executables compiled from a single .c file
+prog-csingle	:= $(foreach m,$(__progs), \
+			$(if $($(m)-objs)$($(m)-cxxobjs),,$(m)))
+
+# C executables linked based on several .o files
+prog-cmulti	:= $(foreach m,$(__progs),\
+		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
+
+# Object (.o) files compiled from .c files
+prog-cobjs	:= $(sort $(foreach m,$(__progs),$($(m)-objs)))
+
+prog-csingle	:= $(addprefix $(obj)/,$(prog-csingle))
+prog-cmulti	:= $(addprefix $(obj)/,$(prog-cmulti))
+prog-cobjs	:= $(addprefix $(obj)/,$(prog-cobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_progc_flags   = $(PROGS_CFLAGS) \
+                 $(PROGCFLAGS_$(basetarget).o)
+
+# $(objtree)/$(obj) for including generated headers from checkin source files
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
+_progc_flags   += -I $(objtree)/$(obj)
+endif
+endif
+
+progc_flags    = -Wp,-MD,$(depfile) $(_progc_flags)
+
+# Create executable from a single .c file
+# prog-csingle -> Executable
+quiet_cmd_prog-csingle 	= CC  $@
+      cmd_prog-csingle	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ $< \
+		$(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
+$(prog-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,prog-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# prog-cmulti -> executable
+quiet_cmd_prog-cmulti	= LD  $@
+      cmd_prog-cmulti	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
+$(prog-cmulti): $(prog-cobjs) FORCE
+	$(call if_changed,prog-cmulti)
+$(call multi_depend, $(prog-cmulti), , -objs)
+
+# Create .o file from a single .c file
+# prog-cobjs -> .o
+quiet_cmd_prog-cobjs	= CC  $@
+      cmd_prog-cobjs	= $(CC) $(progc_flags) -c -o $@ $<
+$(prog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,prog-cobjs)
-- 
2.17.1

