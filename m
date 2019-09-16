Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909E9B38BA
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2019 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfIPKyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Sep 2019 06:54:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43448 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfIPKyx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so11952607lfl.10
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2019 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qALJbnp9FTLPJAoGDKJIaiGyevgs6xsdVhuDmgFkzac=;
        b=Tp5OvP8rCaZb13D4ww3vj2mw2PWVAqGybOa6fUs/oIVw5T7/73Nqpmo57DltCqgBmW
         W/9ysUCIVjTtDUmMneoWsxRoIIm7/1ZmqNsLJ+HjEvvkOOIiQYjOkchVu5eqKs/Mqt1X
         VjfxITukqZHlV1t0Rqp7NNolwQVY8JYuqJ9aTg8QvAEanrhVhyRBlUtWCC2xv0LResJy
         TDMAy3NvtfKh5oTRrkwcPoMTpDX87g8TjD24bYIbVovX1/Wj9J6d5+Ri38Y1b0NWoLst
         CHjgzSYJCQAkhWGFdxr3rIBRjCkEgXHxMGQFp+nj7h4J2kMn6KpOxmGFCXE87IoRKeWc
         23Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qALJbnp9FTLPJAoGDKJIaiGyevgs6xsdVhuDmgFkzac=;
        b=SOD/uVgCSAy2r/LgXFmp/kp33mkfIHsREXKGbvLK5KedSc7N7I7dnHwUNKFSxvR8c+
         g/keS6wKDzZUbOX8u5BPQa4zBYUIxd7TUMv/Fo75ny1Tq3cUzmg5/ARCXTNoOaLTSYpi
         lrCbR9GAA5hfjO+mCoKoc+eRKewZV5VsPV+zVgFeMf763TBlC85hRQJ7cPIpYR84jFmA
         g3qRDrtdXyZZdES9WwttYysNyAuyOlxkp9f5TfLSIbWAzYVRq4LqkhFE/z99NtkteYpz
         0ohP5IqYvjEJ3aM+0wBWItga6ifO3OpCvWIotfZFeVtE3nJz0FiATe5XSHsXVexpJ0Ce
         3saw==
X-Gm-Message-State: APjAAAU/AqLYRsyC2DNsmlPFZQqnrVPBJn8+ohcTajZy6oPCOO/+kK3J
        OQ0Wdfcuss8dkAOA7+Z5RR1uxA==
X-Google-Smtp-Source: APXvYqzllcvzn3zCr2/UXmKKBqQnnGjipxHPlSqink4eIoGTL2UlV4EM6dmS/RiJ2HlREaZdmF9AnQ==
X-Received: by 2002:ac2:5451:: with SMTP id d17mr37030113lfn.77.1568631289427;
        Mon, 16 Sep 2019 03:54:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:48 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 07/14] samples: bpf: add makefile.target for separate CC target build
Date:   Mon, 16 Sep 2019 13:54:26 +0300
Message-Id: <20190916105433.11404-8-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The makefile.target is added only and will be used in
sample/bpf/Makefile later in order to switch cross-compiling on CC
from HOSTCC environment.

The HOSTCC is supposed to build binaries and tools running on the host
afterwards, in order to simplify build or so, like "fixdep" or else.
In case of cross compiling "fixdep" is executed on host when the rest
samples should run on target arch. In order to build binaries for
target arch with CC and tools running on host with HOSTCC, lets add
Makefile.target for simplicity, having definition and routines similar
to ones, used in script/Makefile.host. This allows later add
cross-compilation to samples/bpf with minimum changes.

The tprog stands for target programs built with CC.

Makefile.target contains only stuff needed for samples/bpf, potentially
can be reused later and now needed only for unblocking tricky
samples/bpf cross compilation.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile.target | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 samples/bpf/Makefile.target

diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
new file mode 100644
index 000000000000..fb6de63f7d2f
--- /dev/null
+++ b/samples/bpf/Makefile.target
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Building binaries on the host system
+# Binaries are not used during the compilation of the kernel, and intendent
+# to be build for target board, target board can be host ofc. Added to build
+# binaries to run not on host system.
+#
+# Sample syntax (see Documentation/kbuild/makefiles.rst for reference)
+# tprogs-y := xsk_example
+# Will compile xdpsock_example.c and create an executable named xsk_example
+#
+# tprogs-y    := xdpsock
+# xdpsock-objs := xdpsock_1.o xdpsock_2.o
+# Will compile xdpsock_1.c and xdpsock_2.c, and then link the executable
+# xdpsock, based on xdpsock_1.o and xdpsock_2.o
+#
+# Inherited from scripts/Makefile.host
+#
+__tprogs := $(sort $(tprogs-y))
+
+# C code
+# Executables compiled from a single .c file
+tprog-csingle	:= $(foreach m,$(__tprogs), \
+			$(if $($(m)-objs),,$(m)))
+
+# C executables linked based on several .o files
+tprog-cmulti	:= $(foreach m,$(__tprogs),\
+			$(if $($(m)-objs),$(m)))
+
+# Object (.o) files compiled from .c files
+tprog-cobjs	:= $(sort $(foreach m,$(__tprogs),$($(m)-objs)))
+
+tprog-csingle	:= $(addprefix $(obj)/,$(tprog-csingle))
+tprog-cmulti	:= $(addprefix $(obj)/,$(tprog-cmulti))
+tprog-cobjs	:= $(addprefix $(obj)/,$(tprog-cobjs))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+_tprogc_flags   = $(TPROGS_CFLAGS) \
+                 $(TPROGCFLAGS_$(basetarget).o)
+
+# $(objtree)/$(obj) for including generated headers from checkin source files
+ifeq ($(KBUILD_EXTMOD),)
+ifdef building_out_of_srctree
+_tprogc_flags   += -I $(objtree)/$(obj)
+endif
+endif
+
+tprogc_flags    = -Wp,-MD,$(depfile) $(_tprogc_flags)
+
+# Create executable from a single .c file
+# tprog-csingle -> Executable
+quiet_cmd_tprog-csingle 	= CC  $@
+      cmd_tprog-csingle	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ $< \
+		$(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-csingle)
+
+# Link an executable based on list of .o files, all plain c
+# tprog-cmulti -> executable
+quiet_cmd_tprog-cmulti	= LD  $@
+      cmd_tprog-cmulti	= $(CC) $(tprogc_flags) $(TPROGS_LDFLAGS) -o $@ \
+			  $(addprefix $(obj)/,$($(@F)-objs)) \
+			  $(TPROGS_LDLIBS) $(TPROGLDLIBS_$(@F))
+$(tprog-cmulti): $(tprog-cobjs) FORCE
+	$(call if_changed,tprog-cmulti)
+$(call multi_depend, $(tprog-cmulti), , -objs)
+
+# Create .o file from a single .c file
+# tprog-cobjs -> .o
+quiet_cmd_tprog-cobjs	= CC  $@
+      cmd_tprog-cobjs	= $(CC) $(tprogc_flags) -c -o $@ $<
+$(tprog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,tprog-cobjs)
-- 
2.17.1

