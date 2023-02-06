Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7068C71A
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBFTzn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 14:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFTzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 14:55:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B472940B
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 11:55:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso4962930pjt.4
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 11:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpGBrCO33OvBdZWWz9Tt2l1zmPyCy9RZmal6L8y2AWU=;
        b=jeRrzxZjhIC5zA+XyMZZcS/+XkujED+jMqRhPl3SrxUZZT8X9meD884GzSHqd9MRQn
         sxfo62q9HMIPw1DiODKaLKEDuyaJMn6NBcSx97+Xucel8cBJKQ10JXBPho5ZQdqSBm2N
         vzvydk5Ti3PazZ2rzyeMBG93zvL2vEXQA48Bqs8WR5jT+QTZW7GhNFfEgIifPQ2VQtQ/
         2ZioeSRiXU2MoB/9CNiOYmiugrmXNipJlt2mabJaBDXwvGbXQNIFFgkvUJYEyMaAf/Fe
         OGsIbeDMVBnjYLfxvfOrs2i2ayM9/1V6oArCBYk1gQWfQBX+H/MvWwYKZVF8UCHU/42d
         Cdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpGBrCO33OvBdZWWz9Tt2l1zmPyCy9RZmal6L8y2AWU=;
        b=DADOPAgg+268aG723oLvpR+dxmyp0VOzXk/PFKA1pUEd0LGI4OMCMV4MMFnRkdxcAt
         +wyEbgzpYaRdXWxIZPzo1W3CCs1l7AOdIUrR3aQM+0x3K4ZeZO4PyNftalQlptmLMCmg
         FYv677gB8MZ1/A4++5rWk3KLfGHnwpx0awatVkk0fk5Td/lD9qRvJYiXx8MEhU+ACd8w
         Zng7wSORzKjmLPJXer8RPi4q3quHsXOhWc5/LRuKYqQzo1JNhX7abI3tOtN5WOW7BXNT
         x31QCDjGx6Q10lF4yMOXzHXIxeR7emVobiVAfzFdCxjRg6Z9cyFaC5H81Z3pIk1NqVJf
         wy9g==
X-Gm-Message-State: AO0yUKVi36kAFVIGYkFtSvFWwQ7cLXRvBx6sf/T13jSIzuCMOS3MGbAc
        N7ZLRcIQ14HpouKaOKj1+f64nbGhQME=
X-Google-Smtp-Source: AK7set/jdD6gZTIXyBaqI+fMwFuHm/qJETR2DXBVUhcIdlo7TVJyBWnvCkaGA0tNnt+lSeJrFCzvtg==
X-Received: by 2002:a17:903:2292:b0:199:190c:3c15 with SMTP id b18-20020a170903229200b00199190c3c15mr4580542plh.49.1675713341721;
        Mon, 06 Feb 2023 11:55:41 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.28])
        by smtp.gmail.com with ESMTPSA id p24-20020a170902b09800b001992181b5d5sm1672901plr.245.2023.02.06.11.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:55:41 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] bpf, docs: Add explanation of endianness
Date:   Mon,  6 Feb 2023 19:55:32 +0000
Message-Id: <20230206195532.2436-1-dthaler1968@googlemail.com>
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

Document the discussion from the email thread on the IETF bpf list,
where it was explained that the raw format varies by endianness
of the processor.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..3358769dc1f 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -33,7 +33,7 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate value
   (imm64) after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows:
+The basic instruction encoding looks as follows for a little-endian processor:
 
 =============  =======  ===============  ====================  ============
 32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
@@ -41,6 +41,17 @@ The basic instruction encoding looks as follows:
 immediate      offset   source register  destination register  opcode
 =============  =======  ===============  ====================  ============
 
+and as follows for a big-endian processor:
+
+=============  =======  ====================  ===============  ============
+32 bits (MSB)  16 bits  4 bits                4 bits           8 bits (LSB)
+=============  =======  ====================  ===============  ============
+immediate      offset   destination register  source register  opcode
+=============  =======  ====================  ===============  ============
+
+Multi-byte fields ('immediate' and 'offset') are similarly stored in
+the byte order of the processor.
+
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
 
-- 
2.33.4

