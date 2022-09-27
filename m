Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D55ECC91
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiI0TAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI0TAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF902189395
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f193so10262808pgc.0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XZ+XKQt00DavoiQMa2NSCBNZMRK/jHP2FO1uzN0dL/s=;
        b=Ey96kWaYML7ccOx7SUkzdrA8QktBiBJNjTsCiIQRUiXzdmc4l84Jgkdp6yos7Dngxq
         oD8wsmQq2/khBW6pAe5uVtTeNo4P8IiYZdZ6D3OfOoWsCo1Ozf+YAo3njXLrT1wd+7Ql
         rHfiy2bDiSVKGcFqYpxAGR2jlQengmGUqfhNSTv/0SjKNJxCCckYkYuxbLYa7NCnpZEe
         1AnwoGOOgXE0IgxsT+wXWwaZqxOQ9adjbjtvSNVi1fhFN104jnkFDm3+B86CVBf72caC
         WEFOJf6/aPPAhIhBwlUIzrHusy80QdroOdmZM9nr/0+DIT5gGJjfAfVKkd2zs1BKM7GW
         LaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XZ+XKQt00DavoiQMa2NSCBNZMRK/jHP2FO1uzN0dL/s=;
        b=U9Ip7w2oTthto1pfJ3zYySHdSfzQlKOQeP+RKFNaVlwvlyAAVY8FoOG8grSDkB4gXi
         l6b4lFhVJXJj9OLka5skGhkhNJGHHb6tHQrAw06Mr13EMTOr6l+ow2/gQ/LurPCZpvDX
         /eu7kY6FJpd3W2t2d+geE1D2S4FxvLsrRwNrnS7brKQSlY+GhVuE+FnmVS522prC2ADp
         6syfX7/toVHOsGsyUCnqay/9lQNEcrUnZLIDXctHFmNDB7007hhXEdVK72T8lXSjTA/n
         GYmjPgc0G61IhoMmOxIIfJmGn0Mi+xANNvuU4Sklyu6g3ANFHwLt7EzTSRw+5UphX2af
         h0ug==
X-Gm-Message-State: ACrzQf1wz7HICxFnxwg+nUAq89rHZOcLTY444fbVgj/fWXX98u/WxPQZ
        kUFPYNd6w1NKcT0CRfJcmxxRn5Og5a0=
X-Google-Smtp-Source: AMsMyM6BNretQuhpSGz0q1tuHHCRcRqY4m8yMK2pChzKktrDPkI/+GDnvFhSSArnytvFYJqI17XovA==
X-Received: by 2002:a65:42c8:0:b0:41a:8138:f47f with SMTP id l8-20020a6542c8000000b0041a8138f47fmr25959879pgp.476.1664305226380;
        Tue, 27 Sep 2022 12:00:26 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:25 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 10/15] ebpf-docs: Add appendix of all opcodes in order
Date:   Tue, 27 Sep 2022 18:59:53 +0000
Message-Id: <20220927185958.14995-10-dthaler1968@googlemail.com>
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
 Documentation/bpf/instruction-set.rst | 197 ++++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 926957830..b6f098104 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -408,3 +408,200 @@ Legacy BPF Packet access instructions
 eBPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
 deprecated and should no longer be used.
