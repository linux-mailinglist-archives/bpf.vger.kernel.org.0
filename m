Return-Path: <bpf+bounces-3224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3BA73AE7B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C491C20E00
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AC38C;
	Fri, 23 Jun 2023 02:09:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0694363
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 02:09:14 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C22123
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 19:09:11 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b5035b777aso642745ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687486151; x=1690078151;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uvgXww1Qf74lNzjlCHWc+P1vwe+X39XJAF61OeI3UKk=;
        b=sTP3EWhAM0NAiETpUM+CXYen5eQJQze390CCpnjpzzEva24jg8wlv/3Qk0256MH6i4
         1NTLOHT53FBtMT16jfw5XfXPBEoav4BActohOXmH0I0znSlWug2x5MXxOT1T6aAzMpK6
         mmCeWiZoIAPC+jB1Ho/wQsDOcvJpwFChB7BZaAotb518Sp2fNftzGyf9wbhFiGTbHGRK
         E14Nm2eHMIvVb3bljw3EcnZa+C5SzQ0uWutbkiVVd/0E9RHcyaQAHOwCGfHArOIgnGqA
         ofUOFl+MCNTlcx8fy2IL+wk1t7WWh4YHBxulcykqTxezekNbXTfpiGesnoiUWc4I33S2
         xXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687486151; x=1690078151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvgXww1Qf74lNzjlCHWc+P1vwe+X39XJAF61OeI3UKk=;
        b=REv1yJXGbShEaqjl4Y58LS/glqghdxqNkNkqPI1bY2GuOwlDOpRbFG+ajyW0OBNmR8
         bqkv21czYNvGjQWm66klXxgznnw95555dsxSfLr4qEIKkEI4D7XDqimCwtBIxmVakntV
         g7xn5bHmvCbPpbrt0sQN9HmX2ERFPMFPymA3e8AlVg+9xD0oBGMbHd13U5n4Gcm0xPl/
         VH//zsNzUBeibzG4jTrchIr5htJBXP2d75XZke1Xh6k9N7+xkA1zziLbGfH9CJclGdCf
         AgfEI+RhxtaNRSgNcbHm48Mju8cXCZrhgnhp+InIOeXXJHxOqot4HSK+XLV+2d68Huya
         bJnA==
X-Gm-Message-State: AC+VfDxQqWrhJfkqak0bDTjXqtBYyQOh+eoDN+vxcRPwVZkuH4YgqVB/
	xlD+PR0tvPl7jO1z0XIj+Xu8DGYNi65J
X-Google-Smtp-Source: ACHHUZ7/BcaBiHhJZNge9fOBFPFdm6aO3oUnGq3Cc8bMtWgpz7y4TGt1AXF/Xq1GK18GJK+3ztG8PWkP6U8W
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a17:902:efd5:b0:1b1:e9c0:4625 with SMTP id
 ja21-20020a170902efd500b001b1e9c04625mr3099011plb.10.1687486151113; Thu, 22
 Jun 2023 19:09:11 -0700 (PDT)
Date: Fri, 23 Jun 2023 02:09:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20230623020908.1410959-1-maskray@google.com>
Subject: [PATCH] bpf: Replace deprecated -target with --target= for Clang
From: Fangrui Song <maskray@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

-target has been deprecated since Clang 3.4 in 2013. Use the preferred
--target=bpf form instead. This matches how we use --target= in
scripts/Makefile.clang.

Signed-off-by: Fangrui Song <maskray@google.com>
---
 Documentation/bpf/bpf_devel_QA.rst              | 10 +++++-----
 Documentation/bpf/btf.rst                       |  4 ++--
 Documentation/bpf/llvm_reloc.rst                |  6 +++---
 drivers/hid/bpf/entrypoints/Makefile            |  2 +-
 kernel/bpf/preload/iterators/Makefile           |  2 +-
 samples/bpf/Makefile                            |  6 +++---
 samples/bpf/gnu/stubs.h                         |  3 ++-
 samples/bpf/test_lwt_bpf.sh                     |  2 +-
 samples/hid/Makefile                            |  6 +++---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++--
 tools/bpf/bpftool/Makefile                      |  2 +-
 tools/bpf/runqslower/Makefile                   |  2 +-
 tools/build/feature/Makefile                    |  2 +-
 tools/perf/Documentation/perf-config.txt        |  2 +-
 tools/perf/Makefile.perf                        |  4 ++--
 tools/perf/util/llvm-utils.c                    |  4 ++--
 tools/testing/selftests/bpf/Makefile            |  6 +++---
 tools/testing/selftests/bpf/gnu/stubs.h         |  3 ++-
 tools/testing/selftests/hid/Makefile            |  6 +++---
 tools/testing/selftests/net/Makefile            |  4 ++--
 tools/testing/selftests/tc-testing/Makefile     |  2 +-
 21 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 609b71f5747d..de27e1620821 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -635,12 +635,12 @@ test coverage.
 
 Q: clang flag for target bpf?
 -----------------------------
