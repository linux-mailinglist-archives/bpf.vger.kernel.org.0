Return-Path: <bpf+bounces-51658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E5AA36EAC
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6246116745F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57731A9B58;
	Sat, 15 Feb 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJDDED3L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EB5103F;
	Sat, 15 Feb 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739628178; cv=none; b=X1ZdtYQec2YNnx7zGOu8disWLfnrU5JeYoSXGcmOBXap9a8U25qH9URLbl/WLPrSwhBUIX2KSa+ARvf/0HDOJnRrmREcAXeoZMFnV7DQuXg61XfSTYPZ8l/FcWb7yXXxXsk8/Peag4SKI60c0ZcB7J7n1FXElBD3h/HEL6Mtc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739628178; c=relaxed/simple;
	bh=vNLrGNHqeVoQIeEwsVb8aUGliW0G4Qp5gERyB4+77Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP7Z22QUku0erdxqWy0UfhkjmCP9bz46boB0zJkALbeEzHn2xjTh2yi2gD76+ShYqeWNn0i8DLEN8EqZJEteNd96Ibq0Br1KiohpVCotkOJi562KRN4g6NNUZyxEfrBca86EYcvknudjUBdC+CLh4s8/dwa3aQPH8ci/3kG1RBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJDDED3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6553C4CEE7;
	Sat, 15 Feb 2025 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739628177;
	bh=vNLrGNHqeVoQIeEwsVb8aUGliW0G4Qp5gERyB4+77Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJDDED3L0pMJkGG1sSsVGiyfkflCEIjsN/+OQENknmdKORiZTKf/MP/xBvqgqQxNa
	 iE5zsm41BbaIwh5p21ZCVUbCnER82jL+z9/nC9NzPinDw2m6DURTEep2p3dUG9zva7
	 Hri/qah13kLoubon11ie7miHcTmeOAk9BAnz3xEBZ3gexsU3YIhUHOGEWNu1EfeTqQ
	 Cd5BbYlqYxsJah3O18Hiby1DNs9cVy2zz6vO1u0wnIsmd9akEPjBCrccmT+gZ1ITFz
	 0UCFFSd5FidELQH+0AzwItctqoB24wUnZXRoyUUzioPw5klMrqucOtLeQWJqHOiwi/
	 GzdtSiVZdYNbQ==
Date: Sat, 15 Feb 2025 14:02:52 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Amit Cohen <amcohen@nvidia.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Network Development <netdev@vger.kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf <bpf@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Message-ID: <20250215140252.GP1615191@kernel.org>
References: <cover.1738665783.git.petrm@nvidia.com>
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
 <BL1PR12MB5922564282DA2C2C5CA671C1CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
 <20250205090958.278ffaff@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205090958.278ffaff@kernel.org>

On Wed, Feb 05, 2025 at 09:09:58AM -0800, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 17:26:43 +0000 Amit Cohen wrote:
> > > > You're right, most of packets should be handled by HW, XDP is
> > > > mainly useful for telemetry.  
> > > 
> > > Why skb path is not enough?  
> > 
> > We get better packet rates using XDP, this can be useful to redirect
> > packets to a server for analysis for example.
> 
> TBH I also feel a little ambivalent about adding advanced software
> features to mlxsw. You have a dummy device off which you hang the NAPIs,
> the page pools, and now the RXQ objects. That already works poorly with
> our APIs. How are you going to handle the XDP side? Program per port, 
> I hope? But the basic fact remains that only fallback traffic goes thru
> the XDP program which is not the normal Linux model, routing is after
> XDP.
> 
> On one hand it'd be great if upstream switch drivers could benefit from
> the advanced features. On the other the HW is clearly not capable of
> delivering in line with how NICs work, so we're signing up for a stream
> of corner cases, bugs and incompatibility. Dunno.

FWIIW, I do think that as this driver is actively maintained by the vendor,
and this is a grey zone, it is reasonable to allow the vendor to decide if
they want the burden of this complexity to gain some performance.

