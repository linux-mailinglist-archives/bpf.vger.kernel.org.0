Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B68D85B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHNQrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 12:47:46 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48260 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNQrq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 12:47:46 -0400
Received: by mail-ua1-f74.google.com with SMTP id z21so843055uaq.15
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FPuI57Gwp6Wac6Fi4cTNK0HXdqhfqqrfPDHjjOcr8Bw=;
        b=L6+4a2vUg7jyTQ7kgadz00cPI0WU08mtGoMFsuKPq/xQxXgTiYnru1b8OCqzKANMBA
         9I7xseSeeHKBQ386E7VibqNQ83lGJUqBMySO9+fGbhhY3s+7ccKWOwIFN54QnRL1XBRn
         45lSlLMnMPXbXXvQIR72UKqbU2/xFYoMlUe0TBLRt28c6gQ1pH8AIJuT5O7Ml7vFoBc6
         omEzHbLeTwYbvGDses6PVc6ayRDfahZOkHKuBDfYS7VXFks1Bn5VVP6sxdfoFiprVPnf
         /vIWm2u3EvjF8swmxn2K8gLvR4moBeME3Xq1cKvIuS9WHC1UQI1tLuygtB8Q21zJjZmr
         Lq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FPuI57Gwp6Wac6Fi4cTNK0HXdqhfqqrfPDHjjOcr8Bw=;
        b=ce+I/005oA0jOCKHhFRLEqNW+9ShVmgq0UAoNQ1RG5Es3MV5CBfon3ePE9lMC/kAaD
         s71ESV8CFc8JNUBxsKiQZU6NXNe88tVmbzKjprzW/DyvOirq2ZjawhPu478UqkfpJPKR
         UK5YsbyxJ/5tPfvAcvi/LX9nJFbXXZDydKhPo8jpWFp3GJYXovzVkKKm8swR9h7G1HAQ
         e2KDlkFJdEBbuzGy2soO+Cd5T5QTQE5Ug9y4p4uFlbwQ+4JJZz2harmk7iIsZzDvnOtb
         muLdMKVSqjxrlg/HQyIgXVN9HMURw5ko/95WuHTNq5nNGndHkJfhwL/PzWFZMSzujADc
         Y1MQ==
X-Gm-Message-State: APjAAAWbxtyGrQp23R4ZP3VJHCFxvD+Eg1jkS6BpwKzCEp5/X0Iefxac
        UmJDq/A1oM9I1FcVzt6rRo2mflo=
X-Google-Smtp-Source: APXvYqxs88uisoBK0TpmlGkLAwrocAYqPq1bS41Z7Acmj+peWMYkXuraXSDo5YE15Ysd+zTQ8I1IBvE=
X-Received: by 2002:a1f:1288:: with SMTP id 130mr86504vks.12.1565801264638;
 Wed, 14 Aug 2019 09:47:44 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:47:38 -0700
Message-Id: <20190814164742.208909-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next 0/4] selftests/bpf: test_progs: misc fixes
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

* make output a bit easier to follow
* add test__skip to indicate skipped tests
* remove global success/error counts (use environment)
* remove asserts from the tests

Cc: Andrii Nakryiko <andriin@fb.com>

Stanislav Fomichev (4):
  selftests/bpf: test_progs: change formatting of the condenced output
  selftests/bpf: test_progs: test__skip
  selftests/bpf: test_progs: remove global fail/success counts
  selftests/bpf: test_progs: remove asserts from subtests

 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 32 +++++--
 .../bpf/prog_tests/bpf_verif_scale.c          | 10 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  2 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  2 +-
 .../selftests/bpf/prog_tests/global_data.c    | 10 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |  4 +-
 .../selftests/bpf/prog_tests/map_lock.c       | 28 +++---
 .../selftests/bpf/prog_tests/pkt_access.c     |  2 +-
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  2 +-
 .../bpf/prog_tests/queue_stack_map.c          |  4 +-
 .../bpf/prog_tests/reference_tracking.c       |  2 +-
 .../selftests/bpf/prog_tests/send_signal.c    |  1 +
 .../selftests/bpf/prog_tests/spinlock.c       | 12 ++-
 .../bpf/prog_tests/stacktrace_build_id.c      | 11 ++-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 11 ++-
 .../selftests/bpf/prog_tests/stacktrace_map.c |  2 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  2 +-
 .../bpf/prog_tests/task_fd_query_rawtp.c      |  2 +-
 .../bpf/prog_tests/task_fd_query_tp.c         |  2 +-
 .../selftests/bpf/prog_tests/tcp_estats.c     |  2 +-
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          |  2 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  4 +-
 tools/testing/selftests/bpf/test_progs.c      | 93 +++++++++++--------
 tools/testing/selftests/bpf/test_progs.h      | 28 +++++-
 25 files changed, 165 insertions(+), 107 deletions(-)

-- 
2.23.0.rc1.153.gdeed80330f-goog
