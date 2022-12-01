Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0188F63E6F0
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLABLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLABLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:11:49 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4489312
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:48 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id j19-20020a056a00175300b00574ceff570bso444199pfc.9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttUA9nApBEqatu7CA82K6Y/coidqsTr3aSq7VlryGug=;
        b=Kv4V4+ydkjvHL8x5MjhlgrWTngAj3XLb9aW3wi8n3RUkyJyAK8Mc8gIawx9qfOuqRQ
         PfO0C+ZEumTD+A4THKjzYzp0jJGBGImT1vV7eZKNUHPPXBOz9cKzheiQEtmGXnwLjv00
         vUXGFdVQkq/wx67WqO2Lr8Y2PpCso279nFvrvLn8BE96j3fVzZLZceBdKYnlH0qa9idz
         IqBNgthEIctD/lGjdiZMNexS+OUZrPSCNOJ9s6Qd/7UDfzKBt0h81585I0+Cs0a3N5v7
         tvx1fb2y9BQByQIg5IkzU7KC1yhE+ciq5pPSsOQlAV1YFAI7J3fomYc98PKGIhMkAO4t
         DT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttUA9nApBEqatu7CA82K6Y/coidqsTr3aSq7VlryGug=;
        b=ICp/CX26zPQ7MRYnx0go4vZQGRKRSrZR8LLTBTFV0lp+nmx2OQRq6+9PmjELS5IUGh
         AuhxJs3NMKWfwyciusGebYeJh2qJcEfL9Z00Yf7ZrPhCkjJzHH+vt1YSF9dMayD5effM
         urlk0M1eRp9tyGQWTM0llIrl/qC+8rnrr3OOavFHNHVyBO2Mc9x8qzJ9ZIzsvKNDJJbK
         UYV4UaaTuUt9glWLPGN4rzKCwYJ0RozOspt0U5UYHSMa0Bnx+iHzsFlBLlt+9lDEfpXa
         G1wYG8fpQLNlh3gFYYxIqTmPMhPD4SDYJWMuLOPnqq5r1lQh3DzqDQLPQxc+RuPXXVh6
         WSSg==
X-Gm-Message-State: ANoB5pmii74t/EN4+wm/SS4X46e5s0oW0LskUc3v9i5ph7b31A/ai2Gd
        OWeh7FCW1hT3damEqhaXoDH7etNeRo/5iVT7Hs6IsZCYFhP24tVG5wW8qr8mrWCHGWvWpI+3fhB
        TwGkhMtdBQUTEPJ1cxPVt1z/8753tAOKaxWGJfA0GY1LSyD4fGBdcdpMvQrTyLELNYByB
X-Google-Smtp-Source: AA0mqf5GFvahQI5oTsvrWM2RwXHSCuCIJD8X2/fgOXrKJPHF7qEw7MlHS50YJgWK9qe0HOxoV4eFKAzB1DNALXo6
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a05:6a00:1892:b0:572:b324:bbe9 with
 SMTP id x18-20020a056a00189200b00572b324bbe9mr45540026pfh.57.1669857107709;
 Wed, 30 Nov 2022 17:11:47 -0800 (PST)
Date:   Thu,  1 Dec 2022 01:11:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201011135.1589838-1-pnaduthota@google.com>
Subject: [PATCH net-next v2 0/2] Fix pinning devmaps
From:   Pramukh Naduthota <pnaduthota@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Pramukh Naduthota <pnaduthota@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix devmap pinning and reloading. The kernel adds BPF_F_RDONLY_PROG to
all devmaps when created, but libbpf checks that user flags match pinned
map flags when using LIBBPF_PIN_BY_NAME, so reusing pinned devmaps
doesn't work, failing with an error like:

    libbpf: couldn't reuse pinned map at '/sys/fs/bpf/dev_map':
    parameter mismatch

Work around this by ignoring RDONLY_PROG in the compat check in libbpf.

Changes since v1:
- Fixed a broken import
- Fixed style issues


Pramukh Naduthota (2):
  Ignore RDONLY_PROG for devmaps in libbpf to allow re-loading of pinned
    devmaps
  Add a selftest for devmap pinning.

 tools/lib/bpf/libbpf.c                        |  8 +++++++-
 .../testing/selftests/bpf/prog_tests/devmap.c | 20 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinned_devmap.c  | 17 ++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c

-- 
2.30.2

