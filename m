Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADC5B2A03
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIHXQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHXQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:16:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BF1B9F9F
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:16:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c7-20020a170902d48700b00176be258f23so108924plg.15
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=iHS2kH9GIhQyTrzXAC4JM2mZSat2l8dW4Ph0P8ewe24=;
        b=NWec8YrX1deaWua+9TotWZsoY5U9On+hr9CKq6WdhiyPwiSZt9WJMljWXLaFoGjAcn
         5RxcGYRyWD8Qf3p5I+7tTfudE/KObEKYWRoBXaT7IdYXXFPKu9BLgT2Wp4rIyLyA5wet
         eP1embT41Xi7VLa5hRKprVWc/UoE7jDuAnd4TuppOYJaiBi5PgB0LsIoPLy1ovb4jmyS
         itCdoAnNDFchhgwAABtcrgRwrDWEkKUP0F/5Bc6CrHGJxB+MkkulbkIYmDMC63rDUqIj
         XhIUPxrqQ/lxrjFWB8acJz1jHDkZyMPVhGGcWX4u4q0kBEB1S1Z2AZfaIIK4pLFrlRtX
         gxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=iHS2kH9GIhQyTrzXAC4JM2mZSat2l8dW4Ph0P8ewe24=;
        b=14NAtCrfuzW/kr0lRFSBJlZFzsmfX4mUo11W8HFC9T5X5yKIZprCBhI8GAVCMMAY9b
         +H0jw/zbvNdZRuPYwqU+tAPetkJ7RpfbeMyipcPMaRbU58tAQHN16u45Y7+CpNf4aZlE
         v2Iyy/LyP/Q/7nAZPjkai0IYaSTuDwp/z1HMjc/8zVMaqR5G1RYy6uNCu+WxfThfO9Zc
         CIIXPume2M3HKTTAnSbGwkPbG0AihgmobXdR/lEtMvZ0uCC/UTdA+gHgNY1NsGv4gXLe
         LTdqsvPgGhwnagSJqGeFN/N+xz66hTXBHehzsdCwy31kPLvSh4KMg9RctX/qvKwEYSv9
         0Tdw==
X-Gm-Message-State: ACgBeo3i4SApaLLbmJ9W98H88xb4obMC/LdLEwlf2lXDd65B9voI7+OJ
        5Fvaopl35PiG4tCs4L5AUoXriN/Z8PqzPNaPC70FxUOcIZ/8fB9aS/849eib2uSbwNY4GGPW5JJ
        EoybPVRErU/R82rM3P1ugKXgnsrCCucDozCH5Gg21c1KFEZuWfOWluAzBWGG5uuw=
X-Google-Smtp-Source: AA6agR43ns+TDQgH9hXv6Z5piOKiw7Cq7kfd3C/yP+AnQsEj803mnGL9EUEuA3JCuNpwncMuVrGygXZ5SUNRFQ==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:903:41c3:b0:176:b990:6c28 with SMTP
 id u3-20020a17090341c300b00176b9906c28mr10816405ple.94.1662678978373; Thu, 08
 Sep 2022 16:16:18 -0700 (PDT)
Date:   Thu,  8 Sep 2022 23:16:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <cover.1662678623.git.zhuyifei@google.com>
Subject: [PATCH v3 bpf-next 0/3] cgroup/connect{4,6} programs for unprivileged
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

YiFei Zhu (3):
  bpf: Invoke cgroup/connect{4,6} programs for unprivileged ICMP ping
  selftests/bpf: Deduplicate write_sysctl() to test_progs.c
  selftests/bpf: Ensure cgroup/connect{4,6} programs can bind unpriv
    ICMP ping

 net/ipv4/ping.c                               |  15 ++
 net/ipv6/ping.c                               |  16 ++
 .../bpf/prog_tests/btf_skc_cls_ingress.c      |  20 --
 .../selftests/bpf/prog_tests/connect_ping.c   | 177 ++++++++++++++++++
 .../bpf/prog_tests/tcp_hdr_options.c          |  20 --
 .../selftests/bpf/progs/connect_ping.c        |  53 ++++++
 tools/testing/selftests/bpf/test_progs.c      |  17 ++
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 8 files changed, 279 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/connect_ping.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_ping.c

-- 
2.37.2.789.g6183377224-goog

