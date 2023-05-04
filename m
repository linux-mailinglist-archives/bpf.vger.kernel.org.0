Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46D6F633B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjEDDQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDDP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:15:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87831984
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:15:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaec9ad820so46029225ad.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683170125; x=1685762125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkrmk35Ky/85BXeTs5JHeSBG+pv+CkQQNQ4vZFORK28=;
        b=H0xKmXg00rizh7koD72fKkzR5N23zr1oeXxjphDXAOULpcivedUmDRe4ACkOFDa0RS
         CF57WbP4QUCHkEmu1irEOUxWFWSog21Pn6RzGKK1kcNZeKF5qeQfIO+97BnoME/c8uTR
         4qnqNrc0huw7UYuOFQfwc2AOutSVDR3Gqo3CaRyCciu+jkfRHew9HHmJGd1AqX7N0bhh
         4+l/eRrXr6hTlzgvTp61oM/lnOBV42hSzNkSgTrfPVy/ve+EyOQIwB9GaiEEEcITHti2
         agIvqBHu737c8fOv1J7DGaDMokxDMLk5MPH8KTEhB2NXxfhloZ9GoNKAK3P7MVJ1LakT
         h4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170125; x=1685762125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xkrmk35Ky/85BXeTs5JHeSBG+pv+CkQQNQ4vZFORK28=;
        b=gmfNazXV4bx0aGAQQhLUukjDUxv74EYTP0NGH66OrkDkyWoumZzZcXqCnbni/vVM9K
         yvnmfYZ9vNLrEWf1GBh6eDByl0y05QeiQH2daaU46mFqwgNRfMTkrzCa9RiJx2Hx1Oca
         HnuHBRLZzwZRRyqzJIUoewojkkjkcgYX072YlQqBhnGkGBoL0BNUsBCBt4EKhNPu8jAz
         n9SO6xIIXCxwB4memc3qN9flsXPxwVf+Kfjcr+oLZ6EjDcUnxDbDAkHqaGyE1axsRmEw
         UTzTvsCohXptl8zUVO1H7EU3OWrWLZZdkbCDS6v18rByN1r0VjT0BHT/2PLr78zC3/3V
         Imjg==
X-Gm-Message-State: AC+VfDwdaMFDQfTVNdaVaNlvzEGRYUdeA7Tq4N+Ac/N2ckmFHFDNBGUb
        x3YavRWC+tJ8XZM3Xz8lg9TWDQ==
X-Google-Smtp-Source: ACHHUZ4hu7USx+KN5GnVZpqUhumPBe2XDJMTC8+jNBH1K/EIRNRF1Sn3d1dZRLNXpaqNA/qanVhE5w==
X-Received: by 2002:a17:902:ecc5:b0:1ab:1d81:f8f1 with SMTP id a5-20020a170902ecc500b001ab1d81f8f1mr2724951plh.46.1683170125157;
        Wed, 03 May 2023 20:15:25 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm7146121plb.289.2023.05.03.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:15:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date:   Thu,  4 May 2023 11:15:10 +0800
Message-Id: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
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
v4->v5: Addressed comments from Yonghong Song
- Some code format modifications.
Details in here:
https://lore.kernel.org/all/20230428071737.43849-1-zhoufeng.zf@bytedance.com/

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
 .../bpf/prog_tests/task_under_cgroup.c        | 54 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

