Return-Path: <bpf+bounces-43305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4659B3217
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DD0B2318C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC11DBB13;
	Mon, 28 Oct 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wv+dgxsu"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4351D5CDB
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123179; cv=none; b=jC4FIm2eaFijcYtPEp4asNLhxwKNi9GUEgp23C7koQIG5nxRkMws+2VQqIqkNYXNfeKU8E8VvCN2Y0V7hGWYUr71EUyKNQZc8xP3baQ2fQxCE0YRA4nvyJ/G5qNU+bCy0gZ3ZEcIyCVBOxqD2Q0o5rT7rIhr9X1/Awlgkz34afI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123179; c=relaxed/simple;
	bh=eSKkRuSkf4MgEO/Y4YTP+VC0Z+LIg3WzV5oRRyxLoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGowaTRtEpFrcUXmnUFkpAykK4j6GhU0DgpcMrCE5e75Fi3qanyKriteOX6gMRyje2mfRoDmrzg06ZzYf6IdDwXsE6BX1OEi4SMDrwM5vtIVJDRAJswzR1u2eASXWhm28e960A9aCLkpiVZUsRsSVaocEvs2G2yEoN3HMp2oTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wv+dgxsu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730123175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4kL8dv33kcyGZUTeDLpXgKA3B9BW/7RAqCkyN+Fu0bE=;
	b=wv+dgxsujA0kWY2eSvsIeXomBYUc/NgRq8nyVYdntq+YCITJDWJ+R57gH7GRmUvta+Iko0
	ybHLhkFK40BbeIBX9MH8nsbyTp9KhhmRK8R4ud/9ijMjXBBrcO48DWVJbM1XV3++LO1/mN
	QEFxSt+mNIZ3r0jLd+KBKQAnUn+21j4=
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
Subject: [RESEND PATCH bpf-next v2 0/2] bpf, x64: Introduce two tailcall enhancements
Date: Mon, 28 Oct 2024 21:45:58 +0800
Message-ID: <20241028134601.95448-1-leon.hwang@linux.dev>
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


