Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E977F3936E2
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhE0UPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhE0UPb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 16:15:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3DC061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:13:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6so1178891pjj.2
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/QHqOBKNtWqdsJtGUNQQUflPC8BPFuArIX8hnoyRUY=;
        b=b+qU/1+VO3MerUI0AOYGpoVSUVCaD57dBLjtV3/IsOnoNPloTsBO9oH33wrMBIisV0
         nuWLBTEfP17gIF9POrLjavF2xttHuYsDc39G9chQWPbTSgBuXRFLrXnsGp2FlxjT1Jk0
         V+YvOFalzMB9yctQVMX0GURmOGrzbQ1Y6NUB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/QHqOBKNtWqdsJtGUNQQUflPC8BPFuArIX8hnoyRUY=;
        b=JeVa9vgGQraDBhaJ5b2gt4Vab1o1jreHf+yHLQA1U+zbF7H+QALmHvBVWsznXKBA6U
         UVZgNMf5BtVMSf/D+I6IapawsN8T0shoAjtIZeomCRGD04wZXkhfAZwPb7I6P+3hMkhr
         zqUwDo4pT3Km7sYZ5yQfGxTcs7DL/UPoJbyAslszjSDDb3jDGTnLJ7Xm6+p85lLDlzca
         KXbxpR2a6Og5coQZaoPqmGrl7K5soQopFFJ1vKjP+k+RFRzr9c1bReQ+NWq1kjMFnDTB
         2wsm7O8MJPBKoixb546TdJF/h5oXWC2p4Anh+5vSD8Byl792fjpI/pCsZf5r/5LG/EsX
         3fwA==
X-Gm-Message-State: AOAM530cKI9fEVKP/7E7Ab7O7wzT95NZdaR1DlJJxEnTTbhgk7yoSKHQ
        D+2ZjSC0sRgS6q1l3+sPV9lbPratXdJVwQ==
X-Google-Smtp-Source: ABdhPJz8CuX9QT7jxMmwhQsMhIrFPevM2Uu5lhiWaIVJA25IjCIdjcFSwacw3p3txAWURBXjvGYkFg==
X-Received: by 2002:a17:90a:f2c8:: with SMTP id gt8mr214201pjb.50.1622146436527;
        Thu, 27 May 2021 13:13:56 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id 4sm2462456pgn.31.2021.05.27.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:13:56 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next v2 0/3]  bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 27 May 2021 20:13:38 +0000
Message-Id: <20210527201341.7128-1-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support for passing an xdp_md via ctx_in/ctx_out in bpf_attr
for BPF_PROG_TEST_RUN of XDP programs.

Patch 1 adds initial support for passing XDP meta data in addition to packet
data.

Patch 2 adds support for also specifying the ingress interface and rx queue.

Patch 3 adds selftests to ensure functionality is correct.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20210524220555.251473-1-zeffron@riotgames.com

 * Fix null pointer dereference with no context
 * Use the BPF skeleton and replace CHECK with ASSERT macros

Zvi Effron (3):
  bpf: support input xdp_md context in BPF_PROG_TEST_RUN
  bpf: support specifying ingress via xdp_md context in
    BPF_PROG_TEST_RUN
  selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN

 include/uapi/linux/bpf.h                      |   3 -
 net/bpf/test_run.c                            |  96 +++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     | 116 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
 4 files changed, 225 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: d6a6a55518c16040a369360255b355b7a2a261de
-- 
2.31.1

