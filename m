Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4338F55C
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhEXWIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhEXWIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 18:08:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4330C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:06:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso672926pjx.1
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Mz9qCCnntpId6IQlOHvkO4HscoZIjd1f/czrGn9Wik=;
        b=KN+qLrDux3JLjJnBEeh8Zj3mzp21loZ/em+DzJkmSeA/esO0jwkafeo4FXTCJ4BZqi
         h8wP9NrcO6tYsoCnLbFNekLwenqPQO/CUTRLfLsKxW5M0Bt2zNG895JhvB+rERPwes79
         2kgJUbuVVZoZ1f3LOP8Nmh1RAKgYZ0m9qS2Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Mz9qCCnntpId6IQlOHvkO4HscoZIjd1f/czrGn9Wik=;
        b=WUUMceZHVHx9OP+Oh/6f4HTY2lUigSKk/ECJRLthYaxlfJL10ip1TLHtenW/LyhIa6
         egEeWcUJb9yax507HqaKiu99ORAh0z4+qkt/Uw3D173AK9bjSopq36AphsYlsF6AbJqC
         u5V+GENkdwvnb7iaDaip31n55pYY2ENqxmoJhVLkP0qpXZUrxgk2y9m7g+dyuJMRZnyf
         XqE0UB7tu3xBitsaYztaHBR/h7RZ7VJMXTqt32ttmaUR8R3Q4ZC/TJ5Om0+1jYtOTl6A
         nPz6QzyOJUvBIMiemTykB1JnghlqNaHfnOqlGJp6+sCdDFuEeIaGf0BVRDoywLdgpDr1
         bjGQ==
X-Gm-Message-State: AOAM530svCYXNCvoBQUeMlSu20fHRfJ892+eZf9h/ovBFm1Hwoxwvedw
        T917rpKAYRBx9XV/fYF6iULRb6zg8djblAIM
X-Google-Smtp-Source: ABdhPJxCEdJzAnyWY+Z/TmrQIFrs1czF7lTPJrT1v3jfG7rms4d9r9S2w1rZwL7e59M+5q/ap6phOQ==
X-Received: by 2002:a17:90a:303:: with SMTP id 3mr12674184pje.120.1621894010959;
        Mon, 24 May 2021 15:06:50 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id k15sm12133338pfi.0.2021.05.24.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:06:50 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next 0/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Mon, 24 May 2021 22:05:52 +0000
Message-Id: <20210524220555.251473-1-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset add support for passing a xdp_md via ctx_in/ctx_out in bpf_attr
for BPF_PROG_TEST_RUN of XDP programs.

Patch 1 adds initial support for passing XDP meta data in addition to packet
data.

Patch 2 adds support for also specifying the ingress interface and rx queue.

Patch 3 adds selftests to ensure functionality is correct.

Zvi Effron (3):
  bpf: support input xdp_md context in BPF_PROG_TEST_RUN
  bpf: support specifying ingress via xdp_md context in
    BPF_PROG_TEST_RUN
  selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN

 include/uapi/linux/bpf.h                      |   3 -
 net/bpf/test_run.c                            |  92 +++++++++++++-
 .../bpf/prog_tests/xdp_context_test_run.c     | 117 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  22 ++++
 4 files changed, 225 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: f9bceaa59c5c47a8a08f48e19cbe887e500a1978
-- 
2.31.1

