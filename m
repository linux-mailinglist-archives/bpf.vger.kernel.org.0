Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051235CA28
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbhDLPiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbhDLPiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C7C06174A
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so1426557wrm.1
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzaMXQHvQos4Gg+0sZigLGcf/ybdwK5N7cMvXafL5UM=;
        b=SioqsK2iJ13XqJOeLpzM4AXe5YVWW1Q2GDmrFgyFqmcVvH+7ufzSq8c5zWO1kCAGz5
         b6Ocg2StBqvbJFLWpOAhxJbEKwhqdBdhFN/0NpXVKDO56KSQ9ZI30VgTe2RTOozfkWUL
         MDee+oC9LKqJc+jjgHfjKjp/oNUUWD5IRlYz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzaMXQHvQos4Gg+0sZigLGcf/ybdwK5N7cMvXafL5UM=;
        b=tzHulS4rrYo0f+em0+EyOhA+16qna/QRbgqLzSpzSCvGEswSEhrwNUQa9Q+1do0c6z
         GKRurdqHSpdBprOm8zZ5pYQY1/2TqxQpQVqRMX+tp0GmfzBiR+F1nFRWmSCkD6ZBXrj1
         cPI9+ao+JzlBMM4rtospcawFtRGEhp9KoG0JLAAJf4RHr/HLc0FFbF7BL3K1+4kl88ZC
         FdkCVGrBsAY9ob1JhZZPm6gp35BEO0wAolTAiC7PmoKMhWi9z66JBRnB6Uhsr3cqXEhI
         VF9MA9vdPzfw6X+kEBiHIRRWRz7u7eaVlPAl611WAYFqeaRxd+I83ybf/LX8uHoP7blo
         J5WQ==
X-Gm-Message-State: AOAM5306BB8krBf1yFkt+sMBnadJ7n7Jz4JwKltu1OJXENbpZOZwZDG4
        1py5xP2K/JYsMsDuntnoFN7bp37sBudEtw==
X-Google-Smtp-Source: ABdhPJyCIBayVGyIwLdotL+HbMLf2PnC4mPKF4PoUT9Gx4lowdGchstB9V/3NH9NGU7lgx75yGPFYg==
X-Received: by 2002:adf:f991:: with SMTP id f17mr7306135wrr.5.1618241880150;
        Mon, 12 Apr 2021 08:38:00 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:a372:3c3b:eeb:ad14])
        by smtp.gmail.com with ESMTPSA id i4sm2501449wrx.56.2021.04.12.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:37:59 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 0/6] Add a snprintf eBPF helper
Date:   Mon, 12 Apr 2021 17:37:48 +0200
Message-Id: <20210412153754.235500-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have a usecase where we want to audit symbol names (if available) in
callback registration hooks. (ex: fentry/nf_register_net_hook)

A few months back, I proposed a bpf_kallsyms_lookup series but it was
decided in the reviews that a more generic helper, bpf_snprintf, would
be more useful.

This series implements the helper according to the feedback received in
https://lore.kernel.org/bpf/20201126165748.1748417-1-revest@google.com/T/#u

- A new arg type guarantees the NULL-termination of string arguments and
  lets us pass format strings in only one arg
- A new helper is implemented using that guarantee. Because the format
  string is known at verification time, the format string validation is
  done by the verifier
- To implement a series of tests for bpf_snprintf, the logic for
  marshalling variadic args in a fixed-size array is reworked as per:
https://lore.kernel.org/bpf/20210310015455.1095207-1-revest@chromium.org/T/#u

---
Changes in v3:
- Simplified temporary buffer acquisition with try_get_fmt_tmp_buf()
- Made zero-termination check more consistent
- Allowed NULL output_buffer
- Simplified the BPF_CAST_FMT_ARG macro
- Three new test cases: number padding, simple string with no arg and
  string length extraction only with a NULL output buffer
- Clarified helper's description for edge cases (eg: str_size == 0)
- Lots of cosmetic changes

---
Changes in v2:
- Extracted the format validation/argument sanitization in a generic way
  for all printf-like helpers.
- bpf_snprintf's str_size can now be 0
- bpf_snprintf is now exposed to all BPF program types
- We now preempt_disable when using a per-cpu temporary buffer
- Addressed a few cosmetic changes

Florent Revest (6):
  bpf: Factorize bpf_trace_printk and bpf_seq_printf
  bpf: Add a ARG_PTR_TO_CONST_STR argument type
  bpf: Add a bpf_snprintf helper
  libbpf: Initialize the bpf_seq_printf parameters array field by field
  libbpf: Introduce a BPF_SNPRINTF helper macro
  selftests/bpf: Add a series of tests for bpf_snprintf

 include/linux/bpf.h                           |   7 +
 include/uapi/linux/bpf.h                      |  28 +
 kernel/bpf/helpers.c                          |   2 +
 kernel/bpf/verifier.c                         |  82 +++
 kernel/trace/bpf_trace.c                      | 579 +++++++++---------
 tools/include/uapi/linux/bpf.h                |  28 +
 tools/lib/bpf/bpf_tracing.h                   |  58 +-
 .../selftests/bpf/prog_tests/snprintf.c       |  81 +++
 .../selftests/bpf/progs/test_snprintf.c       |  74 +++
 9 files changed, 647 insertions(+), 292 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

-- 
2.31.1.295.g9ea45b61b8-goog

