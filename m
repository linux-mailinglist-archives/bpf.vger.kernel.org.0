Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B00672EAE
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjASCOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjASCOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:14:46 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7845BD8
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:14:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id s67so413334pgs.3
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VoWeMdhYpsssvK48EaIuLqHdR3EWrkbAKFU0fkKTVP0=;
        b=PGi1CVEp+tWNT6KorkWs4fNxHUveeHTG95n+MBIfSN+/OmpPMSA5tas6JVVlyZJDaE
         HGgjlBEA85qPJCd0pmgobsa8d0zzReJIGq7wyMAZJ3phJg5ippVByYEgPnj+aXZVZV5b
         7Wjl0RaC0wicvx9w8fDr79nkbXMjLtBkTwcb04sjX+R2PKY0yzLnwnCVMBeg657dlCUJ
         0v+43JNtyBuXYZ7RE1fW5DW510SKM/v5PhSjC9bzNZd3QtEqatWxzMnj6Qyqp/cgigj7
         QG33FvK2Nxjhb3DcVLadhBsHMNrs89OthiJhjmw8nyHilDViyHL3YhBalCmBCwGTKo65
         5cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoWeMdhYpsssvK48EaIuLqHdR3EWrkbAKFU0fkKTVP0=;
        b=T7DG+ZXKe6gami2AVM7SoSC7dMHALNbs14eL8zSheDeu90f/5CO8/Hmc+oV8rHkybP
         HBFJajUUxXVy8Ba3jP+zwAwfIDTL1xtwFwVo+DZSm32ke9rofmgExtUBPh6fJlHb/t4Q
         KaWPN8b2Yhn8kg0j0SZY5nA3f9EOrUJ5DMYfy2xQ4PoZLNWf6bF8UIJNBT/ojac7oB9h
         1mOBMHyae9LnnMgVoJblAe0kCwDMv3NP3gTDgslDt8Hg//auPMU5iVzIJ0kcKtOObg4V
         Kab2dmt4KCwCYqXxQbU6NZIalWZ6sjZMlZd2BGCKmZ+LT+nsMyoLNFdqsvDNYNcdcRzH
         nnZw==
X-Gm-Message-State: AFqh2kpAQ1WIX3Mev35i3wh2s2O5lDg9f1wn0HL+P2Fg8JlX9ZPxvZof
        fk4WZ6ih4RnsGSCD/ayXCzUYRKMt00M=
X-Google-Smtp-Source: AMrXdXsBO4qP842yZHcE7Z96O+3EG7MfutZLIvMgkVpDgJqrKxq34lNcWk6BEwlzMqf+Pg6wYAcWWQ==
X-Received: by 2002:a05:6a00:1ca3:b0:58d:bce6:3d52 with SMTP id y35-20020a056a001ca300b0058dbce63d52mr9680928pfw.29.1674094485365;
        Wed, 18 Jan 2023 18:14:45 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id c202-20020a621cd3000000b0058dc1d54db1sm4778556pfc.206.2023.01.18.18.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:14:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 00/11] Dynptr fixes
Date:   Thu, 19 Jan 2023 07:44:31 +0530
Message-Id: <20230119021442.1465269-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=memxor@gmail.com; h=from:subject; bh=dH0EA5IJX/5xm02QtzpITK80JvIbmED8FPlj55Cnhic=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKc/zhIlIKmt3Wh11oitw9HLON4qMqIsx9KoyJxP L/7kSEeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inPwAKCRBM4MiGSL8RyinED/ 9EpYUw6MUeSHSuQv8+O1EOA1qS8zOeVT3/6fG87tkdoRMYHkNeYHrgswN0S96aShLs1fQ7heG1Cm8L YzQsWuWtDCOmIab2EwlEscdeACtIrvN6wRwlc/CWNN6QbcF5v611P929KZ62qh+mC2thJhwG3oBT3D uImv7Wk7LDkUsRrLvG9bLbEkhwJ+cww4zZGJOu5EuV4yL+JSB4voCKKL0iInFkWPR85a/xqkwPREqV n4SPsQHABYBFjb2nLhdUUJlRfAL/AGMFjDuaZ85Fvy2173its1Z2tIsNgLAAVCCeq0bC2Z6cRhuJ6x JwIgBQ3IQnoW/R96dad9/IXcjZQtMINF+XuTZ/yaTfvjMAZJ6P85qtjHUHHR5d8519jmrT/Z1VO9ct juhLuwz9XL5Cgf7gsCHWQ4VI1xA2tFouw2WlzNAJf3Cjkxta6cfvriQBATFKsN18B0XrSCNwVez9BP THClbfbhDjj8U3xr5aAo9dod4KFXSGMUFgRmK+a7mbopgtXgMv6Ja3ClllZxuPtPp/K1wN89Jw4Ne1 FAXfTqXgd6H5aXbnFmsXA6qXD1u0+6FHNXYmboFbffFKwzzn1ICImxNtIlhGSF409OWQDoZqmOeGJe C8Ot1K5sFsdAl++nkXRnTKb6lLuDqWnzkmykUDDMypxVGlWV3IWnnKmJu7Og==
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

Kumar Kartikeya Dwivedi (10):
  bpf: Fix state pruning for STACK_DYNPTR stack slots
  bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
  bpf: Fix partial dynptr stack slot reads/writes
  bpf: Allow reinitializing unreferenced dynptr stack slots
  bpf: Combine dynptr_get_spi and is_spi_bounds_valid
  bpf: Avoid recomputing spi in process_dynptr_func
  selftests/bpf: Add dynptr pruning tests
  selftests/bpf: Add dynptr var_off tests
  selftests/bpf: Add dynptr partial slot overwrite tests
  selftests/bpf: Add dynptr helper tests

 kernel/bpf/verifier.c                         | 347 +++++++++++++++---
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   7 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 319 +++++++++++++++-
 4 files changed, 611 insertions(+), 64 deletions(-)


base-commit: 92afc5329a5b23d876b215b783d200352d5aaea6
-- 
2.39.1

