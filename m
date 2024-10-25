Return-Path: <bpf+bounces-43147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CA49AFE36
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC98287483
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E91D3633;
	Fri, 25 Oct 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV8JwWBt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56618D63C;
	Fri, 25 Oct 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848731; cv=none; b=J2IeXqAzEBxLWEVztYTx9Dg1xMFaRdo7Xajg6f/zSKyE3onakq7aJhcKq0ggFRai9487/ONKtJ4XJXUj+CSXxR6FauRwgcDcNdAk8vfJrTJOvdlfOoNC2HvvHU4mpDk3TlviFhpYOe01rY3nEBJCtov+SaE2AKIu8+QYBGM73KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848731; c=relaxed/simple;
	bh=BIGkXe4S27RvYPC1fUaKy/aC3rYZBY42viXN9VJu3k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ8ry9xRuOHlfpSRFiR5ENQkJ620SSf2yB0YYtVF+W5SOUftiXP+Q5LR0Iu3EIH88+B1e1xSwVLCOJx3HMrPN723z2EW2TExtj+05fG/G801byveqzws4NhBvMNvE1JPOMD0f3voNJgT2qJUDHi0i8qW41bUfi27fGnZtrqzf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV8JwWBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFA0C4CEC3;
	Fri, 25 Oct 2024 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848731;
	bh=BIGkXe4S27RvYPC1fUaKy/aC3rYZBY42viXN9VJu3k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV8JwWBtVPrQwCA8t5ertdsX+W6JbbD2/zcPcnezJ3fyIvMY69cztoR3oMYwwnZIO
	 ecVtIuqheHRA6OQrw0zuakqJikN+mNNRxHTmTE6v7hpexx8+CHyOEBRG9Zghqx0BMQ
	 bpI+WUa+tfCmZPkG+IwAM//npOC371FQDZ65DV/G5yVtg5uNX4cBTjAkbWiSmZ1idX
	 HYT1Y1G928bBMRLAGJBcCtSeWKBi0ity/efvXk76TZlN5ebz4UWPu/WfT4z58lNJEM
	 gT7CweBSji2TG1WL6u4Wn3lpDarUQ7lomqyNRlYCP6buFDJcK4wHwPAFfj1F+m5OGv
	 q4lQgJLzvUV0g==
Date: Fri, 25 Oct 2024 10:32:03 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: marvell: use ethtool string helpers
Message-ID: <20241025093203.GL1202098@kernel.org>
References: <20241024195833.176843-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024195833.176843-1-rosenp@gmail.com>

On Thu, Oct 24, 2024 at 12:58:33PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


