Return-Path: <bpf+bounces-66278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56004B31B55
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70B5B2633A
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8243093CD;
	Fri, 22 Aug 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6TwWb9G"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FD307481
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872277; cv=none; b=FsWv9tvow3SCB+A7y6SjfIkk84awAuhtglQsQI7pvoDWLSarrHQ8ieL6WOpXD3WT3aHGiBLI3zq96VQfSGamYqTkd34wupJlq+tNhL4mSD4PjHA/w2BcitXOt/uVD/V+pvU6CVWagVQbBu2YnoM7MDUpKLDlTeOYwVWdQtFUAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872277; c=relaxed/simple;
	bh=DzVahTq9+wmJvHHjxY9bV2+g4HTN0YWY8b5wehn8t7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyR6jAgb7lhzH6yVD8yDSEe2JV4Z1DspEzz/0gUKY0ZIlu9Tv5OpFsqP4MuOjOZ0jeRs0HsA4gaqDVBr7JCBi8gaSdEXApsaFzC8TBoWKojbES17tsdqQnlIw3u4ufQCBFcpTKjpfbZIjvc65taMlKOdEnB+JGf/hJ0NaIxN3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6TwWb9G; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755872273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ch1mq5Efdw7abCu+O0syCxRjZMdbLIeo3XfYw5zoJOE=;
	b=E6TwWb9GuLz/tjQfy2oxV4i/fjysAVorlFlzreAyKmFKfw+JJflE2l0Su+dVoosblY+Bg9
	+cU+X/KMCzmD1BB74ASpkACqUGQC5xB7WtCWkOC9pyw962sbQ4vDKC+eg2HBB5qsu5DeUH
	Olk9e9xOKPlaEzN41myM43GTtIT2jsg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf: Introduce bpf_in_interrupt kfunc
Date: Fri, 22 Aug 2025 22:17:19 +0800
Message-ID: <20250822141722.25318-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Filtering pid_tgid is meaningless when the current task is preempted by
an interrupt.

To address this, introduce the bpf_in_interrupt kfunc, which allows BPF
programs to determine whether they are executing in interrupt context.

Internally, bpf_in_interrupt() is a thin wrapper around in_interrupt().
It is marked as fastcall function.

On x86_64, it is inlined for efficiency.

Leon Hwang (2):
  bpf: Introduce bpf_in_interrupt kfunc
  selftests/bpf: Add case to test bpf_in_interrupt kfunc

 kernel/bpf/helpers.c                    |  9 +++++++++
 kernel/bpf/verifier.c                   | 11 +++++++++++
 tools/testing/selftests/bpf/progs/irq.c |  7 +++++++
 3 files changed, 27 insertions(+)

--
2.50.1


