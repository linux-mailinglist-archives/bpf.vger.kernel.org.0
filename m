Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041BD6496A8
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLKWQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLKWQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 17:16:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF98DEDE
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 14:16:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so10299697wrh.7
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=na+h8Uvwx9y6jUiTZSF4d6SYhyZS1lQ+xUGuogRSWDc=;
        b=MZzzGEUcF4SzgWCzXbxa9WI8BsZ5e/Gbte+tOeoiuHcvKn6J5dsY2NKEc/KFdqJ6I8
         OprRJDf7/7KPdXg4p5JrEp9G9cuwFNrKc9QigycdEv4VEL6X4hgliKKf1xeFQ056b2sK
         Y//FZZ+sIJzOx7ZMVEMgG1w+LcFuJNlvo/oYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=na+h8Uvwx9y6jUiTZSF4d6SYhyZS1lQ+xUGuogRSWDc=;
        b=x2s0N3EPJBcfhW+Lll/CzmO5LK3bZ0IWM2ib2L7uc4MqArG1YBh3nIlkaY3aDJ9w0H
         ub9Rh67s5T/YXuhZYz+GTKUZ2/5di+eOor0JkxWN2EEkAJNoaf+msMrjOYV+KkTAtdZZ
         nJliQ9fnOa2HQ9czsi+daWZp1uAJUG0/SCtqpqXUheQk1KNYkmoF7x0RKWDOLxu+Fi02
         tc8Xyxc5V54EquyvhVUZceyyTm3d+64gt2/J4f5Unb2la+mmco5fveGpSrAdkS5EnaYh
         MJsUEXInIV5ztqKJXQV6LKzqM9EcEU9aiMJvD4zImj1m2ULCAultxsNQzt/FHs9DUK3y
         4raw==
X-Gm-Message-State: ANoB5pllNPQolwae2BmDviOdUaCbOOqNSPhJ/qhg/HiUGQJKwQBLRplY
        JnttsP3Ig8a12F/agINmACxu4G0Xc7sSFwzB
X-Google-Smtp-Source: AA0mqf70BLquvKyqLkBYJmA6Cl7p2oq36K/2+vKsI3xLCuecwg7mb0Jc9FcRUGbecm7A2jDx+hh8pA==
X-Received: by 2002:a5d:5405:0:b0:24a:e56d:e2f with SMTP id g5-20020a5d5405000000b0024ae56d0e2fmr5048500wrv.24.1670796971135;
        Sun, 11 Dec 2022 14:16:11 -0800 (PST)
Received: from MacBook-Pro-5.lan ([2a0d:6fc2:218c:1a00:a91c:f8bf:c26f:4f15])
        by smtp.gmail.com with ESMTPSA id d7-20020adffd87000000b002422bc69111sm8605805wrr.9.2022.12.11.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 14:16:10 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com, bpf@vger.kernel.org
Subject: [PATCH 0/5] Replace invocations of prandom_u32 with get_random_u32
Date:   Mon, 12 Dec 2022 00:16:03 +0200
Message-Id: <cover.1670778651.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David <david.keisarschm@mail.huji.ac.il>

The security improvements for prandom_u32 done specifically in
commits c51f8f88d705e06bd696d7510aff22b33eb8e638 from October 2020
 and d4150779e60fb6c49be25572596b2cdfc5d46a09 from May 2022)
 didn't handle the cases when prandom_bytes_state() and prandom_u32_state()
  are used. We have now added the necessary changes to handle
   these cases as  well.


David (5):
  Renaming weak prng invocations - prandom_bytes_state,
    prandom_u32_state
  Replace invocation of weak PRNG in kernel/bpf/core.c
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Replace invocation of weak PRNG in arch/x86/mm/kaslr.c

 arch/x86/mm/kaslr.c                           |  5 +--
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 .../i915/gem/selftests/i915_gem_client_blt.c  |  2 +-
 .../i915/gem/selftests/i915_gem_coherency.c   |  2 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |  2 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  4 +-
 drivers/gpu/drm/i915/selftests/i915_random.c  |  4 +-
 drivers/gpu/drm/i915/selftests/i915_random.h  |  4 +-
 drivers/gpu/drm/i915/selftests/i915_syncmap.c |  4 +-
 .../drm/i915/selftests/intel_memory_region.c  | 10 ++---
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  4 +-
 drivers/gpu/drm/lib/drm_random.c              |  2 +-
 drivers/mtd/tests/oobtest.c                   | 10 ++---
 drivers/mtd/tests/pagetest.c                  | 12 +++---
 drivers/mtd/tests/subpagetest.c               | 12 +++---
 drivers/scsi/fcoe/fcoe_ctlr.c                 |  2 +-
 include/linux/bpf.h                           |  1 -
 include/linux/prandom.h                       |  6 +--
 kernel/bpf/core.c                             | 13 +-----
 kernel/bpf/verifier.c                         |  2 -
 lib/interval_tree_test.c                      |  6 +--
 lib/random32.c                                | 42 +++++++++----------
 lib/rbtree_test.c                             |  4 +-
 lib/test_bpf.c                                |  2 +-
 lib/test_parman.c                             |  2 +-
 lib/test_scanf.c                              |  8 ++--
 mm/slab.c                                     | 20 ++++-----
 mm/slab_common.c                              | 10 ++---
 net/core/filter.c                             |  1 -
 31 files changed, 88 insertions(+), 114 deletions(-)

-- 
2.38.0

