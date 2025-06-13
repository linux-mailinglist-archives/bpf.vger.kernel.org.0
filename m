Return-Path: <bpf+bounces-60581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5FAD83FC
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 09:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39A53AB53F
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEE2C325A;
	Fri, 13 Jun 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Jg0xz7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AB20010A
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799312; cv=none; b=jlDBDoq/JwYXugrj6+50qSoqeJb3EX4cgv5DqsKZRqNVynTmJ+Kp5DI1pTriQYInsQJVlDA0xlmYdikrvgCzCvNwTQU2zMD7xv4l2zIBaOH4Nuxf8ytvRPyS0L5seYFqjk4gsssBVDuPEAsyZOJ9evsrnLqqpLyKRzVQdtKzo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799312; c=relaxed/simple;
	bh=z95ouaIjvdQO0a6kcBEfk2Q/9buMxKgvY/ROUFOFZ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzQS11ncS773CpjCuUwuoiBENX3OqP/X7Ymx0BzoCSCROr/Ir6F4/XfS0q8x7RJePQ5m3xXHzUReD/trEyg+ykOyh8b/iFk9RIao+9kaovwxCwGsaF2ueJh027QA7EteM3oWV3gF/r0rzBJsyiLmsvzYIMswr2d7M7gDy50VShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8Jg0xz7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e4043c5b7so15804487b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749799309; x=1750404109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZtKNJ4gA4azgROb3GaKWhXw/oc7nm8O5cZRcz+cbw0=;
        b=I8Jg0xz7gCuX3l/22Xb/kXShrmN7PK1rViZi8fiPO45e4YF/ZJa+CdotFPb3y+S5Gb
         lMmuvIzjBkTR3ribfTxieCP13bGqvH2GThYaO2se69sG+yvQKUq3tBKWQAH+V7Smo/uu
         xc1NWfd/pLURYLTFgh2VfHH8fmdZxkazj0mxWN2AmTt+pYpdLIdVv8lT1d8HBU5a0sqD
         HF+zB0+RuqHUG97/6xA7janUJXFKESeOmONev5UNBvce8rwAOIpStuUvCngPkuC2PGcL
         HaWp70IdMZ1DRF8D9cyLWzx/8qo913t/VM3qonPQ5Nwv+YcIC/EEzGH4ozG3JQN9UtxQ
         GGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749799309; x=1750404109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZtKNJ4gA4azgROb3GaKWhXw/oc7nm8O5cZRcz+cbw0=;
        b=m7yYZuv/B6IfJkyujFDWl1dEvGWIyyLyWW6WOhpm/02js5aEhH3ymkP0i+Nim8SgK/
         0BN0TWYNnCy7rQUUbD6dsIOIT4zL+EdstuTn56/uFOldLefc5Ad+BIbu376oQsCODAQ1
         JFUntuyY50Ygk7TRQT7JnszfHwsq0sowUvPQskhPjAaGdxud+njYXKs7HXr94BMhUoJ7
         KmY8k8KMd1HN0gipYabdeNFTxtgDJ4/dCqRiyHL11mGeJ5OcTyAIxY320Aj41K+x5LQc
         k6c1z1vuAn8uNxUiE5Dv5T/n+tJCenvLS0kzM9MJpe17q6rHgJ3GiqHfd0LZwDBjcibj
         vagQ==
X-Gm-Message-State: AOJu0Ywu/nTdOjed1sbmcNH/rnRnYLoJEhj68xpcD+emUlB3ZLJ2GQxQ
	BEXXUtFZ0/HMGfwOa5cbzlSpka+5Av0kI5wwqc0Em1mqk/BhrQIgCxkZ+4xd7Jul
