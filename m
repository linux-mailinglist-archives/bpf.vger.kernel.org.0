Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A42508CE9
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbiDTQP1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 12:15:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92181BE96
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a5so1678309qvx.1
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHZuJ5hBQch5GDdgmisORzHMbEctPPdvRzGD8Dsrh+A=;
        b=CpQxoB52hIHIhWLIRTsJxE6PYhItTvBMQHZ0Gpw/+Snc6bTBOACG/PEtJaR1Dx2/eb
         byunYWfsDLDGEwQ9iWB0gqeyq5I8lJLfQDuPFcerW6uL8wcBdMoBE2JyQKJuEvE3+Gu9
         0h5ZJOaYWkPaprbvnM532MVNRBB4AjNQuS877VH18g8d220LpnHmsR1xOHpMwvsRJrbv
         0EeJhPyp5jbuce1ks/AtwOcl6z20SbMzuz7NZ5yucIHrPkjYLCZFd/Doyv0CS5DCImPI
         2SIiloM+oajza5O25LTMQdi+WltZdABbHf1bNQgT+e5HKTI8tctFRv7v6+2g8UqAUnjX
         Cw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHZuJ5hBQch5GDdgmisORzHMbEctPPdvRzGD8Dsrh+A=;
        b=J9VrfgEFkAcSRH1Vcbs2l7sVFSxCtxwOfB+SFRy3vdIE0q57bgbzH2PZRnYq1kXq3J
         07n45puE2ltEIrwUataqRHip+zj4592mdZxJ7Swt5SqJeKVRPUQxUsRMXBQfgCZhu+PD
         MelxYHyRuBupg/c6FvtlYz1gcsW0AtwP08txIFsRQiXooHYBPGTzklKuzc6CnLr5j6QP
         M3oU+zh0b4F9YRxYXuIPa85EtBa4EAfSLqFY4eVGcUpQ3HllN9mAgkb8Vp0oag/7rBdf
         Y+SIkEKO8JTn3U3J6I5rqJ4A2a8Sfm3z0o37be4QEm9husAZDOOtr+qPtIjg7XBD1tg/
         p9GQ==
X-Gm-Message-State: AOAM533iVtpCvImcpcGpKBpn/aTdrfTcsidPFb3SzxoSfLFYpdeBMvd8
        vGMNdeRqx1VJs+9KQpSKq3gMh3wOzI4Gmw==
X-Google-Smtp-Source: ABdhPJwu73MMgWHRjGfO64N8vgUOxLrDFULtWa0U54MBEz4hGkdN75kTiVbsVSbW674bvlaQMVgLUQ==
X-Received: by 2002:ad4:53c3:0:b0:432:6d49:b4ad with SMTP id k3-20020ad453c3000000b004326d49b4admr15889067qvv.83.1650471157472;
        Wed, 20 Apr 2022 09:12:37 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id f28-20020a05620a20dc00b0069d98e6bff9sm1694090qka.32.2022.04.20.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:12:36 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v4 1/3] Add error returns to two API functions
Date:   Wed, 20 Apr 2022 12:12:24 -0400
Message-Id: <20220420161226.86803-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds an error return to the following API functions:

- bpf_program__set_expected_attach_type()
- bpf_program__set_type()

In both cases, the error occurs when the BPF object has
already been loaded when the function is called. In this
case -EBUSY is returned.

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bf4f7ac54ebf..707cb973b09c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8551,9 +8551,13 @@ enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
 	return prog->type;
 }
 
-void bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
+int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
 	prog->type = type;
+	return 0;
 }
 
 static bool bpf_program__is_type(const struct bpf_program *prog,
@@ -8598,10 +8602,14 @@ enum bpf_attach_type bpf_program__expected_attach_type(const struct bpf_program
 	return prog->expected_attach_type;
 }
 
-void bpf_program__set_expected_attach_type(struct bpf_program *prog,
+int bpf_program__set_expected_attach_type(struct bpf_program *prog,
 					   enum bpf_attach_type type)
 {
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
 	prog->expected_attach_type = type;
+	return 0;
 }
 
 __u32 bpf_program__flags(const struct bpf_program *prog)
-- 
2.34.1

