Return-Path: <bpf+bounces-67612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934EEB46505
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D91CC2EB1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DD2E285B;
	Fri,  5 Sep 2025 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMUFBYxy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7ED2C17A3;
	Fri,  5 Sep 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105866; cv=none; b=lcg6lT4C927tivzSXP7vZmO0MwZSeIsqjTAfrgc0AxBtBrH46vAg+kvyZiM6aloCfy/TYBRqe4K9QMN1hzN3tMkyPHt+ImEI1sZbT4xBWNPD1si9HTDHOqv/V/gxP/Uoj3IRWCrkhheO3y4wM6M/Q2wHIZ1ZXFiWo78l2uR63c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105866; c=relaxed/simple;
	bh=n0FHDW3YG/QaSMYvc6CMm7we6inPdibj+d+gLQ9pWd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oz9e+zHd27BpS67vNtVxncgx+Ums5gf7AB/EMeCCKrRCRWW1uCU5nfxcHzaydXc4BhMmS8KL2CqkP+zIiqxstuIuv7SaKP6I0z2zVvE7OmSR9n1bTbsH7uSCuouJLee8YiIfa91WEuV3vmGDudap84Z+EpaFlgyW0+y7elBGC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMUFBYxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA76C4CEF1;
	Fri,  5 Sep 2025 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105866;
	bh=n0FHDW3YG/QaSMYvc6CMm7we6inPdibj+d+gLQ9pWd8=;
	h=From:To:Cc:Subject:Date:From;
	b=SMUFBYxyDrZsLbh5dKppGgCCn/j2gkhQhcZgAuayS0c4E1cggEKzM7g7lMlQVullR
	 I5gSmjumoy+ZtwK1jEf/Nbccw3Rjurrn2mE0jij6yBPAkBgAWK5batgIIS0rU2bO+S
	 aBLgCzHzKFhq4cnJRSx+1IhopYVRXPQW1jcvUHS5xDGoeURBGeUN4RkvSxvzPEBetr
	 5tqZ+U8M5Bqil1QnPLY4/xmAmExYTQ6XIIYkIflq8D+ayYK5xuHtfhBNnN27Ipo9c+
	 BvBvfOmlZ7V5tkn1zx10Zf5C8MVerTRgQ0Yrx2v3L663CPruUWw3c9IL3RGmQyzmx4
	 C2dFzC9OYPFlw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH perf/core 0/3] uprobes/x86: change error path for uprobe syscall
Date: Fri,  5 Sep 2025 22:57:28 +0200
Message-ID: <20250905205731.1961288-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
as suggested by Andrii [1] it'd be helpful for uprobe syscall
detection to return error value for the !in_uprobe_trampoline
check instead of forcing SIGILL.

This way we could just call uprobe syscall and based on return
value we will find out if the kernel supports it.

Alejandro,
I included the full man page change from [2], because IIUC this
was not applied yet, and as usual I butchered the wording, so I'd
appreciate your review on that.

thanks,
jirka


[1] https://lore.kernel.org/bpf/CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20250720112133.244369-23-jolsa@kernel.org/
---
Jiri Olsa (2):
      uprobes/x86: Return error from uprobe syscall when not called from trampoline
      selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value

 arch/x86/kernel/uprobes.c                               |  2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 34 ++++++----------------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

Jiri Olsa (1):
      man2: Add uprobe syscall page

 man/man2/uprobe.2    |  1 +
 man/man2/uretprobe.2 | 42 +++++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 13 deletions(-)
 create mode 100644 man/man2/uprobe.2

