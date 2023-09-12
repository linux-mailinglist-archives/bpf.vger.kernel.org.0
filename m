Return-Path: <bpf+bounces-9721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838FB79C77C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683A81C209D5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ACA171D1;
	Tue, 12 Sep 2023 07:02:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9938F44
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:01:59 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2BF10E9
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:01:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf57366ccdso43900005ad.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502118; x=1695106918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MB3Qkjjlw5hcMhrPR6LeX9MD2h80SkIGJQgP0ux+r7k=;
        b=Y+JY1U7cdDH6+WdhWG+jx92Z1YlgNPiheNE3JQgtfyKVrVkgSnJ511PX5YL5nP8i8o
         nQ3DIlKMMbA2w4TUl2BYnd/eYRH9gdNpW+72v8bxfZzZrO+fbM5lN7AutGEYeAqUN8mL
         vSdHjdPytTw44CodoeZDxcPenvIO94PdLFprc7zNl+q4RYjVF7UCK+FoBPlWQAooj9gu
         TN3jQf/ptIwE220kNWRz4SIolBl65lg8OasEf3ViB9HBbrSeigkBXJSOWzmbBA6qgbKv
         SG9SuS/92OGeJE3WWggBvlizgE9nyM5Oghd9Cw9QvVfZVGoyZ4rAG4rO48PQ0BdVfyFz
         BPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502118; x=1695106918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB3Qkjjlw5hcMhrPR6LeX9MD2h80SkIGJQgP0ux+r7k=;
        b=RxcNi3UirPsKEQXMtBVC2olHXG/3v5IFTV2DzckLPD1+snztbrbj3rwb/BQ3r+Xw11
         QWb8lQBw6H+Ty5wnt8BgLegpdbYYXCkktB/LrZOuSXDBmY2vkgsDaiiCNUMZ4b9n8iaR
         LJn0LUjDkWiE6LSx43AnFEEPhJ+bmfct/H7/pIb+txV4DivP/iWmuVoLAUw95GGd1laj
         YTzOwkjfHtHXAlRL+R3ZgGE24eDtrLbkq8rcomfNbwy9h9XmUogXJm9yUbCNk4gnFuzA
         jUHA8UD3u39JVhPkc/bYYQ0OBp3SYO+pi2OnvUa0FPqfBIfdGhYp99tOSWGOap0T0L86
         HEpg==
X-Gm-Message-State: AOJu0YwD0oXAakuP8kbEmanK+EL/6oX4bW515SGg8RiuOpk9LYVAqD/x
	cAsZnXs0retwdQK9CUMtP5m4WqZqLsKAyCY8JAg=
X-Google-Smtp-Source: AGHT+IGVov7oQgYAM90yOHAtqJMtaQjXDBmGz4tHiQIhTOTnMTO1r7bguhmy5c+NjVQAkP9QeQ7JUA==
X-Received: by 2002:a17:903:22c8:b0:1bb:85cd:9190 with SMTP id y8-20020a17090322c800b001bb85cd9190mr2731636plg.18.1694502118654;
        Tue, 12 Sep 2023 00:01:58 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:01:58 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 0/6] Add Open-coded process and css iters
Date: Tue, 12 Sep 2023 15:01:43 +0800
Message-Id: <20230912070149.969939-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is version 2 of process and css iters support. All the changes were
suggested by Alexei.

Thanks for your review!

--- Changelog ---
Changes from v1:
- Add a pre-patch to make some preparations before supporting css_task
  iters.
- Add an allowlist for css_task iters
- Let bpf progs do explicit bpf_rcu_read_lock() when using process iters
and css_descendant iters.
---------------------

In some BPF usage scenarios, it will be useful to iterate the process and
css directly in the BPF program. One of the expected scenarios is
customizable OOM victim selection via BPF[1].

Inspired by Dave's task_vma iter[2], this patchset adds three types of
open-coded iterator kfuncs:

1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
itearing all tasks in the system.

2. bpf_for_each(css_task, task, css). It works like
css_task_iter_{start, next, end} and would be used to iterating
tasks/threads under a css.

3. bpf_for_each(css_{post, pre}, pos, root_css). It works like
css_next_descendant_{pre, post} to iterating all descendant css.

BPF programs can use these kfuncs directly or through bpf_for_each macro.

link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/

Chuyi Zhou (6):
  cgroup: Prepare for using css_task_iter_*() in BPF
  bpf: Introduce css_task open-coded iterator kfuncs
  bpf: Introduce process open coded iterator kfuncs
  bpf: Introduce css_descendant open-coded iterator kfuncs
  bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
  selftests/bpf: Add tests for open-coded task and css iter

 include/linux/cgroup.h                        |  12 +-
 include/uapi/linux/bpf.h                      |  16 ++
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/task_iter.c                        | 130 +++++++++++++++++
 kernel/bpf/verifier.c                         |  53 ++++++-
 kernel/cgroup/cgroup.c                        |  18 ++-
 tools/include/uapi/linux/bpf.h                |  16 ++
 tools/lib/bpf/bpf_helpers.h                   |  24 +++
 .../testing/selftests/bpf/prog_tests/iters.c  | 138 ++++++++++++++++++
 .../testing/selftests/bpf/progs/iters_task.c  | 104 +++++++++++++
 10 files changed, 508 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c

-- 
2.20.1