-Q: In some cases clang flag ``-target bpf`` is used but in other cases the
+Q: In some cases clang flag ``--target=bpf`` is used but in other cases the
 default clang target, which matches the underlying architecture, is used.
 What is the difference and when I should use which?
 
 A: Although LLVM IR generation and optimization try to stay architecture
-independent, ``-target <arch>`` still has some impact on generated code:
+independent, ``--target=<arch>`` still has some impact on generated code:
 
 - BPF program may recursively include header file(s) with file scope
   inline assembly codes. The default target can handle this well,
@@ -658,7 +658,7 @@ independent, ``-target <arch>`` still has some impact on generated code:
   The clang option ``-fno-jump-tables`` can be used to disable
   switch table generation.
 
-- For clang ``-target bpf``, it is guaranteed that pointer or long /
+- For clang ``--target=bpf``, it is guaranteed that pointer or long /
   unsigned long types will always have a width of 64 bit, no matter
   whether underlying clang binary or default target (or kernel) is
   32 bit. However, when native clang target is used, then it will
@@ -668,7 +668,7 @@ independent, ``-target <arch>`` still has some impact on generated code:
   while the BPF LLVM back end still operates in 64 bit. The native
   target is mostly needed in tracing for the case of walking ``pt_regs``
   or other kernel structures where CPU's register width matters.
-  Otherwise, ``clang -target bpf`` is generally recommended.
+  Otherwise, ``clang --target=bpf`` is generally recommended.
 
 You should use default target when:
 
@@ -685,7 +685,7 @@ when:
   into these structures is verified by the BPF verifier and may result
   in verification failures if the native architecture is not aligned with
   the BPF architecture, e.g. 64-bit. An example of this is
-  BPF_PROG_TYPE_SK_MSG require ``-target bpf``
+  BPF_PROG_TYPE_SK_MSG require ``--target=bpf``
 
 
 .. Links
diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 7cd7c5415a99..f32db1f44ae9 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -990,7 +990,7 @@ format.::
     } g2;
     int main() { return 0; }
     int test() { return 0; }
-    -bash-4.4$ clang -c -g -O2 -target bpf t2.c
+    -bash-4.4$ clang -c -g -O2 --target=bpf t2.c
     -bash-4.4$ readelf -S t2.o
       ......
       [ 8] .BTF              PROGBITS         0000000000000000  00000247
@@ -1000,7 +1000,7 @@ format.::
       [10] .rel.BTF.ext      REL              0000000000000000  000007e0
            0000000000000040  0000000000000010          16     9     8
       ......
-    -bash-4.4$ clang -S -g -O2 -target bpf t2.c
+    -bash-4.4$ clang -S -g -O2 --target=bpf t2.c
     -bash-4.4$ cat t2.s
       ......
             .section        .BTF,"",@progbits
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index ca8957d5b671..1b2da781e9e2 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -28,7 +28,7 @@ For example, for the following code::
     return g1 + g2 + l1 + l2;
   }
 
-Compiled with ``clang -target bpf -O2 -c test.c``, the following is
+Compiled with ``clang --target=bpf -O2 -c test.c``, the following is
 the code with ``llvm-objdump -dr test.o``::
 
        0:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
@@ -155,7 +155,7 @@ and ``call`` instructions. For example::
     return gfunc(a, b) +  lfunc(a, b) + global;
   }
 
