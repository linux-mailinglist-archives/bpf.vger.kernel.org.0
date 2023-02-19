Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7169C143
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBSPwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjBSPwy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:52:54 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835D3AB0
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:52 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k5so3921298edo.3
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/8Mxr5IIzPRsMdWEr//mepUczFtxx5+IjkOZKKTvhg=;
        b=YOs35fod/v19ywTxeHmUdeq/D069sjH81a8lSz3fHgAgOMelNhjeVUs/0v8v0fS7uV
         5T2vzBy98CosfokhTuQ3/Ho3zfbPK/0HxFqyP0Kb47iK74sQ/PYDvcwtRqx/I5cyjSqn
         h4qQSdHV1V2m/HaMlmezH5PSW+YqAQy8VOGA40XSRjpEuCnkfXXDVQ9OI8nU0WKnjbVK
         BVxjiscg4aT7Yp7v1hyNk5JWLJgVp/CqGOXWPlF+tl9r7dkJ+lo/4OnM7YF3ExnS6ObA
         bm4LUngZIuK5F5H4W2COBhmQhG61GLCuC7ocyErkiAj1qlTuSHhApNbdllEd1MPC6GYq
         dwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/8Mxr5IIzPRsMdWEr//mepUczFtxx5+IjkOZKKTvhg=;
        b=i9XUCGgXyHKrr2JYoU/pgpPSB6BQiA6dNIEx0JAAZWXgnLyUa6cT6BDGagUmJeKNeG
         kAgrHGYH/nBX4ooLtKlBkg99ZqLLc+rIH04QVF87eucW4Wrheo/qp8AQSgAzyRv7HhVp
         c1/UavmZhXz7qy2FWFyDHw9M+IZeymGAXvpZR1XJBIY0pb95fgBASZy4u7Jt5lNrUgBc
         yuXhIMK4dUEBtLx/563g7CkKBuiFtG3SIu7u+Y2rYvR9GSOPiTV/S3wnpsAi0ckJ+Z3t
         Hvx1Jb3R293g7uI9AtCQP9ujL+7hWees6F5bSKMN0DRELDP/qtSVXQbDIrf3Ke7DLhna
         X5ww==
X-Gm-Message-State: AO0yUKXpK4D6agAUNoPqQrEA/B2Bv5mc3NGlwJm82u1m6Y+Gt6vHC8ZT
        0SrY33GwmcjqKli7+Puk9U3Y/gHnWEwv/A==
X-Google-Smtp-Source: AK7set/dTAdRlhg+m3Fj86Tz1Ta/Me1EyspcOjhzxM78x9PB2O+oDpKcmY5OUQ5ROtpc0hUHHZOPyQ==
X-Received: by 2002:a05:6402:545:b0:4ac:bbc7:aa8e with SMTP id i5-20020a056402054500b004acbbc7aa8emr1736548edx.41.1676821970691;
        Sun, 19 Feb 2023 07:52:50 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id mf26-20020a170906cb9a00b008c44438734csm1599429ejb.113.2023.02.19.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 0/7] Add support for kptrs in more BPF maps
Date:   Sun, 19 Feb 2023 16:52:42 +0100
Message-Id: <20230219155249.1755998-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=memxor@gmail.com; h=from:subject; bh=fHylJJLnp4jtsstuxO8/mhMNdMcM0bT/uAgWsNcdTpQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUeU5odtWWATOeiNSkUDJgPJA2M/8Z0iLGrm37G 1GGfwYyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RymxQEA Ca6Ek1ItvPSBwAAE7MOKif/Yv/KmsqsuOqsy0uNaSyEQbSmsWf3WSvL6ahPZ9R9VjHC9O1ePnvPTl2 /C12ptvsByWJbcjtjUdxlHWTMkDpCWWYTb4211/oGx3TqVmA98OERlD5/G7WoRsG2NI5C809i8KT9K AyKFU731/iHEuxPR/u/JLpkJhKMSqbYpduUt75a8oH5hJqhnlK00OByaKMJRuf5MRryiO+X3nDH5O1 /bWzET2i3YGYPn1RKbnb97Rm3exKJFWXh4jnM+UtbCPjalx6FpdVO7Af25NhWkNeCURXzQP7OvuwY8 e7rpqM1CT6V05xs+rtdV0ze49RjQo3WZCzd8izlhb+k+avHYet3x4si48L0gLEXfxJkZxwQX1jWyfg sgZ4MA5Z+dm4cUDq0AOiMz0FSSsQDAPweT3Sgxlzf5xcyVUljAQEuL+V9juGvNYy2iXk0s9VvDZkZk UQ3pUpTHPyfwU9HD/mA9QNBDwTI7C1IuShb/zKfGEXpLG6CfUNqFKFKHeTVyj6cwz+CLswQxfMSb0r j0TLoSfqHIh3Z0ZM17S/C3tjB9hUkTYJhGTExdhd1kKyjgi4ILn0jMYuNiu8/2s5LlEa+5JVZ8BqS9 Nu0De9Sk0ifd78dbX5j5pGSuGbxSPF89ztl5OuPz58gphlHKSnRL+lMGP/lQ==
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

This set adds support for kptrs in percpu hashmaps, percpu LRU hashmaps,
and local storage maps (covering sk, cgrp, task, inode). There are also
minor miscellaneous cleanups rolled in, unrelated to the set, that I
collected over time. Feel free to drop them, they have been
intentionally placed after the kptr support to ease partial application
of the series.

Tests are expanded to test more existing maps at runtime and also test
the code path for the local storage maps (which is shared by all
implementations).

A question for reviewers is what the position of the BPF runtime should
be on dealing with reference cycles that can be created by BPF programs
at runtime using this additional support. For instance, one can store
the kptr of the task in its own task local storage, creating a cycle
which prevents destruction of task local storage. Cycles can be formed
using arbitrarily long kptr ownership chains. Therefore, just preventing
storage of such kptrs in some maps is not a sufficient solution, and is
more likely to hurt usability.

There is precedence in existing runtimes which promise memory safety,
like Rust, where reference cycles and memory leaks are permitted.
However, traditionally the safety guarantees of BPF have been stronger.
Thus, more discussion and thought is invited on this topic to ensure we
cover all usage aspects.

Kumar Kartikeya Dwivedi (7):
  bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
  bpf: Support kptrs in local storage maps
  bpf: Annotate data races in bpf_local_storage
  bpf: Remove unused MEM_ALLOC | PTR_TRUSTED checks
  bpf: Fix check_reg_type for PTR_TO_BTF_ID
  bpf: Wrap register invalidation with a helper
  selftests/bpf: Add more tests for kptrs in maps

 kernel/bpf/bpf_local_storage.c                |  51 ++-
 kernel/bpf/hashtab.c                          |  59 ++--
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         |  65 ++--
 .../selftests/bpf/prog_tests/map_kptr.c       |  96 +++--
 tools/testing/selftests/bpf/progs/map_kptr.c  | 333 +++++++++++++++---
 6 files changed, 494 insertions(+), 118 deletions(-)


base-commit: 168de0233586fb06c5c5c56304aa9a928a09b0ba
-- 
2.39.2

