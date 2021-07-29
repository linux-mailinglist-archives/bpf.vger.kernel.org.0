Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA93DA8CB
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhG2QUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhG2QUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:20:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77738C0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so4431441wmb.5
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtLmtRs4JsMEZEwpXWJLmasDrmSYlGnq+nOgcswpGZQ=;
        b=B1R7gwYCfNpEf/YEwhsW+0ML3ftVkCHyJUISA65Xj8hH/M4TP2CIBv8KQTXOqb55Rl
         NRjydXsWsxtCyb6iLoSL8NjGlLPG5a1UdPKAZT6gGxGKT6l7XJWB1koMGk7/voPsdVNO
         ygr9Qh71ODr8SkHBVXyzQhwQP0cj+KDBRWMHxJlMPRHTlUwpFlaJTuDZUU0W1PVJuoab
         nEUA2Wbibtj6udrKJJjj3sCEioMnZRDXoUpSHWz1aOCGUxqw+l2XbkVbffDxwmQvN1Xk
         r9fkzRSZlRJ+vyURIFUISW3ZYU3a61a+Z2f73Mu/FCE0H4LPv/+kzry+ZY5h3Qw8lQQn
         UOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtLmtRs4JsMEZEwpXWJLmasDrmSYlGnq+nOgcswpGZQ=;
        b=Q0n/rHWeRMc3rpy14wZu2kAVXfb4UEb+Sg0yBOpoMbhI1Jv6rFlEAPVrWrkxjAWjhP
         2BXQx9YQug/MhNTthY1cqUBxpXLtkVDWbQr62sx/9DKwmtKvd7GvuLRsFDq7ZNc6QMuv
         ua1QyrYup4tvQ6YfJwsaDCVrKsixTBE8UtdUMwgQ5I//zeBh6frOk1CL1HIU/vEXSS7a
         N6mHdTvfGul46Qax4LtRTLRI68IzG3LoUUZRa0IwWM2kziubeH9tOsIYMfK17859Dw5N
         OhAmGobwjdYDFOzg8YbRYWSPt4QAUvnaCge+dkgt3kbCYkO5xguIX6hiSIh8MAxZPUiB
         4OIQ==
X-Gm-Message-State: AOAM533653xLfFJzTHJrl26nv/ZIEpLh2nmeIxzFCgqzfX4KRjM9/az/
        2EAoWXbi3M/SKWx6inPJ1Qlu5w==
X-Google-Smtp-Source: ABdhPJwTD06TMBMqD+vnT1WHyhhbweph9yfbmEgUj8W5OCLtXIPsReIZEvTwciaWkWW/T6BdtMah6A==
X-Received: by 2002:a05:600c:4649:: with SMTP id n9mr8031990wmo.168.1627575636942;
        Thu, 29 Jul 2021 09:20:36 -0700 (PDT)
Received: from localhost.localdomain ([149.86.66.250])
        by smtp.gmail.com with ESMTPSA id c10sm3854853wmb.40.2021.07.29.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:20:36 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 0/8] libbpf: rename btf__get_from_id() and btf__load() APIs, support split BTF
Date:   Thu, 29 Jul 2021 17:20:20 +0100
Message-Id: <20210729162028.29512-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the effort to move towards a v1.0 for libbpf [0], this set
improves some confusing function names related to BTF loading from and to
the kernel:

- btf__load() becomes btf__load_into_kernel().
- btf__get_from_id becomes btf__load_from_kernel_by_id().
- A new version btf__load_from_kernel_by_id_split() extends the former to
  add support for split BTF.

The old functions are marked for deprecation for the next minor version
(0.6) of libbpf.

The last patch is a trivial change to bpftool to add support for dumping
split BTF objects by referencing them by their id (and not only by their
BTF path).

[0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

v3:
- Use libbpf_err_ptr() in btf__load_from_kernel_by_id(), ERR_PTR() in
  bpftool's get_map_kv_btf().
- Move the definition of btf__load_from_kernel_by_id() closer to the
  btf__parse() group in btf.h (move the legacy function with it).
- Fix a bug on the return value in libbpf_find_prog_btf_id(), as a new
  patch.
- Move the btf__free() fixes to their own patch.
- Add "Fixes:" tags to relevant patches.
- Re-introduce deprecation (removed in v2) for the legacy functions, as a
  new macro LIBBPF_DEPRECATED_SINCE(major, minor, message).

v2:
- Remove deprecation marking of legacy functions (patch 4/6 from v1).
- Make btf__load_from_kernel_by_id{,_split}() return the btf struct, adjust
  surrounding code and call btf__free() when missing.
- Add new functions to v0.5.0 API (and not v0.6.0).

Quentin Monnet (8):
  libbpf: return non-null error on failures in libbpf_find_prog_btf_id()
  libbpf: rename btf__load() as btf__load_into_kernel()
  libbpf: rename btf__get_from_id() as btf__load_from_kernel_by_id()
  tools: free BTF objects at various locations
  tools: replace btf__get_from_id() with btf__load_from_kernel_by_id()
  libbpf: prepare deprecation of btf__get_from_id(), btf__load()
  libbpf: add split BTF support for btf__load_from_kernel_by_id()
  tools: bpftool: support dumping split BTF by id

 tools/bpf/bpftool/btf.c                      |  8 ++---
 tools/bpf/bpftool/btf_dumper.c               |  6 ++--
 tools/bpf/bpftool/map.c                      | 14 ++++-----
 tools/bpf/bpftool/prog.c                     | 29 +++++++++++------
 tools/lib/bpf/Makefile                       |  3 ++
 tools/lib/bpf/btf.c                          | 33 ++++++++++++++------
 tools/lib/bpf/btf.h                          |  7 ++++-
 tools/lib/bpf/libbpf.c                       | 11 ++++---
 tools/lib/bpf/libbpf.map                     |  3 ++
 tools/lib/bpf/libbpf_common.h                | 19 +++++++++++
 tools/perf/util/bpf-event.c                  | 11 ++++---
 tools/perf/util/bpf_counter.c                | 12 +++++--
 tools/testing/selftests/bpf/prog_tests/btf.c |  4 ++-
 13 files changed, 113 insertions(+), 47 deletions(-)

-- 
2.30.2

