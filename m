Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9B6D4353
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDCLVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjDCLVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:21:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BA113FD
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:21:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l12so28935402wrm.10
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680520882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfXbK+ehjb3x3tftRCKApX1xRkjQHv0ANTDTDP3NxOc=;
        b=LP5ajRRnzT235CHmQ0lWGzS01yRL1tgN2As0C6a9k+8kESyhDzgjyXI8/BDjLJaUTJ
         WsvByzsfaG8Sorgy//fxlbYOVC0mNesRhPJwZdh9m0lkowm6Q44RL+WC5zrfnawtMqAp
         spVLCXyWFMFo1ZXSL+bQvrMPVbziP+EyTRhcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfXbK+ehjb3x3tftRCKApX1xRkjQHv0ANTDTDP3NxOc=;
        b=puAwz6XUK/8n2X9BSHzitPPpGX/EbbMGhTsgypiE4cKInrVNl7+q/CU5vfPdOHFT5E
         jywkSF2NlaJkKMrXtM741xRjf2iCunFSf/7J7wHq8dyiHV3CZke41bUSLlOPA7ARDVH7
         vZbcKk6w/2FY4io9z75i1VMiDYhN9/T/C0ha02+XbMDigTC1PlHbdypdZsLhXbpMYrFk
         UGr5n5rhI4Od4NMKpgT329b/rby8QwHrDDUBX64DzB92JeEdahXd/XTbxuBVXUiY3cGB
         3btWUG+Fe57DJ2OTPgZgVepFswp3c+3TQ/54FsP0HlG6qNitxyDRMuEXzjTCE26bJS06
         xtew==
X-Gm-Message-State: AAQBX9ekq8LqKJk5pUZE90vfKlBbMAitA8yyQ8eESamTGRqIROqAhQTk
        +mTNTl/A3ZQhsD1LdU6ztwssIg==
X-Google-Smtp-Source: AKy350YH8mOD0Si3cDk+4jVUPMTXC/FAXN6Jt/A0MkgFu+t8zSiQuC5DogJ94PDR//YD6KjdIBX/GQ==
X-Received: by 2002:adf:e90c:0:b0:2cf:eeae:88c3 with SMTP id f12-20020adfe90c000000b002cfeeae88c3mr28245477wrm.32.1680520881678;
        Mon, 03 Apr 2023 04:21:21 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id u13-20020adfeb4d000000b002daeb108304sm9510031wrn.33.2023.04.03.04.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:21:21 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v4 0/4] Add ftrace direct call for arm64
Date:   Mon,  3 Apr 2023 13:20:55 +0200
Message-Id: <20230403112059.2749695-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds ftrace direct call support to arm64.
This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.

It is meant to be taken by the arm64 tree but it depends on the
trace-direct-v6.3-rc3 tag of the linux-trace tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
That tag was created by Steven Rostedt so the arm64 tree can pull the prior work
this depends on. [1]

Thanks to the ftrace refactoring under that tag, an ftrace_ops backing a ftrace
direct call will only ever point to *one* direct call. This means we can look up
the direct called trampoline address stored in the ops from the ftrace_caller
trampoline in the case when the destination would be out of reach of a BL
instruction at the ftrace callsite. This fixes limitations of previous attempts
such as [2].

This series has been tested on arm64 with:
1- CONFIG_FTRACE_SELFTEST
2- samples/ftrace/*.ko (cf: patch 3)
3- tools/testing/selftests/bpf/test_progs (cf: patch 4)

Changes since v3 [3]:
- Added "BTI C" instructions at the beginning of each ftrace direct call sample
- Added Mark Rutland's Acked-by to patch 2

1: https://lore.kernel.org/all/ZB2Nl7fzpHoq5V20@FVFF77S0Q05N/
2: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
3: https://lore.kernel.org/bpf/20230324171451.2752302-1-revest@chromium.org/

Florent Revest (4):
  arm64: ftrace: Add direct call support
  arm64: ftrace: Simplify get_ftrace_plt
  arm64: ftrace: Add direct call trampoline samples support
  selftests/bpf: Update the tests deny list on aarch64

 arch/arm64/Kconfig                           |  6 ++
 arch/arm64/include/asm/ftrace.h              | 22 +++++
 arch/arm64/kernel/asm-offsets.c              |  6 ++
 arch/arm64/kernel/entry-ftrace.S             | 90 ++++++++++++++++----
 arch/arm64/kernel/ftrace.c                   | 46 +++++++---
 samples/ftrace/ftrace-direct-modify.c        | 32 +++++++
 samples/ftrace/ftrace-direct-multi-modify.c  | 36 ++++++++
 samples/ftrace/ftrace-direct-multi.c         | 22 +++++
 samples/ftrace/ftrace-direct-too.c           | 25 ++++++
 samples/ftrace/ftrace-direct.c               | 23 +++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++----------------
 11 files changed, 288 insertions(+), 102 deletions(-)

-- 
2.40.0.423.gd6c402a77b-goog

