Return-Path: <bpf+bounces-68651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE5B7EC96
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E6D4A3298
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6963306B1E;
	Wed, 17 Sep 2025 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGzDXCYj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51B1A3167;
	Wed, 17 Sep 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113597; cv=none; b=aRH6Q7GnAMj39V9hOhNE9j4PBDskIh+4M0yksOUV5uk3725Y8hycBGaO5CHF6e5wVq6RW1l1DPSOw15YWAY/C45uSdZbC9K3DLv3//GUrRhB8Iga+4BIrRWL3cwWsiADNz6dmNUbfkcVxveKrmwUl7uS9VW+QqzRF0J7c0OBA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113597; c=relaxed/simple;
	bh=pWIyZXhr7eTtOtyEolGLe2l7VyFDBdNLk8L7cAxDYfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkKQAtYVkF9UydR0cahyPDauksKmHXwIXeTJYDNemcvR+ecUBdKVOAYZfXQHoB8ntfwuhSL70ESmA4oKyxBmf5etKxuWrPzfTl4AtImb7qkOFBFZMeeJeITLUzeVkb3HYn0ohOz3LJV5mIEtGUZUr/Oe3Ko1ZN0pkrFTVOsCI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGzDXCYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D427C4CEFB;
	Wed, 17 Sep 2025 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113596;
	bh=pWIyZXhr7eTtOtyEolGLe2l7VyFDBdNLk8L7cAxDYfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGzDXCYjlaDTpgiYTY4BWtduupodByhF+4pIPQGmIrgsp8IvKsOwZ7APdA+dcHbm4
	 ltiJRmqRD9FXvVQLcx4788f4+AFWakP3drKJaB3DoH7U4N//tyqtJkSjI+79jo/uY5
	 FRn+nF9nFM4mHv1X1QMYWrbvJbvlfU3DOC+SFF8cRb3ybkOMq8yzdQnKVHVCmVDECg
	 6zUKoL3p4PgExQIhtkiyb02kcwDw/+eLEK6ouFzz/lbTb5ex5/LTg7RKpJYzDWG4T2
	 l+lDv9majJM2Ie01Diy0n37vF628YhLinDLEBpdxl50fpTClIAa7+0rMKFUuUiirDj
	 sfX0nPxDe8JDQ==
Date: Wed, 17 Sep 2025 13:53:08 +0100
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
Subject: Re: [PATCH net-next V2 01/10] net/mlx5: Fix typo of
 MLX5_EQ_DOORBEL_OFFSET
Message-ID: <20250917125308.GB394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-2-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:35PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Also convert it to a simple define.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


