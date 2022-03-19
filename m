Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970574DE965
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiCSQpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbiCSQpF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 12:45:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF8219D;
        Sat, 19 Mar 2022 09:43:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so454725wrr.9;
        Sat, 19 Mar 2022 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU8K3PgurQuN9tqSrXLYpKKI8GsLMkljTred0jAx2VM=;
        b=n5WejALd0BEK/G3IJgspQKobNfATE/oejPYQ2Z9YcsXEmrzeayQemriE7PkEc50I6G
         wzvT8CO3AXn/80qFs63w0ZRldkTUCDiYQC7jCHeWSjyKUB19v1/t/UQzbzBsWzHGvP8h
         ZEUV3BJNuFfmwvgnOrPLPVi3rke06pwk0s1D5SMpG4Br8FHnimGgNdSDtHZtJ+roHED3
         kyFjrgDqH5G7SS+sC27t3tF2+fiFmvLI5W4r9khJB7Fj4SlyEHdb5vIhADgTqM1V6Vy5
         49eF/iNvVHBYaU/Fw1aNjB/azSqYlQipwV7S+PutvVa/hOeEoIBPz5bBGGmDAHyqdbtp
         JjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU8K3PgurQuN9tqSrXLYpKKI8GsLMkljTred0jAx2VM=;
        b=4t6r3RQk/ncvni+N9FKGMXFkrv80tzTMU2vUPlQ/2arOIrg+kHk23K3PkXGRwYa7U1
         I+N9iwzYRZPvzH0q1xesrHWV7QUemax4jDDC7xdK8znCYXLWUFIRptVkRsd03NvlKhGm
         XjdUjhGP2kGLe9UX+1LKYmxn7UB0kUkAvWmwFqJoqYWvJHLSY8gdSYvJybxwUagfG1ss
         CpQvbtxYNIYaO8jrIypDh+DaJW9E7ukusEcJj9WZa34eCt163jQCNW/SVyMwyKlbf4w9
         ChZoJrlWwVdbZIbuiN0wUwbEwiqyXmfjbrC0MCAA94oOGeJPZL3GLc1tKVNXgBfqx/Ox
         A3pg==
X-Gm-Message-State: AOAM532c27m17zNyPXw8c7IAqbefyZpanxr1rAS49Mjk2Kw46CACDP2R
        CgWc2sZvyNCOjLAzaEK4uYFLkKDuDqo=
X-Google-Smtp-Source: ABdhPJxE8W7CWYqz0bRVsWCuXmcD+N4OGG+iaa5vxcG10S6AOk97tZvzNTlVf02q5nCmtwX0rFFMkw==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr12594404wrz.690.1647708221993;
        Sat, 19 Mar 2022 09:43:41 -0700 (PDT)
Received: from localhost.localdomain ([197.61.132.32])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm3642908wrv.49.2022.03.19.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 09:43:41 -0700 (PDT)
From:   Mahmoud Abumandour <ma.mandourr@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org,
        Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH] docs/bpf: Fix most/least significant bit typos
Date:   Sat, 19 Mar 2022 18:43:37 +0200
Message-Id: <20220319164337.1272312-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.35.0
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

The LSB and MSB acronyms should not be followed by the word "bits". This
fixes this issue and uses the full phrases "most/least significant bits"
for better readibility.

Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 Documentation/bpf/classic_vs_extended.rst | 4 ++--
 Documentation/bpf/instruction-set.rst     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/classic_vs_extended.rst b/Documentation/bpf/classic_vs_extended.rst
index 2f81a81f5267..551d788659fa 100644
--- a/Documentation/bpf/classic_vs_extended.rst
+++ b/Documentation/bpf/classic_vs_extended.rst
@@ -252,7 +252,7 @@ parts::
   +----------------+--------+--------------------+
   (MSB)                                      (LSB)
 
-Three LSB bits store instruction class which is one of:
+The three least significant bits store instruction class which is one of:
 
   ===================     ===============
   Classic BPF classes     eBPF classes
@@ -284,7 +284,7 @@ The 4th bit encodes the source operand ...
 	BPF_SRC(code) == BPF_X - use 'src_reg' register as source operand
 	BPF_SRC(code) == BPF_K - use 32-bit immediate as source operand
 
-... and four MSB bits store operation code.
+... and the four most significant bits store operation code.
 
 If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of::
 
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 3704836fe6df..3d123a9b3f5c 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -36,7 +36,8 @@ Unused fields shall be cleared to zero.
 Instruction classes
 -------------------
 
-The three LSB bits of the 'opcode' field store the instruction class:
+The three least significant bits of the 'opcode' field store the instruction
+class:
 
   =========  =====  ===============================
   class      value  description
-- 
2.35.0

