Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A835674A4D
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjATDnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATDnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:19 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2FA2951
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c26so3046103pfp.10
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9MHAT7OW8PywAuR+Of767osGLsM8DdvVZzSMSONGcg=;
        b=HdEta52qEbMUiSBZtS+lRvRjixNYlLrySUCAj89/wlQGd8eAkRGlsA4cf5lw/STGvG
         gCQBox/dVSCNTFQjbgCPIbPj3saDAKrVM1tJudNuzHovq6C59ByHYF2iub0MB8d3Lhej
         ZOgCHLO3KuxOQCKqeg0FQ0EH1KyrvztubxCczrBFlzEVU21q7ig+jKIJlKMD9xV/Phrw
         +ZHeZpX9JnjtM9STioLKbauth5l3CB9PNiBna39cdBzoHS/qSSjNHlKRJt3t2CxO34Yi
         Z9l4SwTydUA7Si10A4KJx9BLGCYNDq2DWLWtQnV+AXvHW4u4TdhCIlUgOIpF+NIKBbF5
         ZxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9MHAT7OW8PywAuR+Of767osGLsM8DdvVZzSMSONGcg=;
        b=2R+3itNF8Sl5NtjcfDAeAV1FjCmgWBRL1r1Mw8ex+T3kefzFWLRWvgKVgqrVhCxazA
         0XZCeuSeM5F1g1uROhsZH+v/bmWc0fWjT5x/bI/pYGlPdBV9qKO/2pfK8/9bkRJ4EldY
         GbxgC9R2+LGAm1lqza+oyv0uDnEM2ouVfQxoOC6JpkfCZeRgjltZDKwWRzH0qa2ivOeO
         v0YsZH12yFepqzDq0vZ6T1K0PMZ39ZKbcQvRDTzJNkMvPDBWiAumyau3YtlvH5XREAIE
         lVFdN77hfuzuSAP2+BkFB9G6Vugj971jlQtJ97+36etTIVCnp8XI5pFaVSP3/6Khvkgt
         GI7Q==
X-Gm-Message-State: AFqh2kq3VuARAj1QPPVueKtpz6iYm20oNwOsh8Lc0uivmdOwcQwbDrPV
        8RD1yeDjLaF75u8tkNfERkJzRx3C65c=
X-Google-Smtp-Source: AMrXdXsLzrIg/i01+rZYU/9qXbsVhnvU1p8AK3yI9cOXlKA6GIdckqvES4nr7jh9tqieMqq9VqHq7Q==
X-Received: by 2002:aa7:8611:0:b0:582:df2e:595d with SMTP id p17-20020aa78611000000b00582df2e595dmr13374476pfn.4.1674186196935;
        Thu, 19 Jan 2023 19:43:16 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id b11-20020aa78ecb000000b00587ca71704dsm21619420pfr.37.2023.01.19.19.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 00/12] Dynptr fixes
Date:   Fri, 20 Jan 2023 09:13:02 +0530
Message-Id: <20230120034314.1921848-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=memxor@gmail.com; h=from:subject; bh=gdBgv2RuRTjQjTE0kY+XxJ5AbuGf7PYz+Xi2uaOuMYI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg283o+kYkNPmNJtLkynThnvi1VwQuE10lS3yATv El1oxMCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvAAKCRBM4MiGSL8Rymn4D/ 4mTHfTxbHh7nu5LOLYRs0Q0m9uJVujYvbIinIVPhYTxhwWxO0afxhqlmy4/4j1yRLD0WxJ4PUumqZO eFNpKSmIDgVPPdsCmut/5NXZgzAqqlHW3vTWE84XtteKmeLrVqxQoEWgUSfVGsw9JofAHBMbbJKySQ q8k6rnXGtW7r1LDYKufr+XvTxpaTOxWM5JsaNfz4W+hoEI7BM5W0VNX7h26KXMaViDVP66KRLsH1Ps CSaTFDhwcK407mr5bdaEprgzlrdEP0VbMl5ruIbfe/zKIH+gM/JpG6I0zCNqyMhRcTCSN3o03qAXND hER12CiwOP4muI2dSDOlu95x5EwgiQk1hS2Tsw2o+6nWXU309sbtZC4BO+NrjWagBX0sKNaPpH7Q36 OxdV2KqrraA5Q0sqnIQUpFXK8j2MDoUXhLbbm4vivja09MNEpdP4hTbIiW+g1+f7hOgMXmwz/lnDEu x7h6pICvQqcNO+s7gX8x/7fDBvSFvHgbvmcTFKNl53h0SpmFku0zU9FzcnkpIwyk9iO2yqDSs4xjpe utTADshBzgS/h9sg8XjzWiIWD3Qj2ewTQ+z6dOq0pN8HuQqNp39eBjyqw6OJTdH5Gl9FW9+oVJ8HkI LmYomgTlLG6ElM6o0LUUYM9m0RjkxomNpwwd87fCIfWDqiO56W4T0y9hI3RA==
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

