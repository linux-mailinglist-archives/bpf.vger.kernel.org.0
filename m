Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0E6D4391
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjDCLgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjDCLgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:36:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D162911E9B
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:35:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso3014774wms.5
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680521758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0HG+W1Nr/Zm5XRUMWQUndq8bum7JqRDYebIXh9Qbe0=;
        b=ADin8NDRYe5sQ0hrQPtqSRLSxBB8ihn7EpyAUhlsyrOcCkUj61zdV9iPRft+pFLa0x
         E09qWvv0++B5plr6iXhNTTdYGo23EMPXVy1xwh6WqY7AGjsf4MFmGNH4LhqH19kBPAP7
         dVdDRTCTSY0MHjb/HLXDSl+4C4hbkxyfphfSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0HG+W1Nr/Zm5XRUMWQUndq8bum7JqRDYebIXh9Qbe0=;
        b=aQtLH1LXxhwwgthq1tHy57XUiyHoKsu4xZBl2oxc81ZdaLwASMgUgcLsyjVCfrr1+m
         aFiqoEs5cnSGNlGJ1E4KKfWom+YbS6iVX5GnH4v4wBiMNT4wbXIuA6sIVGP6EaMu6KPP
         W1wKNuYmH/kn46dXxXsxjWe7ITRpA+VQw8lBRIk/mRur0VIFiEoUAGqKPR1dvQbzaKK1
         OeuAqPwK/0nqxSoJxr6UzFEYITIyBkuGIp3JoUwTbi2w9luDnKXy+7UlN7axHi86z4vI
         aOmrPxwLLZyggtN/9Tng93aDj8YLaL4jl6Y6RxRQMtljESfwSNI20rtt2ZlYJ8V1OuT7
         lTVQ==
X-Gm-Message-State: AO0yUKVVrurmEhVf8nRWYCNYrayGv6sAu1xXgo7FaSYEWVAZaKihbkkz
        ylz3SWYsl4ulWCUMsYxPdy7xjQ==
X-Google-Smtp-Source: AK7set/4kJW+CgDqrDOz4wXVt98om3F+A+nmj93tUu871u1MurFxeTkkxPOfkG6PPH56agG15HqArw==
X-Received: by 2002:a05:600c:2312:b0:3ee:b3bf:5f7c with SMTP id 18-20020a05600c231200b003eeb3bf5f7cmr27217057wmo.23.1680521758197;
        Mon, 03 Apr 2023 04:35:58 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003eb2e33f327sm29841410wmo.2.2023.04.03.04.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:35:57 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v5 0/4] Add ftrace direct call for arm64
Date:   Mon,  3 Apr 2023 13:35:48 +0200
Message-Id: <20230403113552.2857693-1-revest@chromium.org>
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

Changes since v4 [3]:
- *Actually* added "BTI C" instructions at the beginning of each ftrace direct
  call sample (v4 was supposed to do that but I forgot to git commit --amend...)

1: https://lore.kernel.org/all/ZB2Nl7fzpHoq5V20@FVFF77S0Q05N/
2: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
3: https://lore.kernel.org/bpf/20230403112059.2749695-1-revest@chromium.org/

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
 samples/ftrace/ftrace-direct-modify.c        | 34 ++++++++
 samples/ftrace/ftrace-direct-multi-modify.c  | 38 +++++++++
 samples/ftrace/ftrace-direct-multi.c         | 23 +++++
 samples/ftrace/ftrace-direct-too.c           | 26 ++++++
 samples/ftrace/ftrace-direct.c               | 24 ++++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++----------------
 11 files changed, 295 insertions(+), 102 deletions(-)

-- 
2.40.0.423.gd6c402a77b-goog

