Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF95ECC8A
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiI0TAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0TAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2475D1591C7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b75so10484398pfb.7
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GV1tDUBghRbu5uEg8UnHOOqFcAerIG+mQxzutQ0z+Os=;
        b=ddRbAX1QtEYosE15vmR/VRMUir+NVNCP9WUEwtQmPzcvJiLt1juNYY5m0gREfU57sY
         i8IERXm2weMIJ+M/BKFYGLcp2Xx9II1ny1wuxKBhdaUEhnI652zZ+6H1Q24Jopj23lKw
         KXExY6oYrVnkiZh8abkr9z5wblR3dhfjH2ZpKrGjZenuOqA6BtsEY2bVwpkgOKc4j77p
         Gifearp+J8S4vI3ScOzuc3ntWWYoWF6z4aXRstfzHA2UV/yJx123Y2L4haRmTatD3cZ5
         0MZED7xoWgOw2okmEZGwCnbW2ih1hmBpiVemXHI50vM8z0JDa0iwY80xjt060PO3Q0Ou
         H5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GV1tDUBghRbu5uEg8UnHOOqFcAerIG+mQxzutQ0z+Os=;
        b=GFznEfiam1jyb1nSN3V4TeJ+MOrIvZcko1b+CrnMKM1UGS6Hbz5drpqOvTIzfgoh66
         3UEroyS6HMwFJ79gX0/WPWMSpBWx7LFYvCygxiMo+9FexO4Y7WEqJm+yuegAq+Oz++bM
         XHHmpUA3S7zw1EtuE45d/+kKZYOaglF4W3EG7VeCfYzsgMvAxku52mpxS8xoNBJX7kRD
         ik3rKHFGvLVWKG13DoKK5P/nxY2+knJU7xsPyB/g1HPcLUGQudkWueImRlVMdvVrtGVG
         F7ELm1sx5kFa7w24PX6inJ1jio8KG+e++u+lgoRw0b+wMawpcDFIcFVhGUxOMjqUYRtS
         wJhQ==
X-Gm-Message-State: ACrzQf18R/vYiunYoYlL6ozbxbVVQxz2uKA+E0JJrJfNdLdX7Vno472y
        5uhbw3YYak207dj+d55NvlfZ4dEaoT8=
X-Google-Smtp-Source: AMsMyM67dGmsCAxQ7Hq5wYgjAUeh37/mHopfzjcOX9MG/TKJyhRHFAQKZIK4XV95sRUcsudNZ6azbg==
X-Received: by 2002:a63:1d22:0:b0:439:3e7c:8af7 with SMTP id d34-20020a631d22000000b004393e7c8af7mr26076920pgd.78.1664305219167;
        Tue, 27 Sep 2022 12:00:19 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:18 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 04/15] ebpf-docs: Add Clang note about BPF_ALU
Date:   Tue, 27 Sep 2022 18:59:47 +0000
Message-Id: <20220927185958.14995-4-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/clang-notes.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index b15179cb5..528feddf2 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -14,6 +14,12 @@ Clang defined "CPU" versions, where a CPU version of 3 corresponds to the curren
 
 Clang can select the eBPF ISA version using ``-mcpu=v3`` for example to select version 3.
 
+Arithmetic instructions
+=======================
+
+For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
+``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
+
 Atomic operations
 =================
 
-- 
2.33.4

