Return-Path: <bpf+bounces-27735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6D8B1556
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A977E1F231D3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5249157474;
	Wed, 24 Apr 2024 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUoMbTmB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F015696E;
	Wed, 24 Apr 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995537; cv=none; b=orZZJXep5lOA2mjXGc8beaxLHuyg5Pt7OAfUeTBcHmsdv4bEM9EVNkxG16LZ2x8ua0IQV81jXvOidLhse6JOb7ZtfRMq0S6Y8/855pau0SemlpdVXjPzG0TB6veO5sfXZ+U8chJgZ8rnc03p37yf7lXJYM3eveoJJdBSrNntdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995537; c=relaxed/simple;
	bh=G+aiURc6urfG9PgQAVrHhTuXKO9sTzZPh56yF80XjI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lu9HawoeWsvKdCo2EmqQGaG0Ar9z9cxATCW0jTGgS0OcVf7NIYgsdg4bs2AFd6dUw4CxnBPD6+edgsyMeQ9pvJo3p3c+lFmdTib6p0BS9wc71R/TKWDYUT/HckrEIxK0XBffYkiuPrQek98hOc5ZJ1tGj04ZB1xm+sgiEugiwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUoMbTmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB19C113CD;
	Wed, 24 Apr 2024 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713995536;
	bh=G+aiURc6urfG9PgQAVrHhTuXKO9sTzZPh56yF80XjI0=;
	h=From:To:Cc:Subject:Date:From;
	b=PUoMbTmB8LjyNGdqt4lW1GKgaSmHjyrqGSRl2RvJcnWjk3cPAvOoI5NZGXrYcUw60
	 qNF8kRDDAUGu5mHv8vAGOsAi8ZncRP8giwHDqkM8ApH6YwjEqNvENOscqDeYPTj/ff
	 BkS9bOkzBtHitpab2SRjJY4GNb7Uurr8ka05zCNKkMzQUj5FrSGXMyzl4yr3pKOK1/
	 DkBvZerqlTTDk1mumBvHQdkA3vNSWlQrKYgzvY9jxt8e4zZPAyHUzwcma2phqv3eyb
	 ZPy9zAf8fx36EH0gerbBRHAqsLzD8Zerc5b75gOumnGvEAlSqxVa8Er6DDbk6CmYG9
	 //q+EsZ7mreSA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/2] Objpool performance improvements
Date: Wed, 24 Apr 2024 14:52:12 -0700
Message-ID: <20240424215214.3956041-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Improve objpool (used heavily in kretprobe hot path) performance with two
improvements:
  - inlining performance critical objpool_push()/objpool_pop() operations;
  - avoiding re-calculating relatively expensive nr_possible_cpus().

These opportunities were found when benchmarking and profiling kprobes and
kretprobes with BPF-based benchmarks. See individual patches for details and
results.

Andrii Nakryiko (2):
  objpool: enable inlining objpool_push() and objpool_pop() operations
  objpool: cache nr_possible_cpus() and avoid caching nr_cpu_ids

 include/linux/objpool.h | 105 +++++++++++++++++++++++++++++++++++--
 lib/objpool.c           | 112 +++-------------------------------------
 2 files changed, 107 insertions(+), 110 deletions(-)

-- 
2.43.0


