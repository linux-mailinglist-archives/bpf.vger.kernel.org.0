Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD239933A
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 21:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBTL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 15:11:28 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42828 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhFBTL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 15:11:28 -0400
Received: by mail-pl1-f182.google.com with SMTP id v13so1591191ple.9
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khcie9VmodEJlBMmMDo7nQANyQubjNhKWUujgr7nwCU=;
        b=cWa3aYYVvf/GTAGg4GUy3tHrjiiDQjidPEiqUxVKW5yjuU8/oeNiiEkroDMJ3MT6Ip
         tF51K2xkGCFFqYnov6tix/lssgQhst1HXpDWF7XFGgZZdePQOhYSiL46bT+90p8hQTwS
         I2e9aN+ws44I7RBHtQk4G6l13/bVNugumdA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khcie9VmodEJlBMmMDo7nQANyQubjNhKWUujgr7nwCU=;
        b=fa3RKURYHoPGCD6M5+ImMn6lSMDuMH7PFLWypvQLOwiHbuUjiZPdry7f1YyaaIaeWH
         W/3wIaQuoYMwoQ/J5iAdsk8cP9dv1tRKuBl/L0R5cT0MMvRo8ZEK+ZFMqxg9n5V6aMij
         nJ2Vp2bYRzdkwZOb/U0kyveH2ft8CE8wX6r9YZjW7fPuVIU0jYzb3IgSMzcAu06EhDEm
         D1RJZOsPvoiypHAwUeKdkhEbAFP1/KVXawOfe9iElXM4bR/bTUR7ccKyhET79Hoz+Tpz
         NRhmrOFqnwz0JHigdJ9dOdkf+It68r5MUZ7EV5/DTrbFiY8TnvDybGhaazsFZXK6hCsb
         lLjw==
X-Gm-Message-State: AOAM5316modf6lgVmX3W7+1TARZJd8HlfWtKfm1Y+R3F6EETmAwkPqUc
        wtrfsELIa+F4gEdmgTS7pwhRZsjwO0PmRQ==
X-Google-Smtp-Source: ABdhPJw560lINH+YurW/po1HVbXIiAPY7WcfI44pLy6boUwsVScLjKQxmxMwm5h9EmVblzc1jeXIkA==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id a4-20020a1709029004b02900f0b40d038dmr32386738plp.85.1622660924345;
        Wed, 02 Jun 2021 12:08:44 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id j12sm458036pgs.83.2021.06.02.12.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:08:43 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next v3 0/3] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed,  2 Jun 2021 19:08:12 +0000
Message-Id: <20210602190815.8096-1-zeffron@riotgames.com>
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
 net/bpf/test_run.c                            |  96 +++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     | 114 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
 4 files changed, 223 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: 05924717ac704a868053652b20036aa3a2273e26
-- 
2.31.1

