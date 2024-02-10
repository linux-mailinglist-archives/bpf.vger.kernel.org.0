Return-Path: <bpf+bounces-21675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C885022D
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86BAB24295
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFC4C90;
	Sat, 10 Feb 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/YR1G1J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B53366;
	Sat, 10 Feb 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707532295; cv=none; b=SAXYSpcQrDnT8h3Il5/338AsZZB8owruBm82ainZDu3Ax/OKAXUHpPVJ/6J48vPSZShO50pX78FmNC0u2O6KAqb6nOf1ROMe+3qfMxOZKuEdQ4cLRkECqZZQUD3sXLiuFiclRkAgJXfuHqZS8b2q79sdPwNKvnSV/notPBfc1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707532295; c=relaxed/simple;
	bh=B/lPdAa1QyFMInjxuzXc0hyX6ToSI4+D9MPkWAYQwJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t01m+6w6qlDGzQP9y4uaKX/a/mX49i5oq1/h39dfYLLhupulQMS4DIGuZGg7SRDfkzUJXWtPkRD0uiKniyeAQAQLceB2teLPGzDKHzUBBy1mYZ4t3DmF2h4i64jzikSUPQ0WwcqHG1jPm9PVNgi56jeACe5x7WPOXWn7/RbZ+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/YR1G1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1560CC433C7;
	Sat, 10 Feb 2024 02:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707532294;
	bh=B/lPdAa1QyFMInjxuzXc0hyX6ToSI4+D9MPkWAYQwJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/YR1G1JhQNchuMT85aCDkvw/7jZKmYefBcYPekoAhbBOfX6SnHlrZG7QEpnu0ySp
	 DlJR7K39SIvfFezJPZBHPntZPJ7km0spsMO8ojn/XIa5RkXSFlSF01YKxonfJolth/
	 bEgPbvei5/kGsNu8Mng9ezwSawM8v0p+ku5ykD+1RB+sF5JAe/HUJWbbqVZIyU0Pne
	 z4yaWFOJk+tyNPvMMnsL2uP14+7jHyBdCX6gVGEP4E6WYvNDgR4twFkjpjE8SKXM77
	 555p1xOBzlflcx1v32UHJr4Lt4xgyysM3PV8nRHvw4LYyRHHzefqKx2UnQYlV/qlzA
	 sznvme/24Q9DQ==
Date: Fri, 9 Feb 2024 18:31:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209183133.1cc0a4f5@kernel.org>
In-Reply-To: <20240209155830.448c2215@hermes.local>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
	<20240209131119.6399c91b@hermes.local>
	<20240209134112.4795eb19@kernel.org>
	<20240209155830.448c2215@hermes.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 15:58:30 -0800 Stephen Hemminger wrote:
> > I mean that NL_REQ_ATTR_CHECK() should be more than enough by itself.
> > We have full TC specs in YAML now, we can hack up a script to generate
> > reverse parsing tables for iproute2 even if you don't want to go full
> > YNL.  
> 
> Ok, then will take the err msg across all places using NL_REQ_ATTR_CHECK?

Take _out_ ? That'd be great, yup.

> Would prefer not to add the complexity of reverse parsing tables, that gets ugly fast.

"reverse" is probably to strong. It's just a parse which parses 
the request instead of the response. ethtool CLI does it, too.

