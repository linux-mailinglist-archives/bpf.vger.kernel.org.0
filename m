Return-Path: <bpf+bounces-38456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82437965032
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C5E1C23FD5
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBF1BC06E;
	Thu, 29 Aug 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaxk8UGT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C71B81C4;
	Thu, 29 Aug 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960713; cv=none; b=chlzF6V2zYgiFxp82tRmcrE5CNjjRYvhdimu04duWU+yU/xxqA5Vtl/XWdkSxyjo6ZvVFGBvtc7ZARSgUzRLffmLOtQFXwVHnUuUszs+47OFxDa6MAvO0Z/nU2eM6P9YRACbe8Eq6d1cVkv+14UG0Xjx7pV58zPf9Sp7JB5vxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960713; c=relaxed/simple;
	bh=fNXyOL49jkAUQOf2cFndtXdZqKqQJRLcasbXp/nDGv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZsYa8jEGbbVa4QYG4X4FM7FjepbusQRIm+F5lGKdzsJoYiv1qkF3mJHfpIkQ2CXBp4B0lNByuFMbeil4jNU6ykuq0nCPXHHCl5WEFZMtes7vg0zyrnkmoU9/jAJJvn3p6F1L5G9xKxKr2mMqMJLUAU9cW2bO3kRR9mb3r3oa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaxk8UGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A82CC4CEC5;
	Thu, 29 Aug 2024 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960712;
	bh=fNXyOL49jkAUQOf2cFndtXdZqKqQJRLcasbXp/nDGv8=;
	h=From:To:Cc:Subject:Date:From;
	b=uaxk8UGTINmKWRhy3kt6biGc1VXQ2ISgP5muzPKrWBnBwD1P5olMnhQXNGzYAYX8b
	 KV7qOHAv46vFOIMgP6dByReJXfG+cebyLXJZ/U1rHGTiDNJcY4hQ+4uaGzPVXmbPQO
	 sWEy3aXgS9zSw/mse8XNaTjj7Y60Tyb22vF7cPP/1TWFluqgCpWZeH/HnxepGmttDe
	 RG3KrTY1EtQOuNdn9uk7dgpwjPY6p7yQCpqAs4OrZEcEFqx0IlXR5fBnBjV1aS4x9m
	 ctiPCuQZkdBtbv2I3rbIMdPzpnuda0GKClk5z/eln0z+oIkv+zgJgqAyBFhlSEQvW/
	 Gh7laltT3UaLQ==
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
Subject: [PATCH bpf-next 0/2] selftests/bpf: Add uprobe pid filter test
Date: Thu, 29 Aug 2024 21:45:03 +0200
Message-ID: <20240829194505.402807-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
in response to [1] patch, I'm adding bpf selftest that confirms the
change fixes problem for bpf programs trigered by return uprobe created
over perf event.

Oleg pointed out other issues with uprobe_multi pid filter,
I plan to send another patchset for that.

thanks,
jirka


[1] https://lore.kernel.org/linux-trace-kernel/ME0P300MB0416034322B9915ECD3888649D882@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM/
---
Jiri Olsa (2):
      selftests/bpf: Add child argument to spawn_child function
      selftests/bpf: Add uprobe pid filter test for multiple processes

 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c  | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c |  61 ++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_pid_filter.c

