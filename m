Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483742DB74
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJNO2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhJNO2K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:28:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23867C061753
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so20128931wrg.6
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/q19B3/R6J7BzRleBPGaijLiNuKPab4A3ikMD+aFpc=;
        b=vkuert2c6NwOmACcKrGEBG/ZVwlGY5+xuph3roHVDxv5uGnVqsdzXobkO+AbFVLy9P
         RT5LJdxIPpjc/91Rw9i7ruyDESi5qlbq4y+ViU3yu+Of/8gY2WLOZsB6GrizPVen7Xqt
         88gtCXWUIFPPmd4Tuy4BXUEcNvhRKEOKBWtf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/q19B3/R6J7BzRleBPGaijLiNuKPab4A3ikMD+aFpc=;
        b=tYUnkZnB9cFcDsuL4E8Pph7T2Y2kVxUEZPh8kJvaa5ZF1rbD2rpXOkU6HUuyPitQqh
         dwahQjl5fRThMFjQd61PN52bP6by2MmQmPOlku/SonBljq8cJuC6F6KzN92kkcwc6or7
         ykGizxqx+QQy248TsWHRn3ZhgsNN9M1+WoS4xCtWXA6wCqMOwwohcV1W0qAxrlBU/Jat
         gvipRusxg4LVstMP8p5PA96W5nywPvPxgx53b1OPTHbZmumNHyw4gdBYR9L9LeOYXlCa
         tLk4r1B49lPIiamJZ6ZkebUZeqCfXzoyPlPOhYFJB+peZ18BLraEvkvEoqE2ucse9BnU
         b5Lg==
X-Gm-Message-State: AOAM532GR5gdm4whPPOZ0CRZJaKbnOAOHqg9bVfF2U0/WYs+M5stErwX
        OcKzc/QwaX1Jg6mHWxxq7RCNLeD+zTnf6g==
X-Google-Smtp-Source: ABdhPJzB2mQjtO1jbM2E5FRM6Hgfz82vytUWdiGWhil+caGVdjTD7sQWZqzw2X7wsf9dE8yHVxv6Tw==
X-Received: by 2002:a05:600c:358b:: with SMTP id p11mr19459456wmq.156.1634221563632;
        Thu, 14 Oct 2021 07:26:03 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id e8sm3731111wrg.48.2021.10.14.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:26:03 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     nicolas.dichtel@6wind.com, luke.r.nels@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v3 0/3] Fix up bpf_jit_limit some more
Date:   Thu, 14 Oct 2021 15:25:50 +0100
Message-Id: <20211014142554.53120-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix some inconsistencies of bpf_jit_limit on non-x86 platforms.
I've dropped exposing bpf_jit_current since we couldn't agree on
file modes, correct names, etc.

Lorenz Bauer (3):
  bpf: define bpf_jit_alloc_exec_limit for riscv JIT
  bpf: define bpf_jit_alloc_exec_limit for arm64 JIT
  bpf: prevent increasing bpf_jit_limit above max

 arch/arm64/net/bpf_jit_comp.c | 5 +++++
 arch/riscv/net/bpf_jit_core.c | 5 +++++
 include/linux/filter.h        | 1 +
 kernel/bpf/core.c             | 4 +++-
 net/core/sysctl_net_core.c    | 2 +-
 5 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.30.2

