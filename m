Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885BF5ECC19
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiI0SYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiI0SYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:24:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B3106508
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a259e8c000000b006958480b858so9273524ybq.12
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=QrabUh2cIma6U6mpc3DXsTwsgnSJN0WGmMkCXL9FPIA=;
        b=Mkv9SA6D74Cp7a5F/s7LLqsl/w7KGkpPuikNFaCJm6qR5Tnsjs9lRdO1+b9AYzvdmd
         GjRrev3baiuAyuZEH/DH0Oyh5swlbuSTKQfmRdBp6KCKuidWEmEbhVgWP3DAT4KPabrj
         UNMy6/1MNl82RG8LYqBLRG4q9wGbnh5K0/Xtcl2LSutv3AS3LsdNWKB8PvfBR27/gbKr
         6huP+cRYHXmccF2wy+/JVO/wfUEK6itZOcF2xf32ykk4E1MqTgzsZmttbRLRwhlQpbQZ
         lHqeArZA/XXYdMgZ1JA/DDXKWFodBdln0ATnBuv5t6vqhKjTC/sxlxsJvWoo235/z/8k
         8wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=QrabUh2cIma6U6mpc3DXsTwsgnSJN0WGmMkCXL9FPIA=;
        b=4HyoaEpxwGe3VItgUZkZ/NQBRZqyqdeDoqiUyK7nGO5WEwb4scD+c8tL96bGsmmfBh
         Vypamqr+qTzatd9XBbqHC1vO9WO9WPErRKHZh9kYrkNWyqvMIEbaHEeadUtPsYT1fBLS
         81PrHVBvnCxdr/7yuoX2t0/e7FVIVz7oS6KXy0pFpB8z8Wh8GEpBry9FKRMPkmGaw9ep
         Nz2LobAsYYHNqKgd+6yG9uusBX1wCyxPVWInrQJ6MCvOkVAVclMnwEQj+jloWp1vwTBw
         DaHWxZVOixJXla3nIl6l4AVRGMcpVQHDKqqsIQdEBycIyK9Tv4OnHTX49CaZemHIImdE
         /4Kw==
X-Gm-Message-State: ACrzQf36FUROc7/0tc09rLiOd1fCjqf/T7ltPPAeP15fg6MqDsLtbbJt
        rBPDDLoP7gD106HkvFWD67NVkxilywbRXwrjuMQWc5V9GbDmwVGQ7sxPLby6k5XmMeo0tgbEauz
        IF7XyzmT9+Ph/vfxqJTmOgkp+iP61d7CXi1Y9o8obe0NXa6W4BpjOm4IOT7zeh8jAs65Q
X-Google-Smtp-Source: AMsMyM4Peznn4XVkHc5ksgB3DiFraQnHUTycaR5buPdsp4mz1JmQhMr/9asKJW3j1n7kBESFIo3baqpWNumGYxIN
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a81:6941:0:b0:345:4409:5842 with SMTP
 id e62-20020a816941000000b0034544095842mr27404580ywc.298.1664303047036; Tue,
 27 Sep 2022 11:24:07 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:23:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927182345.149171-1-pnaduthota@google.com>
Subject: [PATCH bpf 0/2] Fix pinning devmaps
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

Fix devmap pinning and reloading. The kernel adds BPF_F_RDONLY_PROG to all
devmaps when created, but libbpf checks that user flags match pinned map
flags when using LIBBPF_PIN_BY_NAME, so reusing pinned devmaps doesn't
work, failing with an error like:

    libbpf: couldn't reuse pinned map at '/sys/fs/bpf/dev_map': parameter mismatch

Work around this by ignoring RDONLY_PROG in the compat check in libbpf.

Pramukh Naduthota (2):
  Ignore RDONLY_PROG for devmaps in libbpf to allow re-loading of pinned
    devmaps
  Add selftests for devmap pinning

 tools/lib/bpf/libbpf.c                        |  8 +++++++-
 .../testing/selftests/bpf/prog_tests/devmap.c | 21 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinned_devmap.c  | 17 ++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c

-- 
2.30.2

