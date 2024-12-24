Return-Path: <bpf+bounces-47587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE79FBCB2
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579081882ED0
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49441BDA8F;
	Tue, 24 Dec 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ+CAZR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F6193409
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037078; cv=none; b=btat2j08phzeViT1Oz5hH6votbR5zeAvBD4HmK+IR0sJX68sKw1XNUZONLBxdrEyivvywp3vrbpX+W48EnWJLd+ZkPZHN5RYaFqccq612FAwCzdQZiBT1iN2yA8V5blfcxdrT/wC4UK9QCDCsq9xdk6o1sRMkWCWOHPj5PlmA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037078; c=relaxed/simple;
	bh=jAyEF1XgXNFKM8eyzKIrWDhYrJjbY7DkOcBXnln8DjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvT3TrX4IRpyWlzPP3qwXVdI2o7KAvDCp7MAEIQr8SkrOfW60EOKJaJsFQ1bMSVEzcovnbnXTf+vLdvVFOg/Q8CoTgzFZr5dsTDkx8Bn9DXOm4amGj0R0YpTMSSUy8SFpOjjo2+sy5qZxshaGYaeri5HzO+AhinDNoRFGeBssiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ+CAZR+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso3791772f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037074; x=1735641874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GC94EcAYbMBUjUIz25uAVNdsPCjZLYUODaiYVrPBPmU=;
        b=bQ+CAZR+LdHlxoj0cAcLpo8S+PLXR1DzMzn+bTbSzjzOZuaUMOx62tYE0IHZJ52OXA
         iQHQhrO/+ozA+byFQIi0Tmk8zDkUn/Px3q27ozgt1exORcPEYCFAsq5sCKWs9kydSuK7
         6MGkSpwe6/SpN9haktClIMlVdw2SE6Zt44tHLPDUKi5RV+2GB6zxi9aNMZnznpyv1Fu4
         hfcWe6TdyezoYbXJIzj4ftntKcMVvaXjUll1Zd2LR7wgppiYB3h5tKt5uzT8JUYCe99F
         X1dCR+qGyuv+1Xs9dW4SmXLfNHA4pxtmahhCYwkjunj+PePzq/lvznOHY3hya3h01h59
         pTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037074; x=1735641874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC94EcAYbMBUjUIz25uAVNdsPCjZLYUODaiYVrPBPmU=;
        b=c1V0DI3PnmR0sUI37WkXTrJN4VEM4JUvIPZ4b7UjYM5K9DpMSyXld+dPENfS/wdQnP
         yDj7K6+DNl8c0T8FtCk+ZaMPkhWrzy8fKyZP6pRv0WleEgeb/7epyjSrCMvAgQ1k11wW
         urRzjPXQPmbpfPmPFW6dn/MOvyVOq3VzzLRdwJOnNU/7y/mJkSm2zOcy1HaaScql2TJV
         ZI1iKpLsGoAjIzlwlNrK4U7h9gD62qHbFMu1yJgJYzA7FWiaaWcrpfaLcN2ckvTsQImr
         fEhj5tod4j/qG3NVuuylUCiRQvqo0mVLeSu11IWUlFk4yxUeTdzucakx9/4lN+5x9yZ+
         CiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAPuNw3XfRBTtkhUMUCqj5CmiIPJn0mVJV8MQRklvzpNAUufOjJpvhpywavDgbVNCiU6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXgkRUMqnrIMrv0MI9Pc6lax2EN2YwFhxnm7N1ye/sVSQ+jSk
	rUh6NxIlvkVONVO5OC6MvpcClgpAXJB92bWnemkjM8VSuWPQ7bfaAtvUR0vjWCo=
X-Gm-Gg: ASbGncvk78bUcXk2zOxHDMOHJcLB4FpLKqa15GL6y+k2mbMclXndCfyYcvdZI1R+OzU
	lUcUJC7a3aXAxr5liGK09ea+GByUopDalbkx5aZzVv1nVHUbsDpKsRnfl+Iq4Lwk+cFN3dMZ2/V
	rp2/MYWlYBeFa7gy3cNyhjWZNSO8Cw2JDSub016Z/F9ewBhyWgtNZqNG/6tlwS+oN9er1QqrGI4
	8gKZ3HrA5ep7r6nMR0SSmYZENkWFryi/ZE2rNFTa9AB9uK3UDJXOzY=
X-Google-Smtp-Source: AGHT+IGsMgTuO0pGQvcVI5qARtXeuTRPJmGG/qKyW3MAU5lGxMoG/jQVQ07m+joXnw4orY88L8Fh8Q==
X-Received: by 2002:a5d:64eb:0:b0:385:fb8d:865b with SMTP id ffacd0b85a97d-38a223ff5bbmr15275872f8f.48.1735037073679;
        Tue, 24 Dec 2024 02:44:33 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:33 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 24 Dec 2024 10:44:07 +0000
Message-Id: <20241224104414.179365-1-james.clark@linaro.org>
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

Changes since v1:
  * Add a new section and some clarifications about the PMU events to
    the docs. (Ian)

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode
  perf docs: arm_spe: Document new discard mode

 drivers/perf/arm_spe_pmu.c                | 23 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 137 insertions(+), 32 deletions(-)

-- 
2.34.1


