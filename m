Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECF368DFDA
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjBGSWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjBGSWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E043AD3B
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:22:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u10so8618001wmj.3
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGxlRJ9ItK95pG3qxT0FtHt32aGKUoX/1BboanRbq8=;
        b=Yqv6j338RUp7g0MUxWQki0lWU9i1bVwT9yl9yff3Egv6DDyoizhDSVWZuN/Fdfn9N4
         4yc+0X2KBTxmHpm1cgXSbOXnYeQ+EuHtSg9rOnUMIgq+yNRqiyBgxRR7Wcav5IZjOTQI
         JoPWNnnrH4g7Xc7XI4zXyI0eC2Lq3LuFnPvdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPGxlRJ9ItK95pG3qxT0FtHt32aGKUoX/1BboanRbq8=;
        b=Sl4kNIVkCZSUoTWwqYejbEJtPty1FIJXugWSQy7pZfkEZzI8CIjr80TWBxn2LUEhAv
         hpm5bOWa9MQ3AoQDZrg0ZY9myKdMCx16i/0SqagrQxICbytx27dJ3/GPAgaOj7scPUZT
         t5uYhsIj0q0NB4UwKv5UC2FvywSWByMRZo9kLZS/Gp9dgk9/8Esa1UjmC7UNX0afwrpS
         rsBjBomkMHbD2xEW/xpBk92TT+AwcZQoxYi6gj+si2NK8tf/LHM/reNgdoM7/flBdcB7
         XXmynIx4FhF9E/aChaGQaIuI7wEv5YFAuP2v2ss6DefCFRF6E/iEBIHB9qHOddagB6LK
         t39A==
X-Gm-Message-State: AO0yUKWeytdZsXc4fCgA92DxNXzQ/sPEezo2on34K1zUEBaqgHhL8hIz
        lsmVduO52qFGytdEjrexK/3DkQ==
X-Google-Smtp-Source: AK7set8yvKzsPzd1NqHPmYe3Bs4uyOrcz69GoXhyQgH7RR75m6SdTWtnYOE7HjpEWd5FEYzEcVCv6Q==
X-Received: by 2002:a05:600c:1d8b:b0:3dc:198c:dde with SMTP id p11-20020a05600c1d8b00b003dc198c0ddemr3770794wms.41.1675794120175;
        Tue, 07 Feb 2023 10:22:00 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:21:59 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 00/10] Add ftrace direct call for arm64
Date:   Tue,  7 Feb 2023 19:21:25 +0100
Message-Id: <20230207182135.2671106-1-revest@chromium.org>
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
  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

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
2- samples/ftrace/*.ko (cf: patch 9)
3- tools/testing/selftests/bpf/test_progs (cf: patch 10)

Changes since v1 [2]:
- Updated the bpf selftests denylist according to newly passing tests
- Refactored the ftrace_caller assembly according to Mark's feedback
- Replaced Xu's stub trampoline patch for selftests with Mark's take on this
- Fixed direct calls on arch WITH_REGS=y and WITH_ARGS=n (x86 32-bit)
- Fixed the ftrace_regs stack alignment
- Simplified get_ftrace_plt() (cf: patch 8)
- Fixed a possible race when writing ops->direct_call
- Renamed "custom_tramp" to "direct_tramp"
- Referenced the commit id when mentioning a previous commit
- Linked the arm64 tree in the cover letter

This followed up on prior series by Xu Kuohai [3] and a RFC by me [4].

1: https://lore.kernel.org/all/20230123134603.1064407-1-mark.rutland@arm.com/
2: https://lore.kernel.org/all/20230201163420.1579014-1-revest@chromium.org/
3: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
4: https://lore.kernel.org/all/20221108220651.24492-1-revest@chromium.org/

Florent Revest (9):
  ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
  ftrace: Remove the legacy _ftrace_direct API
  ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
  ftrace: Store direct called addresses in their ops
  ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
  arm64: ftrace: Add direct call support
  arm64: ftrace: Simplify get_ftrace_plt
  arm64: ftrace: Add direct call trampoline samples support
  selftests/bpf: Update the tests deny list on aarch64

Mark Rutland (1):
  ftrace: selftest: remove broken trace_direct_tramp

 arch/arm64/Kconfig                           |   4 +
 arch/arm64/include/asm/ftrace.h              |  22 +
 arch/arm64/kernel/asm-offsets.c              |   6 +
 arch/arm64/kernel/entry-ftrace.S             |  90 +++-
 arch/arm64/kernel/ftrace.c                   |  46 +-
 arch/s390/kernel/mcount.S                    |   5 +
 arch/x86/kernel/ftrace_32.S                  |   5 +
 arch/x86/kernel/ftrace_64.S                  |   4 +
 include/linux/ftrace.h                       |  59 +--
 kernel/bpf/trampoline.c                      |  14 +-
 kernel/trace/Kconfig                         |   2 +-
 kernel/trace/ftrace.c                        | 433 +------------------
 kernel/trace/trace_selftest.c                |  23 +-
 samples/Kconfig                              |   2 +-
 samples/ftrace/ftrace-direct-modify.c        |  42 +-
 samples/ftrace/ftrace-direct-multi-modify.c  |  44 +-
 samples/ftrace/ftrace-direct-multi.c         |  26 +-
 samples/ftrace/ftrace-direct-too.c           |  35 +-
 samples/ftrace/ftrace-direct.c               |  33 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  82 +---
 20 files changed, 382 insertions(+), 595 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

