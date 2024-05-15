Return-Path: <bpf+bounces-29798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EEA8C6CE3
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B73B20F7E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A015ADA6;
	Wed, 15 May 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymxpliUj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81803C466
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801782; cv=none; b=SLjig83zUBqnokdKUQU4IJ0TfgDHztgo/IF6u6bOY64WOGr1DSEwg1FZ53aHXfWG+84BE3e4YBmHp/guHv6Yk/42597vBszqIMwu0epu9RTKLwA0wrcLab7XPluzANVeJjso8qIJI9EENV9OhXMhq2/USfYFnInZVOYvr1VotEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801782; c=relaxed/simple;
	bh=rNcKdHemTqXp/jWokR6p4S2Gh19u1eDcI/Wkq5LI0TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VUO46BiON6WG3iqamjeyVvwGc7xEfJ6j9ZYD9qNPReHVFFwzjjO/aj2AZ93PHLzn61ze+GmuJpQakt9HTZpKEYiBR5r8nlsOWhx0UdB0veEFflckAHujC2+Nv+/KahRCb1a9S2xMqk4C0eWo59GTee5o0IIzw0YemJquyqvomyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymxpliUj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bed763956so135114017b3.3
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801780; x=1716406580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=ymxpliUjau7tW/aFRnwLgbrFs8PjXmfpKYZDfIeE0ucSmv1YpIaaXAiL1kNxao/hag
         NNZfL3pQ8KP8DpGDiF0yChRSHXMVcBBN6iwTdA6YJjHIiJvF7eR3UD5IDUY9v1Ld5H+9
         EuNCBQz3xuKuOtBBBaoECw5Zcf9a6CEBH+ZJQmWX5hYGaW5ER684OQ9BZni3/d7WPzOb
         gY/u2DsMWqhAcfFu6Lt+MFM9ilealcz2kw1b91tJau04V2ty+NOE6At5XeVKcXnB6R1o
         OCywm1TjzVdJOo+fw47vcJ4r0aEMbHuX53hX2vicVRaYY1P8MSpFG+k2vMq4TaN21Yw+
         T/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801780; x=1716406580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mo40hi9HkXQPI0hPSG3MjEbNa63l8uDo/3AAaoaXZs=;
        b=d/DFcR2VtEVyjWdTrivjAMbn3khcEyRm124Ac6PvCkyrceVXhsN6os4RjCYVjajy2G
         aLAVUAH79Sz5+w7LfAg1hCUhreGyalhgp0wELhih2dfkBb2FwEHgvm/28yCmhBlfximn
         m19fnrphAFkNIC+EC5txa76WGt33cGPLNn3juYAbI/mrhYPMKUhr0PLgcAJ44dh2eK3q
         I2eP0Pu78v8+z92ZW+SlE6Eu4YkRFLlif8JLpXodTI/R8UhsZ1ShKUCSuH3Geljeo9kR
         NFlucKGQ4LPuGTqBg0ooc1pZK/tW2zbMmXMSYRGJBGuJAaMtq92BaUQF94yFJwdlOcBY
         cB0w==
X-Forwarded-Encrypted: i=1; AJvYcCX9YeueFZ7MAENsWg0xjYVNUIcj6pMND7XOm5jhV+LDD8RJxA5WW8rztmGu3YGZLuw5B8gw4sMKmpDRthiVAWiVOlP4
X-Gm-Message-State: AOJu0YzzDfB9qQZQSRR512s4iUIiNc+3aQ6STcrjovVGceVwzUGNrSFH
	zSMRM8XMm3igwQglVehVFQ8N5NUHj//U0d5j58PUniR4uMhtJ6pA9rl4C/qW8nBnCk5P3O7MQP5
	D
X-Google-Smtp-Source: AGHT+IH0DGxH7FiS9IKB53lZ/iJkOvC68dQQh6DPRikcqpIYM9vqeJtrXJMVdVoglnHDpQsEeY8eJHhrmho=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr46339907b3.2.1715801779694; Wed, 15 May 2024
 12:36:19 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-1-yabinc@google.com>
Subject: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
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
checking event->attr.sample_type, which may result in unused space
allocated in sample records. To prevent this from happening, this patchset
enforces checking sample_type of an event in these helper functions.

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

Changes since v4:
 - Give a warning if data->sample_flags is already set when calling the
   helper functions.

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
 include/linux/perf_event.h         | 26 +++++++++++++++++-----
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 10 files changed, 55 insertions(+), 43 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


