Return-Path: <bpf+bounces-30072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79038CA589
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7443C280F42
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7A8836;
	Tue, 21 May 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clp322AP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0312E71
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253493; cv=none; b=uCtOsNhQTB1lxRtFLmz1VyEG/NWkoH8B1r1oN/VY72ulWTb/LHSySwFQgpsF6oF/m55P/tVhUDAmdzbW8LHLilFMmopksZaRzM7wHk5xkg5ZQNiTrt7+TEQD/k2JMUFGPdTPa2B5RGlEP6xdeAtGQ3VtvJvu7gKzoer1Ngow4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253493; c=relaxed/simple;
	bh=HnZOyTLA1z7HGjFiTaimfVCHoyCYiv6gxIK1l/WLd9c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=bh/CUognetbl1yIF/N2PDqBxGIHj3IgQ37Ts+3VT0FC5yTUyidXphO+Qsh1l2ANwDdfLhMvooHUJ/6vWZLgk5COK0Y1BNaUlcZTQUMwvOwUYqs/kvDfH3fnWmzx68Jm3hWyVIinRXZGmKmTQaS+r7nCFOl/FZNPEJmPC5qW3bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clp322AP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b028ae5easo188705787b3.3
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253491; x=1716858291; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=clp322APGH01SehhXEomMqOXDsUBlV6LzkR909b/LG8TnlVmQEEo0d/q4XoQV/UcRd
         NI6q9shi93Gg4LvAfTMCTlGnZjdej2Y3WUbP6vEbJ0Twq7mnkfJs0c2MdMWqBiqwTMy0
         YibS5OYcVH7V9qvruf7e5BmdjqNfTuytX9mDhfTNOo03vyiVcKDA6/ggKpJxzwAHpJhT
         9J2ItzI2Om2OR+/NFgsuFoBWxeAvvOEKJcylOYBatDtFBWOZeXtAHKRBn8CzBbVVVu37
         za0huhStK95cGnKTpVW5nYYK75uNLGswQOLfg0BjGDCoDE3tbwkhbZKcdBAamaxqLdiM
         y29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253491; x=1716858291;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=bbjMB2Y4cD7aWMTHcEHFaHzXthq7sEPwAhWaY9alrxuEyRQIPx3zVwxmYEFFoj9a19
         jrJ2Zhvpr+6eUr2a0vgOwMLaEjsa7jy+bgkCzbwYzQuAti1YKr09yYlTtbdoK86aP1Mk
         Xn+1VzeTNtUuo1yxY7ROSLgldeM8g3uQ1G0HhtU03oC0KR5bTQ5SUUozsYKBMHB5BQWC
         LAfE7bEkuPgq2htWK3ihgJFb6Irhlj5rrTxyycy9byNlk93z48Da4F2o0rKiWYZHuK7/
         +mAknHtGXBpowLPB1J4/4g8E66jPNpw7pGp16ko+W8HeCdpZn+nquIhHJkvJKkBZglvM
         RKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4pYb9tuzAo1FaImphsN1Pi1F81eg6GhjLR02OhIiDljoosO5N/3Ygd5jhta5OeZLyjuJD7XvmBF8cJvPtNtUdTg0a
X-Gm-Message-State: AOJu0YyluzhCM4X2OZRO/uF+QsNrsvRrUAhjhn2BJnsGW4sr/thRmTXW
	3h7Uydwk0hBXDw+czyTFQ8XGizPN0ZtzXW2+e+fLkKuO85pmdhZaQYV4nQYsmXXOSUrN1rseeuC
	Qdc5NIA==
X-Google-Smtp-Source: AGHT+IH3laioA2ReSfTb001L3Np4E6P0YRTj77ACLXkl114QIRHb+vY7xJeursyPnrL6W1q5Bah5nKB5u06g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8b:b0:dc7:7ce9:fb4d with SMTP id
 3f1490d57ef6-dee4f322140mr7251230276.12.1716253491136; Mon, 20 May 2024
 18:04:51 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:36 -0700
Message-Id: <20240521010439.321264-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 ++++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 ++++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 ++-
 tools/perf/util/bpf_skel/sample-filter.h     | 61 +++++++++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 54 +++++++++++-----
 9 files changed, 171 insertions(+), 70 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


