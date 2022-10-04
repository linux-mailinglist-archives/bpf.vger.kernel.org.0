Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2335F4C30
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJDWsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJDWr7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F056E2D7
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f140so9097284pfa.1
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=86DZm2UiO+L5P+sRamq8spEneJ7aiz/Oq2WFu7Wd/7A=;
        b=qG3REht8Maufb1Qy5QyNwWhs9CG12pwGmQn5QQ1DfeQph8D2IML0JA1X1p1ik2Kc+p
         vp2ignzktBCjP08Mg/fXj3o04r/jEnBwguBsq+6kuU4XGmoeB6MZgbCfSbRMkyrUnjkw
         iOQ5xnZ9XH2I8UfbPifwCbN5uRcDR5FEgFipJLNk690SnNfNxPM07jUmdVieWcIxikbc
         6bNQLxWtWe3PRAbVI7y5jYIPWOeUQXCWQSiBSBQ/nvnHYtshud/BKkRt5YfK6w2T/4NH
         6rECV8vKzq+IFTW1AjqKNeRZL9l4z6+ILDrcP9M7JJJXEyS0lxKGtkMKNJ7cBMjd47qB
         Zt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=86DZm2UiO+L5P+sRamq8spEneJ7aiz/Oq2WFu7Wd/7A=;
        b=fVvD2YMbKnw1QeSFkapi0U7EkofDGD9WcKimmUv5SBhQMICVZnzeDg6TcZL67AEW1P
         PZYeWVgrWmc8xSsb+kgMbavoO8ynNz244bWm00fr4mQgpZmjX8JHwHIgtxaPWRwyU92h
         1TyaDmaL2FK2i6PcUXLkL3Jd20Ljsk7EoMwF5aHDC7vt9AHodxKXicZj/4OMeJNUJXtP
         Cm/6Tzt7LdpJHsmk50QRm/ny1uEKbNHIUFQgEzAWnYHmi33dwBRNBtYkANICSX9R+JRh
         NR6ccbqrErdsC+Z3qeN+y9QN0oqa1BD/30WrPuBCgWfPgvt8rxNIFc3JvOWXi9fpbX9K
         k5cw==
X-Gm-Message-State: ACrzQf1uLPfBlIGyguy9Gs75NAr1v0NtRil7LJ+TpHQ27sCG/SI6SmCz
        AF7UxDJ4MfhlHrPwacV+wJDtnBLPE8U=
X-Google-Smtp-Source: AMsMyM4LrJB8FA5uVcfet0C8h9VnqgC0A5Tv1t+m+Vpzb/tvsLGhevzpemsG/P5xopkmuBVTGecnaw==
X-Received: by 2002:a65:6954:0:b0:445:fdb8:738e with SMTP id w20-20020a656954000000b00445fdb8738emr15776913pgq.520.1664923677365;
        Tue, 04 Oct 2022 15:47:57 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:56 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 9/9] bpf, docs: Add note about reserved instruction
Date:   Tue,  4 Oct 2022 22:47:45 +0000
Message-Id: <20221004224745.1430-9-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
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

Add note about reserved instruction

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/clang-notes.rst     | 5 +++++
 Documentation/bpf/instruction-set.rst | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
index 528feddf2..40c618551 100644
--- a/Documentation/bpf/clang-notes.rst
+++ b/Documentation/bpf/clang-notes.rst
@@ -20,6 +20,11 @@ Arithmetic instructions
 For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
 ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
 
+Reserved instructions
+====================
+
+Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction if ``-O0`` is used.
+
 Atomic operations
 =================
 
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index d0685a06f..72d59b3c6 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -301,6 +301,9 @@ with the remaining registers being ignored.  The definition of a helper function
 is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
 the number of arguments, and the type of each argument.
 
+Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
+would be read from a specified register, is reserved and currently not permitted.
+
 Runtime functions
 ~~~~~~~~~~~~~~~~~
 Runtime functions are like helper functions except that they are not specific
-- 
2.33.4

