Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B064A5128
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 22:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiAaVL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 16:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiAaVLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 16:11:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A696C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 13:11:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c24so29758824edy.4
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 13:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQmEESnjlSoQ6wiVFz0EdUVr4f3octanu8GZ1I2hj7A=;
        b=ibPN07agU2xjkpXfEt4RUAeRveUqaY7j467Yo5MV/C5b7OMJLNJiUFaVmxpzBXh6ZX
         n0pzuj+5niGaDqMqwgleSgFpombppYAcnDC/qsYW7MGU0UqHbPGtnzzyP2eJsR2e5lvk
         bvhgKC40exea1k8OmWXATg1LxKOouG575jpQz89oLtTc9eVQP+Fm/oxK7XktvWb+1Fzw
         miNR8Qmg7GKzA9cqFq+J4xvcnX/B2lg/RyH9c2D4ijWfR9Juu/t+brDdlqDhXRiBagBh
         1l06CosiUV7QBFBfr7NQ9T03JDF5s9d0yLszFdxINzmOSxHFbo3PB+j6A/FAmkPjUgcw
         Zlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQmEESnjlSoQ6wiVFz0EdUVr4f3octanu8GZ1I2hj7A=;
        b=D0XtAFNkK6WFzL1EvP51k9cnaUvcTTVIjLhzsMBb5YDwFvpwSiS4JKGcT8PwYY7ss7
         ejOxSmY7SNHZiZU/KhKlGOuLtHroqLJXLrTGeMIRp3EMnYxWLQ/q1SHSGi9F4epd1/Iu
         O1vI7Gq9+csl0n1n5sM3ZZ1n1R9QCRhg3w63WQ/kze7+lpdlULh1tQ5U0nngUq5I7Sdm
         R65JpTrQJvdEaocTCEETzvmfUpyJG9SGcI4VFPkOo2QNodQG07bu9bblYu6sidChEZoh
         f7EwAN32635oeKjid4Voc0xg8yf6CS09/GV3VPVv5IFyuIdR0AfQNMSJz2wyRjLC/MVN
         9U0g==
X-Gm-Message-State: AOAM531AyNxO/170XVPASzlrh0xDix+5etGZvJRzq0/F7RBPoGecFsze
        cEIfhswAVHiSXbMeXWmCdo1Bd9awC3DZ3w==
X-Google-Smtp-Source: ABdhPJx18y/ZLW9TWk0doHqtxu4inrDSaXfbnH+jfGdtLSyO3S0aPQHgPgQnw9DNH2v3MpGqY7HU6w==
X-Received: by 2002:a05:6402:42cd:: with SMTP id i13mr22001683edc.121.1643663513756;
        Mon, 31 Jan 2022 13:11:53 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.138])
        by smtp.gmail.com with ESMTPSA id v5sm13763947ejc.40.2022.01.31.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:11:53 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/3] libbpf: Add "libbpversion" make target to print version
Date:   Mon, 31 Jan 2022 21:11:34 +0000
Message-Id: <20220131211136.71010-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131211136.71010-1-quentin@isovalent.com>
References: <20220131211136.71010-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a target to libbpf's Makefile to print its version number, in a
similar way to what running "make kernelversion" at the root of the
repository does.

This is to avoid re-implementing the parsing of the libbpf.map file in
case some other tools want to extract the version of the libbpf sources
they are using.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index f947b61b2107..e3a1ae7efa33 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -108,6 +108,9 @@ MAKEOVERRIDES=
 
 all:
 
+libbpfversion:
+	@echo $(LIBBPF_VERSION)
+
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-- 
2.32.0

