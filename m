Return-Path: <bpf+bounces-42620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205C9A6A95
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E111F23DF4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7901F9421;
	Mon, 21 Oct 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W2P2ByC4"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BF1F819F
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517984; cv=none; b=gGePW6fK8uyKJQCE2kADpibdDFjd2Lgl9mf6/ZWhpyDpg534vXnPXsoJZ6ojvqF1WNySXvI02LBj8abEhCuUx4SKQKR7yx8/l99OCeUmlA8IUKVZV7mirISiTuojcJOQgRvkaZLY8NhUdEaGglJVw0kA2c+CEsSf6O8C76MXhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517984; c=relaxed/simple;
	bh=ZZzxq4s+zc0qfiOiBA6I+JJLwRPs3Fpk7f9iQsV/uL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1pKOGIcja/WlIeermW7eU7mDzc54bhvGeUmUWB10QeWOBRifszkcXcuczIQua2lUZJ7A+QU3kclpjy+1uOw2svDyjs39sBzYo9ehhHtFBzz5ap8GCR2AIqa+flcFrvgYoKYUC0v05z2kbRnRqTMo5bwZdrm9HmajTplAFTv5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2P2ByC4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729517978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YnMU3SJ4rTdwk4npMFwBCF1qFejuDd4IXtYj2YsF7v8=;
	b=W2P2ByC43NudN0eJMDKucUNQ7kKLCXjIDFGOnY2pmUFPoDkyMt7JwhDwGL6y0TXNFP2G6L
	Jgxa4QWiHaBudP5Y18MJtCg4gBEb6tnK3J7iMh2+qO1GuwuitakDBOb7MXz/sgvFnDLpRo
	MpEEdeZK9HTOdWxqSHO5NyRG9kCxmhs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf, x64: Introduce two tailcall enhancements
Date: Mon, 21 Oct 2024 21:39:27 +0800
Message-ID: <20241021133929.67782-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces two enhancements aimed at improving tailcall
handling in the x64 JIT:

1. Tailcall info is propagated to a subprog only if the subprog is
   tail_call_reachable.
2. Tailcall info is propagated through the trampoline only when the target
   is a subprog and it is tail_call_reachable.

Leon Hwang (2):
  bpf, x64: Propagate tailcall info only for tail_call_reachable
    subprogs
  bpf, verifier: Check trampoline attach target is tail_call_reachable
    subprog

 arch/x86/net/bpf_jit_comp.c |  4 +++-
 include/linux/bpf.h         |  1 +
 kernel/bpf/verifier.c       | 10 +++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.44.0


