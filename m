Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139C6F720D
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEDSnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDSnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:43:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9B3C33
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:43:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6437c45318aso492861b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683225831; x=1685817831;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ha9RSXvIpFAnGYm0wSqKWRZJejM9l5JI9qdv5RvMa+g=;
        b=Lz8TOEGqsTTc+2msjN7wgk8T+3A4XFGxtCDpwTR8JIEsgiS0Mz+VxITxHl64+12UsI
         k7bWLs8E+A5+WpFnidFe/jagY9fdqr7r16ztPvcVTNzVKFu+1WXeAnwGMC0ffeL1yzcQ
         0f2jdFNTU8HUldqcb5giNhLGS+RTBOiHFUUAGRZv0Fz+qinJdtlWXCusoc9TljXnYVTG
         ihM5ZuxQ9zgwceYHGkS7ALq/dMbGMSn/7RPuyQe1VU5mlC/KzxL8KTLM35uabHwLBzqe
         OgnwZTFgJMb8GhMPcOAqSZnk7d9ZcWx9reR73i1ro3j69GycSBe+HXpnCwn42ZtXyfda
         Nmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225831; x=1685817831;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ha9RSXvIpFAnGYm0wSqKWRZJejM9l5JI9qdv5RvMa+g=;
        b=g5EXWgKDuhVXcOknO2dwfwWjYwLqyBnBhR+icumzcIzgUvkzcjw/aTR3wv7ysecpTl
         IaDKHLFebUlVbFFbDiPFgD73V1MwOBLqdtQzirZQcjIy20eb6juL8vNn0T+8CnwMYTgH
         jGezvmwaO+mYJBRVzzfX+fS/dED4OtkzPpRB1VkO0G80NWAwztQl+SYzTPvycfJLosir
         1w5OvnCVvc1w51aHwaxsfSRyJLXIeeYcl5pBSyzG9gBHo2peo16MA4WMt1K1JwcxBF4u
         sSWdRJlqrgWJMoEe01i+FVFPY27qJP1D3e2BjhIcxPXdYa4CaaM7nQdP4UJLvsHvW407
         rnhQ==
X-Gm-Message-State: AC+VfDzeD3xxEx5p9YJLOEP6pv/oo9U3VzKNUx0OU2ibFyDEsYlL5hCE
        CYA3DKyXNHFSA++NbVCeZ2TLp0sk76X3OUcT9v1+5DZe1OMMtsFgsCdolPiaDsd9SZqWBsCoL2l
        sfkedlpf30O3cRBKp163nW2MEcQku1D4AxvW93Oq6kEA1zTMh/w==
X-Google-Smtp-Source: ACHHUZ4Dyz0l0i+a58Pf5kLU4Iog38cn+f5O7k+7g09nnXUeD9HrCD2GrZsgUdgRh91yFdn0MVFf4yw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:d72:b0:643:5178:153b with SMTP id
 n50-20020a056a000d7200b006435178153bmr807217pfv.3.1683225831447; Thu, 04 May
 2023 11:43:51 -0700 (PDT)
Date:   Thu,  4 May 2023 11:43:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504184349.3632259-1-sdf@google.com>
Subject: [PATCH bpf-next v4 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

optval larger than PAGE_SIZE leads to EFAULT if the BPF program
isn't careful enough. This is often overlooked and might break
completely unrelated socket options. Instead of EFAULT,
let's ignore BPF program buffer changes. See the first patch for
more info.

In addition, clearly document this corner case and reset optlen
in our selftests (in case somebody copy-pastes from them).

v4:
- ignore retval as well when optlen > PAGE_SIZE (Martin)

v3:
- don't hard-code PAGE_SIZE (Martin)
- reset orig_optlen in getsockopt when kernel part succeeds (Martin)

Stanislav Fomichev (4):
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     |  57 ++++++++-
 kernel/bpf/cgroup.c                           |  15 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../selftests/bpf/prog_tests/sockopt.c        | 103 +++++++++++++++-
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 110 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 13 files changed, 335 insertions(+), 140 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog

