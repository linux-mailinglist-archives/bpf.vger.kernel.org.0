Return-Path: <bpf+bounces-39182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9A96FE3F
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69E41F2420F
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1315B0FC;
	Fri,  6 Sep 2024 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eze8qPjw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20D156C5F;
	Fri,  6 Sep 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663465; cv=none; b=CXVDc0sAxTVY8ChGhm6mOLRUN7CtAVCL43wVvaRcqqfLABu7sYvAzf7Lv48+msJync2ALJedr1bOskB9KokBiA9g2sry01rDy911vBA8tsa8uxYAJaT0a65TRu6GpllefRy+kYcVfM4KHKznMVeHAqe6obLh8y/YWSECnr2HR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663465; c=relaxed/simple;
	bh=x2gJ5IUDvpyP1YM2UKkmoW200N0zbYR1iUQWJXBHFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF9lMx9jQakaLKRTgF/gzExP/GzjvZXL+j0GObgkuMbowKl+kBV/QADlL1ApiWXENwG4fDKpTwcsmUicXZTsSHxFGf+oXYZLfJq3nTvBzWX+t/bPP37qQGK+iAJ+3tqdhpJK9vthuLi9YnSvPqTtOxhIm/XcOHMtyTcJkGTCmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eze8qPjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7272DC4CEC8;
	Fri,  6 Sep 2024 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725663464;
	bh=x2gJ5IUDvpyP1YM2UKkmoW200N0zbYR1iUQWJXBHFFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eze8qPjw/jll/6hOiZtjE0KB9HjMFIBRV9ifAt3p6cInnwVgyMNm2tXduB7vNU8AC
	 2Hlw5shArlaAovGFpcw6DnR46hJYaBADYjtNi0Fpjojfyfn6T5wwaFfyMh9rOPiav3
	 RNvxOQaz+Und3D7lircT19lAzyL6KEURCWHdIJnYxA6YVy0Hyxf66xCbyzjMPfGU0l
	 Na279/WM3zX6CJnn8bBcO49As7taD7qff0HD8D2e20MQ3GJ3YcE3lyYBRABscCJVWX
	 3jC7UZt+74HltHrQHMpD5MK739WXM5gfTalCg0HUok1A9muBSY+H6gEI7/HL+CuVF1
	 2ILt68Ylk5QWg==
Date: Fri, 6 Sep 2024 15:57:42 -0700
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
Message-ID: <20240906155742.0bd4d4e3@kernel.org>
In-Reply-To: <CAADnVQJWm_CJobz71_FRPTFeVojHLgmYmQA4tVhOg3MDP2V2Dw@mail.gmail.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
	<20240905075622.66819-4-lulie@linux.alibaba.com>
	<CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
	<20240906152300.634e950b@kernel.org>
	<CAADnVQJWm_CJobz71_FRPTFeVojHLgmYmQA4tVhOg3MDP2V2Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 15:41:47 -0700 Alexei Starovoitov wrote:
> The urgency is now because the situation is dire.
> The verifier assumes that skb is not null and will remove
> if (!skb) check assuming that it's a dead code.

Meaning verifier currently isn't ready for patch 4?
Or we can crash 6.11-rc6 by attaching to a trace_tcp_send_reset()
and doing
	printf("%d\n", skb->len);
?

