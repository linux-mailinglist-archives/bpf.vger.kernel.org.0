Return-Path: <bpf+bounces-47115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0799F4A5B
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD537188F897
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DED1F03E9;
	Tue, 17 Dec 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpPYrL2S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A71EE031
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436583; cv=none; b=hFQLSOh24961Yk+amLlX4eFDp3JD3dsdfBsm89vqV2gsdG+nK6mDtod9T0Dzk+vAIAUaR9A1PRxDwdkDnxji6ReS20qZ82WnNf2J8VuJuN+FE6Ip3nKT8ZG+HDoHX5qvmvdoICpkz8C2BowohGpfdXrkxbL9aQ1QLn0saycjbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436583; c=relaxed/simple;
	bh=xgd7v6UkdXXhnxqHRbcrW3H/FnAaJmvtXDYoXwaj9no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvC5p0Xz6BPyrd55PbWr9AY8D1VxTdq8tpf7kFbv3r/piV3L/CwEX+/1zFD1nuEEG1+bTik/3U4vIBHKCewl05Pjtd+Ab1ezirq26wi6V7k861KKZepe38fykjNb5664DbmrKGhtVydyl3fsOAbX60ZFLTMbRzNXBOROo6vPvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CpPYrL2S; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso36003695e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436580; x=1735041380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqzWbv8Vx54w1pLkcBRkhMoXdOrWLUel0oeu9kIT208=;
        b=CpPYrL2S4Rj3KmRAqEaKt8Z5Se6vpY/rMZYpf1ONwEgNYNrzuRjFKtKwfHcL6mtBm2
         0Q6eFa3Cwn8wpGaZhp8gvxFnV4H7ccwmDnOnYPptEzaxnPpLmkDmey6r8s0v2BgrlGDU
         n3yUo0WLWabW3y85JhTUoGiIxz3DiW1dOU7cbi1D9Rvjjwi4BDCOZ/QEsm5XHGz+ixUb
         spW/xnIZxh/TXUr/uBxaB2rBDAoBFGry5QA+WCGyDeqygqiWx+52tT4BcTrs1AOu85Td
         3DNNrV15t/M2Gv4EdZbNBH/KA2rRRTOeOUlLQ5ErDHO96U5GdLSxeKGxZAVyn1yFHo3z
         ip8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436580; x=1735041380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqzWbv8Vx54w1pLkcBRkhMoXdOrWLUel0oeu9kIT208=;
        b=hjufHN8VSM1djPMLnBTqjdDQmKtB+EampSYbLdgwPK+cwxDAbGNf1CXIEoVOzXTrSo
         tQ03Id2dbPIOIkigbJIEZDPzOGM8DCnXmR36Gyr0yWnkSzUZhkTC2KX3QuJkCJOQE90e
         VfouwOKHO5EQnAylut+8HuczvnK6IrnVlV8e5S4kLvhTeGdIia3EJPkcSLuOUS/WKjnP
         GdrH/YeZxzcfN4cVVSWu9Tqxsls4XjKCaJ8pfuaBqD+5DcDvBQhEW0xfBu1OgRBt61Sr
         mMkqR7Ju1ay1R6VT05WvX4imnUsFnR1PGun3TU1f23Ylh2Qi/KNEN/d62Q2megxGgvou
         uxDg==
X-Forwarded-Encrypted: i=1; AJvYcCUah2k77HOtrpl2GTuaXw0q79NB4ePW9yR/zBVeSfR2fLkVLROvk3yomksWBM4rucNFRJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVMx7Dspee74VAqCUm6DlgYhzJNlb5RCWQGERguRF5bdcmhxp
	u0fCq4hDWlbzhZVheW/SW7LyALrt5dxUBTZku8PRdKC6h6f/17eQPdpA7+3BDB4=
X-Gm-Gg: ASbGncuDCW+iR17APiMQ9tigHGexz3K/JYVIWTEVLeSlDxUWYYbn9bgpzRcqGLyYS/l
	rKHbPSmE4BiZGQIpP2rcNuXzt7wkk/akX2JsreESutNfCVZJNcXXFBVnb4Mb9IHoViaETDS1r3/
	b8GHd2vj8hzxlm/cC3tDGb6NPzNS5Nci0jVtCTHkvaJdlXV22fLslv14g3gi2ZJJeihgYxX9eyQ
	Mbv4RId3XxCeh825f5+x5S/W/xBqJDt1mlDDX2OiZoGS6eoOFT+fe+X
X-Google-Smtp-Source: AGHT+IFjDZqkiyvwauk6XlCYDztdJprHg+FIrxmThEaEHO34WOG2PpkjDIx179eIda/PttDeXCiW5g==
X-Received: by 2002:a05:600c:384c:b0:434:f871:1b97 with SMTP id 5b1f17b1804b1-4362aaa23d2mr133318405e9.33.1734436580421;
        Tue, 17 Dec 2024 03:56:20 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:20 -0800 (PST)
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
Subject: [PATCH 0/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 17 Dec 2024 11:56:03 +0000
Message-Id: <20241217115610.371755-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard mode is a way to enable SPE related PMU events without the
overhead of recording any data. Add a format option, tests and docs for
it.

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

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode
  perf docs: arm_spe: Document new discard mode

 drivers/perf/arm_spe_pmu.c                | 23 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 11 +++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 122 insertions(+), 32 deletions(-)

-- 
2.34.1


