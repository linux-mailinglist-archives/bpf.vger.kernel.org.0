Return-Path: <bpf+bounces-34647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB192FBD4
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E01F22FAD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C66171098;
	Fri, 12 Jul 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgIi1nSK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1416CD12;
	Fri, 12 Jul 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792355; cv=none; b=VvqHcdyUcN+9aKQPoYuCGkB7tKjuY0eMxJk/jZ4nzPeV262qdSP3odN/6g416IhA5m+/xZFFeBYpCy6SuH1tLE2oo0a/9TGiYZu4x4xaMLl9DSTERmljUHkZKgNkTsJO7Xlv7ExnDC0/3ALOxZaUwD+bdTHyPNrxWD/Dqk90vWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792355; c=relaxed/simple;
	bh=sXeKaDUX+3cKwLbpQ8Fwb49NTHmDHoURC2+/nSGgTMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ep07GWqCrd5KUXNNgRRqeohu9cCgc5n+q5hlXoekgsz8MRbZK519yqb/2KDqYzosv66DHBDVNbbV0rSSl7aO/gvAaCZ6FjVvTx3J9Xp1KNrGOp7d92Iiqn9TfaA51JeK+PddemOex3qZQ6y5h55LQ5Xu2n0d519Wp8iYSiu9EEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgIi1nSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A27C32782;
	Fri, 12 Jul 2024 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792354;
	bh=sXeKaDUX+3cKwLbpQ8Fwb49NTHmDHoURC2+/nSGgTMc=;
	h=From:To:Cc:Subject:Date:From;
	b=IgIi1nSKGGnJZKTFQ6RAfsdptj/IKEFoZ4/mI9y8dGLmPXq/1IXgXEVtdGnqlIJzR
	 mYTsLxGlTK386hxC1cMkf54Lng4TqkuRJB8Nf8ZVcwtO6BQqXUqj+2ExAhb0kp/saF
	 Di8RDna/dL9TPzmt1S4GLwoZJ2OYOuks9wd9fn5/ck15MSoeNLZ8eW8nSTixQHH1Uc
	 H1aEcLmQSfOONjmd4LInewE1ADvGpEuQkzGTjLU6mZZThYdU277ooYNlvTZ+rzZUnJ
	 ZGaOgBHpAdFKMHSDrXEOPfxh1s+f9ZK0BYvNCU/lX0Z15SmUqFJqnhE5zIcJmB4Ama
	 VTFcvig+0ZOdg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 0/2] uprobe: Fix uretprobe syscall wiring
Date: Fri, 12 Jul 2024 15:52:26 +0200
Message-ID: <20240712135228.1619332-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
the uretprobe syscall clashed in linux-next tree with xattrat syscalls,
so after discussing with Arnd, changing the syscall number to 467.

I'm also changing the ABI to 'common' which will ease up the global
scripts/syscall.tbl management.

I split the change into syscall_64.tbl and selftest change, but it could
be merged together if needed.

The patches are based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  probes/for-next

thanks,
jirka


---
Jiri Olsa (2):
      uprobe: Change uretprobe syscall scope and number
      selftests/bpf: Change uretprobe syscall number in uprobe_syscall test

 arch/x86/entry/syscalls/syscall_64.tbl                  | 2 +-
 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

