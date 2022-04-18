Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34954505FE3
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiDRWuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiDRWuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:50:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B55C2BB3A
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k29so21439486pgm.12
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syKnBz3AjaIS4LdUXqCPe/JiOfVNM0OmbCvnu4t5+z8=;
        b=eAbYm1n/luVKLY3no32Tt/ABi8x58WnksMex9YVL8NxMiy+euQoyaLwNCcr5+ujG1m
         mnQ1ZWsz8rKjhAUULdUgsBTll4aEI76hCP92Dv4KV9sRU2ze0JWy0iaqY6utDs3Au3Nm
         CPpjUgofR4lYEailQFfaS+MGtTAFMhAJkvXz3IjC3VsjMBaZqPicLaXYXYsWQq5ti4pZ
         KiJ7HdvPqvS12S78D/OY9V1W3m5tsVwCrFJeqjavSAszZMpUtEgJ2VapaOB+8NKjYcLD
         fwTF7wyomOfif8TyaeWFYB4J2ZFTK6srPISbJQVuBZv81BsABcfn2SO5v4QrkGIDDKJX
         BTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syKnBz3AjaIS4LdUXqCPe/JiOfVNM0OmbCvnu4t5+z8=;
        b=TS8uzJIV+pe9Y3smrB1pEnDCkKYMKYy7B9yB+GOScqq13nEyjFiBadRYshCKHsrcUM
         FQlXqcv++j6pffNBAnYnMYv0+10tKtaHwinhJmYt9VAYH+VzR27pC/m067o4ekEJ1ZsZ
         qZwLfsNeNEr1gozvfFBn+EmFJRd1brUqDDJl4YQ1yc6rsLHOKmZIn/E8EPTc6e0wKPAn
         C9y1Iag7pZIYj/85I3hv/PzwHzsP7KcVmDdyckL+kPufVIEC+8B3hPhgAPrzMKhMlCUe
         wLo47DvhEMtrqSGgOm5wxp0ca582MOH8GqQB6asbfdoMesg/ZRj2X/qz6MjQH8LHpPpH
         Mkvg==
X-Gm-Message-State: AOAM532gR+kdy/qdJkDwFNbklViJnF4/F8aXY0hmart00VwISFzbiKCK
        3stiqZYg9Vnm6D98efRz5KUmJZq1BBTKeQ==
X-Google-Smtp-Source: ABdhPJyx/EDONY/DiohIGKwXg0Jk+hhJtEKTc8HHKiPkTmsomj1g7ehkWkkmP4zB2h8k1KRlWX/Mkw==
X-Received: by 2002:a62:e302:0:b0:506:1fcb:20f0 with SMTP id g2-20020a62e302000000b005061fcb20f0mr14587958pfh.72.1650322032888;
        Mon, 18 Apr 2022 15:47:12 -0700 (PDT)
Received: from localhost ([112.79.142.143])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm14656511pfh.177.2022.04.18.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:47:12 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 0/2] Ensure type tags are always ordered first in BTF
Date:   Tue, 19 Apr 2022 04:17:17 +0530
Message-Id: <20220418224719.1604889-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; h=from:subject; bh=XnqILaX7LErl0AbsjminNJa7qeQVUViEwSe4EnfDvSU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXenSUP9ZNitUSp5rfy/j8Pmqxmcs1AxLglRfeYqS XeHTYuKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl3p0gAKCRBM4MiGSL8Ryp2BEA CifkOdbFtzMqMS5ssAnNji3k2ruou4TvCvQlrU8P7PFS2C6zcs7ZcISAuXvulkfM9xMi8iWc5HynXQ unayAVbGOk/KZ6VkKxkqazdfV7qHJmbQzpPndmUG+sBweIzN2i8mjlGWZlBSQkL5WekN09jIP4yxvV L5ZG6Nuod5MX9iaAH/N65Y4nKziK6lueeTs/h2UxORSto0fRbp9Pt4G2QUPNx7BxR/XhspWp2FN89S AGVLNkWU8iT5aDAFKMyIJ2W6Qr90o09LGqft76Z0U2uPjHUt26JWpsAMcWrtULVIgsDNKq6xRRu0kX Wwo1BzmQzbMFcjauE9B9rVfA65vzO4mqRGbjhpBTiaBsSTP5NTOceCcBxjlEIcAK1Xye9LSW0Mz/DX RfSrP1YWBWFLvAb+CR2pL1sCyfKOhqhcEcK2yYP2r/RdAOiP6e3qBrd+ytWZyi/ER/arS1AVgnrRZv QlcsUk9CLhrgkx+cn96sVk7FkJIiaE9R9zqipzzPscpov4y5Gdb5uiROynXQ22sqoX2LuPAKHBQ8Ek tlh9IvzuwpWHXbTJElPCo1i+flzCD3tIVV69c3g2G1FeaQMPM70AVD+pbOX9KAXDc6VD9U3cIb/V9G 5wBQRliiIymKLQI7owOV6HyYyLCn5EIokoZq47iw1i+2PNIhSXpliwRjxgRA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

When iterating over modifiers, ensure that type tags can only occur at head of
the chain, and don't occur later, such that checking for them once in the start
tells us there are no more type tags in later modifiers. Clang already ensures
to emit such BTF, but user can craft their own BTF which violates such
assumptions if relied upon in the kernel.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20220406004121.282699-1-memxor@gmail.com

 * Fix for bug pointed out by Yonghong
 * Update selftests to include Yonghong's example

Kumar Kartikeya Dwivedi (2):
  bpf: Ensure type tags precede modifiers in BTF
  selftests/bpf: Add tests for type tag order validation

 kernel/bpf/btf.c                             | 54 +++++++++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 99 ++++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.35.1

