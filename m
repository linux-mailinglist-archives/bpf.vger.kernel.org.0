Return-Path: <bpf+bounces-6977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992376FD7D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E032823F2
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F4A954;
	Fri,  4 Aug 2023 09:38:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516B846C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:38:14 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E949D4
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 02:38:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686e29b058cso1410681b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691141892; x=1691746692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9dIV7h+sCekbd6Jiug35Z9Vc/Gl4qYcQsrv76W+vcs=;
        b=X0Kt72ObFXb2AmUvjpljLCJ0/CiK5QQRUOGw5Ygqqx0LHad5xwm7Jo8zkm59JKaXIe
         bl7Py79HnZdLXC4ScPAT2txmPaBBBiTFeLzDnYaZHRmHZumhNNRBYHcv2vosYeDZm/Ot
         kp+AQCVq2QJmxNsDBNMX/iQMj000l05XBv8D32c/j1ftAuMFZUln5xkYzHxXdQAEPXUJ
         DAm3cNsucDXrf1ONWzstwq7va2gdfwlYVFZZGQ/5sDooDwa4M2r7w8fEcZ+n5+gH0dWJ
         LijYxOlIdGXswT3n6+nFjzffC+2cmt9MdTryBYAeUbUsjVq8glbYRs5cB2J4Q3CVgpkN
         J1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141892; x=1691746692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9dIV7h+sCekbd6Jiug35Z9Vc/Gl4qYcQsrv76W+vcs=;
        b=UtOFgAKFKSDfS4pnguMcYaixHzbZ5MdGfNfuBPc19MZH7d8Xjo15lXAABIC7TYWwKy
         zg4P+conBdh0jEYvT0BqFL7DtgfEa3/BgpDoqgG0Or5FXT2EE4VC9VO4ToPyw8lx3R14
         cttZ2sJwRL6yGYBUJ+4wVrQPM1W2ba3zyNLZkAIstCf4ERETcfAKGG+v6Cz7n8LHU7oA
         ZpaT9CurzNqp/DGUJvBKzbiRjy8fLnLveHj0xTYBPyunmxeTw4y83e8JxO0c/cn/oocz
         I7kwrXhm9qw55JK1/bli9OYSNy3POshRaQ3bYQoMG5KUccIHlMXQG+ayCrkIKJLMdsja
         osSg==
X-Gm-Message-State: AOJu0Yx0jLRedLZ4itfa86FPapk2A/iGZGkD+pEeR8Mp6DAHZfMU/Blb
	gcZwh8W5YM2m1ntNTRJ0bdyaWA==
X-Google-Smtp-Source: AGHT+IGpsyV8nAzy3j0aXIanUvxKRza+ZIRtnapG1O2T0h0WF6HVfagRJD4ltE52piSSd9PZUa3plw==
X-Received: by 2002:a05:6a21:8199:b0:134:ad98:fb0c with SMTP id pd25-20020a056a21819900b00134ad98fb0cmr936829pzb.4.1691141892231;
        Fri, 04 Aug 2023 02:38:12 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b00687933946ddsm1214837pfo.23.2023.08.04.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:38:11 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 0/2] mm: Select victim using bpf_select_task
Date: Fri,  4 Aug 2023 17:38:02 +0800
Message-Id: <20230804093804.47039-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset adds a new interface and use it to select victim when OOM
is invoked. The mainly motivation is the need to customizable OOM victim
selection functionality.

The new interface is a bpf hook plugged in oom_evaluate_task. It takes oc
and current task as parameters and return a result indicating which one is
selected by the attached bpf program.

There are several conserns when designing this interface suggested by
Michal:

1. Hooking into oom_evaluate_task can keep the consistency of global and
memcg OOM interface. Besides, it seems the least disruptive to the existing
oom killer implementation.

2. Userspace can handle a lot on its own and provide the input to the BPF
program to make a decision. Since the oom scope iteration will be
implemented already in the kernel so all the BPF program has to do is to
rank processes or memcgs.

Previous discussion link:
[1]https://lore.kernel.org/lkml/20230727073632.44983-1-zhouchuyi@bytedance.com/

Chuyi Zhou (2):
  mm, oom: Introduce bpf_select_task
  bpf: Add OOM policy test

 mm/oom_kill.c                                 |  57 ++++++-
 .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
 .../testing/selftests/bpf/progs/oom_policy.c  |  77 ++++++++++
 3 files changed, 267 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
 create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c

-- 
2.20.1


