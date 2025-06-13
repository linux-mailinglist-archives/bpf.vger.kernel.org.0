Return-Path: <bpf+bounces-60599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831CAD85EB
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD541898BCF
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715ED272807;
	Fri, 13 Jun 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVhmTi0S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AB2571BA;
	Fri, 13 Jun 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804460; cv=none; b=q38QtOqDKcq35ar0VVfd0ZQJGc2tHEupVm07eyZmD9u98sjKztyJ5XKxQfuSO6Dx02fET1c7L91osx74+CduNn/srx0RfuDCBZtUXxvX6aA2xPQ4BslqD3aSBZ53JiP31RjVK+gObNSFdIQvjW/5H33lfNDHvHUjC6bdICJn6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804460; c=relaxed/simple;
	bh=dtmDdNwL/250+5oiAPMHIU8MljAqBQVgAWLaJgUZWHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MG5xMy99DgCMsAyXl7shGV6rdGCy9SQiZeHkFueVIR3+XqjJklEljW+rvoxHDgRDP6f4MZDUu0UHIMROyvmOga27ARO5oreZKedemtmM9ZV5nqro4W35Y7msb0kv+hl5fNdfa/B0BF8uIszYM3NFCq+GD6vpyM2zA7T13/sqhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVhmTi0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18706C4CEEB;
	Fri, 13 Jun 2025 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749804459;
	bh=dtmDdNwL/250+5oiAPMHIU8MljAqBQVgAWLaJgUZWHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HVhmTi0SJYx5tAiGqF0lOhHBUTkG4s5fVSRpyWI4Z81QovR11yyi7XcdZA9aqYX1K
	 6t7dV2powtpuaQ+EVddtUwrA6UPsy8Wexd2SMPS75srmEkJU5Tk5TNBaVT0SCXlYdj
	 rIMplzyR8l3h7yGK32BY1Ka8TF9jaSI69u3lGIVBR3Q31Xy7o2qWT8sEDK7SI+2isZ
	 e7KR6AUaXvSgD4HNjYwWftla+Kf8eEhc1zf85XGRA6N471Ppz8XDlGLHflo8eKjHjO
	 Qi3y5Vjv6W4XyxwYgFIWYi378nQA72t01xLn2JGBqX2lD23X3e/v68KSbyjBnZAk/s
	 pT1pNfwY2AjVA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBC281AF6DD5; Fri, 13 Jun 2025 10:47:25 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2] xdp: tracing: Hide some xdp events under
 CONFIG_BPF_SYSCALL
In-Reply-To: <20250612182023.78397b76@batman.local.home>
References: <20250612182023.78397b76@batman.local.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 13 Jun 2025 10:47:25 +0200
Message-ID: <87wm9grpsy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> writes:

> From: Steven Rostedt <rostedt@goodmis.org>
>
> The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit are
> only called when CONFIG_BPF_SYSCALL is defined.  As each event can take up
> to 5K regardless if they are used or not, it's best not to define them
> when they are not used. Add #ifdef around these events when they are not
> used.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

