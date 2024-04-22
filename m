Return-Path: <bpf+bounces-27354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A858AC642
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3571F21977
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF924E1D5;
	Mon, 22 Apr 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF7bhdrP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436324DA14;
	Mon, 22 Apr 2024 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773151; cv=none; b=N/m3EPQI+vuXx8c+kJkfzJoxEvXYybpXHcjQQFW0RYhAfcn9rrFK3a03WNszq30RGkGBVkPP4FLZYWEagfFxAqa/5SVPcoMoUMaGwLWYwskQg7C9K2FkjpyyjaYKd5Nwfb3F1Nx1rJQXIDlnNYtV/EyxdUxwUzs7lZ4cjuUjqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773151; c=relaxed/simple;
	bh=uVhWNiAMfNDp/b9IeuNVtP5nn6HBNzCWGB9iGqhdiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXunZ4KAyASMoCy779s19i2FZ0/t4+n0VKgyowdv1gEI7SF7za0zZiEOZqEIqfkllPAKcfeN7MuwN/Lxm52+QstO7XEq7tpBfAJueHGIANrDM7o0nNrhSFhNuvq8ve4NFUrS76TZkZxbkNswtXwkQzD+tBXuHL1VQ1xKAXbMUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF7bhdrP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2029237a12.3;
        Mon, 22 Apr 2024 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713773145; x=1714377945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4Ld606VREySuBvvbpoJ4lVHq8DXsMyZcPtIwiLYOTw=;
        b=MF7bhdrPeokn4GStVp0kMvzij6sYL1TjycWWydWwa/0Kyrqn0S82/TdAYMYCrX0osH
         e+R0rzaoYTm9uKc8UtfXO9tkrmu5WYItDqCVEKZnZxyfImcnhSZuDHa1zcu12ebVuptR
         G9dG0vpblcnUqayclS6rpSNTR8amifIruAEG/MvqbSGpKJToEKVQ2uGqxFEzm2ZtNPlM
         YDAQHhlp4Cw0WUi5tGAVFyasev6/xU2jXpKdbyPiNbI5mBzuv8/ROjmTZvy+wXOq1xmc
         JwReEN8QPVmt27COsOPPRA9oUSnPABAi5jtTUc4EPSUvHwxOcWsTa4hLX9HSCpnzOBeH
         8wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773145; x=1714377945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4Ld606VREySuBvvbpoJ4lVHq8DXsMyZcPtIwiLYOTw=;
        b=h54rXPMKLzs858zt0qQXy8AgcsRrEzDKoe4RARUEc6SSrrd1Wu3EeoAHM6OTPh4arW
         Em+qWbNvpIXzGZCrOlXxBbnyHZnzY5IE25J9w4Ij57I5bdS6ZGE0nPYCJJp1k7d0BbgF
         dz7mnlDFrq1m+yUQKBN2aE3kaLxu/1HG4xOa59i5aPUJGxv/69b2FWPt38V5ftdJtjjf
         g8h3HI9wGpYHfbQ9O1oXQCkIyMwB2hPh+iKtfqw2TXdp8ffmAsdptaVkCniW/kZVxOw8
         gY274oF9Hb83yrL8h6laZj4ciSWJ7Jsko+/cs8XhQFQpJMc7HVZCSLosz8yaPuIYsP8h
         H30Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz7IB7oY7tpeFaRpcJv6fyxPHdYlfy57bzXgaRlSRDUg5XH+TngTe19GCcBsYMuV9iaJv/aOGo4Z+t2e38BOFfaJdqec7BC96y1Hdg8uVFs+pKKJy4iQy2qL9hMUWu3Xlt5jZ+RcCQE8KB0i8JsSlTTqNlIr6kSkf0WQBPsc1S2ScDzg==
X-Gm-Message-State: AOJu0YzlVWD1cRZzg4BcEIzCXT+ejo7ytt1nO5omcyoMm81BFgZvN58V
	Lch0lBIKpMh1mWA4TCkTvNKdDRIAHbOwKESOpCMENfWpjknWRT4N
