Return-Path: <bpf+bounces-68732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D317B82C83
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 05:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8898E1BC36D7
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35723C4F1;
	Thu, 18 Sep 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RDj2d8FV"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881434BA27
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166982; cv=none; b=i6YlL2tVZcHCUPwpbkEeH1rGdb3Ms61ZHVLo8X45sSqE/U+/UVHUJyg8a7g+MQcQdbJLiTjX4i9QE0V6PSr2HoLveb1oYdXJhLAerGD54BHdwFi7he7PiprzwPIpwqrl/7201QWtXX607ib83lyauS8iydMvflJ5Ymfv7ilwE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166982; c=relaxed/simple;
	bh=s4dfE2ydAYBlYjHVdDfk+h9Z3FJxFihOYgYp4QN06Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW0kWpXroYxO/ELnbKI9sH7Ih909x8lePekKkevCnAuGXXM3UQbFgmXqsfeeNW3ri2IHC2Au8vMlhvgYoJN8NhF/4lSp7qdH/Old6ZmoxvXyZ9s5mHMG0/QGJo8MdZOV/3fQ7Q2AXxU7XYokNLw36XBJ5RyKytQFQyOflNgHm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RDj2d8FV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758166976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVGCwcKDJxCDUj9E4BqZOP0bEOF1M+F7b6XV7R4YWLw=;
	b=RDj2d8FVLZ7gFmwZbmXHqKcKYWAnHlHdXRekR2Ja85XOCPHFo/Lwkr3Jz7UMkWcC1wRUWn
	TSI/jGmmHm0k5kGnUh6cvV3tZJ7kADtiFKRWcQHMhVE+kmHH133kQBF0+4yx1FokdKzYA1
	h2gmiR740RKpOyOPT7CAdsujlEz4c7Y=
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
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/2] bpf: Allow union argument in trampoline based programs
Date: Thu, 18 Sep 2025 11:42:41 +0800
Message-ID: <20250918034243.205940-1-leon.hwang@linux.dev>
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


