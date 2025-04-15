Return-Path: <bpf+bounces-55959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFBA8A158
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A219119021D5
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7613296D0D;
	Tue, 15 Apr 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLvh2l++"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACB29117F;
	Tue, 15 Apr 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727900; cv=none; b=jPkakJNHitGT47baeQ3Hlr3xB32TZaKckcw6hhQN1D/0cU7nUTYqMoPmCHbdln2rbcbwPMiMZ0zU+Q04eYDp5h27DVFWjLSh9grUtcYPxuadW1E6zMjbgvjKj4YeXPgWWi5XqQy8ikjJNfAfyExacls8HczO2H8EoMd/pBttFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727900; c=relaxed/simple;
	bh=ZpM58jgXe8P92kBPX7QG3YnkqxXt6Jj4oTEvwlNQdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfnh9mxS3kSv4Fk7CTB8G9QvXP02wABsFMrBmb75Ir+aFuSy4nzHj8d9kjZe2Wicty2griAdhtco6J4Ol0I2CDEgS4aglz3b7ewto+vHISx34yCR2UAFeNqxE9G7wbo0t5yQEZBFegYE4Ra7q2YfkcUBGc6uLRDOwL4iuU+HAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLvh2l++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB03C4CEEB;
	Tue, 15 Apr 2025 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744727899;
	bh=ZpM58jgXe8P92kBPX7QG3YnkqxXt6Jj4oTEvwlNQdFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLvh2l++VPeBifQEm59TW5nGAWgkqgrhThC69VZ+qGGNKet/quUjw7ZGXXruuqzlP
	 lkaaH7JvQvawKe+inV2Ll+4rZghPzYQ+tz74EExAZgF7i6MUV+KeuJMTZe5PvRyM8i
	 CWBNkjomCVpwT2vKF5hnS1DnTA4uZGGf4viZAnFz3pa6QWJ2KNXUEMpVJdJOe4CT1c
	 Cb/9JHU8PBQD80eXLDzuoMkSK3rW/avVPCt+3D0VTZH6NgKHa/890EPWkN1clv7DgF
	 kG/fHZIDp/cbDeHEpDPhsYpljSUyJYjmUaKOD/EmhbdT82jZxbXcs824I8I9gqe7IQ
	 YnDC/jbkyH7kQ==
Date: Tue, 15 Apr 2025 07:38:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Stanislav Fomichev <stfomichev@gmail.com>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, bpf
 <bpf@vger.kernel.org>, Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
Message-ID: <20250415073818.06ea327c@kernel.org>
In-Reply-To: <3cee5141-c525-4e83-830e-bf21828aed51@uliege.be>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
	<Z-62MSCyMsqtMW1N@mini-arch>
	<cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
	<CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
	<20250404141955.7Rcvv7nB@linutronix.de>
	<85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
	<CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
	<d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
	<20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
	<3cee5141-c525-4e83-830e-bf21828aed51@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 11:10:01 +0200 Justin Iurman wrote:
> > However, there is my opinion an issue that can occur: between the check on
> > in_softirq() and the call to local_bh_disable(), the task may be scheduled on
> > another CPU. As a result, the check on in_softirq() becomes ineffective because
> > we may end up disabling BH on a CPU that is not the one we just checked (with
> > if (in_softirq()) { ... }).  

The context is not affected by migration. The context is fully defined
by the execution stack.

> Hmm, I think it's correct... good catch. I went for this solution to (i) 
> avoid useless nested BHs disable calls; and (ii) avoid ending up with a 
> spaghetti graph of possible paths with or without BHs disabled (i.e., 
> with single entry points, namely lwtunnel_xmit() and lwtunnel_output()), 
> which otherwise makes it hard to maintain the code IMO.
> 
> So, if we want to follow what Alexei suggests (see his last response), 
> we'd need to disable BHs in both ip_local_out() and ip6_local_out(). 
> These are the common functions which are closest in depth, and so for 
> both lwtunnel_xmit() and lwtunnel_output(). But... at the "cost" of 
> disabling BHs even when it may not be required. Indeed, ip_local_out() 
> and ip6_local_out() both call dst_output(), which one is usually not 
> lwtunnel_output() (and there may not even be a lwtunnel_xmit() to call 
> either).
> 
> The other solution is to always call local_bh_disable() in both 
> lwtunnel_xmit() and lwtunnel_output(), at the cost of disabling BHs when 
> they were already. Which was basically -v1 and received a NACK from Alexei.

I thought he nacked preempt_disable()

