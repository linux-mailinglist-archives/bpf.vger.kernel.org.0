Return-Path: <bpf+bounces-70536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DBBC2A5B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C013C5F53
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013A11F63CD;
	Tue,  7 Oct 2025 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2K1s0vo"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E601487F6
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869172; cv=none; b=r0YfeiHig4RMM/74vKLXCuKQiRtqNkR/RqlvwDq8oXzgcnslbAetYZat+gy23TAUvxvNOrfPQtc6Mmt3g4AD97XBgK+1ZDY/NCNmGAUc3AUpd8LnSQdgRxLmlBKyzhQIPbpUzaPlEXstbmPz2mp7DtorMUMreNdCagPQ9jL/BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869172; c=relaxed/simple;
	bh=MaDAMBNMZ92ElfQt2AXzto3HilYnmemTGRvRi2atjTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSwjNGyzlRQL3t+LJLer3IXZMU+DP2HinF3cQaO/XBfp2vOoK4p7gQ1HiZqSk0idykM9RjVHbeAq+ylAyX4NRVa+dzx9lKKYaQhLWJB8QW4EsPWuxaEU4xP0OX2qDQ4NbpNFX3e2+FPjMdBrEG4OioG9dDyTOdRoWXuEuocDSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V2K1s0vo; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <854e2fce-9d34-4472-b7b8-f66248f3ff01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759869156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSm3WRTYj2I+mXI0pIUfdZvEOC3gbO37eKiogl3mO9I=;
	b=V2K1s0vo0nVK/kO0SiYJwDhq1W8zQz/SvTP2qmZ6UeEl5T9LJRGHQ2L3sy6T871tEuUNXk
	zKDqy+LjeF0aCxAxj5Ph5Lb/Wq4hLsq3l+iD0klwA9ya8UjYhYwQSYXkbw6YPjtrRSVery
	BxPg2gVuE6K1jM83YdVPiP1Lbj4NO2E=
Date: Tue, 7 Oct 2025 13:32:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
To: Jordan Rife <jordan@jrife.io>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <sdf@fomichev.me>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Aditi Ghag
 <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20250909170011.239356-1-jordan@jrife.io>
 <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
 <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr>
 <df4c8852-f6d1-4278-84d8-441aad1f9994@linux.dev>
 <CABi4-ogK1zaupzpRppGEdM0v+4BSJHbrC4Fg=j1zBSGLbkx1rQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CABi4-ogK1zaupzpRppGEdM0v+4BSJHbrC4Fg=j1zBSGLbkx1rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 1:19 PM, Jordan Rife wrote:

> Yeah, this is a bit tricky. I'll have to think a bit more about how
> this would work. The ETIMEOUT thing would work for TCP, but if I'm
> trying to extend this to UDP sockets I think you may need an explicit
> bpf_sock_destroy() call anyway? And if you're making
> bpf_sock_destroy() work in that context then maybe supporting ETIMEOUT
> is redundant?
> 
>> [ Unrelated, but in case it needs a new BPF_SOCK_OPS_*_CB enum. I would mostly
>> freeze any new BPF_SOCK_OPS_*_CB addition and requiring to move the bpf_sock_ops
>> to the struct_ops infrastructure first before adding new ops. ]
> 
> Thanks, I'll look into this. One aspect I'm uncertain about is
> applying this kind of approach to UDP sockets. The BPF_SOCK_OPS_RTO_CB
> callback provides a convenient place to handle this for TCP, but UDP
> doesn't exactly have any timeouts where a similar callback makes
> sense. Instead, you'd need to have something like a callback for UDP
> that executes on every sendmsg call where you run some logic similar
> to the code above. This is less ideal, since you need to do extra work
> on every sendmsg call instead of just when a timeout occurs as with

Yeah, regardless of ETIMEOUT or bpf_sock_destroy(), I think the 
BPF_SOCK_OPS_RTO_CB is better for TCP because of no overhead on the fastpath msg.

> BPF_SOCK_OPS_RTO_CB, but maybe the extra cost here would be
> negligible. Combined, I imagine something like this:
> 
> switch (op) {
> case BPF_SOCK_OPS_RTO_CB:
> case BPF_SOCK_OPS_UDP_SENDMSG_CB:
Beside the fastpath msg overhead, I hate to say this, no new CB enum can be 
added. I was hoping the only exception is the pending udp timestamping work but 
it has been pending for too long, so we have to move on.

The bpf_sock_ops needs to move to struct_ops first. I suspect some of the 
bpf_sock_destroy() hiccup being faced here is that the running context is only 
known at runtime as an enum instead of something static that the verifier can 
help to check the right kfunc to use. Once struct_ops is ready, adding a sendmsg 
ops will be in general useful.

If TCP is solved with the existing BPF_SOCK_OPS_RTO_CB+ETIMEOUT, the remaining 
is UDP and it seems you are interested in connected (iirc?) UDP only. It is why 
I asked how many UDP sockets you may have in production.
> I think using socket callbacks like BPF_SOCK_OPS_RTO_CB would make for
> a more elegant solution and wouldn't require as much bookkeeping,
yeah, if it needs to iterate less, it has to do its own bookkeeping. This patch 
uses the sock_hash but it can also be done in the bpf list/rb/arena also. The 
bpf_sock_destroy_might_sleep() should be strict forward. The 
SEC("syscall")+bpf_sock_destroy_might_sleep could be useful for other use cases 
also.



