Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F031582D
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhBIU4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 15:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhBIUq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44319C061793
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 11:48:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j11so10345445plt.11
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 11:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=65E9QWlOxnsFpuJu25gLN+MB82p4NIaj7h47IO0OcuA=;
        b=R585lJ1hF46WpwHmF3aKEwzXLrhqbMMFgw+YRcmA6ZR45aG75kWq4aBHYQ8dyHorMq
         5FmrcHYwpx5bm63M56TpUk9TYCRD0TzQ8GusVOCpJKrY//GkfEVBpf+9BYhEfl6jRk46
         0buKZTbBZ0/PYqx3RfnlhAdbkIZ0y06yKKGAk3qrFe5lZ7Yix2kKozSuvorJywflS28i
         pw+6iiDV1G206y+PvfilAf7iswMI4aeuRGdPEsOF2/nk/bvb9nBqEhIt+c7oygS8ymoP
         CZdnzFwcem1W0cJMOnvZof/fFFSI870PR+X9RHV1yEbCdq8oh35Ue50vEjavibKDNsKj
         UThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=65E9QWlOxnsFpuJu25gLN+MB82p4NIaj7h47IO0OcuA=;
        b=KOm46wXsKIPX0e9L2FVADnmUQCIHJdXxrbVM4rFSH3OZuQ9iTWOV2euvELy3XTrmJC
         qo9ALCS3huWUvXeh0ei1V+TonexDejras4qCAgcdg/AmFlrm3sRAbpdN1grLc13Um+KR
         wzCzZeyxLz6zrQsMds5Z0KhWMW/LBjbvoEA4uqtTb/t4OUy6/OcytDHve//z9JtAJaNj
         QJ9WVrzOZlbewoqs22UeXIX+ls5MluBlk+qilyE7gheIU2z4S4jCDoJu1/eBBK3donOn
         g8zPgpo/5MJ/HlElY0pjkcevgCbgYgC3aPX2Xk8n5LQHy5bT6HD37XcPJqnDBkcEvjvU
         RQXQ==
X-Gm-Message-State: AOAM532JgnhDqQLAa/jRPFZ4Xl4UGpnGK8Kk5+U2VxYCbtVVqVLYsH+t
        4r3ZVMCMwr7sFDmDC0PAQ7o=
X-Google-Smtp-Source: ABdhPJx/3T1DsI71X/qtrivWl59uQY9A9+LpUGx48nM44RusD1M6AZVTYBRsn2exMu/9mHYb/TpdHA==
X-Received: by 2002:a17:902:7c06:b029:e2:cce9:faaf with SMTP id x6-20020a1709027c06b02900e2cce9faafmr14396991pll.83.1612900138870;
        Tue, 09 Feb 2021 11:48:58 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id j22sm139123pff.57.2021.02.09.11.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:48:58 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/8] bpf: Misc improvements
Date:   Tue,  9 Feb 2021 11:48:48 -0800
Message-Id: <20210209194856.24269-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

v3:
- address review comments
- improve recursion selftest

Several bpf improvements:
- optimize prog stats
- compute stats for sleepable progs
- prevent recursion fentry/fexit and sleepable progs
- allow map-in-map and per-cpu maps in sleepable progs

Alexei Starovoitov (8):
  bpf: Optimize program stats
  bpf: Compute program stats for sleepable programs
  bpf: Add per-program recursion prevention mechanism
  selftest/bpf: Add a recursion test
  bpf: Count the number of times recursion was prevented
  selftests/bpf: Improve recursion selftest
  bpf: Allows per-cpu maps and map-in-map in sleepable programs
  selftests/bpf: Add a test for map-in-map and per-cpu maps in sleepable
    progs

 arch/x86/net/bpf_jit_comp.c                   | 46 ++++++-----
 include/linux/bpf.h                           | 16 +---
 include/linux/filter.h                        | 16 +++-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/core.c                             | 16 +++-
 kernel/bpf/hashtab.c                          |  4 +-
 kernel/bpf/syscall.c                          | 16 ++--
 kernel/bpf/trampoline.c                       | 77 +++++++++++++++----
 kernel/bpf/verifier.c                         |  9 ++-
 tools/bpf/bpftool/prog.c                      |  4 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/fexit_stress.c   |  4 +-
 .../selftests/bpf/prog_tests/recursion.c      | 41 ++++++++++
 .../bpf/prog_tests/trampoline_count.c         |  4 +-
 tools/testing/selftests/bpf/progs/lsm.c       | 69 +++++++++++++++++
 tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++
 16 files changed, 303 insertions(+), 67 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/recursion.c

-- 
2.24.1

