Return-Path: <bpf+bounces-44222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9089C0278
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289C51F21A2F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55D1F4281;
	Thu,  7 Nov 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTw7mH2E"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E121EC015
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975662; cv=none; b=plXDTSIepy/0d8+1CCvXLTyMDrC93O3l88TWeOoYZ8SFFftWRGRXU0wb+ffI9v8UXFiho36lXtuRYLNF7QASfAqKVNgOI0o4CMXgY/76EVsYrsGphU+4bu2bVuBekz72DouINZDWxybv60c7oP60lxW+ZlpqKf8ZbgIthPykX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975662; c=relaxed/simple;
	bh=wXCD5eKz281t5lW/YMvtsw7ddnhmOR7vduWmL2eyIy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TCtitRslOmEk26pjKyORoEvTnADCrWvqW9BO/veQf6rx2DdhYFlewXL+rGRk2M0VgVBAcf6kb6ilqr726r+7D0dIPewFWxtcuF1e+k/fVAhLmeNowowctrzpoPytMhd/hZx30TivHUGT52hV8h+w1dRwOMkjenidn8EfcKFkFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTw7mH2E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730975658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x6Fsai4Rs27CT9uopUQsYU5j2+pOhQUP1RadZUWBh6s=;
	b=JTw7mH2EffeSkQTOBdD8X2S2ZZukBipn1IrNKUozjqxfIzj35ruryFoOu1UbPsuE6ujfIm
	eDum2rPp7dIDxRufrqe1Za+hgTsdW0eLRTWDbLG17BBy6W/XQ200sedz29PnoFQ4Tm+YcS
	8Gtkq7N3B99bVPQIteylSOlnFZab1yc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-YQddzOJxN5aHnaOQmDc1xw-1; Thu, 07 Nov 2024 05:34:15 -0500
X-MC-Unique: YQddzOJxN5aHnaOQmDc1xw-1
X-Mimecast-MFC-AGG-ID: YQddzOJxN5aHnaOQmDc1xw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99f43c4c7bso53929966b.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 02:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975654; x=1731580454;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6Fsai4Rs27CT9uopUQsYU5j2+pOhQUP1RadZUWBh6s=;
        b=Mvl/grWfKRZ8JFDUzdhcLyRcnx4XZSyRnj1yNn9yhbPUUQurLZXKJVmrsL2EEYjX9k
         1FBgcDHvknHjPyf9+eAKxZx2h6XmzkXZ0fPvSqY3DYI91+FUzp+GouUFQ5ZOG4S/wW5I
         +19bcXRqzuM3V4HVEmq+zQBRyicJKl3HDRrK96wLrIzw6X+P7l2JER4OaWOvu2JcrgB3
         w+Kso9NgaGW4PZZ9tuWsN0OKLwriBpJ7EuAxNOKc+FbU9Tw3Jr3QK3m7ib9I9golfWyL
         uaubmMgqu3m9W2orNqCbFK+XXghbVb5uSz+Y3gUA4ZKppxDmh6KjmlGH38R8yuLEIkqt
         /jWA==
X-Forwarded-Encrypted: i=1; AJvYcCVhDlcGlE2XP29TfxaHxhL0aol66Blj05R4Vitcdp/FCA80xps94lW0rZOV3KK8auxdG9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aJdEaylGF/XHjuwxgmdTwTBPgm9zewPOEIw2ymv3D1KDTsVu
	p3yyqer3zOy7zaqKvgLKc/pKqK5QBnPrZJeE5GQipZtI6Xh/SrubiqbiYS+6HLzm9bypueBQSm4
	tq4k/Bv37i3ccgi3xJlHdia7tIyQ95rpAleYxK/l7+YDpmodHyQ==
X-Received: by 2002:a17:906:f58e:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9de61a128amr4040139666b.58.1730975653412;
        Thu, 07 Nov 2024 02:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2AHgYgmjv35/HdJTHTNHZCu2lfRf7nVtBM0rieR1aqMNpyIhtBwrmEXzrXB/1BFoTIZY6aA==
X-Received: by 2002:a17:906:f58e:b0:a9a:2afc:e4cc with SMTP id a640c23a62f3a-a9de61a128amr4040135266b.58.1730975652792;
        Thu, 07 Nov 2024 02:34:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48b14sm74379466b.55.2024.11.07.02.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:34:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 085E7164C5BA; Thu, 07 Nov 2024 11:34:10 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 07 Nov 2024 11:33:52 +0100
Subject: [PATCH bpf-next v2] selftests/bpf: Consolidate kernel modules into
 common directory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-bpf-selftests-mod-compile-v2-1-ef781fe9ca95@redhat.com>
X-B4-Tracking: v=1; b=H4sIAI+XLGcC/32NwQqDMBBEf6XsuVtMomJ76n8UD6nZ1AU1kg1iE
 f+9qfRc5jTMzJsNhCKTwO20QaSFhcOUjT6foOvt9CJklz3oQpeqMAU+Z49Cg08kSXAMDrswzjw
 Q1uXVNE5ZqnwNeT9H8rwe7Ad8ZxOtCdqc9CwpxPdxuqgj//HVH/6iMMvWxnptmsqreyTX23TJB
 Wj3ff8A2WeWj80AAAA=
X-Change-ID: 20241030-bpf-selftests-mod-compile-64938d1ae5f6
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

The selftests build four kernel modules which use copy-pasted Makefile
targets. This is a bit messy, and doesn't scale so well when we add more
modules, so let's consolidate these rules into a single rule generated
for each module name, and move the module sources into a single
directory.

To avoid parallel builds of the different modules stepping on each
other's toes during the 'modpost' phase of the Kbuild 'make modules', we
create a single target for all the defined modules, which contains the
recursive 'make' call into the modules directory. The Makefile in the
subdirectory building the modules is modified to have a .PHONY target
which also touches a 'modules.built' file. This way we can add this file
as a dependency on the top-level selftests Makefile, thus ensuring that
the modules are always rebuilt if any of the dependencies in the
selftests change. The .PHONY target doesn't cause spurious rebuilds
since we track all the dependencies in the parent directory Makefile and
only call make in the subdirectory if anything changes.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v2:
- Rebase on bpf-next, incorporating Viktor's EXTRA_CFLAGS patch
- A few small adjustments to the module Makefile recipe
- Link to v1: https://lore.kernel.org/r/20241031-bpf-selftests-mod-compile-v1-1-1a63af2385f1@redhat.com
---
 tools/testing/selftests/bpf/Makefile               | 62 +++++++---------------
 .../selftests/bpf/bpf_test_modorder_x/Makefile     | 19 -------
 .../selftests/bpf/bpf_test_modorder_y/Makefile     | 19 -------
 .../testing/selftests/bpf/bpf_test_no_cfi/Makefile | 19 -------
 tools/testing/selftests/bpf/bpf_testmod/Makefile   | 20 -------
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
 tools/testing/selftests/bpf/progs/bad_struct_ops.c |  2 +-
 tools/testing/selftests/bpf/progs/cb_refs.c        |  2 +-
 tools/testing/selftests/bpf/progs/epilogue_exit.c  |  4 +-
 .../selftests/bpf/progs/epilogue_tailcall.c        |  4 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |  2 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c  |  2 +-
 .../selftests/bpf/progs/kfunc_call_destructive.c   |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_race.c  |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |  2 +-
 .../selftests/bpf/progs/kfunc_call_test_subprog.c  |  2 +-
 .../testing/selftests/bpf/progs/local_kptr_stash.c |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |  2 +-
 tools/testing/selftests/bpf/progs/missed_kprobe.c  |  2 +-
 .../selftests/bpf/progs/missed_kprobe_recursion.c  |  2 +-
 tools/testing/selftests/bpf/progs/nested_acquire.c |  2 +-
 tools/testing/selftests/bpf/progs/pro_epilogue.c   |  4 +-
 .../selftests/bpf/progs/pro_epilogue_goto_start.c  |  4 +-
 tools/testing/selftests/bpf/progs/sock_addr_kern.c |  2 +-
 .../selftests/bpf/progs/struct_ops_detach.c        |  2 +-
 .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |  2 +-
 .../selftests/bpf/progs/struct_ops_maybe_null.c    |  2 +-
 .../bpf/progs/struct_ops_maybe_null_fail.c         |  2 +-
 .../selftests/bpf/progs/struct_ops_module.c        |  2 +-
 .../selftests/bpf/progs/struct_ops_multi_pages.c   |  2 +-
 .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |  2 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |  2 +-
 .../selftests/bpf/progs/test_module_attach.c       |  2 +-
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |  2 +-
 .../testing/selftests/bpf/progs/unsupported_ops.c  |  2 +-
 tools/testing/selftests/bpf/progs/wq.c             |  2 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |  2 +-
 .../bpf/{bpf_testmod => test_kmods}/.gitignore     |  0
 tools/testing/selftests/bpf/test_kmods/Makefile    | 25 +++++++++
 .../bpf_test_modorder_x.c                          |  0
 .../bpf_test_modorder_y.c                          |  0
 .../bpf_test_no_cfi.c                              |  0
 .../bpf_testmod-events.h                           |  0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.c  |  0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.h  |  0
 .../bpf_testmod_kfunc.h                            |  0
 48 files changed, 82 insertions(+), 158 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef5df08cb2536260f8910b2ebd2b89dbd0ebd2..1c35e29e3e94d86eb5619db5cb20e2d42772fe60 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -152,13 +152,15 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
+TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko
+TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
+
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
-	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko
+	test_lirc_mode2_user xdping test_cpp runqslower bench xskxceiver \
+	xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata xdp_features
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -173,8 +175,9 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_GEN_PROGS)
 	$(Q)$(RM) -r $(TEST_GEN_PROGS_EXTENDED)
 	$(Q)$(RM) -r $(TEST_GEN_FILES)
+	$(Q)$(RM) -r $(TEST_KMODS)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
-	$(Q)$(MAKE) -C bpf_testmod clean
+	$(Q)$(MAKE) -C test_kmods clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -240,7 +243,7 @@ endif
 # to build individual tests.
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
-$(notdir $(TEST_GEN_PROGS)						\
+$(notdir $(TEST_GEN_PROGS) $(TEST_KMODS)				\
 	 $(TEST_GEN_PROGS_EXTENDED)): %: $(OUTPUT)/% ;
 
 # sort removes libbpf duplicates when not cross-building
@@ -294,37 +297,15 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 		  $< -o $@ \
 		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
-$(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
-	$(call msg,MOD,,$@)
-	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C bpf_testmod \
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)     \
+test_kmods/modules.built: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard test_kmods/Makefile test_kmods/*.[ch])
+	$(Q)$(RM) test_kmods/*.ko test_kmods/*.mod.o # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) -C test_kmods	\
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	\
 		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
-	$(Q)cp bpf_testmod/bpf_testmod.ko $@
 
-$(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
+$(TEST_KMOD_TARGETS): test_kmods/modules.built
 	$(call msg,MOD,,$@)
-	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	 \
-		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
-	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
-
-$(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
-	$(call msg,MOD,,$@)
-	$(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C bpf_test_modorder_x \
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	     \
-		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
-	$(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
-
-$(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
-	$(call msg,MOD,,$@)
-	$(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C bpf_test_modorder_y \
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	     \
-		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
-	$(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
+	$(Q)cp test_kmods/$(@F) $@
 
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
@@ -749,14 +730,12 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 json_writer.c 		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
-		       $(OUTPUT)/bpf_test_no_cfi.ko			\
-		       $(OUTPUT)/bpf_test_modorder_x.ko		\
-		       $(OUTPUT)/bpf_test_modorder_y.ko		\
+TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(TEST_KMOD_TARGETS)				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
@@ -883,12 +862,9 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.ld
 
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature bpftool 						\
+	feature bpftool $(TEST_KMOD_TARGETS)				\
 	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
-			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
-			       bpf_test_no_cfi.ko			\
-			       bpf_test_modorder_x.ko			\
-			       bpf_test_modorder_y.ko			\
+			       no_alu32 cpuv4 bpf_gcc			\
 			       liburandom_read.so)			\
 	$(OUTPUT)/FEATURE-DUMP.selftests
 
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile b/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
deleted file mode 100644
index 40b25b98ad1b622c6a5c3c00d0625595349bb677..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-BPF_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(BPF_TESTMOD_DIR)/../../../../..)
-
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
-MODULES = bpf_test_modorder_x.ko
-
-obj-m += bpf_test_modorder_x.o
-
-all:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
-
-clean:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
-
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile b/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
deleted file mode 100644
index 52c3ab9d84e29c794f57c1f75be03b46d80d4a06..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-BPF_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(BPF_TESTMOD_DIR)/../../../../..)
-
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
-MODULES = bpf_test_modorder_y.ko
-
-obj-m += bpf_test_modorder_y.o
-
-all:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
-
-clean:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
-
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile b/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
deleted file mode 100644
index ed5143b79edf790b5d4e7213507110e2c6fb4886..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-BPF_TEST_NO_CFI_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(BPF_TEST_NO_CFI_DIR)/../../../../..)
-
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
-MODULES = bpf_test_no_cfi.ko
-
-obj-m += bpf_test_no_cfi.o
-
-all:
-	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) modules
-
-clean:
-	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) clean
-
diff --git a/tools/testing/selftests/bpf/bpf_testmod/Makefile b/tools/testing/selftests/bpf/bpf_testmod/Makefile
deleted file mode 100644
index 15cb36c4483ac3b970d93d2e4467cd290917c361..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-BPF_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(BPF_TESTMOD_DIR)/../../../../..)
-
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
-MODULES = bpf_testmod.ko
-
-obj-m += bpf_testmod.o
-CFLAGS_bpf_testmod.o = -I$(src)
-
-all:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
-
-clean:
-	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
-
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 1c682550e0e7caa3872970bda26e0a4b3d638a6c..e10ea92c3fe224fc4c7b60c7108e890a524b469a 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -2,7 +2,7 @@
 #define _GNU_SOURCE
 #include <test_progs.h>
 #include "progs/core_reloc_types.h"
-#include "bpf_testmod/bpf_testmod.h"
+#include "test_kmods/bpf_testmod.h"
 #include <linux/limits.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
index b7e175cd0af0cbc51a16a7d695b52828c40ad0a0..b3f77b4561c8281363b5a083368e5f12dc13d758 100644
--- a/tools/testing/selftests/bpf/progs/bad_struct_ops.c
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
@@ -3,7 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 56c764df8196793155d69967ca1c4a28099d2540..5d6fc7f01ebb69e26351f3811ac1551a9e72a414 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -2,7 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr *ptr;
diff --git a/tools/testing/selftests/bpf/progs/epilogue_exit.c b/tools/testing/selftests/bpf/progs/epilogue_exit.c
index 33d3a57bee903ea40aa009cef9b69c354fd6e2c2..35fec7c75bef9a59998ee9fe985ab64b63c2e133 100644
--- a/tools/testing/selftests/bpf/progs/epilogue_exit.c
+++ b/tools/testing/selftests/bpf/progs/epilogue_exit.c
@@ -4,8 +4,8 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/epilogue_tailcall.c b/tools/testing/selftests/bpf/progs/epilogue_tailcall.c
index 7275dd594de0636e7e5d6460bc7813d24539149d..153514691ba4bc5ce24f81f51d23bffdd9773214 100644
--- a/tools/testing/selftests/bpf/progs/epilogue_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/epilogue_tailcall.c
@@ -4,8 +4,8 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index df1d3db60b1b12c36c9d56b0ade990f94f95fca6..9e4b45201e692721ddda6a25a866f44ac05fe6a0 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -4,7 +4,7 @@
 #include "bpf_experimental.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
index f9789e66829732f174892f4ed85a6db9687f6bf2..82190d79de375642d09416dd971cf2c84ccfcd11 100644
--- a/tools/testing/selftests/bpf/progs/jit_probe_mem.c
+++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
@@ -3,7 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 static struct prog_test_ref_kfunc __kptr *v;
 long total_sum = -1;
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
index 7632d9ecb253ba37d3e85a97cc6a19adc1b08112..b9670e9a6e3df53d1178eb05b437f298ac314fd2 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_destructive_test(void)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 08fae306539c591d89201ec10b9ae7b258eab8a5..a1963497f0bff99a21c305a861ddcc35d16c7d66 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct syscall_test_args {
 	__u8 data[16];
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_race.c b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
index d532af07decf954ca168335446daf1a3e34c81b6..48f64827cd934d678ff5ced4369408187df0233e 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_race.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_fail(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index f502f755f56793d7c0bfa241f0cb79539e1960c4..8b86113a0126162d7ce891ee213927b4e778f612 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index 2380c75e74ce2c8e9914e4304cbddbcdccd54d3c..8e150e85b50d286d34c7e569cfadfc294cc52dd3 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 extern const int bpf_prog_active __ksym;
 int active_res = -1;
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index b092a72b2c9df567d8cec37bb9d8645310383670..d736506a4c807feb842dbc749a76c6c51b3270a6 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -6,7 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "../bpf_experimental.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct plain_local;
 
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index ab0ce1d01a4a714c6271e36e8831fc5ffadbb553..edaba481db9d83fb47b255c90369f8dde5448449 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -2,7 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr_untrusted *unref_ptr;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 450bb373b179fc91b028568ee6d787d85147ecbb..c2a6bd392e480e2d32659e94c6904d26ad1ebafe 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct map_value {
 	char buf[8];
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe.c b/tools/testing/selftests/bpf/progs/missed_kprobe.c
index 7f9ef701f5dee65eb71a4c5236bdf6e570e4ed50..51a4fe64c9175f6aa6f4e0210cb1bbf74b8e4f37 100644
--- a/tools/testing/selftests/bpf/progs/missed_kprobe.c
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe.c
@@ -2,7 +2,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
index 8ea71cbd6c45160c5c58d61592967489ba9df4ba..c4bf679a987634c711970cf01ce0b041f3f05697 100644
--- a/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
@@ -2,7 +2,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/nested_acquire.c b/tools/testing/selftests/bpf/progs/nested_acquire.c
index 8e521a21d995957cd42216418c2607c91c2d5b5f..49ad7b9adf566fc608502649ae5a2885a61f50e6 100644
--- a/tools/testing/selftests/bpf/progs/nested_acquire.c
+++ b/tools/testing/selftests/bpf/progs/nested_acquire.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue.c b/tools/testing/selftests/bpf/progs/pro_epilogue.c
index 44bc3f06b4b612b5520f4cec07c61700beb7949d..d97d6e07ef5c156d1c94c6d7b199c50e3ac293e6 100644
--- a/tools/testing/selftests/bpf/progs/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue.c
@@ -4,8 +4,8 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c b/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
index 3529e53be35501b19a47626ee5c50895a02e67f1..6048d79be48bfce0555827b8d5ca6678617d3050 100644
--- a/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
@@ -4,8 +4,8 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/sock_addr_kern.c b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
index 8386bb15ccdc19728cba21cff5f96403903aff7d..84ad515eafd6c84e2762af06de0e598ede70435b 100644
--- a/tools/testing/selftests/bpf/progs/sock_addr_kern.c
+++ b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Google LLC */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("syscall")
 int init_sock(struct init_sock_args *args)
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
index d7fdcabe7d905a439ddfb15a42a92ca29511a706..284a5b008e0c4a6a3eab026f4a366dda7e82a45d 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c b/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
index 3c822103bd405b693373824b006c239a85b3a6fa..d8cc99f5c2e2f9832cdc0da18df00a445cc6be40 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
index b450f72e744ad22a78d98bc3b539527abc7e01c6..ccab3935aa425ec8ff9c7d0aa4cb6ce77fc547f7 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
index 6283099ec383a38bb11c47c6c8f9d51c6dd220e0..8b5515f4f724e8f12fd8f170acbdcd5fb11cb96b 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 4c56d4a9d9f410b42430bd58cd4a0011047e58c7..71c420c3a5a6c7ad8fca16fd3e6432b36027811c 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -3,7 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
index 9efcc6e4d3566d9814933d0d9a3568a3f10d41b7..5b23ea817f1f90d9db1333e00031bdb669509029 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
@@ -3,7 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c b/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
index fa2021388485d67192e8b60f29803f206cda7521..5d0937fa07be20face0300cfebacd387f79ac66f 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
index 7ac7e1de34d811865ca187a200bc6f213d482511..0ad1bf1ede8dc7f83f2e922d918ce40d196b64a4 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_dynptr_nullable_test1(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index cc1a012d038f1ddca8c982a88b9ef15802f39610..fb07f5773888b05f0c653bc168769c85c99811fb 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 __u32 raw_tp_read_sz = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index 5aaf2b065f86c25a00936548d3f76eb3e69848b1..3bce838e92d5a1bfd6b4cc1e5a900e4715bf0170 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -3,7 +3,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 #include "bpf_misc.h"
 
 SEC("tp_btf/bpf_testmod_test_nullable_bare")
diff --git a/tools/testing/selftests/bpf/progs/unsupported_ops.c b/tools/testing/selftests/bpf/progs/unsupported_ops.c
index 9180365a3568f8f5d04682704ae08588bcdc2025..8aa2e0dd624e4b8d83a9377ae3b4adfd62bc350b 100644
--- a/tools/testing/selftests/bpf/progs/unsupported_ops.c
+++ b/tools/testing/selftests/bpf/progs/unsupported_ops.c
@@ -4,7 +4,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index f8d3ae0c29aeb3da58c604f6a2eb6aeb3c90e365..2f1ba08c293e26c48e0866ea00ff73b8517faab3 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -5,7 +5,7 @@
 #include "bpf_experimental.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 25b51a72fe0fe6d0f1253e22e204aaf6c1946fc6..4240211a19001fbbe0860da761121917a91049f5 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -5,7 +5,7 @@
 #include "bpf_experimental.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/tools/testing/selftests/bpf/test_kmods/.gitignore
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
rename to tools/testing/selftests/bpf/test_kmods/.gitignore
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6a1e163429f88f166d1fad8dfb0bb999c80bde71
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -0,0 +1,25 @@
+TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko
+
+$(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
+
+CFLAGS_bpf_testmod.o = -I$(src)
+
+.PHONY: modules.built
+modules.built:
+	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+	$(Q)touch modules.built
+
+clean:
+	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+	$(Q)rm -f modules.built
+
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.c
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c
rename to tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.c
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.c
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c
rename to tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.c
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
rename to tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
rename to tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h

---
base-commit: 9a28559932d2a4d043d3f3f68ea0cb911277b8ce
change-id: 20241030-bpf-selftests-mod-compile-64938d1ae5f6


