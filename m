Return-Path: <bpf+bounces-77727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A40CEFA38
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 03:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74393016CCC
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A521EE01A;
	Sat,  3 Jan 2026 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua0pRTar"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640551C68F
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767407040; cv=none; b=ex5tsU346T0qoU03Oq4bOgvovzoe/JGfJLGaJwQXfKOMMmIw0XhAlCFDs59b7cZ2In7E51EWuAUB8sMu5tvb+PVP9y4xOdqIFvO1YtWwhfGx4WwXhunlWed3EfdbgdUZn223psSCOnJ1zqBoTe6m3kd9Hb8jNU5Q5Lfsf+Vya1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767407040; c=relaxed/simple;
	bh=zWLIdZnvej4mK/LCNfoEGNMMFUBwEpuP01GLBmThlaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3Q07DJDmvF4Q1xIVPrV5RdyyrpvgfRFaA1UKYQmgiF074BjbAeUXWP+9IPUgriO+cvDmQBurzszoA9t2KQu/LCyaAA/0sXmulm3QihWAVSv1fZ+PJR2F1R7gGev76gRMl6oc9tBAc1na8m1HNzMR/GFOCRfrEFiz83EahcunfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua0pRTar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D065AC116B1;
	Sat,  3 Jan 2026 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767407040;
	bh=zWLIdZnvej4mK/LCNfoEGNMMFUBwEpuP01GLBmThlaE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ua0pRTarKm8dQUvqS1IfKG7kmHliQxmFaoEuGIuY/a7co11DdFAT7Xpu8VC0Py61J
	 MUnnQqDADaACP9TchU6vw2my2ky2VGN7k2GosZTDcGI+YCGE1nv+KPZS34+C8k4Tsy
	 reuQtthJdMUzmcoCE+f41TXP+1HtwEzXocdZVuL5uo6x0y/GsaXaVM0Y5x7LOG3eRb
	 bVN+6y/ejHzDn9ynf1VNWuPNN6MJSJhFVVtWtgSuxY8WGyKkrYMGsI8OXXFDuU8Uld
	 PdA24npVyVyDqSEwqC2+iQc1/8M2Du1A2ARYp9feAB2pJDTv5GUqjfb2Z92HniEs3O
	 U/h4zYZyq5FUg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next v3 0/2] bpf: Recognize special arithmetic shift in the verifier
Date: Fri,  2 Jan 2026 18:23:05 -0800
Message-ID: <20260103022310.935686-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/bpf/20251115022611.64898-1-alexei.starovoitov@gmail.com/
Changes in v2->v3:
- fork verifier state while processing BPF_AND when src_reg has [-1,0]
  range and 2nd operand is a constant.

v1->v2:
Use __mark_reg32_known() or __mark_reg_known() for zero too.
Add comment to selftest.

v1:
https://lore.kernel.org/bpf/20251114031039.63852-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (2):
  bpf: Recognize special arithmetic shift in the verifier
  selftests/bpf: Add tests for s>>=31 and s>>=63

 kernel/bpf/verifier.c                         | 34 ++++++++++++++
 .../selftests/bpf/progs/verifier_subreg.c     | 45 +++++++++++++++++++
 2 files changed, 79 insertions(+)


base-commit: 7694ff8f6ca7f7cdf2e5636ecbe6dacaeb71678d
-- 
2.47.3


