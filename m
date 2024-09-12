Return-Path: <bpf+bounces-39720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DF976AB6
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0911C23A60
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9C31B12ED;
	Thu, 12 Sep 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vWDCZLBo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ZcLv+eZ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A71AD24B;
	Thu, 12 Sep 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147994; cv=none; b=r8QbSvE0j5eBmVVMXClfjKe8dHGlWCZzMbjq7b6xNFyhWa/CG6pZS5qE/67e0/JbZ43toSsc6x2IUxCsHrs1T4PZfd2nrQhMNcGHbBdzYHxbOxwqR6FTe+CDo9NEPPXtQufoQyDJEHtnNl5kGUuYSebBMKsSo1iErmHP1wcxl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147994; c=relaxed/simple;
	bh=GV0Fdo2Is2cceJnMIRCU/HwZ4RwMK7CsdKEDfCZ/Zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCs53B0rvrdhaG5Rutyxye1dG7E1W7uHCAILJXz9+qOyjUm8LMjra1EVvYLcRi7Xv4vZLIGz/Vygab2ERcs6Y4e8eHTDpf209D8wB6HwmKvRTm8NccEOScaxqqmtHxxmE0bwPe+l4ukpCaNtRftEXZOMoHojUhd2mw+hgP3oOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vWDCZLBo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ZcLv+eZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Sep 2024 15:33:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726147991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPIj4LbieZJBuxjh5Jx+ca6REHim7dniHBvSpYMnuKA=;
	b=vWDCZLBovROAOg1ErEUQ0T5/r+gkVdAVcGSfDbna/2j1GBBObw6e/fsfBn1CYVWODBFscA
	Wv2SJmcTAGGCNfhopNusJx/imIMuliaeLnk7ChtxyovDY+03AfIMTzpKUHsF07DtodEPOL
	ZbqAKJ3Et/SOUtjxxflZAwOOY2v+2mwkTDQ4P/naqfp634kyI1pjTYGhfS5/Dtxh8cPlCE
	d8FXj9FYnrlmURZTw1+hN0vrrMXhXn4VAYNjeAAMTHZ3G5Wo+sI8is/QXVVSKnoEWhgfVg
	17Vd11PJUReaWEi2i7wHQ0Lk3VzREh+XEfrAFCPe5p3RK4eSnAApORF7X3rDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726147991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPIj4LbieZJBuxjh5Jx+ca6REHim7dniHBvSpYMnuKA=;
	b=5ZcLv+eZXD+PTliTm8osGNBI7yRBpVVrT7++LbbN6PpHzmh6rw4FBYN3dP8UI91vpjEHyy
	viFKS1KAT0NuC3Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912133309.FA7Uul13@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912-hypnotic-messy-leopard-f1d2b0@leitao>

On 2024-09-12 06:17:55 [-0700], Breno Leitao wrote:
> Hello Sabastian,
Hi Breno,

> > This origins in netkit_xmit(). If my memory serves me, then Daniel told
> > me that netkit is not doing any redirect and therefore does not need
> > "this". This must have been during one of the first "designs"/ versions. 
> 
> Right, I've seen several crashes related to this, and in all of them it
> is through netkit_xmit() -> netkit_run() ->  bpf_prog_run()

Looking at this again, NETKIT_REDIRECT invokes skb_do_redirect() which
is accessing the per-CPU variables/ context from the very first day.
So I must have misunderstood something.

> > If you are saying, that this is possible then something must be done.
> > Either assign a context or reject the bpf program.
> 
> If we want to assign a context, do you meant something like the
> following?

Yes, correct. And I think that we do want the context here.
Feel free to add
  Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
if you post.

Sebastian

