Return-Path: <bpf+bounces-48249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C4A05E96
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ADF164F6B
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC141FCFF2;
	Wed,  8 Jan 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eixi2yST"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574731FCF44
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346612; cv=none; b=kk/Y7Gsya4OyFJ6iLZKNelQ/Bp6n+0Hr/2fnsU1QLe/jh03mfPq7Lbny10jp/Iipt2h+hyWB5jRtXlMxnjL1MpukAKUkH0OmGadj3VNdotcbr0524BPuW6R0DvFzwFT9iteyfmHuq9+gjxymyUOuUSd3sPujsw0atfddVDSiJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346612; c=relaxed/simple;
	bh=EbaQIPivd3k12R9u+2jbA4uZjrTwxRKMILMWyBbew2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POtqCThYzEAGrjeZ06nEiHCHJnRV8g/xOX4DFD9GPzM3bDr/yFrg+Z7EK3/gkZSc7lnE7B2j54jtthmbHYosL21fm0ApGYARdBkmmcE54jO8B4WVC04I9zHvDkdE5o3h/vnxtOjyRhRR+dMuWPEkMobKX7OSP/073Kh4HIoCZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eixi2yST; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283d48so122101685e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346608; x=1736951408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=eixi2ySTdhd/EL04Dw814MmtGY9ji9cI8eG7RfMM3yNcFPEbDl/qLG7fNzIyGyGhoF
         rJTWofQEZ1uQsNLCqGhIQxXtbwqssTeLQj/7sovxswtNRsv+jq02nv1kJzJdcm92UgjF
         L1PLuNyeDVhW2xCcGIizyXzdB9S1ocwvZv4tgv28EeyRRaIdv4WaarSc98c48JWNUtyE
         bO8OgX8K1+GS9vnVisrGWrOZH/H8LHAo+JKtDaMt3/K4a9ysJ+AZu7QHT3bS7GymMk1j
         bISPbXiX/as0NW6ovARqehDJvumX9wF9+/rWYRUrB/38kYGNFOLZcODNsXN8zdpcDQWA
         1jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346608; x=1736951408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=XCNXKDVa8WkAATkirnUwo43szegRT4R7lSdxcW1bdjRxL+OuOvk8aaRK3Y2S+8n0qf
         7ByKoW+DZ6+ZMstSGhSMmhFQnx6OihIPSJ5D5sZWEEyKXndGam6GqWkxbizsSFWV4jNC
         LhFzVvljWcWQeuemV/vpfAt0lRRHMMeTafmU9zGdnL14fUunPjGDKRvnWDVhI6/cn/T5
         67UYaaVdD4fxYs8fsFvG70QzgtjMToqUQdeYU7ss9BGk3D3RunAEfvKlzDEZsVMHo2oD
         ks2zrwLkXcmnA62FtRXmzyvrFyyKG6U3qEZyiSOL7GG11QLHEOd2bxriltpit+jHDY4g
         rAqw==
X-Forwarded-Encrypted: i=1; AJvYcCXpf8tGJUuWP+SWcroEyG2hKIPe3PhKbeOCUhOIetUJE+SiUs6msMaKkPZOc2irjif27wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSog6VDhuKE7iSwt0+XW5DgSQUW8buaVNi1EBk7x3GRr4L+P3h
	WwBynfKxyVNjHvJolUXxaNDjUJ4pt7zJpPXFem23p3LZ2vpcEP9TG9ktf0G4pY0=
X-Gm-Gg: ASbGnctZGyxaW600O7gagf98Y2M165Rl1FMPB0SIlxdbris4U042NheY3hC0cVdzrli
	0zsf/sWfgkmfxUL+I39oVS0fDXV1TEErx+5cUpXyVzHXmVYDtbVGlKb0gC7DhSej78wznQdI3I7
	6Y7d4VXkdAoYqKyZGKT8Qeibzc0oDAEcae0LqyBAxqxXiPi/NnaIciMN8F9VHIqYhJgWRO5Jtdo
	RzfMinJMMkJdzxgsVRWVf6SsGw+fWY5FmBCLEPChcs7kM3eoPUMyPpQ
X-Google-Smtp-Source: AGHT+IG+cpKSlSJhi+F2YnCugAoch81HQ2u34rrtXJ7N+pJyIFTLAKd0EsB9c31sEmDi5t+EC9MrUw==
X-Received: by 2002:a05:600c:3b2a:b0:434:f623:9ff3 with SMTP id 5b1f17b1804b1-436e26a8c3cmr28551185e9.15.1736346607506;
        Wed, 08 Jan 2025 06:30:07 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:07 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
Date: Wed,  8 Jan 2025 14:28:55 +0000
Message-Id: <20250108142904.401139-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard mode (Armv8.6) is a way to enable SPE related PMU events without
the overhead of recording any data. Add a format option, tests and docs
for it.

In theory we could make the driver drop calls to allocate the aux buffer
when discard mode is enabled. This would give a small memory saving,
but I think there is potential to interfere with any tools that don't
expect this so I left the aux allocation untouched. Even old tools that
don't know about discard mode will be able to use it because we publish
the format option. Not allocating the aux buffer will have to be added
to tools which I've done in Perf.

Tested on the FVP with SAMPLE_FEED_OP (0x812D):

 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true

 Performance counter stats for 'true':

                 0      armv8_pmuv3/event=0x812D/

 $ perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true

  Performance counter stats for 'true':

             17350      armv8_pmuv3/event=0x812D/

Changes since v2:
  * Use existing SPE_PMU_FEAT_* mechanism (Will)

Changes since v1:
  * Add a new section and some clarifications about the PMU events to
    the docs. (Ian)

Applies to v6.13-rc6

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf docs: arm_spe: Document new discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode

 drivers/perf/arm_spe_pmu.c                | 22 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 136 insertions(+), 32 deletions(-)

-- 
2.34.1


