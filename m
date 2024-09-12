Return-Path: <bpf+bounces-39724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62886976BE3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A145284386
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AB81B12DE;
	Thu, 12 Sep 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6maEOsC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B82BB09;
	Thu, 12 Sep 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151063; cv=none; b=TGLDev3RPbIAnZmDUFnE3Z6GjdT30/INEbccFooG635peTGP/aL2iE0bV87tUsjo5f6Ju7+QufdWuqH/dbgu6mZj4gf69TSbKol5M/N7EoUUWtcHs14dPlKax9dV5dtSsg+SRAlKlWU3SCJIgpExBZvRdoA9CfehLviu+6RqTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151063; c=relaxed/simple;
	bh=DE8LCwYBBBoP7mkIx3nkN1NwNmY7aG3Ig8Uq+Rcy+4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fq0G11TMvvRCuXx/RY3D+LaiDP0X6GjTLrFt6lhcXbWLT/HsyFymSQB1+HGdfNv8HVe7QoJtD4RI/sy18H4cHvp79WbC9VZHJiiR52YnqycK1cITShZzQK0nq8py9pAiqz979Jnsarjl0uxxCmoZ60Z9zJVizs58YxDv+savxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6maEOsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2850C4CEC5;
	Thu, 12 Sep 2024 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726151062;
	bh=DE8LCwYBBBoP7mkIx3nkN1NwNmY7aG3Ig8Uq+Rcy+4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n6maEOsCTqRa/8uwso9+tRoBQXPEDe4J1bb4dJPGFY8RASg5nusWSjLKq+x2pxyiT
	 4Y6RThrncvt7gdXmcemSJ0jH38x7xazGi72rBFhuM+TRv+1//w+nsSrjAo573Aiqo8
	 NxUbZUyJF0zZIIQzySYJD834V5z57NWr+TBgs0Jq1AKozuiijB2p1zEwauzzRL78DF
	 Aygw6jVx/8Qp2+MuP3WNLOaaOm3oGNdtUtu/CPh9L3CGgqHA1TBIIy32ExSFn2WUVp
	 QnG3/rJ9iUE11n2uf/SHjM4d3K5cn+QEOVAkZTJzx0a04H2etEjOZbhfwURH3l18uQ
	 w1gDRq0XnEGBg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 11A90152C614; Thu, 12 Sep 2024 16:24:20 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Breno Leitao
 <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
 syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
In-Reply-To: <20240912122847.x70_LgN_@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 12 Sep 2024 16:24:20 +0200
Message-ID: <87wmjhar1n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-09-12 05:06:36 [-0700], Breno Leitao wrote:
>> Hello Sebastian, Jakub,
> Hi,
>
>> I've seen some crashes in 6.11-rc7 that seems related to 401cb7dae8130
>> ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.").
>> 
>> Basically bpf_net_context is NULL, and it is being dereferenced by
>> bpf_net_ctx->ri.kern_flags (offset 0x38) in the following code.
>> 
>> 	static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>> 	{
>> 		struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>> 		if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
>> 
>> That said, it means that bpf_net_ctx_get() is returning NULL.
>> 
>> This stack is coming from the bpf function bpf_redirect()
>> 	BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
>> 	{
>> 	      struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>> 
>> 
>> Since I don't think there is XDP involved, I wondering if we need some
>> preotection before calling bpf_redirect()
>
> This origins in netkit_xmit(). If my memory serves me, then Daniel told
> me that netkit is not doing any redirect and therefore does not need
> "this". This must have been during one of the first "designs"/ versions. 
>
> If you are saying, that this is possible then something must be done.
> Either assign a context or reject the bpf program.

Netkit definitely redirects, so it should assign a context object in
netkit_xmit()...

-Toke

