Return-Path: <bpf+bounces-67704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB02B48D08
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE531669AC
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BA2FB99C;
	Mon,  8 Sep 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW6cjW2L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C89315D57;
	Mon,  8 Sep 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333601; cv=none; b=pLa/IBZMNWx1UFExP2Kdzds7qXg7HamBTd+rDBLepkgiHgOsHs5mE3Viii/4tLBo1Kl1jlw1NaujLC3ZoQ3mY9EHKY8TMHd3f/GD6jh5TiIenw8zQUtP4ScSTA72c+uFbV0SSkPI30/2aNOPL3Siwxwe1y0G6mGHibOeeWK0DIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333601; c=relaxed/simple;
	bh=epcr8vXWo27xn1G3na7S3kMbX58DE6xb7OS8s4HtZkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N20P/KxbD8VaxRkeXVpQhsTNCg0xNRb39XG/Qoo/Od98Wo4b77w8LsI61Bhc7pFxZE8xzVwuDq6ZxzDpiBAdEbvoVrfUDtgS078YG6txcopc2+yzV/IUVIqw7bB0yWijsNzfmKJOm345NQ7QDRLDXZeXYtE84Ee9BiWaJIAo1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW6cjW2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA4BC4CEF1;
	Mon,  8 Sep 2025 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333601;
	bh=epcr8vXWo27xn1G3na7S3kMbX58DE6xb7OS8s4HtZkg=;
	h=From:To:Cc:Subject:Date:From;
	b=fW6cjW2LH6VyalH3xc3j6nP9GGtXgHxBjGEKuOD5F29nRREhq+2Xs/2G6mzc3W+/x
	 EWTpJoQEBbAROr9YYccc7wRap/ovIsPfBub4xeOpnnZYwQxdcEtXykw9n+rqErpZPH
	 0NFJ8bfeOic2JKgXKQcYUBOqfTkX3dYTS1ERSNEVC/GHmmn0oQKR+Fl1JyPJdKxuO5
	 JdHqjfd6cCRj2j+UYCJ4xgLqlzMy9riW90v8QKc+zT8B6KvfN57Evh027wWA4LgI5Y
	 q+zy5tj3tHfKLaJawImUbsMEgaNl7AtECbcx1tPrswXSccHyipsC0DOGxTxIH1emYd
	 bTf/m36i0GUtw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv2 perf/core 0/4] uprobe,bpf: Allow to change app registers from uprobe registers
Date: Mon,  8 Sep 2025 14:13:06 +0200
Message-ID: <20250908121310.46824-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently had several requests for tetragon to be able to change
user application function return value or divert its execution through
instruction pointer change.

This patchset adds support for uprobe program to change app's registers
including instruction pointer.

v2 changes:
- moving back to original change without the uniqeu/exclusive flag
  as discussed in here [1]

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com/
---
Jiri Olsa (4):
      bpf: Allow uprobe program to change context registers
      uprobe: Do not emulate/sstep original instruction when ip is changed
      selftests/bpf: Add uprobe context registers changes test
      selftests/bpf: Add uprobe context ip register change test

 include/linux/bpf.h                             |   1 +
 kernel/events/core.c                            |   4 +++
 kernel/events/uprobes.c                         |   7 +++++
 kernel/trace/bpf_trace.c                        |   3 +-
 tools/testing/selftests/bpf/prog_tests/uprobe.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_uprobe.c |  38 +++++++++++++++++++++++++
 6 files changed, 206 insertions(+), 3 deletions(-)

