Return-Path: <bpf+bounces-44612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51E9C5660
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB4B2819FC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D0213124;
	Tue, 12 Nov 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GruvpM0v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD1230981
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409768; cv=none; b=P4Z1OUYVDoBBvC5UFjca8H/0XQlrAt3b384v6hik1wnwCIbF5hNWDyzILsvXftdNtJ+xnYBqwX48NG3n8vRjDsxyhv8pG3bDpy2LASUHue7OnJ+aXX6sWNKr1PYFWCzWyjnnvll4kuyMVSlBS3HL5oOtbrpRhuOntdDPKSbDR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409768; c=relaxed/simple;
	bh=lVrU8kRycnRjy+NtIcnCY2So0qOp4u7qAo6e5oicJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdCfUKxyvR4BSvUYiDwO1Tyt7CyTPidFF+fU7pQxfjVqPy7G9710EY8jaqjHlHH44DRrAgcWyBBngsLBR+zmLl41Wy6cJZaGcsVjXC5jBfulBPFUZXpYd0Z4RrIsVgZ/+oFZjkpCN6+a4JxvdGSJtqGMSBzTo3HuFK56PETl6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GruvpM0v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211a4682fcaso12208725ad.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409765; x=1732014565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwoEoTXKQnovp9PKArJn31hinfKBVpSoLL2VF3EBXOg=;
        b=GruvpM0vVxyBz+46KWm1khgDXA021VsrAzwHehBSAPvlzX20EdIEzDZLIagB4NTwA6
         LbqRiIAdbBlzONKZTTH0Nx/+aHq2mpkK+yDIH2HIIvGap130gUSKA1RgqgQFur5wkVJF
         aoi9VzphPPf76tdaVwSJYULUlBlPcNctoFZfgOlykZ16fCpKsef/Snh63b48X8x4Cblj
         B9Ac9EzMsDlVsgxUPr8QGmRGQGtUDBhlQ9TErUvyaiQG7gi83qwC7rjYvFejgxVFbeIt
         UeVyKeXTGZlVJzBcZ4Uzzbis0WniWInzfK2ZSGMtHk51CwmtkSxy9h3x5ocVlDh+jeZ6
         DeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409765; x=1732014565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwoEoTXKQnovp9PKArJn31hinfKBVpSoLL2VF3EBXOg=;
        b=O6ocQN9UKI23qP38xXJEWUV3apSjqgJ8skgx2Hqf/URQ/ykAFkX/pwWxawJO4KZ2Au
         z/Scg/3Flnc3B5vgk3fzZs2tIdRbvfqCpN0+WGW3z0TkRiT/UKyAnjp5QeMm+Hen5teF
         LSyY8uUadwcaC7hNd2F+iBQkIbNxydj6XEsurHCN/q3rKouj7ZvFQI67e8k8L3Q8Iijz
         AV4UnWFn+zLt2XTaTLK2DLKl61XUsS9VdLsG8IDJFm6qNqdPCR8hFg9VS53+mTA4Dbgh
         dEvfSLrJbOYDf2hTVkkGqU4o6m0cVKBXA7kB5Rod9JHPma2Pg30xf54sH9JOTzUZISu6
         zh5Q==
X-Gm-Message-State: AOJu0Yz4dkH5wOoosXHM0F98mB4yGydlPdFzWVcMM+13fV0YD7tr141s
	TpEc2uB/lC/5a8yc/myAvMbALqC7eCKGhD+M3dTj9F+BjqJN8m+KKLhY/g==
X-Google-Smtp-Source: AGHT+IGOES2uip2pB/e7zgT5iWfhJhUyBqhcXapbFiMRwFHyjw7j4Ax5Pw+2bXteUkNjpO2mIAi9Dg==
X-Received: by 2002:a17:903:40c7:b0:20c:a387:7dc9 with SMTP id d9443c01a7336-21183542f74mr248124125ad.29.1731409765484;
        Tue, 12 Nov 2024 03:09:25 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45eabsm91789135ad.114.2024.11.12.03.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:09:25 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next 0/4] selftests/bpf: fix for bpf_signal stalls, watchdog for test_progs
Date: Tue, 12 Nov 2024 03:09:02 -0800
Message-ID: <20241112110906.3045278-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test case 'bpf_signal' had been recently reported to stall, both on
the mailing list [1] and CI [2]. The stall is caused by CPU cycles
perf event not being delivered within expected time frame, before test
process enters system call and waits indefinitely.

This patch-set addresses the issue in several ways:
- A watchdog timer is added to test_progs.c runner:
  - it prints current sub-test name to stderr if sub-test takes longer
    than 10 seconds to finish;
  - it terminates process executing sub-test if sub-test takes longer
    than 120 seconds to finish.
- The test case is updated to await perf event notification with a
  timeout and a few retries, this serves two purposes:
  - busy loops longer to increase the time frame for CPU cycles event
    generation/delivery;
  - makes a timeout, not stall, a worst case scenario.
- The test case is updated to lower frequency of perf events, as high
  frequency of such events caused events generation throttling,
  which in turn delayed events delivery by amount of time sufficient
  to cause test case failure.

Note:

  librt pthread-based timer API is used to implement watchdog timer.
  I chose this API over SIGALRM because signal handler execution
  within test process context was sufficient to trigger perf event
  delivery for send_signal/send_signal_nmi_thread_remote test case,
  w/o any additional changes. Thus I concluded that SIGALRM based
  implementation interferes with tests execution.

[1] https://lore.kernel.org/bpf/CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com/
[2] https://github.com/kernel-patches/bpf/actions/runs/11791485271/job/32843996871

Eduard Zingerman (4):
  selftests/bpf: watchdog timer for test_progs
  selftests/bpf: add read_with_timeout() utility function
  selftests/bpf: allow send_signal test to timeout
  selftests/bpf: update send_signal to lower perf evemts frequency

 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/io_helpers.c      |  21 ++++
 tools/testing/selftests/bpf/io_helpers.h      |   7 ++
 .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
 .../testing/selftests/bpf/prog_tests/iters.c  |   4 +-
 .../selftests/bpf/prog_tests/send_signal.c    |  35 +++---
 tools/testing/selftests/bpf/test_progs.c      | 104 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 8 files changed, 166 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/io_helpers.c
 create mode 100644 tools/testing/selftests/bpf/io_helpers.h

-- 
2.47.0


