Return-Path: <bpf+bounces-176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645946F8E41
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985B71C21B08
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670515C8;
	Sat,  6 May 2023 03:16:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E6715B1
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 03:16:04 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A974F72BC
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:15:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso23753869b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683342958; x=1685934958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0458uXF9RUz5p6djNQUrV1kPPJP26SNua7MTT7E+jsc=;
        b=ah4y2BIozBAxspMXaFJpgiDEb9vP5JX7cXug6SoTtI1q35VtGELqCkcK22wupB2LTn
         rFlXA5OtysZmdrni+jZjZJbkegVrSvCMi3Pzd4ilCJ94XUVOmQjsktn4aJ7FmbfKvQju
         1KetyAbtvoy2iBX0pgCFL07tWfLyatxkynYL8ldrjnLJCVQwb7Q9feYEvRPHWMZu/2yd
         dilSkSgXPiFYoKbGmzaGXEuhoY3dEM/eRaxJGdcWCwmbQTwlHVSmJnfLZUXDGVfGMD6O
         ER1DK0eHWCfT2iqc/C7gNkAlYzhsEZAJVT9OQ2jPrvvHFRdfsdmQXSkRbzovbEMV9HJp
         LGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342958; x=1685934958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0458uXF9RUz5p6djNQUrV1kPPJP26SNua7MTT7E+jsc=;
        b=NuOsyEo7MS4uRzT3T792jAkiGvOF6nLBAz1F+P5b/34gFA/aLSvZbrBL+riN+nes94
         5L3eaguZhISSSWcxoffsreDlAIq8sboOMBLPoVcZmbmRSBBeMKml/hAYpJDkVbenO+yg
         d58OUXposzmg3EZVcEV+/Orsm5KzGInSh9Yo2M/NRXdCr44X3sWwfIGnXyNyNOKzH02P
         6rdH2K5QEoqcFwgCpoCDyIxseHmCw+1DVwR5NX6BnF0IonwsKQVtQoOKdtavqunjNTQ3
         b7U0nZ0WBHo+uwjzzMn4d+k3SgQl3N9LXDaG//zrEe2LUcseFCzoHooTtAtyP94ON+so
         tzXw==
X-Gm-Message-State: AC+VfDyFnHv0X+rSHzDHu+/A9ohSxkbVc8WKPuYAD83ZK7B9x1FvxgJY
	2uO6YzcovgZVSNaR1xx1/X2XMA==
X-Google-Smtp-Source: ACHHUZ6x3RXr+FRSOEa6ajuOd5q+SCqgNp5dyJfTZ6LVau6mi9v4AwFmvAli3FqgzM3yIg8OKhHanQ==
X-Received: by 2002:a05:6a00:1f10:b0:63f:32ed:92b1 with SMTP id be16-20020a056a001f1000b0063f32ed92b1mr8660432pfb.7.1683342958117;
        Fri, 05 May 2023 20:15:58 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0063a1e7d7439sm2256663pfn.69.2023.05.05.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 20:15:57 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v7 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date: Sat,  6 May 2023 11:15:43 +0800
Message-Id: <20230506031545.35991-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace sched related functions, such as enqueue_task_fair, it is necessary to
specify a task instead of the current task which within a given cgroup.

Feng Zhou (2):
  bpf: Add bpf_task_under_cgroup() kfunc
  selftests/bpf: Add testcase for bpf_task_under_cgroup

Changelog:
v6->v7: Addressed comments from Hao Luo
- Get rid of unnecessary check
Details in here:
https://lore.kernel.org/all/20230505060818.60037-1-zhoufeng.zf@bytedance.com/

v5->v6: Addressed comments from Yonghong Song
- Some code format modifications.
- Add ack-by
Details in here:
https://lore.kernel.org/all/20230504031513.13749-1-zhoufeng.zf@bytedance.com/

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

 kernel/bpf/helpers.c                          | 17 ++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 53 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1


