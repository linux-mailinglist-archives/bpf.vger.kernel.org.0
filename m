Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1EE6F3874
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEATs3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEATs2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:48:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242B2129
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:48:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso28818228276.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682970507; x=1685562507;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6r+KaXFehpogpE5aa81mU+Qaa00RpnDSdQ3h+kE88w=;
        b=JfWHByK5XHBahSCN84lE5QZWzdsq3qLEAnui36zUs/AmaC/bDCGYRSxOEZQXSE4c2j
         wskR+qfgyzpN3EpyPN9Qd3rM5axM3NY4dphNXWd2NaJ6Tf7D0RCnJPx2XRDU78ejLHqJ
         MeE+7twkF5PLLaXJ8OmXqG7N9KjzVzHCEquG9l2qNU8lw+QVkQ5sxkvI4givPYW+fYUM
         W33YhRdiOAB6+wIiaUBBLcbcGCtgH/UOVZRHDqtBjAS+Is7q8SgzAYecE8FCcEKoddfh
         Qb24Kw6mDJniAgUAz58Y7+XOw5AmcCk8WpA1k3GXoIbjK6LEzkN3k6mcKgWcjfBgJyQw
         c+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970507; x=1685562507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6r+KaXFehpogpE5aa81mU+Qaa00RpnDSdQ3h+kE88w=;
        b=hR1WMni7AKBiAr10H1igc2MVqvD9Tu8KCir1gxEfyzJD1gjvXO99vgwhOtIeIZHQKb
         J+EmXeypx8gOl8YpOqrf2SY8DE2cugv1GTnaXYoFQmcCUDBr70n7tZ5iod9Kh3OGyAse
         yK9VvIA+7+B4DNs7KVs6HI61j6oj+rNigfaZMs/UsGOdS1XZ1oGeXd6Y2mnd6E20eybY
         1kT4eRYZwsmsLilm2tii0YY6dzxqHj64Gjf+Bju+9cTZ5ISQ8+40AUAK4q8fRDB6t31k
         NaeEf/w8yJdWs+ScUaJkYUttxJMDkW4FrJyPd5yyKdOf0O9cPcAWr/uk7EZBpTxXKgEP
         ogWA==
X-Gm-Message-State: AC+VfDxBNAtmq822vMDJ6kvIwhVNKKprSFw05TwroqVCH5ML15jO7Ock
        s+txwPUGxU9uZtr+a/1qcySziEH8A5M/hqG6j2Rv4YdzNYEpFZodJk6hyc5DPbfqWtG0+UzkT4C
        r078kQI5C92E31GXJznfDvjj+xLl2UnbFeqr1OZmXs/6lOV2wkw==
X-Google-Smtp-Source: ACHHUZ7iAx6CJb42oKpVVMqVGEr5n2gUYOwB+gMDa4/e1KiJqOcHDdci5bN9/OphoPY3LhdV1C9owLo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ca08:0:b0:557:616:7d63 with SMTP id
 p8-20020a81ca08000000b0055706167d63mr9120359ywi.1.1682970507140; Mon, 01 May
 2023 12:48:27 -0700 (PDT)
Date:   Mon,  1 May 2023 12:48:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501194825.2864150-1-sdf@google.com>
Subject: [PATCH bpf-next v3 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
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

Stanislav Fomichev (4):
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     |  57 ++++++++-
 kernel/bpf/cgroup.c                           |  13 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../selftests/bpf/prog_tests/sockopt.c        |  98 +++++++++++++++-
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 110 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 13 files changed, 328 insertions(+), 140 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

