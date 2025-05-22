Return-Path: <bpf+bounces-58737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34081AC10C9
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F413B7624
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A6629A329;
	Thu, 22 May 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsu+Qr4E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38528299ABC;
	Thu, 22 May 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930228; cv=none; b=OoFWcCBGL9uY01Uu8MebTnlhMwo0TYCv3yiimzxmol93YVkmHS0JBCLzZjvpVEB0eyRq5pznEGCLxCOja7ghluPwVnMK6kTrLW2sEpg3Jjry7ErFRRTyU3MRkCBIlHz1J6sjdeEcFCqNLAwo4FDDord3vYky6tdJvt0UVC4DUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930228; c=relaxed/simple;
	bh=//yqCWhyxufogzeM11hu7dBxsi7i01w6ShrWzTpUBY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3b4nz4LbogmYhDxcmmOiYV5PWvSMXA9weTkTe/d1PB5IrOYdsb03XZ4NHNcOQI+luH8doQtWMaZnJ77hL0/JbOyjIRKpBQB1BHc+VJQaF2SJoyqB9NKW7S5D/RvS41n31GQ7AECHc6DspgADdnKKGS0ENq7IqX5B176u3DWeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsu+Qr4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45455C4CEE4;
	Thu, 22 May 2025 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747930227;
	bh=//yqCWhyxufogzeM11hu7dBxsi7i01w6ShrWzTpUBY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gsu+Qr4EUAYEmRKAdWcMXYA7WTDwWoya9pIQYv30e9k6a7jHH6ouza9NDedA3SiD1
	 VqWIpU4+TqEY0WoqxSi1Cl7NQ9AoX1H0x6IvyYBc9Kxpv0a/T4brF0X2ZqYWMIgIRh
	 6kpvjg3M6HD6jfGFibT4GO4LjAr4w6L3B3g5P8WSaaD6ptZMBgsaQiGHOnrudg3Fx7
	 w9wgYxfPN0w6PLHV5jF/x8KwZ9JOvSGCZdro9/+WChqG32VHBxhP29+CyDdmSTMg9+
	 FP005z9vCHsQJrBDqfNy356pHHHgQ7qiUEheyqLUOcgIdQDUKsN/l2KjWRpSg1+8bP
	 hQ0d/HMgkt8eQ==
Date: Thu, 22 May 2025 19:10:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 0/5] net/mlx5: Convert mlx5 to netdev instance
 locking
Message-ID: <20250522161023.GT7435@unreal>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
 <20250522085132.177d7a16@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522085132.177d7a16@kernel.org>

On Thu, May 22, 2025 at 08:51:32AM -0700, Jakub Kicinski wrote:
> On Wed, 21 May 2025 15:08:57 +0300 Tariq Toukan wrote:
> > This series by Cosmin converts mlx5 to use the recently added netdev
> > instance locking scheme.
> 
> Are you planning to re-submit this as a PR?
> The subject tag and Leon's reviews being present makes me think
> that applying directly is fine, but I wanted to confirm..

Yes, please apply them directly. There are no changes in IPoIB in this
cycle, so it will be safe to merge the code through netdev.

Cosmin added my ROB tags, after internal review, so I didn't want to be silly
and send my Acked-by in addition to already existing tags.

Thanks

