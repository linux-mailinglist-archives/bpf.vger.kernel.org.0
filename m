Return-Path: <bpf+bounces-55511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D65A820DF
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE00B8A23A9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071325A62D;
	Wed,  9 Apr 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGMIQvFw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53611DE3A5;
	Wed,  9 Apr 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190269; cv=none; b=oHX50oYO8M4PIxpqgUMM1y+0tLKtZQRElbX2hGGD422Ch4MsbEZJ73VmtvQi4Oi/ZZ2BtrnmAajAwSIDCqBVtOfJEea4LZZKiumQNnJi/OGtoClSDd4TjnC35MNMxfUHmXKYo2tguAlSmhMaO78yLqeLAdicfm/k/eyIntskkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190269; c=relaxed/simple;
	bh=hqEQ77fSXiZu3N5SWCg2WjfSPbGTcCLVEwpTTrz/2xg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nM7Fa8BAWenyqhub1rb6te0v0l9UwiXBCJObX/soPADK30AMmLeeT53xY+Tbp8ahmrfV8vWtBScqJ/vugFDmhnBjD4cObYeA+oKBVEdIGl977f5HQSBkzrD1y6ZCNquWk9WIVtkVz7fuRXJ/udaq785y0XZr7zphXACah4DQe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGMIQvFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90096C4CEE3;
	Wed,  9 Apr 2025 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744190269;
	bh=hqEQ77fSXiZu3N5SWCg2WjfSPbGTcCLVEwpTTrz/2xg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iGMIQvFwdJCtmyVMtv1xeIy2DraOwP6Ba/h6zAEN+wsvrAiubvTkQOtfy9s6ipwDk
	 /mC3296UDFwck7Fh+lRo+EvGvnmmX5znY6NWR1ORehE9yuEqwhe86vEHzf1HkLYNm7
	 rAwhHVN5J5IByZFNVCTNz+MUyLgTnRiD77NVtkhZuq9SDpwEeAcooYDaAl3e9VEI+k
	 EHbka3139/bdYlI/mB38AFgsDPkhfHdEFD2znKL+qGxMoNgUR1YvmAGdh8Ba8qbkZQ
	 iLX8iQrdhRjgZT1f7VA/eaclHqrTx2nTNCxoIF3+xjWJOb7e3teMU/ZaQouTXNky4h
	 7OSTDC2m7te3Q==
Message-ID: <1cc54fa0f517f387563263bb90ef1628244778df.camel@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
From: Geliang Tang <geliang@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, Gang Yan
 <gang_yan@foxmail.com>,  Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
Date: Wed, 09 Apr 2025 17:17:43 +0800
In-Reply-To: <dee07a8c-aed2-4125-a4f0-1bd76ca1e4ac@linux.dev>
References: <tmcxv429u9-tmgrokbfbm@nsmail7.0.0--kylin--1>
	 <tencent_EB51CDCA4E189E271032DFEC7E042B752008@qq.com>
	 <dee07a8c-aed2-4125-a4f0-1bd76ca1e4ac@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yonghong,

On Sun, 2024-08-25 at 21:05 -0700, Yonghong Song wrote:
> 
> On 8/25/24 8:29 PM, Gang Yan wrote:
> > Hi Alexei:
> > It's my honor to recieve your reply. The response to your concerns
> > is attached below
> > for your review.
> > On Mon, Aug 26, 2024 at 10:57:12AM +0800, Gang Yan wrote:
> > > On Thu, Aug 22, 2024 at 8:33 AM Jakub Kicinski wrote:
> > > > On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
> > > > > diff --git a/net/socket.c b/net/socket.c
> > > > > index fcbdd5bc47ac..63ce1caf75eb 100644
> > > > > --- a/net/socket.c
> > > > > +++ b/net/socket.c
> > > > > @@ -1695,6 +1695,7 @@ __weak noinline int
> > > > > update_socket_protocol(int family, int type, int protocol)
> > > > > {
> > > > > return protocol;
> > > > > }
> > > > > +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
> > > > IDK if this falls under BPF or directly net, but could you
> > > > explain
> > > > what test will use this? I'd prefer not to add test hooks into
> > > > the
> > > > kernel unless they are exercised by in-tree tests.
> > > This looks unnecessary.
> > > update_socket_protocol is already registered as fmodret.
> > > There is even selftest that excises this feature:
> > > tools/testing/selftests/bpf/progs/mptcpify.c
> > > 
> > > It doesn't need to be part of the error-inject.
> > The 'update_socket_protocol' is a BPF interface designed primarily
> > to
> > fix the socket protocol from TCP protocol to MPTCP protocol without
> > requiring modifications to user-space application codes. However,
> > when attempting to achieve this using the BCC tool in user-space,
> > the BCC tool doesn't support 'fmod_ret'. Therefore, this patch aims
> > to
> > further expand capabilities, enabling the 'kprobe' method can
> > overriding
> > the update_socket_protocol interface.
> 
> Gang Yan, could you explore to add fmod_ret support in bcc? It should
> be
> similar to kfunc/kretfunc support. I am happy to review your patches.

It took us some time to add this support in bcc, and we have recently
completed it in [1]. We would be grateful if you could help review
these patches.

Thanks,
-Geliang

[1]
https://github.com/iovisor/bcc/pull/5274

> 
> Thanks,
> Yonghong
> 
> > 
> > As a Python developer, the BCC tool is a commonly utilized
> > instrument for
> > interacting with the kernel. If the kernel could permit the use of
> > an
> > error-inject method to modify the `update_socket_protocol`, it
> > would significantly
> > benefit the subsequent promotion and development of MPTCP
> > applications.
> > Thank you for considering this enhancement.
> > 
> > Best wishes!
> > Gang Yan
> > 
> > 
> 


