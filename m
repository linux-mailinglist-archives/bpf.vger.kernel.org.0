Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8ED568E77
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiGFP7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiGFP7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 11:59:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F82124A
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 08:59:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so8891776pjs.0
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RBj37IfQ9akLsTsqjX4Lg9MWMzCvSqMfZtyp812elE=;
        b=br4FHtnOCHkBzKpdhGrH+ORUw50B+4NJBRXx2GKUgQHZYxGHNMIUUiWMVARzbFMW6V
         5gb9DGHaICHV18dUAEiK5TV+7cTjZZyoHn5R8sO+OTmPP5eJ6hMMyfwZpj2l5PY7Ru96
         lbP12arrllcvKHlPFsH7aQJfw12kHm/Bfh4n7pdjVu/xxGSa1ncDHmHm5k5Hcoetqqtk
         SltNRy5m0JceWJJ1aHwE2xZq5bJaV517zoLTgIFfMmGg1kh8j5cPKadQBPixJs1SaVzH
         cEICp/j3/XT0BBXuNZfwsqzqEibhBFtACd6i5tAHhgAtu5+GJq/3GsAfcyKqrD+FndgM
         dycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7RBj37IfQ9akLsTsqjX4Lg9MWMzCvSqMfZtyp812elE=;
        b=3ue1IP4Srx0h83COpm9TjyXdMufQg1mUqgp4rvto9Fmc5PJA1jilXfHJ/q3761fw6s
         thLY+/FDrF8cDIP0UfABpUYH8nFFmRfz4+KUV828rtiMb2yn/MSogKplR46kzT0d1LZJ
         TJ6W/Xtap9JuoLkOi4Zn5NsCMUnh2hgoWn1jvbnzAwqPvgJCCvoSpCyXRF5Y4gOogvhA
         iN48EEyRIV6TzBNQU/T5GHdsS/y8bA2UBKtUTzL0wW4tPSzpzMU5wLTdBiA0485LTgxF
         qM7a1xh0ojCQg5XkTfSzQ6B52RkvgzBSbm7F2UDjSMVW/wXWtlZYoUXAd3qmHt5Ca7hS
         cEQg==
X-Gm-Message-State: AJIora/aFwLsxPoWQ+Z+8BaFFXL6+JIPZrgkZbZEIh0tSB2UaAbDjX7j
        gUGSbAs+MrOFhWE3VL2b1Pk=
X-Google-Smtp-Source: AGRyM1uLnhe6aYQtDfAanM9sVGdAToIdUkZgmDfQZUYi3uNyg68/4/PCpOrFH1RzQhwQRYwVYlkS9g==
X-Received: by 2002:a17:902:ce12:b0:16b:af7d:c2a9 with SMTP id k18-20020a170902ce1200b0016baf7dc2a9mr2579671plg.63.1657123155516;
        Wed, 06 Jul 2022 08:59:15 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:3e22:5400:4ff:fe0f:2b20])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b0051bada81bc7sm25000125pfu.161.2022.07.06.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:59:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Minor fixes for non-preallocated memory 
Date:   Wed,  6 Jul 2022 15:58:46 +0000
Message-Id: <20220706155848.4939-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When I was implementing bpf recharge[1], I found some other issues.
These issues are independent, so I send them separately.

[1]. https://lore.kernel.org/bpf/20220619155032.32515-1-laoar.shao@gmail.com/

v2:
- fix GFP_HIGH consistently over the bpf code. (Daniel, Roman)
- get rid of an error patch (Hao)

Yafang Shao (2):
  bpf: Make non-preallocated allocation low priority
  bpf: Warn on non-preallocated case for missed trace types

 kernel/bpf/devmap.c        | 3 ++-
 kernel/bpf/hashtab.c       | 8 +++++---
 kernel/bpf/local_storage.c | 3 ++-
 kernel/bpf/lpm_trie.c      | 3 ++-
 kernel/bpf/verifier.c      | 2 ++
 5 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.17.1

