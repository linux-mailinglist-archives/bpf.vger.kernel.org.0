Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9C6F6190
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECWyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECWyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917E49EE
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:53:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a50cb65c92so43622485ad.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154438; x=1685746438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6LHEUi/W2g8HXLFp2cOZyUcjUEkan8mQPr5dBh8dvw=;
        b=KkpAhG3Oz5hRg6HSI9ECQf+RA58HW9Mj/U2seUOwsD80CYYhs3Hv4oxHLtk6ri0/MC
         hNrB1Ybab3sWfoy2UC1qRchtnPCNvHnyaypOs4xZxnBQOiGB9XgEJocjMiKROqW0S/ci
         23+Ic4yTxAwABNUXM4ytY8vRGAZYfx8Gxa2p1GVkl8TUBkfm2vwe+9baV+09tXqJdHDJ
         DI2+tsJ1kfAKrRsm+LKCtkTzP8mSTjBuXkzNpmmKQNkq9yvK6n67SfRkuMRVPTa6C1d/
         TvP8vr7C0CykiqsNdd41XPDQzjoT5L759SdpMPA0Ek3Rzi+1CbUKV4w1nuJ0k+6G0M3x
         l7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154438; x=1685746438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6LHEUi/W2g8HXLFp2cOZyUcjUEkan8mQPr5dBh8dvw=;
        b=aFiyguPj9bi9d0skV5ZxA2xnwlzpLpuIaMZyT+A3KN73NC8AfqFkmAZJbJuvm7t4Rg
         v89L+iasyRUlTHCtLJdK56F2Lzd4bcO0Vl9Fgvg99xdcragAC/Vo4k01hGz7bbfa3SA4
         wXEjxNj4uJJXgEI2DHFtqOymNF8QuaFPevsZtkeLfA3IVbvx8r1dePX3F/rqtaImtBsl
         DWcq7qFgcnXDhUaanL1FFSie7UawDx5RUZ0n3NtMkZ6pFR7jBfA9QO1ApMSl028l5CBC
         ToWqW5gwmD6ifYQ9CGFSnPeRZfjSgJPpbjrrRGZ+Niem7nd9r4oIfAchTnq/ZTJ1Dt3h
         a0Ng==
X-Gm-Message-State: AC+VfDxlqJRHcvzVVckuuMo4mQMr4/9JiV/p1yr9emzhtRqUkZnW+vgw
        YxI/zdw+wMwqjqyUf58M90zxSd+B+UyiVzLtR2A=
X-Google-Smtp-Source: ACHHUZ64grEDSY3LpGWyqL/+ZIz5JQDClDDcPmdqYolyuN5wySk36pq2UgZay4qF91Q3UOmtHuPnug==
X-Received: by 2002:a17:903:48e:b0:1ab:595:2f3c with SMTP id jj14-20020a170903048e00b001ab05952f3cmr1458426plb.57.1683154438028;
        Wed, 03 May 2023 15:53:58 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:53:57 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com
Subject: [PATCH v7 bpf-next 00/10] bpf: Add socket destroy capability
Date:   Wed,  3 May 2023 22:53:41 +0000
Message-Id: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the capability to destroy sockets in BPF. We plan to use
the capability in Cilium to force client sockets to reconnect when their
remote load-balancing backends are deleted. The other use case is
on-the-fly policy enforcement where existing socket connections prevented
by policies need to be terminated.

The use cases, and more details around
the selected approach were presented at LPC 2022 -
https://lpc.events/event/16/contributions/1358/.
RFC discussion -
https://lore.kernel.org/netdev/CABG=zsBEh-P4NXk23eBJw7eajB5YJeRS7oPXnTAzs=yob4EMoQ@mail.gmail.com/T/#u.
v6 patch series -
https://lore.kernel.org/bpf/20230418153148.2231644-1-aditi.ghag@isovalent.com/

v7 highlights:
Address review comments:
Martin:
- Refactored logic to get udp table to a separate commit.
- Addressed nits in the batching and test commits.
- Applied patch to filter and restrict the kfunc, and added a test.
Stan:
- Addressed nits in the network helper commit.
Paolo/Yonghong:
- Extended the first commit that revises locking in BPF TCP iterator
  with more details.
- Fixed comment formatting.

(Below notes are same as v6 patch series that are still relevant. Refer to
earlier patch series for other notes.)
- I hit a snag while writing the kfunc where verifier complained about the
  `sock_common` type passed from TCP iterator. With kfuncs, there don't
  seem to be any options available to pass BTF type hints to the verifier
  (equivalent of `ARG_PTR_TO_BTF_ID_SOCK_COMMON`, as was the case with the
  helper).  As a result, I changed the argument type of the sock_destory
  kfunc to `sock_common`.

Aditi Ghag (10):
  bpf: tcp: Avoid taking fast sock lock in iterator
  udp: seq_file: Helper function to match socket attributes
  bpf: udp: Encapsulate logic to get udp table
  udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
  bpf: udp: Implement batching for sockets iterator
  bpf: Add bpf_sock_destroy kfunc
  selftests/bpf: Add helper to get port using getsockname
  selftests/bpf: Test bpf_sock_destroy
  bpf: Add a kfunc filter function to 'struct btf_kfunc_id_set'
  selftests/bpf: Extend bpf_sock_destroy tests

 include/linux/btf.h                           |  18 +-
 include/net/udp.h                             |   1 -
 kernel/bpf/btf.c                              |  59 +++-
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  66 ++++
 net/ipv4/tcp.c                                |  10 +-
 net/ipv4/tcp_ipv4.c                           |   5 +-
 net/ipv4/udp.c                                | 287 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.c |  23 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sock_destroy.c   | 217 +++++++++++++
 .../selftests/bpf/progs/sock_destroy_prog.c   | 145 +++++++++
 .../bpf/progs/sock_destroy_prog_fail.c        |  22 ++
 13 files changed, 785 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

-- 
2.34.1

