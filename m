Return-Path: <bpf+bounces-6043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947D7648CF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867821C214E0
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73AC2EB;
	Thu, 27 Jul 2023 07:37:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041CBE72
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:37:34 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C683ED
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so383531b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443423; x=1691048223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdW9TKjaVoY8TAoiZ9/Vr1Qx2UudtUG/Q1a9kCBPzGw=;
        b=WJUfha13VzDGQgQyWyKoLGRPd9B2AkAKQKlD7TIy163bJUtKECJHVmywN3s0unJxcA
         AFA1yR4NNxwgvdmCB9kcHHQPMLl9LlV8pAcIGWlF0HUvZLVIlQEbvML2tpREm3u8AD4k
         ZViVO1tm0udVd0TVKE7yJTePILn0TB+bdWzMf3niDZWAHwzWJFTwp+C84Q2j6ViYWC5t
         4N5Am2+2fKfp6XRRZQnrrgjY5wF7mYeeJH4JoDqHPFPB6qrHo39bwgcnuGX6byF15qjx
         ceejVzI8aCT+WIluxObIBO5wrLPWkAdawMcVjKG/3zRwdXvZXxv1sPDUtb817SM3m6vs
         XPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443423; x=1691048223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdW9TKjaVoY8TAoiZ9/Vr1Qx2UudtUG/Q1a9kCBPzGw=;
        b=h+RTi8/jbksw92G37CwK9MTiVf40skEiq5eVFZWf+aWfWFl1Mf4xEUi0MSMAWqgP1T
         6BwcqdLLKcvNsCKpdCpaqvayZg2t6sToCPQJsJrCDlUAvkL0hUwdrbIqwFA+1zsa2ejt
         u2ss4zz0xNsEsTjD4zHnC3Oujhuf1z40Tf0pVfSugZiPICJ9eCzuUfKsOJK99mcV3ocL
         9iZVYyPaFE3C3ANbsXlrJWoASWmCFib7jLuragc6Vc8HAZtJn2CG4bAN5EX7GkD0iSkt
         xQVGMXBX5jfotRLFkB6oHYUCAg+t9TymymGflQMhICWRpo7hNQxQ0+NPRjowGVYcA2u2
         W9Bw==
X-Gm-Message-State: ABy/qLbdUw63aw+teogm71RdZqwf9sDXQWLcle4WKOA3Mrr7tDvmEs3H
	URcOtVJXedaKnUEOhjZMZH81IQ==
X-Google-Smtp-Source: APBJJlGxrFogQX0h6qLoImls0/eZEcESwzsR7mUASJnTL6C0r6eTOSp0Rv2425LMPb9lvt4ZknyY3Q==
X-Received: by 2002:a05:6a20:3c8f:b0:123:152d:d46b with SMTP id b15-20020a056a203c8f00b00123152dd46bmr2384597pzj.26.1690443423642;
        Thu, 27 Jul 2023 00:37:03 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:03 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Date: Thu, 27 Jul 2023 15:36:27 +0800
Message-Id: <20230727073632.44983-1-zhouchuyi@bytedance.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset tries to add a new bpf prog type and use it to select
a victim memcg when global OOM is invoked. The mainly motivation is
the need to customizable OOM victim selection functionality so that
we can protect more important app from OOM killer.

Chuyi Zhou (5):
  bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
  mm: Select victim memcg using bpf prog
  libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
  bpf: Add a new bpf helper to get cgroup ino
  bpf: Sample BPF program to set oom policy

 include/linux/bpf_oom.h        |  22 ++++
 include/linux/bpf_types.h      |   2 +
 include/linux/memcontrol.h     |   6 ++
 include/uapi/linux/bpf.h       |  21 ++++
 kernel/bpf/core.c              |   1 +
 kernel/bpf/helpers.c           |  17 +++
 kernel/bpf/syscall.c           |  10 ++
 mm/memcontrol.c                |  50 +++++++++
 mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
 samples/bpf/Makefile           |   3 +
 samples/bpf/oom_kern.c         |  42 ++++++++
 samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
 tools/bpf/bpftool/common.c     |   1 +
 tools/include/uapi/linux/bpf.h |  21 ++++
 tools/lib/bpf/libbpf.c         |   3 +
 tools/lib/bpf/libbpf_probes.c  |   2 +
 16 files changed, 514 insertions(+)
 create mode 100644 include/linux/bpf_oom.h
 create mode 100644 samples/bpf/oom_kern.c
 create mode 100644 samples/bpf/oom_user.c

-- 
2.20.1


