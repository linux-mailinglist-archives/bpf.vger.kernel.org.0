Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491D650728F
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiDSQHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbiDSQHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0542FE57
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id e128so11732229qkd.7
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7ZgVuHYc8Ff4WF/8/g6oS91YrTeGjweqOqxbQpTaXc=;
        b=Ee6i2pfdTs0WPmijL0vPfbzFJzEfTDMkvaYLflUWXyXzvevENbN5gmp9oAi5tg8JKZ
         vNCHz5FKMfV6h0+sUigTWVt2p8i1wTF+Zs2F6Hb1sxjgB3IRCQZmJBZlD+4ctzQhKvIs
         HM3hER6ermpHWncxo+QHlcJv8G5h/oL5sih9wm4opL2MTfiv6UFaRkClFnKGnsgGIIo1
         Kum4gCvXJJLBRWt6gla9NmpV/CCqQrT9xHfvF0YIRbEzMagREREITzi6NtHjpWkg4DbQ
         +4kXmy0cYE8nfs/C+beAwqW+qP4dAuHFXwICD2SCuxv+12uV2jP/YKQ6kZwQfEbxMqWb
         T6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7ZgVuHYc8Ff4WF/8/g6oS91YrTeGjweqOqxbQpTaXc=;
        b=WwCH4dkiN3KMyUQOti8Y1m0qnmE6B7SpDSFnTHWVAYy+dHKOBAuwA/2hxzKLMC9bbt
         AGNMKwS/6mgv0m31bv8CTHECrpnjAruHApNwa9CpuLfIm8PCZR816FvvESZ115WyDSyP
         /M63qAWh+IPgqGk71UoIHY9a70CpN8Ft6bmcWmyI1bIaQQjh6ZUvoziTduPl0jhoFTIu
         N+fyKRbP2KXUdAsvhape3Wx3h1lI0MTacEUFQ8LYBHgEU7arHwrBxQ/XiJtg4SFi1xx/
         vJ2z1uTXk4tOCbS6JOKd0dIHI7LWF3BrCsM9pr3aNi/9xEWoBKsrta+q8qrBQULkIgCi
         Ciow==
X-Gm-Message-State: AOAM530yfmbw2etL1opDuoKZFZdpqix1yD1TBtpAuyk7vHqo5grc9alO
        G/JvevmlRFO2xpaqdIW9Z+SXUhJn9hz8gg==
X-Google-Smtp-Source: ABdhPJwNYLdaBdvbkM/QOSAl7pkv2Hnm/DMJeHtGwRxIpnOsAOv6lOsMqKQiZQFoTLwSETiZAGVsPQ==
X-Received: by 2002:a05:620a:2221:b0:69c:8cb9:937e with SMTP id n1-20020a05620a222100b0069c8cb9937emr9891181qkh.547.1650384256730;
        Tue, 19 Apr 2022 09:04:16 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm232204qtd.44.2022.04.19.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:04:16 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v3 1/3] Add error returns to two API functions
Date:   Tue, 19 Apr 2022 12:03:44 -0400
Message-Id: <20220419160346.35633-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 tools/lib/bpf/libbpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bf4f7ac54ebf..0ed1a8c9c398 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8551,8 +8551,11 @@ enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
 	return prog->type;
 }
 
-void bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
+int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
 	prog->type = type;
 }
 
@@ -8598,10 +8601,14 @@ enum bpf_attach_type bpf_program__expected_attach_type(const struct bpf_program
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

