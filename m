Return-Path: <bpf+bounces-19310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5B829387
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58141C255EB
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 06:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD1DF71;
	Wed, 10 Jan 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6zpXdGD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC06320E
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5989e464910so23888eaf.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 22:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866444; x=1705471244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDNgqt2m8eJ6mk5xqUEQPoK6eTH6ZvEU7S7awzfHSdY=;
        b=W6zpXdGDc8eawSzlGtndncglj8WOkyIiqxtoh4dyORpxhtkTxROarFLx0WADpS6LWg
         LrpvAM2CSC1rktNJaJSMelmxUC4GcBdA4Grfmc54PovpD57ngygNsQVsN5WaeWdjCrdN
         JcTlAjt+ODxW19jM3LretKqd1xfpK7jiy6q/W7hGRN7M1lGZLugOOtw5Z72X6/p3S6oH
         +JaQw93Yxxjt1yRswlMf6AZBy+L802ldj8dS/wXHQYJISRcYZQhhDJtPSj4PzJrcd4pL
         YehsjhN0TeC2VjOM1q+xAPVHo8Kkwzvc5GS/LlgIasM5s70yzIvzdCliC8rupIsPEDMl
         rqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866444; x=1705471244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDNgqt2m8eJ6mk5xqUEQPoK6eTH6ZvEU7S7awzfHSdY=;
        b=teys/80xVFzfCVBLOWCfU+rrAUHaUl6RMf1g5sbFo1gB9vpaZiFT14zc27nKH0NQnb
         gujexaw9EpHdCt6lPt3B9izBenCpV2NxIUV2oy0qVErJpBRm2P3nH4vGnRu4c6svUJ1D
         ChTeRV+jF4Qvn7prG3WoCwhvjvzGJgxcIiG73lLNIbeS5jLmhExL1IfCcSSQLY4HUUeu
         GxwZ3QBkWnmU4ypFDd35/vupmXrReBB4e3Gel+hnajPGjPageB5g78gsBZJIPSPnCppS
         jAikXixyVfgBWPZ6aGVQSpCtUcwCMISB+LZ7AWALBqkCTeMVroZ0TrZR53xm7RWgbLxj
         OPBQ==
X-Gm-Message-State: AOJu0Yyb4h/uehXvLHqY6pvn5TrD4ujJP2ps45vPSTcZ+km8/giqfQsa
	R8b/VoXUaooRyB+P/w62I/0=
X-Google-Smtp-Source: AGHT+IE+16q0sn6zWmIkUh6gTAwjCN5I9Go4swmsDMtLciZFsPBkj+sAM1W0AM5WQJ/Hd6dTJP8CCA==
X-Received: by 2002:a05:6358:2917:b0:172:b6ac:7f89 with SMTP id y23-20020a056358291700b00172b6ac7f89mr497584rwb.3.1704866443905;
        Tue, 09 Jan 2024 22:00:43 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id sx4-20020a17090b2cc400b0028ce9c709e4sm540923pjb.26.2024.01.09.22.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:00:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: Add bpf_iter_cpumask
Date: Wed, 10 Jan 2024 06:00:35 +0000
Message-Id: <20240110060037.4202-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_cpumask_{new,next,destroy}, have been
added for the new bpf_iter_cpumask functionality. These kfuncs enable the
iteration of percpu data, such as runqueues, system_group_pcpu, and more.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
Refer to the test cases in patch #2 for further context and examples.

Changes:
- v1 -> v2: 
  - Avoid changing cgroup subsystem (Tejun)
  - Remove bpf_cpumask_set_from_pid(), and use bpf_cpumask_copy()
    instead (Tejun)
  - Use `int cpu;` field in bpf_iter_cpumask_kern (Andrii)
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/ml/bpf/20230801142912.55078-1-laoar.shao@gmail.com/

Yafang Shao (2):
  bpf: Add bpf_iter_cpumask kfuncs
  selftests/bpf: Add selftests for cpumask iter

 kernel/bpf/cpumask.c                          |  69 +++++++++
 .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../selftests/bpf/progs/test_cpumask_iter.c   |  62 ++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

-- 
2.30.1 (Apple Git-130)


