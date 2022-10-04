Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE55F4C28
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJDWrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDWrw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588B6EF04
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a23so6161799pgi.10
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=s9xNB+9pkjsuEgXzNEYq8ChwptKRSqWxHSgvfEMrQ0s=;
        b=Ho8yNfeynv/wiVDSv7AoCIX8gQxEEQrLKc6lUzcpM5Vc3EYkNgiG5XIQM+Jjr7dMtM
         t1eR573I1wdnFC+iHyfLX9XwQJCHcKMM/Tgdm6jbwrBEo4kLXISxMmCup7oqyO7Nwf7B
         zduBveYq6foCkSSkA9f3NxmIHe1KGMX3UQDVK90TfxdF1peYK9nvK8otudr5opLiFJo7
         lOgA8LsIb4sPgnJdy8sDq0rap/vfMqDm88KyjpT11atKtWmJixW85ZD9HJ+/vGa5j6GI
         J73zh0FHK4qMV3a8fPZsr3kuPhqhwpP0YApgkwYxCTOuShVyqt1TxL2CkhPF7rvTGht5
         zX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=s9xNB+9pkjsuEgXzNEYq8ChwptKRSqWxHSgvfEMrQ0s=;
        b=2qB2y+gS9qKJhFDZL1w8pX/+gsu2OGhkY6KJp35N3FP6sbL9eMpRj1HZHFt4FyXMui
         O0jpuFHqvwzyGBKIE8GrOIzV8akK1I53rH0tj6HCE+EeyA1hrd6JuSgdqyyb2sRDuCv/
         J2XkLtNfXbEyOPNsIjhQLINp5KujjG7CFqWOqPfvPwrXwY95t5subUKponvPpAsa0ULU
         YfaNisU9fnrxLr7ZCucgKVRbINwMOecEemcJQZVQ83OCFyv18XSSFEzXvqqxzSwUOkb/
         q8AfaKs2MQCl/whgPvx32eW7QnsR5ufSdG1rwIcVTU3eDR3IsA+puNByGkjTFqapk1wR
         eIew==
X-Gm-Message-State: ACrzQf3jZ85P/ADrlYhfY/rNeoTOODgIbfjBTvkbX28gFqUou2pAYWCz
        p1NIy1LOS1/W5qj1KZzRFnYD7Qs8280=
X-Google-Smtp-Source: AMsMyM4NzKfKDwmjRkNs0OHMGzid6oEN7VbwUVKDuwYIAxouBeZTqPfnIlgXPvm8yTPakI4JznE7/g==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr30001571pfh.15.1664923669153;
        Tue, 04 Oct 2022 15:47:49 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:48 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 1/9] bpf, docs: Add note about type convention
Date:   Tue,  4 Oct 2022 22:47:37 +0000
Message-Id: <20221004224745.1430-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
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

Add note about type convention

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 4997d2088..6847a4cbf 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+Documentation conventions
+=========================
+
+For brevity, this document uses the type notion "u64", "u32", etc.
+to mean an unsigned integer whose width is the specified number of bits.
 
 Registers and calling convention
 ================================
@@ -116,6 +121,8 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
+where '(u32)' indicates truncation to 32 bits.
+
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
   dst_reg = dst_reg + src_reg
-- 
2.33.4

