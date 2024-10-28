Return-Path: <bpf+bounces-43322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C129B3A2E
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0235C1C223F1
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FFB1E0B61;
	Mon, 28 Oct 2024 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Qp8BivVh"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF211DFE12;
	Mon, 28 Oct 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142675; cv=none; b=mI6pscrIcIoUPRtO/u2l4+6cH5MskVWoaCSSEbkpu6SaCPu5hT8Fp4Ai3FeEMtyDAlYwEoW5NsMXwD41WHp1DJd4jm1vDDXyub6bp64jSJxB4/jYub6XihmIYNrLhfJHepbFWevb6buJhTgLy0CLFIPHxbziYRkjgDRwU2QyUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142675; c=relaxed/simple;
	bh=azit2JlFxdQSSE1/em8t51Zw3redoFo4Pp+bPR9ZzJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ksag6BL/sDmdwfzmBK/Vg8NTVJTc82K4zDlqeOO/8SfbSWV9JRvFv0qa6vVX506X3YXLv7PZY8oz3wk6Q1VfK3xNfwFEJnrI7K/XJ/Xh/fpqZu2svYvNCCh40NaA5uwd72Dbf9hbEEDvHwHzPvhAeiugkeJJTE9Nx8aR3NItHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Qp8BivVh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142672;
	bh=azit2JlFxdQSSE1/em8t51Zw3redoFo4Pp+bPR9ZzJw=;
	h=From:To:Cc:Subject:Date:From;
	b=Qp8BivVhMhcPBpQ57MxG2m7CaD0/x7fR06QM1j7jStScE6P0t9jNZuukiGkuVEaZh
	 g2qRJUb2IhISjOZAVN3RaNFXIEbrijktGHez0aZzdRBLVaqdbVQ01wHJccSqn2rcnL
	 ykZ/yP29+KSf70FqH95PcW6iczTNwRGsm88J1WWKDRCf9h7zjl3Gfd2kRhMtsZJJTb
	 LZAmqDKCBEbQOrGmfkLFr5+N73k32BjetYQgoMPQV3mcjp/c8WuqcamKuzTPMW9pDL
	 b11qCfD1XZYiUBrTBGCTe97FsSqivACDtnj4/X9D79rN+hQFfyjJS9FCzp5PGZQwDe
	 w2bwaw+ii1d+A==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjfR0wxGzs18;
	Mon, 28 Oct 2024 15:11:11 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>
Subject: [RFC PATCH v4 0/4] Faultable syscall tracepoints updates
Date: Mon, 28 Oct 2024 15:09:23 -0400
Message-Id: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses use-after-free of faultable syscall tracepoints
reported by test bots using Syzkaller.

This applies on linux-next 20241022.

Thanks,

Mathieu

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jordan Rife <jrife@google.com>

Mathieu Desnoyers (4):
  tracing: Introduce tracepoint extended structure
  tracing: Introduce tracepoint_is_faultable()
  tracing: Fix syscall tracepoint use-after-free
  tracing: Add might_fault() check in __DO_TRACE() for syscall

 include/linux/tracepoint-defs.h | 10 +++++--
 include/linux/tracepoint.h      | 49 +++++++++++++++++++++++++++------
 include/trace/define_trace.h    |  2 +-
 kernel/tracepoint.c             | 20 ++++++++------
 4 files changed, 61 insertions(+), 20 deletions(-)

-- 
2.39.5

