Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015625ECC93
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiI0TAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiI0TAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A68161CC1
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so10887170pjh.3
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1IK9f71Lu9DwK4AC/QfvBLYh1EUy09UxmzY/Y/A+poE=;
        b=hPZ8uChI5QK5l0A+yP+dFDX4k+8nkDCkWY6v1TzPw6f/DKz2o9+gv8Iku4f0vvLs16
         HG+VhTt68vDbg2rMarOv0IJ83G6+Pu9WSWr/8feecDc06FNB65yPJL0J3mz/L4Yg84ES
         ZNQzkXF2UpBDpzOxjnfxbMcqSv+pFZD53JQuL0ytn2O8Hyg/Da9RbN9TFUigLkB2+t3o
         4u8NS7yT72oexkyLdIwRhq15N9lx8tUj0W+/rYdwMFtnK7LVSoufDaJQrzu0K33lDP77
         /fjb6DfYZqre5WnKt/WC8Dvp2PUZRIWb6SY/0CbLbG6pONxJ3cKIgXNAxkS1zuZGXioO
         Dfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1IK9f71Lu9DwK4AC/QfvBLYh1EUy09UxmzY/Y/A+poE=;
        b=vgnKPiOhIKzHhoyeEjisHg47wLfI3IB8HuQoR1iFXQSKjvD3o+T5wrOguga7fbChSG
         q8iGIn6jGjPl1gUMEqwhdYrJOBBJEMbRxj9g8u+q0k8JWPTiSaxBG4uw+C2zlilVofOD
         TuPI+QMwei6kSxPapOxQ7z0VkWPJWBqugNFFaRcEERhLZkzZANJTTzNYqrMgf3Cc8kh5
         IeDmPJJGHd+UwnAGSAHHF74dsrP6rTtYFl68YAeT6fl7DGKjGXDib6MxAuQaP8+HOqex
         3eRuBblH47kiryBzakE/AjZrW/znrBXWOKu0wUvcWvIKId6obp9f7Z3ic6R47l8tRWIs
         tKeA==
X-Gm-Message-State: ACrzQf3CA32dNKqHeancBwIjESzXgKUqo68nmNzaGeiutAAORvQGhQ2K
        U/UUMa7bxvxoLr1pUW3xzCcNSGN4N64=
X-Google-Smtp-Source: AMsMyM4yfPAKnDypkFN7w+FAhRAhhZY9T5gme1lLgR+o9ia7DtK4kxebob0rinByd1CQzLJ0Aztoow==
X-Received: by 2002:a17:902:7ed6:b0:178:378a:ebbf with SMTP id p22-20020a1709027ed600b00178378aebbfmr28827436plb.117.1664305228957;
        Tue, 27 Sep 2022 12:00:28 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:28 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 12/15] ebpf-docs: Add Linux note about register calling convention
Date:   Tue, 27 Sep 2022 18:59:55 +0000
Message-Id: <20220927185958.14995-12-dthaler1968@googlemail.com>
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
 Documentation/bpf/linux-notes.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 522ebe27d..0581ba326 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -7,6 +7,12 @@ Linux implementation notes
 
 This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
 
+Registers and calling convention
+================================
+
+All program types only use R1 which contains the "context", which is typically a structure containing all
+the inputs needed, and the exit value for eBPF programs is passed as a 32 bit value.
+
 Arithmetic instructions
 =======================
 
-- 
2.33.4

