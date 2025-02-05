Return-Path: <bpf+bounces-50546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00823A296FA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6B31884BC4
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CF1DDC36;
	Wed,  5 Feb 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfsMBNo5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A24C76;
	Wed,  5 Feb 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775400; cv=none; b=EybbwPNAtbfJ3bqHsjc+RH9n4Jobp90modmniduEnA7lnH1xxidahREvZGq6vILSIiCQlmTpRgHieyOh/sOJC8fayeAwN/Jo6R9jc+hWmUYfDl78/WaiJE61aejDBo6fRmOyE+WxbJxew+5qgxq6IMB5XBZU0FMxl7GRsM3OWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775400; c=relaxed/simple;
	bh=5b2MkPkMbbj3UTEjR7NeO1U4/9xMA9aB79imAaglNAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJF08f/dRfo5YvyAqucoGgNarureneE9uZhGCMQX4bPPXUAaP9FYmJViSVcl6Odta9toPROe18d3ryXy+0iNAzsmrkkK3p6C6j4EqDiToSIU+JByjOUeURFpnmmrKTfgBWEH/4gy7zVtba7fU46k30SJYEsTmMhrGDosIfIu8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfsMBNo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6551C4CED1;
	Wed,  5 Feb 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738775399;
	bh=5b2MkPkMbbj3UTEjR7NeO1U4/9xMA9aB79imAaglNAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lfsMBNo5hrfuPqTd3FAELItcIVojV0ZTHXMNQLPcvpImVTf9M7BTlQpiR+aUbM95p
	 pC3IlaJ4JtNqUTxV2aF0Pg5e8Y3USgPi+0YJ2v/gYLG5kos5/vmG50ic5CXyDy9o6I
	 jahOGqCGvaA2Gs41RlUqhIdIqz9d4xp2c4VQIRszWQfVvtTz7+M3A3M8p41+VtBb2z
	 jgVFeabYdkDIhEloOiPumtv6mP7f3/o79++4srMEDtYUtkFrx5r6vwDDFgULOHzeuo
	 Douy+8U6efDkSxw/t4OPbbE2OBa5TfuZKwgg27RAv4Kkp7npn7ekgToESs72j7Wp7a
	 KprVhvT38VC4g==
Date: Wed, 5 Feb 2025 09:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amit Cohen <amcohen@nvidia.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Petr Machata
 <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Network Development <netdev@vger.kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, mlxsw
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Message-ID: <20250205090958.278ffaff@kernel.org>
In-Reply-To: <BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <cover.1738665783.git.petrm@nvidia.com>
	<CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
	<BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
	<CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
	<BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 17:26:43 +0000 Amit Cohen wrote:
> > > You're right, most of packets should be handled by HW, XDP is
> > > mainly useful for telemetry.  
> > 
> > Why skb path is not enough?  
> 
> We get better packet rates using XDP, this can be useful to redirect
> packets to a server for analysis for example.

TBH I also feel a little ambivalent about adding advanced software
features to mlxsw. You have a dummy device off which you hang the NAPIs,
the page pools, and now the RXQ objects. That already works poorly with
our APIs. How are you going to handle the XDP side? Program per port, 
I hope? But the basic fact remains that only fallback traffic goes thru
the XDP program which is not the normal Linux model, routing is after
XDP.

On one hand it'd be great if upstream switch drivers could benefit from
the advanced features. On the other the HW is clearly not capable of
delivering in line with how NICs work, so we're signing up for a stream
of corner cases, bugs and incompatibility. Dunno.

