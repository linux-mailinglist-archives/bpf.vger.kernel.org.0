Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FEC35FB26
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346834AbhDNSyk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhDNSyk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21EC061756
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j5so19893471wrn.4
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5LgeKpusYSyxX8qx1DrgdRoJ4W0OuV8svaN4mMwLYQ=;
        b=awkOVaY3FBqbwSPvcQFmJMgiBgkPDfbnZZ2JQ+y8NXjsQiUsY8xnqDYZRA7DOHDzuc
         UnjikV7YvVHMPseWobwAnaIsaRLDLQz8H7o7TGRDab0w9LD2ea9DMUCM3HO2M2z+GBBQ
         A1EZN8u4whHzQLSmfAp6fFr7v0csq+Jqe79dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5LgeKpusYSyxX8qx1DrgdRoJ4W0OuV8svaN4mMwLYQ=;
        b=mlwLAIOuXEZf32taBxbcXdG2tZy5KDcKOdUHNrtYvDAO19fXmIL9kyZDCuIEKAjnwV
         pXAPOXDBUuzqPScFKxJakG+tYz1DBroe8JxFBI2W3EZF69eZVInPb/OaRFhPShXCpF7e
         BUtyb1V4NzPS0CM2xY/gcibAJcdw04yT3wEtUpn0/v0SvI9szUBlGYOtkwNcwIRCtKQh
         1qn/3GDruIlCqABv48bJwn7kxIsmG3m20UY2baAB/eJOAHOGL9CywMIM+Gsd5s/LHYJX
         UG6u4RmV1BKX+dIBM6LwGdsTQYE/S28nPqilWoRVw7XRybLqE3cwgBiUjpM9NOw3rOp0
         LkUg==
X-Gm-Message-State: AOAM530P0CdhFBzgfOzm3lYcBdzM2LhxSLO1DckefF//si2qo/ytwN5C
        gqK39nbHFpC6lHVi/GE1lQxhHZVX2I/G2g==
X-Google-Smtp-Source: ABdhPJx6DcJkWzUWpASQkdTl/1t4thDEK/b1p0UTmNmJzVT2H1fZsxV8vsRV9zMCc2XL91cnWOzViA==
X-Received: by 2002:adf:f510:: with SMTP id q16mr5741957wro.343.1618426455698;
        Wed, 14 Apr 2021 11:54:15 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:15 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 0/6] Add a snprintf eBPF helper
Date:   Wed, 14 Apr 2021 20:54:00 +0200
Message-Id: <20210414185406.917890-1-revest@chromium.org>
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
 kernel/bpf/helpers.c                          | 304 ++++++++++++++
 kernel/bpf/verifier.c                         |  82 ++++
 kernel/trace/bpf_trace.c                      | 373 ++----------------
 tools/include/uapi/linux/bpf.h                |  28 ++
 tools/lib/bpf/bpf_tracing.h                   |  58 ++-
 .../selftests/bpf/prog_tests/snprintf.c       | 124 ++++++
 .../selftests/bpf/progs/test_snprintf.c       |  73 ++++
 .../bpf/progs/test_snprintf_single.c          |  20 +
 10 files changed, 767 insertions(+), 345 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c

-- 
2.31.1.295.g9ea45b61b8-goog

