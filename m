Return-Path: <bpf+bounces-39178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BBB96FDEC
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D171C21162
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518F15957E;
	Fri,  6 Sep 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3bIZrwM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402E13D251;
	Fri,  6 Sep 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661382; cv=none; b=TojlMoer+P0hZmrWv2M1Hp9F7nK+vUDMR/uWZulLyrwpmAy4QEFVTDdul7n/UK2g7xrHz3zTp/7p0nsfxWct0DtOQjn7DnU5UQhPcYB1OGhaDjR1pN/O2UYGlMZal7qjSAhlOkOqzoqgURnfAtKDamdkFWrujN8VHkAdkSzhY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661382; c=relaxed/simple;
	bh=GKaXF1yioOTb9F5s7ndE5NHY1EH9yLQe0g4ySiSwE30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCRqDmobO0M+Q9U50CArydtlfBkS7T8iCAJPMPYWwVRlt9G/BXopgm7XzepFYRu9tMAD9MbD22Kt6n/S3ub67l0hA3BS3LQRj3KIq69IpvrTTgE7CbpV28mF3NAzyrhjrvzszJ2W0LEKs9SI9ZZqachcSiUkzzhSM4u4pjGWLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3bIZrwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E22C4CEC4;
	Fri,  6 Sep 2024 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725661382;
	bh=GKaXF1yioOTb9F5s7ndE5NHY1EH9yLQe0g4ySiSwE30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3bIZrwMKqqIeo9tZrmgmFG1n6C49TknaHmotoG0W/l825gogN2HJIUq2RGsK02YO
	 yzNq7ugIdrhwUbGKs4ncrn332dEfMlNB14OlNPZarFYSsnBQBCTLsRXqoDhafXRYv3
	 m26Ku/AQi+6Le7aiS8nLoceZD6QrbEx8yjM97dB8nN96Ts6/eF20ukCxUfBLYxoPcD
	 KF+M/txfi4qwaCnEF6uVqyzr4PzpuCe965rUFuuGrxNtj28J2a9JSndsui71x6FRIF
	 FmPtANWVnBkgYnwhIcn1Jf0KWOvUnOcsc2S2TsSzO67ldw3GiGo7F8D87HXsTsa7S8
	 jEMZEFzUJNYXg==
Date: Fri, 6 Sep 2024 15:23:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>, jrife@google.com, Alan Maguire
 <alan.maguire@oracle.com>, Dave Marchevsky <davemarchevsky@fb.com>, Daniel
 Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, Cupertino Miranda
 <cupertino.miranda@oracle.com>, Matt Bobrowski <mattbobrowski@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Network Development
 <netdev@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in
 trace_tcp_send_reset
Message-ID: <20240906152300.634e950b@kernel.org>
In-Reply-To: <CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
	<20240905075622.66819-4-lulie@linux.alibaba.com>
	<CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 17:26:42 -0700 Alexei Starovoitov wrote:
> Yes, it's a bit of a whack a mole and eventually we can get rid of it
> with a smarter verifier (likely) or smarter objtool (unlikely).
> Long term we should be able to analyze body of TP_fast_assign
> automatically and conclude whether it's handling NULL for pointer
> arguments or not. bpf verifier can easily do it for bpf code.
> We just need to compile TP_fast_assign() as a tiny bpf snippet.
> This is work in progress.

Can we not wait for that work to conclude, then? AFAIU this whole
patch set is just a minor quality of life improvement for BPF progs
at the expense of carrying questionable changes upstream.
I don't see the urgency.

