Return-Path: <bpf+bounces-39185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F096FEAE
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292991C2247B
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A34C70;
	Sat,  7 Sep 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Z/l1rh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7C1870;
	Sat,  7 Sep 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725668255; cv=none; b=BDaR2JblIsa4sYXhHIjwjbO6FivWM3Qr0Rpyp8xJ6wNsYj4p6RCytcbhuLgYlMsqktc7P2UgtxED0ohnQAmOxqJs4F2lKMRgilfuspUDLG9cAPS2SB/9U9ckGg3by/u9Zs22V8YZVpyVCF+r4SVLq7UR4r8FjsvBvNvEpDXHKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725668255; c=relaxed/simple;
	bh=OWBN2OBgp5rzmby2r/KnPaH9LBqxwptwE64O7LP4KAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbMkhETAxZCGrtR5OUFUEBL2ehngnu/ObONptXdl2DxLBi4SEQJiGMDLOZbyeI7J5oP8X4T7h41ll80inj8kP9Q/D1wdcXfzJBg0IlEv37Gq3i9xG6cT/vX4JWGR96mCU1s8+bWmyF4i5ppsHS4GB+NtaSobLgdm3l003m80pHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7Z/l1rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D807AC4CEC4;
	Sat,  7 Sep 2024 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725668255;
	bh=OWBN2OBgp5rzmby2r/KnPaH9LBqxwptwE64O7LP4KAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7Z/l1rhIjWIyfX4kfpMlnJHkl2kn5u++CPY9eANiIx3i9Q6AjOhs7FhrU+CSK7id
	 hef5tsaW5zKAxDDUXGoj3kEc4qHrKA1O6nShd4uw66tALDrk4maHB5nD2S2mkqFxxh
	 4lJnGUCipUSe8UgPJ/r+4413Rd8tMyEwEi6k2M+W1tL3T8a0SIQE57h2e697sY/iSe
	 ERaUaKxpP5DH0Kqj+cxEdESuafnA1EM9yZ5Wm6W9zNbDqnUOKM1qABtD4hvNYuz7mA
	 uJeaitBKZKNlUv34QVzScGTdl2bcwZLvYpv4I3Qx0TZFSu4lBehkEc4EVB1QQpqhfW
	 TgxV1XL8BvQ5A==
Date: Fri, 6 Sep 2024 17:17:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Philo Lu <lulie@linux.alibaba.com>, bpf
 <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy
 Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Kui-Feng Lee <thinker.li@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>, jrife@google.com, Alan Maguire
 <alan.maguire@oracle.com>, Dave Marchevsky <davemarchevsky@fb.com>, Daniel
 Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, Cupertino Miranda
 <cupertino.miranda@oracle.com>, Matt Bobrowski <mattbobrowski@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Network Development
 <netdev@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/5] tcp: Use skb__nullable in
 trace_tcp_send_reset
Message-ID: <20240906171732.5382bf80@kernel.org>
In-Reply-To: <CAADnVQ+nsUuQ+6rvEq7mYdE0vvqfZ-=hubcoGgUpprHA5P_mHA@mail.gmail.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
	<20240905075622.66819-4-lulie@linux.alibaba.com>
	<CAADnVQL1Z3LGc+7W1+NrffaGp7idefpbnKPQTeHS8xbQme5Paw@mail.gmail.com>
	<20240906152300.634e950b@kernel.org>
	<CAADnVQJWm_CJobz71_FRPTFeVojHLgmYmQA4tVhOg3MDP2V2Dw@mail.gmail.com>
	<20240906155742.0bd4d4e3@kernel.org>
	<CAADnVQ+nsUuQ+6rvEq7mYdE0vvqfZ-=hubcoGgUpprHA5P_mHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 16:22:12 -0700 Alexei Starovoitov wrote:
> > On Fri, 6 Sep 2024 15:41:47 -0700 Alexei Starovoitov wrote:  
> > > The urgency is now because the situation is dire.
> > > The verifier assumes that skb is not null and will remove
> > > if (!skb) check assuming that it's a dead code.  
> >
> > Meaning verifier currently isn't ready for patch 4?
> > Or we can crash 6.11-rc6 by attaching to a trace_tcp_send_reset()
> > and doing
> >         printf("%d\n", skb->len);
> > ?  
> 
> depends on the prog type and how it's attached, but yes :(

I see :( Thought this is just needed for patch 4.
In this case no objections "from networking perspective":

Acked-by: Jakub Kicinski <kuba@kernel.org>

although it feels more like a general tracing question.

