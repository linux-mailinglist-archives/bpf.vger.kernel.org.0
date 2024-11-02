Return-Path: <bpf+bounces-43804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA79B9C1B
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 03:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAB7283429
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33777130E27;
	Sat,  2 Nov 2024 02:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8A2FC52;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513126; cv=none; b=Qx0B6dbhbsHhSsFUnm1ryqAfZOl73bh4K8qa0SXDWu70XVu2O3YyVHDv7iqZxQlaw3PmXbG5YRCWUsmncfPKtdP9qr89i6EiEQM6mr3/F7b0KYX/Jy+WC6g020AsP+eXiEvExshwSj/coqRXp2p2nJzVIDzKyDRUCzGpbolH3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513126; c=relaxed/simple;
	bh=bWNgwIKB+8pzNspOMUrHipZG4r7htz3bV9OLEnL7rck=;
	h=Message-ID:Date:From:To:Cc:Subject; b=tewPjA5kp4wlbZaQrtBDfRHgFIThnHJUQEU7w8pH0ok7aj2ElCHX6PNlsbWIhOkAOBvFhIP4qlExUpi1bbOwYrx5KKpWLn1WQH05d5g8hYRqCmyiQf7O9DQG2nSUUW8WHXASnrvJ8b3rNRgcUspkMw3i/3/cDA8MwxaoKdDE2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E02CC4CECF;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t73X0-00000005Zdm-0BUx;
	Fri, 01 Nov 2024 22:06:26 -0400
Message-ID: <20241102020553.444477901@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 22:05:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [for-next][PATCH 0/3] tracing: Updates for 6.13
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 24507ce81eaf0c34d91f3d1acaa73ee2f796190a


Andrii Nakryiko (3):
      bpf: put bpf_link's program when link is safe to be deallocated
      bpf: decouple BPF link/attach hook and BPF program sleepable semantics
      bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links

----
 include/linux/bpf.h  | 20 ++++++++++++++--
 kernel/bpf/syscall.c | 67 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 20 deletions(-)

