Return-Path: <bpf+bounces-43647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D59B7E40
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571501F225CA
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F41A256B;
	Thu, 31 Oct 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="abALbbYK"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22119DFAB;
	Thu, 31 Oct 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388160; cv=none; b=JSOA3V/SnqGWTTNTD9rWyvvM945AnhvuLN75l+YHdsX8Q0P7sEuPugvaLMjb3qH+l41HqCvFWk1DJlZjARNkJB/ydi+AKNMb6lM1HuOdrNgpmEGp7z5ItadHxiEbGWOBXZz7CZvMAE0DUcO4OHLoUIldXFAwdndN2pIb/GiXgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388160; c=relaxed/simple;
	bh=AxuR2NgKi8pUaicQNUsWIlLcjILib7JICfE/q4l15Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkByuV0KLjxk8RvHkFw7kTuP3EEUiPwy80sD9hdhOdVdV0WsBfj5gymRV2gBREynLK9t/XRsMOHXGZRJUTH10AbrN8d/3WMrVwLslEVkpCFL5zavl/6N3peQvw9vMTwKbWhyoPay0VXHHGaU+OaMVnQV5xH2OMfZKyUOAXWyul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=abALbbYK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730388156;
	bh=AxuR2NgKi8pUaicQNUsWIlLcjILib7JICfE/q4l15Gc=;
	h=From:To:Cc:Subject:Date:From;
	b=abALbbYK4IH0yfjyd0mtS7aZZK0TGOKWM3ZZPXAkd1Kyyw4kwOp85saOcLR4tS9XL
	 F9lRYlCgq84vMqRg6WGV1UtCpw2IELGcsIt4k2j4Opgq5UqOYsROhh9g/7o9+t8pH6
	 htkbiBY1Ft1XmAholzMy/8tRdSgo0Fw+NnkYyVMaw1Ba5x3tc7l4Tp1/QHDQa0IHGs
	 ORgTLal4FHbnoNVPZATl7iAJHmpRGTUjSaJ6RsopYMRICslEbHPskp9kfxNiSrnG2U
	 qTORLhc0tfG7ARnovBvoRAvqmF6YdwRC6UygZINRbGroCQNS2FLRRQHw9vuAPSuMY4
	 JkyLIKG3terHw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSRJ2CcDzYsf;
	Thu, 31 Oct 2024 11:22:36 -0400 (EDT)
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
	Jordan Rife <jrife@google.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 resend 0/4] Faultable syscall tracepoints updates
Date: Thu, 31 Oct 2024 11:20:52 -0400
Message-Id: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
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
Cc: linux-trace-kernel@vger.kernel.org

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

