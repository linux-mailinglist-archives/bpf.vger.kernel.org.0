Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD570631AA9
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKUHww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKUHwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:52:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60ECB865
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so10551567pjl.3
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 23:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WjVfFYLcTfewafnon3KVt0ktJTiMVy1KnjVKkT5rpE=;
        b=b79/fyAq/YHmS0tOjEAtCmJdzJ1Ua36rMCUO8ivApIafNLtN6kTGfwicRGJWxwKqJH
         lJqTjXKFQSETXnz1A4FO28qxJns3MyYYipxX7PqKjsNMbL6scsAern/+29y+tK3yRLiz
         Y3LRr9VjVmgT1PnZ6dOgikEtWkRy25Ry0OuR/0PI2mEoOSrjuzFBXMfg1jtCepGjgbqy
         UgvpV52e2CQo+J9euy+0nkAgV5wY/EDEiHyK4PfX08gIIZEqnh4jFb5OUx/HeIQ2hpfV
         EUnU/V/yKi6jiFZsTr6ubsWvFNhGJSlwWY2QQHqL7Vi0pVoCKYzysbYlKNYGskbqywlQ
         3SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WjVfFYLcTfewafnon3KVt0ktJTiMVy1KnjVKkT5rpE=;
        b=oUfsXNYFXn0g3zoe2sXMlsIXE9xsVyne+tTa19O/Q3DxQNRRrm2N4W+Ie9OeJmKu2j
         2x1Lr+CggT5zrlLwUNFKAJjHOByz+0dGvSVfC35k1V7knILUHNs6NCG3JiwtEDUy6sP9
         HV+8zo87k52t3AEMa9yRhssZvq8iu4cKj8NVYyN/OOeIfZ9YOd3wzySUDihklXtLvHhz
         gegAICLjYFDxJlVqHVPNSPjZZ+IKnEyIk/8TYuAUPjwsHkcYgtV03w1dP0ZBSLNA4hOM
         ku1k0i4QA1gikbbkKCSehXmDSWXZfk9P0xc8OdALzFU15pnoTwkBmNC6IuAWgsmEwFTe
         5QBA==
X-Gm-Message-State: ANoB5pnXfuoyScXRtZ93vsBorb6Vy8nbGfmbHoy+oojIxJCvTu7o9qoR
        3CvrBuog8ReOCEDKqbNKeJnCLQ==
X-Google-Smtp-Source: AA0mqf5nMvHnG2tzrfyG/pKaCg//dI3l1l5t28l8zrVad0SYYerVDasQyvTv7S7qhLyrX4NgNp1FzQ==
X-Received: by 2002:a17:902:ec8a:b0:188:640f:f400 with SMTP id x10-20020a170902ec8a00b00188640ff400mr1182661plg.143.1669017165937;
        Sun, 20 Nov 2022 23:52:45 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:52:45 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/5] perf trace: Cleanup and remove unused bpf map
Date:   Mon, 21 Nov 2022 07:52:32 +0000
Message-Id: <20221121075237.127706-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The initial purpose of this series is to cleanup the unused bpf map
'syscalls' in the eBPF program augmented_raw_syscalls and perf trace
tool.  The relality is perf trace tool initializes system call table
based on map 'syscalls' and wrongly returns syscall pointer for
non-existed system calls based on the previous initialization.

So the patch set firstly addresses the issue for handling non-existed
system calls, then it removes unused local variable and bpf map in
augmented_raw_syscalls.c.

Patch 01 is a minor refactoring to use macro to replace number, patch 02
is to return error if a system call doesn't exist, especially when we
cannot find corresponding trace point in sysfs node, patch 03 is to fix
the issue that trace__syscall_info() returns a syscall pointer even the
system call doesn't exist, the corrected result is to always return NULL
pointer for non-existed system call.

The last two patches remove the unused local variable and bpf map
'syscalls'.

This patch set has been tested with mainline kernel on Arm64 Ampere
Altra platform.

Leo Yan (5):
  perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
  perf trace: Return error if a system call doesn't exist
  perf trace: Handle failure when trace point folder is missed
  perf augmented_raw_syscalls: Remove unused variable 'syscall'
  perf trace: Remove unused bpf map 'syscalls'

 tools/perf/builtin-trace.c                    | 131 +++---------------
 .../examples/bpf/augmented_raw_syscalls.c     |  18 ---
 2 files changed, 18 insertions(+), 131 deletions(-)

-- 
2.34.1

