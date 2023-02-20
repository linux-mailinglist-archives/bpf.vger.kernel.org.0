Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF269D65E
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 23:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBTWhw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 17:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBTWhu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 17:37:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39351F4B9
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:37:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v3-20020a17090a6b0300b002341a2656e5so2697692pjj.1
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5U/nJ0xEv2k8O3/eZJasRzlsRSZg0C3t8e0K4eKUJs=;
        b=iUyEZvg8fDzGfwA+fNEtVWlhDvkCFHDGInGooqXYhgSjNxbb2fpMuVuJ8pyjnHbYJn
         WUbckEY9xoMbdyXtOh+JWzNuqxRR5sIw8R1P+x+d5sYMCw2xUS2Y6ATDkUgMwpgNuGyo
         umbI+D6t9Homgu9FcTNL0dT9L19jfgaJ76vDh9G+sTVxiISXYGNHuHEZYVJPpp5fQYGu
         /enzXAkyEtAwvzycI+o7/H7sUWgMEZX4yiqC9646v3udXI5GcP+YJvGB273M0hXXv7so
         teYvJQz2xJuoOoPEANK51PrNMMZoXE4uMnSzZkllFG+DHIzHw7Ek10hORqA07WKxlSxk
         WSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5U/nJ0xEv2k8O3/eZJasRzlsRSZg0C3t8e0K4eKUJs=;
        b=BHp8mBVu2rQLWsze7gZgbYRojq9/kqxMn8kVLPbMprFKA0AUWdCHe/9DPiH4JF8VjG
         H08zwY0l5FMEOSXxMNV3CLQQDys9TEJaOG5qyF64NDbZwSosDC7cfocqllVmNv8N4ftS
         Oe50F83+IKbGDBFtLRbw1QH+/EFDSZ/kxNGZa77w3VkXfeZ+CQ5934lYC2RBs9cmh3Mi
         5XyVSzB/UMtvWZt3D25TtN8RdTOKuc/OuglQthFH+grrMOYiWsq0/HwYv25/J9VqEPdw
         GHpr1C4SnFfJ1vzBBJY84vFbMwkdmusP79tlHfYCckUtDfM2Kj1Q17roEqltI+hQSnGY
         Wjhg==
X-Gm-Message-State: AO0yUKVp15IYNAXz/ee3S7to7nfv3JU2lHowDupypGFvfjEq0g5l1BAP
        dicvy5WIckybWvaVC05wAvB6grL2X7Q=
X-Google-Smtp-Source: AK7set9EcWhgt+IGVRRXCrS8uGL021IohbaEA5YwAqRHdubiBfa4VW+iFGh3HOoNqypXRl+95nZ4yA==
X-Received: by 2002:a17:902:cec5:b0:194:62d9:9a86 with SMTP id d5-20020a170902cec500b0019462d99a86mr3758672plg.59.1676932665813;
        Mon, 20 Feb 2023 14:37:45 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b001992fc0a8eesm6883783plb.174.2023.02.20.14.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:37:45 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2] bpf, docs: Add explanation of endianness
Date:   Mon, 20 Feb 2023 22:37:42 +0000
Message-Id: <20230220223742.1347-1-dthaler1968@googlemail.com>
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

Acked-by: David Vernet <void@manifault.com>
---

V1 -> V2: rebased on top of latest master
---
 Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index af515de5fc3..1d473f060fa 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,8 +38,9 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
   constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding is as follows, where MSB and LSB mean the most significant
-bits and least significant bits, respectively:
+The basic instruction encoding looks as follows for a little-endian processor,
+where MSB and LSB mean the most significant bits and least significant bits,
+respectively:
 
 =============  =======  =======  =======  ============
 32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
@@ -63,6 +64,17 @@ imm            offset   src_reg  dst_reg  opcode
 **opcode**
   operation to perform
 
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

