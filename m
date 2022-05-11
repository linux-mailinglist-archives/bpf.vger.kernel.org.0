Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36034523DCA
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiEKTqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbiEKTqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:46:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0182B1AE
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so2871802plg.6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppiTCHI+Dk2khVYJxgWHYySTDTYL6rBgVdN7EuCeY2g=;
        b=iY0X7IfQ0kXdBMdwXK9JsaIjOan9f2Gu+c50cc7v5UVlDL2Oaev+YalHbMpeVCJIWn
         QBHKa0jt0X0m+Bgk4Dq1QPivVIQABBxLnir9IchhHlufZ8mkZB1qad6C/kcncp/3K+G7
         RKtJOofswfTwRGNmeHUJuehB/guZgB0boofZ837GuQ8kzexK2Wlnk7XW2+f+xscPuI6n
         kbgvfReSM96Vo5PvKH9zy92XvmXwrjBZ0tipMSlNxCWNGwRYtgb5u47YU2Jri+GLvHIB
         7yBTYpd6uhMzOEdWzoYIhOnHXPIHIqE1d2lc/n0W1Kf2OZ71lqXP/QkfACDwpvMQhyn/
         kUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ppiTCHI+Dk2khVYJxgWHYySTDTYL6rBgVdN7EuCeY2g=;
        b=NZCqQKYPuoqzr92JwvxuaWMNN2TT1HnOsNG3XJFeIV5Dx81Q1nsqcQPr4Tn8KS+/2z
         HGs0dYZyvGJuyvC2Y9Ig9vgr9+OHw7Y2UaQAW2bWQunGG8I/MUSKhMdL1qOEgjZk2rnY
         5lWbqdKBTRQHDNT4Jl0GpfM4R3ivRLt1toMJQPjMXs8wVButuwyBMLHtosq3kZ88XErL
         O4eZ2GKgvypCLh+wS1SWCBjv4vUSkDQmv9Csy1z3pc0C7OnSf46VLma7UVcIiwklkTwq
         pielbgqryWgczNCEf/6WeBS4cgCpOEX8DzetH6nT4PBl+SxutzjVIwIwsBb5+ZDM3kmb
         2GSA==
X-Gm-Message-State: AOAM531lOuLS/oMLqluMEtyuopX1cRGNQLOZ/ePL0Dw9e9Q5UWa7ORvB
        uRdaV2zF7d8r8bDJB0OBbvEq1ChmEj8=
X-Google-Smtp-Source: ABdhPJwxoXykTqvsKwHdk8fsIHSM8IuJCz5eC2BXhMpKFaFoNQxGfbcfcCuYWa2IWSWqvo73DgvxHQ==
X-Received: by 2002:a17:90b:4c8c:b0:1de:b3b5:ea21 with SMTP id my12-20020a17090b4c8c00b001deb3b5ea21mr6982506pjb.171.1652298377847;
        Wed, 11 May 2022 12:46:17 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id y128-20020a62ce86000000b0050dc76281d4sm2194427pfg.174.2022.05.11.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:46:17 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 0/4] Follow ups for kptr series
Date:   Thu, 12 May 2022 01:16:50 +0530
Message-Id: <20220511194654.765705-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; h=from:subject; bh=gXMa8yQY2NZwkXzaf8wwoXFQ2iDub3/PSC4DjXY3X08=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBifBG6cuLR/V9thKOJYd9AaieEc6cD8gxlpAbBS5Pu WvRnURiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnwRugAKCRBM4MiGSL8RyhTQD/ 9AAGlwdFjdN5LU8vPx/GXP7ceJrPhcyM+mHkzrkd1XUschv+yPG+9A/9hq1j+q2l4+bU406BfWc7y7 p2jzbeuxy7BFoJTzZRplJ2+pbthIpO3oeYUshshIGAdnqTBSvrFokUY8rWx4PMUXlT0g/NN8MXFqed Er2ZUWhBXBSxUpGw5B91azVRlX4bDzOpDJNl2pJTmrxbRp+I8RYfcoy/5c4jH1ACt94YAPiGjXPVns Ofig0TayWZ4U0pTvcpTXWwycpuQ0PAr4bR1Cn9I+CGp7L6neLugXNgZMIGYeb7H4zN/KWwbWGPnJkS 88ue5Od1VnP/hj7l54Hu0Wj9Il/NXzg/xGyxSEw3dLoFhIfmBl+agpk4CU3aaoZeNBFBmTUyZFDAOz zdIkmp7gsF3qlcoSDe424FHrUEXxNzsxebtMu2lxNUvFuGKCeWkxacwt0EGJ45S0YzJFKPQN0l3kJ1 zBp6GuN17tkYSXPGeHPOM4ysHV5Xq7XHXoc/RuTjdwi6U0iql7SMBW9ptLCQ3uL2xspjmdOh0l0pR+ 4jDhLW/jBLAtMvn53cpLYXvpUbUbJZeIsTTrSnsXXzwwJ/JWRsx2iAgssvq7eRz2DqrAfQlvsmEKnU d4GhTSxzircStn5/+8wToEPNHPSmbKIMA6MtNgvAUlOkwEymKcqVG0Dj7Few==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Fix a build time warning, and address comments from Alexei on the merged
version [0].

  [0]: https://lore.kernel.org/bpf/20220424214901.2743946-1-memxor@gmail.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20220510211727.575686-1-memxor@gmail.com

 * Add Fixes tag to patch 1
 * Fix test_progs-noalu32 failure in CI due to different alloc_insn (Alexei)
 * Remove per-CPU struct, use global struct (Alexei)

Kumar Kartikeya Dwivedi (4):
  bpf: Fix sparse warning for bpf_kptr_xchg_proto
  bpf: Prepare prog_test_struct kfuncs for runtime tests
  selftests/bpf: Add negative C tests for kptrs
  selftests/bpf: Add tests for kptr_ref refcounting

 include/linux/bpf.h                           |   1 +
 net/bpf/test_run.c                            |  23 +-
 .../selftests/bpf/prog_tests/map_kptr.c       | 108 ++++-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 106 ++++-
 .../selftests/bpf/progs/map_kptr_fail.c       | 418 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/map_kptr.c |   4 +-
 6 files changed, 649 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c

-- 
2.35.1

