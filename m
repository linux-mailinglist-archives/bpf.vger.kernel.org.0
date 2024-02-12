Return-Path: <bpf+bounces-21796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CAE85228F
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C798E2822DE
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB14F889;
	Mon, 12 Feb 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mmqr1yHJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E33A8C2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780745; cv=none; b=ebNyW102pnMsivEieZDlJY1o4vVURPZSPr9Vat40Yw/bgXznIavCGc5Wr2QJ+oGVO2micTnl7kOrq/nyAJc8ZYd9q3tzDD2gana0LRY6xHxZe/pwoYZLvYIZVfyaztM6HtQJDxZ/1FHGKsgNQML3TiSH7rXB/6F+FffU9dttbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780745; c=relaxed/simple;
	bh=HVZwh68HCaCY9TRZaHyxThFyA902g/mHDX/k0Wlf0oE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6+ffUesJIjtY3YsdOrVUboZ1JMRj2HoN0z6y0hNvXdTqzSd8HAdOJMHXfInnLBDG/xULQy75j8uDZ+sZ0GTKlGW9AuciewBRhuCnyMwK4mMFJ/B9F7UW0hZXZYfUEmradw/Icl0spaUvWt8JMfpfgCS1GldQwRetVCz7eepSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mmqr1yHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ACFC433F1;
	Mon, 12 Feb 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780744;
	bh=HVZwh68HCaCY9TRZaHyxThFyA902g/mHDX/k0Wlf0oE=;
	h=From:To:Cc:Subject:Date:From;
	b=Mmqr1yHJZHtYS+8feNyGW8ZKYGmG17UHxs0A/m/wlpxc1tjmryVQIY1k/mZv1ywlv
	 Jw7hVHTFkBFk/Mx3MXWISyO0zDCEFPE6xIMWBty7yGotsONP/3d8dyme2ogcK/1OMi
	 Pwz4weZu8y83iwPgErwGJzC0Jtu4tRnE98cOFo9C9ALEXdTLjsUYp8NQ7oljCdOfVA
	 gv+ObWo6evN8LoOBRJ4kAgXfDYToJxcQs5VPQxj/TH2j60MqQleC/QYwSqd+EEDA4J
	 +0REz3ETqJIkSBldyvPUgezxiV3k/B+e7VayqYKuj6DP7T5u1Znf03grBL3LHAP0AE
	 npzZQ5FyoQA8Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/4] Fix global subprog PTR_TO_CTX arg handling
Date: Mon, 12 Feb 2024 15:32:17 -0800
Message-Id: <20240212233221.2575350-1-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix confusing and incorrect inference of PTR_TO_CTX argument type in BPF
global subprogs. For some program types (iters, tracepoint, any program type
that doesn't have fixed named "canonical" context type) when user uses (in
a correct and valid way) a pointer argument to user-defined anonymous struct
type, verifier will incorrectly assume that it has to be PTR_TO_CTX argument.
While it should be just a PTR_TO_MEM argument with allowed size calculated
from user-provided (even if anonymous) struct.

This did come up in practice and was very confusing to users, so let's prevent
this going forward. We had to do a slight refactoring of
btf_get_prog_ctx_type() to make it easy to support a special s390x KPROBE use
cases. See details in respective patches.

v1->v2:
  - special-case typedef bpf_user_pt_regs_t handling for KPROBE programs,
    fixing s390x after changes in patch #2.

Andrii Nakryiko (4):
  bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
  bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX
    global arg
  bpf: don't infer PTR_TO_CTX for programs with unnamed context type
  selftests/bpf: add anonymous user struct as global subprog arg test

 include/linux/btf.h                           | 17 ++++---
 kernel/bpf/btf.c                              | 45 +++++++++++++------
 kernel/bpf/verifier.c                         |  2 +-
 .../bpf/progs/test_global_func_ctx_args.c     | 19 ++++++++
 .../bpf/progs/verifier_global_subprogs.c      | 29 ++++++++++++
 5 files changed, 88 insertions(+), 24 deletions(-)

-- 
2.39.3


