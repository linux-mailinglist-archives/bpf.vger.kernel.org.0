Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226706EA684
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDUJF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDUJF4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 05:05:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE79016
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 02:05:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1687247b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682067931; x=1684659931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akWWD6Hh6r+OYGyfrxLzmZDpacDQxQ27SVpN4XMCC9Q=;
        b=hn6iQuC0rkz7WgMmaMAcsLAAvZra6ZxsIgMlDFed2YP1xoOH+yjOoPqvctYof5NHaJ
         XoIqnD43aHZQY4jh2CXmBrxnN11oGVwBsmXcZ3cFjr7TS2sbhS9LLnLPM/JQNwGhMRLW
         3TjdAUPNHlbDqbaVWRHTJOqCAHK5avxkQwCq84VKMAImyj6vDC3z2qh0cFHBnCIKsZoM
         A1waAFM5XeQRZE8ZjQc6pYn5H+wGEwkIj+s9WK028cf7sIAxCPXjUShJcOHf40+SXEaw
         e3KTrDQt7FFfLtBBLBUBEpHItHSHqM1p+8O6VfuWGwnMv35la7XtObm5aU4eLvZ1nv5Y
         VrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067931; x=1684659931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akWWD6Hh6r+OYGyfrxLzmZDpacDQxQ27SVpN4XMCC9Q=;
        b=iQhaYSfz1+fobsf7l1eSq4Y91h5Z5CDfMEAnUd41F1ZbQQw/I4bkLz3fWYJ/raOUfW
         PPwwFR3tBB6HP1cOAoYLitUIeUxFnacA70qaVMvMZRBc0ropF6eALQGWOEQHuopHcxxC
         t35xhVU+mtKI5YqhQJhZ/BgNWEt/TA5eKLr+ZgJuuLKLmlFxXrxKbdf+7D6lKKY7JJFJ
         zDcSe71z2EciEgriX7UAoLXI2HVKlORGUxk4vvTlEkcrJpvsZkbBTPVwKm31LQbd2ahF
         /ZI/kKrokmzzxcXuuaI8q2Ug/IyEq6EPf8bihrfRLDFdLU46+0sXqNtVuZIam/+WdkO6
         UOQQ==
X-Gm-Message-State: AAQBX9ezlhOi1EZ0drPHR8ls27ytXso6xgyfgnBPkZfaDeTvGMOfTuED
        I/DOSbNcR3mK+cKHRYwLqgNKsw==
X-Google-Smtp-Source: AKy350ZMWKiIS/nyv1lpgmbo/fHUe68CiVCgs7QJ0XPwJHYTMJ8tqy3mCU2aNI65do0p5WFlUbaZPg==
X-Received: by 2002:a05:6a20:12ca:b0:f0:4dbf:5f9f with SMTP id v10-20020a056a2012ca00b000f04dbf5f9fmr6785242pzg.29.1682067931044;
        Fri, 21 Apr 2023 02:05:31 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b0024796ddd19bsm4192309pjo.7.2023.04.21.02.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:05:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date:   Fri, 21 Apr 2023 17:04:01 +0800
Message-Id: <20230421090403.15515-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
v1->v2: Addressed comments from Alexei Starovoitov
- Add kfunc instead.
Details in here:
https://lore.kernel.org/all/20230420072657.80324-1-zhoufeng.zf@bytedance.com/

 kernel/bpf/helpers.c                          | 19 ++++++++
 .../bpf/prog_tests/task_under_cgroup.c        | 46 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../bpf/progs/test_task_under_cgroup.c        | 40 ++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

