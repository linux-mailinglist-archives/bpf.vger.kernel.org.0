Return-Path: <bpf+bounces-43232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CF9B1864
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7111F23919
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE41D5CF2;
	Sat, 26 Oct 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE4/y/9x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDCB641;
	Sat, 26 Oct 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947819; cv=none; b=p5NrxNRBgQ1AUVsdEPVQiRajYvdsXZ5xNYvu8H9mAeBryyN/2adykiK8kXRzQifAUsIUloZA37z5aYAcdXkhOhPnlBm8kiTo+/ItS4s0hy8/wEeb7wOR0MQg/JF4QYLiI0gn5rvdaI261wEygFC7mYauOq09ZkzK6qqSuu0AXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947819; c=relaxed/simple;
	bh=XPuYmo0zgd43DSQ6TT9jekdqtTwIJ6eJ4YPPUSxLX6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnVHKhIIaXD4meeYhzUMULIgG0XTbRLlfASFMXv8oM3Ty1gq7emytYVFWLM+h46+7kHBEK4+SkQLrgn0+myMNryWUWSigTfeqdeA6UNHWTAig1Vfzsj/qaFm5UvfXgSUL417cRCWikI3a1QTDZSPlPssCecm3tES0Y6Fo9sBIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE4/y/9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13768C4CEC6;
	Sat, 26 Oct 2024 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729947817;
	bh=XPuYmo0zgd43DSQ6TT9jekdqtTwIJ6eJ4YPPUSxLX6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HE4/y/9xJo3SY0e3w9bf+orKhAGA+RAP3UZKJNacRfemypcPRwie0VXLQ+F5xDu0k
	 FTfXM09UDdfDRpmHfVGiHU+iX1ccEAZ1mpHYC6AFYq349wQ0uVP0/5MPtDet3n+nut
	 t+Wwbreh80ijzupPC3KP0CU9bPg7AJUvUQ2Tcs8SVIcuodSIgRuRAiNKbow85sN9QJ
	 6G/H+2oTcROwsvPK9Pl+x6gfjuaYGnVVcN2+7tT6JJzINO9uXM2D04QJZWK9WN51wq
	 4Bw6DQFX2xohwDZ+eR18gNbZIebM+b/YIORJait7Ja8H7pwrv8IiWAZCwI/U2QUEtt
	 4CAHKdsjA0cWA==
Date: Sat, 26 Oct 2024 14:03:31 +0100
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Coco Li <lixiaoyan@google.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH net] Documentation: networking: net_cachelines: Fix
 formatting
Message-ID: <20241026130331.GE1507976@kernel.org>
References: <20241025-fix_netdev_doc-v1-1-e76e3bc227fc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-fix_netdev_doc-v1-1-e76e3bc227fc@linux.ibm.com>

+ Donald

On Fri, Oct 25, 2024 at 05:38:35PM +0200, Gerd Bayer wrote:
> I stumbled over [0] being completely garbled.
> 
> Fix formatting by adding the required rst annotation for a Simple Table
> and remove unnecessary trailing whitespace. While at it, do the same for
> all the documents in the net_cachelines directory.
> 
> I have not checked the contents for correctness or completeness.
> 
> Links: [0] https://www.kernel.org/doc/html/latest/networking/net_cachelines/net_device.html
> Fixes: 14006f1d8fa2 ("Documentations: Analyze heavily used Networking related structs")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Thanks Gerd,

I believe that there is already a patch in net-next that addresses this.

- 54b771e6c675 ("doc: net: Fix .rst rendering of net_cachelines pages")
  https://git.kernel.org/netdev/net-next/c/54b771e6c675

-- 
pw-bot: not-applicable

