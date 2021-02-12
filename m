Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5B31A656
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 21:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBLU5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 15:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLU5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 15:57:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B2C061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:56:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g10so860947wrx.1
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEedarlwD3NclrL6XFjnYgr8wVb8QNBfcEB2XUh6NaU=;
        b=uN+AqnYcR9R9uhktdnze8VdIpb3fFkOfHhpfLqlNEoqUzTwKjOlWzzYRmZUMKxfFTg
         lEdnxjfSdphEJJiUFdVw7bUZz8R6AkR8yjmGfAQP3X1mWqrGkMhEs7m1jHMN8pKr9G4h
         /4gzSgjYe4ZC2seyWbtPmUTYVvIZH1rerPOj05N3IKE43fac6mMOT07Bm3CjjPtGaEiL
         UWNHlyEr1mSh3vapSbZ5tUhm7/uRjACpRY1rIO7K3Cj51R6DhGxmxNs/jRhPmZn2i4K1
         EOSoXXuomoXTET82pLrGjiWmRsPRM1ivB3OHEnGJsX/OAv2Z6z+lISV0uRhRVP+Ap0aJ
         Q/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEedarlwD3NclrL6XFjnYgr8wVb8QNBfcEB2XUh6NaU=;
        b=tpgKFE+LT3oV36j0RgSJ2ecu17M8fjOe24rAulUBt8vBMRE7ZCKBSfOqTrUYiAKCh5
         6Rf+GvuJa8McxpYiq5EGoBEwagPh1sN1d54z/KHTj3QyMIeZxXhHB3dtfFRsr0OZs2LC
         htYfpGnJ8zaNNVS01YCBNKjRN4hyYrnGuc4MMnel3NOpDIaOITJrpiRUgDTp9OD+sbbN
         nMjEpTlQLdf0JXyYdwZ6joZ3EuGwWvXP0K2PLGPvESNBCW4Tb26fydakB1hPGkJ4XGbE
         2Cr/V0Yd96Eoqa2sDT25NURQNd+aAvYnYeSFStpvYulACKisIP7S/TtZ2HYCEwukDFFH
         72WA==
X-Gm-Message-State: AOAM530JEabbutefCH+de9idtMemQyP2EUcrAXwLqkK3cQXTT3cHbrzH
        Kn2JbJtCOfjHpeZ6e9SuBlU5QzPRKGwV9L2LyoY=
X-Google-Smtp-Source: ABdhPJwumx0Z/WyeiDSdOjqEqa7j6MIYZLngxsfaXpcOyr/vpywesoZ2odeCRGDHlOveC+vwrnAKGg==
X-Received: by 2002:adf:e510:: with SMTP id j16mr5471704wrm.153.1613163414107;
        Fri, 12 Feb 2021 12:56:54 -0800 (PST)
Received: from localhost ([91.73.148.48])
        by smtp.gmail.com with ESMTPSA id a5sm7194282wrt.70.2021.02.12.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:56:53 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v3 bpf-next 0/4] Add support of pointer to struct in global functions
Date:   Sat, 13 Feb 2021 00:56:38 +0400
Message-Id: <20210212205642.620788-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support of pointers to type with known size among
global function arguments.

The motivation is to overcome the limit on the maximum number of allowed
arguments and avoid tricky and unoptimal ways of passing arguments.

A referenced type may contain pointers but access via such pointers
cannot be veirified currently.

v2 -> v3
 - Fix reg ID generation
 - Fix commit description
 - Fix typo
 - Fix tests

v1 -> v2:
 - Allow pointer to any type with known size rather than struct only
 - Allow pointer in global functions only
 - Add more tests
 - Fix wrapping and v1 comments

Dmitrii Banshchikov (4):
  bpf: Rename bpf_reg_state variables
  bpf: Extract nullable reg type conversion into a helper function
  bpf: Support pointers in global func args
  selftests/bpf: Add unit tests for pointers in global functions

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/btf.c                              |  71 +++++++---
 kernel/bpf/verifier.c                         | 113 +++++++++++----
 .../bpf/prog_tests/global_func_args.c         |  60 ++++++++
 .../bpf/prog_tests/test_global_funcs.c        |   8 ++
 .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
 .../selftests/bpf/progs/test_global_func11.c  |  19 +++
 .../selftests/bpf/progs/test_global_func12.c  |  21 +++
 .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
 .../selftests/bpf/progs/test_global_func14.c  |  21 +++
 .../selftests/bpf/progs/test_global_func15.c  |  22 +++
 .../selftests/bpf/progs/test_global_func16.c  |  22 +++
 .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
 .../bpf/progs/test_global_func_args.c         |  91 ++++++++++++
 14 files changed, 588 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func14.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func15.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func16.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_args.c

-- 
2.25.1

