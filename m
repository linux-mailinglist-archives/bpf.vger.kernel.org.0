Return-Path: <bpf+bounces-68659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB79B7EF40
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE9018902D5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170F323404;
	Wed, 17 Sep 2025 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTVtCYdl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5E72602;
	Wed, 17 Sep 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113790; cv=none; b=CtQuA5es7y4yMNRe9rf2WJnMNnbjTH3jxX0E92yjkiwUorAZkwmojUQgNwg/XBcrY384UbtWNlRO86nXIkFfQPlPoUpm+X9rTBuF5Xpm7wHtUQbXzVaZVlkSnNqZWA5U78i0E0MDBfEVuSY5sr3KqUIIuFrAKZZZGOwjKZgQ0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113790; c=relaxed/simple;
	bh=k2wqPIFujf/Dp1epMnjgxvJ7N6cO8qkCH5rM8yVfHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzYjLdei4qzvcUVs7uX0zluABqAuN8FwKQdzLvcjGhobGSpCyMmGjRt+5kPCHF5Zr3gRRznpzpVxGDWL5pDSSUxkKjycRtUVUTTeI12azPdKA95Sty34kiei29/fgwpA6yXUJ/uS+hL9gsFSSCBUUI+dlE2YKbx+wJhkFV/NKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTVtCYdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B243FC4CEF0;
	Wed, 17 Sep 2025 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113790;
	bh=k2wqPIFujf/Dp1epMnjgxvJ7N6cO8qkCH5rM8yVfHs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTVtCYdlQF7xM7ybu+e/Cdru0o3PB2TG89J0chxHNDpcr3HFZXYSdTBA7dnTc4ECa
	 vAuGkPhTQClGJKdaaEv2Pyh4oL6TXhc+ERi1ue9tm5uqUWLf/xvy0Nf/UG+jf1JfIp
	 Lpm6TvOtdntWCMgkYHiSz+ncIDhGnVdRuLeyRrrp7bBu+kRribB7kcHZ+c25vzO2hQ
	 X/+BsadUOTy9R3sfs73+oZQ4ybcRs566Yw+Gpz/l/goZfaCmAw9uiy3+WmidGRAcc3
	 6gnwueDoDf1dsUJuKPn0drYyywHtcSAQ+/MuoPZ14g/apr+VH+KDN0sWvql8fU1icP
	 Sx07uZzyFFc4Q==
Date: Wed, 17 Sep 2025 13:56:23 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next V2 09/10] devlink: Add a 'num_doorbells'
 driverinit param
Message-ID: <20250917125623.GJ394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-10-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-10-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:43PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> This parameter can be used by drivers to configure a different number of
> doorbells.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thank you for exposing this via devlink.

Reviewed-by: Simon Horman <horms@kernel.org>


