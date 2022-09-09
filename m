Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72E35B2B2D
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 02:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIIAuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIIAuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 20:50:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4286565834
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 17:50:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b25-20020aa78119000000b00536a929d8e4so117730pfi.1
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=UzC//+Yk70hj2hJqUtleEEzIXj0/R3c00YBdzJHLjn8=;
        b=oLKZibQ7Xpojcs/uncAmpTMBxDPKAqywkflZvuGSE3Qz4DrVMgJJnwybZ7wbTny1HE
         3rVRxOSXgHGMXdTjwFBSS2sueK7XeAQYphFQxr53Sxx0ZnOybWQvESCxY8QGHsSaB9xr
         HUmvWw7xS/+vSgXdqXazIQ5Xa4GhLm6r88m4qyUfBI9cXULvULoqenuoF/lo5Xenk1x9
         A/+3lxIrDyInfFHzWzi5B0rCULUcAHIVIQWKTyTx7PkZTGsaRFQrYzB1mHPjVHNzF+b/
         zCk87rfwOY6E/xwj92CfBqmDE/wvmizDPXT2kpy02T/yKzui7wNKKIon2KILEQFT9pME
         sG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UzC//+Yk70hj2hJqUtleEEzIXj0/R3c00YBdzJHLjn8=;
        b=cHIJF5FdyRMqaMe0QAAL0GcoV03guVvQz8kaFjYH+bBr2fp4B3ltfSC8hpvOPG7eFB
         f+IE2VUO4V2KG9SfWMRw3RcOtnq/P0FQPVh6ix5RoRILcZWDgeUM7cG66qH1Gn2aLW3M
         quYTlWwVwG7B066/DR3/rImLshL+hjbfmqhovwYU/oeeFTdxpcTif6sB5dLwTpF+nyFM
         ejVIrTwncK6nj50DMTBImE0LI6pTYQbLPSDfdIROCXKs5NI0ne0I3zXU91z9HHiZZJ44
         8dMl98gp6T3nukw35UHsDLlJMWHJUAG39OoKIIC3P8jCcTBpbnR1/Cdf8n5ISE5vlCYb
         GapQ==
X-Gm-Message-State: ACgBeo2u1YFfm/u91RmTBlk1sMVjTR4EBHVdG+DLozXZZcB2/mUIMdU/
        EHBr7x2EDc9WyMscRcpRfFwumTyBLab0gViH4c3J/SQzjTZtml5adLXhEJP+C8XAx+4tmf5x6F9
        htnjgAAR/VO5LURcz2bIXUVnhFdBW8OExX6RBiWNjeGu0teqGoBcR7HEbo+MWNsc=
X-Google-Smtp-Source: AA6agR59tJ1faHQghtsH7mhwtNJ+H7GjQXWBqcckySx7FEgQSBctBT2bgOBT1E6hEj1eT/zPqFPOmVOEWbxkxA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a05:6a00:a90:b0:530:2f3c:da43 with SMTP
 id b16-20020a056a000a9000b005302f3cda43mr11595911pfl.50.1662684604707; Thu,
 08 Sep 2022 17:50:04 -0700 (PDT)
Date:   Fri,  9 Sep 2022 00:49:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <cover.1662682323.git.zhuyifei@google.com>
Subject: [PATCH v4 bpf-next 0/3] cgroup/connect{4,6} programs for unprivileged
 ICMP ping
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Usually when a TCP/UDP connection is initiated, we can bind the socket
to a specific IP attached to an interface in a cgroup/connect hook.
But for pings, this is impossible, as the hook is not being called.

This series adds the invocation for cgroup/connect{4,6} programs to
unprivileged ICMP ping (i.e. ping sockets created with SOCK_DGRAM
IPPROTO_ICMP(V6) as opposed to SOCK_RAW). This also adds a test to
verify that the hooks are being called and invoking bpf_bind() from
within the hook actually binds the socket.

Patch 1 adds the invocation of the hook.
Patch 2 deduplicates write_sysctl in BPF test_progs.
Patch 3 adds the tests for this hook.

v1 -> v2:
* Added static to bindaddr_v6 in prog_tests/connect_ping.c
* Deduplicated much of the test logic in prog_tests/connect_ping.c
* Deduplicated write_sysctl() to test_progs.c

v2 -> v3:
* Renamed variable "obj" to "skel" for the BPF skeleton object in
  prog_tests/connect_ping.c

v3 -> v4:
* Fixed error path to destroy skel in prog_tests/connect_ping.c

YiFei Zhu (3):
  bpf: Invoke cgroup/connect{4,6} programs for unprivileged ICMP ping
  selftests/bpf: Deduplicate write_sysctl() to test_progs.c
  selftests/bpf: Ensure cgroup/connect{4,6} programs can bind unpriv
    ICMP ping

 net/ipv4/ping.c                               |  15 ++
 net/ipv6/ping.c                               |  16 ++
 .../bpf/prog_tests/btf_skc_cls_ingress.c      |  20 --
 .../selftests/bpf/prog_tests/connect_ping.c   | 178 ++++++++++++++++++
 .../bpf/prog_tests/tcp_hdr_options.c          |  20 --
 .../selftests/bpf/progs/connect_ping.c        |  53 ++++++
 tools/testing/selftests/bpf/test_progs.c      |  17 ++
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 8 files changed, 280 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/connect_ping.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_ping.c

-- 
2.37.2.789.g6183377224-goog

