Return-Path: <bpf+bounces-29408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E888C1BB0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFF81C222FF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CD1C68D;
	Fri, 10 May 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6oP6eX2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE53179A7
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300683; cv=none; b=mgA79+r3vBpOympOeygA4aM3JdQ8CPAgRg2wlmFEXf+/PYZcF3NEuI6o2s4XQegvHq7WVsGDbTvNvu66bzbXuu91APY9Ct3f2B54WGfuhEbLhBAJi24fLFOeEUFtnxnZ0ZJjCRJ7n5nb99srRQmqR8orJ3K5qh/ZozMHEjdGE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300683; c=relaxed/simple;
	bh=EavCetVSCgCq8a1RaVsXoOaflK2PYWCs6cIGsY45SPs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PyvUB+xeZo/Pwm5KNks+tEuT9ibIGh1e1CT9JvFEZHVYUC+4jwxCdyT+22Tld6ADNc4kgrYJ2CjrjlB1l7Lnc6V2NT+AUYtCEeqkM5kAUqdry0oR7OMVj4zdF8mdHPAp61kiKyIhBZTMQEu9/DpjA7Q2sDwjINkn1n4zLk2qaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6oP6eX2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so24282177b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300681; x=1715905481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=Q6oP6eX2EIg9SP1I0c1rti1vPfhT1ZObGGUb1pfzKVkMS39ZugHbj+zCZzGU2pqKLp
         QIDQo3ODwrvmjaxT9hftZeLGvA+qfWYTnvFNzYTXmCKqe817XbG/5HcM1VswKYQin8R5
         qrmHmouRUiGyz6g3jIq0IpsKMidRf6i8ShKx+fIpVdqz0AoqnfdaN2jCNqgssErcjuUp
         ui8pas8lprR+rKq8F2xlFjy5TLVeYLj3zumCNz8JWN39TjoPuya2eIFXE9ZIseDwTSXv
         7TY/sCogBvsKnQ54qEVVHhbDlr5cejO8CQ5/A/AkrOyEpkWTU4139dCBPvv2OmBJtRJ4
         QpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300681; x=1715905481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eqm/BqIluFQHvpRuckwNPKwG5hWXwTVWnnYkmrJGUM=;
        b=dhATWGEvxAi+FC5Xx3MKA2lnrLZ2tOFa84bbuPMfmUL7P1hxUSJFtrr6Fkez/yMk7B
         /YjW7q/L1uT6SwYUayO1c/KB34LSfaa9KfNP6AOvb0opTQEH7XjRfF74nqzyZ1JPBPWd
         G+e80Ilptmx3lOKvOeZrUftkI+QaI/MJ2VWlVwoBrTGal+tz4D1LO9ATlgjbiqvLzKW6
         OjeqGBVYeFtlebwIcabwBGpKaa5poS2/UPPmCzAZIIU7R3wxRCVBMCRruIc+20ChIwvm
         UmbiJC/Mo/knj3pgOHBnOZir8DPdvFaXf7c8ydRDiO4sitHb0z7SjCKLb0moo5FfeHzB
         p6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU4hioY/ElktMuB3a2NyZRXrdlBIsaDgxzaK7wciqS8C3ACNgCovnGHR6Jzs/iVsJaB63jsZcUGu9seaUgC9hzFrIRY
X-Gm-Message-State: AOJu0YwsIwwwZjVTeFAr6QWVxNET9ufsPMtm10G+vUncTphJTHcOlKar
	btkMq0nnEAq+Z1jdd+V61IbOAJfbad/W8wiEJjEpqa30McZ7ndbqKL5HfoSNQmAUnCVQ2jYuU9g
	Y
X-Google-Smtp-Source: AGHT+IFLiYM8VZwRIj/wP+/duC96Rdf7O6hJav827B2VR01oQrpB/ASkm4qSwdbPKc+j1GRgZ4Sunld9v+0=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr295036276.9.1715300680883; Thu, 09 May 2024
 17:24:40 -0700 (PDT)
Date: Thu,  9 May 2024 17:24:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510002424.1277314-1-yabinc@google.com>
Subject: [PATCH v3 0/3] perf:core: Save raw sample data
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Original commit message from v1:
perf/core: Trim dyn_size if raw data is absent

Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf: core: Check sample_type in perf_sample_save_callchain
  perf: core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 10 +++++++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 44 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog


