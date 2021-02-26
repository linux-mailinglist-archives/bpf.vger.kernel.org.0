Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918FC32614F
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBZKcc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 05:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhBZKcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 05:32:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB8C06174A
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 02:31:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so8048174wrh.11
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LfT7ay7KwasSV+sFD2ZaC84G9Rrb7GHYn7zU3XdQ/XU=;
        b=ZwKmmSp24fKokSPGlq2bPqs5KXOblmvAuokvjIfEv8tjYpVI3UAW38bbqjjPu95gbp
         8fn8CQoAJDksihVHIPxhmjbAnf2CudyqSee6rbwDY48DC3OclwE7fN6phWXBLVf2QCpG
         wTTI2Yf3ZpD5rVuxE6JnHVn6sIjiwmOI1nk9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LfT7ay7KwasSV+sFD2ZaC84G9Rrb7GHYn7zU3XdQ/XU=;
        b=D9fiJS7gp1JwYdE6JPrZo6fjyhMaCgQvMYmHB+mpBY9wlWMGFuj1sAEyqOr5WsLA/R
         BjuvzZEOPQzFOOF2QlUn2KjKDbfTuWBSI6x+UgFTQS5zQOHY4Z4kLVMtlVbo4zGX1jBj
         J7F47uRG2H7khVFjTsseAfKbrDmOqgVaqLGWqz0X8YY2y2VdunufUZw358mJieYSatOs
         NeYs4BKnzOqPbB3wW4QEiUvhjMzL/0UjMgV3IEf9Tdaw4rPKkq304cgh5XOF9/7dOuLN
         S5vh84K1hnOCL0mnUmoInPTTwrIhE3Fo2D7lO3N4iWlvnemMF3pCXjNLvQe/sUept6iK
         iKNA==
X-Gm-Message-State: AOAM533IEzjvBkYTRDtT1VLXq0IPsAh5xC9xK9Qwot1NoO/T9W0Gd26Y
        N2eD0RcTn5ABSUsB9O1rHAniVA==
X-Google-Smtp-Source: ABdhPJyn6xEPInc3v+XuCtC0l/86BRgur+A0WxpiVPnmC4pIphB8qK4wWb23cs3tqG/GJlyY7pG7ZA==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr2417189wrt.426.1614335478555;
        Fri, 26 Feb 2021 02:31:18 -0800 (PST)
Received: from localhost.localdomain (d.4.3.e.3.5.0.6.8.1.5.9.3.d.9.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:69d3:9518:6053:e34d])
        by smtp.gmail.com with ESMTPSA id a21sm12448744wmb.5.2021.02.26.02.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 02:31:18 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 0/5] PROG_TEST_RUN support for sk_lookup programs
Date:   Fri, 26 Feb 2021 10:30:59 +0000
Message-Id: <20210226103103.131210-1-lmb@cloudflare.com>
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

Based on discussion on the v1 I've dropped support for testing multiple
programs at once.

Changes since v1:
- Add sparse annotations to the t_* functions
- Add appropriate type casts in bpf_prog_test_run_sk_lookup
- Drop running multiple programs

Lorenz Bauer (5):
  bpf: consolidate shared test timing code
  bpf: add for_each_bpf_prog helper
  bpf: add PROG_TEST_RUN support for sk_lookup programs
  selftests: bpf: convert sk_lookup ctx access tests to PROG_TEST_RUN
  selftests: bpf: check that PROG_TEST_RUN repeats as requested

 include/linux/bpf.h                           |  21 +-
 include/linux/filter.h                        |   4 +-
 include/uapi/linux/bpf.h                      |   5 +-
 net/bpf/test_run.c                            | 245 +++++++++++++-----
 net/core/filter.c                             |   1 +
 tools/include/uapi/linux/bpf.h                |   5 +-
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  51 +++-
 .../selftests/bpf/prog_tests/sk_lookup.c      |  83 ++++--
 .../selftests/bpf/progs/test_sk_lookup.c      |  62 +++--
 9 files changed, 358 insertions(+), 119 deletions(-)

-- 
2.27.0

