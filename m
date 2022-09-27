Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB35ECC94
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiI0TAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiI0TAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:46 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA581BF0D6
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so10227003pgb.4
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gajT+qZhqxOHyN30cJ1Tk/WUWyKoP1GuuIXodlFuV/s=;
        b=LTHZomXONDXGYFZIQzJorvySYU4L1C/V/OSqnvRWuOS8URws2bgDo7VEaVr72zFlvb
         YUnKf+3Kuatn01uSeoqU2243U6lV3o/adLwNT9Lds7Nd6/hhW5WuSyQ+HGniTUKX+UGI
         MxwML1W0OqTnWUcXJswPOlUbIeYDMKpJTZf5yj4y+LLuJuAp2nRfdHOq9MQNncxRSJ2X
         nJVQ1L3tca5nYSxwTTRa5ACs5bUFPgn9V3UDjSA6jFZ4dzJC+NWBojkXQVZ3rHb5/6Aq
         LPMUbjsegQnzN7mesya4qs1DKuVpyKG4i2/jNFYnoDtgXvqXwmSNOG7cA+21ua1gPnkO
         ZdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gajT+qZhqxOHyN30cJ1Tk/WUWyKoP1GuuIXodlFuV/s=;
        b=eW/3Yk2Ada9SluHmPXGjRfJucMHMDfaxAiKQduJTc1l3Ztje3bDigF4eUon7ShUz/y
         Gzb5xCjlkJogrb8QWAz9cgv7a50yE1R+zucY9vl+FQqPZPjwNlpYelyTRwMqjjOxQFaq
         S0tHzw2s5vFZgFS2arF2e64JIev4T1tb4f1zpjrLOLwNdcntVbyVvwclagWX1brEXy+G
         HcrPzoiOnclfV8TfYYRTLtGPBwoOSOUyAel1tJ9D8HRUhYfkf2Xi3Q/K2Sf97ga61VEo
         HkRcWbPZjDGCp5jKwq5CqLmunzxXbxL9XHzp4F2gvleH/7MqVjlqB0I7spkWhuOzL1W9
         tsSQ==
X-Gm-Message-State: ACrzQf33A8z/GUr3GPEq3zMh+IiMwbF1Vw4za5dMyllJ6kTgprMdii5S
        frMX4GQwcr81MMw/el3jSuC8lqnjiY4=
X-Google-Smtp-Source: AMsMyM7ZpqLd8FDEZMczpfwsrP9CLTRyyE9/CbnfhrVaTS561LJmN4ax4743q+FyOd9751bhYLn1Nw==
X-Received: by 2002:a65:6e89:0:b0:43c:e3d8:49f1 with SMTP id bm9-20020a656e89000000b0043ce3d849f1mr6036597pgb.315.1664305232101;
        Tue, 27 Sep 2022 12:00:32 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:31 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 15/15] ebpf-docs: Add note about invalid instruction
Date:   Tue, 27 Sep 2022 18:59:58 +0000
Message-Id: <20220927185958.14995-15-dthaler1968@googlemail.com>
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
 Documentation/bpf/clang-notes.rst     | 5 +++++
 Documentation/bpf/instruction-set.rst | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 528feddf2..3c934421b 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -20,6 +20,11 @@ Arithmetic instructions
 For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
 ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
 
+Invalid instructions
+====================
+
+Clang will generate the invalid ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction if ``-O0`` is used.
+
 Atomic operations
 =================
 
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2ac8f0dae..af9dc0cc6 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -303,6 +303,9 @@ with the remaining registers being ignored.  The definition of a helper function
 is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
 the number of arguments, and the type of each argument.
 
+Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
+would be read from a specified register, is not currently permitted.
+
 Runtime functions
 ~~~~~~~~~~~~~~~~~
 Runtime functions are like helper functions except that they are not specific
-- 
2.33.4

