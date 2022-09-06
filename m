Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547835AF881
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIFXtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFXtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:49:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C091D11
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:49:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v18-20020a17090a899200b00200a2c60f3aso1828390pjn.5
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=5bv4tlC5QLxufffMe5LxcecHwglRquewEHZjwnhCi40=;
        b=ARC6kEwmFV+EVmxz/K1QsgDOhfAO56PVuFsLbonq6w7vwzkzXJ6sUMp8U1CULnhUFV
         bFew4idYujAzo6WmtSqvcQkigYQtYl+uzCGGimJvkYzuO22qpwjuSWM9fovtNXUZ/Ji6
         OzGLZ73S532q+txAYDglI53UQ1UuPFSnEHIlwmtjwapPOAwvRu/b1Vq11d0ur7nuJp8/
         nd6UZqiQV00gAPJK6CN+oydqkvrjuSrnSszxTeiJPjwBlbiah79as58ljOnJDd7i69rj
         B2fCB/ydi44gRkmiIbnCOtx1rZhgE7JvrM4vi30vrCMNQFUyiWi4Edu/6g14Z2ieJfpH
         1V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5bv4tlC5QLxufffMe5LxcecHwglRquewEHZjwnhCi40=;
        b=Z3SXl40V+FxMny2aJjf5g7JeaxFhshn4WiwnYUAvmNlAOafqdxgLvTxY1xFQPzD7wL
         aDzoG1EjUQqmfuh64/npDCyydnVnLDd63QkdbZ1N8RlqEVXOYbnkekLxUCclQlEsw9Qb
         N6kjjLUySX0X2znu1PpMgdhTEtTmfVz6BU+AANA42uT+JHNTgchIxYrf1ypBLaiGQ4nY
         kD+LEWgyssG3q9J1MKMxsZeFxS/EuGQsA/D0mcmaB8gHsu16YAefvr/wRQ+1tOzO8BKX
         6nWAu4DhK5KFo6MJGFjCt+Sum8mrqa/AjSwHi183cPuBhpGuiwy+S+LsDgYuk3kQG+cB
         Fakw==
X-Gm-Message-State: ACgBeo0FOIM3r7hRFKRQAkjCedCVEG7z4kYp9zp8T11uZZJ70o7ec5hq
        M54BtJhvnnWHR8jO9fswowUarLlaZ9y0LB2m6PPNS5YVNGa7CVQ99gyqHVTUt33XoDp4U5bv3kS
        b1BULpY9Vc9dw36bhCSCnGLK2A5zrLfKHPJCp+swexziaGKg4YFMs7nRA++KdExo=
X-Google-Smtp-Source: AA6agR61jqjfrHNaym2iVmc07Ds4/liikxtI6c1fAuI3Hn9w2ViV0H4I0NvGk4xmjL58q3yYNwA17bvjfabKig==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr99549pjz.1.1662508143197; Tue, 06 Sep
 2022 16:49:03 -0700 (PDT)
Date:   Tue,  6 Sep 2022 23:48:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <cover.1662507638.git.zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 0/3] cgroup/connect{4,6} programs for unprivileged
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

