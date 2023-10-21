Return-Path: <bpf+bounces-12889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A87D1A55
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E614028276E
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569A802;
	Sat, 21 Oct 2023 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRzDPHby"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A547EA;
	Sat, 21 Oct 2023 01:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC6C433C8;
	Sat, 21 Oct 2023 01:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697852629;
	bh=yRTFPCC2dwBRVws+NAy33Dgp5z84UryexE3MFZt2oD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PRzDPHbyixDF7pJmIt2h/K8P1i1HVGxwnyOczVDfgBQis5rqbiQKVUN7uL5f+GCeM
	 jrC9As7bSj9UPIyltdtW3Pw2u9qqUvIosZ1JonYOzbc86lqnEgToHbRGaHRtH3eF9e
	 7jGt6xyaO0JFH2wPUP/1XTOIx2E+7GCAYNs1CAHfITcKr9MbeE1BKwSigX/7xncjKT
	 32iUTqJFwYCaA2y87XBb+n49zoFMsEcWyVwt+LM/DT82UCUotID6/oevqBgxWKoUI+
	 T7GT+0Iu+GcLpVoJDv7AqY3/vSL5tY/f+BZhjGZYBrTI+Sq6iTdBtewUhDVATS6tek
	 EVPmZleqofOVw==
Date: Fri, 20 Oct 2023 18:43:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, toke@kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <20231020184348.528aa62c@kernel.org>
In-Reply-To: <33467f55-4bbf-4078-af21-d91c6aab82ee@lunn.ch>
References: <20231019204919.4203-1-daniel@iogearbox.net>
	<20231019204919.4203-2-daniel@iogearbox.net>
	<33467f55-4bbf-4078-af21-d91c6aab82ee@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 00:18:53 +0200 Andrew Lunn wrote:
> > +	err = rtnl_configure_link(peer, ifmp, 0, NULL);
> > +	if (err < 0)
> > +		goto err_configure_peer;  
> 
> Seeing code after calling register_netdevice() often means bugs. The
> interface is live, and in use before the function even returns. The
> kernel can try to get an IP address, mount an NFS root etc. This might
> be safe, because you have two linked interfaces here, and the other
> one is not yet registered. Maybe some comment about this would be
> good, or can the rtnl_configure_link() be done earlier?

These are in the newlink callback, rtnl is held throughout.
Which is not to say that corresponding code in veth wasn't 
a source of many bugs :S

