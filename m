Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6A39C32A
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDWFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 18:05:44 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:33733 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDWFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 18:05:44 -0400
Received: by mail-pl1-f170.google.com with SMTP id c13so5384035plz.0
        for <bpf@vger.kernel.org>; Fri, 04 Jun 2021 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WE/dXQ8qz1n8y3p7Yvx8qqvZsp6ICOeMglX4ACVj3Dc=;
        b=ZApXt3MsEl8q4NILYq3T6tHs+G9k5O7/0vN2JHSpWKdohtGPNESpRlJR/KSSpxbtxb
         VdB6iGlzMXkGZvxs4DDrmhsDbXwBBuq3jRwCW2KxP7t6kb6a5yb0WmLewFl6WiQjI2AN
         551BDes/hAVDmPANAXLOTe6jPCOWSighy6c6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WE/dXQ8qz1n8y3p7Yvx8qqvZsp6ICOeMglX4ACVj3Dc=;
        b=p5CVUsrrL/xZnu7uGe65uo8PoY9arv3ATuWVr5qyeqv/b7t2KM2LpPw+80cxi9FOGz
         L1/QdqpBpTHe9AzYozJKk5F+ogkbcscHpUBJ8GiUpys/VCZJayFT+yGxNbhl9VOa7pKo
         V4OF9kkC0JkFLF1KavQI16igH52D8wnB6ofbIx/VKhaTUk6x2awSNXN+zLzcxVgERBxC
         dvhFDEl7hXa7Y+NLj0VlYS4IANP8w+KgRHD7ZZszKVn4Ot/0aNmPfCoNrbggEsrKFd4D
         Md0710obihHq2SGdpomkGnpLpkzRlGGy2MgvcaN3vE0Y4sp+HOJYH+yhcJh3jLAIulFo
         h45w==
X-Gm-Message-State: AOAM531de/gYgrhZkWwnpsbfftK0DaCDOqVwX39xxFZ1mKw17hwOonGx
        9V2iJaTUVB130L7uOxjflpkiAhWIqv/8Cg==
X-Google-Smtp-Source: ABdhPJyj0ltAuvUpYz+B/WMrmznXR8wtxZe6HTjpEh5cOmi1WZjmVYDStjkoGU9zpUl6XQ/UR5zUzg==
X-Received: by 2002:a17:903:152:b029:10f:f6f7:ede5 with SMTP id r18-20020a1709030152b029010ff6f7ede5mr2692711plc.20.1622844177025;
        Fri, 04 Jun 2021 15:02:57 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id bo14sm5435374pjb.40.2021.06.04.15.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 15:02:56 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next v4 0/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Fri,  4 Jun 2021 22:02:32 +0000
Message-Id: <20210604220235.6758-1-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support for passing an xdp_md via ctx_in/ctx_out in
bpf_attr for BPF_PROG_TEST_RUN of XDP programs.

Patch 1 adds initial support for passing XDP meta data in addition to
packet data.

Patch 2 adds support for also specifying the ingress interface and
rx queue.

Patch 3 adds selftests to ensure functionality is correct.

Changelog:
----------
v3->v4
v3: https://lore.kernel.org/bpf/20210602190815.8096-1-zeffron@riotgames.com/

 * Clean up nits
 * Validate xdp_md->data_end in bpf_prog_test_run_xdp
 * Remove intermediate metalen variables

v2 -> v3
v2: https://lore.kernel.org/bpf/20210527201341.7128-1-zeffron@riotgames.com/

 * Check errno first in selftests
 * Use DECLARE_LIBBPF_OPTS
 * Rename tattr to opts in selftests
 * Remove extra new line
 * Rename convert_xdpmd_to_xdpb to xdp_convert_md_to_buff
 * Rename convert_xdpb_to_xdpmd to xdp_convert_buff_to_md
 * Move declaration of device and rxqueue in xdp_convert_md_to_buff to
  patch 2
 * Reorder the kfree calls in bpf_prog_test_run_xdp

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
 net/bpf/test_run.c                            |  91 ++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     | 114 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
 4 files changed, 218 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: 56b8b7f9533b5c40cbc1266b5cc6a3b19dfd2aad
-- 
2.31.1

