Return-Path: <bpf+bounces-47592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306F9FBCC3
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245D4162EAE
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB001D9A6F;
	Tue, 24 Dec 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoVoOiWU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1B1D90D9
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037095; cv=none; b=t1rhth4deVfPef5l2I8XPOcK8ZMWFCOYLwhA+fd/pfPdGZgE/k7OfDa8NL0Pmh6dyqKQpVOs+3KJLOL3bGlCn6dy1AgNMtY6AwgsrEwpvPcz+8dCVNSYBocKtg5lu0SBg5P2fbwT+POZzGfFkWgEgDFBGdIEVIRbRgtBHG3lUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037095; c=relaxed/simple;
	bh=RerMUU2iJNRvAH+P/WRIzJRF2OXWh6S/x0SNAoX8N2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tm2j8vzwU+2KgSTyZGMLp+2NE+CQTKh3lb2gHvzrCe5KK0xQ2XNyDY5b99Pq0ux0E4LaHDoz4tlihpmgbZ51ZocI01WqlRcY/CS9oqsWoxxrjYFCYPEoI1LuPoiQW/Fb5ANEshCfMSwSd5BAtbwClpdwIeCNpokCbU8p1ALY9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JoVoOiWU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385de59c1a0so2998073f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037093; x=1735641893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=JoVoOiWU+LTn+LzaphtbuB4Uy4oRwIAX12TYoxTIyc99OcRv0k1xpgCYbeGRUQukqO
         9BC0T/W69NXtBNB8oxSdTsUYaMqVBU/eIwjInM/SutQGRFGmEYuO0/Pn00AisA5/bna9
         b8hz7lX+wYeObujE3ZP2+HMLlLXlaNzqVk5MKhsUTSVXm8B+ilfBmX3M6ZO9N8nrxAdz
         MW6B+BwJCdndxPaFQ3Q1hYTc6nrxeKtIssYKApNQGxpN6mB9rQfojH1X7grvoEeh7EkF
         tpKo4esC7tqLroFw4E13Dz26NWZQ7MmKiwa7hJ94zkun6Iq7mzP3Hxlw0VKKUrSVIBRx
         h6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037093; x=1735641893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwyNoR0SnuVGySQmrh3vEyVb1ET66P1aG6x3YnivKGw=;
        b=FCcbp4SAUmXZ17JPKfPxMtblhi/BVISByvIBesP4B9dkI760Il5MKv/yV0JI25s+k6
         q4wDd50Bq6IbwTQlLttaiGRRZ+gAFxyDbAcP8R+VxvdX9gB2Yfpon51c0/TuVXgCqXN/
         C47kucNCQN6wBSXnwIIETKk7m50HFimc+AfbmWx6XFrH0nrbsybtf/r9sQZ92TFoRLqU
         3LUJwwN2iT4HDO2v/qYPdUGmXiyjQdW3mKgI/jOoTWXKpu9nG9Is4egoKmNrelJXjntz
         XYwVyCVN78ePjShRGiHOigyCGSapCZ1AixfqxBXKHQFox5o6l2UJduesvVu/COPxF7PQ
         ua1g==
X-Forwarded-Encrypted: i=1; AJvYcCUcmXbGl2nfpgNX8o7ExypMR7p1DqZO8RPXV4IdcW6N3f5pSfPCD8c6oEdD+A5bs5GbVIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwU6vyeAOKsURt4fnxma2Nfi5T16Ipc8kz2ORHTsLQhmVF9uMc
	bYtu+Rj5l4cWycBtLuOmo/1zVu0EIAgPVfHO7m9FDnD4VSQ32+NSjuoPzimMmfY=
X-Gm-Gg: ASbGncu2gwhOxU4vlV8JOV6t5C5Vy4HGaycdlFmPkNE3RJGSgcmjotwkzwd3bzXbPDa
	sTZ4OaTK2FfQB+ysfMxu1vAch0zV7B67nAOncXkrBpbqJgDAjBJc0wZSZdrEdo2C2enj5hWZ+B7
	eN1Ao60Kdflvv/KbHRUW8IwT/fMROwi1aZiaeGLoqNUQYX+hBmZIH3KnWmbKaIbxw623XYQvNHp
	1FDw83TNyEZPeVnQ0uNbfW2H83MdzREoKjmzXeAq0i4JnnpQmu+Afg=
X-Google-Smtp-Source: AGHT+IEHX62hM4cRXueG3YQu6eg84405e7WqgYcT9lFPGrHLB17v7HhSKT3GSKfbXrWS+gmH7kk2Dw==
X-Received: by 2002:a05:6000:794:b0:385:e013:b842 with SMTP id ffacd0b85a97d-38a221ea331mr12569563f8f.14.1735037092689;
        Tue, 24 Dec 2024 02:44:52 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:52 -0800 (PST)
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
Subject: [PATCH v2 5/5] perf docs: arm_spe: Document new discard mode
Date: Tue, 24 Dec 2024 10:44:12 +0000
Message-Id: <20241224104414.179365-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
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


