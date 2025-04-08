Return-Path: <bpf+bounces-55466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA05A80FD2
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CA41BA0472
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEF229B21;
	Tue,  8 Apr 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ/+sd2y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4B1D5CF8;
	Tue,  8 Apr 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125573; cv=none; b=W6HSvaU+Qp6T9g7ttYtxQlKtftXpjvzI31xZYZ0yMOfBeva9Z/SAASglqPQKhtMiOTnC563v7BTj/GzdfGubzMjgx6BsQBz1Pp12/aTmluwXpsDFCKFxS1OLAsQ+erPcgtoRbuusInbqj1FzLoOLdjfntGnDWxtYHxFK36JE3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125573; c=relaxed/simple;
	bh=A3EMV0kbtof4IMctmx/H1T9wwrNnVlomYIe5malimOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNKWOrygEpYB0CylS4uMpcdAQdLWUKsW34BU09ppc2+3ps5HqSvDfavme3h67wql9IT07KcKkMktRbNLhRkUBCg1vYwlsw/Pg2G7GH3oWnKeaZ3ZhSNVjUi6KWWC2Lu8PizuxVHengEibgwA4hXwurbnkSkKyikWuurARsRUoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ/+sd2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A572DC4CEE5;
	Tue,  8 Apr 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125572;
	bh=A3EMV0kbtof4IMctmx/H1T9wwrNnVlomYIe5malimOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQ/+sd2yUkOyZCy0TrYo9HA+HX5/sOPiibUymO8pZa8LqrNrGxcmCKYWezEgBfWOe
	 QdnsA5+yx3RTLUvTZ2TNmHN7cvF5Dm/50cNJyGmqpahO1avUISha2FEOJLiAZUnaiB
	 uiIVEkZqP+GXEZaDZ8LBFP4xWJjfpLl2JXeNAnVuEKqrJms8+MHDyQHKilSLalFBHa
	 gVGWauN1ALRp4ImOfELyNthp9g+eRrClvvnGZbojU9DFAfiMXGVVNDNsfUTLEukydv
	 nze27xFQ0GfLx2+J5Vp76Irl2UmHpLI9sH+PvnSGFQ61OOT8be3ftSxPqHnv7hUbej
	 OjgBQQdI35FHw==
Date: Tue, 8 Apr 2025 08:19:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "Eric Dumazet" <edumazet@google.com>, bpf@vger.kernel.org,
 mrpre@163.com, "David S. Miller" <davem@davemloft.net>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>, "David Ahern" <dsahern@kernel.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, "Sabrina Dubroca"
 <sd@queasysnail.net>, "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
 "Antony Antony" <antony.antony@secunet.com>, "Christian Hopps"
 <chopps@labn.net>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v3 2/2] tcp: add
 LINUX_MIB_PAWS_TW_REJECTED counter
Message-ID: <20250408081930.2734169c@kernel.org>
In-Reply-To: <46c9a3cd5888df36ec17bcc5bfd57aab687d4273@linux.dev>
References: <20250407140001.13886-1-jiayuan.chen@linux.dev>
	<20250407140001.13886-3-jiayuan.chen@linux.dev>
	<CANn89iJRyEkfiUWbxhpCuKjEm0J+g7DiEa2JQPBQdqBmLBJq+w@mail.gmail.com>
	<46c9a3cd5888df36ec17bcc5bfd57aab687d4273@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Apr 2025 14:57:29 +0000 Jiayuan Chen wrote:
> > > When TCP is in TIME_WAIT state, PAWS verification uses
> > >  LINUX_PAWSESTABREJECTED, which is ambiguous and cannot be distinguished
> > >  from other PAWS verification processes.
> > >  Moreover, when PAWS occurs in TIME_WAIT, we typically need to pay special
> > >  attention to upstream network devices, so we added a new counter, like the
> > >  existing PAWS_OLD_ACK one.
> > >   
> > 
> > I really dislike the repetition of "upstream network devices".
> > Is it mentioned in some RFC ?  
> 
> I used this term to refer to devices that are located in the path of the
> TCP connection

Could we use some form of: "devices that are located in the path of the
TCP connection" ? Maybe just "devices in the networking path" ?
I hope that will be sufficiently clear in all contexts.
Upstream devices sounds a little like devices which have drivers in
upstream Linux kernel :(

> such as firewalls, NATs, or routers, which can perform
> SNAT or DNAT and these network devices use addresses from their own limited
> address pools to masquerade the source address during forwarding, this
> can cause PAWS verification to fail more easily.
> 
> You are right that this term is not mentioned in RFC but it's commonly used
> in IT infrastructure contexts. Sorry to have caused misunderstandings.
-- 
pw-bot: cr

