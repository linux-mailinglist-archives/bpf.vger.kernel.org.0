Return-Path: <bpf+bounces-76012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B577CA2345
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 03:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39A223016ECF
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9618E314A7A;
	Thu,  4 Dec 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxIBNmcF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A082313E2A
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816625; cv=none; b=DGzbQOB3RAjrHJcEH4FA3+aKnjWwWxmHBx+0P4KL+Avg4CIYKpTU5TUsvbtxpDF3u/ALRzG+UaJNw1Rf7QNvgEJovXiOi5DImgqhIiG+4i63Sp5Yv25NIc99O8p5bmKQ012R62jiAKBrzD5zXQvGH2b++jaQsuLoxROkTQR7qFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816625; c=relaxed/simple;
	bh=Wqf1Q6l/7NQ/XB6VRxojAG8M0xThMqraEmNr0p/Gptc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=elP28XLR+rn2+MPn5vT+cLJtRb09pmy7mIFSXscfUMCozfQxj0NhUx2/6d0WQTOjH5E9fxZ7p15JfrJThdrG3K72Nbk5mSdTzYAIUZM0oJZQKd4HGZVHRQ6DzJLnwgxFKZ1CeB5hHunyO7DjvayP9vh+yzOvcFLN5KRraU+hedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxIBNmcF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so365018a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764816613; x=1765421413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVWB8hYtCwwcLrdiadBsaKa3b576mee91Y0siXmwXaI=;
        b=dxIBNmcFRc77Nvu5SFgWPUo0B92XTBiKXG1FnF2Fnr1jBavdKdxI34ScjjCnDpRQw2
         EzNXgqp4YwT6qpTTE7mxzTmKpnO7NIIhVmjqo0qviRuPvaOD3df9WQuFzC0WNm128pQy
         eVbFqvW2zohmGBkKi+zEIUoL6mP7vSiOxkkIeMgmDpQqssJ+vaNW05EspjASdj/0sdaO
         HkX6SdLvKzJUQxnnogbnEOYPRqRkUtqLN97Xq08jTVgxgrKHgJ8PDD4PfAo3Yyr1W1MA
         8lrkYl3oXG1xtdUEc1zBrAFEQ8MgKANaXieX7n+tTeZ00vLop3VFKyq9jtv6cU8/Uwqz
         IIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816613; x=1765421413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVWB8hYtCwwcLrdiadBsaKa3b576mee91Y0siXmwXaI=;
        b=A52PK03UO5Tj1e6Q34DfkKm4MEBed+7MbmM+34LDsQo9a6EwlOWdzrjKZ4VbxjDK5S
         pojQNRUC5rWfRR1BCuatlowzKMcac4w1dBubVMTObt5MjiwrjxwhS+5L+KTLcjLFedRg
         vWjGHz9M3OQ0NFgabaDX0WaehBz46Gg6TbfGnMy2pjOxkP6+oKYlRij8Xahin4PTFyom
         DYfkMQgSgBrifONsHii7r+YT1a4prLPKRswEk28tmlb4Dx7Dfwgv61GbQRg9LA0XwhjB
         BVQ9hO+WknlKXv7Y8Bne6XFRJXwxUFiLE3jSooSd4gRitYKzuHgCRTSaU2JHxem+Nnaf
         Dc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLbw/vnffhnHXEmE3dqBVab3YCcfVH5ofXgiEZJPtXOD55ze24X6bMVIJcP+zXGToTFJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxStOQwFaIEQKqlTaMf2vknUxZYbj5ZxF8PJehenAFULb0Cr6w
	UMzXDSr0OE8pQaVZJzkFarb9H3BIgzqvsy+8O+eNo4nYAkJezTiYGYoZQSbpIl7PxIKKqyR+LLy
	j+NZP6MmIQve7Gw==
X-Google-Smtp-Source: AGHT+IGYWQuKWSewRxlU8L6DiRrvrEKqNqkG7Y6XzWNDEeOrH2BjtMRztQwO5FnwUg0IYePOuaYns8zr3HDmZA==
X-Received: from dyjh23.prod.google.com ([2002:a05:7300:5617:b0:2a4:7a56:1730])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8186:b0:2a4:3593:4667 with SMTP id 5a478bee46e88-2aba422c0demr1077343eec.3.1764816612751;
 Wed, 03 Dec 2025 18:50:12 -0800 (PST)
Date: Wed,  3 Dec 2025 18:49:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204025003.3162056-1-wusamuel@google.com>
Subject: [PATCH v1 0/4] bpf: Add wakeup_source iterators
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: rafael.j.wysocki@intel.com, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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

Samuel Wu (4):
  bpf: Add wakeup_source iterator
  bpf: Open coded BPF for wakeup_sources
  selftests/bpf: Add tests for wakeup_sources
  selftests/bpf: Open coded BPF wakeup_sources test

 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/wakeup_source_iter.c               | 137 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 323 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  | 117 +++++++
 7 files changed, 587 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

-- 
2.52.0.177.g9f829587af-goog

