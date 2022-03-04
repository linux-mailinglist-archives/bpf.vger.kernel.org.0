Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC74CCA6C
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiCDAGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiCDAF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:05:59 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B4ED945
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:12 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id z2so6239405plg.8
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XprcENRzB1qvnwt18rCE6NSuKIj5S5bX3sl7nc74Krg=;
        b=izaHUanQ9BIRLLt634LkKdgm6k/qYIEOGlYjjyzYW3sU41PF37Q37wjX5OcfLR0RDO
         vXWDV8gdLnTKT4queqF55AP82jKr9uRWx12zRQQEuEOLCaj4y/LH0lYKHRzmRk7Qd/cd
         PiDjzhr/4nE3L+6ZUbPtj7tkzyzKlHMCIh7IeLr/bjxdcsfg0+pE6YVYIB60XrOaVdUK
         qMyOpszaGE6Dth4XaNWjOYIfYmXN5Jsv544Ej1Z/lMypuGD8YT8/qAmPgfUhEP0XZnKn
         IqxJf0/WnXayjj5bf4sMyY+FQ5ucU0oMfseZQhhA5lBYaKlFxeRR/Fq5ykLaV+Yu2ozz
         w9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XprcENRzB1qvnwt18rCE6NSuKIj5S5bX3sl7nc74Krg=;
        b=ePT/Z/UlDHUBtd2gy401jjXHgQWD10ZA1S+RzkcFqnwLsKwvAYv7Vqy3T0BaEnHkbq
         BDcN1ak/YlaBvdJcbdMRCe+itLDWQhlj3BpIBrXSwEEbCqTj5ctv4s7leMIbwweNCvO6
         A0bu9R3vjbyW6yBuWMQnb4pJ2XW0+BmAP2nDGxemt9fygT4YSovQfU4pGhkg2beH2unp
         l4x1fZaMmK3eNgiFTH7abt37RGZ7F/IztlrvFTo9cIWMlAYMMPzAHatqDiIB6Ls8aG7/
         gvuYjGKQjK30mdHyCYchsVMgBamSsy5THPg6rUupJGl24fR1Sxh6YRBq+uqB3gPh7zkf
         gbbQ==
X-Gm-Message-State: AOAM532T5KGucfucaGk7nDNvWDj+jWHmdD8Fix0A0/PyTEdUPnwefaQX
        2dmvmMEYP6LGmFju9KxAv9XpvDjjExk=
X-Google-Smtp-Source: ABdhPJxGzXvm5Fg//W7nV4WotjHH1pXFhIUZA84bHRWJipWb9uvxzvtCSLWtldnu1B6Vf/Jfm3UOfg==
X-Received: by 2002:a17:90a:20a:b0:1be:e850:1a37 with SMTP id c10-20020a17090a020a00b001bee8501a37mr7951806pjc.28.1646352312076;
        Thu, 03 Mar 2022 16:05:12 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm5366719pjo.0.2022.03.03.16.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:11 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 0/8] Fixes for bad PTR_TO_BTF_ID offset
Date:   Fri,  4 Mar 2022 05:35:00 +0530
Message-Id: <20220304000508.2904128-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; h=from:subject; bh=UjLH+I9qg7u3TDpqWNGPjdKP4rC9drR3TzqyLw2lX+w=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/9Bg8DJ9vdukAjO8rZ9MZ1VCQtl3dpz88GSFc Ck7ZoIOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8Ryj+wEA CEYbElxsKQYr+nEXsXG7K6WTkL7Nh5MeYEptD6L4DTPWhapIxeZCmhOnYPpx4ut5N29Y0RhC2VY4EB QHK8C1ZpdRrvXj+qatxllC8xHkQmB2vjxtd0TU9MQaPZBiPT4Hnlv8WDKnnAYuP0BXXrUaVTR2Rqa1 khDhp2gq2Spz2YOt6il5zQ6RvdzkQiNM9iJ+VraUjEJcFUpb7dwygFdNm6pPmNj2rgd/6Lut8c+d+t rZWjP+XwDRankV0WQBlWHBu41az/YaS9lFmdS+wdJ2yz/3TNikdlVQyTCWQF/QmIv3FGKhs4Ycp1lG 2fQZSxvW+Zn9fcXPmkDJ28/iXFs2YxJ8TODE8QDZMa4JNvrDiFVSeczXalTnf2fVaAGP82mE94LUkz mu6wP42sdQ6w+P1Y7WxghDyIckWvy9tUIqMKGAQ87vmCt5DZMfOi8ltneg0nV9vZ50/Vsib61fthQJ Ql+9B+a3KGXPxTxtyFG/9BJGXrr9RGTfL5TS5IiPMwJwK3h/djYmpAkt9A2fYp8TRL4Uehu1sb5GB6 rFsyD8xkVlaYKHZSrJVPe//qeZ6gROG9E+FRaWzYRmFzDrqiM48rlvDz8eofhcD6WtTEXLBIa/VATV 5kVPqoWQkynLajSzAJWejdvsyCP/Pqv2ujtN3t6liSe8SsPzz7YxR72yg4zw==
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
v2 -> v3:
v2: https://lore.kernel.org/bpf/20220303045029.2645297-1-memxor@gmail.com

 * Add my SoB to __diag for clang patch (Nathan)

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

