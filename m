Return-Path: <bpf+bounces-20093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65F8392A8
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD121F242B0
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE55FDCB;
	Tue, 23 Jan 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASWrNdU0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C35EE98
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023666; cv=none; b=tUBDP6yfQ0/GqXUMxMroOSPwReTF7IyvCSKdBcj4BitzbjL+E3/Ni0x26/HeOwTOcstJGhKK/yfzQoPfNlgTDXL2dZiDXKbXClyhQVFi9G5W3oCyFjFq3B8qgdcWbp1Dd4LwfSC8Xd3/TLnCWLx5Cjr60LO5dhvLREqQ9N46lbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023666; c=relaxed/simple;
	bh=wt4e3Q23CWOJh2gHtLHk2i/IscjaQZx7YNaT/Pnys6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WfECYwCT5BEYGwiAW2qUNfWPvez/nZMfcnF60Ct+qn+yaEGYy8tsPssRPFJWsFL4iabCQ8/rZvPhpKtDn+7MzcbmPti231RP/FPerYudc20zcxqksgojm4aGdVgqMkgyLJdXa/WZk2SpEws0b5pZEZOTFQiqwSDKRVb6ZgN/0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASWrNdU0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso2639303b3a.3
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023664; x=1706628464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXSfeoTGdgo+Urdtz7d3jF29Hy+v10mJfuOWrpz2bBs=;
        b=ASWrNdU09cI13vKEGraKARXUNRdZGvgvL1UPHH6JoXvkeWdXtYIPACOSZbJw15wVMJ
         +vmxjJje4IRjgzprXXYFLgMe9absCitIaMSD8oCeU6ducNs9s0Tm4q1LinxIO8UZsJuH
         kLzbKqhahJsFQX4Eu2M4jIc1+UP7v0THh6v1jw1S3/gp/wa/vzBSrj3naOS6IN3RDT7l
         aWhkxEZEFvM1FPCnriBjD94vxw9elOM/eFyzdzUfOqQopwk2P+lg8xghwTFMvokxeC2S
         ab+EpUpXNJcsNB0gmX5QvqCu632nwxLET+aWRn5nFkh86yLqPa4LnfduiDqjBiofATRp
         kIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023664; x=1706628464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXSfeoTGdgo+Urdtz7d3jF29Hy+v10mJfuOWrpz2bBs=;
        b=qDKyrIe6fOEg+nZDSTQVe8LUDzxi3qcDRz6xvgweiRL+SOvjivQYBwslI2cAJNLusT
         hIZjiz0YKYdvP5zbZB+rXWNO33HQGsPWfPe2artABqCJ66SJplXQBojh8j747hTLTGVk
         DAV4UoXZHnS6pkYISjQROCYPfPTXEMsG+C8HhUD7nOVZZ+XMPiG204aoxv/coZ/em5bh
         mYRVLdFFRy4xEjbx1Q9qcmsFZ/EBGmPI1wxylwuTKMOx1yWRfid2jFO1HDdJD8HL0iHv
         WIT6MdJno/KS2w9rzwVW+A0zjsYeScEq3SMcYWREkh4b2WSr+BP0skcK3EUHfli/6MXg
         GYuA==
X-Gm-Message-State: AOJu0YygoNVA1x3s9Ayw2wZAo6osv3bDDpK16SyQaqydncdlyjnTXxmR
	4/iJAlyEWH4HBZwGl/6XWcJMlKPHmmW9LaXL8AFIDm+xcDXmYvNJ
X-Google-Smtp-Source: AGHT+IGHo3w6Ar8ifgV1OWBQrbY2HfNJUjqV/3GrpnfV1Y+n1gZHY/wWl37rygvJHjIgP9uQ9SfQ0Q==
X-Received: by 2002:a05:6a00:1901:b0:6db:d589:1d62 with SMTP id y1-20020a056a00190100b006dbd5891d62mr3486127pfi.7.1706023664227;
        Tue, 23 Jan 2024 07:27:44 -0800 (PST)
Received: from localhost.localdomain ([183.193.176.90])
        by smtp.gmail.com with ESMTPSA id s125-20020a625e83000000b006dae5e8a79asm12264233pfb.33.2024.01.23.07.27.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:27:43 -0800 (PST)
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
Subject: [PATCH v4 bpf-next 0/3] bpf: Add bpf_iter_cpumask
Date: Tue, 23 Jan 2024 23:27:13 +0800
Message-Id: <20240123152716.5975-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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
- v3 -> v4:
  - Use a copy of cpumask to avoid potential use-after-free (Yonghong)
  - Various code improvement in selftests (Yonghong)
- v2 -> v3:
  - Define KF_RCU_PROTECTED for bpf_iter_cpumask_new (Alexei)
  - Code improvement in selftests
  - Fix build error in selftest due to CONFIG_PSI=n
    reported by kernel test robot <lkp@intel.com>
- v1 -> v2: 
  - Avoid changing cgroup subsystem (Tejun)
  - Remove bpf_cpumask_set_from_pid(), and use bpf_cpumask_copy()
    instead (Tejun)
  - Use `int cpu;` field in bpf_iter_cpumask_kern (Andrii)
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/ml/bpf/20230801142912.55078-1-laoar.shao@gmail.com/

Yafang Shao (3):
  bpf: Add bpf_iter_cpumask kfuncs
  bpf, doc: Add document for cpumask iter
  selftests/bpf: Add selftests for cpumask iter

 Documentation/bpf/cpumasks.rst                |  17 +++
 kernel/bpf/cpumask.c                          |  82 +++++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask_iter.c   | 130 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
 6 files changed, 289 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

-- 
2.39.1


