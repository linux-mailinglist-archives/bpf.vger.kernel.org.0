Return-Path: <bpf+bounces-66385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E12B34076
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0A4E332B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AD51DBB2E;
	Mon, 25 Aug 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d35x8pTg"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DBA81749
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127741; cv=none; b=tpQkdyf8NMuqeZYpzGU6mj9mm2ebRL7gugCjBh9hUwylo3G7HA19QHTLkOhaki1zEPbXSebnFPnR3YWXdDnlR7qBSvx09J2Y5TGHxsdjOXnmGxPErSJAuaoOR9LnYReYkNiASbpCsepYKTvpUITL92CdMVAQQ2GDVDXmgSxhKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127741; c=relaxed/simple;
	bh=RJtuIDYVgqBhjbhRdsTw2PqosqjsiSBmGzprKo8+Hoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVO+1s9udia9uqERAx1zMsMrV2s2c8gojx+4OuUD+i2CD3zWHjAytsk+G/v3YrSFSeIUWwwhICaHUctCL+xYEYwUZZPL+0J/4mFr7fmm4VlDY1Rjz1RormRT6t0AGdHe2vI14AAB+QQUTsfxBbm7mr8ZhJr49BdMgECgniozyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d35x8pTg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756127735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzQBzVeHC+ikuIPDddeKBzNFeO63h88E4KeXdDjOTgg=;
	b=d35x8pTgZ/iKpOMH04yWI2Xrtg/VfXh6VSoIY0iNzGWO1mezGvf8AxTRKC7rLXerJixxPa
	jhgUK/V4FKLtPnaBr0FwgoP9mkoqnx9OlL7I1jC1yHzalMDkeFfwpPJbiDHisqbau45KUf
	zeIHO9fz+YyJB2/POk2VmuiIfYsWRoM=
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
Subject: [PATCH bpf-next v2 0/2] bpf: Introduce bpf_in_interrupt kfunc
Date: Mon, 25 Aug 2025 21:14:59 +0800
Message-ID: <20250825131502.54269-1-leon.hwang@linux.dev>
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

Changes:
v1 -> v2:
* Fix a build error reported by test bot.

Leon Hwang (2):
  bpf: Introduce bpf_in_interrupt kfunc
  selftests/bpf: Add case to test bpf_in_interrupt kfunc

 kernel/bpf/helpers.c                    |  9 +++++++++
 kernel/bpf/verifier.c                   | 11 +++++++++++
 tools/testing/selftests/bpf/progs/irq.c |  7 +++++++
 3 files changed, 27 insertions(+)

--
2.50.1


