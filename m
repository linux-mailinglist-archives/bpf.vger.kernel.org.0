Return-Path: <bpf+bounces-48251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00396A05E9E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B3818876D9
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEDB1FE46E;
	Wed,  8 Jan 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVr9y2vK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5C19CCEC
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346622; cv=none; b=iuyO/BIYa3fAZhYrR+HPjASjpP4x5U/CMptLwD9R1irjiPbrArxTgZx8Jm3lo/qhA3Wdk1jBxratglLhzko3999JOnBUon88EaZHdSG5DJW61R9EUzXL4as1lbZuEBoGxX9riBR1MqfmSriluJBeps3b7cM4hrwopYkGm/H1Um0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346622; c=relaxed/simple;
	bh=RerMUU2iJNRvAH+P/WRIzJRF2OXWh6S/x0SNAoX8N2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2GaocQBDqQkilw+b+kNk6HNhe7ylk7Vjm5o2VBXFDP+fZt4QwkCHIznxy5ybDJN74/ODXc4675VdFetJLXI0HNA+KJGsVtZdujY/Il94AFU8IaJsEgUCrh37RcreO2ylUPKDQh06xjkHeYiZy3c1BULVGV8jvkOxZpDhDXMnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kVr9y2vK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e3621518so7934540f8f.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346618; x=1736951418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=kVr9y2vK41azp1jjKs336EQXN972UOu3AWQ13mfDpeHY3IvN6Ix22adcGpiXweytkV
         wynI1DYIvAlqgZFsme/a60xCTk6ZXB59+iit+FjrSt8aJDXX10w+sljCBt+424T9VyeQ
         YlHHVSrSjRJqptNHkDvulh6IJYQ2Qas6xD5IK8pg2qHJW+BfxC4I+2qRGgV4d9oFpD9N
         FWaVmWr9WPvXvFLp7fTOVlgI21dE8cRAxnMT5wtzaNNgV/QCUfVNk/+uzquNOagjzfne
         527k7s7BuvkMtdNf8HnqnqQWh2bTUq32B2w64ALXPsMD2NoSdu0J3aRuM/ajk1hyZBFw
         JUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346618; x=1736951418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=krE4s0TKdPN+SCdDmeb8D6uynH7zsmFtWO75F4ITSSRCLUsxBPIBhLh5QfalRb+Qlo
         Z2JncGAPfkubwuUd95g7ZYOJb8p6m1EAtqa4mIZCgFCOvUl+BQHwgjh+RNJ+wZzprxa6
         A4Oc3M6uui+/PIVyqsHYNcEmh6dAceb/mRSyAS7jn9m8ALGDCpP9SD823ZjtgwlL8f6y
         bgx2vBALZkzxt28y+xdO1Z02eyS1u7le7r5i01cSBEAqqEAPKtEW0oumwYZn56H0TGdF
         Z2EEG7L42vvUjPNWrcqK3V6FjZCXseCC44IU8ExRLINbapbD6t+ssRgILRKWT+tYDHbp
         7SQw==
X-Forwarded-Encrypted: i=1; AJvYcCV2olJpBzjFvsterIkHdgDvr4FB6/C8Z5QE3N2KergVsBuIwBh86Me1/0a3c0tWcJZ7MWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1kxoZq/mgG21jZSuPTZKxhfJr6gq6fYqsQiepnLAoEbuGIVw
	hQLypjpvCa9FUsqcL7BJcd/vaFWOEZbtQlLJ+EuNSwhQrr4LwPkHo14gwadDNJ0=
X-Gm-Gg: ASbGncvxep0k2EUs/FCXLNXtj3nvLjRsk5pzqaAqH3tU0d9mIFn8Ox/z9i/nmz70TrX
	b0KcLyHzhefZ9jp91NyRx9MPMj6f0JXs/As5DWJbOjMLWLA4llRWiVHWBu6FjS5E3W947q81Wyk
	livASfwnJdjDPv2Wf4+vXhLo+DU7O8wjsEyA5pe6h6s1cp0yD+BZpUoA3zKMN9GdNOVeQH/3ZzR
	A2NRjFrZCo0cO52MyBAopW50z5jljsZIMK0lijiVtJyJK0RxhLf5bar
X-Google-Smtp-Source: AGHT+IERlWXqo2ZT7VqdO/os7iGNqhnAktOupf4yL+hZB/qbP2byYeljw2KjaDqnGgNolCaFP0shlw==
X-Received: by 2002:a05:6000:712:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38a87306e8bmr2608823f8f.21.1736346618097;
        Wed, 08 Jan 2025 06:30:18 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:17 -0800 (PST)
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
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 2/5] perf docs: arm_spe: Document new discard mode
Date: Wed,  8 Jan 2025 14:28:57 +0000
Message-Id: <20250108142904.401139-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the flag along with PMU events to hint what it's used for and
give an example with other useful options to get minimal output.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index de2b0b479249..37afade4f1b2 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
   store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
+  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
@@ -220,6 +221,31 @@ Common errors
 
    Increase sampling interval (see above)
 
+PMU events
+~~~~~~~~~~
+
+SPE has events that can be counted on core PMUs. These are prefixed with
+SAMPLE_, for example SAMPLE_POP, SAMPLE_FEED, SAMPLE_COLLISION and
+SAMPLE_FEED_BR.
+
+These events will only count when an SPE event is running on the same core that
+the PMU event is opened on, otherwise they read as 0. There are various ways to
+ensure that the PMU event and SPE event are scheduled together depending on the
+way the event is opened. For example opening both events as per-process events
+on the same process, although it's not guaranteed that the PMU event is enabled
+first when context switching. For that reason it may be better to open the PMU
+event as a systemwide event and then open SPE on the process of interest.
+
+Discard mode
+~~~~~~~~~~~~
+
+SPE related (SAMPLE_* etc) core PMU events can be used without the overhead of
+collecting sample data if discard mode is supported (optional from Armv8.6).
+First run a system wide SPE session (or on the core of interest) using options
+to minimize output. Then run perf stat:
+
+  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
+  perf stat -e SAMPLE_FEED_LD
 
 SEE ALSO
 --------
-- 
2.34.1


