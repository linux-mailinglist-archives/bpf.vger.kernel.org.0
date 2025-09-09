Return-Path: <bpf+bounces-67857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD4B4FB70
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864C23BB009
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6102338F43;
	Tue,  9 Sep 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1aCO5RG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211723376A9;
	Tue,  9 Sep 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421551; cv=none; b=sHLaCY8sIVBVNvtMtTE59u/uIgxY0yUe/jx16VdekSShm3Z2b4sDHJq+eYde6801H9ZCPO7eHyjCwizCucue8BsuUpT6zd2NkcWTRbJQIAhXFYLvhNxTyG4sw9J0cjrNczvv9pvZb1M0bbhxJv+VFSXue83zn5mPf10EWWRmq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421551; c=relaxed/simple;
	bh=rbCE8SsMmrEjxrwSW2ckA+InZUSNKEWi/INtyk/HIE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8bRe6zxxQWJyEGQO6eddeGVwzA4gmkbypfzRh58ESmClGI/mo+ewm9aIJRnOhsh+zgeV6JJMoomZvqfYPKiDdOuIWZGIjl80ucAmEBglhc1mV1zETadESJf3XUHccHOGuqarPXxmgcsboEyIA4FHhCTr8hEsppbOm92Xj1gEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1aCO5RG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7F9C4CEF4;
	Tue,  9 Sep 2025 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421550;
	bh=rbCE8SsMmrEjxrwSW2ckA+InZUSNKEWi/INtyk/HIE0=;
	h=From:To:Cc:Subject:Date:From;
	b=e1aCO5RGH2WOMivpapZgoCxCJXa81E1AP/nBBLtvocoCcYbs9ywrG1nVmvBaxa4Nl
	 ii4xO9yPX4RQRroS/kUq0m+YRAvLCX28SVeF4q4wTFFIuUWe33QWJDNiO6OUmU/ACX
	 /k4cxYZTn7i3rrxSOPc4lSFEcTBnYbHQ+fKgIItDMMtrASu5iPjk8j8XV/57OwIdRX
	 0GFxEHCywHHfk/1sJguGsLOOYPpHkmVDSC4mWKSjt+yVqRXmsLk5aN666pGe1S6Q6j
	 I0B5n9M2AbYPsaLoCdtPitQ+2b4tijB035domuSzegPnJEf9BjAuET0DK6/sT/wgyP
	 4eoAVA1Xjv0vQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app registers from uprobe registers
Date: Tue,  9 Sep 2025 14:38:51 +0200
Message-ID: <20250909123857.315599-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently had several requests for tetragon to be able to change
user application function return value or divert its execution through
instruction pointer change.

This patchset adds support for uprobe program to change app's registers
including instruction pointer.

v3 changes:
- deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
- added more tests for denied kprobe attachment

thanks,
jirka


---
Jiri Olsa (6):
      bpf: Allow uprobe program to change context registers
      uprobe: Do not emulate/sstep original instruction when ip is changed
      selftests/bpf: Add uprobe context registers changes test
      selftests/bpf: Add uprobe context ip register change test
      selftests/bpf: Add kprobe write ctx attach test
      selftests/bpf: Add kprobe multi write ctx attach test

 include/linux/bpf.h                                        |   1 +
 kernel/events/core.c                                       |   4 +++
 kernel/events/uprobes.c                                    |   7 +++++
 kernel/trace/bpf_trace.c                                   |   7 +++--
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 ++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++++++++
 tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++++++++++++++++++
 9 files changed, 287 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

