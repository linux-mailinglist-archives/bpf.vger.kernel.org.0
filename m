Return-Path: <bpf+bounces-68340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF4B56B26
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB1D3BBF17
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED32E9EC6;
	Sun, 14 Sep 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6gCMLKU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063A2E8E07
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873528; cv=none; b=j9YIdFF2yMpoQyMIr8UrgRD7ExulIC9DvNknOUIn+CNsF37MBlRZOrMmuLzjQgjWM8UAOvr4oepmebmX/NAa3rVdw4T+sMtO+QRDfhgIEkzY7N2MWcpBZVqWM7n+8eZwZVRo54SPyMuKDm/ZC5ih7IlzHGREFYjmiDHVKNvjubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873528; c=relaxed/simple;
	bh=/lWVvuqK7ZPO8OlTvbP03ml/m9hkltI7r5Lnp5abMlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SCmdJCYEMirkRKSdKIMV7sYXxKXD2AQFI+QH3GgFerKUiu1C50gZbMECjXdntWhtZajIOpVOw9OpmGBBJNJO/OgFV5ZXUZ+A5uGFup38xIXmjii2v6rkEejqP2xoYm68VOvdPJsYOgqkOamwhVI2RUX3dp+zVHUTchpGxFAjt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6gCMLKU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ced7cfa07so37543575ad.1
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873526; x=1758478326; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=W6gCMLKUf1Qdm0m8sZSIvC6nlStPHkMem3QGkMeeU/Jyn0BZIb+fvOMieAe2nP8Lct
         4i8YONekC7OySn9xo4aHCYd5t/D4MkOhXhqsZWnFMVHZIY0svCcsXj9XlYmgWeIRKklj
         uOaZVw37+qBD7I1Q+2ORHQwtzjoI1mn1JBqPs3sEE6jAKuMk90qf3Jyx2pNhzb3vbGcj
         PiKtjrre9fwcRdS2nJU20t3vC7mRWXnPcbg2Bj8Ot4ZLQmTuQ5wdI89Ehb+UR9nOGkPp
         VMSgY+aH56YJ8Pdqb73hmJSFhfCLDANoMsKmw2nIBPKe/sPs3mfsmftvc+sHRpn3HlDS
         e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873526; x=1758478326;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSFwqlAy6DXlbte7Dca09XDOUDeXcrwb6x4Txuv9Fo=;
        b=qdW9GncNjnop+MaK7//r+imetoi5a6vqP/W/C+RNgzrLnkIYPiyHFa1JDU6ZebN1gI
         16O5hmA5fy/tZVHwh3kdI1i4wZiya8yps1mjCsEJDw4CJcQPeyAkB3UpqnyAXo8F9+iB
         DjNkNHO1TSEiFhQkXPuPwvmlUmlnwzaIIscrOsw1ltGecs3o3MaAoy3ho/au+5zxDXv8
         6mtsRaCZjXnTIebbqDILuWRVc8E3HzJRlXeWOeb9Nfg6GIvHUjfrePaNIux8b1awq5TV
         YbVwKY2Be0oXKttrStXaPDhm3PqRJXlRelC1X0XYL+hfQbxWh9IDb0vBKZJH9OeaMT8z
         KPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw/0vk7ayw7Tk46N/UeTTUtFLCo+x1z5+3eEqEYA5Dc4RdI54peQ/5xGt9K6IwvnJsBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLp8VO9BqXivddPWumr+moWkyQgIjNy/dj3pxt+ceVoV/lZBpd
	R2hGronyMyyf5IKycLgbFMbz0gm47ua/4S7JvcdXOs/+VM/x4EYLorSyqeLNsUkD3A/c1QLy2Ow
	ybuNCY9Y8Tg==
X-Google-Smtp-Source: AGHT+IEEErKdREcN8hd/P7bK3uoM7X5PVPYZyYex0CAoLECSrtA99Rqt2eeKZc9BNuOL1rvt04CzwP6Ktni/
X-Received: from plsl15.prod.google.com ([2002:a17:903:244f:b0:25b:db75:cd39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1590:b0:24e:af92:70c2
 with SMTP id d9443c01a7336-25d24ea0302mr124377165ad.24.1757873526082; Sun, 14
 Sep 2025 11:12:06 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:21 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-22-irogers@google.com>
Subject: [PATCH v4 21/21] perf test: Make stat grep more robust
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

If no cycles event is found by grep don't fail the grep.
Tweak the reg-exp to allow cpu-cycles on ARM.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..45041827745d 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "cycles/[uH]*|  cycles[:uH]*  " -c || true)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.0.384.g4c02a37b29-goog


