Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E204F364771
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhDSPxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbhDSPxW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3BC061761
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w186so13967468wmg.3
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGCSU0+xBTq6JECVGtsHDCoHfkG3tRLAZalWeXZdUNw=;
        b=ogqSu3tNEv1raYEZtdWkpx1xE55xvIfvUADfA9pJI49f5N7oatUwkAnR/YVPvDqmRI
         vsvzWx5rQP+LVS52uDPpf9CVTvf/gFPSxRL5vjtBm4yIlk6Pz4WyEIpVUr2D7i4hiCUh
         gQQbbCbqvf5lvOBkcqZbsZG8Q87l5jVAz7+eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGCSU0+xBTq6JECVGtsHDCoHfkG3tRLAZalWeXZdUNw=;
        b=HbJTK9tx7wgVaG189KExgUiXwyfwK5+vmfHeK97qhoetlm+fFt/mA4UjSQ36G0AcIY
         X+mJzXqw+3a9WOnqaA7l41t6EsAzdNeCT9LGSVZ6j2r26Hx6m2cq0cj5gJO6ONolYgRL
         PAbIfeNmviiuFJuKiE9KwV52YZpmCmbqKMks9NlaanGtqV9lPlFtW0e+CjNbXCgJoN3L
         rRKMNj7bSyJIQIJwstylDhaF/ek39wxZN5aBqzb+UZNNFRhPp4G4FK2l4VgIrTplukqX
         hiGMi8xsNB2HSlpEskNWxNL3txwvUaNbW8az19UdJQRbmSCQP+n6QdE87k2GH+eNBMWY
         pI/g==
X-Gm-Message-State: AOAM532wFhnW7M/2vDU66bu2/u+1HS2MTUPyd5gMWe3XPLe7P7rcy9A4
        h5CT0aChe2hyNd8emsiAnr6HHMWgvZaMAw==
X-Google-Smtp-Source: ABdhPJy4NneQSv/HOLqdCu6grwQWrJn8WIZag0q7UBCHweJ5DLG6sM79gcR/wDODA9jG37txfnU6DA==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr16950222wmp.64.1618847569977;
        Mon, 19 Apr 2021 08:52:49 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:3bbb:3f8f:826f:7f55])
        by smtp.gmail.com with ESMTPSA id l9sm22868669wrz.7.2021.04.19.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:52:49 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 0/6] Add a snprintf eBPF helper
Date:   Mon, 19 Apr 2021 17:52:37 +0200
Message-Id: <20210419155243.1632274-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
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
Changes in v5:
- Fixed the bpf_printf_buf_used counter logic in try_get_fmt_tmp_buf
- Added a couple of extra incorrect specifiers tests
- Call test_snprintf_single__destroy unconditionally
- Fixed a C++-style comment

---
Changes in v4:
- Moved bpf_snprintf, bpf_printf_prepare and bpf_printf_cleanup to
  kernel/bpf/helpers.c so that they get built without CONFIG_BPF_EVENTS
- Added negative test cases (various invalid format strings)
- Renamed put_fmt_tmp_buf() as bpf_printf_cleanup()
- Fixed a mistake that caused temporary buffers to be unconditionally
  freed in bpf_printf_prepare
- Fixed a mistake that caused missing 0 character to be ignored
- Fixed a warning about integer to pointer conversion
- Misc cleanups

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

 include/linux/bpf.h                           |  22 ++
 include/uapi/linux/bpf.h                      |  28 ++
 kernel/bpf/helpers.c                          | 306 ++++++++++++++
 kernel/bpf/verifier.c                         |  82 ++++
 kernel/trace/bpf_trace.c                      | 373 ++----------------
 tools/include/uapi/linux/bpf.h                |  28 ++
 tools/lib/bpf/bpf_tracing.h                   |  58 ++-
 .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++
 .../selftests/bpf/progs/test_snprintf.c       |  73 ++++
 .../bpf/progs/test_snprintf_single.c          |  20 +
 10 files changed, 770 insertions(+), 345 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c

-- 
2.31.1.368.gbe11c130af-goog

