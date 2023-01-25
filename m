Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FD367B9DD
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjAYSt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjAYSt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:49:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632375B5A9
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:48:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c6so18764690pls.4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol1c+8UQbtPqveQDMNJUx2zMmRKJIN8oBgN8A1mBs5Q=;
        b=mC7FLfV1DOa7v8LEuGBo1mOqNj92hz4iCfVNoTsq91Pj7YSO6V6kvjmIgH9Lw70cxu
         RD7aQH1JAzaxjC3T5ahp38iLLxFOCQrD8aGgm6M6pjCfCQ52hJSqK/08JzmbbZXVv4+K
         XaAZU7L7Dggs8v2By5iMZ7N/sP2Evn2bicK3JGbQcuWt4m9jvYhELljo0ljIP4PIvA2B
         cmLrn2SSDVQiZULRJxh7yboJHP4V2+WUCBrr8SQMLNWD9flzePIeDvt8BvsB/Jpr0Sic
         9ixZIhr/HYHu8lz0DXH/t3Xietb5Se6hSshy9EvX809vxOCKXaoUnhREkANU3gVYKO+5
         wQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol1c+8UQbtPqveQDMNJUx2zMmRKJIN8oBgN8A1mBs5Q=;
        b=yavMjdGS4dqvrwKIxjizSgQY71GWsnOqGpFPsdossFv1G3c88EJu69iypbJRidcxvF
         9QZ791sp9XCiuT55alcGDCmSEFQNMbzY2mSm9tponhpb6Nb1865V9L2rHN20bA5FyHK3
         y8QtxtIHr/FB0Ai3fN+lSBJeJBT2U/k/7ulcd1yLIK+V9VwrmXL3gV8+zxKkQHi3epDv
         wMQ4mROlev/MazilbM8trOmwnqPLGCAVBzJv9xW8r31MDppxD4ZQD9Tn16VaFda3PQPt
         2tknckcwhU/aCpM23Z7l2swHw+9KeDaMTxNtWusEpsYhD0isheyr5XEyDhIORPMvwGnk
         st6w==
X-Gm-Message-State: AO0yUKUAuKEcxVizUIuwSHjRnhI65s+SHD4UpVvtl7f+uGz3zNhfYvFG
        EyQrR3R4ajeBIHecQiOKFdbuJIMOYqs=
X-Google-Smtp-Source: AK7set883McyQMUYHdFBznuK3varEpQ1M8hwV9JqAgqrlRrbNKPAt6o75z+m0wzXR0K0GVgLzYrTwA==
X-Received: by 2002:a17:90b:3ecb:b0:22b:f6bf:e4e3 with SMTP id rm11-20020a17090b3ecb00b0022bf6bfe4e3mr6418218pjb.26.1674672522453;
        Wed, 25 Jan 2023 10:48:42 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.80])
        by smtp.gmail.com with ESMTPSA id k14-20020a6568ce000000b004cd2eebc551sm3568335pgt.62.2023.01.25.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:48:42 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Add note about type convention
Date:   Wed, 25 Jan 2023 18:48:27 +0000
Message-Id: <20230125184827.6120-1-dthaler1968@googlemail.com>
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
index 2d3fe59bd26..77990c97b5e 100644
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
@@ -123,6 +128,8 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
+where '(u32)' indicates that the upper 32 bits are zeroed.
+
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
   dst_reg = dst_reg + src_reg
-- 
2.33.4

