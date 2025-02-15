Return-Path: <bpf+bounces-51665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73C1A36F4E
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E311F3B1833
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779311DE2C7;
	Sat, 15 Feb 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V83/Jk4q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832F23A9;
	Sat, 15 Feb 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739635846; cv=none; b=Cf1JJPGkNdZwH5s9fRtEQ9USDHOqti/EPUqoS408cly0amp1JkWHawQSTXaJZrpjCEok5QOqc9xntDOSf41BwJsaGuTn6TequswtgcXNVWalIKEnMaHPIBhqtoBX8ZOn5Kq7kH9OCzrilZDg0151nRXOWkkZSatxnc6whKfNRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739635846; c=relaxed/simple;
	bh=9s+IiJsEUk9aU24rG4a7pQ0sKjOHMDHvd8Goa1eO8Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5F5PGFizcmF9IVidRsx4VrPyTqvydToeFBmHiKuMDqiYYznLa4XEwr0/yeGG/sH3tYLlrSotimFmeYODJN5/uLqXNuMY64tEQAj4TbR90v5jVHp4C0Qfg0SeVj2U/HGgxWHcXbNCunmtiTwvZFK0rivz2FMd6xXk1B42P8DEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V83/Jk4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4B0C4CEDF;
	Sat, 15 Feb 2025 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739635845;
	bh=9s+IiJsEUk9aU24rG4a7pQ0sKjOHMDHvd8Goa1eO8Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V83/Jk4qJm23lCL2iopygF9vkvI/eIYIR5p6ZCe+t2OLD+gMcxXdUgdCKcpxvP/hS
	 eCs41y3gAcJm5KEix4csue3S8s8z/Ly+PMDhvrMH7N+E+hlMhQOpnEIIdPzpkryADP
	 UGictaOpb7sxWwLf942PjV5D4QxRIxtzmXNAGlqpTf2Z8QVTgTXIeu1KuJKsuakqol
	 JeSlcce1czwMpspQAjyDKBkBpCOnbtnnRZYH9wKkADw1AsDBseF5FYh6qhRD/0J0Sf
	 G7x74L44CVjxmBxsXAW/UDFifjPtwRT2QIlbYznMFGEHhI8BUtFfTBngusuG3cxJ6N
	 1DIIxrFMe9sUw==
Date: Sat, 15 Feb 2025 08:10:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Amit Cohen <amcohen@nvidia.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Petr Machata <petrm@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Network
 Development <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, mlxsw
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Message-ID: <20250215081043.063e995a@kernel.org>
In-Reply-To: <20250215140252.GP1615191@kernel.org>
References: <cover.1738665783.git.petrm@nvidia.com>
	<CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
	<BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
	<CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
	<BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
	<20250205090958.278ffaff@kernel.org>
	<20250215140252.GP1615191@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 14:02:52 +0000 Simon Horman wrote:
> > TBH I also feel a little ambivalent about adding advanced software
> > features to mlxsw. You have a dummy device off which you hang the NAPIs,
> > the page pools, and now the RXQ objects. That already works poorly with
> > our APIs. How are you going to handle the XDP side? Program per port, 
> > I hope? But the basic fact remains that only fallback traffic goes thru
> > the XDP program which is not the normal Linux model, routing is after
> > XDP.
> > 
> > On one hand it'd be great if upstream switch drivers could benefit from
> > the advanced features. On the other the HW is clearly not capable of
> > delivering in line with how NICs work, so we're signing up for a stream
> > of corner cases, bugs and incompatibility. Dunno.  
> 
> FWIIW, I do think that as this driver is actively maintained by the vendor,
> and this is a grey zone, it is reasonable to allow the vendor to decide if
> they want the burden of this complexity to gain some performance.

Yes, I left this series in PW for an extra couple of days expecting
a discussion but I suppose my email was taken as a final judgment.

The object separation can be faked more accurately, and analyzed
(in the cover letter) to give us more confidence that the divergence
won't create problems.

The "actively maintained" part is true and very much appreciated, but
it's both something that may easily change, and is hard to objectively
adjudicate. Reporting results to the upstream CI would be much more
objective and hopefully easier to maintain, were the folks supporting
mlxsw to "join a startup", or otherwise disengage.

