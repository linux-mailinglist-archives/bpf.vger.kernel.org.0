Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7B650458
	for <lists+bpf@lfdr.de>; Sun, 18 Dec 2022 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiLRSbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 13:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiLRSae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F171175
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 10:19:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so6776857wrv.10
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxdu72YhCTISL2BPtVB+B8zb3J0dRA9fDH5fu8L77EM=;
        b=ofTP31M0qkkWWR1vwtEoZJ3F61v0rpEoDk5RKSZw4+WHAw9KRF1dDlLhfqIhke21/C
         gvAqtaS5IEdG0wOIV+MCawfTFs/s57vteMpt/5rsYsmMsiKMbX7VOdo6K01IGjEei3Mi
         gKC8S6Px/FBRos77qCtzDAzncon4bagRkSDt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yxdu72YhCTISL2BPtVB+B8zb3J0dRA9fDH5fu8L77EM=;
        b=owm8E8acXn7TRAOCXv3Ky6ynJc00oTwBa/zEV0xx8rKpCVGMWSR95X2ka/+kxBp6RB
         ly7uShFtrKshNss89mo+36oOg1MC512+QarXTSu/owd9X+axYPef0h/Zg/+iO0BBDLJ8
         W1ksjrRw8139Uc/iXhbyzQhrho74F8gvgT7l/Ds+SjPD+lrIiNPeNpUX9OJNxcxi5YK2
         EfyHuPtj5Zlcd0AZ0ARRVhqTE4NQmh38mAd5W/C9snJKY3Fa19DBkImleXPClMFsEjv6
         EJwcVxohJWNcC4wzAyVXcVEaewRwYGnyArBXz7oZ1KGxHQXhYqilXP4Plz4ElGO/ZJUM
         yKOw==
X-Gm-Message-State: ANoB5png+zZXv0AoqBfExjCn1e2Vu8HD2QNp0LfS6p4O3B17EWgzm8Ot
        k9MeB84rWlIBAuY61pbqS1QVyQ==
X-Google-Smtp-Source: AA0mqf71WDDq80LmTFC8T3VFJz2DJudTFRdPyMXPdL8mtQi2rHRbQA1ofTDIQxeWj5vqryeMY772Bg==
X-Received: by 2002:adf:ee12:0:b0:242:1cc2:b1eb with SMTP id y18-20020adfee12000000b002421cc2b1ebmr25898728wrn.5.1671387544992;
        Sun, 18 Dec 2022 10:19:04 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:c45e:1c4b:fab4:ee34])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm7956489wrg.104.2022.12.18.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 10:19:04 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        aksecurity@gmail.com, ilay.bahat1@gmail.com, bpf@vger.kernel.org
Subject: [PATCH v3 0/3] Replace invocations of prandom_u32() with get_random_u32()
Date:   Sun, 18 Dec 2022 20:18:57 +0200
Message-Id: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

Hi,

This third series add some changes to the commit messages,
and also replaces get_random_u32 with get_random_u32_below,
in a case a modulo operation is done on the result.

The security improvements for prandom_u32 done in commits c51f8f88d705
from October 2020 and d4150779e60f from May 2022 didn't handle the cases
when prandom_bytes_state() and prandom_u32_state() are used.

Specifically, this weak randomization takes place in three cases:
    1.	mm/slab.c
    2.	mm/slab_common.c
    3.	arch/x86/mm/kaslr.c

The first two invocations (mm/slab.c, mm/slab_common.c) are used to create
randomization in the slab allocator freelists.
This is done to make sure attackers can’t obtain information on the heap state.

The last invocation, inside arch/x86/mm/kaslr.c,
randomizes the virtual address space of kernel memory regions.
Hence, we have added the necessary changes to make those randomizations stronger,
switching  prandom_u32 instances to get_random_u32.

# Changes since v2

* edited commit message in all three patches.
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c, mm/slab_common.c

# Changes since v1

* omitted the renaming patch, per the feedback we received
* omitted the replace of prandom_u32_state with get_random_u32 in bpf/core.c
 as it turned out to be a duplicate of a patch suggested earlier by Jason Donenfeld

Regards,


David Keisar Schmidt (3):
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Replace invocation of weak PRNG in arch/x86/mm/kaslr.c

 arch/x86/mm/kaslr.c |  5 +----
 mm/slab.c           | 25 ++++++++++---------------
 mm/slab_common.c    | 11 +++--------
 3 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.38.0

