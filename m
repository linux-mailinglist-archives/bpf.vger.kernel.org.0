Return-Path: <bpf+bounces-48248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49EA05E8E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E283A2CA8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370001FBEB6;
	Wed,  8 Jan 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnlLQYTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A621E131B
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346494; cv=none; b=Hfzyv5a7eJ08JZQkitxHsDZciiocdMVK0V+keLzRqAZZgUA60iPddAaIUGozIXNJRdFPQ0W+UMigbcDG33KJqiv7gfSBuSUU0TacifWcD9DlbLYmD3lNjc8niQ67F+fxACBb37scgC5BiW/+toG/4qu09KUmZ3y1G+h0tTbqee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346494; c=relaxed/simple;
	bh=EbaQIPivd3k12R9u+2jbA4uZjrTwxRKMILMWyBbew2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNvgqGgkTr3XxQL+T7yapxFQDAb/6rPK4/zDNILQkQAZgkKCZ0oqYiUQjAvh1rgGMiW30/wjWnjTfNtTlf7/WaTm7SfxgA2yuK61r88s/SoMZE1077g4dqk7Uu3XExl4YUA6XPQXmokdkR+i4bOrWvbN3pfzwNc1W3Rqqve3V6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnlLQYTA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso16155554f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346491; x=1736951291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=hnlLQYTAdsXICHCzSALVIWGTCGPfK3iT+bq6XprmbQosiylioVU0GpsSshmSD3aBS8
         fxKoJ6IJn6a++l34pmWF/JfdUPWM+XjQO+ijaNhE9PcgCG2hPahbbiMqvEA8xMF5jtpv
         WYHFaIbJ8RutA0LgYVGB/6Yeff7G4eosb6O0bmDNXUgNg1uY+cLJMpoMPtGs7qyVWaBl
         f5vH1lP69fmxlEa5UOV7Wd3KA05Ph+/MqcVI7d9xBay6aitryEg16ERoSmlGBmdR0DOW
         YIHyJixCPVp+XdZcbAf9SKV6KvcqpblusPgmcJ26XEQ5g2BuJISOx+uWrVE/j9+F+JJY
         LuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346491; x=1736951291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DTjVFlw3a1BE3G1k/Oc0pCRnQoWK8WuT3gO6hdQWPM=;
        b=FN0wUc+zPMtWbsdRfECeuvd/klhAiumfKpJlCeV9RrXvpk5Ol4eed8VHftjq9G7fWR
         G0Hk4Mp5ea6Y6c5hRXw7HZPAAQ5SOELBfNZwvMe6YpO7AEmDoF5yPTVC1uIYNlzNAGCP
         xUWvB/YAGNXTNLFGv7K2D/q5ZsfUxUe7zvzdgmhEE2S607h9Bdpr13SMvJO23LCqnLxI
         wmDysTS3B5Th25Lo/p87EpPzmA7WvrDbLV1zoNC+JqaCl/J2Jo/P+3MtViRbZnHVytai
         UjA3yIqBMw2wtP1vOhqaDwz69SN35+AXC9rlT+WQb0rrAOHP01hVr4WQqY4ICtgGodns
         lk3g==
X-Forwarded-Encrypted: i=1; AJvYcCVJtQulp663iTtuRCsWXuqhuCyJFNxeJV7cqJpMNUZd8j1WzrNaCcaD+Sky36MSIBz9WFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyii2DS3tpnq7Atf94TDe3WS5HuYZtWKW5Hdyc9WMbqtLTB9MC
	INAaaPp+XAXyc8KxZPHpxq681UsoGwMAsqPfy/3ABQquJnCTPlMmi4kd1L2mU/4=
X-Gm-Gg: ASbGncsRQAcNTFzQe7FX/iGuFOIZV8HLysb1QIcxpc73HhYx/bdgPWhXT/x+XFzqPhL
	KFUbY3l6HqGNXG7FV2xCZQxDiep99fdHpFVe7u161nSN5asgN15qio1FXje5MEjSAr4HCwNB5zk
	mNCA0CYta9a0DzvNIQ5CKruQ+/wW929WmYc0cuMqM8ubW0q6N9X0UJN1bAWEBE35rKTi8lHthtT
	tUne8BuvHm8AjHBhMr75fR17obM/HdpwiGY2vf2JGFxKpJYAIsYkBca
X-Google-Smtp-Source: AGHT+IHz31vPgvjsP1ktI6cDJs5dwXi6jyonWjrDKCklrI15yME8jN2ZsQTROIywKIjV9MjHGbUrWw==
X-Received: by 2002:a5d:64a8:0:b0:386:3a8e:64bd with SMTP id ffacd0b85a97d-38a8730560emr2565669f8f.22.1736346491235;
        Wed, 08 Jan 2025 06:28:11 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm47577178f8f.108.2025.01.08.06.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:28:10 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
Date: Wed,  8 Jan 2025 14:27:22 +0000
Message-Id: <20250108142731.400605-1-james.clark@linaro.org>
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


