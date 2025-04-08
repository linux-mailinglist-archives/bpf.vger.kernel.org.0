Return-Path: <bpf+bounces-55464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A83A80F04
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061C67A52E6
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9839ACF;
	Tue,  8 Apr 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oGmqxoT0"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6215F330
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124259; cv=none; b=UyQcbsTggDIArW2l/d2zwT6nN8etGIjmyYqh5t9sqQq/EcGyP3lnyn/V2TiT3tI0WMsJwJB9YZQwsodhGyGhC1jl7WcT7ztmTeIttsWR9o6BAoe2V/kNPCi+vOacP72FfKEIM/I5XlSpolDwJkZNoWjNb5Xd7Strw5FEf+hh0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124259; c=relaxed/simple;
	bh=UdQjo7GX3+JoHxf1FCW1rvspbShM7CTaNouAZV4fgUk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FMJ9pxgvAH+5JXWdidr7JeGIOF2X+5ehSqCFsa0fcp7h4SpQSr4lUKkLuLN8xfbAhhSPW1axeB7L6fT2TSrGx00NZyrSzNRcw/3tcEYmlZA6bkcA+RmEndBl+wN6a9V43HIORxBrLF3syImWzZ6VFuSOGJgADs0m3R/tTXh+8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oGmqxoT0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744124253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VRMkAdXCE8Xz+ZVJqgl2Gets4GXYhybM2zk48uTnfE=;
	b=oGmqxoT07NQyejq3aH5h02F4c2zBmQPIsf6QnKSuYQ23Asn6guo1iwqQpkfDzQYjcGD9mW
	+UY5pS8A9X5kqN2+oG0cZ587M7TLVN3Pd1BgMFu/X3jr31RZwWqPxDwX6RGiW+OA95CqhR
	u6Ah9TZgqERxHcfo3ZkdkpM6jSloR94=
Date: Tue, 08 Apr 2025 14:57:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <46c9a3cd5888df36ec17bcc5bfd57aab687d4273@linux.dev>
TLS-Required: No
Subject: Re: [PATCH RESEND net-next v3 2/2] tcp: add
 LINUX_MIB_PAWS_TW_REJECTED counter
To: "Eric Dumazet" <edumazet@google.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>, "David Ahern" <dsahern@kernel.org>,
 "Steffen Klassert" <steffen.klassert@secunet.com>, "Sabrina Dubroca"
 <sd@queasysnail.net>, "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
 "Antony Antony" <antony.antony@secunet.com>, "Christian Hopps"
 <chopps@labn.net>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iJRyEkfiUWbxhpCuKjEm0J+g7DiEa2JQPBQdqBmLBJq+w@mail.gmail.com>
References: <20250407140001.13886-1-jiayuan.chen@linux.dev>
 <20250407140001.13886-3-jiayuan.chen@linux.dev>
 <CANn89iJRyEkfiUWbxhpCuKjEm0J+g7DiEa2JQPBQdqBmLBJq+w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

April 8, 2025 at 22:18, "Eric Dumazet" <edumazet@google.com> wrote:



>=20
>=20On Mon, Apr 7, 2025 at 4:00 PM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
>=20>=20
>=20> When TCP is in TIME_WAIT state, PAWS verification uses
> >  LINUX_PAWSESTABREJECTED, which is ambiguous and cannot be distinguis=
hed
> >  from other PAWS verification processes.
> >  Moreover, when PAWS occurs in TIME_WAIT, we typically need to pay sp=
ecial
> >  attention to upstream network devices, so we added a new counter, li=
ke the
> >  existing PAWS_OLD_ACK one.
> >=20
>=20
> I really dislike the repetition of "upstream network devices".
> Is it mentioned in some RFC ?

I used this term to refer to devices that are located in the path of the
TCP connection, such as firewalls, NATs, or routers, which can perform
SNAT or DNAT and these network devices use addresses from their own limit=
ed
address pools to masquerade the source address during forwarding, this
can cause PAWS verification to fail more easily.

You are right that this term is not mentioned in RFC but it's commonly us=
ed
in IT infrastructure contexts. Sorry to have caused misunderstandings.

Thanks.
> >=20
>=20> Also we update the doc with previously missing PAWS_OLD_ACK.
> >  usage:
> >=20
>=20>  '''
> >  nstat -az | grep PAWSTimewait
> >  TcpExtPAWSTimewait 1 0.0
> >  '''
> >=20
>=20>  Suggested-by: Eric Dumazet <edumazet@google.com>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>

