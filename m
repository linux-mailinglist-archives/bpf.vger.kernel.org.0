Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAA5ECC87
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI0TAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiI0TAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CE15E4F0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so9918921plo.3
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2eM0bW+kJIRaRGmJEv4QVeyfZ5y4avXbADaNHf73UyA=;
        b=lGismXlQnh1LFstZ4W8ifUrLWtLj6Ec1pjc1w8xbdS0FnTpbCFlTCM/DD9sIy1jAfa
         sUD3RZ3MdyPCKhUto2NvLsFb03yUvxlPIrYsEpOdX5f4t/Nd1SOhd4iEum/qdC7vf7in
         yLsBSbiYrVR8RyKbFN1fcJGz24JWOHq4xrkYu448IwJDSS1qLnapRd3GEZMd7bc5kxUI
         zrBYWwkgcf9vj9ynZ6P+ecUBPVobwnf5Y8nOc/daCL5anAbNYAXR8IXaSfWK8sTjPoCl
         WRzAySbzbZ1FcdRSV0KJhFuDwVc1hcgZHc0gUy5An6nM719d1m7Fk740JjhUYOaPXuae
         vtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2eM0bW+kJIRaRGmJEv4QVeyfZ5y4avXbADaNHf73UyA=;
        b=ENRwhAupjG2TftHYhmDoTf1Iy1048aNyEY/9KhU6rynsFk7toyfn44qZZCNKcjGTEH
         bBHIZAsNfB3HuIiUh9ZSrq+CT9bOfnTKRyCVmqswvHrpCmbU/Hd9oT4s75fL+buvydI2
         P/jRZ30kZJsBVnIdvPrysbsPFfwu9PWPZC6/9CAVvX32+ro/zdfrAGqsje0iCZcugGsN
         tG4husNgymk7Fio4DcEnpEqT74kE6SgprWOlna97KDM5q7sbzw9tq+DoIa8D2eyEQhYF
         TqY2yCMmDlalfslha6yJ+7PdirS10/tS1rpTW43xAdZuBghiCUAPKMIEXsunHI1e/x6T
         0wFA==
X-Gm-Message-State: ACrzQf2pmQxOASSZCkucwWUtp0XiDuSe4UlKs/nouBTjlv8dCfZDN0d7
        A+pDZQlcC3hAVqlap5muHxi0yA6Y2iI=
X-Google-Smtp-Source: AMsMyM4bxUHQGaA/zWB/KVOssHDvJoKHmLMyfnaq2BB/eINJw8Svd1i4wXhj2ajh92NJz0Wt7qwGeg==
X-Received: by 2002:a17:902:c702:b0:178:9fb3:419a with SMTP id p2-20020a170902c70200b001789fb3419amr29115280plp.35.1664305217182;
        Tue, 27 Sep 2022 12:00:17 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:16 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 02/15] ebpf-docs: Linux byteswap note
Date:   Tue, 27 Sep 2022 18:59:45 +0000
Message-Id: <20220927185958.14995-2-dthaler1968@googlemail.com>
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
 Documentation/bpf/instruction-set.rst | 4 ----
 Documentation/bpf/linux-notes.rst     | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 352f25a1e..1735b91ec 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -156,10 +156,6 @@ Examples:
 
   dst_reg = htobe64(dst_reg)
 
-``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and
-``BPF_TO_BE`` respectively.
-
-
 Jump instructions
 -----------------
 
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 93c01386d..1c31379b4 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -7,6 +7,11 @@ Linux implementation notes
 
 This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
 
+Byte swap instructions
+======================
+
+``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

