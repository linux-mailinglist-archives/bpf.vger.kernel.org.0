Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCE6F123A
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 09:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjD1HSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1HSQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 03:18:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FC2694
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 00:17:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52867360efcso3599054a12.2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682666270; x=1685258270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukMaBLPXL+Km2GlrH9mAFaejvqqjOkS5iDjlAGQ7GAY=;
        b=MJsEXN/X56AtbGcdtftxmkDoW4CjqAstmIw63sZCSjxnxfcz4HCr5gfJ0ZcNjsp+aU
         VomhmzDYHgHGbiDjetF70zrlY0E9U2eXQl/s7fV1KCBy/rZLoSoFhNlrSXdeQ3epjujI
         33zHwShNStT5XcnHJdLANH2a4UGUlmwFA+bvd35kJmFyZQRDsP+Z/FdPuoLZUUElnmXE
         2uXO4si4jFYWkDADrJKEFG4DsRYs9/93dP+lNRdzDV4zwCRXMWdbJjI4dfH7ZjGpe9lw
         +5kf1kH6a4Sx7rCjOwt115A9TXNRtM7jyYyCz+Se9lSmOfk4L3FjQofipcNvOnspEE2q
         APPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682666270; x=1685258270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukMaBLPXL+Km2GlrH9mAFaejvqqjOkS5iDjlAGQ7GAY=;
        b=G9t/uLsYp4KQgPk1eEaTqCLEdOI9KI1a+62xDXYehgp7FtjrFdVqutP+1JQF+Merfe
         P25GGRnRZG553YD/emeZWjUtcdoZgtfGOtqwktgqfvcakrZ78Q6YsRXWRsIkrWOyg+LY
         e6Rx2gVrqqHgc5pmv2e7aGPY+JW3zS3S6Ll4xbEPir1qIDyvehPTeDkLGZsvdlHGkQZ2
         /hbqqqXJ8FE0+4EA51HWv7aJZ4y97ixSCAQBaNVy0o+xmqW1Wdi/eYAcZWGfTWKGuES2
         tyAor7sPOeVexCMdUjcQonXQEeKxcus0uxv1EQPfD2y44OQAAXuoGsw/WdE6g8t2hdgx
         A8cA==
X-Gm-Message-State: AC+VfDwElJN3E05ksEl7lhOu0CVPuzKVfPp4om5zvoSvRsCNVLjDxLrk
        VE1c7RKLmUGX5e0lTTcgC1zTIw==
X-Google-Smtp-Source: ACHHUZ5YsRCK7s1Ipah26XWJmbC2dPQFPOOLy6IpRQ+5lOSJft2l8ZFBG3iszAMzgA9g3+4R4kA+MQ==
X-Received: by 2002:a17:90b:4a10:b0:237:b5d4:c0cc with SMTP id kk16-20020a17090b4a1000b00237b5d4c0ccmr4730936pjb.39.1682666269807;
        Fri, 28 Apr 2023 00:17:49 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a318200b0024739d29252sm14159939pjb.15.2023.04.28.00.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 00:17:49 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v4 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date:   Fri, 28 Apr 2023 15:17:35 +0800
Message-Id: <20230428071737.43849-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace sched related functions, such as enqueue_task_fair, it is necessary to
specify a task instead of the current task which within a given cgroup.

Feng Zhou (2):
  bpf: Add bpf_task_under_cgroup() kfunc
  selftests/bpf: Add testcase for bpf_task_under_cgroup

Changelog:
v3->v4: Addressed comments from Yonghong Song
- Modify test cases and test other tasks, not the current task.
Details in here:
https://lore.kernel.org/all/20230427023019.73576-1-zhoufeng.zf@bytedance.com/

v2->v3: Addressed comments from Alexei Starovoitov
- Modify the comment information of the function.
- Narrow down the testcase's hook point
Details in here:
https://lore.kernel.org/all/20230421090403.15515-1-zhoufeng.zf@bytedance.com/

v1->v2: Addressed comments from Alexei Starovoitov
- Add kfunc instead.
Details in here:
https://lore.kernel.org/all/20230420072657.80324-1-zhoufeng.zf@bytedance.com/

 kernel/bpf/helpers.c                          | 20 +++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 55 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 +++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

