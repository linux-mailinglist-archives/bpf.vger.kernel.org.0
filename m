Return-Path: <bpf+bounces-52982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9187EA4AC87
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988D416AE50
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB501E0B66;
	Sat,  1 Mar 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLVD12Dd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342123F386
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842331; cv=none; b=Un+EvT9G6IQnWMZdij2TLlvvLlwnW+j+h3XS/iruS8wP2H/BQNPj0yj2mcQ8Zc5yyL3oZxSeI5Yp9tB8QR9D0DP2MJaUKJkwd+YGyQQlZNRpqNgPCkFLt5gTAVnUdmRE5eIJ/WWEVg192hWw3gje0Gc5QTtjHC74iMBMVccRMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842331; c=relaxed/simple;
	bh=w4BecYR8aD8xtwNYwQszlU2o4WjjtpHZX2j6fb74Ub0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIaYhTWkoN2kNgDEhCs/rzBvRlE5rJdH11C4sOZkD8J/8Si2UBvkQhWOtxD4GQaJTp6W3+K1BWWPw+TujU2dYLWAwH1I/S+MUPJ4dfqSyQYA6RPvjPFfH51kqkvHBP54umohgpM2QgMXfWTMrgjFp7ciO1WK2u67QH3eaG+QSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLVD12Dd; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so21260215e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740842328; x=1741447128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SMjmtKyuhT48llSuVoCpssHjSTwlRrZ0Dvw/Rshiew=;
        b=hLVD12DdusNz+PbvltVSnRVtObfAPIR48+r+0Bqy5WX9n7GatVcqaGUoWTeVK5UHin
         pvgfbTw0QYNCBHI3CXOqXd1xYVnuQcr98ZvbmzEu3FbCtmchRNIEdGJR75so5eb6rn2E
         WDKSn+/x/FST4aam3x3siB6I52kr5E93q8TOBEMdDatMe1zvhXQTwnE0TqN6teJf36nU
         vwDsldJS+A3k3XDQJM1K5sKO7HOgYJuI5TGzAtajjq0thkTLac2yrhvJvMJQ8jg/3ZTx
         oH4a49B7gMO8NBIIT94kfQAMXvA3vDzP+caOoLC3ZMp8+mPBqxi9bKOX3cvEAmlNUapN
         Hmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842328; x=1741447128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SMjmtKyuhT48llSuVoCpssHjSTwlRrZ0Dvw/Rshiew=;
        b=cog3OhsBN6uift3yCP/RsXMPwa1qNLefE/rD7S/uCDQaAG1BHVhIBDDBfd+LliKmAZ
         OzrR65N+inkAU4sPnIgcp2KZU31HBrLAayrfvDJ/Ibz/Gvh2xcATc7P4qzXNH2LK7OPW
         07O9L1N+/Ttfy8JhaqrBMXhK01rXAQb/1T4QwR8gWAzV32ukw5HLXj7xkRrNrJhvKOiV
         YrwrNiZ749XP4T5UcM2ENU7YNb1ASRrmtzSC78ue7kzT057PQsB7duxXWGGzZ7oI7HKW
         gidhWtdp4rEntf8rV7ZgCEcotlo2MP5VPPSY4e7sHacze3KHsyufEBkidkF/Ud1JaKst
         LXhA==
X-Gm-Message-State: AOJu0YyLldUrGU4Km23j9QHjmOuzK5MlDi8KId8qoaXaR/GI1JsbqqQX
	1odhmzaLulBVDIwKSymo6cvqOHhHQxE7Lfo368rxhSFsP/kSgSPUfAonUoVWH+o=
X-Gm-Gg: ASbGnctgaNwtwUXwKwxXS8M7Ll7ERW99ONRa0AKWSJfDrsKbQYAnDlL68jWw0M2j/iv
	yyx1GhWcsO/fAi2LXhw9rGKL2exRpItCsjHEj8rH+Vq3gb8RqaKKBeVcnyBi1lbB4cwVOtyoJGV
	7gLeTlgwW9am1ieyBjmBA+dv/eW57aSK0S7mQkBtTAH1jgjCC5L3o9YzK5u+pGT5KTtZpZx0IdA
	TO/NFWKbzQtc/p83+l4ppoEW37il6YKSVs+J3i8hZ6QNuX/W3Xj6dQEfXJbNzTx/xaG3hQ0pItd
	ZQguXPbgAwIASjY/gz0mk1mK21BrpVukNQ==
