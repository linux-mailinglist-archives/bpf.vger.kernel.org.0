Return-Path: <bpf+bounces-27361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0498AC730
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823A0285B58
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC051034;
	Mon, 22 Apr 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjWP4Yiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4143AC1;
	Mon, 22 Apr 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774910; cv=none; b=nusKbvGHkRxr5+qDjvOF8sGqgiSxnC9H3oC6/ypf9m3AhAt7j9U7Lbm+XNFl1AAHrz/i6XVRQ/+wCkqOvxXmJM1hYP5RjWeojDl2HiefWS5UchnKh9N2+1BnGrcuXXkynLOSeGeqejz08yPAt98DarfmCi8yXVgNN6a6//vN7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774910; c=relaxed/simple;
	bh=uVhWNiAMfNDp/b9IeuNVtP5nn6HBNzCWGB9iGqhdiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILvtZmLsPKUmIauehg2JCXXTGxUDM2+BH2s6NO4VHxTr/NyDNoUV/6GBOzZ6CWQUb3JXhZbMncv1yFEf+wuX83M5E2vO8MsKjdLzu6M3iIwzdYjGMLnZsUC3meaYxdlF3ubDhT1OVUxh4KEZ9eNh6kkGZ5C3TnyXAzuo8xt4Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjWP4Yiz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3f17c64daso26481355ad.3;
        Mon, 22 Apr 2024 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774909; x=1714379709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4Ld606VREySuBvvbpoJ4lVHq8DXsMyZcPtIwiLYOTw=;
        b=kjWP4Yiz2EBD3GRaet7sOsWuZErYMbFyxhjsVNz46vqbo5C/2GacSyZf6k+hbfBftE
         6t3FyjSjvsZnaOkb1G9CwYbIZPlKnXgKc02eETrPTsbeAv0KWt3MuxXrDAMzXmU9SbFB
         DBLijBmi/JibXSgirIU/XIznJh0yPxjPx+enEyvR/+VverAszD1vxwdvSRUm/+LWUuOG
         nHZB0HOFKSpPAg/niBO3IrGQteYWESiQ2FbuM8dkzziEbAmQekc4v+EsVzqlPfmZh+V+
         xWomRIscjB8ivsdRjzafu4YwH/C8J6fhFfqLsuV+gvJWIj65dPv7TZf0zkbKJJR69/Bx
         34UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774909; x=1714379709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4Ld606VREySuBvvbpoJ4lVHq8DXsMyZcPtIwiLYOTw=;
        b=Odi0B8Lreh5+ZcpSBciFchuPD43tsWDotCSUlOxOndYpCxGg2+uex9eNl2wXldo2TL
         2Xfb3kCJatPRmxuaoCtyzHI2jBlraNRjrkkWEGXQONH03+I4kUphUegkt1wlvPmr5iwA
         GoIy4R5blbyu7kIERaKBfXgKOp40pYdyIFmh4wYcymFatSr84RZsNaOU9HY/ijeHVOUA
         T+E73UMeBZ4C0D5x3D2TZC3AniAHvms3gr6MzHyLg88eX0/atZwqaVFPCuW4wRwUq7n4
         89MUQpp3yjCRSddH2AwY6RcVYJaFvfy2PSc8IiWRK3Hy/5XjGcJdgE7JqHQdrNEDl6qg
         e77g==
X-Forwarded-Encrypted: i=1; AJvYcCWiilymlqtcYFsYNqkSFfZV5/C2Q6rdYWrYd48o16k7nVBm/EBJsO/LH7rFIe18FDvHuwGqw+qEoPx3nJ94J09eEMwRbWQPpALB7ygsxyx/s03PygRxxOcj4fJjgd0nk3vWd7uYqM+mEoSWpjCeqRBtzQ2hn6+b6EgJUu88xdz9V6mHyg==
X-Gm-Message-State: AOJu0Yz2XxICgHqA9ntrpcSMTUw8fi4DElGJOaZ8mVt/fA3FxM4n8JGc
	uAdkh/21G3Y2bDTAN7TIz4WigdWve+Ky6uMQ93rTBsqEoIlFwPBHmfqgNN4Hdr9nK7Li
X-Google-Smtp-Source: AGHT+IHAM+B3vkuSrRZbI+vYXFaboYToWCWzZAQS5VJoVl1yPN3R5w3lVdzvmfsZZ6DwIqWgJOZoPA==
X-Received: by 2002:a17:903:11c5:b0:1e2:a5b3:e7 with SMTP id q5-20020a17090311c500b001e2a5b300e7mr10243897plh.58.1713774908758;
        Mon, 22 Apr 2024 01:35:08 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.236])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ab8100b001e4881fbec8sm7544792plr.36.2024.04.22.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:35:08 -0700 (PDT)
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
	bpf@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 0/4] Dump off-cpu samples directly
Date: Mon, 22 Apr 2024 16:35:10 +0800
Message-ID: <20240422083510.1928419-1-howardchu95@gmail.com>
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

