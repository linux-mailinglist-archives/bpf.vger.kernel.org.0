Return-Path: <bpf+bounces-60110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78623AD2A6B
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4147E16D90D
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648BB22A7FE;
	Mon,  9 Jun 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMENuWgd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3110207DF7;
	Mon,  9 Jun 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511348; cv=none; b=RAeBZ/dSVuc2hHafk8+QJmyAljMenssy8Y/0stghC1c0et/PaemrYYgWExeCrX1grqbEnWEPlEu6wDRVgzVJ+Yc1s7Bwupicucu2hf9d0hQm1dZUMfOb9pq4ABVQ8ZPnGQjpuUAyIcKG2zpnENcIRY3wTFDHM9EwPE+XG5LYFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511348; c=relaxed/simple;
	bh=2pZxcvn9dwYkFHGMysoejb290t6liiYtHhqJiwoIRTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz+3252wGAaEeuCLcPBXeFw+aYtaCWgx7PfRdCN5eJknaNYkjq6xkV81eTbTx++k08pqeRiBs44o5pfBx+b2/luklGrBot1w30EW+IKlBwlTX1NgHzvIgeHSrSL1GA/iinJ9C1NvZNAujDuIKZlb5vgfltpr3LH84X913WB5ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMENuWgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE114C4CEEB;
	Mon,  9 Jun 2025 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749511348;
	bh=2pZxcvn9dwYkFHGMysoejb290t6liiYtHhqJiwoIRTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMENuWgdVh5N9AGnA4Cay0jv2l4LoCTgQ2WK8s8FqufjyvvLPMcg8qeiQOTcaQo6y
	 MVXoTRrdjjYX4V6lfGBwTUXE89Yp2EgW9bmHMogmwvUNrf6VWBJPyf1LWpTlOptb58
	 jOshZF/xQnZ7d3G+CKejlA2NCV+xxzCwosNMuYqdtoy4ER5i/6v5WVyfSdKmiSgYYi
	 dtbHIGyaoabEOP53ZmDHC61khVerdrVRIoL7GPxTsxmABBlzQAdl6tQwWYJ3mtvX7G
	 NW5go0rXT7cNtXCvU/ei5OcqaAK2HehATJ0ljHmASmnzkF/UhHJ5J+js0AtYOWsQG2
	 ei7HxGNRaOyeA==
Date: Mon, 9 Jun 2025 16:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com,
 leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Simon Horman <horms@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 07/12] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <20250609162226.2da77646@kernel.org>
In-Reply-To: <ga65ehnqozlkoh5hjuujdv5m5yetmena7qpt22evtqgwq7tzdw@c26wfwrc3hkx>
References: <20250609145833.990793-1-mbloch@nvidia.com>
	<20250609145833.990793-8-mbloch@nvidia.com>
	<20250609082152.29244fca@kernel.org>
	<ga65ehnqozlkoh5hjuujdv5m5yetmena7qpt22evtqgwq7tzdw@c26wfwrc3hkx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 15:31:00 +0000 Dragos Tatulea wrote:
> On Mon, Jun 09, 2025 at 08:21:52AM -0700, Jakub Kicinski wrote:
> > On Mon, 9 Jun 2025 17:58:28 +0300 Mark Bloch wrote:  
> > > Expose the stats of the new headers page pool.  
> > 
> > Y'all asked for clarifications on this patch 2 weeks after v2 was
> > posted and then reposted v3 before I could answer. This patch must go.  
> Ack. Sorry about the too short window of response. Patch will be dropped
> in v4.

Thanks! FWIW the rest indeed LGTM.

