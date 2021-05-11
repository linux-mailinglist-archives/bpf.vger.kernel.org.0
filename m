Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACF37B06B
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhEKVCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVCs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 17:02:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC7C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 14:01:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v5so13439328edc.8
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DmwvoWnFxFsnWV8zB+SFUg55UC+pgsHUrCupFbSUPw=;
        b=ahgPcIgM4JgGZE+ikgfs+tgOSJqrkx7jZZ8ZXorADrPvudnnruXsSnoAJcJfPEpXV6
         yIB6nKhDMxGQy3+D0P6069J7whK5I3rF+rJwcXIeX2NZbB1s5A567dJP8sD2pBIh0kdY
         gZCGRhI6kO4visan3/DQrrtgU8YBR8a3Hob8Xui8eWlpP+rdvTeYiuDTmUI6PZZ0yLy9
         9UW8zPxiUZfqq84Uhsk1o/1nLRzXn3ifG33c/LEFsqA7feFQSx9mtAHbg0QDADj87v4C
         uWCPCAj9oNO7P30iJUDpoPD3AXWTQk9H/EqdCLrmTsYJht6tOMQMnqfrDiNwP3sKn6TI
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DmwvoWnFxFsnWV8zB+SFUg55UC+pgsHUrCupFbSUPw=;
        b=s2gsDbdM3i2kftc/2y7Gk7ELzTiMHz01q2HzL6XwfzUln7YEPHBLSsYipUoodot9hF
         B0F9yRYGGSmkskx2LZL55iObuYubVDEfP0NKUknwK3IQ69IhF1CperwhdF4ibTqgZpjs
         R6a8dPX7ifhatFEpE0qIcDpq+YnmMsjDgQndhY5vEiSeuxANDnlfVMqn3HKLBgEdVPVW
         p+wZ/CG7qTSVnf6rU5hBxYrxfIic5YHWAl8vtvhDGXFNzJZOTp+XdL9et352qohsbiZS
         Tlol8FVCwzcTcPCLnDZctqPXuoc3HQl2TCmGV4CylgLxQCz4aSWfu1lZIrEkKHN2zN9F
         AZbg==
X-Gm-Message-State: AOAM531IZLXPDXGsSFvsxtgZ4H4lsWIaOa6LQUAbZqxtQV4mcT4coEu2
        OEfC7OTuQ6VGPp5Bm9OWkkTpqgYjec8IYOZEUELQelbio+2brXPVdG85TmyCOrgqndH6+/FJQ8H
        Yo/k6B0QmVR1rphGhio9dEgrTAiWGJ9YGtXCIWSGDwsLI1OWCdN9ro/1L4Y+l5RCYIxQJSREV
X-Google-Smtp-Source: ABdhPJzxpu6jmTwsF0sG06ui+etjzT7o+JdmMGb0pdcwZRd/kjHQ7P6H2QX6BK1UplsZRE+eSxD/Jg==
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr38051043edb.205.1620766899012;
        Tue, 11 May 2021 14:01:39 -0700 (PDT)
Received: from localhost.localdomain ([93.140.9.82])
        by smtp.gmail.com with ESMTPSA id k9sm13206569eje.102.2021.05.11.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:01:38 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 0/3] Add lookup_and_delete_elem support to BPF hash map types
Date:   Tue, 11 May 2021 23:00:03 +0200
Message-Id: <cover.1620763117.git.denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series extends the existing bpf_map_lookup_and_delete_elem()
functionality with 4 more map types:
 - BPF_MAP_TYPE_HASH,
 - BPF_MAP_TYPE_PERCPU_HASH,
 - BPF_MAP_TYPE_LRU_HASH and
 - BPF_MAP_TYPE_LRU_PERCPU_HASH.

Patch 1 adds most of its functionality and logic as well as
documentation.

As it was previously limited to only stacks and queues which do not
support the BPF_F_LOCK flag, patch 2 enables its usage by adding a new
libbpf API bpf_map_lookup_and_delete_elem_flags() based on the existing
bpf_map_lookup_elem_flags().

Patch 3 adds selftests for lookup_and_delete_elem().

Changes in patch 1:
v7: Minor formating nits, add Acked-by.
v6: Remove unneeded flag check, minor code/format fixes.
v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
documentation with this changes.
v4: Fix the return value for unsupported map types.
v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
v2: Add functionality for LRU/per-CPU, add test_progs tests.

Changes in patch 2:
v7: No change.
v6: Add Acked-by.
v5: Move to the newest libbpf version (0.4.0).

Changes in patch 3:
v7: Remove ASSERT_GE macro which is already added in some other commit,
change ASSERT_OK to ASSERT_OK_PTR, add Acked-by.
v6: Remove PERCPU macros, add ASSERT_GE macro to test_progs.h, remove
leftover code.
v5: Use more appropriate macros. Better check for changed value.

Denis Salopek (3):
  bpf: add lookup_and_delete_elem support to hashtab
  bpf: extend libbpf with bpf_map_lookup_and_delete_elem_flags
  selftests/bpf: add bpf_lookup_and_delete_elem tests

 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |  13 +
 kernel/bpf/hashtab.c                          |  98 ++++++
 kernel/bpf/syscall.c                          |  34 ++-
 tools/include/uapi/linux/bpf.h                |  13 +
 tools/lib/bpf/bpf.c                           |  13 +
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/lookup_and_delete.c        | 288 ++++++++++++++++++
 .../bpf/progs/test_lookup_and_delete.c        |  26 ++
 tools/testing/selftests/bpf/test_lru_map.c    |   8 +
 tools/testing/selftests/bpf/test_maps.c       |  17 ++
 12 files changed, 511 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c

-- 
2.26.2

