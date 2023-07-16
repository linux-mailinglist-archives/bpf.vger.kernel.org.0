Return-Path: <bpf+bounces-5065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B958754E8F
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FD28149B
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E261747F;
	Sun, 16 Jul 2023 12:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C66D1B
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 12:11:00 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811910E
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:10:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66c729f5618so3655910b3a.1
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689509457; x=1692101457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PmtlXi/yV+45PIt1tlnROYiXpWnFQIPBm/FQLM51mo=;
        b=LBGAr28Anaar8p8dvqeon6FqAuEm/BbSA2fPe9te21zaydQubsn9BzStgzUs/QB5K+
         tMnJM9T07URFUwq4m0QzpmMCTQZEL/J4OIodmQLV6dX3KLvSo/lZJX6Ss9AxBhliRYfY
         nRzaOTdOn9gLvpgx12RxmddOmXCWsAg8i/ubnthJBfFO16N/6u8wrhpg/cyIx5adKU8z
         5mbTjeSHYbnzQ1l6GEHdxNLvPRuptOwyd1yDWhZwA9MIZtCWhmz+KOficaC4heKIa0Q3
         nSMMlt0Ubj1DrEvsody+rdojs8Os8+7wmgmBv/rX0Rt4OnO+gmoDqTL09Kt//vfrthms
         /CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689509457; x=1692101457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PmtlXi/yV+45PIt1tlnROYiXpWnFQIPBm/FQLM51mo=;
        b=dg9Rp5Xx++f0mjlVgo78kOU1xHbZXEadduMP7HE1abii2KWt7YunaetBZ9e1ppE3TR
         qHnI8NjY9jfT8lI+XwHF38/JPC20zdA+m2gY5ii9YtqCPQj0tkrLUsVlHW2BQ+TNm+nH
         S6xU8I6TVmG5oL188zTK03H13aw2+/bY3xi/2B1Mm0AnIGUlqFgEsrWU2Rbf+oECx69Y
         v9odbSrwRKw/qjC+Vv1GIx0LsZsOCf7VdXfttUUqMPhOJ45ODvCGcyF4ENUcC5DduUB5
         RNmG//1LS00xVmT/BB9DXqHaTmPBAE5sqVDnQ44EArHbR+Ur9Wc4DTvfqtWo3E605vDL
         jRyg==
X-Gm-Message-State: ABy/qLYQJjoadRm14xrh9zEZLFYqhILgG8YL9s6aeZHSNoYousbsa4At
	gDsmaKcvOPYtZ/ToWT8NrGo=
X-Google-Smtp-Source: APBJJlFxRubbz3hX7C1Rdu7JJ2lOdd364oZrC8JtaSTNBAsgfQskmnuRnHZabPOVAzpFsCAhZJQOKQ==
X-Received: by 2002:a05:6a00:2e0f:b0:66c:6678:3776 with SMTP id fc15-20020a056a002e0f00b0066c66783776mr14343289pfb.7.1689509456815;
        Sun, 16 Jul 2023 05:10:56 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:697:5400:4ff:fe82:495b])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0062cf75a9e6bsm10128730pfh.131.2023.07.16.05.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:10:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/4] bpf: Introduce cgroup_task iter 
Date: Sun, 16 Jul 2023 12:10:42 +0000
Message-Id: <20230716121046.17110-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch introduces cgroup_task iter, which allows for efficient
iteration of tasks within a specific cgroup. For example, we can effiently
get the nr_{running,blocked} of a container with this new feature.

The cgroup_task iteration serves as an alternative to task_iter in
container environments due to certain limitations associated with
task_iter.

- Firstly, task_iter only supports the 'current' pidns.
  However, since our data collector operates on the host, we may need to
  collect information from multiple containers simultaneously. Using
  task_iter would require us to fork the collector for each container,
  which is not ideal.

- Additionally, task_iter is unable to collect task information from
containers running in the host pidns.
  In our container environment, we have containers running in the host
  pidns, and we would like to collect task information from them as well.

- Lastly, task_iter does not support multiple-container pods.
  In a Kubernetes environment, a single pod may contain multiple
  containers, all sharing the same pidns. However, we are only interested
  in iterating tasks within the main container, which is not possible with
  task_iter.

To address the first issue, we could potentially extend task_iter to
support specifying a pidns other than the current one. However, for the
other two issues, extending task_iter would not provide a solution.
Therefore, we believe it is preferable to introduce the cgroup_task iter to
handle these scenarios effectively.

Patch #1: Preparation
Patch #2: Add cgroup_task iter
Patch #3: Add support for cgroup_task iter in bpftool
Patch #4: Selftests for cgroup_task iter

Yafang Shao (4):
  bpf: Add __bpf_iter_attach_cgroup()
  bpf: Add cgroup_task iter
  bpftool: Add support for cgroup_task
  selftests/bpf: Add selftest for cgroup_task iter

 include/linux/btf_ids.h                       |  14 ++
 kernel/bpf/cgroup_iter.c                      | 181 ++++++++++++++--
 tools/bpf/bpftool/link.c                      |   3 +-
 .../bpf/prog_tests/cgroup_task_iter.c         | 197 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_task_iter.c    |  39 ++++
 5 files changed, 419 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_task_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_task_iter.c

-- 
2.39.3


