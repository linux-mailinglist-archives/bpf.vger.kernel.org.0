Return-Path: <bpf+bounces-68906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C86B87E02
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 06:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B76C6284DF
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087D269CE5;
	Fri, 19 Sep 2025 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PCNzLbBw"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4E34BA4E
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256966; cv=none; b=hrgN4AVDX/mHksWuxZouTJlkbvXsMwDAj3H3e6TfN7AOsYsQAzvKWMvdloRJxs94oL7ek8AVLymQk3sSAUHop1L09TKiD7XPEBN8Ujo8CKv0uNS/CINNHwK74RfbNKcZ26HG9sIDit7e6m+BavX0CjXDIRe1LnbLLTE3FRjn5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256966; c=relaxed/simple;
	bh=nXcQgHWrSEu9Z/XauGOjJi0ONYFYH992suPL5pJTvfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCb1V1dFMgnVkrms+C7XaFs/AkNPGH52oRJnPUrn6QvKMBWOB5lhKhnE7lLjl7BHqfsYFNo7nmOlUF2FM1SYC3OZ/AoJj2QkxPDWzCTORNIobhS0idmIed+bwBf0ZzdvcLLeqzocXDOKJQLUzFZkrT43G1RBqFuPJKKKDpshuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PCNzLbBw; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758256960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BzQJzfCGeotDipsg+w9yxTguzz5V+3MoQ/lSxpmIyUI=;
	b=PCNzLbBw9YJduEw1fqinXy4UsavWiBIsLc4J8lB5l1zK8gSzILYwFJXYQz9g4vPixmhWYS
	OVRyCbuo2+cC2Z2FfCa7Fg/DiOsHlCf/MP7XuiHrztsstLtbUWchke6hPcuv0KNujZSvML
	+2mobv9T6ACk7yMQgTQSTXr7RgFtb4s=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	chen.dylane@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/2] bpf: Allow union argument in trampoline based programs
Date: Fri, 19 Sep 2025 12:41:08 +0800
Message-ID: <20250919044110.23729-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While tracing 'release_pages' with bpfsnoop[0], the verifier reports:

The function release_pages arg0 type UNION is unsupported.

However, it should be acceptable to trace functions that have 'union'
arguments.

This patch set enables such support in the verifier by allowing 'union'
as a valid argument type.

Changes:
v3 -> v4:
* Address comments from Alexei:
  * Trim bpftrace output in patch #1 log.
  * Drop the referenced commit info and the test output in patch #2 log.

v2 -> v3:
* Address comments from Alexei:
  * Reuse the existing flag BTF_FMODEL_STRUCT_ARG.
  * Update the comment of the flag BTF_FMODEL_STRUCT_ARG.

v1 -> v2:
* Add 16B 'union' argument support in x86_64 trampoline.
* Update selftests using bpf_testmod.
* Add test case about 16-bytes 'union' argument.
* Address comments from Alexei:
  * Study the patch set about 'struct' argument support.
  * Update selftests to cover more cases.
v1: https://lore.kernel.org/bpf/20250905133226.84675-1-leon.hwang@linux.dev/

Links:
[0] https://github.com/bpfsnoop/bpfsnoop

Leon Hwang (2):
  bpf: Allow union argument in trampoline based programs
  selftests/bpf: Add union argument tests using fexit programs

 include/linux/bpf.h                           |  2 +-
 kernel/bpf/btf.c                              |  8 ++---
 .../selftests/bpf/prog_tests/tracing_struct.c | 29 ++++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 33 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 31 +++++++++++++++++
 5 files changed, 98 insertions(+), 5 deletions(-)

--
2.51.0


