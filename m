Return-Path: <bpf+bounces-9011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924E78E2F8
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DE1280D79
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6188C0C;
	Wed, 30 Aug 2023 23:01:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC838C02
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:01:52 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7410C0;
	Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565403bda57so219690a12.3;
        Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693436490; x=1694041290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=om0kQ9df7Z1G+GaiHkAQxZdKchIgLbQj4RWgw9XOLsg=;
        b=pQw6Eok5nF1gyTFLKAwTH20ujyhsztRj7+4OpguqqIn7GkMy0wJwRJ02RezonYTzui
         b8je8NtiIAEeh6Blnx7g5/Yvb6xLXB6mfUYI008pZDDM6j/oS7IW9jvcLuJsUfl3T0QD
         OuYNO4y9znIoAjHbPfzOutorcw9VoXac+8pFOiAkHdiq0TqlpGC9oY0Phs6uciq4DNwd
         VaiDwtU6bUxs9ATZLJU8xgGSePbBKcEb9IhuK16z82xyPb7mlGa4PwFkBsf+5nenRQCe
         K49Yw4fvB72oZtZ3kDPF4L5B/3Q2BgmgfMUkMtq4LCztTb1728ax7M+/atK6hzXnaVht
         vzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436490; x=1694041290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om0kQ9df7Z1G+GaiHkAQxZdKchIgLbQj4RWgw9XOLsg=;
        b=i5JlYXf4kar3YTfFJIleftif9IEGB4weQ7sDOXib3EFO0XhISDI69YVaxD/2u8nn+S
         Hujgb2uYGsAnbJrwLVe+mNt2WcoUEqgRKgIqSj5/1Pa8udnI3nHKM2ZZlrRIb6zkG8iy
         t4a/def8ZVyM82wpv+ZPY60c0Zisia7mGtNfBDuNym1m4y90DiXB518U43CsABM3r4O2
         wYe+F/b07rOnN4iRlCAUslYYWjAIJw9U10DfvFkK9ixh+olkNURfjlmUTbC+b+wSyNJR
         /wp89yoxBzWKoH3D5o7HE4JfHYVYETJ85ffjJvZAw9ikMHpR9HrrYU4FbW5scg1fQKC1
         qvMQ==
X-Gm-Message-State: AOJu0Yz6rQIaqLlkMBMwzEKosMadYQW1V6H9JoDvNTbQHVjnlunDLeri
	eo5woOwbIvkdO7vk+VPLVKA=
X-Google-Smtp-Source: AGHT+IEij1xA8Kx+HiU6qOh2MeTo2Ljzg881ipS6Ie7v5S0H/mvhEVFWBFmZtrrME7QCCgx9ox6gVA==
X-Received: by 2002:a05:6a20:7da9:b0:129:3bb4:77f1 with SMTP id v41-20020a056a207da900b001293bb477f1mr4336971pzj.0.1693436489492;
        Wed, 30 Aug 2023 16:01:29 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:4366:cd91:1c34:2aa7])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm92531pfa.133.2023.08.30.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:01:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCHSET 0/5] perf lock contention: Add cgroup support (v1)
Date: Wed, 30 Aug 2023 16:01:21 -0700
Message-ID: <20230830230126.260508-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

The cgroup support comes with two flavors.  One is to aggregate the
result by cgroups and the other is to filter result for the given
cgroups.  For now, it only works in BPF mode.

The first one is -g/--lock-cgroup option to show lock stats by cgroups
like below.  The cgroup names were shortened for brevity:

  $ sudo perf lock con -abg perf bench sched messaging
   contended   total wait     max wait     avg wait   cgroup
  
        1052      3.34 ms     84.71 us      3.17 us   /app-org.gnome.Terminal.slice/vte-spawn-52221fb8-b33f-4a52-b5c3-e35d1e6fc0e0.scope
          13    106.60 us     11.48 us      8.20 us   /session.slice/org.gnome.Shell@x11.service
          12     21.20 us      4.93 us      1.77 us   /
           3     12.10 us      8.80 us      4.03 us   /session-4.scope
           2     10.98 us      7.50 us      5.49 us   /app-gnome-firefox\x2desr-34054.scope
           2      6.04 us      4.88 us      3.02 us   /app-gnome-google\x2dchrome-6442.scope
           1      5.63 us      5.63 us      5.63 us   /app-org.gnome.Terminal.slice/gnome-terminal-server.service
           1      3.51 us      3.51 us      3.51 us   /pipewire.service
           1      2.15 us      2.15 us      2.15 us   /pipewire-pulse.service
           1       742 ns       742 ns       742 ns   /dbus.service

The other is -G/--cgroup-filter option to show lock stats only from the
given cgroups.  It doesn't support cgroup hierarchy and regex matching.

  $ sudo perf lock con -abt -G / perf bench sched messaging
   contended   total wait     max wait     avg wait          pid   comm
  
           2     10.58 us      8.39 us      5.29 us       257552   kworker/4:1
           2      9.76 us      7.96 us      4.88 us            0   swapper
           4      5.36 us      2.09 us      1.34 us       255462   kworker/0:2
           3      3.33 us      1.48 us      1.11 us       257680   kworker/3:1
           2      2.59 us      1.46 us      1.29 us       257478   kworker/2:2
           1      1.50 us      1.50 us      1.50 us           15   rcu_preempt

You can also use these two options together. :)

The two more test cases were added to the existing lock contention test.

The code is available at 'perf/lock-cgroup-v1' branch in the tree below.

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (5):
  perf tools: Add read_all_cgroups() and __cgroup_find()
  perf lock contention: Prepare to handle cgroups
  perf lock contention: Add -g/--lock-cgroup option
  perf lock contention: Add -G/--cgroup-filter option
  perf test: Improve perf lock contention test

 tools/perf/Documentation/perf-lock.txt        |  8 ++
 tools/perf/builtin-lock.c                     | 99 ++++++++++++++++++-
 tools/perf/tests/shell/lock_contention.sh     | 45 +++++++++
 tools/perf/util/bpf_lock_contention.c         | 51 +++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 48 ++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |  3 +-
 tools/perf/util/cgroup.c                      | 63 ++++++++++--
 tools/perf/util/cgroup.h                      |  5 +
 tools/perf/util/lock-contention.h             | 10 +-
 9 files changed, 312 insertions(+), 20 deletions(-)


base-commit: d2045f87154bf67a50ebefe28d2ca0e1e3f8eef1
-- 
2.42.0.283.g2d96d420d3-goog


