Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84C31C930
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBPK7l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 05:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBPK7I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 05:59:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FFC06174A
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n4so9399090wrx.1
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXqgmXSGO2OfxbM787pr/fo3adQzSE3XAY09QFycryU=;
        b=wFr3e5P4VYoR7vnRPBjrDjDE2+e8s3Iprkn/Z9+CCbyTrL+Uv6A/JOKbWhCPo56/I9
         uUMLI0UQinS4Ybq4s4iz1naybV0LsBr+y/t0enI9OgXQhGRqepIawS/A0dFbdsIOyqJy
         3m/vOeYBhslEX8d3XChmhtQWGGkiez063rasg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXqgmXSGO2OfxbM787pr/fo3adQzSE3XAY09QFycryU=;
        b=ovOaR6ctNMCNXC4MXpYUynzcbH5yN1XL0UUV79VHX/sRzb/Q4kzIxTf/UZ8Rvu9gKq
         jahtl4VDjcsaMnvC4LuezqSczzFYFUg+jNLgNU8Me3Gd/+8/dVmXYLVkEyM/T3C7rJVy
         MLyFnfaMoamcFTAOoQL4Lu9Sw3KlBZADKHGFEtZb2MfKQ+8YtBAzSpXIFg5HaXt05bhW
         166pkuQezCJsHStpzbdaUV2L1G6c7kFztg7rKh1N39pSsn7w+beAE+kRh95Z6JJQu4cR
         DHUU17sxWPEzBT+pgNfcfh1ez+NCCXQVqlgpV9IQLI9qFiGn/WDIVhVNT2h7tFAFwHWL
         v7EQ==
X-Gm-Message-State: AOAM532c47498QwuQf7pmQodHLf0JbwyaeBM7JxSreoRkftYQE7MmG27
        S9DXgu327Xe01Y/kTBVUVpMMpQ==
X-Google-Smtp-Source: ABdhPJxPu+mQfUsUJP3uh7BIhcSbMhQoXkDcblnv7J079B+o50BUhyfoTNA5Sj/UMcbowxzYFuKieA==
X-Received: by 2002:adf:f80e:: with SMTP id s14mr6445421wrp.363.1613473096077;
        Tue, 16 Feb 2021 02:58:16 -0800 (PST)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l1sm2820238wmi.48.2021.02.16.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 02:58:15 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jakub@cloudflare.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 0/8] PROG_TEST_RUN support for sk_lookup programs
Date:   Tue, 16 Feb 2021 10:57:05 +0000
Message-Id: <20210216105713.45052-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We don't have PROG_TEST_RUN support for sk_lookup programs at the
moment. So far this hasn't been a problem, since we can run our
tests in a separate network namespace. For benchmarking it's nice
to have PROG_TEST_RUN, so I've gone and implemented it.

Multiple sk_lookup programs can be attached at once to the same
netns. This can't be expressed with the current PROG_TEST_RUN
API, so I'm proposing to extend it with an array of prog_fd.

Patches 1-2 are clean ups. Patches 3-4 add the new UAPI and
implement PROG_TEST_RUN for sk_lookup. Patch 5 adds a new
function to libbpf to access multi prog tests. Patches 6-8 add
tests.

Andrii, for patch 4 I decided on the following API:

    int bpf_prog_test_run_array(__u32 *prog_fds, __u32 prog_fds_cnt,
                                struct bpf_test_run_opts *opts)

To be consistent with the rest of libbpf it would be better
to take int *prog_fds, but I think then the function would have to
convert the array to account for platforms where

    sizeof(int) != sizeof(__u32)

Please let me know what your preference is.

Lorenz Bauer (8):
  bpf: consolidate shared test timing code
  bpf: add for_each_bpf_prog helper
  bpf: allow multiple programs in BPF_PROG_TEST_RUN
  bpf: add PROG_TEST_RUN support for sk_lookup programs
  tools: libbpf: allow testing program types with multi-prog semantics
  selftests: bpf: convert sk_lookup multi prog tests to PROG_TEST_RUN
  selftests: bpf: convert sk_lookup ctx access tests to PROG_TEST_RUN
  selftests: bpf: check that PROG_TEST_RUN repeats as requested

 include/linux/bpf-netns.h                     |   2 +
 include/linux/bpf.h                           |  24 +-
 include/linux/filter.h                        |   4 +-
 include/uapi/linux/bpf.h                      |  11 +-
 kernel/bpf/net_namespace.c                    |   2 +-
 kernel/bpf/syscall.c                          |  73 +++++-
 net/bpf/test_run.c                            | 230 +++++++++++++-----
 net/core/filter.c                             |   1 +
 tools/include/uapi/linux/bpf.h                |  11 +-
 tools/lib/bpf/bpf.c                           |  16 +-
 tools/lib/bpf/bpf.h                           |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  51 +++-
 .../selftests/bpf/prog_tests/sk_lookup.c      | 172 +++++++++----
 .../selftests/bpf/progs/test_sk_lookup.c      |  62 +++--
 15 files changed, 499 insertions(+), 164 deletions(-)

-- 
2.27.0

