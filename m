Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23DF674DA3
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjATHEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATHEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:00 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9EA40FB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:03:59 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id x24-20020a17090ab01800b00229f43b506fso3163949pjq.5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fql/IEhvJxf/AKgUEG4CG5i06RUoNjeEjV2gmlSH+4=;
        b=o6i7IDWbS9e957RjAgRoVRVFmeclZuZ0qO5ScJa7DcERYJYjtBbzwU9Q/KHezFSJf0
         FO9zi8vgbMdcBRCN9UVbj1Rh3oScoPEfqlC13YkOpzAbNwfwCzpy3n/3LISbWGXxy7RD
         ECSQjejRuFacIuvBs+JK4vdxHcQjjc/lACOLhe22FMLoXzlBD3SWUrc9d/54nZLo3lPD
         +yicRcIRAmemnQbb+aYd6MWydB7o65ytAZhgE3nb6rdlXWeLwNSWz8hOwUcme7McS2Np
         HFGGFVcYASEKORcwneKatVFENXipkbz40zs3M+1qrS+vW38EPQU5lxNHTMVt5bdfsnFT
         IXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fql/IEhvJxf/AKgUEG4CG5i06RUoNjeEjV2gmlSH+4=;
        b=A/0Q/bqbIiQV4RHAaV6bqbId6O+p3rZAPepX/a9+uxV60TnQ3JkHBYUzaXHAPjje8t
         oKA709Y39nYQxbw0xkFfBWFNge0N/H0h6d9RuXAtDyKIStshHqrxjClWFcU+ciGzXLcn
         POKCGFFGkCM2C5XfedeNP9EqcGwFzaVLHFIUqjQqVO9cMWhAOVYh7sRHjSZmwMplPtCi
         zvlxMcDkz6EYXsm4d2HvYnmV/wnUWQqWY5e0nW59WnkoFYnwknBJA3CYTIuCIKLmebcW
         W1jGN7W6n8NIBx5TBs9kg5rGnh0ERvYYKrViov5zSyx0aTcpJGz9XHZmI3PM5xFwy16U
         UeQg==
X-Gm-Message-State: AFqh2kod5VUYaPYaXs1PiN1Qh/u7sYmg+XTKrPyyv7zGM5CYXRdNQxKy
        5PYuiIIDq5id2g4yoruek3GAF3Qopyc=
X-Google-Smtp-Source: AMrXdXsNK+xItfJguhicnemzT84dsfnFfNj9Uonc/X8l63vikTMEIN4CuWGo+1Ft83Yf1ZRrMevf5g==
X-Received: by 2002:a17:902:b20d:b0:191:4389:f8f5 with SMTP id t13-20020a170902b20d00b001914389f8f5mr13976506plr.34.1674198238683;
        Thu, 19 Jan 2023 23:03:58 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id g38-20020a635666000000b004768b74f208sm21772444pgm.4.2023.01.19.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:03:58 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 00/12] Dynptr fixes
Date:   Fri, 20 Jan 2023 12:33:43 +0530
Message-Id: <20230120070355.1983560-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=memxor@gmail.com; h=from:subject; bh=qyahahOyIiYUEAAc3WmKtc/k6PZFb0wgmiVQueIVS0s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLIaIA9mV2gczXE0nh3kh4FDLwsnHmxR2oPJpv Xv5rt66JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8Rys6lD/ 48KALqPgtKcMISC1xjFPoI1H1WvW2N1noEL2jGvV7IQJzB1/er4v1B9Pdbfbgh/IVEUmKQV2fWnSEf xUfQc5+LiZ+Pq2RQGfWcTpCv+UTKb8gKqFAETXjZLsaNCQQ+MM0f7GRSI2krF9C6AWs2QB3GuMr5Kp h54561LKy9ia+OQAmOnUO3DpHT5cF1mIEbOyScQZaSB0m9gb/POAkItaWuJdG0lGqsmRArpIxdDW4X FGxd4skFdaEHi7+KeupAAVABDiM/qXq457UHZlMmM3n/0hHMxwmldn7ZZPrHmiPSKSNwH1wLupUyYB NjfC89FKMZfjtXkfZQ55E7Gm6RgRcQ1s1tFieuTztJ7fYkLWxWf6BJRd154UauLq3ARfAq/M2FYcjL RtC/AsYfck3cWhTBppd1Z0l9C9aQVgen/sjnWbOvvHa89quF3Wq+JO8OWB1M3n7aMbo03/LcbRxVdI QPhVKSUbqjBAUJVS4XCelgfq3X5zMnEW63zrG0RRiE7fxX11KAlVRM8mzifFmMt8Xw68bVBblrABiC eylb5t1xmt+thiBG6k4OOro4oiy7istZCP4ngiEE1PQ6v5UKs/KB7jDtFxlBJAa68gztbrAlUDM6by oRcYYopOQSEXqGYVu1yuhB5AQNs+RVq6TeCcD+4LTKyoPV8q43XKcIDa1NMA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20230120034314.1921848-1-memxor@gmail.com

 * Adopt BPF ASM tests to more readable style (Alexei)

v2 -> v3
v2: https://lore.kernel.org/bpf/20230119021442.1465269-1-memxor@gmail.com

 * Fix slice invalidation logic for unreferenced dynptrs (Joanne)
 * Add selftests for precise slice invalidation on destruction
 * Add Joanne's acks

v1 -> v2
v1: https://lore.kernel.org/bpf/20230101083403.332783-1-memxor@gmail.com

 * Return error early in case of overwriting referenced dynptr slots (Andrii, Joanne)
 * Rename destroy_stack_slots_dynptr to destroy_if_dynptr_stack_slot (Joanne)
 * Invalidate dynptr slices associated with dynptr in destroy_if_dynptr_stack_slot (Joanne)
 * Combine both dynptr_get_spi and is_spi_bounds_valid (Joanne)
 * Compute spi once in process_dynptr_func and pass it as parameter instead of recomputing (Joanne)
 * Add comments expanding REG_LIVE_WRITTEN marking in unmark_stack_slots_dynptr (Joanne)
 * Add comments explaining why destroy_if_dynptr_stack_slot call needs to be done for both spi
   and spi - 1 (Joanne)
 * Port BPF assembly tests from test_verifier to test_progs framework (Andrii)
 * Address misc feedback, rebase to bpf-next

Old v1 -> v1
Old v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com

 * Allow overwriting dynptr stack slots from dynptr init helpers
 * Fix a bug in alignment check where reg->var_off.value was still not included
 * Address other minor nits

Eduard Zingerman (1):
  selftests/bpf: convenience macro for use with 'asm volatile' blocks

Kumar Kartikeya Dwivedi (11):
  bpf: Fix state pruning for STACK_DYNPTR stack slots
  bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
  bpf: Fix partial dynptr stack slot reads/writes
  bpf: Invalidate slices on destruction of dynptrs on stack
  bpf: Allow reinitializing unreferenced dynptr stack slots
  bpf: Combine dynptr_get_spi and is_spi_bounds_valid
  bpf: Avoid recomputing spi in process_dynptr_func
  selftests/bpf: Add dynptr pruning tests
  selftests/bpf: Add dynptr var_off tests
  selftests/bpf: Add dynptr partial slot overwrite tests
  selftests/bpf: Add dynptr helper tests

 include/linux/bpf_verifier.h                  |   5 +-
 kernel/bpf/verifier.c                         | 407 +++++++++++++++---
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   7 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 390 ++++++++++++++++-
 5 files changed, 735 insertions(+), 76 deletions(-)


base-commit: 00b8f39f1d15c7e16e3f5ca7538f522f3a89131f
-- 
2.39.1

