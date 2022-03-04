Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476144CE05F
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiCDWri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCDWrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:37 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE221E01
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:46:49 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p17so8982232plo.9
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUmKTuTxu2X+mbNDuejXZ0912381YsxLoisXVjHHtiU=;
        b=QAxaRHbqKeCHTaQS6qFZApDsgcrRTB9/UxRjyTjE+gxzcmbKDBDryeDb4CYRwD25jF
         ChcUy07A/HvuO+PRSN92Lnf19w+jXX8bRjSxHNcE12fGF0Sk8RD734fogtShV8uEk4GG
         syt4sMBuPJr6JyWIyDHIEMdIbjFfsyn8MnVlog6xVL7XB02Yk5EOL/HM9QWZ/y87IIgN
         h4evJeyyUDMjthkfFAydA76sfG/hdBlxG2Sdu2PuyWUP/5564X8cvV88v0h8EO0uHKyX
         riJvP/+nB0eoV+8VD7g71uaAcJIwJau3l4QAqaV/a+33AfpMv/tS1t+N0VN4kD3qjMLq
         I4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUmKTuTxu2X+mbNDuejXZ0912381YsxLoisXVjHHtiU=;
        b=0l/6TpzRR8jweulCvh4/bUJFi9QSs1NbXq7OasnL6rBce32Kv8lOWbtUYpgQWg1+UZ
         7FczjOSSVEsBpChYoXdnI3n9GP3UPsuOZ76ohyMyLMjzvxVyyqhtzNSc/qpmU+VrDHps
         d+urvTqg/xAUtNkEzlrObmXgiujKCo3kUY9pALr5bvvJd1mSbopu/3JBGXq8widuznuZ
         OZRWEyHL9rTxQPkJn87HGIAvx/xAKm7IF7ohAGlT2RGYWdxuVQeqiHRurwzp/VbT0eP7
         erspwy9lZmomdAR/svEGkyZrHrxzyZ+ns+3TxykNHvse+PCoQHJKohQgtrENPxfM397U
         6ZKw==
X-Gm-Message-State: AOAM530aO3se+p7i/n+lmYfF1MQYXxQQSSgBDLrowLNtUCX7/rHeEC2b
        7nUK96fla4Yacm2Az2UZOO16yLa1ndE=
X-Google-Smtp-Source: ABdhPJxsdtGUJpFHf65aW2Y0cJAqkU1RtuUIfTG2hl/wv9msyvBhJ56MlezMHafHbUNbajVWu/zyRw==
X-Received: by 2002:a17:90a:e606:b0:1bc:4c56:b31 with SMTP id j6-20020a17090ae60600b001bc4c560b31mr852235pjy.49.1646434008786;
        Fri, 04 Mar 2022 14:46:48 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id f15-20020a63380f000000b0037ff640933esm82380pga.67.2022.03.04.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:46:48 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 0/8] Fixes for bad PTR_TO_BTF_ID offset
Date:   Sat,  5 Mar 2022 04:16:37 +0530
Message-Id: <20220304224645.3677453-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; h=from:subject; bh=llcBJEFmdG8PoqZZfL4G38UBkFKoircXFN90oiPguVI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpasCO/zBOIAnOlr49jJl9kC+lvKIjDVccooB+Zr VS+O0IeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RynryD/ 9Qiqd2lnTDVyA+oacIcLCB9+5QjBWrGjHhdCzGAhzdbibrqF3YH3dZyivjvOLUPCb8zWoH8vc2oR3I 9dLzitUVPBTHqtLM6DiWS95s6mKtlt+IO8m9xDWuYyR/Mjs4t2ASvCiBl2wwrTef1p3K115BL9MVdi +7g9l0QlwjxcTbs7LKC+MNCX5RvM9DdoyFPpdSe/ps8t6iJcqUszk3rEjzcW/H8nwPvHsuldIerXzj GBYahZdnrPcpj2UPmSTWUS+3O7NImAZ1v5CVESnj2P4PCWWNJPB9KhD+T2eLaIETsviiG7cn48NiUF KLwjXM2VqamShryg4CPVnMC3M96hTdlmm7DYJdgECIP/VpHBHMv50I46FRboQPoM/XsM0tpz7iFiWP U/10gtZwKTuwK3LAiJS1KSQnmhfGHw1YkcO8YXWwMrIpP1RWK6BLfCquOHOQ2ajUImKGN/N9qc48OL zx99t8cGWKZcyt3IMCVt4vZOAxCjGfMw6Nu4B3pwtfEnYLOK/xC9oM3C0joq7z1DKCkFZnBuZZL9GB fopR8yrOr01AL7561bptRl2MxGKpNaS3+1LrHWIOJfVCZz0qpjrLiAOLK1i1FaB+CbHmcFnMbeMohC GBQ5iRSFhcCPbXtfA0bUktkKv0v+EWVLJx+h3RoG+vz2f4CN7W7XWAZs3nbQ==
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
v3 -> v4:
v3: https://lore.kernel.org/bpf/20220304000508.2904128-1-memxor@gmail.com

 * Update commit message for __diag patch to say clang instead of LLVM (Nathan)
 * Address nits for check_func_arg_reg_off (Martin)
 * Add comment for fixed_off_ok case, remove is_kfunc check (Martin)

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
 kernel/bpf/btf.c                              | 40 ++++----
 kernel/bpf/verifier.c                         | 94 +++++++++++++------
 net/bpf/test_run.c                            | 15 ++-
 net/netfilter/nf_conntrack_bpf.c              |  5 +-
 .../selftests/bpf/verifier/bounds_deduction.c |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  | 83 ++++++++++++++++
 tools/testing/selftests/bpf/verifier/ctx.c    |  8 +-
 11 files changed, 230 insertions(+), 53 deletions(-)

-- 
2.35.1

