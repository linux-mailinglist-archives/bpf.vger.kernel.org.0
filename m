Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B964258CD9
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIAKch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIAKcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 06:32:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A8C061246
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 03:32:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so930946wrt.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVd/25SA5CkuNY2Mmiqh2iS1gbDuo2vaS5H6jkOpTPc=;
        b=KaxdODE/QNVBKJ4gfEuX271Yo6HL84fbPBqIO/2a8APXqOVHugYv/8D0bi70QGB8eF
         zlbRCHmgKZomtVM8qli8Ossf7PzLuISWVHvKRUVqreZ00c115Z8o2GKSfz735QFXmfYp
         GCs6PmVMmTWx115An42gChuekx1PQP0zO+59k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVd/25SA5CkuNY2Mmiqh2iS1gbDuo2vaS5H6jkOpTPc=;
        b=NqAVBkIPo5T0V8uF2gwfPzwhoBkrF4ekhtApEz9yvuzT7g1IlTHGW/Bv7L2V2fdv8V
         BsJgR+TrIuXqyiePgx0rvVyeNdPM5vlDLaE86NQnvv3BTCd+rkL1CguseeEi6gfUbVUP
         3FnuyEKJ7WEgUjuFxsiLR3m/h57h9ODHvJq+7czUNHscFIbBuDcgWg7eXes9hjUAcUMs
         fDSKuB6RndhtcQ2xiZH4mcTYv/Pa4NCWpK9neZBUlUj7ns/xjws/KnI1Ru6nq0rsgFFc
         Kvw0NXH42HSBTcDEnqQLG271TD8Sa81dVAFgYBSJFdJ+TtF3RLVBBbPkp68e09RmiWh7
         d8vQ==
X-Gm-Message-State: AOAM5307kP/wbWh26/L7+m0ampfhgJTddF1PQUQToANGUCccsw7BV21H
        5VjvOsVr7lDGzql1PY2kzUc3VA==
X-Google-Smtp-Source: ABdhPJx6NWPDmW0MiNJ1X/DTAmJe89si28r+Wn3mEZGvtFrzUXy6a0B58WhnD0LqzYJf2quZn+Z2iA==
X-Received: by 2002:adf:e382:: with SMTP id e2mr1202205wrm.306.1598956344271;
        Tue, 01 Sep 2020 03:32:24 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l10sm1653070wru.59.2020.09.01.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:32:23 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 0/4] Sockmap iterator
Date:   Tue,  1 Sep 2020 11:32:06 +0100
Message-Id: <20200901103210.54607-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This addresses Jakub's feedback for the v1 [1]. Outstanding issues are:

* Can we use rcu_dereference instead of rcu_dereference_raw?
* Is it OK to not take the bucket lock?
* Can we teach the verifier that PTR_TO_BTF_ID can be the same as PTR_TO_SOCKET?

Changes in v2:
- Remove unnecessary sk_fullsock checks (Jakub)
- Nits for test output (Jakub)
- Increase number of sockets in tests to 64 (Jakub)
- Handle ENOENT in tests (Jakub)
- Actually test SOCKHASH iteration (myself)
- Fix SOCKHASH iterator initialization (myself)

1: https://lore.kernel.org/bpf/20200828094834.23290-1-lmb@cloudflare.com/

Lorenz Bauer (4):
  net: sockmap: Remove unnecessary sk_fullsock checks
  net: Allow iterating sockmap and sockhash
  selftests: bpf: Add helper to compare socket cookies
  selftests: bpf: Test copying a sockmap via bpf_iter

 net/core/sock_map.c                           | 287 +++++++++++++++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 141 ++++++++-
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  58 ++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 +
 5 files changed, 482 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

-- 
2.25.1

