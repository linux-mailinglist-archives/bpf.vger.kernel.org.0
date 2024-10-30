Return-Path: <bpf+bounces-43554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FAE9B665C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256DE1C20BF6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405F1F4723;
	Wed, 30 Oct 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BQPz7qxc"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA691F12FB;
	Wed, 30 Oct 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299699; cv=none; b=i2+LSsV9+Ju+cJOwDGGrefXUYBhRJtLrAC9v6jWLnVuB/a2UYDcTtt0iRSlIub99QCTt0oHun1rP+sRW8W/jcsiZituvHg6+SvjvjDaiYmTxSWpRxPh/ZFvVHeLnFlOnKcJ348HojA4ZOCh4TiC4M2LjexfvDCeRbHH3NnJsjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299699; c=relaxed/simple;
	bh=huslmwSU328gHP09/A8miwhklqfMgAXZb3iiHy3RBJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROHa6owB7XxnLo6cpiwlvqZpEnFGpGmtCcU7Si816fE1R6VEhccLLcwPR1F+iVeHuqpftDtBPYl5DC+GyxZXzq56RmU3U7aGyB0fqxgBOnZeHhPsvrZ+Cuvp1Zx9HDvWLi5aSDZ/fAVsHghaX0QHYbM/Pe7My0KroIjh2+ac5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BQPz7qxc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730299695;
	bh=huslmwSU328gHP09/A8miwhklqfMgAXZb3iiHy3RBJg=;
	h=From:To:Cc:Subject:Date:From;
	b=BQPz7qxcq596k0p9YzjVkwdsGSmNohAw5zOwuCylTObeIm+CwYobYIkw1qWcde9/f
	 zd1Y5iSQHqapbeJYTP3O7HC7mhKPDqFlNaVLvMS0Q9o3CLeJ8VvGZfc/D3bHsjEtyn
	 6WJDIEythzBoL7mGCvCjfxEUxA7JL5+DDzaz/OuhznvqfYuatkW3p9/hoR+fsnNZOg
	 Gs/LCAzsME30ptvz+eR8xSuPzdg5S/giZHBfI8mioeIViALVM+jfmkj/Kj/3rRZgTt
	 2iSi7jYNXIlwm0PLZXcOoROHshKdE1j9IZF+R1GWJ8SDiLOGuStzNEaybuY5oEYe8b
	 g/hsmk65uy3GA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xdqk72m21zKd4;
	Wed, 30 Oct 2024 10:48:15 -0400 (EDT)
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
Subject: [PATCH v5 0/4] Faultable syscall tracepoints updates
Date: Wed, 30 Oct 2024 10:46:30 -0400
Message-Id: <20241030144634.721630-1-mathieu.desnoyers@efficios.com>
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
  tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL

 include/linux/tracepoint-defs.h | 10 ++++++--
 include/linux/tracepoint.h      | 44 ++++++++++++++++++++++++++++-----
 include/trace/define_trace.h    |  2 +-
 kernel/tracepoint.c             | 20 ++++++++-------
 4 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.39.5

