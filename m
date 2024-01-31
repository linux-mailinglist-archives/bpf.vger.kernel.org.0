Return-Path: <bpf+bounces-20824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73082844271
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEAB1C25ACF
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E91272C4;
	Wed, 31 Jan 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHAEkhG7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445A12DD8A
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712932; cv=none; b=ipJ1FSQ8KGPxFFU7F1mPmx4GgAQ/TKCcVw/Ye6Kqn3qnjHtsjN7qPJLLtQq2D50laRNQH+MyI9HY492BXxpgpuL+7U8XZuvVMxA+Ln+MY00DFvQY5t/POFjlqlPreTMjv4kcOGqoT9hDRMF9VyImjtbs/XihJFnIn7TGl/z9row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712932; c=relaxed/simple;
	bh=ml+nP/ijJBn3JJhGK3tvAP6PZBrK4/t44HhbGFyWErw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyJ64q0pF7KIY0TlR2SiHDdSoYvACOqym/jXM7FQ9YOvdxJz21EUyT4bbTyb0vRVBNOFqT0R7vOcl4ag67SeZh5Z5mJZCXy2u6L0PGgpDUOUb3BO4rdW79XmNCsK8YlCAWTP0RZ2HJNYtzEwvOv5rdWUTD67kYEIzK0ZSpg9xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHAEkhG7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso41812525ad.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712930; x=1707317730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhR4J0j3yVI1mTZkuto06e/lo6baemKfxx3E3SbxWdI=;
        b=cHAEkhG7h54zudEOpd0aA4zBAyRWumQ9RpmRivNlGKIWPERe4dEsDnjtQb8WFjpMG+
         wH5jchMEGk+8VyN0h/xA7ZlLgaJRUbulfVQaJRQ/p5N5Td86K9oW5HKmN0+3HrHGKK0q
         8xumB1x5F00em4W17b6kzkAckawHTqgFrWUtlydKI3sQaVowrAKfhaKnOy2ehX6WixOh
         /31KcOnUdDoBNnhkp7q8pmJlKAiqqa3+73M+zbrb5L3UFh6Oyd17lWQx6ObGmYDwFcna
         85M363HvF/iElgkRAXe8D8HWWJEAEyjq77E1ckWawpROL/m6D5ENSScrj92Y0RDYQ4h7
         ACHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712930; x=1707317730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhR4J0j3yVI1mTZkuto06e/lo6baemKfxx3E3SbxWdI=;
        b=Us6bTOJW+XN6fnkpZyPCt3j9vTFOTaiiK4f9SvTHBEStrC1ggy7xF6GHPrEjOKR/zO
         ISiQeym1wcTT49Amf3TEWFo6K1C2I6zFVOZqAYadDNwg4/5aXe1MBEK8LMKrUGy9G3Ut
         ZLZypSLstFwDeEVe8Q+zkdZarTR5FYi/+IlQEKXqsabOnzcDYHrzPF27I2+l+wQtK7mr
         OrxGLBk52nbBECAnezkmqd5amaEUiprycMNVtZrP55uSXOP7hCNIp32KR3lh8+PfMkbI
         fAojLyjNXvcmtI6758g0zN67mKFCZn3BdQFb1Erp2lWDHxPXDC85jdChZYa8o+JShoHo
         63xA==
X-Gm-Message-State: AOJu0YxoUXsAC+HMpNFWmgv9mlLzpAsKGlIY+nBuBFx/VwY4YFloJNHn
	J/5LP4EfODy4JU2wj4fBeFrZinGFaeXOod7kXBmzqDCjFU/y6rT6
X-Google-Smtp-Source: AGHT+IHwMlWvPCLfeddFEKsRjJeC5RDADBT5b6O1+4oA+ToMfQjZ5WITPUUyy3PXzPQbsxFASyyDuw==
X-Received: by 2002:a17:902:82cb:b0:1d7:e84:4ede with SMTP id u11-20020a17090282cb00b001d70e844edemr1820898plz.67.1706712929973;
        Wed, 31 Jan 2024 06:55:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUm2Rrmi51lvgFoFHrSofE5kFarbLJWdNlOulhL9/L6/oTodHcW7k5YGzs+xt3BzMLZFqeVJNReoe1y5YRSZ+odoAL7fglSdtcOt73+U3ZIXXn6wvOQ3mPp51dAploQyRPaJcGtA3lVvhZEWyLQobR/WL9Dw1g+iYv5UByddWIky9o4Bjo9Seyff78dkOb3dmM06I8uB964OQlVEHl8u5Seuz2c2ySbeanPbC5DaLHt49W/RJ1sA5u/RyZvZl2Q10Z4CdXy6LhPJ6IgkmrI+/yt5l1e4MI9ZWNBqzel7AM5Ke0A62CghGHC9T3/DROiz4dgTk2geG+FkQqFW9cbYh4aM62iqWkt7Mt2lYDmOZCYdo/1UWdVQuYW0T9aiL9QMp9Q03/kD25QondGKaWWey+1VzNz
Received: from localhost.localdomain ([183.193.177.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001d8fe6cd0aasm3901335plq.286.2024.01.31.06.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:55:29 -0800 (PST)
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
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 0/4] bpf: Add bpf_iter_cpumask
Date: Wed, 31 Jan 2024 22:54:50 +0800
Message-Id: <20240131145454.86990-1-laoar.shao@gmail.com>
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
Refer to example in patch #2 for the usage.

Changes:
- v4 -> v5:
  - Use cpumask_size() instead of sizeof(struct cpumask) (David)
  - Refactor the selftests as suggsted by David
  - Improve the doc as suggested by David
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

Yafang Shao (4):
  bpf: Add bpf_iter_cpumask kfuncs
  bpf, docs: Add document for cpumask iter
  selftests/bpf: Fix error checking for cpumask_success__load()
  selftests/bpf: Add selftests for cpumask iter

 Documentation/bpf/cpumasks.rst                |  60 +++++++
 kernel/bpf/cpumask.c                          |  82 +++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask.c        | 158 +++++++++++++++++-
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../bpf/progs/cpumask_iter_failure.c          |  99 +++++++++++
 .../bpf/progs/cpumask_iter_success.c          | 126 ++++++++++++++
 7 files changed, 526 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/cpumask_iter_success.c

-- 
2.39.1


