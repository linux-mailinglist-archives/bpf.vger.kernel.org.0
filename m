Return-Path: <bpf+bounces-60710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F438ADB074
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF411886741
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940E285CBC;
	Mon, 16 Jun 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNEYiPqc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9126C3B7;
	Mon, 16 Jun 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077789; cv=none; b=U2+ypWhWw509rkjNlBipQ0uyVOhzZ9NM1RDFA9dracfdHuXEuvU959IqcZbAQTzsBA3FA6vIID4Zr1TkgYaMe33RUJtNvsqR1uVyMNE9O7k20CjkWPXIzYkTg75qaX98EtpSZ1vbGAqI/Ongn5IfN098YJl7QsHBUeJoJNJwm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077789; c=relaxed/simple;
	bh=rT/5O1pFR+fi1TbayQkW7zHw+KVBHF8HPxP4ZI+ohiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSod2wewLaVxUxXv+6NaUiiFRKojoro0cnLk8oheBiHk2l8S5NXfdQPOqAfgVJKOfvYjWRScnE9cSW4AjJ+Ek/6VHrUvQSj2uq8pQ/eznwbeorJEVSPEv+hS47ulKCAUQ4BhefTc0hlr14XY8u/7jqQjD6AIT8dJVmEgBBF1w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNEYiPqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369ECC4CEEA;
	Mon, 16 Jun 2025 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077788;
	bh=rT/5O1pFR+fi1TbayQkW7zHw+KVBHF8HPxP4ZI+ohiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bNEYiPqcCX0Xpwqz42+6CfGJMEtShOH8ujQuf9BG7VBCUsH9vd7Xr1ugSdFJasGwP
	 BLkm8ZN61wW8GOgv2qWLHIHSlCcUUGdoiaDcD2HThCeVSlRBFYHS2g+2dsau49GAy1
	 vwhAGz2VzXx+BzFws1qEVysVByDWNsBanLYJhM2CeLqiQG0VHLHaufnv06sqTpmO0e
	 MxSQ2FRPSMrvtwId+11+ppKOOcWPp9ICnKI2+ryTkEMR7TbvGEkQTk73XG7Dq4bgzW
	 4kZOXyD8s4O/RVV5up9vQkDAH6B72CEPCDXM+Z2zr4NbF/JdR2fULsnbLqCZFVRiVu
	 rMuhGNlAz1R/g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 667051AF7032; Mon, 16 Jun 2025 14:42:54 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
In-Reply-To: <20415ab5-5003-4725-bf1b-560f197465c4@kernel.org>
References: <20250611155615.0c2cf61c@batman.local.home>
 <87bjqtb6c1.fsf@toke.dk> <4af27621-6d81-4316-b57a-b546c8a7ad08@kernel.org>
 <20415ab5-5003-4725-bf1b-560f197465c4@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 16 Jun 2025 14:42:54 +0200
Message-ID: <87v7ovluwh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 12/06/2025 12.54, Jesper Dangaard Brouer wrote:
>>=20
>>=20
>> On 12/06/2025 12.30, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Steven Rostedt <rostedt@goodmis.org> writes:
>>>
>>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>>
>>>> Each TRACE_EVENT() defined can take up around 5K of text and meta data
>>>> regardless if they are used or not. New code is being developed that=20
>>>> will
>>>> warn when a tracepoint is defined but not used.
>>>>
>>>> The trace events xdp_redirect_map and xdp_redirect_map_err are=20
>>>> defined but
>>>> not used, but there's also a comment that states these are kept=20
>>>> around for
>>>> backward compatibility. Which is interesting because since they are not
>>>> used, any old BPF program that expects them to exist will get incorrect
>>>> data (no data) when they use them. It's worse than not working, it's
>>>> silently failing.
>>>>
>>>> Remove them as they will soon cause warnings, or if they really need to
>>>> stick around, then code needs to be added to use them.
>>>>
>>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> I guess that makes sense; I have no objections to getting rid of them.
>>>
>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
>>=20
>> Make sense.
>>=20
>>=20
>> Toke we have to check how XDP-tools handle when these tracepoints=20
>> disappears.
>
> To Toke, notice that userspace tools expect this tracepoint to be
> available will fail as below (for kernel release v6.16):
>
>   $ sudo ./xdp-bench redirect mlx5p1 veth41
>    libbpf: prog 'tp_xdp_redirect_map_err': failed to find kernel BTF=20
> type ID of 'xdp_redirect_map_err': -3
>    libbpf: prog 'tp_xdp_redirect_map_err': failed to prepare load=20
> attributes: -3
>    libbpf: prog 'tp_xdp_redirect_map_err': failed to load: -3
>    libbpf: failed to load object 'xdp_redirect_basic'
>   Failed to attach XDP program: No such process
>
> IMHO this is a userspace problem, that needs to be more flexible and
> adapt to this change.
>
> This was changed in kernel v5.6 (Jan 2020) commit 1d233886dd90 ("xdp:
> Use bulking for non-map XDP_REDIRECT and consolidate code paths").
> So, I'm thinking that xdp-tools could just remove monitoring for these
> tracepoints?

Yeah, let's just get rid of them:
https://github.com/xdp-project/xdp-tools/pull/513

-Toke

