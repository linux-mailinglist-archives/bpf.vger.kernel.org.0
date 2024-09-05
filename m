Return-Path: <bpf+bounces-38998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25EE96D795
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A51F2360C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92447199FC7;
	Thu,  5 Sep 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuDXz2Pl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E62192D72;
	Thu,  5 Sep 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537090; cv=none; b=ZtYOOzmV5Ns6Zt4xXBAOTqZ5rsNX2C0vzEGN0wDMlokdhMvYUzLAZ603XhswmQMy7RoB/CbLpERb7CwUvGcezZgftNjpcTqX1U0mxCLoANmBbYyxTwZELUBa35hawrnETJ4QbFT7veuUfJXxFaYHl7ut1EN2E5H66AGDFKYvoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537090; c=relaxed/simple;
	bh=rPMJdd1ORGdXYpzb/LiBqkjF3pi4/Gdz1m6XIzAMKa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBP2bDNCk+M0vC/Ir9OC418Z4E4SE7S6KUCLfLEsGZKi4EY7LGvKc+SHTRVOvNuktsmP+rOzBD95UBF3KAWLVyMF/6CtHxSKovPcFqnofcI+2bryXp/Bclm7G5yzzK+CfPlIj/9dIGH4JqOYW6bpERCFC5ImOh70K5oSC9biHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuDXz2Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C9BC4CEC4;
	Thu,  5 Sep 2024 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537089;
	bh=rPMJdd1ORGdXYpzb/LiBqkjF3pi4/Gdz1m6XIzAMKa0=;
	h=From:To:Cc:Subject:Date:From;
	b=DuDXz2PlnVY0ZQc1AfqGzltWghBpUS4W153rc7ruKIJsMIbLw76bTFLT6/UiCIA7R
	 4Hc6w4H2HjDLhl5mv3B6Pi6+zGrgJhJiAAy07v6P+KIeOfs4EojJhpomq2r5lUyyWq
	 i84NVAVAKdz6PFV/UA5usxcW04HvSHyrwEfcvzn6CPt5kh5L03heCONQQ8zbirm7x2
	 /w6vHU86p51Ycf/pi16y0P5x39ourQRDjNV/Zw6zG8yHTytSnJOUUKd5yE4VLaxNhV
	 ekIyabLGY2gkszzjgWu57GtQR7fxeVDe3q9RaL+5TdBM/hmayXd77cabCD/sOlA3Xz
	 nNySQAXiWa7Jw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 0/4] selftests/bpf: Add uprobe multi pid filter test
Date: Thu,  5 Sep 2024 14:51:20 +0300
Message-ID: <20240905115124.1503998-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
sending fix for uprobe multi pid filtering together with tests. The first
version included tests for standard uprobes, but as we still do not have
fix for that, sending just uprobe multi changes.

thanks,
jirka


v2 changes:
  - focused on uprobe multi only, removed perf event uprobe specific parts
  - added fix and test for CLONE_VM process filter


---
Jiri Olsa (4):
      bpf: Fix uprobe multi pid filter check
      selftests/bpf: Add child argument to spawn_child function
      selftests/bpf: Add uprobe multi pid filter test for fork-ed processes
      selftests/bpf: Add uprobe multi pid filter test for clone-ed processes

 kernel/trace/bpf_trace.c                                    |   2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c  | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c |  40 +++++++++++++++++++
 3 files changed, 177 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c

