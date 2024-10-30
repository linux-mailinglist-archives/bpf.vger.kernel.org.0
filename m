Return-Path: <bpf+bounces-43611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65709B708C
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4551F282819
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0541E5710;
	Wed, 30 Oct 2024 23:33:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B071CB53B;
	Wed, 30 Oct 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331203; cv=none; b=k99KUkjro97VgDER/k52umCQm6sZ8aqKgbhm42Eo650coSp63haXYVUS6vOIZFGoM77P0o4xM6NB+a6MbXyGdynOGYHxdxCpGPFwa+ykM1LHVWtbUS7gRUOkk20mk7RlGZEARHBkKr4QJHvlcKLKZXNBiYIai9LxBtys853PX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331203; c=relaxed/simple;
	bh=btyfdxubc9Hn+1DXvikeoIFfblIGF4n+0oNtQ2MmOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtfkCgGot665Uf+iqLV7a6JlxyMBj3mTv1n5dERO89w1U2hiq74a4BXOqtn7x9xwKRw+Xwuz/8tkzcG/b8VKQSbUbpsCXfQ2fs9pNel2pd9/6Pc5Kk/jJnW9BvE9yv20vR1yGNPjXTtyZccl2avzc7c9xUvEbXROI/PAhBAJ9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B35C4CECF;
	Wed, 30 Oct 2024 23:33:21 +0000 (UTC)
Date: Wed, 30 Oct 2024 19:33:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexei
 Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E .
 McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim
 <namhyung@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Jordan Rife
 <jrife@google.com>
Subject: Re: [PATCH v5 0/4] Faultable syscall tracepoints updates
Message-ID: <20241030193318.712118cf@rorschach.local.home>
In-Reply-To: <20241030144634.721630-1-mathieu.desnoyers@efficios.com>
References: <20241030144634.721630-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 10:46:30 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This series addresses use-after-free of faultable syscall tracepoints
> reported by test bots using Syzkaller.
> 
> This applies on linux-next 20241022.

Please Cc, linux-trace-kernel@vger.kernel.org so that your patches
appear in patchwork. Otherwise they will not be seen. I can pull them
from my "INBOX patchwork" but that is outside the workflow of the
tracing subsystem.

-- Steve

