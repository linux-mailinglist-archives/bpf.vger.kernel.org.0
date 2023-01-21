Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49DD676252
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjAUAYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAUAY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:24:29 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A89B740
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:23:55 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 5so1409207plo.3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a86+ggx7JYuYxAqziIXw3w2YD4Z9v23Kfv8nyOuUkmo=;
        b=IzXFULwobx14wW6WKIDjcdz06gddJGEr2VCf1AJH7WnR6KVRMZPXRQLIcJNYyK+Vm1
         5mMigAAYGueZI+XjSoLeXbrRaF/eg+tTvgMunW1ObYLFV7rusGbl46kvupQOK0i7YgQO
         c+7Qqzk4b2OnVXXW2U7u1lBQ5O3Eb8Fq87npZx7z3xDkegKojbJ4OMyhIrcPSyXSC30f
         eEriUMFauhKmVaeIZaNC92DN9ItVUZqJ8ymz+ohJOXAky43CqcCuSmI9LN+gn4BMMTyz
         HcOo59w6Ff9Thqpv64ssim3qy/oQ1lpAn569IqF5wK/4g0UHCJCXzmQu9bCmM8kp+Ksx
         FjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a86+ggx7JYuYxAqziIXw3w2YD4Z9v23Kfv8nyOuUkmo=;
        b=JA02bB7SB7ki/kvea4RKd4AOq9xTxmxHsnDpilLV+QGTFi3OkSzxrBypPruvRReUoM
         Ty+ngSe6RJR7vUnUhoMbr7zuZsePnxEBMIiKq8CkqcACIGCdFiK4UZVYAN857TlQxDHs
         AdLXgTmcSO9Mb+/GVCF+EAe9BG5m4hvhCNK+6bGu3vwdAjUpKqHzNGGAdA8IdiUeQKll
         4EO5GUEQYjS5qYMLcW3qr9Mz5lGH48UovVlXsdMKVZJgNYcvk+KScfyRuWkRKEmzvz7j
         BJhyLUFedE1jB9GP8z+HpPSN5G4vlBjgoW4YKLJhP/WmLyUYZiQxdQtNphgRuapOo8C3
         +11Q==
X-Gm-Message-State: AFqh2kpioUEMpFYFgdZA0qKvJPpzxkm4Cc5iar5wsL9fulRdNjtZw2Qr
        jgcmB+czAbDNPxteWRs3zSL8ofSK3XU=
X-Google-Smtp-Source: AMrXdXur/G+ACDLVo4mQUqws1pUq5hfw8AVDrZBbiNd+CsNiNimflkQqZW7nmv5DbAuOc9JOYFY1CQ==
X-Received: by 2002:a17:90a:1285:b0:229:679b:bf9c with SMTP id g5-20020a17090a128500b00229679bbf9cmr18333337pja.9.1674260565215;
        Fri, 20 Jan 2023 16:22:45 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id nh15-20020a17090b364f00b0020ae09e9724sm2111904pjb.53.2023.01.20.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:22:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 00/12] Dynptr fixes
Date:   Sat, 21 Jan 2023 05:52:29 +0530
Message-Id: <20230121002241.2113993-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918; i=memxor@gmail.com; h=from:subject; bh=iGHLMJE2nNfbW84RdxjBwxIp03c8uGe7ZYELSS8JGms=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAjKLPQgi738UclDzVt05VVz/GmpLEQIV1KVMVN /HNx+zCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swIwAKCRBM4MiGSL8RytT8EA DBKk+j9MuJ89lhMnMAC1cM/k3d7mco/WpHif+jM8Rl7TXrpXAvtInJvybUZNx2YrKsepo65dDcsYZO 0lBsMDWMh9IFPjKJnrXoF3zroudIICKitNwRpc1CC40HbwcgoEWuc+y38Iy2j4+zzgwZqqqW5GlUZp BNKj7YucPn9n8SwkVCxXv0xIBEC4IvP8iomLa6OsW2yc0/qCYxfYLtxoVmN5GcJEdkBeG6WgWp+AYq IDt6Hk1z1t7yr83TSWkEPKNqIH9aHv2y+lPZbszfDHBnMT8UFAV0aqrd6e5FKrc0XV5bnpwGgxVd6B dY5iGqcTOV+g+lU2E7KgzCjiYY4iEgOl+wvISmrzi2RnSRCITKMw1cdVx+1ubI3MwsJZS2STwJhjjq +9vHQrnu4oItN4L2YRhELaT2gbsilRt044PnsVU0RCOFJ855Hx+TZ5eVobiI5B+ItVDaznUCD3LRD3 xRdAavGNybgAyxdxUBS0FXO5NbSfAhwhTrVBb/ImCJz05uwC31zEFFVrsSVk7lxN49DczlR4MAjlt/ 5JFwh/UDDPAQBUmr4f8PMs/vacKqhayZ2MH5+zyg76q1jIiGH/PjJVwGE+jxM1+WDazlirtMz8F0g3 +W4mTfqRSs3k+cAjDC0H11w09VBQFc6r3xfd5MnVy9fQQOHwXm1vhUrO1JrA==
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
v4 -> v5
v5: https://lore.kernel.org/bpf/20230120070355.1983560-1-memxor@gmail.com

 * Add comments, tests from Joanne
 * Add Joanne's acks

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
 kernel/bpf/verifier.c                         | 407 +++++++++++++---
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   7 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 453 +++++++++++++++++-
 5 files changed, 798 insertions(+), 76 deletions(-)


base-commit: 00b8f39f1d15c7e16e3f5ca7538f522f3a89131f
-- 
2.39.1