X-Google-Smtp-Source: AGHT+IEr8/+66snntLRMzZCUO90S81JePpMsCeL3w66lbO0RkfdaeGJVZyZq3gBfQDbdCvcKx9Y4Sg==
X-Received: by 2002:a05:6a20:244d:b0:1aa:8442:21ba with SMTP id t13-20020a056a20244d00b001aa844221bamr10148312pzc.21.1713773145406;
        Mon, 22 Apr 2024 01:05:45 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm7468208pfb.170.2024.04.22.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:05:44 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 0/4] Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:05:52 +0800
Message-ID: <20240422080552.1913893-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

Currently, off-cpu samples are dumped when perf record is exiting. This
results in off-cpu samples being after the regular samples. Also, samples
are stored in large BPF maps which contain all the stack traces and
accumulated off-cpu time, but they are eventually going to fill up after
running for an extensive period. This patch fixes those problems by dumping
samples directly into perf ring buffer, and dispatching those samples to the
correct format.

Before, off-cpu samples are after regular samples

```
         swapper       0 [000] 963432.136150:    2812933    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
         swapper       0 [000] 963432.637911:    4932876    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
         swapper       0 [001] 963432.798072:    6273398    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
         swapper       0 [000] 963433.541152:    5279005    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
sh 1410180 [000] 18446744069.414584:    2528851 offcpu-time: 
	    7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)


sh 1410185 [000] 18446744069.414584:    2314223 offcpu-time: 
	    7837148e6e87 wait4+0x17 (/usr/lib/libc.so.6)


awk 1409644 [000] 18446744069.414584:     191785 offcpu-time: 
	    702609d03681 read+0x11 (/usr/lib/libc.so.6)
	          4a02a4 [unknown] ([unknown])
```

After, regular samples(cycles:P) and off-cpu(offcpu-time) samples are
collected simultaneously:

```
upowerd     741 [000] 963757.428701:     297848 offcpu-time: 
	    72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)


      irq/9-acpi      56 [000] 963757.429116:    8760875    cycles:P:  ffffffffb779849f acpi_os_read_port+0x2f ([kernel.kallsyms])
upowerd     741 [000] 963757.429172:     459522 offcpu-time: 
	    72b2da11e6bc read+0x4c (/usr/lib/libc.so.6)


         swapper       0 [002] 963757.434529:    5759904    cycles:P:  ffffffffb7db1bc2 intel_idle+0x62 ([kernel.kallsyms])
perf 1419260 [000] 963757.434550: 1001012116 offcpu-time: 
	    7274e5d190bf __poll+0x4f (/usr/lib/libc.so.6)
	    591acfc5daf0 perf_evlist__poll+0x24 (/root/hw/perf-tools-next/tools/perf/perf)
	    591acfb1ca50 perf_evlist__poll_thread+0x160 (/root/hw/perf-tools-next/tools/perf/perf)
	    7274e5ca955a [unknown] (/usr/lib/libc.so.6)
```

Here's a simple flowchart:

[parse_event (sample type: PERF_SAMPLE_RAW)] --> [config (bind fds,
sample_id, sample_type)] --> [off_cpu_strip (sample type: PERF_SAMPLE_RAW)] -->
[record_done(hooks off_cpu_finish)] --> [change_type(sample type: OFFCPU_SAMPLE_TYPES)]


---

 tools/perf/builtin-record.c             |  98 ++++++++++++++++++++--
 tools/perf/tests/shell/record_offcpu.sh |  29 -------
 tools/perf/util/bpf_off_cpu.c           | 245 +++++++++++++++++++++++++------------------------------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 163 +++++++++++++++++++++++++++++-------
 tools/perf/util/evsel.c                 |   8 --
 tools/perf/util/off_cpu.h               |  14 +++-
 tools/perf/util/perf-hooks-list.h       |   1 +
 7 files changed, 347 insertions(+), 211 deletions(-)

-- 
2.44.0

