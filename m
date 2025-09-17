Return-Path: <bpf+bounces-68656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5438B7EBF1
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A237B7D2E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F1732E75E;
	Wed, 17 Sep 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3BYJEyu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468232E747;
	Wed, 17 Sep 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113689; cv=none; b=EDawOLsV5gseakTEaJNNMB5n01n3YKXvEQ2lCIMVcAHMLjqOxD/rqFSFrKbxUg1EDBdHSUwA0nWdVi5yR/wj79bmBi5x+dStqGRKT3TkeYym1i4drgqO1N/+02PWrV9Omdr4x63JPxA4DF1ZSUUNFjIyge1LJ4Vij6WfT2z3p6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113689; c=relaxed/simple;
	bh=QKyCgcFoodzH/FjHW6Oo6xspEoVjKBY4bFc4QI/M+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcT1//uofUZvtgos10ojkPQ7gEtgeg8Cto3dstwVUukJs96toSb6w6dzzemjQEsnAMQE+sHTUY03NQcrACpAfS9GgK/++CER2ox1yhxoiAnczkCuPUfMafUr/5u+BRomlmklmI8nPjmtKlaASEspHALf3feqHU7lVBqT27UqGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3BYJEyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0F7C4CEF0;
	Wed, 17 Sep 2025 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113689;
	bh=QKyCgcFoodzH/FjHW6Oo6xspEoVjKBY4bFc4QI/M+Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3BYJEyum9F9Q9bMawWXWL3Po3Ae+atpsDwX3Q+FQ75o8JTZ/2kkUo3PqeTZ+1/D+
	 2UkXr1resBwbZJQV25aHZFcI0Ub8i4GeZVlRfq80lde8kBUypbzt6CFgm8/m959PVd
	 q6TufeMBhErGqmhZRTtAS5ZlyRnf9M+9rrx78/OkMTIftqTYBS7VkaBCtdK1yKvuZE
	 wl9tSSREmvXChtnHrPT+8mu0U4nE8x+DDSUeyMXp4hEo6ppYvz5CO1JivPT1FqbAeu
	 ypGY14Snsf+iSzoSFEkRwCNBABSgrYkz55x+Tr6SFLH3K1ssPR7gPF9DWAWLiPVGeg
	 aiM6n8LLloK8g==
Date: Wed, 17 Sep 2025 13:54:43 +0100
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
Subject: Re: [PATCH net-next V2 06/10] net/mlx5e: Prepare for using different
 CQ doorbells
Message-ID: <20250917125443.GG394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-7-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:40PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Completion queues (CQs) in mlx5 use the same global doorbell, which may
> become contended when accessed concurrently from many cores.
> 
> This patch prepares the CQ management code for supporting different
> doorbells per CQ. This will be used in downstream patches to allow
> separate doorbells to be used by channels CQs.
> 
> The main change is moving the 'uar' pointer from struct mlx5_core_cq to
> struct mlx5e_cq, as the uar page to be used is better off stored
> directly there. Other users of mlx5_core_cq also store the UAR to be
> used separately and therefore the pointer being removed is dead weight
> for them. As evidence, in this patch there are two users which set the
> mcq.uar pointer but didn't use it, Software Steering and old Innova CQ
> creation code. Instead, they rang the doorbell directly from another
> pointer.
> 
> The 'uar' pointer added to struct mlx5e_cq remains in a hot cacheline
> (as before), because it may get accessed for each packet.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


