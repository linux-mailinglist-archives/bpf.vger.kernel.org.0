Return-Path: <bpf+bounces-29513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4128C2A61
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38231C22173
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC5482EB;
	Fri, 10 May 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFlNaoYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99872770C
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368482; cv=none; b=QvxxFQUgQu7cvtJ4ExVnl1S8vYkGqPdsXOgpvhQT2CKWfU8dhbzsFCfgsmELP0GVoJlaBtnSqnvDOOX6yoXQlpTxV3kHKwi+fsDYWH9VqdrXJvL3pnsx7qoVf1lEGrKOqGHYKlpy1yZJigzmQFK0Ubvv7O2yuYjEdNNZJheq1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368482; c=relaxed/simple;
	bh=lM7Ffa7a34WiHH98qjX1e31MHrDcWjJyEDQyUEnhRS8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ppUhdN0wwpNWb2NTfN1VnYhy8lQMIgZQZGQUjVZTH1UPL7HFj0LJKCa/+bvUJyCRGAN8Hr20LRutC1L2kgENU/n/+e400w1QKtU0rPqE8gJUfW5A8aZYSH6MNIumCBRPJzYDr9e3fkQZMNDmdzXvqRSS5n0wWYIx8SwHtI6YGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFlNaoYV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so3883319276.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368479; x=1715973279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EylM3vFA7lZulI4V1G3R5cUfH0kthc6cGsP9Vyzx3vo=;
        b=XFlNaoYVzX9GjKEIbuq5Fy7cLywGJafcvsi6kKz8WNpklVpqdYtAGqbO7N4prS0sNF
         XT4jN1+sRE+cwCeEVllNgQ2l83OR6DFtFiirFfVig9DU/iqPll339FfWKhPL/BMlmFky
         ccskUr0N7ZHPkrl/ILuMx0WJ6VrCmpIVjDEh/+/M8pQB38gcDBsHPPbzGvbreqnu1tMN
         OlEgCZjxSbDRzcv8VRo91CN0RH/6POcJKkkdHvI31afQL0/doGUQN/pe7uIpqjsH++TI
         CpVCE96lXXbgfBXY4lRGrFe9D29yS0myaczzhUR3w9jJC/qOkBHBEeyhn1BWBZU8cE7v
         noPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368479; x=1715973279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EylM3vFA7lZulI4V1G3R5cUfH0kthc6cGsP9Vyzx3vo=;
        b=Pk9tYPI5NssQysgKVMjbPeii1kcCX0SWbbu6Ax1dDuO+6xM9UOB74sBif3aWxmPiGV
         yM3AbS9H2YGSzS6dQ8DWoKMWANai8lRAIHb8cnCMmZIA/mzTuYIjTztuC8oevjyjqSqZ
         K1ECfVpxJ28IqihG+C18CnPQWmQvHnYfSZK8kHg5uH0/dZNW80/P0i+zTCiT4y2ZCDV8
         ZPuO+6An27BhhBK5+c84F1uoIcy6V4DHQbGy+R2oTjDVONM7Zyk1nfOIvinjosaPj7v1
         a9KmMP4BEhabg9SNS7NPiIQHBrWbzw6WZSp4Hr5XdTRiiZW0ktrScT5aRyZRnrpBJmMZ
         sduA==
X-Forwarded-Encrypted: i=1; AJvYcCWKpeOI/riUVmVB3jC8apjrURnLDxxPZyjZ830VDM/msAOTd7nyaCdLx+qLESbQEQ4qmCAVx37nwtS/HMFk4242y+Q9
X-Gm-Message-State: AOJu0YyLGmdkK2XWxHcqK2bazmg+kBhwH4cvTLkLuW2yVwgMWv+LhZ7F
	dPO/H1KYxWqO8A96RWFqEkw1x7xsXTX2pG4bDGFVv0L/L8be6C//h1ZxwVHccjHZbT9OJ4aGISU
	A
X-Google-Smtp-Source: AGHT+IFayfrPaX7uaHZYOl6bplU+LYQx3Ktr5lITHr1i7FA2htt6wI5T6hzwgjkNUc0yOZw0xjOlsYU+OnQ=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:d3a5:c745:caa1:83ed])
 (user=yabinc job=sendgmr) by 2002:a05:6902:110e:b0:dcc:f01f:65e1 with SMTP id
 3f1490d57ef6-dee4f506107mr928748276.8.1715368478676; Fri, 10 May 2024
 12:14:38 -0700 (PDT)
Date: Fri, 10 May 2024 12:14:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510191423.2297538-1-yabinc@google.com>
Subject: [PATCH v4 0/3] perf/core: Check sample_type in sample data saving
 helper functions
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We use helper functions to save raw data, callchain and branch stack in
perf_sample_data. These functions update perf_sample_data->dyn_size without
checking event->attr.sample_type, which may result in unused space allocated in
sample records. To prevent this from happening, this patchset enforces checking
sample_type of an event in these helper functions.

Thanks,
Yabin


Changes since v1:
 - Check event->attr.sample_type & PERF_SAMPLE_RAW before
   calling perf_sample_save_raw_data().
 - Subject has been changed to reflect the change of solution.

Changes since v2:
 - Move sample_type check into perf_sample_save_raw_data().
 - (New patch) Move sample_type check into perf_sample_save_callchain().
 - (New patch) Move sample_type check into perf_sample_save_brstack().

Changes since v3:
 - Fix -Werror=implicit-function-declaration by moving has_branch_stack().

Original commit message from v1:
  perf/core: Trim dyn_size if raw data is absent

Original commit message from v2/v3:
  perf/core: Save raw sample data conditionally based on sample type

Yabin Cui (3):
  perf/core: Save raw sample data conditionally based on sample type
  perf/core: Check sample_type in perf_sample_save_callchain
  perf/core: Check sample_type in perf_sample_save_brstack

 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/core.c         |  3 +--
 arch/x86/events/amd/ibs.c          |  5 ++---
 arch/x86/events/core.c             |  3 +--
 arch/x86/events/intel/ds.c         |  9 +++-----
 include/linux/perf_event.h         | 20 ++++++++++++-----
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 49 insertions(+), 43 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog


