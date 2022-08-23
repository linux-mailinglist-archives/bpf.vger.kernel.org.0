Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA84759CDDA
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 03:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiHWB2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 21:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiHWB2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 21:28:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232E5A3DB
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:28:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gb36so24555484ejc.10
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1w/UYy1Kwba9D7BjPi7DSXEkEXwhxwKtw6Hc46YcpFI=;
        b=JWQvxKCY+BSqQLc9xZ5y/Isdb7k5Ujg6Qxz9bOQYm/Db+Xn845yFV6Ge9hGrDqV86i
         iF8LdwwNlzFs5n6VPzHYD5WGid3Q342QIduIb627r5T3JsXlx1SyUyusfjcExokPsVBg
         UygxVgXcCwqANkOnFbSr2AvVHW4vvMTSyKFOVoJvJXDVbPXIrILR8N6Ba3inDn7ZwOo2
         K6tI5dRNmRhrBEYYzs5O7V+3fL+Mv22BdJEhh6/xLAKwwTfx7lcu6i5qhbcMdFsHq4M7
         6Mt77GOqku7JoihmIoIwBXBnEwkPhgAM4YRQCe91gMqeBn0Ci5AjFFf+rK7KeYFAJmyK
         9xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1w/UYy1Kwba9D7BjPi7DSXEkEXwhxwKtw6Hc46YcpFI=;
        b=FW3+0kFeT5T3mulCagJluHuksjWFhTCDsySkDc+NwbMpeLW9/UnLp9NKg2c1YM32pp
         DjHXuX6OSXcoASuLKe0oKUGOEJEceDWamRZKILUsurAz1c/qm/qKfNoBVOM77Ai9LWTq
         +rXyLVN4k1n07XmyGf1OqZzIq7mTCiap9ycuz7nVZjAXealaTxTb5Up7vutDVCGqLnWW
         Ng8kpjsWG1oDoFQxzBq69QyMqdcW0EUURBcdU1hO4UlQVYh5769WiHe7dUHRtR8NYzGP
         nduCpgfRFEd1J+vrTecELmRmh5B3VRdRhHwcL67tVfz1n1FMmwUh602yWYAL84H/qIVU
         zUsg==
X-Gm-Message-State: ACgBeo2pCu1QyOeUserejg9/qyKSCtVQaRRXt1b8eP9/tILnX3HJOnCW
        9lNMURyxuQ42ye65d3Nr33nnsyj2dmA=
X-Google-Smtp-Source: AA6agR5DRDBw30D18WUGajcfm80qUvRMxkVF7c91FODDK/CT+OkS2D5PJdUR3mbXz9HgN0NlUOOhdA==
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr14607492ejc.170.1661218091272;
        Mon, 22 Aug 2022 18:28:11 -0700 (PDT)
Received: from localhost (vpn-253-070.epfl.ch. [128.179.253.70])
        by smtp.gmail.com with ESMTPSA id ft8-20020a170907800800b0073d68d2fc29sm3739622ejc.218.2022.08.22.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 18:28:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 0/3] Fix reference state management for synchronous callbacks
Date:   Tue, 23 Aug 2022 03:27:56 +0200
Message-Id: <20220823012759.24844-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=memxor@gmail.com; h=from:subject; bh=txZ7qQVBsISClL+yF7zrk/57guUVTDjMLYjO45D8AtU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBCbXXabMAQd//oQnCJc76ngeKbwOkO9eU4y21zbz M3OIW5SJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwQm1wAKCRBM4MiGSL8Rypf8D/ 42iLK6MRTgc5YQHdt0MBcR4YC0StML1MYgQg+hVMzotWA6PEBOyEtaf63LVcoPIHHaibVh8tzQuuav I7kazW+anU2SEIJeBMe6kgtOGNCma3gFtZAoxrIIDHyxekaIrlXX1zXL47zoXf7O5H3NqGELGxxSMD R0U+CD+OinNXV92cppXYxLSFicQyiBzkVzPZ60VMkkddlxLEQ9pbkCxVS45FzjxVKbIpU6Db3Ek/Nw XlwvV7xI4oP75ubBAA9AQEy5nUQH/488DyS5pfnP+r/CN5o4n990wPCUZQa2UQkdr7povIjHVD1XcS uGVZ5O2FxexRfAb/0zJtEnU1LqVK+soaLzsis046L0DQgKoMFW4NH/g9VC6w3ky5sycdoSByAtyms+ mumKaGsWX1Fe0VBvl9sN58rUcLng3eOFhlOvkr1NVzRmlolA3FqyWbvAgUrw8VlegVTq+Qr81uQXxB oDbsHesZZS+GWD+Lp8f1b16CtK73IzVEr8dgNus3JVCLn3z0HY5Dr4Wln8+x6RYUsYsVvL/dGbMiew rPaNQ633MhYVrmNb4fZ8lb6aZa8zGEcFrj+G1XDMvAPM6Azk8oNSFoYKYbvHBs+NdyrzhDZUztZX3t +hjW81lJEJUsXY9QFnYz4G2p5KUKPXXgE8hG+JKMllqpOQLEADHR3wJd3Vig==
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

This is patch 1, 2 + their individual tests split into a separate series from
the RFC, so that these can be taken in, while we continue working towards a fix
for handling stack access inside the callback.

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20220822131923.21476-1-memxor@gmail.com

  * Fix error for test_progs-no_alu32 due to distinct alloc_insn in errstr

RFC v1 -> v1:
RFC v1: https://lore.kernel.org/bpf/20220815051540.18791-1-memxor@gmail.com

  * Fix up commit log to add more explanation (Alexei)
  * Split reference state fix out into a separate series

Kumar Kartikeya Dwivedi (3):
  bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
  bpf: Fix reference state management for synchronous callbacks
  selftests/bpf: Add tests for reference state fixes for callbacks

 include/linux/bpf_verifier.h                  |  11 ++
 kernel/bpf/helpers.c                          |   8 +-
 kernel/bpf/verifier.c                         |  42 +++++--
 .../selftests/bpf/prog_tests/cb_refs.c        |  48 ++++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   | 116 ++++++++++++++++++
 5 files changed, 212 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/progs/cb_refs.c

-- 
2.34.1

