Return-Path: <bpf+bounces-19703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE282FEEF
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F58A28A38F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630311C11;
	Wed, 17 Jan 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsSF8IJj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6C17E9
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459804; cv=none; b=qLbBNVGDTpeGz/1bePq7XzZfJLdSoLtEkU0wrPlqDTRN7JV4X8/E+pEbknvGRdfq1zNTWHjXJR5Cq69l/WoQglMGrZrRBkxTZ5TW0YZl9kAJ1aroiXAXxXtJRVGtUNnwyKjSngu/159uRIWkAyvfV2lY3DrA4KvGS4LX4D+ydI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459804; c=relaxed/simple;
	bh=hU88NBatR1bubvP26lNJUIM4oCS217VWxgiK/YQ6OfE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=q3jbbZLbHYAOhiR8T8QD8xCisQ4hEYyulWXVoyfDdDSZiljR4zRTjg+oZzBZZxWCuq1IxXGDpUiTyG2Pvz/S872HC4b8ZoP4hKpfQ6yC+RjEPhjoBlO7oa2671FY486SFgraM1GzEmDJj45axRLRT0m4HnKTAG3euuIJknMDaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsSF8IJj; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5efb0e180f0so105693697b3.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705459801; x=1706064601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqGmOuwIZ2nI6OMLffc1DxW5P1FEwlpZ9CVPRTegukA=;
        b=TsSF8IJjHdJgQmtKE+HY7yX14XnbLH7P1hyWgmerlPk3zQ+PLouWYcrGzxF6B4MqVW
         yjhP8kqADZzPwA8W9/KTHeG2TiKCBUCIzn/VEszkzHe9rmC1aVKjjnmRjU/NjSSiFuFg
         ejSWUHOmG3vOSR9CXWik4FLIcm/CgVkD6sN5yOe1cxKo4AooFziGF30hbaIX4urtphly
         Bl5+k8i5w/FPkxbZMax1e9TPwzqqeEHbhU73av7NNtJgqk1wR7pBjKPhcBqHS6PQyj/4
         o1RbVvA3FguJPow20deQu1v77VCZft6qS1pf2pOhP15A9BIZziOkCYnW/F7tg8XvzoO0
         inOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705459801; x=1706064601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqGmOuwIZ2nI6OMLffc1DxW5P1FEwlpZ9CVPRTegukA=;
        b=XbpvlfYo9JoxqA5bxTcPvurMwaCQgI+vR1xWL+kh+pGmBjXG/gwPdZvAjmtYJFuqHB
         ZGKsIu5MZGUsIaAuSwvyVVO+NIcR9upadurSYYniHg1cSshK5WmtDGINNMz6rG8azK6Z
         JW/N1y0Zqf/d4563ajgO5bDFSnDgZtHVcUCqjhm7pQNtyfkM54ZNKXiGZLsJc8dbnRP/
         4ZMj6Cv8XuvaGT50iZ9QfNKychRzsbqBgiOi86Ez+jw4lO/uOP3iLQnBYkRIUiCWOu32
         MKKg0LRlulJB7qxMJO24zWqqOI1AbVRrPBVur1Rp4NP/lF77VPMOCC7Lt2Fgei2qgc8B
         VPrQ==
X-Gm-Message-State: AOJu0YwYPKjgExycqujPt5d6aZRQ2em+mZJ+c+YdcQoHOreLEttY5nTG
	+Srl3kihSnsY47exTIgJckU=
X-Google-Smtp-Source: AGHT+IHn0+yXvrcjLJ8opFJMbV7JYDyZwwfT2c9Q9pkqfepLp7T/Gx2l6vB4Moj+zq9SyNpKw3w7iw==
X-Received: by 2002:a81:c442:0:b0:5e9:10ab:1b25 with SMTP id s2-20020a81c442000000b005e910ab1b25mr5890701ywj.18.1705459801291;
        Tue, 16 Jan 2024 18:50:01 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac02:50f:5400:4ff:feba:a83e])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001d0cfd7f6b9sm9996883pla.54.2024.01.16.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:50:00 -0800 (PST)
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
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 0/3] bpf: Add bpf_iter_cpumask
Date: Wed, 17 Jan 2024 02:48:20 +0000
Message-Id: <20240117024823.4186-1-laoar.shao@gmail.com>
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
 kernel/bpf/cpumask.c                          |  69 +++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 ++++++++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   3 +
 .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
 6 files changed, 280 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

-- 
2.39.1


