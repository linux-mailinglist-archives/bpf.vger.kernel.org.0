Return-Path: <bpf+bounces-22705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A94862C86
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 19:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C591F21428
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9C18637;
	Sun, 25 Feb 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8yCu0fr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52D1B805
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887073; cv=none; b=IDXxUQBPJPiy2GpQIqtfxkiaWNltTOdTFupKJgZ3U7tmq6GqUyolPKI2v39qjmJfpg/ZNvAvSRRQx/67HBBJZAYW9sYMNuWk7Q4KvCLf1YwWABXoRNC1NKnpl/faosjnuyFguyMswpCHENwzqUGcScFyUFRCFG2/RIorpyLbjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887073; c=relaxed/simple;
	bh=GcjXzUspWJyHWnXifYzzK/sflMFCO8s+VX1t10MLqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YXpBAmCYNRfNpFBlZa2dCjv69fz5yK55cRn+kb/gH5Sfyi4OdCkF+m/lVWNhrwOe4A0dAOq8/Jte6d76RqryDkRbM7WnCfm9FH4VceB7fEGibXDoP3UUBhCpYgk5ljqRpHEtAUZDgvDkXTHhElo5vKoYu/JtXzXhWMSqC97NCJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8yCu0fr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc744f54d0so165655ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708887071; x=1709491871; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=d8yCu0frenTOD+F9N7YYvm6/YatnRt6BJy0ft7ukkD+ibLUjghcBSK8UCExwF2aPAw
         WsAPuRFtayq4z/IxkinNvNLzPXqybsNC6PDHn5AG0MqqS+1pnjbuyt6PV7rrozGSx87K
         wG5gotrtq/ei3kEX+RGgZKIDYxk/TzxpnAuWFRQTEtpgR62ODYg3GsMFh/gsXkBiLvfG
         0J92vH5gjIcUI7A25ooeI5QnLNWgMhCzBIt6ERmp+LcMpNXsXpD4Gg5UXz0/nMQspm7L
         mIvhAlmqBWu4QP9PFH1ZdhE+YQxFF5ZHyt3LPQDWi2NceL0AauNo+a9f/wL9YfUdOZIx
         neOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708887071; x=1709491871;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7KE24MU9eBDBjtTNbfc43uuaCFDb+3UMGms8jPvzDQ=;
        b=ScONxL7T9DUbKAB7CxhL9Ua/H/Aw7IGD36378LQuv8hPRy4GLLryyyuZabQ1Ix2yP3
         VBz5O0RkReQCtUuPPmFW2SoQfifgPXkb/o/faml9/J5+jg8Diwwkq/yvVbG/GBS7I/3C
         RtgIaC78psFgItwSNo1Qws52aq5mhhfmiBzmwLaG8FXU5dnnVY1/zZVBpXf6zMbNX2xW
         ECBSFQMTrRlvw1N7TlU4ZR2SYGXJFCXnaBtq6SoDo7Dzz9U+UT0zFXT394O2FXSvRi6/
         7aC8qHgaBJrYGucuja9fFLphqGdrOpp3JHhDXDQg5QTwfJYCc0lmo/oHbqVGLUWrc4kV
         w/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVeunWBTsEVZvoa1QNjevXxX/HAh/4urwItFVQa8Wqk3kpjmU85jkmC1VBxTjtt0ZNam9O1ST/DE7IFTn/ci+cpcdKW
X-Gm-Message-State: AOJu0Yz8zKKa9m5k0yILd4SsDNOqDo8UI1xoXmoGvWitxUbDQ4AtYIz0
	Qv5QpUFFsG0Jb3y9Y4HpWiySeHJthR6k0pR7mPx1O+eHOrtYG9A3aWrpqvihAhjrWASsNGlkrRf
	p5l/PO0pjsIvG4Q4an4R5ZogEFCxjtISZLoyG
X-Google-Smtp-Source: AGHT+IHlyeuRMm9XjLl4GPQEhwwJdCgz/3HCmZEfXLKbYFWdnA6DoDHqOg/2Z0w5L+na/YNYO5L72bfgxGPFrVwl8Sw=
X-Received: by 2002:a17:903:410c:b0:1db:90e9:43dd with SMTP id
 r12-20020a170903410c00b001db90e943ddmr237497pld.22.1708887070453; Sun, 25 Feb
 2024 10:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 25 Feb 2024 10:50:55 -0800
Message-ID: <CAP-5=fUhK9FaP4c5sSsM_DdNB+MipEvDDwO1e-n9fK5GLn87wA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Thread memory improvements and fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The next 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> now the initial maps fixes have landed:
> https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/
>
> Separate out and reimplement threads to use a hashmap for lower memory
> consumption and faster look up. The fixes a regression in memory usage
> where reference count checking switched to using non-invasive tree
> nodes.  Reduce threads default size by 32 times and improve locking
> discipline. Also, fix regressions where tids had become unordered to
> make `perf report --tasks` and `perf trace --summary` output easier to
> read.
>
> Ian Rogers (6):
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
>
>  tools/perf/builtin-report.c           | 203 ++++++++-------
>  tools/perf/builtin-trace.c            |  41 +--
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   8 +-
>  tools/perf/util/machine.c             | 344 +++++++-------------------
>  tools/perf/util/machine.h             |  30 +--
>  tools/perf/util/rb_resort.h           |   5 -
>  tools/perf/util/thread.c              |   2 +-
>  tools/perf/util/thread.h              |   6 -
>  tools/perf/util/threads.c             | 186 ++++++++++++++
>  tools/perf/util/threads.h             |  35 +++
>  11 files changed, 464 insertions(+), 397 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h

Arnaldo/Namhyung, anything outstanding that needs addressing in a v2?
I'm looking for reviewed-by/acked-by tags :-)

Thanks,
Ian

> --
> 2.43.0.687.g38aa6559b0-goog
>

