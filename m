Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196EE43BC57
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhJZV0t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 17:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239575AbhJZV0s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 17:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635283463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c0f2U91ZYdHciaCbl1twiqOJ6L+v0KBNSmK6aUUIrtE=;
        b=XevrFokYlbtEF9Bgtj+Dm5oCV6H//zkc7Btb3yLbxyBvE+t1E080HX92hC+RRRaCHgrJKD
        P6MdvpGbBKZzBO2nV1Gp3pMCCUXuoz0EEz5bHspkY2d6WlMpGdul86I5jIJpDF5saKNcmz
        q9w52mLYKUowp1K1fofYfv652+165LQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-t3PZAQ6WPnqyWFZG2fBEkg-1; Tue, 26 Oct 2021 17:24:22 -0400
X-MC-Unique: t3PZAQ6WPnqyWFZG2fBEkg-1
Received: by mail-wm1-f69.google.com with SMTP id c1-20020a05600c0ac100b00322fcaa2bc7so263124wmr.4
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 14:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0f2U91ZYdHciaCbl1twiqOJ6L+v0KBNSmK6aUUIrtE=;
        b=My5LeQOhtUo8ch2inulQKEvRN78qbJZWFyiYrKjrU3kTzAFGJfjE3wTV9D7HN9Gz4i
         9La12SH0fvkE1HBUb5HWKNh0yT6hoNLTLm0lROwQUJKZNLrP9F62VB/3fBO7Y/4BOwr0
         FfLRqbp3aU4ZX7xP2O1iaW+gPp3J2YflFzBVVJWNBXDp1MqolDom28JgH56D5EHMYOlB
         IU6CyIbyx9ebZMEq0S/O9G5qkCiqPfKlHoQ/Iuf2o8mAjvlT+JPjzIOcCCHSZeGpz6Qa
         Vrm8HgIBHqTS92Pm0UrjmLa01ol9NRcyUUENZFF9LEaOZ+Gnd08POgs59qK06Wz+zwGN
         Tt4A==
X-Gm-Message-State: AOAM5323C55P5zcqUCMCzAO4hIawd1OiUACTySTrp2rG53yJPT+iKKFy
        7wuNIy+0bMfexnrjk5hamsgXu4KTQbL07CNr+1UpLFzYatqt2nFug12GNYHxh+ou96Y6jHMk7KO
        GlMykAYWpPpNe
X-Received: by 2002:a5d:5402:: with SMTP id g2mr31143126wrv.290.1635283461123;
        Tue, 26 Oct 2021 14:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwApQ6dlu1w5joksZslbDv4X+LkjmHfIX/w2wmCQK02a+UzvJ/pIx/wfXYYP4tdhcXj30e93w==
X-Received: by 2002:a5d:5402:: with SMTP id g2mr31143091wrv.290.1635283460869;
        Tue, 26 Oct 2021 14:24:20 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h22sm1828123wmq.42.2021.10.26.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:24:20 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCHv2 bpf-next] kbuild: Unify options for BTF generation for vmlinux and modules
Date:   Tue, 26 Oct 2021 23:24:19 +0200
Message-Id: <20211026212419.144077-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using new PAHOLE_FLAGS variable to pass extra arguments to
pahole for both vmlinux and modules BTF data generation.

Adding new scripts/pahole-flags.sh script that detect and
prints pahole options.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - posting separately from original patchset
  - added Andrii's ack

 Makefile                  |  3 +++
 scripts/Makefile.modfinal |  2 +-
 scripts/link-vmlinux.sh   | 11 +----------
 scripts/pahole-flags.sh   | 20 ++++++++++++++++++++
 4 files changed, 25 insertions(+), 11 deletions(-)
 create mode 100755 scripts/pahole-flags.sh

diff --git a/Makefile b/Makefile
index 437ccc66a1c2..ee514b80c62e 100644
--- a/Makefile
+++ b/Makefile
@@ -480,6 +480,8 @@ LZ4		= lz4c
 XZ		= xz
 ZSTD		= zstd
 
+PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) scripts/pahole-flags.sh)
+
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
 NOSTDINC_FLAGS :=
@@ -534,6 +536,7 @@ export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
+export PAHOLE_FLAGS
 
 # Files to ignore in find ... statements
 
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1fb45b011e4b..7f39599e9fae 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -40,7 +40,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ -f vmlinux ]; then						\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
 	else								\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d74cee5c4326..3ea7cece7c97 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -205,7 +205,6 @@ vmlinux_link()
 gen_btf()
 {
 	local pahole_ver
-	local extra_paholeopt=
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
@@ -220,16 +219,8 @@ gen_btf()
 
 	vmlinux_link ${1}
 
-	if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
-		# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
-		extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
-	fi
-	if [ "${pahole_ver}" -ge "121" ]; then
-		extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
-	fi
-
 	info "BTF" ${2}
-	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${extra_paholeopt} ${1}
+	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
new file mode 100755
index 000000000000..2b99fc77019c
--- /dev/null
+++ b/scripts/pahole-flags.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+extra_paholeopt=
+
+if ! [ -x "$(command -v ${PAHOLE})" ]; then
+	return
+fi
+
+pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
+
+if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
+	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
+fi
+if [ "${pahole_ver}" -ge "121" ]; then
+	extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
+fi
+
+echo ${extra_paholeopt}
-- 
2.31.1

