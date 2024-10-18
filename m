Return-Path: <bpf+bounces-42463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDB9A47D0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29581F24897
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F864208213;
	Fri, 18 Oct 2024 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA4QaQe3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5D2071F3;
	Fri, 18 Oct 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282980; cv=none; b=NxzfKAWdoSuQ2nKAyLRvvS2PKFDZmhICsWs9/1vDTsmL2r9B8YToLjN//qA9Aw/OIjqhzjHvSlzqN6kY7OyBjIKvP9bXojBmS5XFyAio1v+bIbdBdQvKaMN6T6AYztG22G8nA41LCi1xgY/jK+kUUb9LuRGfFOCDXlu2DjNOgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282980; c=relaxed/simple;
	bh=O1f98Xv4QRZMli1lDouWqvDmZ/hsStC23qtkN+HEouc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBDCyxN7aZqErQcLw6vgzBgd2XofnLgW6v7TQjxQAkXXzLWvebrmtfcefOAmLlKj1/Mdrd33TgVRIfh6oGnnt/78eInYDTR85urnHVcJDj4RuHgHoxh0kH9DFb/yusbeplBpokd3ub83QTD+O94/7kPkceyrXLx59Ln7hWh8Mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA4QaQe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB32C4CEC5;
	Fri, 18 Oct 2024 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729282979;
	bh=O1f98Xv4QRZMli1lDouWqvDmZ/hsStC23qtkN+HEouc=;
	h=From:To:Cc:Subject:Date:From;
	b=WA4QaQe3zLxPcOUGWRAmUPKZMXZJaPUPuCchzH2VC3gEU1sQ9I8sVwkSZ/403cgEh
	 msMABIPql6VEhAvFNlhQyt958wyW2/geA3AjVQ0Feqn7TK7aTgTQkebPBz4QUVksIq
	 pgOQ5vhCa6reKxpxoW9jbqtdoV35q37nq010cs42sqz4ANKRh/MjkahwpHsK7zqi6+
	 bc2/fTu6oyRggU137BjRxHU5xEVAfisXAIj5cBefntavNPHPLvVRfTj1IS7V6pUuA0
	 qmbimNFyKpEKdb0Sdj9Sc29zvXRiRVLuD8+abv+pHr3Y3oxqLwL2ysFwDZI2zSC2dE
	 UUwNjKdnJOsLQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv8 perf/core 0/2] uprobe: Add session support
Date: Fri, 18 Oct 2024 22:22:50 +0200
Message-ID: <20241018202252.693462-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this patchset is adding support for session uprobe attachment and
using it through bpf link for bpf programs.

The session means that the uprobe consumer is executed on entry
and return of probed function with additional control:
  - entry callback can control execution of the return callback
  - entry and return callbacks can share data/cookie

On more details please see patch #2.

The patchset is based on Peter's perf/core [1].

v8 changes:
  - split and sepatate only the perf/core patches
  - rebased and reposted to proper ppl/lists

thanks,
jirka


[1] git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
---
Jiri Olsa (2):
      uprobe: Add data pointer to consumer handlers
      uprobe: Add support for session consumer

 include/linux/uprobes.h                               |  25 +++++++++++++++--
 kernel/events/uprobes.c                               | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 kernel/trace/bpf_trace.c                              |   6 ++--
 kernel/trace/trace_uprobe.c                           |  12 +++++---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c |   2 +-
 5 files changed, 154 insertions(+), 39 deletions(-)

