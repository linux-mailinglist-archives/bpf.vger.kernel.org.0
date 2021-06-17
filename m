Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0663ABF60
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhFQXba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 19:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhFQXb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 19:31:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484AFC061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w31so6236786pga.6
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBXNPqoHcsY093Rly0NwbkAzd1rHw/S0lUY+IIzdMJE=;
        b=WdcIN5fJeIyQT9vQhsOC8wrBKVgqZEqmWAU6T687cb6WWU71ITST4IHYPABlOYPdlB
         ms1oumbba6+BQuCet3syGgMDHZC3ghJFNh2bdPcu6cg9YmCh8J2SLKAhVfddEAkF0DGL
         nYJ3L0EuOuvGazOuoTqsddpv5BL5oZSZDO99s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBXNPqoHcsY093Rly0NwbkAzd1rHw/S0lUY+IIzdMJE=;
        b=tRylzbD3RWQElBJeNdTa/ev6ivxPsdMV/1R92xJ3hwBxOf+cGZYTs9riDUFoGcWl6c
         VDMsDIyGJ+MKnqwPHnOPRjl5XM2cgwMqfXVIEgGXLojknHK78cixqIrOoFmnyMKNuJA5
         8W0JCnA7HmXyQmDHNo4CgC0CFDJFJdSSaICCO75IakDDn4LRNAb6rNUynR/jpzdEJGNL
         9plZJSoULEHAnZm1HSV8S/3431jrMHNkC4utiCvL5YnVIMH7pfB9snWPNyG/c/+QLHd7
         nNGCYlmQS9SW9/1UE87ljLb296kb0WiqvmOCfVesBvi6mGJMLWbYFIQp5iimDwbs9quP
         KPZg==
X-Gm-Message-State: AOAM533P/5l8XCCYTHzHJqrkaSYnXKwBAUIst9IvMEIm+cJZ8otHHJYk
        JeOs9IMu3Ne5AEvnWDNKyJ3qwbs4wHxUzQ==
X-Google-Smtp-Source: ABdhPJwnUGok6FK+YJNZ7nr+jtkmX6rtmTMvF+kbuNTJYGiycWZ1SO8TAfE3FBIKjk+y7i9ozKjcBQ==
X-Received: by 2002:a62:7d4e:0:b029:2e9:ac1c:2769 with SMTP id y75-20020a627d4e0000b02902e9ac1c2769mr2245154pfc.57.1623972558399;
        Thu, 17 Jun 2021 16:29:18 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id a21sm6217241pfg.188.2021.06.17.16.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:29:17 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next v6 0/4] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 17 Jun 2021 23:29:00 +0000
Message-Id: <20210617232904.1899-1-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support for passing an xdp_md via ctx_in/ctx_out in
bpf_attr for BPF_PROG_TEST_RUN of XDP programs.

Patch 1 adds a function to validate XDP meta data lengths.

Patch 2 adds initial support for passing XDP meta data in addition to
packet data.

Patch 3 adds support for also specifying the ingress interface and
rx queue.

Patch 4 adds selftests to ensure functionality is correct.

Changelog:
----------
v5->v6
v5: https://lore.kernel.org/bpf/20210616224712.3243-1-zeffron@riotgames.com/

 * Correct commit messages in patches 1 and 3
 * Add Acked-by to commit message in patch 4
 * Use gotos instead of returns to correctly free resources in
  bpf_prog_test_run_xdp
 * Rename xdp_metalen_valid to xdp_metalen_invalid
 * Improve the function signature for xdp_metalen_invalid
 * Merged declaration of ingress_ifindex and rx_queue_index into one line

v4->v5
v4: https://lore.kernel.org/bpf/20210604220235.6758-1-zeffron@riotgames.com/

 * Add new patch to introduce xdp_metalen_valid inline function to avoid
  duplicated code from net/core/filter.c
 * Correct size of bad_ctx in selftests
 * Make all declarations reverse Christmas tree
 * Move data check from xdp_convert_md_to_buff to bpf_prog_test_run_xdp
 * Merge xdp_convert_buff_to_md into bpf_prog_test_run_xdp
 * Fix line too long
 * Extracted common checks in selftests to a helper function
 * Removed redundant assignment in selftests
 * Reordered test cases in selftests
 * Check data against 0 instead of data_meta in selftests
 * Made selftests use EINVAL instead of hardcoded 22
 * Dropped "_" from XDP function name
 * Changed casts in XDP program from unsigned long to long
 * Added a comment explaining the use of the loopback interface in selftests
 * Change parameter order in xdp_convert_md_to_buff to be input first
 * Assigned xdp->ingress_ifindex and xdp->rx_queue_index to local variables in
  xdp_convert_md_to_buff
 * Made use of "meta data" versus "metadata" consistent in comments and commit
  messages

v3->v4
v3: https://lore.kernel.org/bpf/20210602190815.8096-1-zeffron@riotgames.com/

 * Clean up nits
 * Validate xdp_md->data_end in bpf_prog_test_run_xdp
 * Remove intermediate metalen variables

v2 -> v3
v2: https://lore.kernel.org/bpf/20210527201341.7128-1-zeffron@riotgames.com/

 * Check errno first in selftests
 * Use DECLARE_LIBBPF_OPTS
 * Rename tattr to opts in selftests
 * Remove extra new line
 * Rename convert_xdpmd_to_xdpb to xdp_convert_md_to_buff
 * Rename convert_xdpb_to_xdpmd to xdp_convert_buff_to_md
 * Move declaration of device and rxqueue in xdp_convert_md_to_buff to
  patch 2
 * Reorder the kfree calls in bpf_prog_test_run_xdp

v1 -> v2
v1: https://lore.kernel.org/bpf/20210524220555.251473-1-zeffron@riotgames.com

 * Fix null pointer dereference with no context
 * Use the BPF skeleton and replace CHECK with ASSERT macros


Zvi Effron (4):
  bpf: add function for XDP meta data length check
  bpf: support input xdp_md context in BPF_PROG_TEST_RUN
  bpf: support specifying ingress via xdp_md context in
    BPF_PROG_TEST_RUN
  selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN

 include/net/xdp.h                             |   5 +
 include/uapi/linux/bpf.h                      |   3 -
 net/bpf/test_run.c                            |  87 +++++++++++++--
 net/core/filter.c                             |   4 +-
 .../bpf/prog_tests/xdp_context_test_run.c     | 105 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 ++++
 6 files changed, 211 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: 8fe088bd4fd12f4c8899b51d5bc3daad98767d49
-- 
2.31.1