X-Gm-Gg: ASbGncv4eaJGvMh/QzhJkLefDxp0giF1x1kAzUeLxhaAegcbgGuWbtNImnmDjw9QKMS
	MPebNYeRPOg9qf22/SFEfn+PijOLZtvp6GTcvBQSZ0IAxmabtsDP2SHvGFTUXhpzgc0+zZYWhIp
	JPdmFd2jCCyuNyCpgOiOjFvXCPO5dwwZK8WENE2wpwVXvd5qRX4qGIL6zzlWxutEE8oisIko/Qu
	GeU3lDIZZa6aMG8csydzaLD/zNkwALYxdSX+Uby16klB1r/fUQkeDmR2oU7F5zYwMrM8ak3wxx3
	I4P2y8rLuSMGfHt47aPkaZM/IniBm/Z9eJ1Ybpfs8SZtxhxeqA7DAhL4ZKguCy4F
X-Google-Smtp-Source: AGHT+IEWZwDPzF37uQisNGx09LZEpbbnuPsG3IhS9pwvkOG+R/ZeMz0djmptwRRoci4SNxuO4ToP7Q==
X-Received: by 2002:a05:690c:4885:b0:709:197d:5d3c with SMTP id 00721157ae682-71163650082mr35112697b3.11.1749799309356;
        Fri, 13 Jun 2025 00:21:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115205991esm5541747b3.19.2025.06.13.00.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:21:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v3 0/2] veristat: memory accounting for bpf programs
Date: Fri, 13 Jun 2025 00:21:45 -0700
Message-ID: <20250613072147.3938139-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on the verifier, it is sometimes interesting to know how a
particular change affects memory consumption. This patch-set modifies
veristat to provide such information. As a collateral, kernel needs an
update to make allocations reachable from BPF program load accountable
in memcg statistics.

Here is a sample output:

  Program          Peak states  Peak memory (MiB)
  ---------------  -----------  -----------------
  lavd_select_cpu         2153                 43
  lavd_enqueue            1982                 41
  lavd_dispatch           3480                 28

Technically, this is implemented by creating and entering a new cgroup
at the start of veristat execution. The difference between values from
cgroup "memory.peak" file before and after bpf_object__load() is used
as a metric.

To minimize measurements jitter data is collected in megabytes.

Changelog:
v2: https://lore.kernel.org/bpf/20250612130835.2478649-1-eddyz87@gmail.com/
v2 -> v3:
- bpf_verifier_state->jmp_history and
  bpf_verifier_env->explored_states allocations are switched from
  GFP_USER to GFP_KERNEL_ACCOUNT (Andrii, Alexei);
- veristat.c:STR macro removed, PATH_MAX-1 == 4095 is hard-coded in
  scanf format strings (Andrii);
- env->{orig,stat}_cgroup size changed to PATH_MAX (Andrii);
- snprintf_trunc() is removed, flag -Wno-format-truncation
  is added to CFLAGS for veristat.o when compiled with gcc;

v1: https://lore.kernel.org/bpf/20250605230609.1444980-1-eddyz87@gmail.com/
v1 -> v2:
- a single cgroup, created at the beginning of execution, is now used
  for measurements (Andrii, Mykyta);
- cgroup namespace is not created, as it turned out to be useless
  (Andrii);
- veristat no longer mounts cgroup fs or changes subtree_control,
  instead it looks for an existing mount point and reports an error if
  memory.peak file can't be opened (Andrii, Alexei);
- if 'mem_peak' statistics is not enabled, veristat skips cgroup
  setup;
- code sharing with cgroup_helpers.c was considered but was decided
  against to simplify veristat github sync.

Eduard Zingerman (2):
  bpf: include verifier memory allocations in memcg statistics
  veristat: memory accounting for bpf programs

 kernel/bpf/btf.c                       |  15 +-
 kernel/bpf/verifier.c                  |  69 +++----
 tools/testing/selftests/bpf/Makefile   |   8 +
 tools/testing/selftests/bpf/veristat.c | 248 ++++++++++++++++++++++++-
 4 files changed, 292 insertions(+), 48 deletions(-)

-- 
2.47.1


