Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C110756CA62
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGIPpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGIPpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 11:45:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECF1A3AD
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 08:45:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x22so1007654qkf.13
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7XPP8LEJ6T33MerUemeYl877Dk21zrKUZAa3HwbOMs=;
        b=UVAS2BVY3xt7D3PzfhHff32aJxKegUu24DPuwAxX97b/gkXzEWUsX1JbFvXJx2N+XD
         hvfyhesnLqxfkl6Auh73D83vOBcL1RHjP2FyfbwOnwYArMTl+F7ORwJaVuXqc4Gfepzo
         srdzdbgGg5CSYXxpt8hSuZO0hYg4IY6ucaYPgvi8BX0mRufVuJgcfAY4EQnUIKl84yKb
         fIRLrUwlrW6jID/he8IrYXrLP1L0FkPsFMWALczVKwTwNIRkgNGL5AQJAdka0nu2CweJ
         cn6dEhOxwIkmxUrzsdfzWVS3rWkzu9a76QON0Z35O1vTs97R9rMhCSmPw5o/jKaY3bx/
         lE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7XPP8LEJ6T33MerUemeYl877Dk21zrKUZAa3HwbOMs=;
        b=PKCL0Lx5ns4iQnhJzfuftjT15w83lmvz3Slfdj/7flkTRMjRjaGg/kW317ttDhwyty
         bBnnPVzX0HF0dZ9PfgamypaMVmte5uUl6KsfDQ+lWh2POXFwLp79AJuoHSauPO50V/P5
         2/WPLm3ux1K2PwVbc6+DN3VAhQkU25/OucyE0s3QRqN84/p3MMal3T55QNXEKf97TxUK
         BQd+nEO6SfX0FOcYT0xxZELOnrK4IqS8bsv382kOiQvD/YuJD1WqlJp3+G+9Dk6oka80
         VaZtp4wrEXSDcKqysyRms8MbXmrV/FwBkgkAnW27EZd34+CyqyrglKKYkhpL9+6TEnMf
         tRMg==
X-Gm-Message-State: AJIora/ZqldtUhEmbkv5efI6EaEfscaTqknGiAyVfv0f+12mQgOPjhSh
        zJvTYTWum2278lOveHQV2Oo=
X-Google-Smtp-Source: AGRyM1uSAGlPcloDnqIQCfLrQBR/Xxku7vIYDBMn1+6oVbLMfTgU80jma8djrGo9qOBr19oVTCBDOA==
X-Received: by 2002:a05:620a:2455:b0:6b5:797a:5d85 with SMTP id h21-20020a05620a245500b006b5797a5d85mr591124qkn.249.1657381500911;
        Sat, 09 Jul 2022 08:45:00 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:6e4b:5400:4ff:fe10:17bb])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a430e00b006a6a6f148e6sm1682411qko.17.2022.07.09.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:45:00 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, roman.gushchin@linux.dev, haoluo@google.com,
        shakeelb@google.com
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Minor fixes for non-preallocated memory 
Date:   Sat,  9 Jul 2022 15:44:55 +0000
Message-Id: <20220709154457.57379-1-laoar.shao@gmail.com>
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

v3:
- use GFP_NOWAIT instead and update commit log (Shakeel)
- exclude some attach types for BPF_PROG_TYPE_TRACING (Alexei)

v2:
- fix GFP_HIGH consistently over the bpf code. (Daniel, Roman)
- get rid of an error patch (Hao)

Yafang Shao (2):
  bpf: Make non-preallocated allocation low priority
  bpf: Warn on non-preallocated case for missed trace types

 kernel/bpf/devmap.c        |  2 +-
 kernel/bpf/hashtab.c       |  6 +++---
 kernel/bpf/local_storage.c |  2 +-
 kernel/bpf/lpm_trie.c      |  2 +-
 kernel/bpf/verifier.c      | 18 +++++++++++++-----
 5 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.17.1

