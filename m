Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515D449A3A
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 17:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhKHQtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbhKHQtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 11:49:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6405C061714
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 08:46:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b12so28005664wrh.4
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsaAiJyU3IWpU1sdedD0cLViiUE0fHAufvw/i1WABNA=;
        b=RkumnJe4lkdrvwoC8BtG5+j/rYJLZV+FbRI0zECVuLwubvjTfKbJIaCPo3qeZvEtCx
         9U6vcwqlI5JM18C2z/h07kpgXZO/6BhDPHcLz7KSkxQw/WF2ZMyYpRFWK/BDcedPi9ob
         yLU3jy8K6uBqagPP/ytvBshDkgP55stqmtAQ9o1hLgkLF1tHmDslfEO/3gn3079Dm0Jt
         HGpa/+wTK0vlGvRIhMf3JQIose6CWskAhzdTqynUl9UaQYRKtu7d+tcNYjZPf7DknMzf
         FeUQsYdBV3ECGYf60N83sFNaGGxWX9y675f+PUVBN2cHxJiG3Xe0bKHf4m5aSm2TJrOD
         l1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsaAiJyU3IWpU1sdedD0cLViiUE0fHAufvw/i1WABNA=;
        b=S3BKnfglfP+2+qOxYC3Umt4VRIIu0PqnDLzxj9dEGslYeo/QNuMms5gJ2/8Pm5IMFT
         6wz3yKHvR1Gr/iD5auui2b/XBWySa8qxEOlGVC/mUE7AqWAL3Jmh9213Asf77fiBEhZP
         MZhpRG0eJg1LYIBN7I7WPhHmqSDjpASbt2LGSyMSUyVuftAfOcpE8PMxQRmbfE0hNoRj
         Z6Kt1rbozQirl6jF0QrgaHYPwUIH8O0q8speXRrwjKOlk9v/eP9aTSN6mJkx19f/OvOJ
         TJDhKct+c/qnhKvfkdVcIqC+Koz9KrtKx2FYZd2/pdQXHu3lFcrJOtJUSyxQDbNpu38f
         TYgw==
X-Gm-Message-State: AOAM530bB8ULPfMyTn+vVwUuaU1Xq9pmPVFYSSS0tZ22H6z2lBfbq6dP
        VMKki9VBi0mXMdH7VDKDSrJTx8NhUuNwKjnCLCtj1g==
X-Google-Smtp-Source: ABdhPJykXEA4jEDdc1hXxf4Xb1HWlFDnI2cRvj0LLfFK5HL0bSAtCBey6bACqmTpzi3QojtCIoiikw==
X-Received: by 2002:adf:fe88:: with SMTP id l8mr664445wrr.208.1636389994959;
        Mon, 08 Nov 2021 08:46:34 -0800 (PST)
Received: from localhost ([91.75.210.37])
        by smtp.gmail.com with ESMTPSA id c6sm18019002wmq.46.2021.11.08.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:46:34 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, rdna@fb.com,
        john.stultz@linaro.org, sboyd@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, rosted@goodmis.org
Subject: [PATCH bpf 0/2] Forbid bpf_ktime_get_coarse_ns and bpf_timer_* in tracing progs
Date:   Mon,  8 Nov 2021 20:46:18 +0400
Message-Id: <20211108164620.407305-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot found a locking issue with bpf_ktime_get_coarse_ns() helper
executed in BPF_PROG_TYPE_PERF_EVENT prog type - [1]. The issue is
possible because the helper uses non fast version of time accessors
which isn't safe for any context. The helper was added because it
provides performance benefits in comparison to bpf_ktime_get_ns().
Forbid use of bpf_ktime_get_coarse_ns() helper in tracing progs.

The same issue is possible with bpf_timer_* set of helpers - forbid
their usage in tracing progs too.

In the discussion it was stated that bpf_spin_lock releated helpers
shall also be excluded for tracing progs. This is already done in a
different way - by compatibility check between a map and a program. The
verifier fails if a tracing program tries to use a map which value has
struct bpf_spin_lock. This prevents using bpf_spin_lock in tracing
progs.

Patch 1 adds allowance checks for helpers
Patch 2 adds tests

1. https://lore.kernel.org/all/00000000000013aebd05cff8e064@google.com/


Dmitrii Banshchikov (2):
  bpf: Forbid bpf_ktime_get_coarse_ns and bpf_timer_* in tracing progs
  selftests/bpf: Add tests for allowed helpers

 kernel/bpf/helpers.c                          |  30 +++
 tools/testing/selftests/bpf/test_verifier.c   |  36 +++-
 .../selftests/bpf/verifier/helper_allowed.c   | 196 ++++++++++++++++++
 3 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/helper_allowed.c

-- 
2.25.1

