Return-Path: <bpf+bounces-47120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0A9F4A6B
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B20D16F15D
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F91F472F;
	Tue, 17 Dec 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmrD2b/b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A401F4289
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436604; cv=none; b=HMfn3wXMs2cVRgDsD6oftFTBoHl4+WN2/t2Qjld23NSZ4LFOLF24AxpbmDHneC/2KcrJaNBJL9dwPAHeRv60JRagSwHmkmHPqYS9Team4g7IyR2aHmSFjov0UKuCVY4Rl5bN90vAJ0ThxMi3tVO/wi2phPfUFjFK4pWK8uNE0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436604; c=relaxed/simple;
	bh=fyI0/dhbkFxqKd8iWh2Jzy9mpwkSrgNFZ+i9alPd06w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg5xfIBmwcf2IUo/o5gJ/fE1SKX5HHFjEGaFHJdg1qDkAGN4hZRqVG0XNosxUBsDK/kNuxN//DC2rjFnvj70HqbdiVWhV8tRtA7Rs2xjuuGh0knPE70yMGuqGGuG28SwbyKR/FOOLII1B2yZISk4U2mVg0pAuGYy4fDl0+agCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmrD2b/b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso32288775e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 03:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436601; x=1735041401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFM1q7jsB7Su3lAVmgr0rlaLhCHhfoFOEst7jXnFLG4=;
        b=WmrD2b/ble34C9MwCDKzGxVg0vFLBUyrDuJVfLLw1rqm1qyUXqWiR4eOZbNAk1BNVb
         w4Jfgt14YAEDSRgePSBFuicKaAgUGvmJ9KwAjmlzoZcAyaMCeTIcWsakq8DZKghJYTTH
         RdTK+wh+fy0FLBLE1CNgxbjk/MuMoXFuOBFn+mGQMYKWiW1kkYesLDjNUohiIRRv42L3
         tEBnBEcZhdBHqtYPB2CqdsAuXKhNiySB36/XPUBHQ89xX+TnS84awpFdq5CEcJlr6M+X
         jGSfOJdqpWl7+gNYy60d/+FvDsWF+ezjMtjKNRe8YzoCgnw5JWBID5d1O+20jG16Uw+B
         YZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436601; x=1735041401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFM1q7jsB7Su3lAVmgr0rlaLhCHhfoFOEst7jXnFLG4=;
        b=N7EuKvVF4Ta6lIyfAp6vZVNfPMbH5n2PRxdlusEFuSe4aLRzH6EzoHOaWe8XJeov6y
         m1BPFMeH12Cp8eVddUe5WtNH7cCi96N+vkqt5MqSLHLTM9H9q87/Hf425LsV9jT0RlOQ
         cjCljgG9X4GFGdYcVoqZUksTbWTMbCBx9W3SkjN1TkyC9UDe4WLmw8/RQjDCjBvQnSCU
         03JUcq8xSNqd0qjmA9n5vliXIFvZXIEtQBgg8vNfk8FmBINv0jKDB6tNitkNs6jSJzKn
         TeexCwCET8U/KcVjUloGgm2Jx2bxe2JsHpad6c/xONWcOgl3sAjdciM4H2Z82h4u+bBu
         9Q0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb+pP1iNed77zDVGpimI8Nt21ADyDGqqRm9Te3gtQBOesND6dADIYPumTqZ/1Zh0LaOfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTQFUG/uun1qhI83KXx2C7xfZkXirMpkR16iHUm09XQ1Ji2hD
	/iWbNAJcrHD/d2xQZ9C+42n1Uji0KkPEw362NyOvRF0GI+AU41pai2KfpAch/ps=
X-Gm-Gg: ASbGnctcay1M0xW6PoCFvu9cV+97iHzBg21fj0iCwZMbtUBFzrFIUdRHnS15BdMWhb5
	P3UfGgfJQY4PGT5W/EaDbwVWY8IUhMwGXQ6sD+d8kutHj76Y1mdV5feYEx7rTfjsm9cyEGEupf8
	1qHpaZIGAH3/2Ne0G7+E6ktGd4pK+VzOtzChVIyiDUyB5TilElQOpTcO3l4Xn0j5+m1fLgwZvct
	sO6A9TI1gpmip766PRmxFvYFO8qWW/jJF3LnuhSktjSUdxlVF2MdyNa
X-Google-Smtp-Source: AGHT+IGHK04q5y+mpaaNrdicK1T9ozCfgAnXqS1cmz3u3H1E5qAKa1r9yR6aB/fLQM8NPU3JxtkxJw==
X-Received: by 2002:a05:600c:3516:b0:436:1b77:b5aa with SMTP id 5b1f17b1804b1-4364815c7d6mr27745645e9.8.1734436601097;
        Tue, 17 Dec 2024 03:56:41 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:40 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
Date: Tue, 17 Dec 2024 11:56:08 +0000
Message-Id: <20241217115610.371755-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the flag, hint what it's used for and give an example with
other useful options to get minimal output.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index de2b0b479249..588eead438bc 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
   store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
+  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
@@ -220,6 +221,16 @@ Common errors
 
    Increase sampling interval (see above)
 
+Discard mode
+~~~~~~~~~~~~
+
+SPE PMU events can be used without the overhead of collecting sample data if
+discard mode is supported (optional from Armv8.6). First run a system wide SPE
+session (or on the core of interest) using options to minimize output. Then run
+perf stat:
+
+  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
+  perf stat -e SAMPLE_FEED_LD
 
 SEE ALSO
 --------
-- 
2.34.1


