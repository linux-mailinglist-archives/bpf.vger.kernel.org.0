Return-Path: <bpf+bounces-43302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E79B31E0
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3893C1F22391
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C891DC749;
	Mon, 28 Oct 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i33jbS1u"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7151DBB37
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122855; cv=none; b=BAdkUlRzsfSmeV0EQ2vXmtsintbZhA3FXFaWcRekbj0Bnpl0qugGBF8ihjEryRLtHNMIVbeK0IDcmVEYEdv1fE/wT3wzlFZBDwkNnQuJ5PaBcVs3JAprp0BJsPBfnihqkDIs/2YZlfJljDqUWgIV+jq8sh9pMbNQuiW2VUm4khE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122855; c=relaxed/simple;
	bh=eSKkRuSkf4MgEO/Y4YTP+VC0Z+LIg3WzV5oRRyxLoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8i+wJNoRdAnhskwmbfhrI3r/6Distblu5ruiwx9DxJqxtoEUMwi+MLHaeeHgDAsXTwFBmQkgccLPc2JafpJE5sgW60hQ0fTNJDHtaUOq49abf4TbOzy406pXnew4btGiRXGWO5bw86ftI4Zj3NF5E29zzJesWfo5Q5UzgtOJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i33jbS1u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730122850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4kL8dv33kcyGZUTeDLpXgKA3B9BW/7RAqCkyN+Fu0bE=;
	b=i33jbS1up1z5+MXVBLdVy9tlTB8tYl/shJ0MlZjyyX5OcJ53pL52fQiqZRdNQXV6lMvlXj
	zJFmTcFsqxV9yxeHuNLTEZXnyVSShjA0Ag718YrhAMHXyR9D6oYHHEJNJrmT6bvH0X8ulb
	0854Ex7vicE8dByjEt+2mmc7ehwQtDc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/2] bpf, x64: Introduce two tailcall enhancements
Date: Mon, 28 Oct 2024 21:40:39 +0800
Message-ID: <20241028134041.94098-1-leon.hwang@linux.dev>
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

1. Tailcall info is propagated only for subprogs.
2. Tailcall info is propagated through the trampoline only when the target
   is a subprog and it is tail_call_reachable.

v1 -> v2:
  * Address comment from Alexei:
    * Rather live with tail call inefficiency than abuse insns fields
      further.

Leon Hwang (2):
  bpf, x64: Propagate tailcall info only for subprogs
  bpf, verifier: Check trampoline target is tail_call_reachable subprog

 arch/x86/net/bpf_jit_comp.c | 3 ++-
 include/linux/bpf.h         | 1 +
 kernel/bpf/verifier.c       | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.44.0


