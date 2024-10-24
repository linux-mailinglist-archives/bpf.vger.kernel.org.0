Return-Path: <bpf+bounces-42981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F149AD8F9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5705B2839EB
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E217D53C;
	Thu, 24 Oct 2024 00:40:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25835223;
	Thu, 24 Oct 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729730407; cv=none; b=Pl7Nu8b1N3FWVWpJdJGDYEdAn4TjLBrXo8TeObaVAoc1cC5vSJmkXLRCdJ7/P35Yg6k/NVIvoysOMOuTHIR9oV8VqPLemXjgjjs6ngna2VXrliWshaPqdLTbGlbJquc3pM2xJwitfcZhMgT2bD2C6+TQy1gEs9q6howjLT5tvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729730407; c=relaxed/simple;
	bh=hBh/HmzAftsUlSaYAyh6s6cXaZRHsOZG7zrH/yOo1xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/JSVUVCw0zud3f6zAIsR5F/Ta9H3S1v4D4k+7lSr8/SyvbmM/f02dH0IRrFFxfBYB3LFeROFPAY+emDKvWZXIFgYGR+IVVvZ8fodZ2PX15NzgUrOWaDYuc5oQ5aSm4ozvdFvHPTmdWkkIgAJMMV1qjPMC9imQoPoYZe09y4LnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DE0C4CEC6;
	Thu, 24 Oct 2024 00:40:05 +0000 (UTC)
Date: Wed, 23 Oct 2024 20:40:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jordan Rife <jrife@google.com>, acme@kernel.org,
 alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
 ast@kernel.org, bpf@vger.kernel.org, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
 mingo@redhat.com, mjeanson@efficios.com, namhyung@kernel.org,
 paulmck@kernel.org, peterz@infradead.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, yhs@fb.com
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
Message-ID: <20241023204001.69aa5573@rorschach.local.home>
In-Reply-To: <f63cc172-72a7-4666-a15f-c53d8562d7d7@efficios.com>
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
	<20241023145640.1499722-1-jrife@google.com>
	<f63cc172-72a7-4666-a15f-c53d8562d7d7@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 11:13:53 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> That question is relevant for ftrace and perf too: are there data
> structures that are reclaimed with call_rcu() after being unregistered
> from syscall tracepoints ?

ftrace doesn't assume RCU for when to synchronize with tracepoints
being unregistered. It uses:

  tracepoint_synchronize_unregister()

-- Steve

