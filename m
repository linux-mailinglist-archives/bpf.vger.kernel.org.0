Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD37C2661E6
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 17:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKPPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgIKPM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:12:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC792C06136E
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:31:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so10215370edk.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0QD34+bxOAz0p5Ruf1S0pwezgoC99GUrOiFTRHr1WU=;
        b=s7+XJKuz3oEy3pnN/elhmjMP3fwttIcgzseKr38icNThXbOY0LirJo1to8ih0eNwQA
         1KVmgArwT9O0ardNtiHkXQr8ohGLQ3earWaQz2bNkJyavHpjUOfqH+Rutql5evnZd+Wh
         ElzqI1mWKCmB58u26vkRGzBC30VJZaPuMrtCYlhX61qRdr1KXozuXbPHYa6PCfyjzIaD
         fvfOOfdUXUj4+OUuH2PQ2U1nJ34ARaYMY27CZuB+H1DB8Dwubq3h+SEl5oAvEQ3z2Pde
         LMYbLS+kf5N+T2N3Psx1V3ZEDhgWCrTGE48hCzhGy1NvpqiM/I1E80W0/usazP+4Lz07
         5TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0QD34+bxOAz0p5Ruf1S0pwezgoC99GUrOiFTRHr1WU=;
        b=aCsUatlITuVc1IIVw0gTRzMGgY3VcNsF037yz3Gakpu2c6mIbPNISoagOZ1a16q+77
         vuVyZMfv98CiHXazjgT44Q/poalJiYT6YFVCU68awK4gd4wh5HLRBgs+mjqkrQHHoC3l
         byazlCtbg1Mwc9+ZwvT9Z0xVWdsZO2V6uEDIPaFFyjqUqwqfcBrXaB718gkdxBtNIJXn
         N/QzBOIKrrL3b2JdLbwF5sQnWbaTj4qsY2O8nxY+2bWagZ9OtS7zQQVpg1/QiCiHtaGW
         CvU0NfAvF4EBa1s0DDggmyAJskbZAFDId9G82sVxwO05gie50uapYHLflDudbWdyWb9E
         h70w==
X-Gm-Message-State: AOAM531/QnXDiQQRdvQ5FLZEb/1bHd6T10h48njsVkcX+KYObcJ+3sB0
        MGeiRzr3Pjdta5nqBCXLpXjJ1w==
X-Google-Smtp-Source: ABdhPJyNl/jj9IvK4T0bkJprq/8BXcKllYou73+Al1l1qxTjRLji8C3rkP9NSSxO0s2oL8lobF2CFA==
X-Received: by 2002:a05:6402:1710:: with SMTP id y16mr2416437edu.197.1599834691462;
        Fri, 11 Sep 2020 07:31:31 -0700 (PDT)
Received: from localhost.localdomain ([87.66.33.240])
        by smtp.gmail.com with ESMTPSA id y21sm1716261eju.46.2020.09.11.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 07:31:30 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mptcp@lists.01.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 0/5] bpf: add MPTCP subflow support
Date:   Fri, 11 Sep 2020 16:30:21 +0200
Message-Id: <20200911143022.414783-6-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911143022.414783-1-nicolas.rybowski@tessares.net>
References: <20200911143022.414783-1-nicolas.rybowski@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously it was not possible to make a distinction between plain TCP
sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.

This patch series now enables a fine control of subflow sockets. In its
current state, it allows to put different sockopt on each subflow from a
same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
BPF programs.

It should also be the basis of exposing MPTCP-specific fields through BPF.

v1 -> v2:
- add basic mandatory selftests for the new helper and is_mptcp field (Alexei)
- rebase on latest bpf-next

Nicolas Rybowski (5):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  mptcp: attach subflow socket to parent cgroup
  bpf: add 'bpf_mptcp_sock' structure and helper
  bpf: selftests: add MPTCP test base
  bpf: selftests: add bpf_mptcp_sock() verifier tests

 include/linux/bpf.h                           |  33 +++++
 include/uapi/linux/bpf.h                      |  15 +++
 kernel/bpf/verifier.c                         |  30 +++++
 net/core/filter.c                             |  13 +-
 net/mptcp/Makefile                            |   2 +
 net/mptcp/bpf.c                               |  72 +++++++++++
 net/mptcp/subflow.c                           |  27 ++++
 scripts/bpf_helpers_doc.py                    |   2 +
 tools/include/uapi/linux/bpf.h                |  15 +++
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  37 +++++-
 tools/testing/selftests/bpf/network_helpers.h |   3 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 119 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  48 +++++++
 tools/testing/selftests/bpf/verifier/sock.c   |  63 ++++++++++
 15 files changed, 474 insertions(+), 6 deletions(-)
 create mode 100644 net/mptcp/bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp.c

-- 
2.28.0

