Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6156A44C04A
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhKJLt1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhKJLt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:49:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71DC061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so1755883wmd.1
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFsDhVwNfx2+wkoea0+L+uj6nk2RYNAhjgBsFkxBpOc=;
        b=LGuOHPNv5SM+Efl20xjITHcexnv/lLd9xDAvK0xXDYAM1Zuzey8RxnUiiLUbO2RO4Q
         l2LboeCRNrAKIpCsRdQ0zTmbU3D+IWFZ7Flqbcu6mlYNePFyZqgT2Dr1QnQhKrQFVkV5
         Bop2d6/nCinD7lw87akAXcFWfV8IHnDtFzyAc9HIqKv3tlc2/mJe5I9zUkUlSFZUg6F/
         a+o/jpb45DZSLo5OO5UJ21FdK244oIZ95VUbXO5Kvh2H2XWrq8SnvTsLiffZLP2/1IMH
         l9WmJR0HSmiRngOEQU9g62y3RFbAyaXy2vLEpdWAThQYWXywxej13J6k9ZN5L0rIcOn9
         lxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFsDhVwNfx2+wkoea0+L+uj6nk2RYNAhjgBsFkxBpOc=;
        b=leBpg9/UkqizdMyTZK7iO/U/A0asfdX+GVreTjgTroI16Ujnty70kSa1wnNa6tJpgI
         nCDXEr7L0D6t4ak2a2QWBsVDYv5JsuggStY42LFKe7y2hkbLjr9Vazq8w2UPnPLQCoPF
         fN0QMhxacflYH24qkX+I0BDuTlsPyPgEBJJZnbZRVxSPZUHjkMGW5/ojv/1Ns4by2CC4
         NXKafYBldtDqGHwreAFCgr0hvDlvUloemBHRYn+f8ALqQ9aSl9wCW0tzms5SEEtTBz0G
         dG3qZ7qYh1697OXBLFbDnxTXWB1UKvC/4BXNUiIf6LQTn0zprFyRbD3Sd1Yz8oip7Z3X
         8pKQ==
X-Gm-Message-State: AOAM532tGTOmAjjCtOuHvLplsgPRvjgmIbi2B85qJRXtjiE3o9QoUMf4
        Bb0uFSAMiscF49CsDXyngzkNDQ==
X-Google-Smtp-Source: ABdhPJzRX4of9vIT8wZ5LBq5RdCJb+hTM8osAAIprtsMS+oFv3HstM8wzOlGAQOEQlO9LH6Mmp+Qcg==
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr15660896wms.81.1636544798013;
        Wed, 10 Nov 2021 03:46:38 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.190])
        by smtp.gmail.com with ESMTPSA id i15sm6241152wmq.18.2021.11.10.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:46:37 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/6] bpftool: Use $(OUTPUT) and not $(O) for VMLINUX_BTF_PATHS in Makefile
Date:   Wed, 10 Nov 2021 11:46:29 +0000
Message-Id: <20211110114632.24537-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110114632.24537-1-quentin@isovalent.com>
References: <20211110114632.24537-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The Makefile for bpftool relies on $(OUTPUT), and not on $(O), for
passing the output directory. So $(VMLINUX_BTF_PATHS), used for
searching for kernel BTF info, should use the same variable.

Fixes: 05aca6da3b5a ("tools/bpftool: Generalize BPF skeleton support and generate vmlinux.h")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 2a846cb92120..40abf50b59d4 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -150,7 +150,7 @@ $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
 $(OBJS): $(LIBBPF) $(LIBBPF_INTERNAL_HDRS)
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+VMLINUX_BTF_PATHS ?= $(if $(OUTPUT),$(OUTPUT)/vmlinux)			\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../../vmlinux					\
 		     /sys/kernel/btf/vmlinux				\
-- 
2.32.0