+
+Appendix
+========
+
+For reference, the following table lists opcodes in order by value.
+
+======  ===  ====  ===================================================  ========================================
+opcode  src  imm   description                                          reference
+======  ===  ====  ===================================================  ========================================
+0x00    0x0  any   (additional immediate value)                         `64-bit immediate instructions`_
+0x04    0x0  any   dst = (uint32_t)(dst + imm)                          `Arithmetic instructions`_
+0x05    0x0  0x00  goto +offset                                         `Jump instructions`_
+0x07    0x0  any   dst += imm                                           `Arithmetic instructions`_
+0x0c    any  0x00  dst = (uint32_t)(dst + src)                          `Arithmetic instructions`_
+0x0f    any  0x00  dst += src                                           `Arithmetic instructions`_
+0x14    0x0  any   dst = (uint32_t)(dst - imm)                          `Arithmetic instructions`_
+0x15    0x0  any   if dst == imm goto +offset                           `Jump instructions`_
+0x16    0x0  any   if (uint32_t)dst == imm goto +offset                 `Jump instructions`_
+0x17    0x0  any   dst -= imm                                           `Arithmetic instructions`_
+0x18    0x0  any   dst = imm64                                          `64-bit immediate instructions`_
+0x1c    any  0x00  dst = (uint32_t)(dst - src)                          `Arithmetic instructions`_
+0x1d    any  0x00  if dst == src goto +offset                           `Jump instructions`_
+0x1e    any  0x00  if (uint32_t)dst == (uint32_t)src goto +offset       `Jump instructions`_
+0x1f    any  0x00  dst -= src                                           `Arithmetic instructions`_
+0x20    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x24    0x0  any   dst = (uint32_t)(dst \* imm)                         `Arithmetic instructions`_
+0x25    0x0  any   if dst > imm goto +offset                            `Jump instructions`_
+0x26    0x0  any   if (uint32_t)dst > imm goto +offset                  `Jump instructions`_
+0x27    0x0  any   dst \*= imm                                          `Arithmetic instructions`_
+0x28    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x2c    any  0x00  dst = (uint32_t)(dst \* src)                         `Arithmetic instructions`_
+0x2d    any  0x00  if dst > src goto +offset                            `Jump instructions`_
+0x2e    any  0x00  if (uint32_t)dst > (uint32_t)src goto +offset        `Jump instructions`_
+0x2f    any  0x00  dst \*= src                                          `Arithmetic instructions`_
+0x30    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x34    0x0  any   dst = (uint32_t)((imm != 0) ? (dst / imm) : 0)       `Arithmetic instructions`_
+0x35    0x0  any   if dst >= imm goto +offset                           `Jump instructions`_
+0x36    0x0  any   if (uint32_t)dst >= imm goto +offset                 `Jump instructions`_
+0x37    0x0  any   dst = (imm != 0) ? (dst / imm) : 0                   `Arithmetic instructions`_
+0x38    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x3c    any  0x00  dst = (uint32_t)((imm != 0) ? (dst / src) : 0)       `Arithmetic instructions`_
+0x3d    any  0x00  if dst >= src goto +offset                           `Jump instructions`_
+0x3e    any  0x00  if (uint32_t)dst >= (uint32_t)src goto +offset       `Jump instructions`_
+0x3f    any  0x00  dst = (src !+ 0) ? (dst / src) : 0                   `Arithmetic instructions`_
+0x40    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x44    0x0  any   dst = (uint32_t)(dst \| imm)                         `Arithmetic instructions`_
+0x45    0x0  any   if dst & imm goto +offset                            `Jump instructions`_
+0x46    0x0  any   if (uint32_t)dst & imm goto +offset                  `Jump instructions`_
+0x47    0x0  any   dst \|= imm                                          `Arithmetic instructions`_
+0x48    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x4c    any  0x00  dst = (uint32_t)(dst \| src)                         `Arithmetic instructions`_
+0x4d    any  0x00  if dst & src goto +offset                            `Jump instructions`_
+0x4e    any  0x00  if (uint32_t)dst & (uint32_t)src goto +offset        `Jump instructions`_
+0x4f    any  0x00  dst \|= src                                          `Arithmetic instructions`_
+0x50    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x54    0x0  any   dst = (uint32_t)(dst & imm)                          `Arithmetic instructions`_
+0x55    0x0  any   if dst != imm goto +offset                           `Jump instructions`_
+0x56    0x0  any   if (uint32_t)dst != imm goto +offset                 `Jump instructions`_
+0x57    0x0  any   dst &= imm                                           `Arithmetic instructions`_
+0x58    any  any   (deprecated, implementation-specific)                `Legacy BPF Packet access instructions`_
+0x5c    any  0x00  dst = (uint32_t)(dst & src)                          `Arithmetic instructions`_
+0x5d    any  0x00  if dst != src goto +offset                           `Jump instructions`_
+0x5e    any  0x00  if (uint32_t)dst != (uint32_t)src goto +offset       `Jump instructions`_
+0x5f    any  0x00  dst &= src                                           `Arithmetic instructions`_
+0x61    any  0x00  dst = \*(uint32_t \*)(src + offset)                  `Load and store instructions`_
+0x62    0x0  any   \*(uint32_t \*)(dst + offset) = imm                  `Load and store instructions`_
+0x63    any  0x00  \*(uint32_t \*)(dst + offset) = src                  `Load and store instructions`_
+0x64    0x0  any   dst = (uint32_t)(dst << imm)                         `Arithmetic instructions`_
+0x65    0x0  any   if dst s> imm goto +offset                           `Jump instructions`_
+0x66    0x0  any   if (int32_t)dst s> (int32_t)imm goto +offset         `Jump instructions`_
+0x67    0x0  any   dst <<= imm                                          `Arithmetic instructions`_
+0x69    any  0x00  dst = \*(uint16_t \*)(src + offset)                  `Load and store instructions`_
+0x6a    0x0  any   \*(uint16_t \*)(dst + offset) = imm                  `Load and store instructions`_
+0x6b    any  0x00  \*(uint16_t \*)(dst + offset) = src                  `Load and store instructions`_
+0x6c    any  0x00  dst = (uint32_t)(dst << src)                         `Arithmetic instructions`_
+0x6d    any  0x00  if dst s> src goto +offset                           `Jump instructions`_
+0x6e    any  0x00  if (int32_t)dst s> (int32_t)src goto +offset         `Jump instructions`_
+0x6f    any  0x00  dst <<= src                                          `Arithmetic instructions`_
+0x71    any  0x00  dst = \*(uint8_t \*)(src + offset)                   `Load and store instructions`_
+0x72    0x0  any   \*(uint8_t \*)(dst + offset) = imm                   `Load and store instructions`_
+0x73    any  0x00  \*(uint8_t \*)(dst + offset) = src                   `Load and store instructions`_
+0x74    0x0  any   dst = (uint32_t)(dst >> imm)                         `Arithmetic instructions`_
+0x75    0x0  any   if dst s>= imm goto +offset                          `Jump instructions`_
+0x76    0x0  any   if (int32_t)dst s>= (int32_t)imm goto +offset        `Jump instructions`_
+0x77    0x0  any   dst >>= imm                                          `Arithmetic instructions`_
+0x79    any  0x00  dst = \*(uint64_t \*)(src + offset)                  `Load and store instructions`_
+0x7a    0x0  any   \*(uint64_t \*)(dst + offset) = imm                  `Load and store instructions`_
+0x7b    any  0x00  \*(uint64_t \*)(dst + offset) = src                  `Load and store instructions`_
+0x7c    any  0x00  dst = (uint32_t)(dst >> src)                         `Arithmetic instructions`_
+0x7d    any  0x00  if dst s>= src goto +offset                          `Jump instructions`_
+0x7e    any  0x00  if (int32_t)dst s>= (int32_t)src goto +offset        `Jump instructions`_
+0x7f    any  0x00  dst >>= src                                          `Arithmetic instructions`_
+0x84    0x0  0x00  dst = (uint32_t)-dst                                 `Arithmetic instructions`_
+0x85    0x0  any   call helper function imm                             `Helper functions`_
+0x87    0x0  0x00  dst = -dst                                           `Arithmetic instructions`_
+0x94    0x0  any   dst = (uint32_t)((imm != 0) ? (dst % imm) : dst)     `Arithmetic instructions`_
+0x95    0x0  0x00  return                                               `Jump instructions`_
+0x97    0x0  any   dst = (imm != 0) ? (dst % imm) : dst                 `Arithmetic instructions`_
+0x9c    any  0x00  dst = (uint32_t)((src != 0) ? (dst % src) : dst)     `Arithmetic instructions`_
+0x9f    any  0x00  dst = (src != 0) ? (dst % src) : dst                 `Arithmetic instructions`_
+0xa4    0x0  any   dst = (uint32_t)(dst ^ imm)                          `Arithmetic instructions`_
+0xa5    0x0  any   if dst < imm goto +offset                            `Jump instructions`_
+0xa6    0x0  any   if (uint32_t)dst < imm goto +offset                  `Jump instructions`_
+0xa7    0x0  any   dst ^= imm                                           `Arithmetic instructions`_
+0xac    any  0x00  dst = (uint32_t)(dst ^ src)                          `Arithmetic instructions`_
+0xad    any  0x00  if dst < src goto +offset                            `Jump instructions`_
+0xae    any  0x00  if (uint32_t)dst < (uint32_t)src goto +offset        `Jump instructions`_
+0xaf    any  0x00  dst ^= src                                           `Arithmetic instructions`_
+0xb4    0x0  any   dst = (uint32_t) imm                                 `Arithmetic instructions`_
+0xb5    0x0  any   if dst <= imm goto +offset                           `Jump instructions`_
+0xa6    0x0  any   if (uint32_t)dst <= imm goto +offset                 `Jump instructions`_
+0xb7    0x0  any   dst = imm                                            `Arithmetic instructions`_
+0xbc    any  0x00  dst = (uint32_t) src                                 `Arithmetic instructions`_
+0xbd    any  0x00  if dst <= src goto +offset                           `Jump instructions`_
+0xbe    any  0x00  if (uint32_t)dst <= (uint32_t)src goto +offset       `Jump instructions`_
+0xbf    any  0x00  dst = src                                            `Arithmetic instructions`_
+0xc3    any  0x00  lock \*(uint32_t \*)(dst + offset) += src            `Atomic operations`_
+0xc3    any  0x01  lock::                                               `Atomic operations`_
+
+                       *(uint32_t *)(dst + offset) += src
+                       src = *(uint32_t *)(dst + offset)
+0xc3    any  0x40  \*(uint32_t \*)(dst + offset) \|= src                `Atomic operations`_
+0xc3    any  0x41  lock::                                               `Atomic operations`_
+
+                       *(uint32_t *)(dst + offset) |= src
+                       src = *(uint32_t *)(dst + offset)
+0xc3    any  0x50  \*(uint32_t \*)(dst + offset) &= src                 `Atomic operations`_
+0xc3    any  0x51  lock::                                               `Atomic operations`_
+
+                       *(uint32_t *)(dst + offset) &= src
+                       src = *(uint32_t *)(dst + offset)
+0xc3    any  0xa0  \*(uint32_t \*)(dst + offset) ^= src                 `Atomic operations`_
+0xc3    any  0xa1  lock::                                               `Atomic operations`_
+
+                       *(uint32_t *)(dst + offset) ^= src
+                       src = *(uint32_t *)(dst + offset)
+0xc3    any  0xe1  lock::                                               `Atomic operations`_
+
+                       temp = *(uint32_t *)(dst + offset)
+                       *(uint32_t *)(dst + offset) = src
+                       src = temp
+0xc3    any  0xf1  lock::                                               `Atomic operations`_
+
+                       temp = *(uint32_t *)(dst + offset)
+                       if *(uint32_t)(dst + offset) == R0
+                          *(uint32_t)(dst + offset) = src
+                       R0 = temp
+0xc4    0x0  any   dst = (uint32_t)(dst s>> imm)                        `Arithmetic instructions`_
+0xc5    0x0  any   if dst s< imm goto +offset                           `Jump instructions`_
+0xc6    0x0  any   if (int32_t)dst s< (int32_t)imm goto +offset         `Jump instructions`_
+0xc7    0x0  any   dst s>>= imm                                         `Arithmetic instructions`_
+0xcc    any  0x00  dst = (uint32_t)(dst s>> src)                        `Arithmetic instructions`_
+0xcd    any  0x00  if dst s< src goto +offset                           `Jump instructions`_
+0xce    any  0x00  if (int32_t)dst s< (int32_t)src goto +offset         `Jump instructions`_
+0xcf    any  0x00  dst s>>= src                                         `Arithmetic instructions`_
+0xd4    0x0  0x10  dst = htole16(dst)                                   `Byte swap instructions`_
+0xd4    0x0  0x20  dst = htole32(dst)                                   `Byte swap instructions`_
+0xd4    0x0  0x40  dst = htole64(dst)                                   `Byte swap instructions`_
+0xd5    0x0  any   if dst s<= imm goto +offset                          `Jump instructions`_
+0xd6    0x0  any   if (int32_t)dst s<= (int32_t)imm goto +offset        `Jump instructions`_
+0xdb    any  0x00  lock \*(uint64_t \*)(dst + offset) += src            `Atomic operations`_
+0xdb    any  0x01  lock::                                               `Atomic operations`_
+
+                       *(uint64_t *)(dst + offset) += src
+                       src = *(uint64_t *)(dst + offset)
+0xdb    any  0x40  \*(uint64_t \*)(dst + offset) \|= src                `Atomic operations`_
+0xdb    any  0x41  lock::                                               `Atomic operations`_
+
+                       *(uint64_t *)(dst + offset) |= src
+                       lock src = *(uint64_t *)(dst + offset)
+0xdb    any  0x50  \*(uint64_t \*)(dst + offset) &= src                 `Atomic operations`_
+0xdb    any  0x51  lock::                                               `Atomic operations`_
+
+                       *(uint64_t *)(dst + offset) &= src
+                       src = *(uint64_t *)(dst + offset)
+0xdb    any  0xa0  \*(uint64_t \*)(dst + offset) ^= src                 `Atomic operations`_
+0xdb    any  0xa1  lock::                                               `Atomic operations`_
+
+                       *(uint64_t *)(dst + offset) ^= src
+                       src = *(uint64_t *)(dst + offset)
+0xdb    any  0xe1  lock::                                               `Atomic operations`_
+
+                       temp = *(uint64_t *)(dst + offset)
+                       *(uint64_t *)(dst + offset) = src
+                       src = temp
+0xdb    any  0xf1  lock::                                               `Atomic operations`_
+
+                       temp = *(uint64_t *)(dst + offset)
+                       if *(uint64_t)(dst + offset) == R0
+                          *(uint64_t)(dst + offset) = src
+                       R0 = temp
+0xdc    0x0  0x10  dst = htobe16(dst)                                   `Byte swap instructions`_
+0xdc    0x0  0x20  dst = htobe32(dst)                                   `Byte swap instructions`_
+0xdc    0x0  0x40  dst = htobe64(dst)                                   `Byte swap instructions`_
+0xdd    any  0x00  if dst s<= src goto +offset                          `Jump instructions`_
+0xde    any  0x00  if (int32_t)dst s<= (int32_t)src goto +offset        `Jump instructions`_
+======  ===  ====  ===================================================  ========================================
-- 
2.33.4

