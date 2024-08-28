Return-Path: <bpf+bounces-38279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74DD962A6E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7180E1F2117E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEA11A2C3F;
	Wed, 28 Aug 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G9I/ucdD"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CA1A2C24;
	Wed, 28 Aug 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855872; cv=none; b=MH2v0z5RUcH5jfPEDG3xNylFMUY7eif/YKBJS/MPWZgSymhT+8ldc9peUYpipTK98laaj5JG7J6LqKNvLvHKHiXBkbHJQfgI/26K15kXCtTiNXOFJmagTKGF1Y1alULi0EyiD0P2VFqcnuuOWmm9Qeq1OvjJ2KoYqf/4I9bdjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855872; c=relaxed/simple;
	bh=5WZBkhTqLLTBIxUntgfPtpfXSq+rSI5jc+kEehv3GH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHfVCFltL+wqwlyMi/eTPVJjjdVR7eeq56JqJt4CpWRKNoOfXHep2YgL8l8KfacTUbaxqHYUW40ZkJRma5n7JW/ycRx+25YYYs4Wb9BOyAfj624MU5WGhOP9ApNa9b964Z561/6rAqTfMDl9djyquSWY8lnfJZ2zP6WAfo+IM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=G9I/ucdD; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724855869;
	bh=5WZBkhTqLLTBIxUntgfPtpfXSq+rSI5jc+kEehv3GH4=;
	h=From:To:Cc:Subject:Date:From;
	b=G9I/ucdD+h6aKe64GdncroXMeJ3mUsF2UdqB9Mb0KuLrDz8jRP+YgXaXkNlmU8lK+
	 vxgbDiS2PhINV8kbm6fYMSajE/tqV6Ai3i0rJUfYmNHEcF9MJL+JMV3/i40bqLoxZX
	 n3o04ue87cfmGD2bdPuCDEUIFmNhGoHqnwx1c5eKpg/ji5Iu1wj6FpPvXLKLi1HNyY
	 ZwOzt1TepwZA/K4F5rAHkFa51gGHovtZpho/BNCAbjxR6Fk2iAyZLmAsb0L99oCccs
	 BU+K9HZNZHfRjzBrcPNgf9pbA0pQwQjqe2NN8ZKgkpAtDiiY445G3YFaQ6IAx0pbUG
	 HObXRiZrOBjQg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6T90GxSz1JFP;
	Wed, 28 Aug 2024 10:37:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD()/activate_guard()
Date: Wed, 28 Aug 2024 10:37:17 -0400
Message-Id: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to introduce a "DEFINE_INACTIVE_GUARD()" to actually
define a guard variable, rename all the guard "DEFINE_" prefix to
"DECLARE_".

To cover scenarios where the scope of the guard differs from the scope
of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().

The faultable tracepoints depend on this.

Based on v6.11-rc5.

Thanks,

Mathieu

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-trace-kernel@vger.kernel.org

Mathieu Desnoyers (2):
  cleanup.h guard: Rename DEFINE_ prefix to DECLARE_
  cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard

 crypto/asymmetric_keys/x509_parser.h         |  4 +-
 drivers/cxl/acpi.c                           |  6 +-
 drivers/cxl/core/cdat.c                      |  2 +-
 drivers/cxl/cxl.h                            |  2 +-
 drivers/gpio/gpiolib.h                       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c  |  2 +-
 fs/fuse/virtio_fs.c                          |  2 +-
 fs/namespace.c                               |  2 +-
 fs/pstore/inode.c                            |  4 +-
 include/linux/bitmap.h                       |  2 +-
 include/linux/cleanup.h                      | 79 +++++++++++++-------
 include/linux/cpuhplock.h                    |  2 +-
 include/linux/cpumask.h                      |  2 +-
 include/linux/device.h                       |  6 +-
 include/linux/file.h                         |  6 +-
 include/linux/firmware.h                     |  2 +-
 include/linux/firmware/qcom/qcom_tzmem.h     |  2 +-
 include/linux/gpio/driver.h                  |  4 +-
 include/linux/iio/iio.h                      |  4 +-
 include/linux/interrupt.h                    |  4 +-
 include/linux/irqflags.h                     |  4 +-
 include/linux/local_lock.h                   | 22 +++---
 include/linux/mutex.h                        |  6 +-
 include/linux/netdevice.h                    |  2 +-
 include/linux/nsproxy.h                      |  2 +-
 include/linux/of.h                           |  2 +-
 include/linux/path.h                         |  2 +-
 include/linux/pci.h                          |  4 +-
 include/linux/percpu.h                       |  2 +-
 include/linux/preempt.h                      |  6 +-
 include/linux/property.h                     |  2 +-
 include/linux/rcupdate.h                     |  2 +-
 include/linux/rtnetlink.h                    |  2 +-
 include/linux/rwsem.h                        | 10 +--
 include/linux/sched/task.h                   |  4 +-
 include/linux/slab.h                         |  4 +-
 include/linux/spinlock.h                     | 38 +++++-----
 include/linux/srcu.h                         |  8 +-
 include/sound/pcm.h                          |  6 +-
 kernel/sched/core.c                          |  2 +-
 kernel/sched/sched.h                         | 16 ++--
 kernel/sched/syscalls.c                      |  4 +-
 lib/locking-selftest.c                       | 12 +--
 sound/core/control_led.c                     |  2 +-
 45 files changed, 163 insertions(+), 142 deletions(-)

-- 
2.39.2

