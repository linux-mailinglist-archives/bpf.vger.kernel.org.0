Return-Path: <bpf+bounces-27621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5938AFEA0
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5881F2434E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6759184D24;
	Wed, 24 Apr 2024 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCQUkFL5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4983A1E;
	Wed, 24 Apr 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926788; cv=none; b=W2zLdHiXqYIOaXyzhhxsPtH6+tXyZMsgc05ATx+5WE19KtCxd2M2ShutPenPZbsbm0hKY7YYVVXbt6/f5wjMlcgbNy8jhWUx8wTbx5Uxs8o/wVtlUo+yeoxZCeh2iZahsO6ZdqXCJbfWvP9gCrg5UMFQ3BDseM02hTIV5Uk1qWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926788; c=relaxed/simple;
	bh=xBUEcmhUENIVfjoh2Y2J3tXoPs5E2mh53NO4x3kUDXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwqL4b65uSDD4DSssaGgLhOCxzP8VcdDe6y97j/n5NHcx6Edius8c+cEARIzUfHbfku5hpeKRw111M0uw6nma9LdPMz1/q9sYAci/Njb9eOdXJgh+xqQwaYIx8MzWh5PjEd1tG0PAQDnQ4b1OIRz7L48fC1A8JVt//6tinL1mOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCQUkFL5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4f341330fso53967385ad.0;
        Tue, 23 Apr 2024 19:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926787; x=1714531587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTvKMLpj2AZnqrPhNjBbKcnRSe3quDRxIzs6jtieELk=;
        b=YCQUkFL57jYgfRvQaq0nBIAr4mRNTHJW4YHO8NYhk+jk1RuWGZGkpVJ21eZf/9x5PP
         K9oku2CiZNewtNlF3CcuOhBXuDEfrBX51ZLwq2srGNzCbbeFKvpDXshFQ4iwMJoF65RU
         +FBsm46nWMmvub2stNmtRlOegqHzvaUVWaIy4smeBTaBfiiU4iFPy1db0tZadtniTj/i
         8Kz81bVJnfe6qw1nubPIo9nzdRHBViJBN3PmyvlVr7t1N7to6qdTNunCnYUnRfcRio9d
         PurISUQ/t2vkY0A8MzeXRg8mwRid0gL/34+cT301/rzYJb5rWMq1bmTVdWnSC6Yb61OX
         x/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926787; x=1714531587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTvKMLpj2AZnqrPhNjBbKcnRSe3quDRxIzs6jtieELk=;
        b=Trgv8LeEWajuG6gxQz4G/RNNeLMQms8HOEqsTB0w24gNRaUDjV01Qlj9dN+n8ENkl5
         x7o3pLc/ghkSGC601++SRgonpQYhyM/nOA/zMITboix6mfqVCvaHPOWeSxz2vQJREiWE
         yoopVK8vmWqJYm6xvoJWXUfquB5vD0ryCl9Gcu5o8gaxhFg83Ys2XbW4hv556tCYb8Yv
         H9R4XKD3hgBB0V5DYFbTR3H62azqudoGbc0qtUj3lQR1s6di2DtcnTU4uUbhkwr+wq0l
         XlCoftSaRJy+dBdlBaT4zHvnFnVPrTSowv1EB2JKqFrO35UJR2myKpZ/NpJMFmpGUalI
         MdDw==
X-Forwarded-Encrypted: i=1; AJvYcCUhtZNxIoTH56uuVgQs/J7o2xh/vaMk/jIAJhOu5lUQYhQx8iw0AxrEkbFh3yTqzBwEgzamJIMrlj+3RPHfmn/O/ED6LpMUQEL9DjW2S6CVrXeMCo4IoAhYFuRqaMy4HxYSFthSTFRq4gujrngOFkeFp2EKNNRqLRv+KEQvsqNf1bcYJg==
X-Gm-Message-State: AOJu0YxtIjd7kKrgYCRuKd/AI8N+lOUrEdfonuCAlc0EK7jSUClfyAVw
	3u5/mj57vEVYHwu1M3lYNdzBlZ2zKm0p3DtCF96eGZVed0NfnoKQqOS0IqbTWjeM7Q==
X-Google-Smtp-Source: AGHT+IF79yN1BuL7Po0ptWnZUO05HzHm4l9+fwgVmQSQ/bfLGqHL4piuBpi0EwGBsi/CKkzw8U3sxg==
X-Received: by 2002:a17:902:d481:b0:1e3:e25c:fa5c with SMTP id c1-20020a170902d48100b001e3e25cfa5cmr1395689plg.67.1713926786686;
        Tue, 23 Apr 2024 19:46:26 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.143])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e604438791sm10739243plg.156.2024.04.23.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:46:26 -0700 (PDT)
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
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/4] Dump off-cpu samples directly
Date: Wed, 24 Apr 2024 10:48:01 +0800
Message-ID: <20240424024805.144759-1-howardchu95@gmail.com>
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
[record_done(hooks off_cpu_finish)] --> [prepare_parse(sample type: OFFCPU_SAMPLE_TYPES)]

Changes in v2:
 - Remove unnecessary comments.
 - Rename function off_cpu_change_type to off_cpu_prepare_parse

Howard Chu (4):
  perf record off-cpu: Parse off-cpu event, change config location
  perf record off-cpu: BPF perf_event_output on sched_switch
  perf record off-cpu: extract off-cpu sample data from raw_data
  perf record off-cpu: delete bound-to-fail test

 tools/perf/builtin-record.c             |  98 +++++++++-
 tools/perf/tests/shell/record_offcpu.sh |  29 ---
 tools/perf/util/bpf_off_cpu.c           | 242 +++++++++++-------------
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 163 +++++++++++++---
 tools/perf/util/evsel.c                 |   8 -
 tools/perf/util/off_cpu.h               |  14 +-
 tools/perf/util/perf-hooks-list.h       |   1 +
 7 files changed, 344 insertions(+), 211 deletions(-)

-- 
2.44.0


