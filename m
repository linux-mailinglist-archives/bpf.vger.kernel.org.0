Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7CE686BD7
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjBAQfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjBAQfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFB70D64
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1835564wmb.2
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogquxG5XLdGczboibIaLv1v+sI1rVWj8OVZyg325S98=;
        b=OqDLJPqNgNTjv+tJkw0JVlEEnytMVwnS/r+9V/2FKWOtmXea2c1oNHkbLhHfsaoPb6
         ABgxtqiJR2l1iWo/91F2ArCyfyfFlfeXEwvW1djmxV3bWjU1UFqd2xWtLD+JHZVZKkyB
         OqVr5X6HRQ+fiPdrTztgkFSF+oMEz0W9GIOS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogquxG5XLdGczboibIaLv1v+sI1rVWj8OVZyg325S98=;
        b=l70lavihT0lCYgkLYkLUDYwWDz3Xt8e/GFi3Nm7coWZ1QBT8Q27aoMEZqTnKdmhgZv
         WYl0/lDj0NEEG1ro/DX8YI85whR4JzLICIYsRenB7JFTYLgflt5iD93Uups0ToQUgSeG
         ANbM0HW2BjNGTua21kQKUXs4mg9ZltpV6QwRhdL1S3GAOxtpvdaupE8hkCdMjV++uN7l
         wHMP+FuTBHpIyqbmyB2qjqQ3/BlU/Sk4HwKosZtJakdXCjVLkK3vbptxusbxVzSpsdY3
         bKJFM8aarIGk5F5VQG/FLMs8ZPfhTV9SM7KVZJJGqe9IUerV/dyil/UwVvCwBfleCFZl
         6Y0A==
X-Gm-Message-State: AO0yUKWljV/eF8qAAGHqkki6mCQSlDk549sJSqS9sFPA04y6jcY/0VE2
        sNwwnkj2M0594vjlQIBMcJPKNg==
X-Google-Smtp-Source: AK7set8qjoGgTsYwyJ3LRLtxhldsGEurrzyEfjQAtmQT56+MJE4pgQklXhOB5XitFcad606GvpR/fQ==
X-Received: by 2002:a05:600c:6018:b0:3dc:1ad6:55fd with SMTP id az24-20020a05600c601800b003dc1ad655fdmr2743120wmb.32.1675269322418;
        Wed, 01 Feb 2023 08:35:22 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:21 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 0/8] Add ftrace direct call for arm64
Date:   Wed,  1 Feb 2023 17:34:12 +0100
Message-Id: <20230201163420.1579014-1-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds ftrace direct call support to arm64.
This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.

It is meant to apply on top of the arm64 tree which contains Mark Rutland's
series on CALL_OPS [1] under the for-next/ftrace tag.

The first three patches consolidate the two existing ftrace APIs for registering
direct calls. They are split to make the reviewers lives easier but if it'd be a
preferred style, I'd be happy to squash them in the next revision.
Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
from samples and selftests, there are no users of the _ftrace_direct API left
in-tree so this deletes it and renames the _ftrace_direct_multi API to
_ftrace_direct for simplicity.

The main benefit of this refactoring is that, with the API that's left, an
ftrace_ops backing a direct call will only ever point to one direct call. We can
therefore store the direct called trampoline address in the ops (patch 4) and
look it up from the ftrace trampoline on arm64 (patch 7) in the case when the
destination would be out of reach of a BL instruction at the ftrace callsite.
(in this case, ftrace_caller acts as a lightweight intermediary trampoline)

This series has been tested on both arm64 and x86_64 with:
1- CONFIG_FTRACE_SELFTEST (cf: patch 6)
2- samples/ftrace/*.ko (cf: patch 8)
3- tools/testing/selftests/bpf/test_progs (both -t lsm and -t fentry_fexit)

This follows up on prior art by Xu Kuohai [2].
The implementation here is totally different but the fix for ftrace selftests
(patch 6) is a trivial rebase of a patch originally by Xu so I kept his
authorship and trailers untouched on that patch, I hope that's ok.

1: https://lore.kernel.org/all/20230123134603.1064407-1-mark.rutland@arm.com/
2: https://lore.kernel.org/bpf/20220913162732.163631-1-xukuohai@huaweicloud.com/

Florent Revest (7):
  ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
  ftrace: Remove the legacy _ftrace_direct API
  ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
  ftrace: Store direct called addresses in their ops
  ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
  arm64: ftrace: Add direct call support
  arm64: ftrace: Add direct called trampoline samples support

Xu Kuohai (1):
  ftrace: Fix dead loop caused by direct call in ftrace selftest

 arch/arm64/Kconfig                          |   4 +
 arch/arm64/include/asm/ftrace.h             |  24 ++
 arch/arm64/kernel/asm-offsets.c             |   6 +
 arch/arm64/kernel/entry-ftrace.S            |  70 +++-
 arch/arm64/kernel/ftrace.c                  |  36 +-
 include/linux/ftrace.h                      |  51 +--
 kernel/bpf/trampoline.c                     |  14 +-
 kernel/trace/Kconfig                        |   2 +-
 kernel/trace/ftrace.c                       | 433 +-------------------
 kernel/trace/trace_selftest.c               |  14 +-
 samples/Kconfig                             |   2 +-
 samples/ftrace/ftrace-direct-modify.c       |  41 +-
 samples/ftrace/ftrace-direct-multi-modify.c |  44 +-
 samples/ftrace/ftrace-direct-multi.c        |  28 +-
 samples/ftrace/ftrace-direct-too.c          |  35 +-
 samples/ftrace/ftrace-direct.c              |  33 +-
 16 files changed, 333 insertions(+), 504 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

