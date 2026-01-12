Return-Path: <bpf+bounces-78616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A8D152DA
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB67030E04C3
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC2330D32;
	Mon, 12 Jan 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGwjU1sq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A6330D22
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248875; cv=none; b=EEfrYm6ruBqP3kAg+S6LT9+WvmAM+QnHObHlJDTZ9UXGIj3zf/fpw5+JGZz1mAYg4EsAPg6KmID7k3BSxeLNOCIt8G8sgvUAihY/qBo+gMxL+xO3xjEei/ffYhc2cpmCWValcp51B91q3C6KuwXLXK6ySB5Fi8WWWpUP8J4gSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248875; c=relaxed/simple;
	bh=fqxHJFmBuev/49Rl/DxXE4O5auQ1Z7wZ0oxYnsm7QLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0UkDfcIM0YbkZnbgxkvXUzho9Lnb4yj7oRgRkM+4vSUn+2iVsbLJtKZra46JuhFixh8iJxyKOlRXZTFlQPoHeQfC7ZnYpsYSFXg+mIJ/PqYocospTqDjOeJlrO97aa8cGPRGCbOhsMXZ6J02u+1kXtncrwVTzD2UOsI3GWdU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGwjU1sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8CBC116D0;
	Mon, 12 Jan 2026 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768248873;
	bh=fqxHJFmBuev/49Rl/DxXE4O5auQ1Z7wZ0oxYnsm7QLc=;
	h=From:To:Cc:Subject:Date:From;
	b=hGwjU1sqv1BdASRoBrUSBQl4/6w6Ln3YhcmJBQsN3EaDasCI4IPP/qQ7nfT8r2smz
	 0ZlU8C59Fxdfa6F4sUIieWu+2ebIRhJd9TRxtJRzalMdTk5QHgMcRDpN6yTOzX8QZC
	 PLCvXEO1S45IyX/3Px6b7ZrfV9Bh4pmpUuslzMdfGxT8KV7GhPt/NZSHc/QdUbYVJe
	 oUPOD4FnsTvvOZ543QT9CXUwMRtWpZo73hGl5iGsJT7bMKY4EB6OlaX/xs1UKO3VOF
	 Bi5Kf1nfwLAMVnSMwCxcfVMZyBWEJisAZyvEtqPVsYmRvkFStgALJZn37YRR71AX5V
	 sgxFzwlD1ek7Q==
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
Subject: [PATCH bpf-next v4 0/2] bpf: Recognize special arithmetic shift in the verifier
Date: Mon, 12 Jan 2026 12:13:56 -0800
Message-ID: <20260112201424.816836-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/all/20260103022310.935686-1-puranjay@kernel.org/
Changes in v3->v4:
- Fork verifier state while processing BPF_OR when src_reg has [-1,0]
  range and 2nd operand is a constant. This is to detect the following pattern:
	i32 X > -1 ? C1 : -1 --> (X >>s 31) | C1
- Add selftests for above.
- Remove __description("s>>=63") (Eduard in another patchset)

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

 kernel/bpf/verifier.c                         | 39 +++++++++
 .../selftests/bpf/progs/verifier_subreg.c     | 85 +++++++++++++++++++
 2 files changed, 124 insertions(+)


base-commit: 5714ca8cba5ed736f3733663c446cbee63a10a64
-- 
2.47.3


