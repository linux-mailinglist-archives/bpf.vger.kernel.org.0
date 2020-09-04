Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA38C25D584
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIDJ7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIDJ7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 05:59:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86CC061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 02:59:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o21so5528540wmc.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9m3/iW1nwxBcVKjrmsVLGnSEgchrFvLIg+SGVpnLZM=;
        b=G/sLYlMjeuzG5lECxm4DG+TCnHzTsMGm2VAk0OMutA/1g2Yw8fG07YX5X63Zleq27d
         YTEdW5T/AmVJvFls3n9AIfk5dv8hwHPS/hVi+ei25Or8HUZD/b5kYLGdFlV4KmIfB5pi
         +0I5Pq8BIozn3p9yz/rH70s9oSYeZpEBlc6nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9m3/iW1nwxBcVKjrmsVLGnSEgchrFvLIg+SGVpnLZM=;
        b=N/2CpAOYPqgbQD1W5yO2csEvZb8I80WrF5BVIrl0ysV4z1tgTQVYgc7ZH861hmpiUJ
         JBvlfXoTBKtS5kBoCZysdmACpa2J0LYSnDPv8Km+36P/c7U8fXgKgtvMt2aGOjUNT11x
         r80HyNu46SUOVqHaSi6OkMPSRRPpbHnZ5axXz4g6ITckfpHOlCMu1Ltm3CA5LL3txO/y
         tBWeYCzLulwXcpmACllrbiSJdrBaqDf+wz5anLQju4yByp7tLZPItIJKv6rYJqKZ7aB8
         i4kRg2bDziz6HZnGA6vKLJ+8eq91UieyTPLadjoO0phsjXVyupuvxzwzkNR65B7TnF+K
         cdlg==
X-Gm-Message-State: AOAM531gMwFJuHwDwyvOGD6OX16Wna+k2JyHenicNd+Zg2vCyf3U0Fi7
        3Tc9drP9X42eJvgIBY4TYVAJXQ==
X-Google-Smtp-Source: ABdhPJyuv7Fzd8IpmkIl8NU0wKlo68l+ilaFvbvGpIhla6fZA+kU4TUaAU8llw9rMH5EmQY8NNBRFQ==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr7218348wmu.156.1599213562552;
        Fri, 04 Sep 2020 02:59:22 -0700 (PDT)
Received: from antares.lan (a.6.f.d.9.5.a.d.2.b.c.0.f.d.4.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:24df:cb2:da59:df6a])
        by smtp.gmail.com with ESMTPSA id c18sm11648088wrx.63.2020.09.04.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:59:21 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 0/6] Sockmap iterator
Date:   Fri,  4 Sep 2020 10:58:58 +0100
Message-Id: <20200904095904.612390-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This addresses feedback of v2 [2] (see [1] for v1). From my POV the open
questions from v2 have been addressed.

I have a set of check_func_arg cleanups which I will post as a follow up
to this series.

Changes in v3:
- Use PTR_TO_BTF_ID in iterator context (Yonghong, Martin)
- Use rcu_dereference instead of rcu_dereference_raw (Jakub)
- Fix various test nits (Jakub, Andrii)

Changes in v2:
- Remove unnecessary sk_fullsock checks (Jakub)
- Nits for test output (Jakub)
- Increase number of sockets in tests to 64 (Jakub)
- Handle ENOENT in tests (Jakub)
- Actually test SOCKHASH iteration (myself)
- Fix SOCKHASH iterator initialization (myself)

1: https://lore.kernel.org/bpf/20200828094834.23290-1-lmb@cloudflare.com/
2: https://lore.kernel.org/bpf/20200901103210.54607-1-lmb@cloudflare.com/

Lorenz Bauer (6):
  bpf: Allow passing BTF pointers as PTR_TO_SOCKET
  net: sockmap: Remove unnecessary sk_fullsock checks
  net: Allow iterating sockmap and sockhash
  selftests: bpf: Ensure that BTF sockets cannot be released
  selftests: bpf: Add helper to compare socket cookies
  selftests: bpf: Test copying a sockmap via bpf_iter

 kernel/bpf/verifier.c                         |  61 ++--
 net/core/sock_map.c                           | 284 +++++++++++++++++-
 .../bpf/prog_tests/reference_tracking.c       |  20 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 138 ++++++++-
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  57 ++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 +
 .../bpf/progs/test_sk_ref_track_invalid.c     |  20 ++
 8 files changed, 548 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c

-- 
2.25.1

