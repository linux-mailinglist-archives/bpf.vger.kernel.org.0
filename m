Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB64203A9
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhJCTY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhJCTYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 15:24:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D86C0617A3
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 12:22:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o20so8360323wro.3
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDlgUQirZcOt1FAHvZmZNmvLlnlW8XrgUiUQXaZEUJM=;
        b=HPYUUXZZm3+OB8e2U+Z2KPrnDJKdj/A0fXhGS8POpGD8+7WDr8LtyrMuS6RzCHevkI
         ri92xvsl6tiEmbhQN0dgEuY16lMcI0WarLqxg2ox8SMyDGshIB7rg3+7Bf1puF5/zh6z
         Cf1oRmb5h9qVTm7BD02J1y2coIogbvhbj/5l7kO2JDeiZLh6VKq6Et6j0lHeqIWiNTOU
         p7rUmuY1APtvgYLRKM8V0lY99uog9E416RMaOyPRWVEMRGCMBsr//S9k4mk35PKXvGuh
         lqE9Td9LNZ6CHnl9y73BnJjG/PogKL6qc1xcOcIqdbFsFl+KWzoe1NDoY+gfYj0peFt5
         /Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDlgUQirZcOt1FAHvZmZNmvLlnlW8XrgUiUQXaZEUJM=;
        b=aTlDAZoUNBZLvNnT31k24jOIPqa8KTwhE2qrLGxBDkbDNaAmUdTJ8WdDmiYdqkas+O
         qvkUWE5/WeUkX+dehCiZIA8O4HSESBp+bnL9JUDiISlRB2w9hp8LoDHm6HtSuH5yj4G6
         DIDeq2warMKW3T8WSqqe5/1F0LjLs32UliZ5J3lIkaefhuZ5SiHkaezz6EYP1ekSnWUt
         eRNeD3j4iaKt4EY8VYWbu/D2OSCrq+TfovfZASQq5f2MGaWWRCHwvuOkRhahtqC2G8gz
         zhOCkDoazbRGIVixZwiEHsKginNC/g2inmQpCV4Jj4ROTA5wkRq0u1/VWqh93weR3U+Y
         RjtA==
X-Gm-Message-State: AOAM530R4l/q+Cf8WNJ+bmJOjLS4g0TV8prE4+E7gsVhboV/p0FmcNWp
        2U7EtKWadYHI0W7QfH9QGpNi7A==
X-Google-Smtp-Source: ABdhPJzb/u4TIo3KgzbBwfzILlctGJx1H2U1FHbUrzIhlv1OBw3jUKwvwzKt2EAwW6e0QOEXLjZfAg==
X-Received: by 2002:a5d:4911:: with SMTP id x17mr6955157wrq.173.1633288948218;
        Sun, 03 Oct 2021 12:22:28 -0700 (PDT)
Received: from localhost.localdomain ([149.86.88.77])
        by smtp.gmail.com with ESMTPSA id d3sm14124642wrb.36.2021.10.03.12.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 12:22:27 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 10/10] tools: bpftool: add install-bin target to install binary only
Date:   Sun,  3 Oct 2021 20:22:08 +0100
Message-Id: <20211003192208.6297-11-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003192208.6297-1-quentin@isovalent.com>
References: <20211003192208.6297-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With "make install", bpftool installs its binary and its bash completion
file. Usually, this is what we want. But a few components in the kernel
repository (namely, BPF iterators and selftests) also install bpftool
locally before using it. In such a case, bash completion is not
necessary and is just a useless build artifact.

Let's add an "install-bin" target to bpftool, to offer a way to install
the binary only.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 kernel/bpf/preload/iterators/Makefile | 2 +-
 tools/bpf/bpftool/Makefile            | 6 ++++--
 tools/testing/selftests/bpf/Makefile  | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/preload/iterators/Makefile b/kernel/bpf/preload/iterators/Makefile
index ec39ccc71b8e..616a7ec0232c 100644
--- a/kernel/bpf/preload/iterators/Makefile
+++ b/kernel/bpf/preload/iterators/Makefile
@@ -67,4 +67,4 @@ $(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
 		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
 		    LIBBPF_OUTPUT=$(LIBBPF_OUTPUT)/			       \
 		    LIBBPF_DESTDIR=$(LIBBPF_DESTDIR)/			       \
-		    prefix= DESTDIR=$(abs_out)/ install
+		    prefix= DESTDIR=$(abs_out)/ install-bin
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ef5219e0e233..eaa38d27194d 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -221,10 +221,12 @@ clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
 	$(Q)$(RM) -r -- $(OUTPUT)feature/
 
-install: $(OUTPUT)bpftool
+install-bin: $(OUTPUT)bpftool
 	$(call QUIET_INSTALL, bpftool)
 	$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(prefix)/sbin
 	$(Q)$(INSTALL) $(OUTPUT)bpftool $(DESTDIR)$(prefix)/sbin/bpftool
+
+install: install-bin
 	$(Q)$(INSTALL) -m 0755 -d $(DESTDIR)$(bash_compdir)
 	$(Q)$(INSTALL) -m 0644 bash-completion/bpftool $(DESTDIR)$(bash_compdir)
 
@@ -251,6 +253,6 @@ zdep:
 	@if [ "$(feature-zlib)" != "1" ]; then echo "No zlib found"; exit 1 ; fi
 
 .SECONDARY:
-.PHONY: all FORCE clean install uninstall zdep
+.PHONY: all FORCE clean install-bin install uninstall zdep
 .PHONY: doc doc-clean doc-install doc-uninstall
 .DEFAULT_GOAL := all
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ffe48b40d8fa..f1cb55c0c37e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -216,7 +216,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
-		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
 
 all: docs
 
-- 
2.30.2

