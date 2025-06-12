Return-Path: <bpf+bounces-60455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8BAD6DBB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EF83A51E2
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF36239099;
	Thu, 12 Jun 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu8Ia/uB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0E2367BC;
	Thu, 12 Jun 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724230; cv=none; b=h+0E7iHo3RBotLiIBIlGtnuf2SiZVHMyXlHzquRqYt1qUG4Sw9I32EgD7oFav0OxJyw1ftOndUlwJ7xgl8JFbXmGk2sUWrPmdZhvirkZd6JGaDx2B1EETjy5QAsSfCCpFEts6VcohcGA9YyWkfHLbTiPqUfRFo7NNj68pPg76PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724230; c=relaxed/simple;
	bh=3DEc4h66KpM39d9s61Ex2AB7LLJV25GL4TXRcKI5g9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZo12j7ux+Dv2OIVjGdiGF9VWDvjAJHhSuhg3F8Yhu3TYKMeg7fsa5LywFx8J+Al8MgF4jo6qnHSxWGe7KAz5Yl3OHsmjeVeoRRxqtdYadB3RjXSd04SrZKb74P4z/W4iSAZZKQqIbVVCHU0xRqKM7UYaDYp5fD3kWYekzW2bZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu8Ia/uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5BCC4CEEA;
	Thu, 12 Jun 2025 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724230;
	bh=3DEc4h66KpM39d9s61Ex2AB7LLJV25GL4TXRcKI5g9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gu8Ia/uB/zXp9zILhzjNZwhHRUGppAZLKYL0Y9M36mf7Op4uV/G0ILdntfsh1FhQ6
	 yqDj+1mCgeXlcDp8KT3el9cfRrjhWMHc0VRbjmbupczLOCDyoU466UAN+9ogDneodJ
	 Vk6avv6cDdSUkkY74RIVntyr5y02OkqJ5sDsT7MeYgwFolE/U6ZEktL4pa9+1iRI/D
	 wYyi3wqpN/NSRdUOg2tWigjHNmEZ9PD827+GIZOkK5kMftmlUA7u7MPuSjBDI5+aM6
	 /EyqnF74hRUCjTnoH78r6Ko8gt0MgqviR6KjT0dVJSwxTWp9me2+t0AUuEuG5tX3w8
	 FXRLp3RmoclEQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D0DAA1AF6CD7; Thu, 12 Jun 2025 12:30:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
In-Reply-To: <20250611155615.0c2cf61c@batman.local.home>
References: <20250611155615.0c2cf61c@batman.local.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 12 Jun 2025 12:30:06 +0200
Message-ID: <87bjqtb6c1.fsf@toke.dk>
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
> Each TRACE_EVENT() defined can take up around 5K of text and meta data
> regardless if they are used or not. New code is being developed that will
> warn when a tracepoint is defined but not used.
>
> The trace events xdp_redirect_map and xdp_redirect_map_err are defined but
> not used, but there's also a comment that states these are kept around for
> backward compatibility. Which is interesting because since they are not
> used, any old BPF program that expects them to exist will get incorrect
> data (no data) when they use them. It's worse than not working, it's
> silently failing.
>
> Remove them as they will soon cause warnings, or if they really need to
> stick around, then code needs to be added to use them.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I guess that makes sense; I have no objections to getting rid of them.

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

