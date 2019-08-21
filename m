Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2398805
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHUXob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 19:44:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39763 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfHUXob (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 19:44:31 -0400
Received: by mail-pf1-f201.google.com with SMTP id n186so2692845pfn.6
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9ejBxwIf2OTyCOXhoIveUpnEl0lj13boerWhd2cThhI=;
        b=q7nA1XxwNpr4Kr/1jhDYs7iNjubMJ6FanU8AvcDrFg78pcAeZZ23Uql/YB/5qjKdKC
         6MkyHIPzjGkdTqnCUhe4Ej+MV39NF5Q8Ib60BNWr9X6d4ffsOVBnz3ICVtIp3LUTK6vM
         zYh4uPPEpIlR+QrfFToUlrXjhftyn4zzhI+eSEHYs7ToUAhAuo090rjRfZdLl2zAg6l3
         5TkGZup50HuY9gNmNKNHpZxtM0fyymg7WA6PanZ8pSiGfJ2qMeZQEDkm0YMaHbe0Ytlr
         Vf39NrKREACAPKAnHkeLKjH5aoTRu1ygfCmPfoHpa9i4yUHnGtfwniEXEtzRcKJ7gnBG
         oLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9ejBxwIf2OTyCOXhoIveUpnEl0lj13boerWhd2cThhI=;
        b=rfs+xhGzZqQLgrCYw+o0PiT4Xc1PGJ0ObuFMNUBO4AtSQvitt9Um9Qqz7qRPKMoYBA
         KVs4ggUCjmMFyqWbpGaQgp1yaSUb6q43HSsTwEvatWyl7zFHAaLShYbxaTsOc+dexJHV
         thb6opWLTjEt2rbHWB/NW6UFgRusqSMP1CiBWcCzVaYN2bAaos+Do8KzEpdZpnDMPGfF
         2X3N5ZEwIVh1z177Z/troIeQFG9WW5taO7zLvVbgzBA5xu0EabyryGNQm3tNEeI1U1EP
         8R3/IsHgQLHS1DN2RAZ/QZwpQw4HUi3mlFqfHVZ6axaMAo3rYqbq3gLcv43EPMxchyVe
         eW/w==
X-Gm-Message-State: APjAAAWppd0HqhVa8uUIfqQrBjP620871MYLpOHyrEGyjrqj7tNNvhQR
        xdoX0Fv54ogGgkoK8TtfHxCqDEQ=
X-Google-Smtp-Source: APXvYqwLPLYElU+JU8bBoQqiKAANKLyxCFz92Dyz4JcEov1L2y/e0ZulhU0MqXshwT7V4AJSp4ocWns=
X-Received: by 2002:a63:5765:: with SMTP id h37mr30486718pgm.183.1566431070034;
 Wed, 21 Aug 2019 16:44:30 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:44:23 -0700
Message-Id: <20190821234427.179886-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: test_progs: misc fixes
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* add test__skip to indicate skipped tests
* remove global success/error counts (use environment)
* remove asserts from the tests
* remove unused ret from send_signal test

v3:
* QCHECK -> CHECK_FAIL (Daniel Borkmann)

v2:
* drop patch that changes output to keep consistent with test_verifier
  (Alexei Starovoitov)
* QCHECK instead of test__fail (Andrii Nakryiko)
* test__skip count number of subtests (Andrii Nakryiko)

Cc: Andrii Nakryiko <andriin@fb.com>

Stanislav Fomichev (4):
  selftests/bpf: test_progs: test__skip
  selftests/bpf: test_progs: remove global fail/success counts
  selftests/bpf: test_progs: remove asserts from subtests
  selftests/bpf: test_progs: remove unused ret

 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 20 +++++----
 .../bpf/prog_tests/bpf_verif_scale.c          |  9 +---
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  3 --
 .../selftests/bpf/prog_tests/global_data.c    | 20 +++------
 .../selftests/bpf/prog_tests/l4lb_all.c       |  9 ++--
 .../selftests/bpf/prog_tests/map_lock.c       | 38 ++++++++--------
 .../selftests/bpf/prog_tests/pkt_access.c     |  4 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  4 +-
 .../bpf/prog_tests/queue_stack_map.c          |  8 +---
 .../bpf/prog_tests/reference_tracking.c       |  4 +-
 .../selftests/bpf/prog_tests/send_signal.c    | 43 +++++++++----------
 .../selftests/bpf/prog_tests/spinlock.c       | 16 +++----
 .../bpf/prog_tests/stacktrace_build_id.c      |  7 +--
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  7 +--
 .../selftests/bpf/prog_tests/stacktrace_map.c | 17 +++-----
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  9 ++--
 .../bpf/prog_tests/task_fd_query_rawtp.c      |  3 --
 .../bpf/prog_tests/task_fd_query_tp.c         |  5 ---
 .../selftests/bpf/prog_tests/tcp_estats.c     |  4 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  4 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          |  4 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  8 ++--
 tools/testing/selftests/bpf/test_progs.c      | 41 ++++++++++++------
 tools/testing/selftests/bpf/test_progs.h      | 19 +++++---
 25 files changed, 138 insertions(+), 172 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog
