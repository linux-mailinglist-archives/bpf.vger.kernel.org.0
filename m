Return-Path: <bpf+bounces-59986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4120AD0B62
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 08:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96103188FA8E
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 06:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E431C5F30;
	Sat,  7 Jun 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAEfyFTW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6551367
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749276795; cv=none; b=tBZtWCSkDoa0a6fWoXfry8eKkSENs8lGJzU/59NkzwZ/nboJUY6PgWDlM70CeiKy/ZzcRphD6BerimWiJ9u4P5djIPisjkUi5qo+F3VqsPGAEWR/33bF2gPSE6rkzqiCuWyp8Fa0rg7hHnX8ISS368pL2sXmRe/bhudEYLfNtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749276795; c=relaxed/simple;
	bh=SfzCslTg7FUskHtU5qkqJT8Z1pqMrqj5+kjaJG91nS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=p1K5dXpHreVy+HDI0AGKIxnBQvH0U9hWanOn/VVATHJdzXZmImyO5LQkECbobFCPnN9Pcry509tFjiVmrsJa9vtSHAJZLSo3YBBhTtaKk3fBzDozRu3sl+uwKrYjEKy/bSBA9o4HYGmjOEgTbW7PNcumH4Mdqnz9SkqvTnkNkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAEfyFTW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234dbbc4899so44839675ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749276793; x=1749881593; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=EAEfyFTW5ycJR/YNaQlihNhPHyXwRAjmavu70csiM07ZAEX655LA5Bd+JjGrFk3jC6
         OpkUw+HeiNfMKZ1Ip1bBi3PNf+gxfmu1ibjHD/8xlnRZ8199RVvi2PhQhZqLCTtoOkvi
         L3ISN9IEzFiJDYUbWxN65ODDXLlD9vErfOiEKPgZ9E8MNApLWKvprcWtiCBBcp9h74R7
         t0w97Wnsnxb0y11DggMKiUI5XUcw54twLupI51CDDA0W6gWc/06LSLLombTlO3S/B0ao
         yuz+eBVbs8Ry/Vjnv2xzwzZ7cnXaP/2xOEj58S68hnrBNDZm6j7Avm2NFaqNsckSHHy5
         irbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749276793; x=1749881593;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJD5E+0Fcbf3IjrC3jfxv5TUMepu7Kfa9Vz+4EtPR9o=;
        b=aM7LfkvGr1EBWNXh95mVa377SvLqgXeEYDt/0cwiEZRFP/qQIp3hLQywy9CiZ3bxlU
         mSeDEhQAextsXaU0hne1Kul6pZQmlJWoC7VeChex2I+rVkEQOe5VtfLe8h3dQ5Ii7BYm
         5VR4AgTDWiXXR6foUsS634bnrXvO1h9FYnUaIAXJvDNRu2F/rkBM/izHsMeWlQc2FVed
         fl4275QJrz+wFqZ7lpEP6nJPHMCsZcB2Zvr1fK12T7avPjy9mpY5vSij9VXZJSiHTgH/
         L+cHrxkabo+BweKy4C7g2M8i1nmEZ2XP9OzUWbWpEzP0AtpahcCZ0h5iopxcCVf3UQ2H
         /wRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3LWmgFaVrxI3WFKdxwfGrNyCGhJE2ZrVZfh/KgTdwu609IZPyPM+tnAIgI6e9BwKzMSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv188utZijCkNbELV+Y3WGs5ndoeHCicMMYbtvteiRU397w9z
	8qdV2HrDyaadKd8u2g/EfvEcJUn1hjZTxmfX3MgxPogAHuVvIEsWbfWVykau6JzUcxbqAgcgBLg
	XP8SBGKxTVw==
X-Google-Smtp-Source: AGHT+IESG86lWsGrnXT531aY5QwFbMGojtb44hgC7bu7eDmJoYZRQjG61FmihcJMS90FqH1Z2wMc0nypTnrs
X-Received: from pga1.prod.google.com ([2002:a05:6a02:4f81:b0:b2f:5c37:666b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f711:b0:235:e757:ebd1
 with SMTP id d9443c01a7336-23601d18701mr96634415ad.28.1749276793580; Fri, 06
 Jun 2025 23:13:13 -0700 (PDT)
Date: Fri,  6 Jun 2025 23:12:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250607061238.161756-1-irogers@google.com>
Subject: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pipe mode has no header and emits the data as if it were events. The
dumping of features was controlled by the --header/-I options which
makes little sense when they are events, normally traced when
dump_trace is true. Switch to making pipe feature events also be
traced with detail when other events are.

The attr event in pipe mode had no dumping, wire this up and use the
existing perf_event_attr fprintf support.

The header's bpf_prog_info or bpf_btf may be empty when written. If
they are empty just skip writing them to save space.

Ian Rogers (4):
  perf header: In pipe mode dump features without --header/-I
  perf header: Allow tracing of attr events
  perf header: Display message if BPF/BTF info is empty
  perf header: Don't write empty BPF/BTF info

 tools/perf/util/header.c | 46 ++++++++++++++++++++++++++--------------
 tools/perf/util/header.h |  1 +
 2 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


