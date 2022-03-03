Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768AE4CB5F1
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCCEvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCEvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:22 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496411B5D0
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:36 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d19so4484386ioc.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLAfEU+4gmh3i0B8zHIgrMWYWA8MdCQk6sJcvO+vvjw=;
        b=jcKAsO1J8Vtg16gpGUhtT2ilgpBdLvXQCoMYIKxE+klTgXsJhFs6zKk9OAqUEDvT/x
         SEl90lKrlZsxaPGHfZ59sH3JiD/zfxuY6NTvTywJYXes8/76o1TTaFPvJqElJ5fMHRn2
         HLKkiKjkN6mlbmzLUzA5IGkwtOk8be+R8tQnSykBbvPmKkqVxjJGkkU8wiv/SX10hOB/
         UQs6TRT8Q42r35ZNZ8EHfEdbZny3JB9jx2yebZO0ry+7ATDdkzjq68P/lWl5/3OJbqkD
         vxKYYe0r54+wYdxkRCLFparuxx8avtAn0agEPgwhgyn2HZKnwQiaAhTEg5Y0USeLb8EZ
         E1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLAfEU+4gmh3i0B8zHIgrMWYWA8MdCQk6sJcvO+vvjw=;
        b=GXZZtZ7J/nhEd+YwO4zKmwOjCv8TatENfSMGgsQggtaBvLaX8KnJ+oP69PKwLWE2OT
         ce2T4IJoa7tnlmdzHfJGY7hMDsxODUSZG5Sipp9The3kskRxCum1VAady4d0i/MxE+Hn
         0VR48S8WKLB/tzqYfe7QCyteOSarY7wOzdcjh6uJk5f4Vq6KzyX1zwE37LObtEY2d+hu
         VnTvgPVVDrzJjQQzUlGUkk7cjPuNNu26CNX9vvIxOuEJ2Hr0ExrQ745FFaIb9BCxvJRZ
         JX8rzBZUNlj4LDZufYukyY5BqMOvVgzBOmMMlXxOiCei9+yAu1Al/hSOzJzs71+vyJRI
         m+8A==
X-Gm-Message-State: AOAM5321qdmKTV8dLkZ5GaUV729VwtPS1PFoU10bZxkKhRZMHCvXehYa
        vbAE3asqUjBZkV895P4IngXQ8x7qOC8=
X-Google-Smtp-Source: ABdhPJyo2Z4TErNvTzJ48piX40d0auhK1mrnDT3RA9C0dzRwVXLzafDqolkSU+HeO0Vr9j4+LO6MVg==
X-Received: by 2002:a02:3f04:0:b0:30d:2251:2c1a with SMTP id d4-20020a023f04000000b0030d22512c1amr27337534jaa.314.1646283032241;
        Wed, 02 Mar 2022 20:50:32 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id b24-20020a6b6718000000b006412400e2c2sm769002ioc.1.2022.03.02.20.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:31 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 0/8] Fixes for bad PTR_TO_BTF_ID offset
Date:   Thu,  3 Mar 2022 10:20:21 +0530
Message-Id: <20220303045029.2645297-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; h=from:subject; bh=6smx+LiaHJqv3x5SOTecvzW2ur3M+rPBGhRctbviAfU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj+b3Ix+diiC/Xol4ofd3yqlRV8HLF1jf9toP8A /nmczSaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/gAKCRBM4MiGSL8Ryi2ZEA C5dkIJbbx73T5/GAqTqRhlZlrpW4uizC5w1RGKzlRKmMO7fCOCM/Kv/6ObyG0KA59GR7K3Spl9d8jP 8O2f1CaTWz/uVKa2v/NIaF/+Q4rYyWmwOKVWwFEHz4cbEUUA65GsEdtG14vAEjWHl6ZjrydmVjf35v yhOVSLYDRcmC7YqlxqEqmd2QEB6u/agaW1+JQGJ7Un2bNiLa/lmZ86tu5L90OmOUlIH5Y4ycKy9pj2 bMxu4uQXibfb8nxLVOlmJnRQZ4z+TAYuZjfeLZQM2gs+GWRsoyy/2OZnm7S3GfDKLFXscn6PWM9xQc dE+bT4Q0OVMXEiMPZ0Nvdr80gcr+/UaLzDBR1ohQpESEHqsBweIVHUiwuEMGjt9DB/TBVtcl8jxtCc HJO4EbRr1hSd5wT/MD/qJF5F6QWVLp/Dxjh1Nl73MvbnHje5L3le2+ukAQ4FMrhfRgxmL8kv/dWuPU kABWn3bu5+zK5MZl5tz2AS6Zr42sbZXCx+ppZgyMD0pT2/NZ6b7FMcUifQ24DTZMWaWap1HKDcZLOD JtYBQruSLMBw6/gxmk2MmKayd7NlgIQz/+/Jm2052YYe9KvO6lwpy3f2TcPNjenNCJgI5CEhBH4vdc iyxXm5bEbNaQFz9//3rItljhLznO9oQK7LfbdkTTf9uWZJSHq5fehRu/joVQ==
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

This set fixes a bug related to bad var_off being permitted for kfunc call in
case of PTR_TO_BTF_ID, consolidates offset checks for all register types allowed
as helper or kfunc arguments into a common shared helper, and introduces a
couple of other checks to harden the kfunc release logic and prevent future
bugs. Some selftests are also included that fail in absence of these fixes,
serving as demonstration of the issues being fixed.

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20220301065745.1634848-1-memxor@gmail.com

 * Put reg->off check for release kfunc inside check_func_arg_reg_off,
   make the check a bit more readable
 * Squash verifier selftests errstr update into patch 3 for bisect (Alexei)
 * Include fix from Nathan for clang warning about missing prototypes
 * Add unified __diag_ingore_all that works for both GCC/LLVM (Alexei)

Older discussion:
Link: https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (7):
  bpf: Add check_func_arg_reg_off function
  bpf: Fix PTR_TO_BTF_ID var_off check
  bpf: Disallow negative offset in check_ptr_off_reg
  bpf: Harden register offset checks for release helpers and kfuncs
  compiler_types.h: Add unified __diag_ignore_all for GCC/LLVM
  bpf: Replace __diag_ignore with unified __diag_ignore_all
  selftests/bpf: Add tests for kfunc register offset checks

Nathan Chancellor (1):
  compiler-clang.h: Add __diag infrastructure for clang

 include/linux/bpf_verifier.h                  |  4 +
 include/linux/compiler-clang.h                | 25 +++++
 include/linux/compiler-gcc.h                  |  3 +
 include/linux/compiler_types.h                |  4 +
 kernel/bpf/btf.c                              | 20 ++--
 kernel/bpf/verifier.c                         | 94 +++++++++++++------
 net/bpf/test_run.c                            | 15 ++-
 net/netfilter/nf_conntrack_bpf.c              |  5 +-
 .../selftests/bpf/verifier/bounds_deduction.c |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  | 83 ++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  8 +-
 11 files changed, 220 insertions(+), 43 deletions(-)

-- 
2.35.1

