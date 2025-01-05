Return-Path: <bpf+bounces-47886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14580A01968
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76330162C84
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468DF146D45;
	Sun,  5 Jan 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfvl9Hiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DD79CD;
	Sun,  5 Jan 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081058; cv=none; b=WfhJtODVyMXOLZ3citXxtJ+pgL1S4VNzvkEpbXXz/dWJYspwqjWBq8DHPC03u7wE+rHlqSAFo74ZzBpWtpoYZvlkbMy5TtBkephf0eJaWKP2PN00EbYJ7CoF//YYTajFSUhRKOUdbqNGc7rsiM/Rr0Q2B5g5mFB7IEMk+RQpR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081058; c=relaxed/simple;
	bh=HE9/BmvT/RK8Uhf3T347NFSYmVj/bWZPI/+3qzHdeMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qRkwfjr3v9ZvoYQk95cGLM+Fjvw7r1myUygicbGadp6QJw/7DpmZUaPNcPJHk+CZjbFCfmz4bBr1/f8MGuL4Xk6CO1VRTf3qjXE5jj0cyKFSMos+X7N2rjPMMUoLHroonAjDQuOcm3AYWs4D+Bg9hoAy7HnLjtb45JyPDbQugKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfvl9Hiz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21654fdd5daso178387625ad.1;
        Sun, 05 Jan 2025 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736081055; x=1736685855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVNY+BN3G4MnzTrAhJMK1UjCccAjOvbl4Auxr2FKUv0=;
        b=Wfvl9Hizsi/Gw8h4RGwgkI4qWhvrViNkuTYHp8aHxL/G2Lx/faCCvhHxf5tLbYhmA3
         riARqb6wPfj4JlOayjE0Lo4KZF6X4spF/NmgTS1480EIUsYgm+cL301lbWWUJD4Gx2k4
         x5U71JS2JQnhmU3+FTZ/HJ3HpbVn9F2OH7eVjoZHIjR/0avx1+AIF7noYMgRr6rS2vjG
         W8fGTIMSKTIGRLc3qFd3q0I+6WW+oHknn2QoTGZrYDGVL24ysrIm48/52jEX6xHqBS/z
         4DXjVHEYAFvZlT8JZHjP+JoSJurAH6iuqmN5KBnwf4x16mlje0w9phiG3wS7z6hAvSze
         v/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081055; x=1736685855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVNY+BN3G4MnzTrAhJMK1UjCccAjOvbl4Auxr2FKUv0=;
        b=uc2LKPQkFvMD53Ma4qYuMsXwwMw70SlNdQ3R2XmfIqZJ/TiyeUgJtNQxXO1T0LG3MI
         rcG9BvHA5IIupKOepYdVDxX6GEFUxv4vnOiqimzEIZwDgpIflP2ffaUdFj/MuOWa75Rv
         +e9zhqYWYi1gs2kMrfrQBpbnCZtJlxBC7q6+d3lW+AmX2phEn7xs0qwdYz2V5FY/Ij/Q
         AQdByp4hMO7oWqtDj0FkKSbaF1mis++rIpXZZ9nJY7UnJ5Ysi4wtdIt/BPNvxJlyowY0
         PL0dA5/0cmDX8EPWtPWmxeTvH3WiwPSWJlz3U/W28b/Vu2GtXC4WvW4OqIk/Ee16K1M6
         XbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUMmmhgfbCvyZ1dlYINRq8TuaEL4m6iJ2xeF0Oo6YAnTpMC9+TI50/RODlrCHFl0qKjp4+JCt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5n+55rspbR/Fv6uFMysU4fKMt+8qCeVWPwKlvHmz6AdZJRzC
	ZHy9FOe2tqMvJoGvRE4UpG6z5v3BLlms45b3DQrHz6qmFcdwbQGb
X-Gm-Gg: ASbGnct0x6uAtL8gS2scBC0c5GH2/PZ2rDIdGVrTOh0TezLugpHSgwJ5INob51wrdYD
	dUb7nhBj1YOpsg6deug73m2xi7++xrr4EGoHXG8hDU41dpZ2z7N8VKVBTAR/RDd60JmToC0tduU
	XE7vCCimzpnqpsNHJUhF6gs4eW54gwyLlKTGQN7qNvSpz0PrtkV1CVe8ByTYbFOCTwjIAPaB2NJ
	hAIbaYP834IoCsFuYTvkm4V7aKPO+69SAT1sW+jh26pGOzjaNm3/aPM/UuA67er5318xMtvURG/
	9RtCL2U=
X-Google-Smtp-Source: AGHT+IEc7r2xZDsug/vVv0Tm/tEEgYCbNXWwocfM12NpCShyoACQdKQqvGJmsKjf2rEDfMS5xW0sMQ==
X-Received: by 2002:a17:903:22c7:b0:216:18dc:43b3 with SMTP id d9443c01a7336-219e6f2eaffmr870357715ad.42.1736081055493;
        Sun, 05 Jan 2025 04:44:15 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01415sm275427215ad.231.2025.01.05.04.44.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jan 2025 04:44:14 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] libbpf: Add support for dynamic tracepoint 
Date: Sun,  5 Jan 2025 20:44:01 +0800
Message-Id: <20250105124403.991-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic tracepoints can be created using tools like perf-probe, debugfs, or
similar. For example:

- perf probe
  $ perf probe -a 'tcp_listendrop sk'
  $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
  enable  filter  format  hist  id  trigger

- debugfs
  $ echo 'p:myprobe kernel_clone' >> /sys/kernel/debug/tracing/kprobe_events
  $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
  enable  filter  format  hist  id  trigger

While these dynamic tracepoints are functional, they cannot be easily
attached to BPF programs. For instance, attempting to use them with
bpftrace results in the following error:

  $ bpftrace -e 'tracepoint:probe:tcp_listendrop {print(comm)}'
  Attaching 1 probe...
  ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
  ERROR: Error attaching probe: tracepoint:probe:tcp_listendrop

The issue lies in how these dynamic tracepoints are implemented: despite
being exposed as tracepoints, they remain kprobe events internally. As a
result, loading them as a tracepoint program fails. Instead, they must be
loaded as kprobe programs but attached as tracepoints.

This patchset addresses the limitation, enabling seamless attachment of
such tracepoints with BPF. It simplifies tracing inlined kernel functions
using BPF.
 
Yafang Shao (2):
  libbpf: Add support for dynamic tracepoint
  selftests/bpf: Add selftest for dynamic tracepoint

 tools/lib/bpf/libbpf.c                        |  3 +
 .../bpf/prog_tests/test_dynamic_tp.c          | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynamic_tp.c  | 27 ++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynamic_tp.c

-- 
2.43.5