-Compiled with ``clang -target bpf -O2 -c test.c``, we will have
+Compiled with ``clang --target=bpf -O2 -c test.c``, we will have
 following code with `llvm-objdump -dr test.o``::
 
   Disassembly of section .text:
@@ -201,7 +201,7 @@ The following is an example to show how R_BPF_64_ABS64 could be generated::
   int global() { return 0; }
   struct t { void *g; } gbl = { global };
 
-Compiled with ``clang -target bpf -O2 -g -c test.c``, we will see a
+Compiled with ``clang --target=bpf -O2 -g -c test.c``, we will see a
 relocation below in ``.data`` section with command
 ``llvm-readelf -r test.o``::
 
diff --git a/drivers/hid/bpf/entrypoints/Makefile b/drivers/hid/bpf/entrypoints/Makefile
index a12edcfa4fe3..43b99b5575cf 100644
--- a/drivers/hid/bpf/entrypoints/Makefile
+++ b/drivers/hid/bpf/entrypoints/Makefile
@@ -58,7 +58,7 @@ entrypoints.lskel.h: $(OUTPUT)/entrypoints.bpf.o | $(BPFTOOL)
 
 $(OUTPUT)/entrypoints.bpf.o: entrypoints.bpf.c $(OUTPUT)/vmlinux.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
+	$(Q)$(CLANG) -g -O2 --target=bpf $(INCLUDES)			      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/kernel/bpf/preload/iterators/Makefile b/kernel/bpf/preload/iterators/Makefile
index 8937dc6bc8d0..b83c2f5e9be1 100644
--- a/kernel/bpf/preload/iterators/Makefile
+++ b/kernel/bpf/preload/iterators/Makefile
@@ -50,7 +50,7 @@ iterators.lskel-%.h: $(OUTPUT)/%/iterators.bpf.o | $(BPFTOOL)
 $(OUTPUT)/%/iterators.bpf.o: iterators.bpf.c $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
 	$(Q)mkdir -p $(@D)
-	$(Q)$(CLANG) -g -O2 -target bpf -m$* $(INCLUDES)		      \
+	$(Q)$(CLANG) -g -O2 --target=bpf -m$* $(INCLUDES)		      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..595b98d825ce 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -248,7 +248,7 @@ BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
 BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
 BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
 BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
-			  $(CLANG) -target bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
+			  $(CLANG) --target=bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
 			  $(LLVM_READELF) -S ./llvm_btf_verify.o | grep BTF; \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
@@ -370,7 +370,7 @@ endif
 clean-files += vmlinux.h
 
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -392,7 +392,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
 	@echo "  CLANG-BPF " $@
-	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
+	$(Q)$(CLANG) -g -O2 --target=bpf -D__TARGET_ARCH_$(SRCARCH) \
 		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
diff --git a/samples/bpf/gnu/stubs.h b/samples/bpf/gnu/stubs.h
index 719225b16626..cc37155fbfa5 100644
--- a/samples/bpf/gnu/stubs.h
+++ b/samples/bpf/gnu/stubs.h
@@ -1 +1,2 @@
-/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */
diff --git a/samples/bpf/test_lwt_bpf.sh b/samples/bpf/test_lwt_bpf.sh
index 0bf2d0f6bf4b..148e2df6cdce 100755
--- a/samples/bpf/test_lwt_bpf.sh
+++ b/samples/bpf/test_lwt_bpf.sh
@@ -376,7 +376,7 @@ DST_MAC=$(lookup_mac $VETH1 $NS1)
 SRC_MAC=$(lookup_mac $VETH0)
 DST_IFINDEX=$(cat /sys/class/net/$VETH0/ifindex)
 
-CLANG_OPTS="-O2 -target bpf -I ../include/"
+CLANG_OPTS="-O2 --target=bpf -I ../include/"
 CLANG_OPTS+=" -DSRC_MAC=$SRC_MAC -DDST_MAC=$DST_MAC -DDST_IFINDEX=$DST_IFINDEX"
 clang $CLANG_OPTS -c $PROG_SRC -o $BPF_PROG
 
diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index 026288280a03..9f7fe29dd749 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -86,7 +86,7 @@ BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
 BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
 BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
 BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
-			  $(CLANG) -target bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
+			  $(CLANG) --target=bpf -O2 -g -c -x c - -o ./llvm_btf_verify.o; \
 			  $(LLVM_READELF) -S ./llvm_btf_verify.o | grep BTF; \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
@@ -181,7 +181,7 @@ endif
 clean-files += vmlinux.h
 
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -198,7 +198,7 @@ EXTRA_BPF_HEADERS_SRC := $(addprefix $(src)/,$(EXTRA_BPF_HEADERS))
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(EXTRA_BPF_HEADERS_SRC) $(obj)/vmlinux.h
 	@echo "  CLANG-BPF " $@
-	$(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
+	$(Q)$(CLANG) -g -O2 --target=bpf -D__TARGET_ARCH_$(SRCARCH) \
 		-Wno-compare-distinct-pointer-types -I$(srctree)/include \
 		-I$(srctree)/samples/bpf -I$(srctree)/tools/include \
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 68454ef28f58..5006e724d1bc 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -260,9 +260,9 @@ EXAMPLES
 This is example BPF application with two BPF programs and a mix of BPF maps
 and global variables. Source code is split across two source code files.
 
-**$ clang -target bpf -g example1.bpf.c -o example1.bpf.o**
+**$ clang --target=bpf -g example1.bpf.c -o example1.bpf.o**
 
-**$ clang -target bpf -g example2.bpf.c -o example2.bpf.o**
+**$ clang --target=bpf -g example2.bpf.c -o example2.bpf.o**
 
 **$ bpftool gen object example.bpf.o example1.bpf.o example2.bpf.o**
 
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 681fbcc5ed50..e9154ace80ff 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -216,7 +216,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
 		-g -O2 -Wall -fno-stack-protector \
-		-target bpf -c $< -o $@
+		--target=bpf -c $< -o $@
 	$(Q)$(LLVM_STRIP) -g $@
 
 $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 47acf6936516..d8288936c912 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -62,7 +62,7 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
+	$(QUIET_GEN)$(CLANG) -g -O2 --target=bpf $(INCLUDES)		      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0f0aa9b7d7b5..6654b1a35ab3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -372,7 +372,7 @@ $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
 $(OUTPUT)test-clang-bpf-co-re.bin:
-	$(CLANG) -S -g -target bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
+	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
 		grep BTF_KIND_VAR
 
 $(OUTPUT)test-file-handle.bin:
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index e56ae54805a8..1478068ad5dd 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -669,7 +669,7 @@ llvm.*::
 		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
+		"-c \"$CLANG_SOURCE\" --target=bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 	llvm.clang-opt::
 		Options passed to clang.
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f48794816d82..1b752e0a3723 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1057,7 +1057,7 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -1081,7 +1081,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
-	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 4e8e243a6e4b..c6c9c2228578 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -25,7 +25,7 @@
 		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
 		"-Wno-unused-value -Wno-pointer-sign "		\
 		"-working-directory $WORKING_DIR "		\
-		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
+		"-c \"$CLANG_SOURCE\" --target=bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
 
 struct llvm_param llvm_param = {
 	.clang_path = "clang",
@@ -569,7 +569,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		pr_err("ERROR:\tunable to compile %s\n", path);
 		pr_err("Hint:\tCheck error message shown above.\n");
 		pr_err("Hint:\tYou can also pre-compile it into .o using:\n");
-		pr_err("     \t\tclang -target bpf -O2 -c %s\n", path);
+		pr_err("     \t\tclang --target=bpf -O2 -c %s\n", path);
 		pr_err("     \twith proper -I and -D options.\n");
 		goto errout;
 	}
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28d2c77262be..ade4db05f338 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -332,7 +332,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -373,12 +373,12 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $3 - CFLAGS
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
diff --git a/tools/testing/selftests/bpf/gnu/stubs.h b/tools/testing/selftests/bpf/gnu/stubs.h
index 719225b16626..cc37155fbfa5 100644
--- a/tools/testing/selftests/bpf/gnu/stubs.h
+++ b/tools/testing/selftests/bpf/gnu/stubs.h
@@ -1 +1,2 @@
-/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 01c0491d64da..2e986cbf1a46 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -167,7 +167,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -196,12 +196,12 @@ CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 # $3 - CFLAGS
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c12df57d5539..359389a66935 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -112,7 +112,7 @@ $(MAKE_DIRS):
 	mkdir -p $@
 
 # Get Clang's default includes on this system, as opposed to those seen by
-# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
@@ -130,7 +130,7 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 
 $(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
-	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
+	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
index cb553eac9f41..3c4b7fa05075 100644
--- a/tools/testing/selftests/tc-testing/Makefile
+++ b/tools/testing/selftests/tc-testing/Makefile
@@ -24,7 +24,7 @@ CLANG_FLAGS = -I. -I$(APIDIR) \
 
 $(OUTPUT)/%.o: %.c
 	$(CLANG) $(CLANG_FLAGS) \
-		 -O2 -target bpf -emit-llvm -c $< -o - |      \
+		 -O2 --target=bpf -emit-llvm -c $< -o - |      \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 
 TEST_PROGS += ./tdc.sh
-- 
2.41.0.178.g377b9f9a00-goog


