Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BCB32C154
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445671AbhCCWkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843039AbhCCKYs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A5C08ED88
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 02:18:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f12so19222527wrx.8
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrjISZvwHbhwQBfRB9QHN6sF/EaAM40kAOYVP7EBVPk=;
        b=yAr0OpU+J5TnBd2deL9/KG6DkLgp+D2rcjyU28XXNUmWYTepPnPJW0hmFRrV+ounO8
         K7BNCcSH5Egh4MDcMIQCV+o782+A6OzDYSsgeD8/XjZsoZPeRZx4iHFZfcoDjnfsp/Wz
         eh8DI2EhYpqJOjeOf5YfHkvlHqfcvH41nQJ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrjISZvwHbhwQBfRB9QHN6sF/EaAM40kAOYVP7EBVPk=;
        b=NuwDgbyvOvAEFchB/9t8Yvh8VqG3Dz20vgxxkhygCW5SiMRu2H9vKklnsO1tRhLHQo
         /w9J6BSXI3eSg6+uJjjsq+Leh0JXkInNxrNDfJoSYJpC6WZQRMp9hrUSFWNLwqLG7Cht
         2uEADcYB1UhqmK0tIzqv/jsy4WZHaVeOCfOvX4tl6EIxD4R/0iHhvsuSR+8ppdGpweej
         /xxHLXQdB3OcS15XyrylEfYzXW7+RgWYThZ2gOpjK5hE1B6D15yRhTOy/aoQX9rfmXya
         JhF6J6x/SO/aARI4vX0ue8ElXd/GUPuZy/kPbii59QOGBQCH+lgtZ9uoHG9EBRz6B9w1
         VNdg==
X-Gm-Message-State: AOAM531ftOLvUGQEXO+/l7H4VhzH0dgEfF+1Zr9tFrgNjSZfhubYQgKh
        wl0i8h6k4WYsVdxJqjnA621XAw==
X-Google-Smtp-Source: ABdhPJwouyFYuLRZj6bEB1+6XmR8zNP/itvznp79frNrqnTcU/VMSyPnF2hyfkLjUF7dp6+rDpI1+Q==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr26641486wra.42.1614766706440;
        Wed, 03 Mar 2021 02:18:26 -0800 (PST)
Received: from localhost.localdomain (c.a.8.8.c.1.2.8.8.7.0.2.6.c.a.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1ac6:2078:821c:88ac])
        by smtp.gmail.com with ESMTPSA id r26sm1710761wmn.28.2021.03.03.02.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:18:25 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 0/5] PROG_TEST_RUN support for sk_lookup programs
Date:   Wed,  3 Mar 2021 10:18:11 +0000
Message-Id: <20210303101816.36774-1-lmb@cloudflare.com>
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

Changes since v3:
- Use bpf_test_timer prefix (Andrii)

Changes since v2:
- Fix test_verifier failure (Alexei)

Changes since v1:
- Add sparse annotations to the t_* functions
- Add appropriate type casts in bpf_prog_test_run_sk_lookup
- Drop running multiple programs

Lorenz Bauer (5):
  bpf: consolidate shared test timing code
  bpf: add PROG_TEST_RUN support for sk_lookup programs
  selftests: bpf: convert sk_lookup ctx access tests to PROG_TEST_RUN
  selftests: bpf: check that PROG_TEST_RUN repeats as requested
  selftests: bpf: don't run sk_lookup in verifier tests

 include/linux/bpf.h                           |  10 +
 include/uapi/linux/bpf.h                      |   5 +-
 net/bpf/test_run.c                            | 246 +++++++++++++-----
 net/core/filter.c                             |   1 +
 tools/include/uapi/linux/bpf.h                |   5 +-
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  51 +++-
 .../selftests/bpf/prog_tests/sk_lookup.c      |  83 ++++--
 .../selftests/bpf/progs/test_sk_lookup.c      |  62 +++--
 tools/testing/selftests/bpf/test_verifier.c   |   4 +-
 .../selftests/bpf/verifier/ctx_sk_lookup.c    |   1 +
 10 files changed, 356 insertions(+), 112 deletions(-)

-- 
2.27.0

