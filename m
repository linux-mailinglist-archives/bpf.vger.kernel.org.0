Return-Path: <bpf+bounces-74847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E424C67147
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D323D29B75
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642123E23C;
	Tue, 18 Nov 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="cYl+PDXv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBDD515
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434866; cv=none; b=psShg6Ymv/gJG/44NnhWdpAHHhBT5l6ceqJStBLV/9x/i1xRNgeQ3HTDhvTXvTFpGmgYl/p3R6/vqrNJQy0CzrxDerleb+faLDjYT7s/nuYBZ+/hwa9OWReJinYrWqyNI9+NlEtFf/LoUnYtSulLFdYtAu3NbdKs7TXjy38nqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434866; c=relaxed/simple;
	bh=VT5Mqbr0H9U5jZ6tvnfKGudfzjuLEZn82jDiZmcoseM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kib8tfvAteaApNmt5BKU8oqz2b8hSarc68s6aSZya2jUHjBzLtk+W/WSRK1yfEUlD9/SDfLwNjcU0edhEwMltayS8q272Mff66sodwGDBGwWbInyvdVr+d9frNXkuaR6drlkyEMr5HkyKQGbEh+CPaOL6iKNH6LYeEaNLqVemSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=cYl+PDXv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b28f983333so520617785a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434863; x=1764039663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4RA5qcwtRAcDK+scEe8d7frLMYjRRdNWkIMIlWZXOY=;
        b=cYl+PDXvBwwyshEnODQqTI0fB0XPcAYoIHhauQQZQxNcdyCo87UUXHIy8/OHv4meyn
         gX3xNJKo16E15CfdxwTXaKEBGDx0yq4MZQQ6siwGGSa2cfMUpTrFvNn3t7M19k2bMu4N
         BVsHvyiDajSJNr/a6etIqHTzaVJndgeDKPCP4kKvx+O4P2qgcNrms42bWrqasNJ53tIV
         W4pWh2TbQ/8a0joskN/IwiF/YoSnmgCzvhAg5Ge8lvbMdrhwbsc9SIdVMaLyGp+EuTop
         Ug4WgmAlgkjdYCHjGUxS0/c6CkRqwK7bAcTlZlk3xmHw78MsEtHSojKyn+I/3sLy0fb1
         MjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434863; x=1764039663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4RA5qcwtRAcDK+scEe8d7frLMYjRRdNWkIMIlWZXOY=;
        b=iM+XFkWbr8og/2pCKl1OowOposKx0Uv1EKO3doBYmZ+zKbnTxonei93cPA5nahhx/K
         NX8aRtImaZ8KQ1qKKpOAywsCdlTkotU+FIMaf0fJpQ6teUwQBHa3HWRQb6l5jhq6lIc0
         Euzi5hrtNqwhXCtqqMyjbxmHsQQuVj6vDjba1ToBMDfWw70sohfMqcY8lS/3iaaIK8Ax
         gZznV9Ps/VLBGOb/8xCNR8DZNNHGrVd7s2K/+c+UPOfjpmjFKI94uWukdHtfiGsZo2+U
         mmJgO0hFf9+Aqa5oYzvpATSqLPyPqRflFQn6aaY8HkLLfkoekUHXPGn8vLSAikguIAGS
         Rhkg==
X-Gm-Message-State: AOJu0YzgKvVb4qWhhZJhrNZJ9p/3YTVO1soVqP48dnbEgF8R1r0uAEF6
	zEXq9L7eQlU0QJJzMT0OfDvS8dvA4mucG+kD2vq+mKyYZ4Dn2xq6w3uR7FeQHwfahb9OnK7rnb8
	7NcQGJRg=
X-Gm-Gg: ASbGncujom5+18Duvq44DJertB79U+WpiC46H6olpyQMb0ATHKso0fmVUb3GaunuAUY
	EIjEPtF/jxWvArOl6w/ZCKkGVE8sEanEqaHmerdSpI8Td1vDalXgOkinzUuatk71oZ+fk6LOuXX
	+oo3mQAZBpXGicn2vrNjjDhbP6BGh9H3BkYCkTRd4LC6NmJQCeyAgHkd9JHsJ3p/Jz1a3pl6OfG
	MbPcqCAplyaQKu5XZb2igmTkH6xXAgQlyemeTBtV/vcdyPR8YUlira39OHNXKxWtTh6Np10KykC
	rkSI+I/avg+JbshGrRkmi8ZonHiRrFBwxW2tmTCics8hK3iNPVKhxtCuMeMnb+aIfnF5FNYT/s6
	LE+dWG9fvRU5sC3VTe2qMWrxnAAfF/6oGFYYCildaQ/1cZgW+1+TFkhOSjsy1O6z+MpS1uaZDGs
	UNZk4mWCUy5g==
X-Google-Smtp-Source: AGHT+IF/uZVymeZv1Bf4HaxNmmqi2auMwAyLMsUgUcrjuSmjGDG8aQpb/Dm6PHj+2BDYfEFoKjQ4tg==
X-Received: by 2002:a05:620a:2915:b0:8ad:5014:53e3 with SMTP id af79cd13be357-8b2c31c9406mr1723547385a.80.1763434863246;
        Mon, 17 Nov 2025 19:01:03 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af043037sm1117130185a.48.2025.11.17.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:01:02 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/4] libbpf: move arena variables out of the zero page
Date: Mon, 17 Nov 2025 22:00:54 -0500
Message-ID: <20251118030058.162967-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify libbpf to place arena globals in a small offset inside the arena
mapping instead of at the very beginning. This allows programs to leave
the "zero page" of the arena unmapped, so that NULL arena pointer 
dereferences trigger a page fault and associated backtrace in BPF streams.
In contrast, the current policy of placing global data in the zero pages
means that NULL dereferences silently corrupt global data, e.g, arena 
qspinlock state. This makes arena bugs more difficult to debug.

The patchset adds code to libbpf to move global arena data 16 pages into 
the arena mapping. If this move is impossible, libbpf tries progressively
smaller increments, and finally defaults to 0 if there is not enough
space in the arena. At load time, libbpf adjusts each symbol's location
within the arena by that offset. The patchset also adds padding to the 
BPF skeleton struct arena datasec to ensure the arena's fields are 
pointing in the right locations within the mapping.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

HISTORY
-------

v1->v2
------

v1: https://lore.kernel.org/bpf/20251117235636.140259-1-emil@etsalapatis.com/

- Fix ifdef guards causing unused variable errors for
  architectures/compilers without addr_space_cast support (CI)

Emil Tsalapatis (4):
  selftests/bpf: explicitly account for globals in verifier_arena_large
  libbpf: add stub for offset-related skeleton padding
  libbpf: offset global arena data into the arena if possible
  selftests/bpf: add tests for the arena offset of globals

 tools/bpf/bpftool/gen.c                       | 23 ++++++-
 tools/lib/bpf/libbpf.c                        | 36 ++++++++++-
 tools/lib/bpf/libbpf.h                        |  9 +++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/verifier.c       |  6 ++
 .../bpf/progs/verifier_arena_globals1.c       | 60 ++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 +++++++++++++++
 .../bpf/progs/verifier_arena_globals3.c       | 61 +++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          | 25 ++++++--
 9 files changed, 261 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals3.c

-- 
2.49.0


