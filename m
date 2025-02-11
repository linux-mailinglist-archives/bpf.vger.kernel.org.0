Return-Path: <bpf+bounces-51125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14935A3081B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C195C3A6FBD
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0501F4299;
	Tue, 11 Feb 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqQfUHO+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584B1F4264;
	Tue, 11 Feb 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268587; cv=none; b=SoauQn39DrRCGyBnKAE280vmmaDvS8tw5HUpknz/aoJqkDOjjOx3+JZdZI6krjY8X799XbAgr0rbMPknb5excI050BAIfnDBUjL7z7VvC47ZB6OvVGK4PVmWt/ijWhAXoItCZOrufK+w642s5ATT6grCAPRWDgyZ/7q5EymGOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268587; c=relaxed/simple;
	bh=vlK1kYDAhpjzPcfIwGf1Lxx/sTSC0Xl2d3beqDbehpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8eikktUxTmhzzPNLdJ1MtYYj77GTwaCC67znHZgURAiplRYZKh0Yzw6SmDrCZQIWbu0z7Sgjwl6s8ZSLfff7EiQjfsIpTICOmHhxm2RwA6Wc/9O2xhp/gD8a6r0u0pWOLvER6QAX1KVL8uizgFoXKV3g05XI4k+zd71Vqynz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqQfUHO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AD2C4CEDD;
	Tue, 11 Feb 2025 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268587;
	bh=vlK1kYDAhpjzPcfIwGf1Lxx/sTSC0Xl2d3beqDbehpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqQfUHO+ooFm+5w4bq6zRRZFDISyiTyPAQ8yykyVor2I9+5KEn1/5S3dLje93Xpud
	 5LgTmo5ZGytpxnZnyHmCRSbZ3Ok5/ouprHWyXEKJG/TU3XGDnVSTv06L7+yEp+svHV
	 SfD+Xq74PFC7T1qU1SHvM5wl3d9KMkCRJUI6HqflDXMe3BnmrB5Lu9Tbhc3qg0Q3lI
	 0nfoAQYlgGu+tss1xDhz18XEGsqs2yDKpHyzXEMQICx5KIXXcguS2oyI59jiGhkOfo
	 IpRRAdvxRHev+/vsmCNxNGMgn9w0UYY+mGt+DhUJkXKOqhEv+dgFPln1GYfjlk+C0v
	 12bGaSBwEtxzA==
Date: Tue, 11 Feb 2025 10:09:41 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linu Cherian <lcherian@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"larysa.zaremba@intel.com" <larysa.zaremba@intel.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v5 2/6] octeontx2-pf: Add AF_XDP
 non-zero copy support
Message-ID: <20250211100941.GI554665@kernel.org>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-3-sumang@marvell.com>
 <20250210164128.GG554665@kernel.org>
 <SJ0PR18MB521635EA615322287FB56A37DBFD2@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB521635EA615322287FB56A37DBFD2@SJ0PR18MB5216.namprd18.prod.outlook.com>

On Tue, Feb 11, 2025 at 07:07:02AM +0000, Suman Ghosh wrote:
> >Hi Suman,
> >
> >If this is a bug fix then it should be targeted at net, which implies
> >splitting it out of this patch-set.
> >
> >If, on the other hand, it is not a fix then it should not have a Fixes
> >tag.
> >In that case you can cite a commit using this syntax:
> >
> >commit 06059a1a9a4a ("octeontx2-pf: Add XDP support to netdev PF")
> >
> >Unlike a Fixes tag it:
> >* Should be in the body of the patch description,
> >  rather than part of the tags at the bottom of the patch description
> >* May be line wrapped
> >* Can me included in a sentence
> [Suman] Hi Simon,
> This was suggested the Paolo in v3. He suggested this to simplify the merging process but to add the fix tag.

Thanks Suman,

Sorry for missing Paolo's advice on v3 [1].

[1] https://lore.kernel.org/netdev/dddca9a4-9ee3-4da1-b68d-26f208566d5d@redhat.com/

