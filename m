Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921D54A512C
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 22:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiAaVMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 16:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiAaVL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 16:11:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E78C06173B
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 13:11:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j23so29440832edp.5
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzPneTo0JhD90wvMMv3HK1Id2oCk0Ayd+5WYzgnvdM8=;
        b=ZIWsKNjyMbRXti9nm2SdFOJkQs7y2R5vGzStqAdBGURn+OfggXWLuC+vcYJAIWXot5
         1FAW0MGtKYvCk1rArqx3qwHbuu2cFk5b5neY9oztyX4B2lmTxVzuMU16TFbXNolmpRop
         Yrmj6vQ5AxCwiYDyIp3Z0UZTsHX29ggmq6Ezt6Glm+ef0f7epC1I84aSxn1sh4Wk8mJf
         3syFGZmXjLAKu2zfO/6duwHlmGEB+l1P6ilBq6T+R83FakzSSD6k2SCRNzICJzPKLNmj
         dI5OMS78hoVIXVjXLpc7mByW1etMQlas9y7DzIVustRiqlbzQ2P+IChPhYMhnqvm4E17
         AG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzPneTo0JhD90wvMMv3HK1Id2oCk0Ayd+5WYzgnvdM8=;
        b=LriUf4plD540Kqu/+RoVRbvZIKicBiG7IT8eofHxRcR03JLL+VJw8Ldx8yUgT6fG3y
         DYfHd0bK91Zq9bVv6jHCriDN3foqoqsTJuGzYfwRFk0U85Vg+IIYMjSsChi3QVir/JWp
         hY+pIC4I4NFg4NjSpqpjUAA+xy9Graj5gU1u8bD9xAaU+MHalb73Ht72uzic3MWlJqwU
         wkdIePpghs1D8WpLokRSVzxWbzHI2bebiqj4svH6PDIoqFzlj9MAEXOQ++DcgakArknd
         3eXh4HFwrwcQJ+kehcAYLHdikocPrlHfbWJFT6GbuA1B7vN8ZrXqsTuMMHS/aZ9fM73s
         niyQ==
X-Gm-Message-State: AOAM532E7Gw9E426L2pXzg479jmWKdH8Iifx0ZPk1ZGo+a/xfYILgAgG
        ZtLr4/8n3fSSiUgHQCg6iiVQWA==
X-Google-Smtp-Source: ABdhPJyTHRwsjxos+vTc+S5LWZOwW4hZJnpzBfMbzeQ2WDVHC/WfavYcDs7HSreT09s2gM9FPUzlXw==
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr882918edr.427.1643663516110;
        Mon, 31 Jan 2022 13:11:56 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.138])
        by smtp.gmail.com with ESMTPSA id v5sm13763947ejc.40.2022.01.31.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:11:55 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/3] bpftool: Update versioning scheme
Date:   Mon, 31 Jan 2022 21:11:36 +0000
Message-Id: <20220131211136.71010-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131211136.71010-1-quentin@isovalent.com>
References: <20220131211136.71010-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the notion of versions was introduced for bpftool, it has been
following the version number of the kernel (using the version number
corresponding to the tree in which bpftool's sources are located). The
rationale was that bpftool's features are loosely tied to BPF features
in the kernel, and that we could defer versioning to the kernel
repository itself.

But this versioning scheme is confusing today, because a bpftool binary
should be able to work with both older and newer kernels, even if some
of its recent features won't be available on older systems. Furthermore,
if bpftool is ported to other systems in the future, keeping a
Linux-based version number is not a good option.

It would make more sense to align bpftool's number on libbpf, maybe.
When versioning was introduced in bpftool, libbpf was in its initial
phase at v0.0.1. Now it moves faster, with regular version bumps. But
there are two issues if we want to pick the same numbers. First, that
would mean going backward on the numbering, and will be a huge pain for
every script trying to determine which bpftool binary is the most
recent (not to mention some possible overlap of the numbers in a distant
future). Then, bpftool could get new features or bug fixes between two
versions libbpf, so maybe we should not completely tie its versions to
libbpf, either.

Therefore, this commit introduces an independent versioning scheme for
bpftool. The new version is v6.0.0, with its major number incremented
over the current 5.16.* returned from the kernel's Makefile. The plan is
to update this new number from time to time when bpftool gets new
features or new bug fixes. These updates could possibly lead to new
releases being tagged on the recently created out-of-tree mirror, at
https://github.com/libbpf/bpftool.

Version number is moved higher in the Makefile, to make it more visible.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index bd5a8cafac49..b7dbdea112d3 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 include ../../scripts/Makefile.include
 
+BPFTOOL_VERSION := 6.0.0
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -39,9 +41,6 @@ LIBBPF_BOOTSTRAP := $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
 LIBBPF_INTERNAL_HDRS := $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nlattr.h)
 LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,hashmap.h)
 
-ifeq ($(BPFTOOL_VERSION),)
-BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
-endif
 LIBBPF_VERSION := $(shell make -r --no-print-directory -sC $(BPF_DIR) libbpfversion)
 
 $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR) $(LIBBPF_BOOTSTRAP_HDRS_DIR):
-- 
2.32.0