X-Google-Smtp-Source: AGHT+IGmkS9S6GTDv4NrySiQuyaeHYU62NONxAVIHxzKQgmstqkoeVZBwVZS2CGqBImhID72zlgJ/w==
X-Received: by 2002:a5d:47c3:0:b0:38d:ddf2:afe9 with SMTP id ffacd0b85a97d-390ec7c8ff5mr5380685f8f.1.1740842327819;
        Sat, 01 Mar 2025 07:18:47 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm8762196f8f.63.2025.03.01.07.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 07:18:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/3] Global subprogs in RCU/{preempt,irq}-disabled sections
Date: Sat,  1 Mar 2025 07:18:43 -0800
Message-ID: <20250301151846.1552362-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; h=from:subject; bh=w4BecYR8aD8xtwNYwQszlU2o4WjjtpHZX2j6fb74Ub0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwySYNMgcEC8PLGjhtKdNnq91WhJ5OSDgYf/zWdJ1 vcXCKbGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8MkmAAKCRBM4MiGSL8RytGhEA COKJF5DS0CiUzUa29WK9OgYedSjlTlLF4EKemk4VP56tQ+EQ9/FvQw+49lRaVP05KVJnLv479BzyWL BNLEZmRL003sYlUh7HSHJNNXMVVUEZiY2t/mr5cRJ/rsqXnBo2kPJcah2+bD6UXq8V5bOgwxjcdv8R L+YW3wmGyIcNnX1wplM+Uk48w3vs9VG4WPE57rKC5xvvBTx1GV2vBvHW0Zi0slPqx6j5N0cS32cdGS qcXzb0nIoOFJLSiytTPcWTBSOykH5rQJ+ERAizeKoPtH7ZXYlJpe9VkHyKB48gzk0Jq+i96yAdfevC D0siXZu8wx8pAmO4qdniKTbYPkzZRPQuRB9G8FQk+WeWJ27S5N0w2pdreQH+yUFCirszqt9UXEAgwU YQ/V6UBuEVRmru0VbnXNC5+oNmS0OLqmj2jw7KLU1UqU/Z8QBJsaPY6CGehjNxtyv1wOByOjl/8PJL QlfAZaQVuzG9m/Ih1RW/+4+sBMRf3h9ksRZQzQpX2An9jQ4V+z7On80RKlmKGA4ynAHOJE+hx8BAUO phpxuvUtPP4IGfK25l5Blk1L758sDrdBLPyj9rGqas1pilsDvFUDDAbIL7DMFVJGYdFDd5LmoydSYk onkQUaKSSxH38PSS1iJg7OVNLk0NCs9tIkczu/v6dyfK72glh1WIeQNnEhrQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Small change to allow non-sleepable global subprogs in
RCU, preempt-disabled, and irq-disabled sections. For
now, we don't lift the limitation for locks as it requires
more analysis, and will do this one resilient spin locks
land.

This surfaced a bug where sleepable global subprogs were
allowed in RCU read sections, that has been fixed. Tests
have been added to cover various cases.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20250301030205.1221223-1-memxor@gmail.com

  * Fix broken to_be_replaced argument in the selftest.
  * Adjust selftest program type.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250228162858.1073529-1-memxor@gmail.com

  * Rename subprog_info[i].sleepable to might_sleep, which more
    accurately reflects the nature of the bit. 'sleepable' means whether
    a given context is allowed to, while might_sleep captures if it
    does.
  * Disallow extensions that might sleep to attach to targets that don't
    sleep, since they'd be permitted to be called in atomic contexts. (Eduard)
  * Add tests for mixing non-sleepable and sleepable global function
    calls, and extensions attaching to non-sleepable global functions. (Eduard)
  * Rename changes_pkt_data -> summarization

Kumar Kartikeya Dwivedi (3):
  bpf: Summarize sleepable global subprogs
  selftests/bpf: Test sleepable global subprogs in atomic contexts
  selftests/bpf: Add tests for extending sleepable global subprogs

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         |  62 ++++++--
 .../bpf/prog_tests/changes_pkt_data.c         | 107 -------------
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |   3 +
 .../selftests/bpf/prog_tests/spin_lock.c      |   3 +
 .../selftests/bpf/prog_tests/summarization.c  | 144 ++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    |  39 -----
 tools/testing/selftests/bpf/progs/irq.c       |  71 ++++++++-
 .../selftests/bpf/progs/preempt_lock.c        |  68 ++++++++-
 .../selftests/bpf/progs/rcu_read_lock.c       |  58 +++++++
 .../selftests/bpf/progs/summarization.c       |  78 ++++++++++
 ...ta_freplace.c => summarization_freplace.c} |  17 ++-
 .../selftests/bpf/progs/test_spin_lock_fail.c |  69 +++++++++
 14 files changed, 558 insertions(+), 163 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/summarization.c
 delete mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/summarization.c
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data_freplace.c => summarization_freplace.c} (57%)


base-commit: 0b9363131daf4227d5ae11ee677acdcfff06e938
-- 
2.43.5


