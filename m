Return-Path: <bpf+bounces-78260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A5D067C6
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23DDA3026ACC
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5633AD9E;
	Thu,  8 Jan 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuML2+Cz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A732F740
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913001; cv=none; b=t6TsDH7VJ5+d3x9jU6CChK5Veg5iUe/XN1EDujHzUYWK0qMG0MHBe18zZx2paQ/rf8wdlBv8fmGZs9CANqovD1logwj8f/0dDKDNXwJPuBOv4r2LwAiUgdO+6PoSMuYf2P1qLLyuXj3tqWcWoZUnTPi/kfKkD+eXJnaglvZqhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913001; c=relaxed/simple;
	bh=F5rLUx30ihLzNCsKKK+9lJkThou5C7DJgWMvbfY/DVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nmpVHd+rxd1NMeYhBvF33kc1UViJPrPpTyLfjQHPc68uRMFxw1MKtxFQ3IuQaI30ZLTdKVdXwETROhibipGZlYfENV0AQ0Otqn0hntCisHYhruQinNZsGMmagq1BM10tygQ/EaxLzw5gnLueiEPOabv2TulWhvPIzxDZYEWYg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuML2+Cz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b048fc1656so4772786eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912999; x=1768517799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c2rtpYcP3DAOdbt732zx7+jr91irIrA8WZ/Xzq8bqJI=;
        b=nuML2+CzD8lZ59v+NlefqhkF62fgQVTjiCsFeX4C+04Q8OkeijSkXubPps9St/hUJL
         PdtqY4NKyzFDeffPq+OgkxVVBDIhgRElu57RCO0Q81IJahkjg0hyWu2lqeIcn4MvALpW
         I73O5vBe3Hwdk1gDISo5gPVBz+FcV8rJseyZZSvcmkh8gssRA11JhPbE331n91L3pn3N
         4SaponmL8zC7racmgAeKOIquQCHJWSSS8bzGGvRbOQatztvIyPKmSJFFQY9K7xY5Ruzj
         oKfCGq71t5evjS6AVWtTAPMwIH/PuODp8waf/iFMnm3BAr+E56xtx8yAezW8f36n52wv
         420g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912999; x=1768517799;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2rtpYcP3DAOdbt732zx7+jr91irIrA8WZ/Xzq8bqJI=;
        b=fxbxIROW6Xp/AMR6wvZAVFgxoZomDdPE2G4K/ywoSDoQGoAfgYfUu7aoqPBxGouNDB
         BGY7LtBybMeeuzaJYTFt/6XKCfKFNwgEhiPxDCjcSrq7xVbdrinr1x362L6W/xDjnyeI
         R+6FVkFzl6h0mzJEjlrb6F5byLrKzOeiofqCUS8SRix8xY9asyk/2ZFsb4+DKRgd8XSu
         4D/qeAXu8JEU+GO+QlNC2vSBc+dW3CBOa6sPk7GIV/Cnm2AK0sakq6qEMXz/UMMpP2Uv
         +ZvzMXJ+dCq+IYFNIue4CugzqafLVWau6Ayj/S4kiWqMvgcvxQGExN7xD8xE13zypV4L
         h2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqlQnl4qs5Fxm/NqMg9D0+MwtUwGyqCYzlycIMaCGrq11RGb4Y3CT8CFYfcdQPPx89z5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9Uo3OkEXt5b6GPgjAsz8SB/7uy+E3UIPoD7HHEdVyKmpwR2j
	Q/686WVOpjAgxJArfMwN4iboYMUHqsqHKYQokuLoLaAu+K6AGghvMdeEyRZ98RpXTbacgm5G1rK
	MhBajRIvnWc9Dew==
X-Google-Smtp-Source: AGHT+IEPMqVeidF/HQfzF5blhVJjcK7ooy1GXBw2OmQH8gfNq2+feiN8Uwq5zuBT5zWfoWRHgipKuLoi2G0jtA==
X-Received: from dyew16.prod.google.com ([2002:a05:7300:4350:b0:2b0:4f93:391f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2093:b0:2b0:52ac:92fe with SMTP id 5a478bee46e88-2b17d2ba856mr5980637eec.21.1767912998679;
 Thu, 08 Jan 2026 14:56:38 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-1-wusamuel@google.com>
Subject: [PATCH bpf-next v2 0/4] Add wakeup_source iterators
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces BPF iterators for wakeup_source, enabling
BPF programs to efficiently traverse a device's wakeup sources.

Currently, inspecting wakeup sources typically involves reading interfaces
like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, and
each wakeup source have multiple stats, with one sysfs node per stat.
debugfs is unstable and insecure.

This series implements two types of iterators:
1. Standard BPF Iterator: Allows creating a BPF link to iterate over
   wakeup sources
2. Open-coded Iterator: Enables the use of wakeup_source iterators directly
   within BPF programs

Both iterators utilize pre-existing APIs wakeup_sources_walk_* to traverse
over the SRCU that backs the list of wakeup_sources.

Changes in v2:
 - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
 - Update copyright from 2025 to 2026
 - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel@google.com/

Samuel Wu (4):
  bpf: Add wakeup_source iterator
  bpf: Open coded BPF for wakeup_sources
  selftests/bpf: Add tests for wakeup_sources
  selftests/bpf: Open coded BPF wakeup_sources test

 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/wakeup_source_iter.c               | 137 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 323 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  | 117 +++++++
 7 files changed, 589 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

-- 
2.52.0.457.g6b5491de43-goog


